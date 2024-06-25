Return-Path: <linux-kernel+bounces-229503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B80917041
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E651C262EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC1C17C9EB;
	Tue, 25 Jun 2024 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VT6AykHP"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AA017C22A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340103; cv=none; b=qr91u1r8qa80YJhC8pbaxArdAzxddvAZ++ElBkePZGGDUS+q7VfJODHz3JT9UeEJvY7ef4y75WObucRY8ozvLW6aSMxoNLeTF09CuotBuFNNABQ65GJaYKc3wbHlBl4ScYLxKPFaDsFQ4SF15j2BXrNIBAWu778m7AOKHueE0CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340103; c=relaxed/simple;
	bh=hlAsvCKJeJlsvCjk6T4iu/SvTfq4qoydQ2dHeLtqkkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oyXWR54H/sxgeKyKW5FnXoOCx88KLrtV/P/VxkBC7tz++18vo05GmiwXLyjhWv19XjP1wO8kmtql8yZQ9Xh0UQXzXbYiaPJQe0l0QvdjQLqnVA8cF43vLJL54XzDx6QJXroPTs1MgrXX4B7AuchwsXlt0eUjAZM26cStPVyPOt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VT6AykHP; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57cb9a370ddso6878030a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719340100; x=1719944900; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNl1LGe+OUBjKkWza/syUNm4iRQsXOqi9TzG6uI03xo=;
        b=VT6AykHPus/YVtB0DbJKyFvP92iUb59yDh3Cta7j8SMj6HaSliBYYuzNsbJaVOzRue
         e8+hoF8e2NkoMcnCuGySNDN0qfh8lm9njH0Dr3DuNLJFiioIVvrg0oy7OOoiVahliVzR
         6sTzxpbgL/yf1fbLvjQL11/hc2h7zY0LLrRsAPiwXVkuxr7XfcCagZUfsdSkCsm9W+1y
         lz/V24AajqW+SQjKxPPGAtM7O3v5LzEpCFelS1KM1KiLrqGnEN5uN4fwYz9x9+uGQTwM
         eZlivp7MVMmmGVPPa15fZPvsapmucgjfKxi2ikC0o885d/VyHDl6EEcfLJCKSl2ZNQir
         bvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719340100; x=1719944900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNl1LGe+OUBjKkWza/syUNm4iRQsXOqi9TzG6uI03xo=;
        b=Ngtqov/F64EBztdHt5vlmNBYOJlHIlbmFLkjHpvpgmJXgHrlQ/Bn6mDsMb4l8x8WgG
         UXqXwvqlCLrbmDBmcOxthnq11a2UH+we09zhuo0UHiKIRMhXFx5WGKHQ7STbveFdrz4u
         MmFrqiMlMTpYg3PHfD1nw7sm8cwg0c00pugbsZmz4OZ3bw5kSrVf1jVVOHcLjyg/EF8H
         lUgCKUEYDmPL0azH9oUENsx4VOA+a4wZ9oyVI5mo0Og0u3eQMuOUUbAWS/SMNQg7Pr/M
         agZSZ577UIQZhVGxm+3Qeqn1VFHAb4IK4I0n92Bk+HuRzp5zsOyeTAdjzOeeXquA8Q5R
         k+Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUDj5l23Gv+DG7qFWns6UQd3PeW46AaQd7akt4aMZoYw9ayd5pWDyZsDc6j8jQwYb3x95+tS/1esp5fqD/NO5o4hvhQHxpzGUGOZek8
X-Gm-Message-State: AOJu0YyZ0vaRvL87AApWLi1epvgKdRUklwNfdozrsmJ9rrydKdYXAIgO
	TRHmtqVBtMPazY8kfKsuC/u2rsg1S++NwPdRCf13YLJhtGDoBHZ1WgY0VlEXLKM=
X-Google-Smtp-Source: AGHT+IFZf75V6EVKFoeMMT86fpiVICPajQFEHJC9qNUtbTjyoSjlwEE+EJZ1PD+TboCYI1SSsb8bUw==
X-Received: by 2002:aa7:d393:0:b0:57d:5600:2c94 with SMTP id 4fb4d7f45d1cf-57d56003448mr5183567a12.0.1719340100400;
        Tue, 25 Jun 2024 11:28:20 -0700 (PDT)
Received: from [192.168.215.29] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3042fd72sm6323136a12.48.2024.06.25.11.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 11:28:20 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 25 Jun 2024 20:28:08 +0200
Subject: [PATCH v4 3/5] drm/msm/adreno: Define A530 speed bins explicitly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-topic-smem_speedbin-v4-3-f6f8493ab814@linaro.org>
References: <20240625-topic-smem_speedbin-v4-0-f6f8493ab814@linaro.org>
In-Reply-To: <20240625-topic-smem_speedbin-v4-0-f6f8493ab814@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719340091; l=874;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=hlAsvCKJeJlsvCjk6T4iu/SvTfq4qoydQ2dHeLtqkkA=;
 b=IRMR1HRLN2YRjxVqz6xKwmuxF680eWYXDX4vQzB+gFNVfylWuVcDos2bQwzKA7wmZ4U3gJ32x
 gg7nzrlgLmLBSFRvmSiO2FyHkPwIZb+ULPTqUvjdw9Y1u9Ob9HaCm+V
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

In preparation for commonizing the speedbin handling code.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a5xx_catalog.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_catalog.c b/drivers/gpu/drm/msm/adreno/a5xx_catalog.c
index 455a953dee67..c98ad4ea558c 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_catalog.c
@@ -116,6 +116,12 @@ static const struct adreno_info a5xx_gpus[] = {
 			ADRENO_QUIRK_FAULT_DETECT_MASK,
 		.init = a5xx_gpu_init,
 		.zapfw = "a530_zap.mdt",
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0, 0 },
+			{ 1, 1 },
+			{ 2, 2 },
+			{ 3, 3 },
+		),
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x05040001),
 		.family = ADRENO_5XX,

-- 
2.45.2


