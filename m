Return-Path: <linux-kernel+bounces-526179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE61AA3FB63
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618B23B8125
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3B41E7C0A;
	Fri, 21 Feb 2025 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/h4Q73B"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E53165F1A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154847; cv=none; b=q7kXknkLiaUWJ0p7JMSIxIVSz9g2kV0FzKslpIg6SVDr0/AAGflMJvmgD80WFwI6lUlQdybZ2dYiytxPfk1CbE4U7Ov7jdVV1XlpCSZnVFxfcyze0s1gNXtg6YmczjtomXPdJZRiCNTP2KGYKScwjrDIsrIx2Vb1+Te14lfv+rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154847; c=relaxed/simple;
	bh=3F4PLLlDDcYjyrHIJd3Z1KwkgliYoME3pBR9xLhcWls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WmLyGcekAjM5wDrwaM4Ho20BufjLFS4kMqnAHmCXYSAgBPYZfc2Sd1s26tyAIZruxfM4TE4/egF2XQ8AJqPG8jNkrCuKohikgL5SO1xjbs98c2GwA7PpyS9HiPylMcE1C3yKZuBdZmOzgUHiBczm9wOVAJBdplpvhS4mUrQDQiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/h4Q73B; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-216513f8104so5268405ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740154845; x=1740759645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ok1PcUQEwo9Z4uPO0boiFAABo1z9iTXkCf8Ww7aDcN4=;
        b=C/h4Q73B7hkr2TCMF5Rwy+Bf4DZYL1JUHNbHbMW2vB2rV1l3tblVCy6zeNIniTCPAB
         /i5KPSbv5pQASv3uyc6zy5ljDzilgRxSWRmFlt8zUnx1xg3ORGEN6+c3eT5a9kVKQCN4
         3ALYIEDBv6nqPuqpJkaK0tRaC9zfWDixuB4urr7hwu52Ar1HWwmJ2F3UtP/j2RCL5jR4
         mTPq6ZEfBHoM4i8njxGYOXoA1on2UwK/cjNr/IXA7n0cIBDFnuXx6Krra6YDy5FGyUD7
         0F7GVMVRarh//A0pC5V1RUkncU8IYqGdF0t0sb71TMiYkanc0Kl2qFVM0C+R7XWtdnJ1
         /YwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740154845; x=1740759645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ok1PcUQEwo9Z4uPO0boiFAABo1z9iTXkCf8Ww7aDcN4=;
        b=saVFjQ4jLG+SxJ7XeqAvOs4kTtD7LD6Lv92GMZxydiB6eCA8AmGu9D1k2Naxq4Y1JF
         U3w2+kdGnV2geaF1plsw5FoFc8GHYcZ6iTIAkaqoeXy4GR+Qb4ERddVgf6wC8t/WC/vz
         gfhZ87tVJb5fiiGAaZyKqz0cD2utNtbrd4CyQhArv7AKf6Xuu5ZXlBgAKq8to9030d57
         CQ/Bj3c9w98GoUNx6WpjGAccAY4NNAtw0ZfyLjagVzro69AHZMltMjL0dfWesdnK7Jd2
         BV9Y3BazC3lJMW5d09Hn9szP9C8mR6xOIaZXv5lrhOcMdLXz4zZvzfg07yohJHwT3HiW
         Fp0w==
X-Forwarded-Encrypted: i=1; AJvYcCWfXUHifK2hEa8GTvEXMuoT6nWVqDg8RkFT56xbP7n2rPUbYACXT916g/9UoG6z69KGx4yyQhc3q0xqe0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXjQ8zjFSSd2iSXbSMF4WWZeebBnldaVhf8SEB7ZNCcc0nifEC
	kxj9semHXEVn1lcab0t98A1lqkIcrj3pNYppRkXD6qAeGIUY+9xtgjdi/K/HqHDuZ8maKQFokEI
	cjf0piEoh6XSYnr/oOePaHsuFees=
X-Gm-Gg: ASbGncv07KUPwVQXRBa6hbSqQaMITVmvh5w6tCyfGq+NEZ33E3wIK90M7zImV7JhKQn
	36Aq+j1iXiMzC3FpV+KZzsMh8GtkSCqg3uVYTfIBJcNdPgRKEkvqr7yhsN9dyiaV8EHZxhmuJup
	ptAqa/fRA=
X-Google-Smtp-Source: AGHT+IEeQ2lAvqEeFfxRn4Nrirkv4XDLaiyqdZeo/kvpEaOxNKZdbOVPP1dGbhLcch78JwD2YY3l/amCLt49Tu9LiQU=
X-Received: by 2002:a17:902:cec6:b0:220:d71d:4666 with SMTP id
 d9443c01a7336-2219fff855emr22594785ad.13.1740154845453; Fri, 21 Feb 2025
 08:20:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219212318.46036-1-linux@treblig.org>
