Return-Path: <linux-kernel+bounces-210693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD629904786
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD66286EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5490E155A47;
	Tue, 11 Jun 2024 23:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IRbA7Jtb"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEF81553B5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718147454; cv=none; b=cirFaWf12pkv0lYZGRNwu68KXHJUJN0iu0Ztfn5RDjLflMG02P2KB+2w/ZzFas8YlxIhUiIoFgmzBsz7LWtcQVlxPnwViiaIJYpbb0rhgMOMSxQUz+WdjiCtsI30/BpeNKyZKkRh+ejdYa2a4lRBEg6Otx9kqoIfn8r+K0gkOYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718147454; c=relaxed/simple;
	bh=JyJ2yGZOZ9dEZqkXTQ9wgC284YMUsZat6pw03S0Hv+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rH5DEY4ef4pqZHdsArbAb0vUenMSHn7W1joMVec0E7RAdyarYws6qcwe+zT+pcTbMMNW5TbkWohfV/uKtybpajjojBE/6dy0DbpmJ0skAQHC2zeulYkbxr4Eo7yCeNTdQ0U+MJrXNLbQn20QRKBAlWo7D1U41ZnpNzqceUc6EAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IRbA7Jtb; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57c8bd6b655so6757a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718147451; x=1718752251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEJ+k84moPXNg3qvePPmZCf7DoIinx6O+aze4nf9Dnk=;
        b=IRbA7Jtb13bSHtkfTCQY//LyMuip4Y4lxn0imxkgcdTf7lCh62L9rcHzmcRayphD7V
         y4ibFX51cIultK4MwEQrcaeftW5x8oXQQ8Knof4iGbdN3xFeMxky89HZWYAUu5rQmFk/
         2ey/a7aQQLZItaK3v4a2M6LCVYh4fLVf/bEyty45DAkFCAQ0fytlsagc8o1OTq3Y3h/1
         0TbcJBF51FKPEdyqeMiNs4Y6fJ/HTrQq1qK9V6Xo5LeJDDdLfaFLjabYAo/F3pscEYFj
         124mBgZeJb1ye/q4VCO50dJ5ybRgzpFt50yqX+fIYTHRV+6LBJGHBYBcN8Nrnw6l4Kfj
         6xBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718147451; x=1718752251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEJ+k84moPXNg3qvePPmZCf7DoIinx6O+aze4nf9Dnk=;
        b=Bl7DAXqDDQDeK0b31BACqPGHd73m4GK0zEJBcBObphFf5mWOLppK1efJbk8odrlmw2
         tnAwWJnBHQVt9ZwnQhd6iii3TFpytCPJytDm5uox5x9tIMiH/mZEWkNoPlguyq4sVS8F
         IiY3MH11KEq53Tt0HuDmyweqod6DPzululZih+hpi8d2tOuV7DrVKc0WIJGeA88wm1cf
         UHUqaJcHVw0JsOWbj8BT776BkgeYn+ILebQ3AvUJRMVZ0m5R/CcSfa2KvuiwCPs+Yd3v
         IM64CvSUVp1urk+5LowrOTXGxvpEj+0an4Hau6b0gXRGbNxLFGDRY17kc5/41gESpojt
         h4nA==
X-Forwarded-Encrypted: i=1; AJvYcCUeMUfR9mbUZgN99sCgc/3f7BQppmD32cLxyrN6viXmYXSextggzHZiEgI7601Scn1pbNJ6lQaVP/byEdm01NCoBtNcKTR5VAkAm2Fu
X-Gm-Message-State: AOJu0Yw6AXT7TNrox1AEqZcM9UJofoSFrj2ja8TTRAJynSHHjZM4aue3
	BIrpE3wZXOVs2JEf8U16xiQlKonUH4KgAIrZ6Idcwsbe1szfLZKLO8576t7FKI/tm4RirmQytOa
	XV/BF3fl8E0LyOet6vwMl3HJTcGcejNdpFZIp
X-Google-Smtp-Source: AGHT+IH/Mh8iRBNHjzst6XyQIWGXcAOiUHzNx/r+Ic+RHr9DMQ5wuKkn9tcaGXdq3WKF1UXCi388R4lG6KVct282WV0=
X-Received: by 2002:aa7:cd17:0:b0:572:988f:2f38 with SMTP id
 4fb4d7f45d1cf-57ca7fd71e8mr77923a12.6.1718147451162; Tue, 11 Jun 2024
 16:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103164841.2800183-1-schatzberg.dan@gmail.com>
 <htpurelstaqpswf5nkhtttm3vtbvga7qazs2estwzf2srmg65x@banbo2c5ewzw>
 <20240611124807.aedaa473507150bd65e63426@linux-foundation.org> <mpshgxmd3c3gpxltlvquw7zvhq5rvukcws55yo7womgogjxu7q@4p7dr66ctwxh>
In-Reply-To: <mpshgxmd3c3gpxltlvquw7zvhq5rvukcws55yo7womgogjxu7q@4p7dr66ctwxh>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 11 Jun 2024 17:10:12 -0600
Message-ID: <CAOUHufafhx+3QE1CSQpctOm8NjQRuHLT+jyK=mf7c2dgFAn4+g@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add swappiness argument to memory.reclaim
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yue Zhao <findns94@gmail.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, Chris Li <chrisl@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Hugh Dickins <hughd@google.com>, 
	Dan Schatzberg <schatzberg.dan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 4:50=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Jun 11, 2024 at 12:48:07PM GMT, Andrew Morton wrote:
> > On Tue, 11 Jun 2024 12:25:24 -0700 Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
> >
> > > Hi folks,
> > >
> > > This series has been in the mm-unstable for several months. Are there
> > > any remaining concerns here otherwise can we please put this in the
> > > mm-stable branch to be merged in the next Linux release?
> >
> > The review didn't go terribly well so I parked the series awaiting more
> > clarity.  Although on rereading, it seems that Yu Zhao isn't seeing any
> > blocking issues?
> >
>
> Yu, please share if you have any strong concern in merging this series?

I don't remember I had any strong concerns. In fact, I don't remember
what I commented on.

Let me go back to the previous discussion and see why it was stalled.
Will get back to you soon.

