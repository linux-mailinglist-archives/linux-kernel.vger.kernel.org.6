Return-Path: <linux-kernel+bounces-515025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2280A35ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1EB16343F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4620264A74;
	Fri, 14 Feb 2025 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wz1s2EFk"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C19D264A90
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539081; cv=none; b=IIZP3BbohWKDtQ7OGqMJfEayItHTW4S8Knmaqb1/85fT5YNGhkXFOixoFNhL49dhWiJ/vwa8wbp7/b+DUEuZGo91vTLl/zVCgHaVOTpVRZF+9BvgbuDHyt9CT9ba6VWVwepR4fpfupQ80DOZkqKUxSb0r2bBFCE3Bm7cdImVGR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539081; c=relaxed/simple;
	bh=L+i2ne6USMbeouYgvh/Dzg8b8EW24qOMAa2/YMn7bNg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PTWv8s5eGjNvG5wj7Dv8NP3OSpJjqArKOBbvqExQrDEx5bg0CtpBwpuPWfka9YPU3AGvGPFUvQohTE8MVra8WONPoqF9EKGMxVHUOOORRMiQVB0HNtyWctRQmXZ3Do/+siZStH8paX16wuxtKmYReR0nW02q/RCwOM+Wjv3vt+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wz1s2EFk; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38c62ef85daso293169f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 05:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739539077; x=1740143877; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WTkVJFJYdKGE2V15GcqWFnLtubHjV8Mv7nfMRm+EoPY=;
        b=wz1s2EFkFWVsipFgTOefpZkkry/fmwujLStP3uji3xrwBrliD20GlnhSlMTTG4p5Zu
         5EBRTq0LHffWYBuIwQAKRjRPDMy+k+uon471aCBf2hSc8Qa1HwBz88RXEn6kpfjBc6uu
         7VBzaD3TX62eQYlr7LxE1XOAmGdeiK+n9cYhGwSbo840tqNL9gE5wuUHhFuLWopWRTPN
         FyCR/0/rocjWCNTq3Ok25ZxgtUAUC+qMyeMbLUMC5nrbQnXM61LbOJ8KmY0oMhbwDdlv
         u0c3SUbzx4/PL+BSJ3zWa3JaAwk7TEaXDtAgWwzJ6TWwgBx1vYGOGxB3DJxk/RkFc59C
         K3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739539077; x=1740143877;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTkVJFJYdKGE2V15GcqWFnLtubHjV8Mv7nfMRm+EoPY=;
        b=FKtrbT5yoT7l/L87yMzKxY0b6kMfbANHUfwmf5w4GjOFfPTrBtiWP3GPNa89lqg/n2
         RMe0S4x/hTZjLJ+UC30xpQNIZ8aD/4cV47CDXtYfORw7ZnzNv5U9HmWQcWA83QPYMOIQ
         oUHhRKNRfyPrh9iq/8l3uvXGvMqiCdAkR/DQc3H5fTG8/SUqK5bgakM3qLZbybbJv+z0
         nfT2GnFPymc5QmuCeklJzfho8SvzNmWXWnrcfQUQC1CY2OI/zpEURF1xoAf+BbDXk9px
         qL5JqkYJ7J0yvYOuLFGlTN+r3qTmD/AZRnmZExMLnQ17bAcTR1/mDoZlOyZ63VQ5J8Kr
         f7RA==
X-Forwarded-Encrypted: i=1; AJvYcCXsZxFEBq43At5xJydDzsKfGey1SgmWryKVOk8LF6ZsA066lbC+o3YbRDwchOSGyzFYTtqPdSMsG7fVQpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHhTAYf2RYIPyBs+bu9UtdZFw4Gv6mjxBpiFk0DRA8s8jur1fl
	KmrTpEfVW4YSbFI1iu5R5fzp9rQJbPCcfq3FkqScWWM5sYbR00TD0fZuCyr+WQg=
X-Gm-Gg: ASbGnctiFkxagfKzmIglZ0Q3awL0jOAk52/o5V0fb59k/RJXwJfj0Ec2HUThF4uJ4eR
	EyGiaqsvGLgnsvG2PM0OiHVa2VQQUlEM9/gDpi+KwjDYz8xDU+mHu6x1AdOxW3rVessHqT0tKFt
	UlxudhJZNSWrtM0TdxaeD2jhYnnHIgAu3RJOfqxlK4jbF6r7CRkxdGHQdlUMXMRdF04/IG6B583
	8fOTtQhxkhouz59e32MKqQo0U2VMo7us8c7eRnRMvRPMJe9YIFsw+9vT9sIX03CvVFRxfdpsGbK
	209IvDCzM1ik23NIm4ked55d+vQG75E=
