Return-Path: <linux-kernel+bounces-263347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CE893D4C0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E7F1C232AE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BB210A19;
	Fri, 26 Jul 2024 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Knbz2aAZ"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4504BA53
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722002689; cv=none; b=ZLGS9D3Bx1CPbZivXK1uNEVIx/dcp2gUyNa9n2LJ31pGmt7XaqVHL8sNFtFRhkhiWCB6rB+9eyz2sqqJEifiAoeplBXxKUHk9ikbw4C+aGjjYNFZP0VmJzmZRdu/xRA8EisTgAdqA/o2U8coFLtT32PY87qdQQ4LwEtdryi+ntc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722002689; c=relaxed/simple;
	bh=VvskMjEUgtoQdGVqCnbSHZQ+8PzbiDCVycbLh+XPygM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOEpm5wtO4FfipEE5X0ARgmnzTXp/8okCzACaDJup2H7AxS5rDb+QWFc1ee9cCOxz7gvRV3NKnaaQ9Iya+radCKsIcnTxRE5bXJI9VTYcyM0JtN9zNYiIYpZZ2bECUARIfoflVbQRFLL6z4bo/v16uTgiFC9YswmEAGnvgUrsIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Knbz2aAZ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7a18ba4143bso844869a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722002687; x=1722607487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZtkUciy53SlA3q1C2mBesNLpAodaomgS3oD4UCQoBY=;
        b=Knbz2aAZTjY8I3glMuoakkvVsjCo0O3m+dQrwKygvOzIu5dgo1hdUiZXkEzPbQ3ZmQ
         pHwnMdjbDIv7/VZiATm4+otIMjFI851iPhK/8TrL++oygm2YbDF3MjeHfAMfyLbmieh/
         Awcjb1njpcEr3Bjze8Bp3ORowKDIfRIOZSauZGF9sXeGrxa+VU6/qzcg0e8+B7SSh3Ij
         APY/fhWtqMQWGzGtkLdURnLmVTzHrADrfKaH0v84pTApUg/RCcyRCxArdvjCo93zjQDR
         1zXXqGKvaV9NV1vTMXMWuc3aWyzEdWG0alHSOmRchfq3vUsN+2K1XK8gFFVms5VN+MnN
         psdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722002687; x=1722607487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZtkUciy53SlA3q1C2mBesNLpAodaomgS3oD4UCQoBY=;
        b=h//lWej+AlNmJ/T5sXKoq6/pNsCl4m/YU/lvYURbTyxk/9sd/DU06WdI7d/htpdk10
         W2xvwYoR77EIMlDP6oiFeh9HsI4Ii/PQJ1MV77IIEsJtYIb67Etewv2vUZIqIdBBBoHF
         riD9KpdllqoBLsSYH3WYkQtg+L6JbJZRbqIibR4oVXv5vMQ3jpRsfResRnDMnoFN6/dG
         Udxiohxr5dCTLjBuZXHydtMsf+x128ZBkxtDhzZUKzFAfhAsmyWNiBPTaZ5UxzQOQp/Z
         M9I9bjIJ0zSAmqP4ggqUXlA7vmAjeMuPTGdXYZbqQHTfD3SUDOqrFyaeCWWFwza8Dqy5
         QCcg==
X-Forwarded-Encrypted: i=1; AJvYcCUENbJt5XV6Us7grhE7vkAWQX7iNSSnae8oaY0aP1Sjw/ZhlDvPEdP2ykXiJM7EIpHDBCGb8AQMQpQXY+yb3i6RtiE2LOV42hu2YsjY
X-Gm-Message-State: AOJu0YzDgHkJ0hWlAbqAXv5s9uAa1LcDr3O8Pwda1wJtzRDDkTGZZ6iW
	ysL7hvVztfTkSJylqUxDrZT1nLvbOr/nChZCl0czr9S4BoE8m38/y+wXQq+M/i9DnloEqCzNEqD
	ZUyUWDjJPgfmssyTF/3GexjmU61w=
X-Google-Smtp-Source: AGHT+IEQKLKHLh9iUylwXZrOlh4LpZAvjxsgcGtt4pKukArrozDytrxIsOXJTlQFPEWoZrVPyd4xxPLBpuHK0Qol0F8=
X-Received: by 2002:a17:90b:1c87:b0:2cb:50fa:b01e with SMTP id
 98e67ed59e1d1-2cf2ebb7c91mr5372574a91.41.1722002686719; Fri, 26 Jul 2024
 07:04:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726094728.1161-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240726094728.1161-1-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 26 Jul 2024 10:04:35 -0400
