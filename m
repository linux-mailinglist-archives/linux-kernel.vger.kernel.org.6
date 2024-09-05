Return-Path: <linux-kernel+bounces-316271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F48A96CD5D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3956DB247F6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C576C155C9A;
	Thu,  5 Sep 2024 03:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vc1i/6aN"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C150D14A4F5
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725507228; cv=none; b=sGHe3M/z3sZ0gc/6mBdq2WRB3R8+qmPQFd++Rw0MwyyEq3JcslxQXvDUesJ8rzer5PJJKySZb2ew8RuvkiVLCa4T4kncKVAFK4gFNLAB70/s4gldPEOQqS+56nU4qfr/B63wYd9SIm021e6GzCUpw5V1C/snyHdTwFfYVzuiYuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725507228; c=relaxed/simple;
	bh=WXwWdAN2CjuwBCuWeEweH6BIa47rfL9ZR0rsCYG9S7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwp4gIPPOo52+DeHv0JmBBO9sOQYso5IMbZbQOk6TevNNr1YCrdoUcUkxjqgCpSMliyMci0llMMaYwfYIWktzoNi7twq+HScIBqRUwlJ/GeVpz2rX23Ydzb0+EyQXfOhuVDfWF4VKPds86t/Fc35iAd6Cr6zAENEgOG5HDyN4ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vc1i/6aN; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5356bb55224so260164e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 20:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725507225; x=1726112025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyUpvOqb1HnLAQIbraYek0wvreZFpF6ISG16EWHJbNQ=;
        b=Vc1i/6aN0YNl6j2UAWO9TSPvohyORCN/cTWPZRCQQb7qUm5U1Gop2kgWy8KOrTOegO
         LUXQL6VpmSaMHaCwcoxDWT3buaLztjzmd5tOmGMr6rkINV/REVVgyXeCpDR5baTdQGsm
         uz+fqPUc60daz5Zzik0aK+nQSfYdyRNp7lvNpCbodRMOc7uuBp6kyth5wPwJIK1/FJJO
         Kc/0TioZJcAD8o/i2dUn77bsyVnPFYCaJzHKgsj15Qdo5VvyAjEvexYDO/zsxnxaMNkU
         V23jnleXHfnUhlrsvdTIuVTHDtMj1NUox+0PbV+BsHoy3YQMmcj098QgWUxq1Jeo1MHx
         dobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725507225; x=1726112025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyUpvOqb1HnLAQIbraYek0wvreZFpF6ISG16EWHJbNQ=;
        b=u76m9fy/47GUssL2YMw6b2eBvTqjzgdRwpEGwMs0DuCR3zJ4vXrMSoC237NaZm4s5B
         txsi+OgTUvDnrHNTVq2mqUEtnAKhBSkqBMgk7Up3bcX+4XySPaepLsLQ7S9milLPNTIV
         oQKtosAkdHup0YShubExON0zgANDrLKBCPlvBLXTuKcjprYZQsGPQikbYrhaxeGbJdKm
         baVcaRAEYr19bEZXGpJIkSnMdYs7FecR54Yog0eSHNAZ+K8mdXsvAXdHRZp4zyi/tLMe
         GHS0NG4Ebcy1vb9kGvtkz8y+JLkJPPq61gKhB3R6zcoIx4c/V/JyFtxXg0q/Jo5dyZCY
         BweA==
X-Forwarded-Encrypted: i=1; AJvYcCXJcr4LseTJXjbXSgl+ye+QHlGDf3IOGnEpm1UzDNIMNcLMZNHL2F6Uggrbv+6mvckxLW9taBbNriOU9hQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8+cAkBlsYdpiyWHtmSmoFLAHVm+ZD1/xAZkeIJ8JtPlGpZIOK
	jf/B0Momx32tqlK3k1F4G2VR3EMKW9UiLhs31PzHfSpNqbnffNwjZV7c+lpBa54=
X-Google-Smtp-Source: AGHT+IGL24J8npgJaD6qdH/iBLmRVEB4YeGZTdlYLtr6yfSabcuuW1+0DO4dioT58qUKhW1Yg6Av3g==
X-Received: by 2002:a05:6512:4014:b0:530:daeb:c1d4 with SMTP id 2adb3069b0e04-53546b1920fmr12600653e87.12.1725507224725;
        Wed, 04 Sep 2024 20:33:44 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53565f6d409sm389165e87.35.2024.09.04.20.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 20:33:43 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: robdclark@gmail.com,
	quic_abhinavk@quicinc.com,
	sean@poorly.run,
	marijn.suijten@somainline.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	ruanjinjie@huawei.com,
	Sherry Yang <sherry.yang@oracle.com>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] drm/msm: fix %s null argument error
Date: Thu,  5 Sep 2024 06:33:38 +0300
Message-Id: <172550712137.3299484.13467941827572106122.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240827165337.1075904-1-sherry.yang@oracle.com>
References: <20240827165337.1075904-1-sherry.yang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 27 Aug 2024 09:53:37 -0700, Sherry Yang wrote:
> The following build error was triggered because of NULL string argument:
> 
> BUILDSTDERR: drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c: In function 'mdp5_smp_dump':
> BUILDSTDERR: drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c:352:51: error: '%s' directive argument is null [-Werror=format-overflow=]
> BUILDSTDERR:   352 |                         drm_printf(p, "%s:%d\t%d\t%s\n",
> BUILDSTDERR:       |                                                   ^~
> BUILDSTDERR: drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c:352:51: error: '%s' directive argument is null [-Werror=format-overflow=]
> 
> [...]

Applied, thanks!

[1/1] drm/msm: fix %s null argument error
      https://gitlab.freedesktop.org/lumag/msm/-/commit/25b85075150f

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

