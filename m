Return-Path: <linux-kernel+bounces-526641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D2CA40177
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE81C7AB29C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A35253B6E;
	Fri, 21 Feb 2025 20:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLzGMWHk"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462A7253338;
	Fri, 21 Feb 2025 20:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171401; cv=none; b=j9aChte5sD5t2qGu6FXEStatLpeZ9/UzxdTFSuefjwNM6AqEHoMpkKqjZKYx3HKkzmQUFdho2uZve5RRxd0EwUUG3E0VNNnk4M+HRkaTVXPYKQToenVrwCT3ViqkAO3kMZBO1V0EJUJxgr5gb3RO52v899Cv+GYHjVY67VQxfVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171401; c=relaxed/simple;
	bh=kPABSk89z0t89xDH5ilBsjLyOpR7/0y0TwjsL3wzqGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUTTDirzN3RrX1ZeYs9wEJGBRHQ/MtTsUNLWNEzaDKNRPJQGzlvCeCZKVJ1BgFEMWtj30QUP+2eu4Wp1wO4rD1Vhcygh2lxgGQoyOMM4uqN8AJGF59jA+l9Y1vCpkTosqEvfMxzMIYMacy6nDwv207OaQvAVgtLOBVTWtncBQyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLzGMWHk; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fc317ea4b3so650624a91.3;
        Fri, 21 Feb 2025 12:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740171399; x=1740776199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTZj1VfgXuSxDSAhZ5TKDIe0iQGufaJMlCuZk2vxFBY=;
        b=TLzGMWHk66lBODgmVJG7llyepLtXBZDn9mxskm+AoSexBwWlXiT6h9BHr6AglAUgk1
         gQaZRweUnkyFHDQ/uyaa1TUxQbUSZfBlR4oZLDA/uAOQi2a3Cnl9mfN5Hiv7zs3WuYTu
         QxHNish6b2/fgfkDvJGp9z7wpr7Y6jMe5kVyhqNgqU8Lyu8gfsA/Tv2mjkfMBBBrDs1+
         sJVO15oUpd7MBlfbreoIyovhgCB5EeYN0f+fwwEjSg+LLd8STGmFtUhIc/bbZHQAx2nl
         gC0u++dn+dIAo6X/Fc3qhmdFoVTpWMe4dXC0H+lOfEt6/bosAxGtjAVs6qLeIeTTWWR/
         jHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740171399; x=1740776199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTZj1VfgXuSxDSAhZ5TKDIe0iQGufaJMlCuZk2vxFBY=;
        b=hDnuYjwp0tgVzbJyPEccFEzW5fT9eFaLf6XpqtQcdrPROTXv118uIp1BfefNjhx7lk
         TIySY8gvgi6TWAhMGcDRMrRpscZmaPCn7I9xGIYURzyAg4fW/+drY+0ad5pPlt7ZNh95
         vDxTEbNUcBjdnPkIVYEbD0RESKzmt0geyUPBqDDxLMKCjNAuZHEWiTr6R9AmgGUJSnP4
         nDLRAJSlOJk/+mdP+vNVe0MBzP+4z3ruCSh75utDIm8LIXj2Bs3MQMSLkNCj8OvsZD7r
         2Nek8YarNg9AFmnKWM7NxJc2PXo6SgucKXq3CLohvWqKbcyOUWNSg0D3YV9MvS5f51nE
         VSaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWompNIbRGJNqe/hzpRKO/cT/lpGQBTqzEOjtlBNj0p9mOXTTQLFTv6EtXPIlHlTmFIkDI5XL5bx7syKFp0@vger.kernel.org, AJvYcCXVjxAbzSLHZxe4OZrQV66q5i+7GN4KHKsLxj/AYR1FYAWefGF2y6dBeWzrDCCRmkAh2uoR+9eDZKq3hWFgea0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXVgejcbzRPyrGRuSaq1SeHsJrjoPZV2CJ6txFgD/wwUw4BFEL
	DigRws99iT7InFg/p6V0Z2RSK6R/ZGhdX/C+K9b0uEGmQp4f/txAnQ9MG9ECgtfC+W6hlkYrnMm
	VeTFUvHJSyOCxKmDdM0VgQc0jYx8=
X-Gm-Gg: ASbGncsp7HkL5ZGoa1uXHX0BOAoMJF7o4Au40Os05i/EjCoSgvuhgKB1tq6wzpnEMZR
	ymGHl0SCsiJQRswrSa+42DGMWZa48LLAXAVulL6Z72KrC7UwlsgL9FPUW/BAuP8y9wuS2lx46KU
	rVn+Mn2ss=