In-Reply-To: <20250219212318.46036-1-linux@treblig.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Feb 2025 11:20:33 -0500
X-Gm-Features: AWEUYZmGC373SSC5vhbJhkIHShbThxRTzyZwtw8XnFZE5muKA-ZzJdtCPl_7X2w
Message-ID: <CADnq5_PmPkzHrh9MjQF_tx-6ntEem0VKr=pbdWCgKaCKPz0NsA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove unused nbif_v6_3_1_sriov_funcs
To: linux@treblig.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Wed, Feb 19, 2025 at 4:48=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> The nbif_v6_3_1_sriov_funcs instance of amdgpu_nbio_funcs was added in
> commit 894c6d3522d1 ("drm/amdgpu: Add nbif v6_3_1 ip block support")
> but has remained unused.
>
> Alex has confirmed it wasn't needed.
>
> Remove it, together with the four unused stub functions:
>   nbif_v6_3_1_sriov_ih_doorbell_range
>   nbif_v6_3_1_sriov_gc_doorbell_init
>   nbif_v6_3_1_sriov_vcn_doorbell_range
>   nbif_v6_3_1_sriov_sdma_doorbell_range
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c | 46 ------------------------
>  drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.h |  1 -
>  2 files changed, 47 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/a=
md/amdgpu/nbif_v6_3_1.c
> index c92875ceb31f..9efe74148867 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
> @@ -474,52 +474,6 @@ const struct amdgpu_nbio_funcs nbif_v6_3_1_funcs =3D=
 {
>  };
>
>
> -static void nbif_v6_3_1_sriov_ih_doorbell_range(struct amdgpu_device *ad=
ev,
> -                                               bool use_doorbell, int do=
orbell_index)
> -{
> -}
> -
> -static void nbif_v6_3_1_sriov_sdma_doorbell_range(struct amdgpu_device *=
adev,
> -                                                 int instance, bool use_=
doorbell,
> -                                                 int doorbell_index,
> -                                                 int doorbell_size)
> -{
> -}
> -
> -static void nbif_v6_3_1_sriov_vcn_doorbell_range(struct amdgpu_device *a=
dev,
> -                                                bool use_doorbell,
> -                                                int doorbell_index, int =
instance)
> -{
> -}
> -
> -static void nbif_v6_3_1_sriov_gc_doorbell_init(struct amdgpu_device *ade=
v)
> -{
> -}
> -
> -const struct amdgpu_nbio_funcs nbif_v6_3_1_sriov_funcs =3D {
> -       .get_hdp_flush_req_offset =3D nbif_v6_3_1_get_hdp_flush_req_offse=
t,
> -       .get_hdp_flush_done_offset =3D nbif_v6_3_1_get_hdp_flush_done_off=
set,
> -       .get_pcie_index_offset =3D nbif_v6_3_1_get_pcie_index_offset,
> -       .get_pcie_data_offset =3D nbif_v6_3_1_get_pcie_data_offset,
> -       .get_rev_id =3D nbif_v6_3_1_get_rev_id,
> -       .mc_access_enable =3D nbif_v6_3_1_mc_access_enable,
> -       .get_memsize =3D nbif_v6_3_1_get_memsize,
> -       .sdma_doorbell_range =3D nbif_v6_3_1_sriov_sdma_doorbell_range,
> -       .vcn_doorbell_range =3D nbif_v6_3_1_sriov_vcn_doorbell_range,
> -       .gc_doorbell_init =3D nbif_v6_3_1_sriov_gc_doorbell_init,
> -       .enable_doorbell_aperture =3D nbif_v6_3_1_enable_doorbell_apertur=
e,
> -       .enable_doorbell_selfring_aperture =3D nbif_v6_3_1_enable_doorbel=
l_selfring_aperture,
> -       .ih_doorbell_range =3D nbif_v6_3_1_sriov_ih_doorbell_range,
> -       .update_medium_grain_clock_gating =3D nbif_v6_3_1_update_medium_g=
rain_clock_gating,
> -       .update_medium_grain_light_sleep =3D nbif_v6_3_1_update_medium_gr=
ain_light_sleep,
> -       .get_clockgating_state =3D nbif_v6_3_1_get_clockgating_state,
> -       .ih_control =3D nbif_v6_3_1_ih_control,
> -       .init_registers =3D nbif_v6_3_1_init_registers,
> -       .remap_hdp_registers =3D nbif_v6_3_1_remap_hdp_registers,
> -       .get_rom_offset =3D nbif_v6_3_1_get_rom_offset,
> -       .set_reg_remap =3D nbif_v6_3_1_set_reg_remap,
> -};
> -
>  static int nbif_v6_3_1_set_ras_err_event_athub_irq_state(struct amdgpu_d=
evice *adev,
>                                                        struct amdgpu_irq_=
src *src,
>                                                        unsigned type,
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.h b/drivers/gpu/drm/a=
md/amdgpu/nbif_v6_3_1.h
> index 9ac4831d39e1..3afec715a9fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.h
> +++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.h
> @@ -28,7 +28,6 @@
>
>  extern const struct nbio_hdp_flush_reg nbif_v6_3_1_hdp_flush_reg;
>  extern const struct amdgpu_nbio_funcs nbif_v6_3_1_funcs;
> -extern const struct amdgpu_nbio_funcs nbif_v6_3_1_sriov_funcs;
>  extern struct amdgpu_nbio_ras nbif_v6_3_1_ras;
>
>  #endif
> --
> 2.48.1
>

