Return-Path: <linux-kernel+bounces-379756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271E79AE347
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A5A1C21E50
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77781C879E;
	Thu, 24 Oct 2024 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHPrtSbo"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35391C4A31
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767766; cv=none; b=sLxVQh18Wml3Ijm0y3/oMrDaUFy0Za5GAaf58KOel1fVu3BN0sfI2vZ0wbkYl6QAb5MZHgfmavcOjPNOEkcwshI3I5UF7g6g64B5jUTfgtlDPn4Dqah/Ru64hqHIao3gdOXIdaSKdTOrRa16nQ8TMYAp9LN2kPaA64WJqdFYO2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767766; c=relaxed/simple;
	bh=/DupztjPPxP6/yR5blgMyduO9g/hEuiLBCcC9S6SDoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djRBrMw1Kw703BuJI9uh/4X0DeklxAlItflpxaNbcSoJMNCSgD3OMda8bILGjAgVfYfivwUmzsjQxUwqtwRihabgElBXzlowvi+RxBzSAStNhPDCdvEUUB4YzpGIDjgEcsM1AxpFqoQZ0aS47jFPPXmVwYRqQnc1pU4g4KNGShw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHPrtSbo; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d6716e200so90400f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 04:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729767762; x=1730372562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+rBpU1fj2NO0Xxcw+tiXkle1Ph6NpAoy9Tv6zEpu5I=;
        b=VHPrtSboT1dZkkozKob1eIo0ORYs2DLXr8P8JiCCGPz1LcSbbfMO73Tky0ClQFPsrk
         NRsD9UvMs/L/JWdp70gS9fXWayG6UCC/OT6SZ6unfycELXXu7VKQtL8Jx/oUNwgzjof+
         kvePzKtZJANHG6v5qI6NmRt5DVDv/+pZP9uJLn7foccHBRR7prkrScdcYke1kdb5/ug7
         BSeu6wG+IO/zI088cLUdu09NA26AXvqOwI6DK3cwKLU/qYIsln6dT8EiZVg2JY6taVU9
         xdC8a9zh0zsi56hYn2EJosFO+yCBhwqEctBNjRfcvrh6XSr3Ft3SSd2jFjMOkIvQDa2Z
         ou3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729767762; x=1730372562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+rBpU1fj2NO0Xxcw+tiXkle1Ph6NpAoy9Tv6zEpu5I=;
        b=cikmIN9or+6syzB1C2cHlUU//2mad9tzVq9T4YlTxIHWjcnUUPwmnPIJgVl5a832gz
         bJdOW/9cPmBvVI4pKFPY2FX1PflIs+tbrAUPMNYXk8H/tgu5yWKq6lYpb3V24qzweDgf
         4sPYx84XW4zAe36JGPdHsOa4BPusi1QS+wuaXom9bx7UIfnm4nbWbU+EsFPfD2s2Wv1o
         Aa9nLeSeuRUbTaMwZrP90i0+Xs3tcP032gnEq1JCENPSUwCvQBN4gRoEbQ/ljNAKEuK7
         UmfqTFLuLZKwBRQS+TtUBKAN3DqXhVN/5q7GgY8KJXrr+oEIMHdATSu1xyB5pu0H8tpD
         7YPg==
X-Forwarded-Encrypted: i=1; AJvYcCVRtnPkpxMvxko0JUvCXZL0rIShEDiHVpld8MqV2muAYFjCChHu5NcvBZ/FVi5Ag+fq/A7/sNx5UBF35hU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcaVdZxz7YKETJDufTsJ9dhra/HPyFM6Q65oskHBD1ggIEgWqp
	6JCYAI4tUPJac2de8pf0ZGBz3J23Cro9PzaJA6Kaegy++25uu2RKDmVJ7BnG2I4Owjqje/+j1pU
	eM6PzDZ2JC7NhKuwaQVo43RqVVoY=
