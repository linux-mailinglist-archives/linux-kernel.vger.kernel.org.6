Return-Path: <linux-kernel+bounces-389872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D66849B7251
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8FF1F25CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368C6823D1;
	Thu, 31 Oct 2024 01:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWn0hqsU"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28EE4A35
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339975; cv=none; b=eIbworRx+buVmA7s1onYL/2W5m/xFCwot/7aQdImy336RqxACS9wbXxGgPe9qghPriBwhD+fmurLSGVE9Ce08RmiVLyoFf46VWewcOoKKBuI/wo9p3BAqRRk+qJADd3cF0aBYTS5y5aIkv3Av19tDq22KuDZtP+FU39YIaAZxQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339975; c=relaxed/simple;
	bh=1YMmtYM4Lz45x2w4MeS1rdbS7c8KgOV0UTXgky2BM0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qetNPYtl15FOZ06M/P32YcST+HU0wjvsjgoEMtrO6ds+Y3mrUcJ0Xys7pRh2wcY1QEtPE+LDgGZJYgeejvUOBiQ91FWM7r5xBzX+aCPBbKOgbflwL5SIu0Pef/MgJHTU7iYr81QFfB5I4xn7FRbPfFSn1WNs9URD0KvT9/yrIl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWn0hqsU; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ede82dbb63so370753a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 18:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730339973; x=1730944773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynFW5xtxd+8iX2/i2+qR8o0VfxX1NPyp2FCK1MSrQ4I=;
        b=UWn0hqsU3uzHOguUE6iMmXrwX0HLGkXaZNA9P9yFBzL0uFJ9cwud4HNWDRR1jvfrS7
         3tM6BXG0+P203vd9raBbk/46a6CmmXLozOS5piv52upcjLChSyk9pO8HYCOhx0+5ZDcx
         NRNY42L0dnpoUwbMsKunrrL2dVrsqxp8fjsNCW6rYRSrFwqFSiXnEUJb0YxRYrRq0PWK
         kuoShlDK+/Uta77SXwP8bqjH6pIuKim72zqKYRL0USiijtMyAUSnNyR2v84sSh3X7Rvb
         mReI2Ud+k4PSqeuzpJQeEd64uCbxdEP/bBGJsnsXLmUNpC8/LngWSin4IJolSmElq6by
         nTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730339973; x=1730944773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynFW5xtxd+8iX2/i2+qR8o0VfxX1NPyp2FCK1MSrQ4I=;
        b=IyG8WjyucS8+ZkDrPmWrid4KDrnOuDwOp2Khene291CXMm81XztURubjylRRnWruUZ
         Qv7FvTHH7MwYnMleXBI21S+bN7NlxwHC6ss6NJQnEF06s52Di+9wG8kDvum0V7wAZvMc
         FEx3UmiSzll3rljwVRbKPgvZicNzKa7aRM/9LYgglUxhLaDTolQzU6HwOgA71DOjCa66
         oiK9A3KJjZMEo63/V/CfNxnuU/S+UtmaP9hMjyfz3Rr7gaPGw8uUpASiiOiYps/5XtD4
         Vin2H3CkR0HNGEcX5xYA6+fvf2v2XWrXdtVmdOUhxsXVNreK9ArU72lsaNnyOFI6giGS
         4sRQ==
X-Forwarded-Encrypted: i=1; AJvYcCViUuL9QXhNX0ySb39QeJzywNBhGuOvNsjJ6/XaHsxbw2ASHIgU1h81HSPgcDvFQrm/EglDyEd2O2bb/Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YySwppKyGbF7Z5EQ99MlvDecibBoET1Tn3NF5IGF3+yMhLkiWTf
	jiWrhU79bOky9amaI9QiqrTJAjR0cwKf6tSw3RrQ1Ou4DN4OUFHtp1Ez8unkSxHA7dX4JiemBXL
	wFACG9H1v2aZM8Aug/tACZQi4fL0=
X-Google-Smtp-Source: AGHT+IEQhTled4Rz6KFrJ2IKyQkoEnKEtdZKw+2W8R45nlgXhdOiQjXP9bHvdIwNwjEKbTltHi0BzL+5It6TevR+0/I=
X-Received: by 2002:a05:6a20:d80b:b0:1d9:9c6:5e7f with SMTP id
 adf61e73a8af0-1d9a83a3e2bmr23611975637.4.1730339973074; Wed, 30 Oct 2024
 18:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010134351.1884580-1-ghanshyam1898@gmail.com>
 <fa5dd074-0045-4f37-894f-861081f4cfdd@oracle.com> <7ad9c139-6627-4401-a7d6-0e488f39c5ad@oracle.com>
In-Reply-To: <7ad9c139-6627-4401-a7d6-0e488f39c5ad@oracle.com>
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Date: Thu, 31 Oct 2024 07:28:56 +0530
Message-ID: <CAG-BmodOM5p=hEs8E0DUAPX5skyGZ3FusjQ7o2W374pLFjFQrQ@mail.gmail.com>
Subject: Re: [PATCH] jfs: fix array-index-out-of-bounds in dtInsertEntry
To: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: osmtendev@gmail.com, ghandatmanas@gmail.com, eadavis@qq.com, 
	jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzbot+5f7f0caf9979e9d09ff8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 3:09=E2=80=AFAM Dave Kleikamp <dave.kleikamp@oracle=
.com> wrote:
>
> On 10/29/24 6:03PM, Dave Kleikamp wrote:
> > On 10/10/24 8:43AM, Ghanshyam Agrawal wrote:
> >> The value of p->header.freelist can be less than zero which
> >> causes an error in dtInsertEntry. Added a check in dtInsert
> >> to address it.
> >>
> >> Reported-by: syzbot+5f7f0caf9979e9d09ff8@syzkaller.appspotmail.com
> >> Closes: https://syzkaller.appspot.com/bug?extid=3D5f7f0caf9979e9d09ff8
> >> Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> >
> > Looks good. I'll apply this one.
>
> Unapplying it. This caused regressions running xfstests. I'll need to
> look into it more carefully.
>
> Shaggy
>
> >
> >> ---
> >>   fs/jfs/jfs_dtree.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
> >> index 5d3127ca68a4..51bb3e14551b 100644
> >> --- a/fs/jfs/jfs_dtree.c
> >> +++ b/fs/jfs/jfs_dtree.c
> >> @@ -834,7 +834,7 @@ int dtInsert(tid_t tid, struct inode *ip,
> >>        * the full page.
> >>        */
> >>       DT_GETSEARCH(ip, btstack->top, bn, mp, p, index);
> >> -    if (p->header.freelist =3D=3D 0)
> >> +    if (p->header.freelist <=3D 0)
> >>           return -EINVAL;
> >>       /*
>

Hello Dave,

Thank you for reviewing and testing my patch. Let me go through the
xfstests results, find the issue and send a v2 for this patch.

Thanks & Regards,
Ghanshyam Agrawal