Message-ID: <CADnq5_MbocNRzAP6-2gR+CNofo-eFFM7GGsUFGUjQzKz7Q8qDg@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Use ARRAY_SIZE for array length
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Fri, Jul 26, 2024 at 5:55=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Use of macro ARRAY_SIZE to calculate array size minimizes
> the redundant code and improves code reusability.
>
> ./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1552:57-58=
: WARNING: Use ARRAY_SIZE.
> ./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1561:57-58=
: WARNING: Use ARRAY_SIZE.
> ./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1573:53-54=
: WARNING: Use ARRAY_SIZE.
> ./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1578:53-54=
: WARNING: Use ARRAY_SIZE.
> ./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1592:53-54=
: WARNING: Use ARRAY_SIZE.
> ./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1597:53-54=
: WARNING: Use ARRAY_SIZE.
> ./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1611:50-51=
: WARNING: Use ARRAY_SIZE.
> ./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1616:50-51=
: WARNING: Use ARRAY_SIZE.
> ./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1630:50-51=
: WARNING: Use ARRAY_SIZE.
> ./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1635:50-51=
: WARNING: Use ARRAY_SIZE.
> ./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1649:60-61=
: WARNING: Use ARRAY_SIZE.
> ./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1663:53-54=
: WARNING: Use ARRAY_SIZE.
> ./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1677:52-53=
: WARNING: Use ARRAY_SIZE.
> ./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1691:53-54=
: WARNING: Use ARRAY_SIZE.
> ./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1705:53-54=
: WARNING: Use ARRAY_SIZE.
> ./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1719:54-55=
: WARNING: Use ARRAY_SIZE.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D9580
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  .../display/dc/spl/dc_spl_scl_easf_filters.c  | 63 ++++++-------------
>  1 file changed, 20 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c=
 b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c
