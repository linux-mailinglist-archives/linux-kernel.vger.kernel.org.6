Return-Path: <linux-kernel+bounces-311735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DD1968CEB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE5C2854FD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C844A1C62BA;
	Mon,  2 Sep 2024 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6cQZiqa"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22381CB508;
	Mon,  2 Sep 2024 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725298904; cv=none; b=byW6M8RSdf+eJ2Rjwg37jOzz20bPGjg9jy6HFcI6QPt/RWXc1IxIqh/vVP9A0r0G+8C78vW0WQKXu1ukJqrdchWwWMQ6OWnm35R0kFQTvZ7zgFn2qSHxtr0SMCkvQqZUizshS25Xw/dqsrnC6ETjWxPZrkBVyHiSlZY5sdEJdmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725298904; c=relaxed/simple;
	bh=+yq+2739O6Ht/F2E5lU+5ItgxhwlrFgrtAYcefbippw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O902yzoKkFmbMjLL7gjRyT78/Wt4uXsjP5dv+0IJSEw5nmSffAS0NMfdmQfnkNeLfLMpuD+sdJpX9pdN+r42A06tpahy8KMxSiSb3/j9R0CXVNkCviR2CGDNZfXjqIR0YAw9bY115dFBEbTdBcF4xKIS6N3IQMxtvppweEXSuvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6cQZiqa; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7c3d415f85eso553856a12.0;
        Mon, 02 Sep 2024 10:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725298901; x=1725903701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+wNgYxU7oLzYD3y0Bt7MyKXymsVh78qZSxkiBUsM4A=;
        b=l6cQZiqaNZsawj7ByjF1h083ZtHpDinKJmvWxeQNXDrAFQmQEkTpgeMEKnX2xRaAUe
         bc8PXRmjDhb0pJgh3F9xxYsPES3NF4m1dHEN72RRTtasdcXcnjNPcpwBkePxJf3gkxLk
         lmy6TVfEaX2uJDBPnch/gEVAT0mACLKaVdgl9LUz1MrPBAf8mOqMM0dLaAIginZxF/0S
         61L9Cr0z2uFJnLvpAW/lI73/ae/+F9auZnvOQFPyZcuHw8t/pLzcS/tQonohpreCdpmG
         hKwX/Q1D56lcLnN5v83oVmZ1Pw+UVgJF/TZuU+g2wrQIFACCo1pDYkuBkgWb06dW7pXZ
         fZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725298901; x=1725903701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+wNgYxU7oLzYD3y0Bt7MyKXymsVh78qZSxkiBUsM4A=;
        b=q0qrZVdqA01lkhz40bifnykIML7uJN7ULtUIK22etCXK3kPII1e95NjF8kKgUkkBui
         T+X4r6cLY7J+6oiXNLRSWjzXMPk4JO2r5asp5gWPTX1fUEJ9FR/iFCWWeINuUInuCydG
         /xxjMN/Yaa28HMu3n/NhGdLZPbknSc+B9L0dDXuICxVW2FPHjlpc/RyMqAJQVkQzfERB
         F5sHKDaId03S7R72ztkOqmDbU39dIRke+uxcXHD5ZnxxynShmKJ5Do0M7y6fNgY7J8aH
         +7Zdud3RmJaIlvKtniW4brQrvgV+Bj/AN83XYr9ItO7XUvJztza6Gg0YySutzjHCZXbW
         UVBA==
X-Forwarded-Encrypted: i=1; AJvYcCUWwdOiyIm9AoGOygjj6BxDgOkL7UvWSZwKgMrnt8eQ3Xlz3i793PpTaAliHh4r6Dhzi+5hcKdyhVk6Ltmw@vger.kernel.org, AJvYcCWb6jHfe5fNv5cWi18QvxjuFjPWy/9oR+yIMjnWQLVtkalJLILFP8Ki5OPHLREpGec5/Z5zsgtFdhKVgefEqGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIK3zhDxsbcyEuGXbwQKB6pI/vqK6V4uyFtCESsfvM13NyB4Nl
	8Niv2+hbD2KQuVVPEV1aejZO8VrCDAIAUHQDleqW3Zpwitb1kOX1c7wlWXIZpfDm+elga1WKw50
	WE42xJZdbDs5asQ8m6rZUcdFNXrA=
X-Google-Smtp-Source: AGHT+IGkg12Pi/6mf66io9D4Xdsd85fJlC6soRLCamM5arxcv6bY2hHX75vh/HfsgiJ/ZJ20leY3s+4dgW2u7NweAM8=
X-Received: by 2002:a17:903:2346:b0:205:938b:f387 with SMTP id
 d9443c01a7336-205938bf846mr10502095ad.8.1725298901041; Mon, 02 Sep 2024
 10:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828093250.271358-1-colin.i.king@gmail.com>
In-Reply-To: <20240828093250.271358-1-colin.i.king@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Sep 2024 13:41:29 -0400
Message-ID: <CADnq5_MJYokqxKs+TJz5-ut-Gsy_SxP79g9Xr-hQxkJAb-86yA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: Fix spelling mistake "recompte" -> "recompute"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Wed, Aug 28, 2024 at 5:43=E2=80=AFAM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> There is a spelling mistake in a DRM_DEBUG_DRIVER message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 0859a7173a06..669fd8fb6c24 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -1325,7 +1325,7 @@ static bool is_dsc_need_re_compute(
>                 if (new_crtc_state->enable && new_crtc_state->active) {
>                         if (new_crtc_state->mode_changed || new_crtc_stat=
e->active_changed ||
>                                         new_crtc_state->connectors_change=
d) {
> -                               DRM_DEBUG_DRIVER("%s:%d MST_DSC dsc recom=
pte required."
> +                               DRM_DEBUG_DRIVER("%s:%d MST_DSC dsc recom=
pute required."
>                                                  "stream 0x%p in new dc_s=
tate\n",
>                                                  __func__, __LINE__, stre=
am);
>                                 is_dsc_need_re_compute =3D true;
> --
> 2.39.2
>

