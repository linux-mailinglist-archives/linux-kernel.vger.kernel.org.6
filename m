Return-Path: <linux-kernel+bounces-372491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B88E9A4938
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814A21C21A6B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039B51917C9;
	Fri, 18 Oct 2024 21:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mHc50/DB"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2658B18E368
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729288167; cv=none; b=QhBtYxx58RYUf+euNGDU4ZROhiAOPaT3K+BC5h2MDiwfo+MG9vaS+UIasEf1UJuSIT/u+VlhXRTV0qgOIWr4VsBPBXTe0rO/GmgPeNxOP0ONXIp7UJ5TlvrKzZ+zXpx+sCBiK43alWRwitJ5a53G8mK9VCVM8STziKqcxV1v33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729288167; c=relaxed/simple;
	bh=bRmnoe4tVoeG590rXiMuIqAybo/BJ38wHNkcgqIlmso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X72ShIR7aE0FEQb5908u4JngwCp6q37IdOpSFdiX1y+W01NXYYGdhLcRCyy+FZtVseJHMGZB/l4Q2vvEubI5oZpflSrFls1w7xfqjnybxaw9GcnT62aqH0oRP9aCeZTP9nwBpPvUxfuMYLSEVmqlLStq8g+Rcd4Mfa+08iW7kfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mHc50/DB; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e3f35268so569138e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729288163; x=1729892963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Go5ATa3ANcllBgMb3i995a+Tn/9iklS8uo3r/4fZl+Y=;
        b=mHc50/DBWSvHrt7tVmOY6bhi9YwBV6stq+zQ7jADyZvkKNVDV0AX2+qNYjttYQUjXJ
         wlT/Ex9MDHCDGKvjHSDj0UyGECIbp9Z9g1Sgp6YRHgQfnUZ2dKnrZiqm1uJ4nf9A+ow1
         MLXcofCwRWbrew7DiEZ7PJe2sUa7GRE2F9DwpRYZVINRENce3IVj8Pq1PF2OGE6M4nib
         M8skRUgWLaWEq8F//GWkqgofohK4lmkA3RbWo05VpHzOI4VABqFbViH0OtqM4CA599zs
         K2/bF7gAXdFQdqPthVtHvid9Uzz1DDB66FZSr1G5vvcN25nDPHk61A8qGckCJXPM66Wi
         Z5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729288163; x=1729892963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Go5ATa3ANcllBgMb3i995a+Tn/9iklS8uo3r/4fZl+Y=;
        b=TBZSs+1IrFsqUNTB74eKdopteSgz/0ArvVTXkBgs0mE1wniTZ/Wq6eKzjXi3h32sIQ
         vNAI1nEkAye2MK7PyU5qKMLNRw3eOJcM2t5cWlDXODpXO26FortXMIbpur/tPolm63B5
         eMM9GH5QpEakxJim4S3EhVM29r0mBd1GLCFs6TFK5v1UkrpyXtuSC3zYOFu/bqZw4EBq
         XjE1CvcQQbp8jHuAoYVwSQARsfHJQVIy011lfCUoWbldVMW92vjmaxBvJvm2Ei+kpIca
         GSiw/LwBI/cbwKiKp9RBlJ+OcKVUIyOU1k5es1icfxq0OTyWH1BoGaR7QAiOAyp0RzAG
         dGsw==
X-Forwarded-Encrypted: i=1; AJvYcCUSJuiocZcC65txMeCWlDI97Ib0Ft2Xwqdr0WtMqKz++l662awoprD9QIV9Zg81zut3kfl+mY4PyTNK4lg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsgu1mqW9rOdjQTzZdyAYY+6CgDxv/AWTV5ynQfkxazSy9aTcB
	3xXqFdExHvrlZFLHJy/E5UEqjCF4bLNDNDaeQ2+ZHRd8eBIEe5921bPGMsQ/dg0=
X-Google-Smtp-Source: AGHT+IEo/FMuV8BXcaeTLXW0eKYEblPO9D0Z6JBXczbnQvEt9ytqgCebRe6synIHwL/ExZe7lEvCMQ==
X-Received: by 2002:a05:6512:3c9e:b0:536:a695:942c with SMTP id 2adb3069b0e04-53a1520be7dmr2388053e87.7.1729288163023;
        Fri, 18 Oct 2024 14:49:23 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151f0ce5sm332088e87.181.2024.10.18.14.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:49:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 19 Oct 2024 00:49:13 +0300
Subject: [PATCH 2/6] drm/atomic: add interlaced and ycbcr_420 flags to
 connector's state dump
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241019-bridge-yuv420-v1-2-d74efac9e4e6@linaro.org>
References: <20241019-bridge-yuv420-v1-0-d74efac9e4e6@linaro.org>
In-Reply-To: <20241019-bridge-yuv420-v1-0-d74efac9e4e6@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=bRmnoe4tVoeG590rXiMuIqAybo/BJ38wHNkcgqIlmso=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnEtfdV58nH3hPAsgrDZ9l/GYMAVX0S0QXyB3Om
 au9VDJz5tGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZxLX3QAKCRCLPIo+Aiko
 1VjhCACxMe6Efsk0jMD+km71rST56+FRiTPqH+ulz1SSX9gFC5ae64pRNdtVSouzjEQta4XWO55
 TR8odbc1YUb62bW4jdPyQ6hWGQ+m2pnJ76JcZTNomBlvh9WBURN/nn7j3Izw6QJK3o/hozejaOu
 VVfbcWJGzREM7vnHQV3i5fpBqIbd31u9+zf4karPkxgVnUj+6FuOCVsmV/Fp1rRJZQKlpiKq0yd
 MRJFtyJTPKHvXbPGc/wautX5WvPq9TLXrfb8bbaATPxf3th7DP5WbsDfNMSyrfyOjEMsspoQ8Jd
 YGmInnt4UhpdCGWANP5rPQGdkFDWgZc3Rs/ou8nS5YNF2/Go
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Although the interlace_allowed and ycbcr_420_allowed flags are a part of
the struct drm_connector rather than struct drm_connector_state, still
include them into state dump in order to ease debugging of the setup
issues.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_atomic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 0fc99da93afe..9ea2611770f4 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1132,6 +1132,8 @@ static void drm_atomic_connector_print_state(struct drm_printer *p,
 	drm_printf(p, "connector[%u]: %s\n", connector->base.id, connector->name);
 	drm_printf(p, "\tcrtc=%s\n", state->crtc ? state->crtc->name : "(null)");
 	drm_printf(p, "\tself_refresh_aware=%d\n", state->self_refresh_aware);
+	drm_printf(p, "\tinterlace_allowed=%d\n", connector->interlace_allowed);
+	drm_printf(p, "\tycbcr_420_allowed=%d\n", connector->ycbcr_420_allowed);
 	drm_printf(p, "\tmax_requested_bpc=%d\n", state->max_requested_bpc);
 	drm_printf(p, "\tcolorspace=%s\n", drm_get_colorspace_name(state->colorspace));
 

-- 
2.39.5


