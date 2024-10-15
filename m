Return-Path: <linux-kernel+bounces-365805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0276C99EA2B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB095288517
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8BB1C07E4;
	Tue, 15 Oct 2024 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xL26zUle"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE071C07C5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996165; cv=none; b=n4pgeCzMnfiSaqhCbLr/DOea/oem+AZDftREWxsus5TifTu4DIvZV3JuxYfPKtTXELBqFVfkOahHOQJ1K9iSU1d3N3hyO3Zw1zbjeQvYR/xx4o7pgQ5+pvJtq1vPjf3YZGufRVm2av6PWL8+jGw269r187B54Lc4VKggd5JNtUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996165; c=relaxed/simple;
	bh=zOINycgOQdCuFElhvq0QEyzwnLQ9174DgFq28FKNf+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7MyCEUX+8ebKSmVGVbPcoBcpVuah8Rk1OdOUZ+OFvT7W/FU6O8rKwuz0GVKorAu7dJo11QmFK/qo/yUFMmCNQtY3GaZymrAszNJgIuWaCGua0+gxCeKWSVtkSabSikDZiil27gH+KHXea1ZD/QfMi7oLlsH2M3TW6hpbQ0FyiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xL26zUle; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb5740a03bso17548751fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728996161; x=1729600961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XHzRYFNnfJVncBBpgR8dVgaov8GBCzN7kXiTdUtfWag=;
        b=xL26zUlewkcDE+OEGwVwo2yK3mecZftGg/7/1clK1QEfNFR/dFH0i6+Xt2xb4GRNIk
         VH2/wIBOA98/ueCs4x/DFDfoSRB5hIcReIMWqz/e/0UscMXGuJ+DSf70P9TPhq81yAXk
         9kczoWMDBl+d1o6LQSeugDOgv0doywQlUTTuIYK/h5fqWK7L6ItdbTPJw+p5Wfm9qlYb
         m7GAuCh5aTnBtRviULH0hpiIBmPV636xOpGLQb3oxHJWeCAfJNt3R9F30QiGEC/t1rp7
         5j1FYLAhPF8yFwaOPJqJYXPPj7useMJwalyHhSOywrVEPp6ICjxRvjfCGk23+tgHIY8Q
         urvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728996161; x=1729600961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHzRYFNnfJVncBBpgR8dVgaov8GBCzN7kXiTdUtfWag=;
        b=neIspdDK+XPQA+fIQACCBI0ZkvOYOdNUNtJv/xDcBxitGC9hDTQ77qgfzOgjtgjBj/
         G2n4uFzlOZqP8lrVnNpzyH4nmzbfxd73O0j0UYLel7PHyKEsrcoIrQrKOy/Wl5Dw9e+w
         yu1+1qcKCzjIr5cWCbu10aHICxAr7b3BTJST7oYk025Apzwiie5dFOeztEk+AzE8imGl
         aFsrBX2bROCGilRj40X+c3E8OSReN2nXgyZPrW2CjZkIn53+k2CeZjRg3xa9jvDv3h74
         5JDdVcPngZvzfMFIpZsTrFc6Otgmaf01NOJpLIuHhP0Oep8FBHBzYBCjF/wZT5e9dgQg
         S3iw==
X-Forwarded-Encrypted: i=1; AJvYcCWXfGQPKkkggfLo+zUx0Q0VhyynSv866F6bWK/TpBbQOEaa70ZDvS7BamNV8PHPguna2Bbz2cR6WjgJSgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyybdU+QiIt4HCQ38ExkmMwFDE3AAxRqc8jD86RM2yWAQ7jh+z5
	EkMfBTO0MQFeO6BiAPoUZ9zSvkoTG5Z3QOvEdh0Yme1H+RWweJtf8crIhsvZTrk=
X-Google-Smtp-Source: AGHT+IEV43mu0PNLzC2rOlLLQ1oDj5meAK/97CNJwbn6N2i56zKqE1Z4tFDL+BwSeHdxi9g6tO9F6g==
X-Received: by 2002:a2e:bea2:0:b0:2fb:4a63:92c0 with SMTP id 38308e7fff4ca-2fb4a63cf63mr33684261fa.14.1728996161537;
        Tue, 15 Oct 2024 05:42:41 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb5d135901sm1409991fa.66.2024.10.15.05.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 05:42:40 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:42:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, quic_abhinavk@quicinc.com, Rob Clark <robdclark@chromium.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dpu: don't always activate merge_3d block
Message-ID: <mfmupuz3nksvkujqu55xo6bpa2wkzzlfz4frdayspgkdkmeedr@mjh2yq7qs33y>
References: <20241011-merge3d-fix-v2-1-2082470f573c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011-merge3d-fix-v2-1-2082470f573c@quicinc.com>

On Fri, Oct 11, 2024 at 10:25:13AM -0700, Jessica Zhang wrote:
> Only enable the merge_3d block for the video phys encoder when the 3d
> blend mode is not *_NONE since there is no need to activate the merge_3d
> block for cases where merge_3d is not needed.
> 
> Fixes: 3e79527a33a8 ("drm/msm/dpu: enable merge_3d support on sm8150/sm8250")
> Suggested-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
> Changes in v2:
> - Added more detailed commit message
> - Link to v1: https://lore.kernel.org/r/20241009-merge3d-fix-v1-1-0d0b6f5c244e@quicinc.com
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