X-Google-Smtp-Source: AGHT+IH+EYmWeA1LWeRvivFdhkovV3JXAQXGbPQOMp0OcWg5nbCX0fAoBV+Te8py0Y7dhNTltTi0vw==
X-Received: by 2002:a05:6000:400d:b0:382:4e5c:5c96 with SMTP id ffacd0b85a97d-38dea30a188mr5168291f8f.8.1739539077391;
        Fri, 14 Feb 2025 05:17:57 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5655sm4607690f8f.77.2025.02.14.05.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 05:17:56 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/4] drm/msm/dsi: Minor cleanups
Date: Fri, 14 Feb 2025 14:17:43 +0100
Message-Id: <20250214-drm-msm-cleanups-v2-0-1bec50f37dc1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHdCr2cC/32NTQrCMBBGr1Jm7UgSiUVX3kO6iPlpB9qkTDQoJ
 Xc39gAu34PvfRtkz+QzXLsN2BfKlGIDdejATiaOHsk1BiWUFlKc0fGCS17Qzt7E15rROWODDPb
 0MBrabGUf6L0n70PjifIz8Wd/KPJn/8SKRIGqlyFIK0R/0beZouF0TDzCUGv9Aok/QK+xAAAA
X-Change-ID: 20250106-drm-msm-cleanups-ddacf1fc3ba5
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=822;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=L+i2ne6USMbeouYgvh/Dzg8b8EW24qOMAa2/YMn7bNg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnr0J81HBnDmsvJT7ZOq36M79xw8Qu67Y1oNk06
 cD5OWAmN8aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ69CfAAKCRDBN2bmhouD
 19uGD/9oGzLoFf2LW8iOUbXHjLuJFp73CsojzoPu3vV66wBuA26yHbH6IuKC7nishtJxp4vva5F
 MRNY+e/lBhDOua+fbak/wzDBvWePwnGCcpZULffj611wOZT99CRPMjXjOleHSfTMtx5gxQqXIvO
 NH2ciOwgZJR6eVIDzXWtxkrQYLKimA0BVCdVe/jk43at0Hyib9Tk77g/w/geCmRex8+Aa1TjE7j
 s8HaboZH2FgKAjHltfmTlUjT3PRvPbjMe0rs7LkKL7jg4TTPhL/ol1shTCIsGhMl0J1UCZWrpWO
 Ry61QJTIzPFKdUEZZoKO+H03PoZfhZ5sGa30O5t5AIYjLlKvFqqC9ZE5enzi+cvgAwl044ln+uF
 qlJzsfy6Uoj+5E59sRLf1scEXX2cpsJRyZppq9mpE2G+8/WUPhTk8bn9Jfa5mhXVg4y2d+hCUa8
 dDuhsmzRWnPe9fpKI72iKhLW1VokXkWI5zdg5/JmEjUYYvoj5apU85HYlf74l3yemQfuARUwyTf
 s5Dm/yCbzBXvjDL08MLsceQoqLkDSEzpFpIAhNqBEjKdQilegsu1dyvBhl6WI7rRQwOTreUMylY
 VPfYNb+8r+Q0Hn3HsidsL61wKqwESAkIAiF1uofmeVBoKOhw2pE1QfhtcNUBpKAsh7Fl/7hvu+S
 XuGceCz2ooIa8Cg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Changes in v2:
- Patch #2: Update commit msg
- Tags
- Link to v1: https://lore.kernel.org/r/20250106-drm-msm-cleanups-v1-0-271ff1c00795@linaro.org

Few minor improvements/cleanups why browsing the code.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (4):
      drm/msm/dsi: Drop redundant NULL-ifying of clocks on error paths
      drm/msm/dsi: Simplify with dev_err_probe()
      drm/msm/dsi: Minor whitespace and style cleanup
      drm/msm/dsi: Drop unnecessary -ENOMEM message

 drivers/gpu/drm/msm/dsi/dsi_host.c | 158 ++++++++++++++++---------------------
 1 file changed, 68 insertions(+), 90 deletions(-)
---
base-commit: 88cdcf93795d293aec92218477e6f857cce9156a
change-id: 20250106-drm-msm-cleanups-ddacf1fc3ba5

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


