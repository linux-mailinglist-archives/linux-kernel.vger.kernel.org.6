Return-Path: <linux-kernel+bounces-377241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7939E9ABBD8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 04:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AECD1C22D60
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA7952F88;
	Wed, 23 Oct 2024 02:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zq2OKrY3"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EA817F7
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651756; cv=none; b=nJG/kMz1sBMOTPrcza0gudjIJBg3JzcFA6nqzEEnv2mI1ACL4GS1nA4R7Ul+M3LDAuwPRKwa9eoLowLgULWlGq4qZBDH6k5v5qykHcmpTcNNSecPdvUIc0vBFFpB84gPHNhXzWlEBaPIpfP9suCHXu4/57jYf7zYTD4VOEgPF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651756; c=relaxed/simple;
	bh=YTJH9JIZTiz5GzDP4/q4LhY5jb+bbCaYEAeSUWS/4KQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8BSGYcNxDUq/EL1jo3Dk9HuXr6fdLPdd8SkPYsLuE0PptUvKCvf2yn90OtbBjHqhTeh36VCKo0TmJ9XSmIHM4l1Quo8hEmZrmiUwe0sWaVLs5PY65KBI7zAkzCx11YLCvLFH1OQgAhrcfg4Mb8+xpDB8BFwXYH3yNObxAc/ghk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zq2OKrY3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315ce4d250so8294855e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729651753; x=1730256553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiaRh5RUNm5O6Dddihn/O/4m6jy7rccRtfMj6bKeym0=;
        b=Zq2OKrY3cm2wyfaxxpRDwchvtzCGOjo6Zq9zSLEWRibKi0qv259bp+xLFURbKvcGrS
         Kjwz4DVN2AOE09tnl4QmfHcy6zlrBckQlYRmE284a8g0wm5EentqfHZ4CbSjJIP2lldn
         YyRXdu1/Sahl6aYxYUOsRvUr0MSG88k7kJcw6KRUgIxfu0GizBCYu7bYtyBxUxh15G7Y
         L7IuDVs9BwKsniLVBrIvJ8GGPRVV/tXIyHbIPLl/LgxDimmFQiv2t3ZMg92vv/LdazGw
         RsoFNMYLrD+KT9olADOIVMZ/r0lFKeksnyPEMsh5mF3ipx6Ux++p4t9m42+navkrT+M1
         6jxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729651753; x=1730256553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wiaRh5RUNm5O6Dddihn/O/4m6jy7rccRtfMj6bKeym0=;
        b=Ssc/EKZ/eqcLlUhT0ojykXxxeV9cDWXrXJxlsP3Wyf4H+aX42IQkZnZzzvmjKl0CEZ
         RKTv57F9y/p/3vS5jrG4+95rhQjuAj01i17ocjid6X3fle/wNYSlzPlzgN0Vo0E48G0q
         /+IOG//hnSiR+P60azknH62bUAp8RDYdd8GYTVhchkw3NxnBr7a0dvmbv4id06/Ph2QL
         xLQHCXBAjl9uokMVgB7ZCgKdEAvbtTHfXdMMrQah0KejQ4OQPxhHteOZv3iSfClxP3fs
         zqnTiX34NMLWk2AzZwFUuJaEwX7rI5M7A0vxNtjSMt+ei1yGX45Na3/XCuZipvPh+ZQq
         Keag==
X-Forwarded-Encrypted: i=1; AJvYcCXpDPZ+CVDeCkIoKD+OAZFotwYUVlqDSiZd1etdNG7JKqDZUSlL18VifvDcn7TOdbac3FglKXHFaygkmfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywww8X+AvNQ3rSvx3B6giV1lsmSXaeGfxzJ0wLWQioTPeL51lwA
	iAxCNsjhWO2uVG0M9JDo1zpPsFfLeLv/Ll+M4VzNtjt8Z9ApJWmXtcTtWL5JiovIb3LrE/87W5k
	bfKtERTHyfo4lfeoC3PVgwU65J6c=
