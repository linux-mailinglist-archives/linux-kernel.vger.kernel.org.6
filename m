Return-Path: <linux-kernel+bounces-214341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9E0908303
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 06:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3EA1F2399C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 04:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF40E146D60;
	Fri, 14 Jun 2024 04:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBU3qLBW"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5436E146582;
	Fri, 14 Jun 2024 04:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718340010; cv=none; b=SN6IRXXQDbn2Miih+Sqr2/f7cD8MGpY7RQppTMnm8tT6kNDjuRf1K9peWWCrxVonvru1wsX1TmG1MFcGcq0srpcCaA5yjp+2Ys5u7uem9CoMBMX3yiMJMiKLeBppSwaCwhrGhKYADVIojltVLeErS6YBIAiPDiijoGOg+6ykcI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718340010; c=relaxed/simple;
	bh=Cj5KzMMadXsRnndd+TlVK0BUb+fjbSscqj3uM4ytUuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rueTXhA5c1Dost4p6RTi8HRtGag4G9gDo2SNTp6iAuMqVbGsavyPvE5ho+57NxVB0Wnp2+Cv0BzSKd9rxrDF+4jpfdwA5kkhq1gk8sycFfrMlkc5n141tIgGjiAEk1oWU4RFd5dnMYUimlgp97ht4Ml4QXPzIM4oAJZ41AYMCG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBU3qLBW; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dfac121b6a6so1406996276.0;
        Thu, 13 Jun 2024 21:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718340008; x=1718944808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbtquG4p0hVvqKFk1U/Le3nDHhfbk+WM+GokVxGfK54=;
        b=HBU3qLBWlZqRg9Nnhj8P6lwfiVE9T2AHErZAmSPQ0Rs5eQyw18AQgP0vnX6HAsAfwg
         kgwYCzMDg4nb0d2+FW5NsdytcKqB2oBzniMMtPhucGI5sDGxRatRlK+1+88+d9MQLilc
         Sk6Tc+8fpBYsMM3lLgX/8sggKnAiZOnOTPbBP9k0B+bk1krhiU/l03C8MWuBy1tiLBHs
         4oAstZJe2L1i6K7q1ILP7f7Dcdv7NaVWE38EPU/LDk7QOQtT2y2he9cEFACDnWVA8HjO
         I3EXskF63ElXl7ZZB835QwJuOJsZxEho2CrVqcK+M1XAJ7adZqxWYSyiSkU8u2usCvUY
         OdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718340008; x=1718944808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbtquG4p0hVvqKFk1U/Le3nDHhfbk+WM+GokVxGfK54=;
        b=f1PmQgmvTkO4/iXefA1wiOOAyp6q7cPETfxAKcKQRhxFWfDA6xIfpRSBxoJNhVY3GO
         uCqFHsbqHv7l/PlzjHz64HvxMAzGGjBVn6hIAR8a2lH/oIvhTXIAcLnnkw9alHP5LLT0
         /BekzH5/WD1V969QemkUCjkN+7+xvtjxdrWTJn5U5B2xWUYszrxbFlaeSwuROd8P0skK
         QMz6IXgqFfHsl6b0lomX6ssjnRsq7DAZdkO+XG581MR6TonelCoQ9sZt5mrpSni0lXcd
         Uw+QOeplj6b79cONRjs0Bq4P51S0btlLshfTb13asjY6U6PegJLTduFLdKfn0O+EAMDX
         XuTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIm4W5GM4vK54QuL5T9FICdzxJ9HtCgfALS/OXJ68unzvEhsmVaoFRa5ZDzZEuyHnrwziFHT0d7Mf5z2NRXeech56Idu9xdz2A3VUAijq/iHGPUxhpzGZzmGVl+gZXppHsyGcggXOu
X-Gm-Message-State: AOJu0YyUXuhU8zyh7CPgg2Zh9fEczbti0MqbDxmgwTS16vgPHT5uylGO
	CzyZU7BZMXSfSLxI/IwPSozOYGPN7eYWq526a7tZBlNBU1xaMmWKv2yxwnU1soGGjSiIf99yCyX
	dC+ei2iMew3a/8KTo60uVhcbJ4MWiokYar6Q9MA==
X-Google-Smtp-Source: AGHT+IHBsx4z2qtUMxZdNHJ7rhea/P9NlQ3RdnormcjNH+YUFkeA2RwUCdIJnmNFgrDo65EOWOo2cUHVGvpZXlOKNQU=
X-Received: by 2002:a25:abb2:0:b0:dfb:f8c:39f2 with SMTP id
 3f1490d57ef6-dfefebc9ca9mr2619063276.5.1718340008223; Thu, 13 Jun 2024
 21:40:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608155316.451600-1-flintglass@gmail.com> <20240608155316.451600-2-flintglass@gmail.com>
 <CAKEwX=P1Ojb71AEJ2gzQTrfWidFPcJZmoNxEwji7TceBN-szCg@mail.gmail.com>
 <CAPpoddeigM44jhTA8Ua=+J4MC1MikouBZVoPrCW2LZF+9r5YeA@mail.gmail.com>
 <CAJD7tkYp3GbuXV9G5bAZ1DetMmepV5ynciA+ukae7CKuxpXDJQ@mail.gmail.com>
 <CAPpoddfj1EdfXfTUT8bLaNxat0hYiE4X9=qG38gPgRgmmVOjcw@mail.gmail.com>
 <CAJD7tkZTSGz1bpo-pMNP_=11O-7RrhubWonqhUJwrt+TB=Ougg@mail.gmail.com>
 <CAPpoddcp9rVvg77WapsuiMdMzFrV0UioJ+VbQuJbKNY7-=nvVw@mail.gmail.com>
 <CAJD7tkY0=0yKSmEz=E5dL7GLRsO8r6ESWyzF+HdgK0wnMpzLKg@mail.gmail.com>
 <CAKEwX=PF=a2+pUBM3xEHBMu6VJY2Q64eTmVwo7vb4YmJQpK_DA@mail.gmail.com> <pezgvebjcykwgawtmvymqwktul25pgw5orxvvrbm24hjc3sizv@3yg7tbpwnlnf>
