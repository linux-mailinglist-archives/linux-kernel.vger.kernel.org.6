Return-Path: <linux-kernel+bounces-531224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F53A43DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D62171A50
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEFF78F5F;
	Tue, 25 Feb 2025 11:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mKQL5vi4"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A5F4C80
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483479; cv=none; b=opKva25HmdlCoPreCq4ozVpuNOVDWxkTI/YxjJCGnglSzv2pGd4/+0vSq3W2zrUu1+a/f14yvHBV5xukHYyxObdnPiUcgvLRocXLdFi28CUqGpct+cOpAiOZNXOIDEU7unIg3DWOvqaoQbfm2p2guLADdAeIdwLvROtWCTIabqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483479; c=relaxed/simple;
	bh=yt2R0RS1TqSbKw/Jt2UsZPUVcnMdVRQFPe4UhVWU6gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSYoovWIMNO3S6tIcq+9o8xzsrzNQeK4IJ1B7c06LOrj1E59ACp3xNibHRc/iFpP3VyTe/beDJ6arz2qI/dBt/kFXsZIVzyEMrHlb1i82iLBV09gbnC9FmwpcGEEqxYbKgtNDpFN9Y2N6iskhv/dnBvcguUpGrhPJuSDNFQSM1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mKQL5vi4; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e549be93d5eso5890610276.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740483476; x=1741088276; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n1TWnKYSjWgGvb3cyxt3TX5DamTHuovBzjkuSknBSeU=;
        b=mKQL5vi4qGOJRLNpfXdtofuJbytPCxHNMU9f1tg4sQGkA9LmiJLUUnYV2K/6x+Foqo
         X4b1+WjYxO0NbzdXZ2x9I6xbWGj6s8mmaVDuzv3K71KgfISMkkbl89BpTPmecRPl/DNf
         lkw8yLL+brU/PjVEKZZCMUgMoGuL25c28+T2unlydgObpEmUc7nftZCGlxkHOEvqHPZS
         LATnblprmHKRH8zZ629/vS8HUTGBQY1pGgpnaC3jBGbyZiO94TJlGoMmPyy2CmuENXlV
         Wb570NAxOAfyPJ9R0mXBwM/YwU/sd3SxplXuCHLDcekbb7KfRb9HsDC1Bp94Y8qnberX
         hi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740483476; x=1741088276;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1TWnKYSjWgGvb3cyxt3TX5DamTHuovBzjkuSknBSeU=;
        b=Ewru888H7nsG1gWqXO+3lyRqsFAtrzzBNtc4HL3c6pApJ8SKJDgBiH+z+AgRcdUL5j
         mgHaV2o3xTXbCW/ID5ilo4Tesx/QFeqHkIOyhOop6xO813IDK/UZb8sg6Zybm+tedcTe
         uJn4l/sjn5b1xZom6nzN0w1i0YsrQMqKdKOt602oLKSn7TqkEPlDmJBGRM3bqJTSl9Fs
         FbsY5gZ1WwQKE6+XwuS6OPCCiMV9SUdUi+7ALVPOU/0QToBNeloBd75i24vOoOHug6VA
         vNR5daEC+Y309Ru1hlhrhoRbDW5Rx+E9PADduNrFFybtjs/gqiTlY1JjiahG47b2tTh9
         sOfg==
X-Forwarded-Encrypted: i=1; AJvYcCUIh+d+unEzlbpHm9V66ZA2TwjcCPcGLB3eS4t0+pM1ptvtOlUdBtGtLbRF0dpaevWbK9FBMF6Be6rlWqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsMMslJz+u/XRZrOkP158vfxQAeGj+EUJ1Dp6f/jKU1VdXQvZm
	NpiWvUF/7GeD0GVmQlcDbU3bQ6U2w5VWsGQ1NjtGUoyBTjEd5AH53Qy9ocoobGGdFCnkQd6Grz7
	FlokHxVKSbx7Lg5GHuxZ8M/nmzr+v1Jc3h2oeVQ==
X-Gm-Gg: ASbGnctvYe5bPEpYCPsAmQ7Ac1+CMM2zOrzqx/I4naajeCLCH4ksVAdZviv1Wzkx0Yx
	2FXjtowncWgf7U0xZ1rcidnd0n2Y1wv21ufQ8m7rCjh9ura3pN5FzsuM/vdhV4Umj7yd02+WK/X
	Ri4NmShPv++FgbEuGIsguD1UfaJQoj1+C5UUouE88=
X-Google-Smtp-Source: AGHT+IFoRV0tABvVleGcPGFjITHVSAozbUIV7vt/JXOPnNAtmYOOQYQ8LJ70dKpeCX04ppbU+mmusjSHjBwHx6qf6uI=
X-Received: by 2002:a05:6902:18cd:b0:e5d:fccc:7907 with SMTP id
 3f1490d57ef6-e607a4e3c9bmr1939202276.14.1740483476663; Tue, 25 Feb 2025
 03:37:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-adpdrm-v7-0-ca2e44b3c7d8@gmail.com> <174047913824.2131221.6545389561298332217.b4-ty@linaro.org>
In-Reply-To: <174047913824.2131221.6545389561298332217.b4-ty@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Feb 2025 13:37:45 +0200
X-Gm-Features: AQ5f1Jq_8vz2X92aaDmmCRK3QuSACEM5CmHNBFF9CumkaBecyk4PuPviBAdIWp0
Message-ID: <CAA8EJpqM8ZQ-ScEtEBXaUF2Nargtp_TBAyMYvbJ49PGbwPWjaQ@mail.gmail.com>
Subject: Re: (subset) [PATCH v7 0/5] Driver for pre-DCP apple display controller.
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev, 
	Janne Grunau <j@jannau.net>, Sasha Finkelstein <fnkl.kernel@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alyssa Ross <hi@alyssa.is>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Neal Gompa <neal@gompa.dev>, Nick Chan <towinchenmi@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 12:25, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Hi,
>
> On Mon, 17 Feb 2025 12:39:30 +0100, Sasha Finkelstein wrote:
> > This patch series adds support for a secondary display controller
> > present on Apple M1/M2 chips and used to drive the display of the
> > "touchbar" touch panel present on those.
> >
> >
>
> Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)
>
> [3/5] drm: panel: Add a panel driver for the Summit display
>       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/40115947b59f2ca361a47615304dff0a2b69a2b4

Without the bindings?!

-- 
With best wishes
Dmitry