X-Google-Smtp-Source: AGHT+IEUJoKVzePOgGPBj2D4HiQDP9RAbWYiWW3odar1X34BtNWzUhkR7VlayUrdPqiWROj0Jxkw/v7JTB3/9q89P0c=
X-Received: by 2002:a05:600c:3ba2:b0:42c:ba6c:d9a7 with SMTP id
 5b1f17b1804b1-431841b54e8mr3796195e9.4.1729651752539; Tue, 22 Oct 2024
 19:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1729588481-29390-1-git-send-email-zhiguo.niu@unisoc.com> <28ad2c90-a95c-440a-ae6a-5fb19bacd252@kernel.org>
In-Reply-To: <28ad2c90-a95c-440a-ae6a-5fb19bacd252@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 23 Oct 2024 10:49:01 +0800
Message-ID: <CAHJ8P3++emTdFd0NYUxqVr47dsRmfiCWLpCUuK+TN60pN_4fTA@mail.gmail.com>
Subject: Re: [PATCH] f2fs: fix to avoid use GC_AT when setting gc_mode as GC_URGENT_MID
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B410=E6=9C=8823=E6=97=A5=E5=
=91=A8=E4=B8=89 10:42=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024/10/22 17:14, Zhiguo Niu wrote:
> > GC_URGENT_MID is introduced by commit
> > d98af5f45520 ("f2fs: introduce gc_urgent_mid mode"), aim to does GC
> > forcibly uses cost benefit GC approach, but if ATGC is enabled at
> > the same time, Age-threshold approach will be selected, which can only
> > do amount of GC and it is much less than the numbers of CB approach.
>
> gc urgent low(2): lowers the bar of checking I/O idling in
>                   order to process outstanding discard commands and GC a
>                   little bit aggressively. uses cost benefit GC approach.
>
> GC_URGENT_LOW uses CB algorithm as well?
Hi Chao.
OH, yes, thanks!
>
> Thanks,
>
> >
> > some traces:
> >    f2fs_gc-254:48-396     [007] ..... 2311600.684028: f2fs_gc_begin: de=
v =3D (254,48), gc_type =3D Background GC, no_background_GC =3D 0, nr_free_=
secs =3D 0, nodes =3D 1053, dents =3D 2, imeta =3D 18, free_sec:44898, free=
_seg:44898, rsv_seg:239, prefree_seg:0
> >    f2fs_gc-254:48-396     [007] ..... 2311600.684527: f2fs_get_victim: =
dev =3D (254,48), type =3D No TYPE, policy =3D (Background GC, LFS-mode, Ag=
e-threshold), victim =3D 10, cost =3D 4294364975, ofs_unit =3D 1, pre_victi=
m_secno =3D -1, prefree =3D 0, free =3D 44898
> >    f2fs_gc-254:48-396     [007] ..... 2311600.714835: f2fs_gc_end: dev =
=3D (254,48), ret =3D 0, seg_freed =3D 0, sec_freed =3D 0, nodes =3D 1562, =
dents =3D 2, imeta =3D 18, free_sec:44898, free_seg:44898, rsv_seg:239, pre=
free_seg:0
> >    f2fs_gc-254:48-396     [007] ..... 2311600.714843: f2fs_background_g=
c: dev =3D (254,48), wait_ms =3D 50, prefree =3D 0, free =3D 44898
> >    f2fs_gc-254:48-396     [007] ..... 2311600.771785: f2fs_gc_begin: de=
v =3D (254,48), gc_type =3D Background GC, no_background_GC =3D 0, nr_free_=
secs =3D 0, nodes =3D 1562, dents =3D 2, imeta =3D 18, free_sec:44898, free=
_seg:44898, rsv_seg:239, prefree_seg:
> >    f2fs_gc-254:48-396     [007] ..... 2311600.772275: f2fs_gc_end: dev =
=3D (254,48), ret =3D -61, seg_freed =3D 0, sec_freed =3D 0, nodes =3D 1562=
, dents =3D 2, imeta =3D 18, free_sec:44898, free_seg:44898, rsv_seg:239, p=
refree_seg:0
> >
> > Fixes: d98af5f45520 ("f2fs: introduce gc_urgent_mid mode")
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> >   fs/f2fs/gc.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index e40bdd1..daecf69 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -257,6 +257,7 @@ static int select_gc_type(struct f2fs_sb_info *sbi,=
 int gc_type)
> >
> >       switch (sbi->gc_mode) {
> >       case GC_IDLE_CB:
> > +     case GC_URGENT_MID:
> >               gc_mode =3D GC_CB;
> >               break;
> >       case GC_IDLE_GREEDY:
>