In-Reply-To: <pezgvebjcykwgawtmvymqwktul25pgw5orxvvrbm24hjc3sizv@3yg7tbpwnlnf>
From: Takero Funaki <flintglass@gmail.com>
Date: Fri, 14 Jun 2024 13:39:57 +0900
Message-ID: <CAPpoddcQRJ5EYFVaUhM+f5pV-RMtq=1kzkTuWQ2GRkcux-Yzcg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mm: zswap: fix global shrinker memcg iteration
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B46=E6=9C=8814=E6=97=A5(=E9=87=91) 1:49 Shakeel Butt <shakeel.bu=
tt@linux.dev>:
>
> On Thu, Jun 13, 2024 at 08:04:39AM GMT, Nhat Pham wrote:
> [...]
> > > > >
> > > > > Is the idea here to avoid moving the iterator to another offline =
memcg
> > > > > that zswap_memcg_offline_cleanup() was already called for, to avo=
id
> > > > > holding a ref on that memcg until the next run of zswap shrinking=
?
> > > > >
> > > > > If yes, I think it's probably worth doing. But why do we need to
> > > > > release and reacquire the lock in the loop above?
> > > >
> > > > Yes, the existing cleaner might leave the offline, already-cleaned =
memcg.
> > > >
> > > > The reacquiring lock is to not loop inside the critical section.
> > > > In shrink_worker of v0 patch, the loop was restarted on offline mem=
cg
> > > > without releasing the lock. Nhat pointed out that we should drop th=
e
> > > > lock after every mem_cgroup_iter() call. v1 was changed to reacquir=
e
> > > > once per iteration like the cleaner code above.
> > >
> > > I am not sure how often we'll run into a situation where we'll be
> > > holding the lock for too long tbh. It should be unlikely to keep
> > > encountering offline memcgs for a long time.
> > >
> > > Nhat, do you think this could cause a problem in practice?
> >
> > I don't remember prescribing anything to be honest :) I think I was
> > just asking why can't we just drop the lock, then "continue;". This is
> > mostly for simplicity's sake.
> >
> > https://lore.kernel.org/linux-mm/CAKEwX=3DMwrRc43iM2050v5u-TPUK4Yn+a4G7=
+h6ieKhpQ7WtQ=3DA@mail.gmail.com/

I apologize for misinterpreting your comments. Removing release/reacquire.

> >
> > But I think as Takero pointed out, it would still skip over the memcg
> > that was (concurrently) updated to zswap_next_shrink by the memcg
> > offline callback.
>
> What's the issue with keep traversing until an online memcg is found?
> Something like the following:
>
>
>         spin_lock(&zswap_shrink_lock);
>         do {
>                 zswap_next_shrink =3D mem_cgroup_iter(NULL, zswap_next_sh=
rink, NULL);
>         } while (zswap_next_shrink && !mem_cgroup_online(zswap_next_shrin=
k));
>
>         if (!zswap_next_shrink)
>                 zswap_next_shrink =3D mem_cgroup_iter(NULL, NULL, NULL);
>         ....
>
> Is the concern that there can a lot of offlined memcgs which may cause
> need resched warnings?

To avoid using the goto-based loop, here's the new version, including
Shakeel's suggestion:
```c
    do {
        spin_lock(&zswap_shrink_lock);
        /*
         * Advance the cursor to start shrinking from the next memcg
         * after zswap_next_shrink.  One memcg might be skipped from
         * shrinking if the cleaner also advanced the cursor, but it
         * will happen at most once per offlining memcg.
         */
        do {
            zswap_next_shrink =3D mem_cgroup_iter(NULL,
                    zswap_next_shrink, NULL);
            memcg =3D zswap_next_shrink;
        } while (memcg && !mem_cgroup_tryget_online(memcg));

        if (!memcg) {
            spin_unlock(&zswap_shrink_lock);
```
We can add or remove  `spin_unlock();spin_lock();` just after
mem_cgroup_iter(), if needed.
I believe the behavior is identical to v1 except for the starting
point of iteration.

For Naht's comment, 2. No skipping over zswap_next_shrink updated by
the memcg offline cleaner.
While this was true for v1, I'm moved to accept this skipping as it's
negligibly rare. As Yorsy commented, v1 retried the last memcg from
the last shrink_worker() run.

There are several options for shrink_worker where to start with:
1. Starting from the next memcg after zswap_next_shrink: It might skip
one memcg, but this is quite rare. It is the current behavior before
patch.

2. Starting from zswap_next_shrink: It might shrink one more page from
the memcg in addition to the one by the last shrink_worker() run. This
should also be rare, but probably more frequent than option 1. This is
the v0 patch behavior.

3. Addressing both: Save the last memcg as well. The worker checks if
it has been modified by the cleaner and advances only if it hasn't.
Like this:
```c
        do {
            if (zswap_last_shrink =3D=3D zswap_next_shrink) {
                zswap_next_shrink =3D mem_cgroup_iter(NULL,
                        zswap_next_shrink, NULL);
            }
            memcg =3D zswap_next_shrink;
        } while (memcg && !mem_cgroup_tryget_online(memcg));
        zswap_last_shrink =3D memcg;
```

Which one would be better? or any other idea?

