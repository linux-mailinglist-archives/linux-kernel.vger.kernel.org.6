Return-Path: <linux-kernel+bounces-213490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E5D9075FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98071C22965
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA0214901C;
	Thu, 13 Jun 2024 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak7SMJ9v"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB026148FFF;
	Thu, 13 Jun 2024 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291093; cv=none; b=LHQCnG+XnzuqcgA3stEnjb5F4p4603umDtFttuMCrlopn1j1BTeyOIRkjbJvEWxfHkmWEi9p4odZHIgqPBU3W5oxGPEKA7VzjEjtV4evG1xoqpzteNVXxM8DWU1RzUmoWOYqnSPentZP2sDJy5A9rpj/T8OrjLEKMZFP9apJ4OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291093; c=relaxed/simple;
	bh=VuyCLVw5xrGKJGG2faecvFsFbDGJjg+31wyzeWw+FRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfY8vq9i0XHoF+AcpMrt6Dew31bueMycLOeTPa/tfvDWlXeJtP8TjlFS/5WJ6JLlthuZBKgCJTjKM0AjOPNSfL5TC1Bt5s3aNfXdRyznBrnFF3xdsyoYIt+k3fd+BDeCX647iMawlCiDAYRPDPVp0mElS98cKEsnvXYwGyiNTGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ak7SMJ9v; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b05c9db85fso6217626d6.2;
        Thu, 13 Jun 2024 08:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718291091; x=1718895891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APrVAMfdz5UzlM6te+OQj7RDwISoPjhwoAJLzTA+Yb4=;
        b=ak7SMJ9v54LvlVgk3VVCwc2aFxcHFmeVu5Pcpk53CKyhctgHcOO31suS8fgYqkK06q
         Fyj5nNIiHzBmkQI4m73us1I+lhbkEDVzqdpxDckLALqfzvmeUNZNqoLexvFt2X+Ufqzx
         PRugmZHFoTbumj55ktS6cFCsHrLlM6/YLzw69jqGlj/RbMwUwpyw7vJ4CZ4N4vPCXYIm
         LAkzURDAt6d1+1fgXYd4bsa716gBwia7crDb3QZQIJ5lOemxw+VBmhWoJDbAZJpqwjEk
         DpZj3CctcyGJ9r9nTvP3wduiG1V6yzumjbq4++6Hi6XcamBCO9L0d29qzp4dipOqaaSf
         wNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718291091; x=1718895891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APrVAMfdz5UzlM6te+OQj7RDwISoPjhwoAJLzTA+Yb4=;
        b=rGeDf4Nw1GXvKSQRxUkjTikkS6xSf3vEAU54I3TJ3fe8m6UelXsk4896MgRpHD2Vr+
         BHg0NuROffkiSZS0HFIT4LUnjc1Y8EYun6bo+zHYI9XRzmLVpaklFMthV5z2Nh4HlJrk
         hcyezBaGH6JadOjE+sb/umG6Z1umL6xaRQ2QA25B+7HmQ9FHnaDVCaA96gqcwBrK9+/V
         GZAArEpqtygI/gAxVydzfvCs4VsDXGgGdKDQUI08JjR06aEtEPlgSn+7JXaapOtpmMwk
         RL3/K3u72b7q7e9h8lxUgm3egXBjYcqEQlq0xfZQHwkOVfLjix8zc/rtqZOm/8XYroPV
         PLlA==
X-Forwarded-Encrypted: i=1; AJvYcCUmHDM+eAkc29er0yFdKq4Gl4TjfYQKY39lMTz8YMzhrYHEqyvp8hK/YMkawtdQilBclu0aqqWI5bBiWlI119zrwZGOX1xdG01Mc3chEGnDrbgQu0N01rYYxa2vbgbEhLTwgEzaSiTA
X-Gm-Message-State: AOJu0YyKn9lgdLu+viq9sSDFuSEf9mMxvTOLQ2xXRAHJQohPb3i6+Q3r
	VgUBgH5L8/icfCFLSIJ9fEYOG4MLO/snIGlhIvoLvx+K1LqM7tBNZ75Aph+Xdzm912b4OXLQCGh
	j613j4tJNbgY969GiqS/4Kz2u6Tc=
