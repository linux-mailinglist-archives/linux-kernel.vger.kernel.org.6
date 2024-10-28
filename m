Return-Path: <linux-kernel+bounces-384658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6BF9B2CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA801F23964
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34F9193091;
	Mon, 28 Oct 2024 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPgHMEUE"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236ED52F9B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730111363; cv=none; b=ASNgZeYsvYBs2p2bvEKJfuflL8JHxdFxegVyqXSRBOZRssMLNMnAHXuDzqq7sogulii9I0+gV3yUFnj6LC0QeGJVVoOT7Av5X+b8vNkUr93kxX9zLWkWmFQhOxB/ihstMzRIXtguDKoqDCCF/kVSB+oBbOBvXl1EzbAZuXLDqOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730111363; c=relaxed/simple;
	bh=RHrCR19mH+IWpiBCI5GwmFzEep3i28rKt8asgy32UvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lk2/K3y2Esb6KHMSJ2UThA57av+I6/+DKNW69nL5RukcSVvVVbkIeNJoYFid7Qf9DiJ0pJsd0slBB9kCXMz7sZs0dO1agaULc6M2uvhSga9sie3c/kBsLdMzv1AKoYW7YTrVm0aUzFAjljL1GjFTFH6j74px6dFkvyrCPneLZP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPgHMEUE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d570728ebso531396f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730111357; x=1730716157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e66hzpUkXwh1+UAivXnQMAmUZZGDpRptxtP/9uQ4ZKk=;
        b=YPgHMEUEC6x2ckq32CmgDj7ekWMK8Md4dsJof91EjZQRKvb2w6jmXcNO41UFWgeBRt
         HXmJgz36vOwviJYbLVnrk2L2W8wPEOmTRiZvjrS++9TFT3GyYVKG+AwFcbHMGkrbQ3Du
         JLxRQxLDNzizoCR4rV4WtkT9XDgb+FhGpxWn8iuJqNFkI2B6Om0pyKmEXJzqV/kLBYOs
         t28FanTa3CKdHadMi5yIjf7NodaXqdJB6pszJbSowM9I5ef3KGoR0dvXv9GUZmAkhunQ
         Uw469rwXBF7nf9jBaT/4UmIZsik6ybdIhCd9M7GZ0FIe4JypLLNMpvf45lFRUtkeI8AL
         arAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730111357; x=1730716157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e66hzpUkXwh1+UAivXnQMAmUZZGDpRptxtP/9uQ4ZKk=;
        b=nOIZp8Ba/el33EVID1mNRcFwakxJ5cFuoGIn73+/srm1rnd8m7uWwkOc5+925DEwY8
         j1ssWWrP13EXsJLWXXbl4hwQTqNoLcvlJlifJiy1fKpgFkKNiSaedCnZhQf9ils4qk1U
         JQOSX6KoqsDVWsu+PRcUSSiOc1vFinOn0quQ//1+C0JJbZCXbq7SO1Kx5HHEWrag5fuC
         4DkqpXeCsTzZp4MxltBjRBSlKm7Q0R/9jfHCdGXX1Q9hItch/B6OJlkCEc09miXrct1p
         hDpWCO6N87Xb7jCFUOfkf+oz0/BbSbVfsWd7L/81sVKdEMnjL4uH9+giTvqAMF5Vjg4D
         uYjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKuFTe60vF/2vxkxM3JvmtUiCN3l70xC3KGzw/7MdtKRSDeSKPicXBfBH/Gk/GsLuKF9tGAjkOO9a79QY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxSymqbK8FzgIlk4fP29DMNsw53ogXTpBM/8VcaelxvTiq6H57
	9Hj2Ne0Q/H58jInIFODCb5sWElcpL2jaBIvhAAzD5iIurZGl+65aoGjNDKbROIliF4KgiPE68iO
	OhiituofdVo8MQQUZ7hg2yARpb4U=
X-Google-Smtp-Source: AGHT+IE1YBr0eKkaIlb+X8Y2dq45JaRERXIEnKMFMLPIGlhK2fYf1knJjHF6p2ekvt/howswXmhyYrH3666kcgnJWAs=
X-Received: by 2002:a5d:6c6d:0:b0:37d:47f6:6fda with SMTP id
 ffacd0b85a97d-3806117dde8mr2587347f8f.7.1730111357196; Mon, 28 Oct 2024
 03:29:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1729652883-12202-1-git-send-email-zhiguo.niu@unisoc.com> <7d68560a-19ea-455c-ba23-1dda32ed4d15@kernel.org>
In-Reply-To: <7d68560a-19ea-455c-ba23-1dda32ed4d15@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Mon, 28 Oct 2024 18:29:05 +0800
Message-ID: <CAHJ8P3LrnCYo_ETa7XPty_keAmPd_z8V9A2Bp6gDaxBMCxpPSA@mail.gmail.com>
Subject: Re: [PATCH V2] f2fs: fix to avoid use GC_AT when setting gc_mode as
 GC_URGENT_LOW or GC_URGENT_MID
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B410=E6=9C=8828=E6=97=A5=E5=
=91=A8=E4=B8=80 17:34=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024/10/23 11:08, Zhiguo Niu wrote:
> > If gc_mode is set to GC_URGENT_LOW or GC_URGENT_MID, cost benefit GC
> > approach should be used, but if ATGC is enabled at the same time,
> > Age-threshold approach will be selected, which can only do amount of
> > GC and it is much less than the numbers of CB approach.
>
> The code looks fine to me, there is one more thing, can you please update
> description of gc_urgent in sysfs-fs-f2fs? so it can describe explicitly
> that configuring gc_urgent to low or mid will setup GC_CB GC policy which
> will override GC_AT.
Dear Chao,
OK, thanks for you suggestions.

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
> > Fixes: 0e5e81114de1 ("f2fs: add GC_URGENT_LOW mode in gc_urgent")
> > Fixes: d98af5f45520 ("f2fs: introduce gc_urgent_mid mode")
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> > v2: make GC_URGENT_LOW also use CB approach
> > ---
> >   fs/f2fs/gc.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index e40bdd1..3e1b6d2 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -257,6 +257,8 @@ static int select_gc_type(struct f2fs_sb_info *sbi,=
 int gc_type)
> >
> >       switch (sbi->gc_mode) {
> >       case GC_IDLE_CB:
> > +     case GC_URGENT_LOW:
> > +     case GC_URGENT_MID:
> >               gc_mode =3D GC_CB;
> >               break;
> >       case GC_IDLE_GREEDY:
>