X-Google-Smtp-Source: AGHT+IH4JGHzRb9jWikDVpbBK3rDzevf9xVNgbJpgC4gFDTY1gFQUQh8FiT//xXAS+ix8wGJO5lE2iFrUjY9jm7bb08=
X-Received: by 2002:a5d:47c2:0:b0:374:cc10:bb42 with SMTP id
 ffacd0b85a97d-37efcef323fmr1802100f8f.2.1729767761844; Thu, 24 Oct 2024
 04:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1729652883-12202-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1729652883-12202-1-git-send-email-zhiguo.niu@unisoc.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 24 Oct 2024 19:02:30 +0800
Message-ID: <CAHJ8P3+kKayoWk8B6JQ66vC9LGxoWP-pDDGtkF-MQcJG3OS3xQ@mail.gmail.com>
Subject: Re: [PATCH V2] f2fs: fix to avoid use GC_AT when setting gc_mode as
 GC_URGENT_LOW or GC_URGENT_MID
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Chao,
any suggestions about this patch version? base your kindly suggestions
on patch v1
this is the issue encountered when I test GC.
thanks!

Zhiguo Niu <zhiguo.niu@unisoc.com> =E4=BA=8E2024=E5=B9=B410=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=B8=89 11:08=E5=86=99=E9=81=93=EF=BC=9A
>
> If gc_mode is set to GC_URGENT_LOW or GC_URGENT_MID, cost benefit GC
> approach should be used, but if ATGC is enabled at the same time,
> Age-threshold approach will be selected, which can only do amount of
> GC and it is much less than the numbers of CB approach.
>
> some traces:
>   f2fs_gc-254:48-396     [007] ..... 2311600.684028: f2fs_gc_begin: dev =
=3D (254,48), gc_type =3D Background GC, no_background_GC =3D 0, nr_free_se=
cs =3D 0, nodes =3D 1053, dents =3D 2, imeta =3D 18, free_sec:44898, free_s=
eg:44898, rsv_seg:239, prefree_seg:0
>   f2fs_gc-254:48-396     [007] ..... 2311600.684527: f2fs_get_victim: dev=
 =3D (254,48), type =3D No TYPE, policy =3D (Background GC, LFS-mode, Age-t=
hreshold), victim =3D 10, cost =3D 4294364975, ofs_unit =3D 1, pre_victim_s=
ecno =3D -1, prefree =3D 0, free =3D 44898
>   f2fs_gc-254:48-396     [007] ..... 2311600.714835: f2fs_gc_end: dev =3D=
 (254,48), ret =3D 0, seg_freed =3D 0, sec_freed =3D 0, nodes =3D 1562, den=
ts =3D 2, imeta =3D 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefre=
e_seg:0
>   f2fs_gc-254:48-396     [007] ..... 2311600.714843: f2fs_background_gc: =
dev =3D (254,48), wait_ms =3D 50, prefree =3D 0, free =3D 44898
>   f2fs_gc-254:48-396     [007] ..... 2311600.771785: f2fs_gc_begin: dev =
=3D (254,48), gc_type =3D Background GC, no_background_GC =3D 0, nr_free_se=
cs =3D 0, nodes =3D 1562, dents =3D 2, imeta =3D 18, free_sec:44898, free_s=
eg:44898, rsv_seg:239, prefree_seg:
>   f2fs_gc-254:48-396     [007] ..... 2311600.772275: f2fs_gc_end: dev =3D=
 (254,48), ret =3D -61, seg_freed =3D 0, sec_freed =3D 0, nodes =3D 1562, d=
ents =3D 2, imeta =3D 18, free_sec:44898, free_seg:44898, rsv_seg:239, pref=
ree_seg:0
>
> Fixes: 0e5e81114de1 ("f2fs: add GC_URGENT_LOW mode in gc_urgent")
> Fixes: d98af5f45520 ("f2fs: introduce gc_urgent_mid mode")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
> v2: make GC_URGENT_LOW also use CB approach
> ---
>  fs/f2fs/gc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index e40bdd1..3e1b6d2 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -257,6 +257,8 @@ static int select_gc_type(struct f2fs_sb_info *sbi, i=
nt gc_type)
>
>         switch (sbi->gc_mode) {
>         case GC_IDLE_CB:
> +       case GC_URGENT_LOW:
> +       case GC_URGENT_MID:
>                 gc_mode =3D GC_CB;
>                 break;
>         case GC_IDLE_GREEDY:
> --
> 1.9.1
>

