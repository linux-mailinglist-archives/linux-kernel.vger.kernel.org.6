Return-Path: <linux-kernel+bounces-296116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ACD95A5D9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 22:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072381C22ECC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB62175D51;
	Wed, 21 Aug 2024 20:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQKC52rP"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63529175D3A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724272111; cv=none; b=HtCdR1Kz3+DjbmVxmShmJ37GZaSt0MZJ7EIbo52aWplWLDRo8MMlrMfqJ2F/RGBjRjVHXJnVlJmHUGw86hYu5Eu0lOe840zDRZO75zf9OHibVpFWyB6dQIBCdLeJCE4i9WljL85yMD7KEPZgVQlKMVC4YuL2JKeoly2k1MO4UMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724272111; c=relaxed/simple;
	bh=oeoxgACaNUzhrPL77cacfT4mMaAviEmAdoRWE6VR9Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRwkkPcR5VVbKYvJicneqmckJOtiIm1kJZ9Fca8yNRWkAJHdb7MG/8AM4bxU4UT6nxCuucGTIqu12zFcEpwHBr2MnpPPgmzGuast7r0XvKRf8Fz+zMuE5XeirYwwZq5ODeEqB545jfL7hjKG7rTMKhRiAyci9Nl+g2V+scefqBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQKC52rP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20228008eebso82685ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724272110; x=1724876910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWXnhVui2nFYwSjIEsqfqovQFvySgCe73i8eTlEDVwA=;
        b=JQKC52rPvUHByEGBEM4jaVRl+6YpkkxCYuOB03TMdrqwyABucj7onS0hX8gHVhM0Qg
         loNPsB2mVf3o6YXllNxsaLBwwwgrrRYq8Z04RzXJH4/56eVos3wwamGoyRoLJTVcH8Ay
         kFrti1yffzvO2l10+R4Lq7TOFEaEityXoLCa8HEaxsJL6FqPpPWgrwWUTrFSYS4zlsse
         JQftsFcYpx7ECJ0NqLO5oDAd11GIeI7LumYPENrZcfYFHLj+SsI99rSZTDXJgtihEHrP
         srmtzLSAwWq9RiYfuFySPK5GmbwhV321tKXYFIALmJx9CVNpCPZ75H77EQR4fa2I6fjU
         6/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724272110; x=1724876910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWXnhVui2nFYwSjIEsqfqovQFvySgCe73i8eTlEDVwA=;
        b=v+IrHnkkh5UrwwNWxbuzwCPJAxWAx0wHhsGv7UKJQwiz7XARb/bSlvvvUFqnpqQsY+
         DWlBRB8DblVCy61vfzQ+46RSjdhjbCq8/6yNDJmtF7KakCr89CymJFlrcbpRLin3eih6
         NUBrvIOD6IDCSqKhtt8WjqB9CM4X2vk0Cqv8HzUw81+X+f/46Xbd88Xrv+8fcAPTLaWM
         aBsuDNTuFXwNCaC9fh0hGk4wC/WAvxV09UofDuTzp9GY4iimYFDNt62PrvVS0W0rft8t
         9/iN6/9IxMFo8OrNi7P0w8+W5hqueTSd7kPXhVvUJEW95KRrHRjG4mgkFbBMradYdKHk
         k7OQ==
X-Forwarded-Encrypted: i=1; AJvYcCX69oEEd6nkZvZBYPYj/BPUCQokwoGiFoPAMjeHS2J6qVkO9fC34usxS22lgohDr7/yGNu/xWBELJZSymU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfH55aHXe1t8U3WMAubKm5it7+bRJI6MCFqEZvP6PvwqiuOQFT
	IRXHaKq2r8wqYK1MWWB97tIRy16a/tX9kgvaDb4D6rvWpK1vNc+tB0FTNI8zmPVyiqrI3/Durmj
	1iDa9PEWe5Q3KkSeFNcIIzff1CjvuZg==
X-Google-Smtp-Source: AGHT+IGsvJQ6KGu9ogn//vAedYuxvsyPBtabUKbWujAuMr2pmxWCTY6LOcw3VsB+KWrDf+stA7PKf7eIrh8+UXN42fE=
X-Received: by 2002:a17:902:f541:b0:1fc:7180:f4af with SMTP id
 d9443c01a7336-20367bf70femr22338685ad.1.1724272109477; Wed, 21 Aug 2024
 13:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821064040.2292969-1-ruanjinjie@huawei.com> <20240821064040.2292969-6-ruanjinjie@huawei.com>
In-Reply-To: <20240821064040.2292969-6-ruanjinjie@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Aug 2024 16:28:18 -0400
Message-ID: <CADnq5_NfynxZHrAG8cAhmMmmdMT96kAEZCVB3Tw9jrwqS4rG7w@mail.gmail.com>
Subject: Re: [PATCH -next 5/5] drm/amd/display: Make dcn35_fpga_funcs static
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: chaitanya.dhere@amd.com, jun.lei@amd.com, harry.wentland@amd.com, 
	sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com, 
	christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com, 
	daniel@ffwll.ch, alex.hung@amd.com, aurabindo.pillai@amd.com, 
	colin.i.king@gmail.com, dillon.varone@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 2:33=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> The sparse tool complains as follows:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c:10=
71:22: warning:
>         symbol 'dcn35_fpga_funcs' was not declared. Should it be static?
>
> This symbol is not used outside of dcn35_clk_mgr.c, so marks it static.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c=
 b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
> index e2d906327e2e..818a9b0933a5 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
> @@ -1068,7 +1068,7 @@ static struct clk_mgr_funcs dcn35_funcs =3D {
>         .is_ips_supported =3D dcn35_is_ips_supported,
>  };
>
> -struct clk_mgr_funcs dcn35_fpga_funcs =3D {
> +static struct clk_mgr_funcs dcn35_fpga_funcs =3D {
>         .get_dp_ref_clk_frequency =3D dce12_get_dp_ref_freq_khz,
>         .update_clocks =3D dcn35_update_clocks_fpga,
>         .init_clocks =3D dcn35_init_clocks_fpga,

This structure is not used and could be removed.  Making it static
will create a warning.

Alex


> --
> 2.34.1
>

