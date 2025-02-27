Return-Path: <linux-kernel+bounces-535862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBFCA4783C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42293B1D56
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0E2227E93;
	Thu, 27 Feb 2025 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tsrDmHOq"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A1C17A305
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740646219; cv=none; b=Fy/BpgnHOqbxaZhf7pU3lMEcXJSvchI5MQvxWiIxaMkNP07vrcSZzKIVUo1NanrDpH2pecqOiyraxtn0sqcbyrdoiQrg2IUFKPOSL48LxpeAiodkMKzDJ9c8D/pX++CrxdoYQB81JviT7mRNuUGkEIAmMzRbA7iuNWv88EBQQFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740646219; c=relaxed/simple;
	bh=uynasPwDdscPLERoEl2jRP9OFCsreNV2gINdXwEpEFk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WAv/mr5kfX2J3xKUs38xOjgZUhF1PKODy3vRn+1QWPmW1d0ZvLjeyUwgojvsWNIKCMS+9xzeMw19TrKuXMbzZX0ckOpAplMr36fVcl439VGK4B9o+MOKzhbiT3QaiO74N8k61uXfoY2HQys5dAsczD7fWySQHb0CNCVEThLXNBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tsrDmHOq; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f31f7732dso406246f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740646216; x=1741251016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ks/IBwEcAklNTaxJVZ+LwL3mjgTmoZqvlq/i0v1O5/Q=;
        b=tsrDmHOqesXrqelYX9H5/bSxH05AIppaFPG0KGQJ1kiUCYdoEuPs0zyhcvQNHeN0yT
         AYnMEkSnxC9KdodRXRFaTWQyY56DVCH8fw7tq8qH0uCVWFqYJe20Iw/h0jAlnWek2p0j
         VYkDAsBtMHqCQmSbWDQxTBm59Q8KOdsxfEZsP8wSKwIlz0Q4gbrbWjGeAGIAPm4wYjqw
         3ooDnwS/HQ/agq332TySbCiFSzvLUmNHzj9jrT3T6sF7V3bMUB+UXftP57QtzuqAutI7
         Bncx0kumLx4VB7CcXPogBmMyxAwMplB6AHeiTcKJoiHp247ZWMH0cLYVKaSpsC+/nX2D
         gWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740646216; x=1741251016;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ks/IBwEcAklNTaxJVZ+LwL3mjgTmoZqvlq/i0v1O5/Q=;
        b=TgrFzpAcELHLtPmAH9DcWhOOWy0+ccbiJ5evMN630ycdvK37VazlzlGNWMAvAB5duf
         LxR1rprPbfl3lbXiFi6HJIt1AjPKBLEJsP7rT+Fr2tgy4V2JVjkp2IN78IaMI8lkBq7d
         lbR5cLQGyCTBG6xRT11DqWAaHpC8+Mce4ZsLqYmmCZezuQreN7YaK3lbpQat9/7G9saE
         QT6Z+mn3tBKAzJ/Ml7QVxTbQ2jGmtt9BgaCwuh1XzC/1n5u2sMeLI3beVzkYsxWZFA5g
         bBCP5Bczejy89PixsXpIUv3apwWJ1a1GjevVvTGRoOq8DgHf46FGO5sK7B8biD1CbRD1
         wzxw==
X-Forwarded-Encrypted: i=1; AJvYcCVff0qF90FdyJTDMT4Z3vpKiv3ozAYLYqk3Adayz8kem/gouCuk490mQ+h6D5HtvdYd5VsDxiIBIRArjfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaCwD7Dy6ywEra6uV2EeMFs8RF2OTKLTEsg9bURol2m7AFWSNn
	KfB+vwRH66yY3hnFE9goNRXDY9oROO2eB0/WqisvF0RB6XPFscO2QS0Wt9JQKes=
X-Gm-Gg: ASbGnctCVtRPKInnen2N1J7mRk6wPnuSIxUQ0JOhyrVr6Jh1C3ISlyv1WSeMr3y1wZ/
	Gjh3+1mN7GIg92UroVY9Yod9tdavIZ8+r/sU4te8KaEp5t+SLhr+dSqoFaocANI6++npTLhrOhU
	f48DUjMon/Ww+wdWjpcbooPui9fRwPBicfNlwSafI+QFdNLuVyEpYDmRvxwjM1+0RQd4D5q9Iqd
	o+vcoPSbJwLqAJXSMYsvbycjXS0Jd57Mt2/iFKv7bLHv5OPiliYdJfHFQMpxO3hX/NmZo7fx2hj
	g/BRxUgOHs40mqq+96eYfoOscnxq+XQm8tv7szOkVlRXodU=
X-Google-Smtp-Source: AGHT+IFoYeXJ4I6jLF2jC03Em3Oo6roBaewn/6DI8FuDdaLJ1uKLliib4X2jgX4JOOl4swbvnoBEew==
X-Received: by 2002:a05:6000:1a86:b0:390:dfe9:1881 with SMTP id ffacd0b85a97d-390e18d23bcmr1917682f8f.27.1740646216574;
        Thu, 27 Feb 2025 00:50:16 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba57145esm46894535e9.30.2025.02.27.00.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 00:50:16 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 andersson@kernel.org, konradybcio@kernel.org, robdclark@gmail.com, 
 quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org, sean@poorly.run, 
 marijn.suijten@somainline.org, jonathan@marek.ca, fekz115@gmail.com, 
 Danila Tikhonov <danila@jiaxyga.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux@mainlining.org, 
 ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20250217222431.82522-1-danila@jiaxyga.com>
References: <20250217222431.82522-1-danila@jiaxyga.com>
Subject: Re: (subset) [PATCH v2 0/4] Add and enable the panel
Message-Id: <174064621558.3904283.15224037666170321960.b4-ty@linaro.org>
Date: Thu, 27 Feb 2025 09:50:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Tue, 18 Feb 2025 01:24:27 +0300, Danila Tikhonov wrote:
> This patch series adds support for the Visionox RM692E5 panel, which is
> used on the Nothing Phone (1) and then adds it to the DTS.
> 
> Before integrating the panel into the DTS, we update the DSI code to
> allow bits-per-component (bpc) values of 10 and 12, since the Visionox
> RM692E5 panel operates at 10 bpc.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/4] dt-bindings: display: panel: Add Visionox RM692E5
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/383c772f23869df7a31dea333ec92c9e442431d8
[2/4] drm/panel: Add Visionox RM692E5 panel driver
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/7cb3274341bfa5977f3c90503b632986a82705fa

-- 
Neil