> index 09bf82f7d468..e847af94419a 100644
> --- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c
> +++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c
> @@ -1530,14 +1530,13 @@ static uint32_t spl_easf_get_scale_ratio_to_reg_v=
alue(struct spl_fixed31_32 rati
>         value =3D lookup_table_index_ptr->reg_value;
>
>         while (count < num_entries) {
> -
>                 lookup_table_index_ptr =3D (lookup_table_base_ptr + count=
);
>                 if (lookup_table_index_ptr->numer < 0)
>                         break;
>
>                 if (ratio.value < spl_fixpt_from_fraction(
> -                       lookup_table_index_ptr->numer,
> -                       lookup_table_index_ptr->denom).value) {
> +                   lookup_table_index_ptr->numer,
> +                   lookup_table_index_ptr->denom).value) {
>                         value =3D lookup_table_index_ptr->reg_value;
>                         break;
>                 }
> @@ -1548,21 +1547,13 @@ static uint32_t spl_easf_get_scale_ratio_to_reg_v=
alue(struct spl_fixed31_32 rati
>  }
>  uint32_t spl_get_v_bf3_mode(struct spl_fixed31_32 ratio)
>  {
> -       uint32_t value;
> -       unsigned int num_entries =3D sizeof(easf_v_bf3_mode_lookup) /
> -               sizeof(struct scale_ratio_to_reg_value_lookup);
> -       value =3D spl_easf_get_scale_ratio_to_reg_value(ratio,
> -               easf_v_bf3_mode_lookup, num_entries);
> -       return value;
> +       unsigned int num_entries =3D ARRAY_SIZE(easf_v_bf3_mode_lookup);
> +       return spl_easf_get_scale_ratio_to_reg_value(ratio, easf_v_bf3_mo=
de_lookup, num_entries);
>  }
>  uint32_t spl_get_h_bf3_mode(struct spl_fixed31_32 ratio)
>  {
> -       uint32_t value;
> -       unsigned int num_entries =3D sizeof(easf_h_bf3_mode_lookup) /
> -               sizeof(struct scale_ratio_to_reg_value_lookup);
> -       value =3D spl_easf_get_scale_ratio_to_reg_value(ratio,
> -               easf_h_bf3_mode_lookup, num_entries);
> -       return value;
> +       unsigned int num_entries =3D ARRAY_SIZE(easf_h_bf3_mode_lookup);
> +       return spl_easf_get_scale_ratio_to_reg_value(ratio, easf_h_bf3_mo=
de_lookup, num_entries);
>  }
>  uint32_t spl_get_reducer_gain6(int taps, struct spl_fixed31_32 ratio)
>  {
> @@ -1570,13 +1561,11 @@ uint32_t spl_get_reducer_gain6(int taps, struct s=
pl_fixed31_32 ratio)
>         unsigned int num_entries;
>
>         if (taps =3D=3D 4) {
> -               num_entries =3D sizeof(easf_reducer_gain6_4tap_lookup) /
> -                       sizeof(struct scale_ratio_to_reg_value_lookup);
> +               num_entries =3D ARRAY_SIZE(easf_reducer_gain6_4tap_lookup=
);
>                 value =3D spl_easf_get_scale_ratio_to_reg_value(ratio,
>                         easf_reducer_gain6_4tap_lookup, num_entries);
>         } else if (taps =3D=3D 6) {
> -               num_entries =3D sizeof(easf_reducer_gain6_6tap_lookup) /
> -                       sizeof(struct scale_ratio_to_reg_value_lookup);
> +               num_entries =3D ARRAY_SIZE(easf_reducer_gain6_6tap_lookup=
);
>                 value =3D spl_easf_get_scale_ratio_to_reg_value(ratio,
>                         easf_reducer_gain6_6tap_lookup, num_entries);
>         } else
> @@ -1589,13 +1578,11 @@ uint32_t spl_get_reducer_gain4(int taps, struct s=
pl_fixed31_32 ratio)
>         unsigned int num_entries;
>
>         if (taps =3D=3D 4) {
> -               num_entries =3D sizeof(easf_reducer_gain4_4tap_lookup) /
> -                       sizeof(struct scale_ratio_to_reg_value_lookup);
> +               num_entries =3D ARRAY_SIZE(easf_reducer_gain4_4tap_lookup=
);
>                 value =3D spl_easf_get_scale_ratio_to_reg_value(ratio,
>                         easf_reducer_gain4_4tap_lookup, num_entries);
>         } else if (taps =3D=3D 6) {
> -               num_entries =3D sizeof(easf_reducer_gain4_6tap_lookup) /
> -                       sizeof(struct scale_ratio_to_reg_value_lookup);
> +               num_entries =3D ARRAY_SIZE(easf_reducer_gain4_6tap_lookup=
);
>                 value =3D spl_easf_get_scale_ratio_to_reg_value(ratio,
>                         easf_reducer_gain4_6tap_lookup, num_entries);
>         } else
> @@ -1608,13 +1595,11 @@ uint32_t spl_get_gainRing6(int taps, struct spl_f=
ixed31_32 ratio)
>         unsigned int num_entries;
>
>         if (taps =3D=3D 4) {
> -               num_entries =3D sizeof(easf_gain_ring6_4tap_lookup) /
> -                       sizeof(struct scale_ratio_to_reg_value_lookup);
> +               num_entries =3D ARRAY_SIZE(easf_gain_ring6_4tap_lookup);
>                 value =3D spl_easf_get_scale_ratio_to_reg_value(ratio,
>                         easf_gain_ring6_4tap_lookup, num_entries);
>         } else if (taps =3D=3D 6) {
> -               num_entries =3D sizeof(easf_gain_ring6_6tap_lookup) /
> -                       sizeof(struct scale_ratio_to_reg_value_lookup);
> +               num_entries =3D ARRAY_SIZE(easf_gain_ring6_6tap_lookup);
>                 value =3D spl_easf_get_scale_ratio_to_reg_value(ratio,
>                         easf_gain_ring6_6tap_lookup, num_entries);
>         } else
> @@ -1627,13 +1612,11 @@ uint32_t spl_get_gainRing4(int taps, struct spl_f=
ixed31_32 ratio)
>         unsigned int num_entries;
>
>         if (taps =3D=3D 4) {
> -               num_entries =3D sizeof(easf_gain_ring4_4tap_lookup) /
> -                       sizeof(struct scale_ratio_to_reg_value_lookup);
> +               num_entries =3D ARRAY_SIZE(easf_gain_ring4_4tap_lookup);
>                 value =3D spl_easf_get_scale_ratio_to_reg_value(ratio,
>                         easf_gain_ring4_4tap_lookup, num_entries);
>         } else if (taps =3D=3D 6) {
> -               num_entries =3D sizeof(easf_gain_ring4_6tap_lookup) /
> -                       sizeof(struct scale_ratio_to_reg_value_lookup);
> +               num_entries =3D ARRAY_SIZE(easf_gain_ring4_6tap_lookup);
>                 value =3D spl_easf_get_scale_ratio_to_reg_value(ratio,
>                         easf_gain_ring4_6tap_lookup, num_entries);
>         } else
> @@ -1646,8 +1629,7 @@ uint32_t spl_get_3tap_dntilt_uptilt_offset(int taps=
, struct spl_fixed31_32 ratio
>         unsigned int num_entries;
>
>         if (taps =3D=3D 3) {
> -               num_entries =3D sizeof(easf_3tap_dntilt_uptilt_offset_loo=
kup) /
> -                       sizeof(struct scale_ratio_to_reg_value_lookup);
> +               num_entries =3D ARRAY_SIZE(easf_3tap_dntilt_uptilt_offset=
_lookup);
>                 value =3D spl_easf_get_scale_ratio_to_reg_value(ratio,
>                         easf_3tap_dntilt_uptilt_offset_lookup, num_entrie=
s);
>         } else
> @@ -1660,8 +1642,7 @@ uint32_t spl_get_3tap_uptilt_maxval(int taps, struc=
t spl_fixed31_32 ratio)
>         unsigned int num_entries;
>
>         if (taps =3D=3D 3) {
> -               num_entries =3D sizeof(easf_3tap_uptilt_maxval_lookup) /
> -                       sizeof(struct scale_ratio_to_reg_value_lookup);
> +               num_entries =3D ARRAY_SIZE(easf_3tap_uptilt_maxval_lookup=
);
>                 value =3D spl_easf_get_scale_ratio_to_reg_value(ratio,
>                         easf_3tap_uptilt_maxval_lookup, num_entries);
>         } else
> @@ -1674,8 +1655,7 @@ uint32_t spl_get_3tap_dntilt_slope(int taps, struct=
 spl_fixed31_32 ratio)
>         unsigned int num_entries;
>
>         if (taps =3D=3D 3) {
> -               num_entries =3D sizeof(easf_3tap_dntilt_slope_lookup) /
> -                       sizeof(struct scale_ratio_to_reg_value_lookup);
> +               num_entries =3D ARRAY_SIZE(easf_3tap_dntilt_slope_lookup)=
;
>                 value =3D spl_easf_get_scale_ratio_to_reg_value(ratio,
>                         easf_3tap_dntilt_slope_lookup, num_entries);
>         } else
> @@ -1688,8 +1668,7 @@ uint32_t spl_get_3tap_uptilt1_slope(int taps, struc=
t spl_fixed31_32 ratio)
>         unsigned int num_entries;
>
>         if (taps =3D=3D 3) {
> -               num_entries =3D sizeof(easf_3tap_uptilt1_slope_lookup) /
> -                       sizeof(struct scale_ratio_to_reg_value_lookup);
> +               num_entries =3D ARRAY_SIZE(easf_3tap_uptilt1_slope_lookup=
);
>                 value =3D spl_easf_get_scale_ratio_to_reg_value(ratio,
>                         easf_3tap_uptilt1_slope_lookup, num_entries);
>         } else
> @@ -1702,8 +1681,7 @@ uint32_t spl_get_3tap_uptilt2_slope(int taps, struc=
t spl_fixed31_32 ratio)
>         unsigned int num_entries;
>
>         if (taps =3D=3D 3) {
> -               num_entries =3D sizeof(easf_3tap_uptilt2_slope_lookup) /
> -                       sizeof(struct scale_ratio_to_reg_value_lookup);
> +               num_entries =3D ARRAY_SIZE(easf_3tap_uptilt2_slope_lookup=
);
>                 value =3D spl_easf_get_scale_ratio_to_reg_value(ratio,
>                         easf_3tap_uptilt2_slope_lookup, num_entries);
>         } else
> @@ -1716,8 +1694,7 @@ uint32_t spl_get_3tap_uptilt2_offset(int taps, stru=
ct spl_fixed31_32 ratio)
>         unsigned int num_entries;
>
>         if (taps =3D=3D 3) {
> -               num_entries =3D sizeof(easf_3tap_uptilt2_offset_lookup) /
> -                       sizeof(struct scale_ratio_to_reg_value_lookup);
> +               num_entries =3D ARRAY_SIZE(easf_3tap_uptilt2_offset_looku=
p);
>                 value =3D spl_easf_get_scale_ratio_to_reg_value(ratio,
>                         easf_3tap_uptilt2_offset_lookup, num_entries);
>         } else
> --
> 2.32.0.3.g01195cf9f
>

