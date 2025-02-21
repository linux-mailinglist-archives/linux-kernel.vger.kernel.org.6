Return-Path: <linux-kernel+bounces-526557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7893BA40035
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE03189A88B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C75250BF6;
	Fri, 21 Feb 2025 19:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QMZXmBsV"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC6325334F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740167945; cv=none; b=ptWGMCZXQKdfk5yTw3CuibHdFYaVJnh24ubiOtwsZcKgsZu8gcBESW/n/IqN9/Ys+4PPQFnsH4ITPJ/8Ee3Kg5gaZ3BZrsSY5JKPVc3WMjkfSoSuHlS/l6BkD522XnF6O0M/8WgFExxdbODbPdVoPC9934Ej0svG3eme7UHiSSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740167945; c=relaxed/simple;
	bh=qyLjB2yK6cLCrCuufMw+8ShdfCl1k1G8uj1YbUl6t4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTiNNEsIMlO7GfC1aysdV0/+jj/9VRk5qqHqxCfuTfmmFmrQxylniVQvFrwYDZjWWeGK9WBePZN7jOp6ICI8MmpHBVCBAIsJZ7RMvi3vq3Hl7jcpVpgdj7cpUbWdp6x6HaIgz6gonytY3oBKCURVwJUUcZvhqng8NEfWVfMXzcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QMZXmBsV; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54524740032so2609819e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740167940; x=1740772740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bnb83UtqsBWTiNAjltn4JLaoZM1hQGViXgrYc69juLI=;
        b=QMZXmBsVRVlWHnsgQ6iVcH7l+zqVE+TRFzvj+hhHyi/UHZHncoEliUUDYaGIY+9KGY
         NMTeAJrZR+ZxYwhI2wk8Kms9wo2+XRqcUfstyhIbNb33fAk/JKzAbOobV9bfhgsNIzfm
         SMmbTgj/oYupcxJvm3HcvCqw9PwMLQV3PEnb3tADri5U/asxemyEG+FR/wlkSYCsUTK0
         DG0kqHFnMNSwAxYedGrA1zwUspT4yH7rUWv9rgv75BC53WkaU+FrmthwF/eqALI34q/a
         dPxsL1HJ87XJJMSgZLNCOgjp2ql31CDB0B0BbUxuSr5/IyJRy6zccCPn7gRdHLT3t2/9
         UG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740167940; x=1740772740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnb83UtqsBWTiNAjltn4JLaoZM1hQGViXgrYc69juLI=;
        b=WuOG2J0sEOlUpuPfhTY4jGgoQszm8rtu5iwI5Crf+fzMqK2I66iJJEplmgjXON74Nl
         1q0FXJwBZ2rbtqS2SRLWZaXMDjsU/WgABDYj1QSxDnLiIHntQlZwykatQH7gtYGWFI3Z
         drm7m9UCqmP0a89aWQsXMRAe355VwRyXfV2JYv20t4xFkw1J/FZREmj5SoAEZbINBoZj
         eAitDdaVjQAaUJbBH42fFZO0YPoGNG0irOfyui0oP2axX0oT7E8a45pevmcPFOD0PtCA
         lQoSyYHy76KlA94fG7Al9kNf3U92UjhHWC+gqnl50lCXLpoUzDX0UGxZeiqvdB3d+Ewg
         a+ow==
X-Forwarded-Encrypted: i=1; AJvYcCWvLzhidZt2ddgvhH0NTbyopAy9qQgcoInunBwIGq4ToVMZmc60AoYPItxETsENVAeo0BqTknQ1ZPyhhmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRk4F3t67j2U2MeNryzGW/PKQI9EU+rlzVjLbxX/VyWpIGQJzT
	/nVdHgU6c+jPxpS+8FgJzHVAlIdWVwewO2g5Mrb65Woxa1pTmu4iWtmqEOIjEGo=
