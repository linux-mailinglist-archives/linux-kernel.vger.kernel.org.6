Return-Path: <linux-kernel+bounces-376614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AEB9AB3F3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BB41F22954
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AD51BC070;
	Tue, 22 Oct 2024 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZKFHH9OO"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17611AFB35
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614455; cv=none; b=kF6VJa4bbuZVokMTmATEIKKW2qwqgh+Zw/dlRG6rVk80YuL/RUGTV5Qej0gG+e1DI2nKP1mAOnM4cIQHMoCQPf2SVguJ21+1QwVyLkU7kLnNf6oDJShqp2OGpEnu32/3iytEAL2p7yrDvZeehrhQjtW3zksNm0qQLZnqOi8Id9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614455; c=relaxed/simple;
	bh=YetXmpo1FU87tQbfMy3tmCWhG8Jq9L1beNcjzGpdrnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=di8IXnbMBTyIvKBH3/UBdI1xSwQCEXPi2yBQMQoGmabhEzOXgypy+X26ZE3djd7OrBzI+7amtTZKRUgW8xhox5pG9X5qYZtWNoI5/FHEjmyBbcN0AXjVqCzvHNET4KDataCQJtjm3jSEfy/vOlbfSXoalMR3ye0bHM/vKRVmqUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZKFHH9OO; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e290200a560so5508694276.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729614452; x=1730219252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfcQit/uWdai0Gz1OYnQOrro3YmwaBdxtR4cFYi7qqc=;
        b=ZKFHH9OOHDNsUqpTPg1WWwHvZ129r2jsVgULvDny9/dW3/qppYYdqAfs33pFenZj0W
         bI9wWgoy+NZ3/n4z0mnnWAdvGoC77hYmxLdbbYtp1QContGSh0skZJ+aEK7fOfRdP4uR
         aWtuN3Oc9o4H+ZtosbduzzEs25AhK9RXpRXpXVSWc+GzpvfzZ6pwQp020mYqAZrJ2DYU
         Py6QPNNB4cxX3gsjmL9d5y+xgNAclzT4HDfPiwNtBCgIJp3AMexHftypJzVKiYpR+fBN
         v9P5RFGsg78/CFjnh/fT6lRwr1kbhGaXiKvSAn9djphmjA7CcQntNbTAJPy40iekF45K
         hHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614452; x=1730219252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfcQit/uWdai0Gz1OYnQOrro3YmwaBdxtR4cFYi7qqc=;
        b=Xd61JqfrnP5mbl4SW1pCnW3rNEu4RsTjUSEeZ5dvlc1wqUXsCDFdYJLTjyYauLLLbE
         V+J6GTqIxgFKO6zcDU1Xelpc3c6eaYv+0leFkgp4B+PSRT+ulqz/cQfzQgVAfD1gBYfq
         JKwHvAZk8DWWzAhRavDoIjMxzsH3o6dnNiocHqaP1NMzxsYB4uTrB6nQEIvp2CW+080W
         xVAlkL+TtQshzj/TKlNTAH0VNL576Can0e9QCJlIM0LM5+oTVZsmaJFKuADZBTU5bFgY
         wGZr85MBfLZnL5Dk7hz0zhdvRfya/FoKK7X2/wfrt2GijuKVQ/AAuOX2uX0r6d3m4Swe
         dy4w==
X-Forwarded-Encrypted: i=1; AJvYcCVQNINE+xkfjcorbrCgfEE0x6EkIDNOosDpaSMVTQABDIVtYNYvVBLPUbLB6gRtccWPgXQbPyhJ1HY/WCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxETDaBfafnyTwuR4WD8g+9cLtOC4nlKdRWOR78jrPAYwNHop3K
	3/subPr9ADeRyyTD75Aacg/XSkNBs10s62peYHKv0atFOMRSXlkGcgzDhZ3qXwQnCrGOL80vXj4
	8E0lVRL17ykzN5YtlZittOgfQyGdmb0uNF0s9
X-Google-Smtp-Source: AGHT+IH6teBDteuKX1IfTUU7aOF/brFPLWkJN/2yz4gkMpur17JiIyAYiy3u4lW9412aaSoQIXj6qPi46aPfQzyDatk=
X-Received: by 2002:a05:6902:723:b0:e2b:d610:9d61 with SMTP id
 3f1490d57ef6-e2bd610a475mr10370763276.43.1729614452032; Tue, 22 Oct 2024
 09:27:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018161415.3845146-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhQP7gBa4AV-Hbh4Bq4fRU6toRmjccv52dGoU-s+MqsmfQ@mail.gmail.com> <20241021200636.308f155a72f8a4d1e26f82b8@linux-foundation.org>
In-Reply-To: <20241021200636.308f155a72f8a4d1e26f82b8@linux-foundation.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 22 Oct 2024 12:27:21 -0400
Message-ID: <CAHC9VhRxXAj3ee0z7eMAiDYJ858xOgRyBTwCjvTRfNzDqt6yVw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Split critical region in remap_file_pages() and
 invoke LSMs in between
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, ebpqwerty472123@gmail.com, 
	zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 11:06=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Sat, 19 Oct 2024 11:34:08 -0400 Paul Moore <paul@paul-moore.com> wrote=
:
>
> > >  mm/mmap.c | 69 +++++++++++++++++++++++++++++++++++++++++------------=
--
> > >  1 file changed, 52 insertions(+), 17 deletions(-)
> >
> > Thanks for working on this Roberto, Kirill, and everyone else who had
> > a hand in reviewing and testing.
> >
> > Reviewed-by: Paul Moore <paul@paul-moore.com>
> >
> > Andrew, I see you're pulling this into the MM/hotfixes-unstable
> > branch, do you also plan to send this up to Linus soon/next-week?  If
> > so, great, if not let me know and I can send it up via the LSM tree.
>
> In the normal course of things I'd send it upstream next week ...

That sounds good to me, I just wanted to make sure there was a path
forward to get into Linus' tree.

> ... but I
> can include it in this week's batch if we know that -next testing is
> hurting from it?

I don't believe so, I think this was just a syzbot gotcha.  From what
I understand remap_file_pages(2) isn't used much anymore.

--=20
paul-moore.com