X-Google-Smtp-Source: AGHT+IFM/J8ccLUv6pCWoCHFq6aIfv3z+UGD1zIf76O88EjqTbIyqqsctg0qW8JzGFkwIsg0BzVkO6VURoA+T3MG9O8=
X-Received: by 2002:a17:90b:3a81:b0:2ee:b665:12ce with SMTP id
 98e67ed59e1d1-2fce789cc70mr2888192a91.1.1740171399575; Fri, 21 Feb 2025
 12:56:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217095325.392152-1-colin.i.king@gmail.com>
In-Reply-To: <20250217095325.392152-1-colin.i.king@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Feb 2025 15:56:27 -0500
X-Gm-Features: AWEUYZlGjjBQHXFe4kVYYoLXSOdkH8QC_8D4sDFG32SyXzn4R5IkXpUkq-hRSHg
Message-ID: <CADnq5_MPcshUk9uYqZ9eroJ8Pcbdr_ymqnaHeGYQf-VuVseDEg@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: Fix spelling mistake "oustanding"
 -> "outstanding"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Jun Lei <jun.lei@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Mon, Feb 17, 2025 at 5:48=E2=80=AFAM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> There is a spelling mistake in max_oustanding_when_urgent_expected,
> fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  .../dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c      | 6 +++---
>  .../dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h    | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2=
_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_cor=
e/dml2_core_dcn4_calcs.c
> index 87e53f59cb9f..243d02050e01 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_d=
cn4_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_d=
cn4_calcs.c
> @@ -5058,7 +5058,7 @@ static void CalculateExtraLatency(
>         double HostVMInefficiencyFactorPrefetch,
>         unsigned int HostVMMinPageSize,
>         enum dml2_qos_param_type qos_type,
> -       bool max_oustanding_when_urgent_expected,
> +       bool max_outstanding_when_urgent_expected,
>         unsigned int max_outstanding_requests,
>         unsigned int request_size_bytes_luma[],
>         unsigned int request_size_bytes_chroma[],
> @@ -5106,7 +5106,7 @@ static void CalculateExtraLatency(
>         if (qos_type =3D=3D dml2_qos_param_type_dcn4x) {
>                 *ExtraLatency_sr =3D dchub_arb_to_ret_delay / DCFCLK;
>                 *ExtraLatency =3D *ExtraLatency_sr;
> -               if (max_oustanding_when_urgent_expected)
> +               if (max_outstanding_when_urgent_expected)
>                         *ExtraLatency =3D *ExtraLatency + (ROBBufferSizeI=
nKByte * 1024 - max_outstanding_requests * max_request_size_bytes) / Return=
BW;
>         } else {
>                 *ExtraLatency_sr =3D dchub_arb_to_ret_delay / DCFCLK + Ro=
undTripPingLatencyCycles / FabricClock + ReorderingBytes / ReturnBW;
> @@ -5121,7 +5121,7 @@ static void CalculateExtraLatency(
>         dml2_printf("DML::%s: qos_type=3D%u\n", __func__, qos_type);
>         dml2_printf("DML::%s: hostvm_mode=3D%u\n", __func__, hostvm_mode)=
;
>         dml2_printf("DML::%s: Tex_trips=3D%u\n", __func__, Tex_trips);
> -       dml2_printf("DML::%s: max_oustanding_when_urgent_expected=3D%u\n"=
, __func__, max_oustanding_when_urgent_expected);
> +       dml2_printf("DML::%s: max_outstanding_when_urgent_expected=3D%u\n=
", __func__, max_outstanding_when_urgent_expected);
>         dml2_printf("DML::%s: FabricClock=3D%f\n", __func__, FabricClock)=
;
>         dml2_printf("DML::%s: DCFCLK=3D%f\n", __func__, DCFCLK);
>         dml2_printf("DML::%s: ReturnBW=3D%f\n", __func__, ReturnBW);
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2=
_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_c=
ore/dml2_core_shared_types.h
> index dfe54112a9c6..4e502f0a6d20 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_s=
hared_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_s=
hared_types.h
> @@ -1571,7 +1571,7 @@ struct dml2_core_calcs_CalculateWatermarksMALLUseAn=
dDRAMSpeedChangeSupport_param
>         unsigned int *DSTYAfterScaler;
>         bool UnboundedRequestEnabled;
>         unsigned int CompressedBufferSizeInkByte;
> -       bool max_oustanding_when_urgent_expected;
> +       bool max_outstanding_when_urgent_expected;
>         unsigned int max_outstanding_requests;
>         unsigned int max_request_size_bytes;
>         unsigned int *meta_row_height_l;
> --
> 2.47.2
>