X-Google-Smtp-Source: AGHT+IGU/QEpuTi/kwbsmlS2WdrVWU0zL2Qu2R/VLvOWuGqq4KLKtnVAdbBgWWeLmr1OLqdFCN9jK78F3SRfXTZlqgw=
X-Received: by 2002:a05:6214:311d:b0:6b0:80f4:4505 with SMTP id
 6a1803df08f44-6b1a64907d8mr51601676d6.33.1718291090593; Thu, 13 Jun 2024
 08:04:50 -0700 (PDT)
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
 <CAPpoddcp9rVvg77WapsuiMdMzFrV0UioJ+VbQuJbKNY7-=nvVw@mail.gmail.com> <CAJD7tkY0=0yKSmEz=E5dL7GLRsO8r6ESWyzF+HdgK0wnMpzLKg@mail.gmail.com>
In-Reply-To: <CAJD7tkY0=0yKSmEz=E5dL7GLRsO8r6ESWyzF+HdgK0wnMpzLKg@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 13 Jun 2024 08:04:39 -0700
Message-ID: <CAKEwX=PF=a2+pUBM3xEHBMu6VJY2Q64eTmVwo7vb4YmJQpK_DA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mm: zswap: fix global shrinker memcg iteration
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Takero Funaki <flintglass@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 7:58=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Wed, Jun 12, 2024 at 7:36=E2=80=AFPM Takero Funaki <flintglass@gmail.c=
om> wrote:
> >
> > 2024=E5=B9=B46=E6=9C=8813=E6=97=A5(=E6=9C=A8) 11:18 Yosry Ahmed <yosrya=
hmed@google.com>:
> >
> > > > The corrected version of the cleaner should be:
> > > > ```c
> > > > void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
> > > > {
> > > >         /* lock out zswap shrinker walking memcg tree */
> > > >         spin_lock(&zswap_shrink_lock);
> > > >         if (zswap_next_shrink =3D=3D memcg) {
> > > >                 do {
> > > >                         zswap_next_shrink =3D mem_cgroup_iter(NULL,
> > > >                                         zswap_next_shrink, NULL);
> > > >                         spin_unlock(&zswap_shrink_lock);
> > > >                         spin_lock(&zswap_shrink_lock);
> > > >                         if (!zswap_next_shrink)
> > > >                                 break;
> > > >                 } while (!mem_cgroup_online(zswap_next_shrink));
> > > >         }
> > > >         spin_unlock(&zswap_shrink_lock);
> > > > }
> > > > ```
> > >
> > > Is the idea here to avoid moving the iterator to another offline memc=
g
> > > that zswap_memcg_offline_cleanup() was already called for, to avoid
> > > holding a ref on that memcg until the next run of zswap shrinking?
> > >
> > > If yes, I think it's probably worth doing. But why do we need to
> > > release and reacquire the lock in the loop above?
> >
> > Yes, the existing cleaner might leave the offline, already-cleaned memc=
g.
> >
> > The reacquiring lock is to not loop inside the critical section.
> > In shrink_worker of v0 patch, the loop was restarted on offline memcg
> > without releasing the lock. Nhat pointed out that we should drop the
> > lock after every mem_cgroup_iter() call. v1 was changed to reacquire
> > once per iteration like the cleaner code above.
>
> I am not sure how often we'll run into a situation where we'll be
> holding the lock for too long tbh. It should be unlikely to keep
> encountering offline memcgs for a long time.
>
> Nhat, do you think this could cause a problem in practice?

I don't remember prescribing anything to be honest :) I think I was
just asking why can't we just drop the lock, then "continue;". This is
mostly for simplicity's sake.

https://lore.kernel.org/linux-mm/CAKEwX=3DMwrRc43iM2050v5u-TPUK4Yn+a4G7+h6i=
eKhpQ7WtQ=3DA@mail.gmail.com/

But I think as Takero pointed out, it would still skip over the memcg
that was (concurrently) updated to zswap_next_shrink by the memcg
offline callback.