X-Gm-Gg: ASbGncsBcsHHyOwmln7PJDkPXE0KYUwkru/zt9jr23+NxdUwPhr7+fwKvmTJhVPytQ9
	+Y89kNjkV6Y6Np5Yy7rlAwyp0mJmEQYJjeCMyWrJDXxaGXE4+POnXbcN/eEZEdfWhMS4I36LmIE
	cd3LjUYx9fVUZ17WWxr+eKiemCBJvThOTBR+Y1dmrBNSHZhEdSBnTozpSg5CG9l0gPQRiTfkBZV
	4ZVOpv0DxJw4wrVDjeBB3z2fhZsrxdadsp5tpgsuTdqMLYRDzvaVtl6zPM2CpWRkxNMHRKtMyCT
	Koc1qZLk8SFo4S4p7kwmSbEb9Ga0NeCqwxjtXfA3yY9mBSRR7aS1i9MVj5tvAphMoNx12wjkWT/
	Del/jZw==
X-Google-Smtp-Source: AGHT+IFrckxDnWKfgAPPHmHclcGmNelQ44VvTcHTs9NzEDZAkR9Zx5tMSuT7N+Xy/eOAfbNq+ITXqw==
X-Received: by 2002:a05:6512:3183:b0:545:10eb:1ab2 with SMTP id 2adb3069b0e04-54838f5a39dmr2406233e87.33.1740167939939;
        Fri, 21 Feb 2025 11:58:59 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54530a91179sm2128132e87.33.2025.02.21.11.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 11:58:59 -0800 (PST)
Date: Fri, 21 Feb 2025 21:58:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@redhat.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	Johan Hovold <johan+linaro@kernel.org>, Imre Deak <imre.deak@intel.com>
Subject: Re: [PATCH v5 0/4] drm/dp: Rework LTTPR transparent mode handling
 and add support to msm driver
Message-ID: <frsbcvxcvtp45mh45cld3rzbgl52gomzmzs73crv53pwbc4fns@sygnt6z2avht>
References: <20250203-drm-dp-msm-add-lttpr-transparent-mode-set-v5-0-c865d0e56d6e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203-drm-dp-msm-add-lttpr-transparent-mode-set-v5-0-c865d0e56d6e@linaro.org>

On Mon, Feb 03, 2025 at 12:57:55PM +0200, Abel Vesa wrote:
> Looking at both i915 and nouveau DP drivers, both are setting the first
> LTTPR (if found) in transparent mode first and then in non-transparent
> mode, just like the DP v2.0 specification mentions in section 3.6.6.1.
> 
> Being part of the standard, setting the LTTPR in a specific operation mode
> can be easily moved in the generic framework. So do that by adding a new
> helper.
> 
> Then, the msm DP driver is lacking any kind of support for LTTPR handling,
> so add it by reading the LTTPR caps for figuring out the number of LTTPRs
> found on plug detect and then do exactly what the i915 and nouveau drivers
> do with respect to toggling through operating modes, just like the
> up-mentioned section from DP spec describes.
> 
> At some point, link training per sub-segment will probably be needed, but
> for now, toggling the operating modes seems to be enough at least for the
> X Elite-based platforms that this patchset has been tested on.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

[...]
> 
> ---
> Abel Vesa (4):
>       drm/dp: Add helper to set LTTPRs in transparent mode
>       drm/nouveau/dp: Use the generic helper to control LTTPR transparent mode
>       drm/i915/dp: Use the generic helper to control LTTPR transparent mode

Lyude, Jani, what would be your preferred way of merging these patches?
Would you ack merging of those through drm-misc or would you prefer for
the first patch only to be landed to drm-misc, which you can then pull
into nouveau and i915 trees.

>       drm/msm/dp: Add support for LTTPR handling
> 
>  drivers/gpu/drm/display/drm_dp_helper.c            | 61 ++++++++++++++++++++++
>  .../gpu/drm/i915/display/intel_dp_link_training.c  | 24 ++-------
>  drivers/gpu/drm/msm/dp/dp_display.c                | 15 ++++++
>  drivers/gpu/drm/nouveau/nouveau_dp.c               | 17 +-----
>  include/drm/display/drm_dp_helper.h                |  2 +
>  5 files changed, 85 insertions(+), 34 deletions(-)
> ---
> base-commit: 00f3246adeeacbda0bd0b303604e46eb59c32e6e
> change-id: 20241031-drm-dp-msm-add-lttpr-transparent-mode-set-136cd5bfde07
> 
> Best regards,
> -- 
> Abel Vesa <abel.vesa@linaro.org>
> 

-- 
With best wishes
Dmitry

