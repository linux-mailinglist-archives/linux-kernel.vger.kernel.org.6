Return-Path: <linux-kernel+bounces-418080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E63A9D5CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97FE2815F7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFE61D7996;
	Fri, 22 Nov 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w8BcMaUf"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E971BC094
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732269823; cv=none; b=Be88MGujJ5FLEXF6fM+lDKqj1Y5taDOeCf0I0fUf/mOmYev1A1Bxu8KM8dZwigDQ1wPeQv23VrJRPXVNacUATnZxjjbnsMizTxp6zOGlRYBS1F9H1+gHdAEdZo1gJYkjiWRramHVdt/uu3gDhSf5Pyy0v3/c3gOFmxU6npQVIL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732269823; c=relaxed/simple;
	bh=hOOE3Hpd3X+IfgD1920kuhEgIKOhGUmIcwAdHX0dcPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfZ2eNJgaTju2+ALCX7dZGcY86w04s5FCSW1EPakem0v9vFYM05z/wpIYU3EccaRrW9USsUVdnQRVE3hmPfaUZb9n1xGSk7cvg4KETlZixYpD9rYTUmfeY9brKAcHexc7Ul/Up0DjpWxiskrvADwLS/6ZNbcZMJYIsnSaknkXpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w8BcMaUf; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539eb97f26aso2203389e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 02:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732269819; x=1732874619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZLT8I4KDbe++vNVuiTZLA4WW9vKk6hhxnM+ns9I/LY=;
        b=w8BcMaUfM9AspQc5qieoz9+IGahqzG69zCWPJdHU3Dw1/m9+79oVCQFsMQtLizX0XA
         Mn6uVoJlIts7CknWpYAyM+TU71JSXDOQEsoFHcfvlPXZAO/+6JXXrN6a70jDK/bm9TXO
         8H1j4eoSIyZIGvsBCT4zq7EluENTrQ26KbKN55xXNFQ/mBvOQKA25bjrN623fc5ItEDB
         CrkjJj6kKwZCX/ryGDO3OtE7jIK9vjSbvxdO3YAVoPP7/sMw6GR6tCqjaYGQ3/xC1qfa
         qpbSLJTncQExP+rbdq6gWOV2rXB4NscMdxKeCqR4OoO1IwGEqdc74ZYh32YTFDszeqEW
         DmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732269819; x=1732874619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZLT8I4KDbe++vNVuiTZLA4WW9vKk6hhxnM+ns9I/LY=;
        b=jEWMJdzjoC6DydMyWSD2TCqicfjhwAV6bz5Sp0h3IASzyfFHK+Ko6gFkOzAooVFkkS
         /t7q3gJG4NYhzWUSxk0oP04j3syQq6pQybB+WdNwupx3dIH+UM/xKtTtmWaSnIwPk5Ue
         ZPcLa5beQNaOIBoeRFz2cg07GjuGA2CNnigvobwWQ0OzOJbma4rFvv6jZVNjiN5/eHbC
         zRbs9DNf19yNqaxugStrnHY/k0atUQScponDAafIBe1igt81yreOzx3/F+3a5cMNLdGP
         SYGQkIbCsOzJQacaXax4cJW69wM4DJQxL5c7OLCuwOr8EUe2uYMkFmLOqNsihnAVvpme
         j/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWTVJjWu6ATiTFNuywuEr/XRsOuA2Z8mnCPNynKP303AFwCGIhP6f/qx+ukbKJY0pLNftiwC0JFENV1Vs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbc4PsFVjWt0sJM7koU5I8qMyayhMZspergLngRP1kMbwCZnWT
	Bq2NUNY3s/2X4fyWIM1BBzCPtLTsmZnV64u+gL9gei2VDPu1d/TSZipy+5zdwNw=
X-Gm-Gg: ASbGncs0bAImyTqLxxP4Si8wauOKaMtNIM1dwdA7qwsBLKUL4BCXsrEtMUlUaL4xEWd
	6AtuwPrSaS6TuvEGz/QyZP/kcqzG79rSvCugNoTpPDnDX7bf9zRBGz9nNSNpCCAcF2FHGAm6DCG
	8oLbzX1m6gh9Efh9sH3SBO7w/Q33YwlbhFZI/ArI0cseb7oj9YAhkV0y7Whs4F8XFcepaDmfbcX
	I15M4aX2rwhCiKhWdFMvYVOSW5vDId5WaYbKoEZQJEK7g4JGKMz9tyb9aFiPCN5mz4coO3dqiOV
	L9JhIL8jBOvzj1uGrwmJjPW399y5cw==
X-Google-Smtp-Source: AGHT+IE3PHq2qPNqY+QbYoKQGe6R086mqzI0wJSLMJ+g6h7CmPQMNZmjuqoEun+JNczYZAXDctuzeg==
X-Received: by 2002:a05:6512:2311:b0:539:ee0a:4f8f with SMTP id 2adb3069b0e04-53dd39b2dbemr1081114e87.44.1732269818813;
        Fri, 22 Nov 2024 02:03:38 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd24517e8sm318249e87.91.2024.11.22.02.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 02:03:37 -0800 (PST)
Date: Fri, 22 Nov 2024 12:03:33 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Fange Zhang <quic_fangez@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Li Liu <quic_lliu6@quicinc.com>, 
	Xiangxu Yin <quic_xiangxuy@quicinc.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/9] drm/msm: mdss: Add SM6150 support
Message-ID: <jquwvnj7s3n5ki63ooz52ys3cbenuedr7mkrdkdujrnza3ewa7@i4y2uhy63yvq>
References: <20241122-add-display-support-for-qcs615-platform-v3-0-35252e3a51fe@quicinc.com>
 <20241122-add-display-support-for-qcs615-platform-v3-4-35252e3a51fe@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122-add-display-support-for-qcs615-platform-v3-4-35252e3a51fe@quicinc.com>

On Fri, Nov 22, 2024 at 05:56:47PM +0800, Fange Zhang wrote:
> From: Li Liu <quic_lliu6@quicinc.com>
> 
> Add support for MDSS on SM6150.
> 
> Signed-off-by: Li Liu <quic_lliu6@quicinc.com>
> Signed-off-by: Fange Zhang <quic_fangez@quicinc.com>
> ---
>  drivers/gpu/drm/msm/msm_mdss.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

