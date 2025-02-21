Return-Path: <linux-kernel+bounces-526011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6646EA3F8BA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7E91887750
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDA121B9D4;
	Fri, 21 Feb 2025 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pvxX49Mt"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181D1219E99
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151521; cv=none; b=uS13UAqTYKN9ErdDhewxi6N/mOTpWNDGVMbfjaPVWAODDq1X2ZfsFNrhyY0VqTXOY0QTBkXNu1nJMmuTSumOqjGbM9kJEfS2ymGk6++bZJfh5ofgsOnIi5sIV0hNidnhV0pXh/YCP+zRtdAz5psc+XJigM/jdCplR2SwiqXW0A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151521; c=relaxed/simple;
	bh=JRqovq+Rdk4ORXpGPmhXUXGU0PwNM6eotWnKyHhO04g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hhuRRtHepzOrQ4hAWWrmw741J0SzVmzMnBoVuPUGTFK2g3bgKGpwbCD0huBtqciNe+oMgAp8A9KBprqBBrLpBNPSd1W95QTjuJmJvkXA6w2J7ojWNVnqiNw8nQBJJPWtTmPvxPUo72ccxsGjxTUT5NpL7obQQaIaSDD71+DYRWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pvxX49Mt; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab7098af6fdso34137666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740151517; x=1740756317; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MScxPmftbdaB9C7JfNjmumigE9RQy6JfuyND1GmcrGQ=;
        b=pvxX49MtuQeD0D7NWEnc8eDfhaHzKXPrZL7FWKh8p1n7d4sMT8bn5vYLrZvmznVJFj
         4+LKWScUDuKJVs4jkH/nJn22Mej35g7FcbkWso7OqSDT6HJkOs9UswWup1xB+EstRjN0
         Qi2Tc2pUviYJJte7zq53xRNDlbt7gwmMukGcUR3x8XVtKQMjMCzud7+PpGauIhKiTHUT
         VRm/1TW7ZVHCqQJuwBvNOU3LjUaynNyxK1zVy/F+AOZU4VU7AFOc1kdFPYb036LrHWSU
         0P6r+RLvt444yL6EOUIOQzljyEmHe2peDVBMR2Bdd+6mTYvEbJ9aUp8hhu/XaHGH4Af+
         n7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740151517; x=1740756317;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MScxPmftbdaB9C7JfNjmumigE9RQy6JfuyND1GmcrGQ=;
        b=A49X5fo7v5DuoHuKn6ZWsoktBa3Cv8oFHRR6RxoxxbcyIKN5sI+aL+Ah9KxfOvojU7
         T9JKw7NSIWLF6JF6W4GfR6HHtGDEjfgk4SpS/rb5WZ7hKIOempJzxFffXID5P9cPkPL1
         4vr1HkSEAY0SJi4dKs6fxFzs3FLVEkIuoo6G4xZjeG09ajQgUeLMqsvgrslBaX4riwWG
         1ahLxFjvWDa8QSIsZll4zndC1fqvPfsjwiLlB0BFcYemipfSWe2mkRfh8Y7DkldDdtbl
         Mg4EY7nIMZ7dMWxQlCXB1GVs2NoWhN//aAIK8P5m1dKfUP/O7DmkLSrybQ4qqkb1Ps+r
         kDKg==
X-Forwarded-Encrypted: i=1; AJvYcCXlxZAbvPJfh6AQhpEK5hgrWEptpug3oze5CwMmeTb19sCREMcOuAoI+sqtKMphJWkhPyDyPiQCsFZWcgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEvrOKp3dtmeZthU+VX36GNZrNV+nerNljC6Y2FzohoUr+8c3s
	BgxXg5qjWuAAhb7olyZixkd7NhKdw8hUgaRbdm2RkwCLnno7TIt2ZPLvYYVQCQU=
X-Gm-Gg: ASbGncskOVcH3DjBW3zFcyNQFkyInosXgdCxRkTkXQQfFynnBMJdOhS8vr7OKe+qsJY
	mz9Jh0ciCMKOjxFsyACsy21wB5nsy7mIpgqABHEntePw+wt7rlqVz/xeUnM4y9cLjXI1DgN7Oi/
	SMM+EVYsdtscYU0v1P99JYqgnD+/dSVmUCDjdY6omv6++9owPu3swVzr+3+R8fVD95zRdXq9piG
	q7PpKGKXiMVEWgBMH9FtQ0+Hrwy+QQMhQD/DjHpnk66Thmx9qeCFdeAVkHR8oC3DP1vYLwONRMI
	WDJc2G4Dn92t5oztdleCqYaDx2bVzuHaLlXFB5ZntvosbJHu7DWciXu9/kReppjGNAPGiLVCTLY
	D
X-Google-Smtp-Source: AGHT+IEZnVvREUQe8xdsdj+GBrgqQ7C/qFngFux4HQwA1pzTqFUf21THE/JmZxJqitoZlusB8jqZIA==
X-Received: by 2002:a17:907:7f17:b0:ab7:63fa:e35a with SMTP id a640c23a62f3a-abc099e1dafmr140825966b.2.1740151517355;
        Fri, 21 Feb 2025 07:25:17 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbaa56026fsm865456666b.113.2025.02.21.07.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:25:16 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 21 Feb 2025 16:24:24 +0100
Subject: [PATCH v3 14/21] drm/msm/dpu: Add handling of LM_6 and LM_7 bits
 in pending flush mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-b4-sm8750-display-v3-14-3ea95b1630ea@linaro.org>
References: <20250221-b4-sm8750-display-v3-0-3ea95b1630ea@linaro.org>
In-Reply-To: <20250221-b4-sm8750-display-v3-0-3ea95b1630ea@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Clark <robdclark@chromium.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=JRqovq+Rdk4ORXpGPmhXUXGU0PwNM6eotWnKyHhO04g=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnuJq4bVJFnsyb6JXH0wvrNs+g4JuM+dv4z0uK/
 SXpuDXh5ZCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7iauAAKCRDBN2bmhouD
 10+bEACS/6knRONeGRMXYcJCR0RdF1lHQo2wynIQXKhVTCF0F2KMsTDrqFOiGs1+EXBtyp+tM+Y
 xe/+bWynGqwKEbRNdt4haJT50d6v9mHfR09hzbVuxRzX7gC2dZvG3xyUbGSDTrn5kO9szHGLOgO
 9rRxycM+wrNkV7Lslr5FvhgjYdePrmrTBi4lV393VJZzH7hoFmQKBqXTyQCw/MD3kX6DGF9X7n6
 XvCe2nXpjelkmztT3j/HGLqpmSQ+fctZexywB1ZSQaTQmf686BIRnWLmvcwAIxWH8Ei07pQEeVt
 q5U0PgQw8KLGkR4YE8BNUJzS7qXpA/SAxq5wbwbClFKC2mMBtY4611wdvGD8oSy7Ueqby8+qeTc
 8wgarJfbYY6LmmB065D9QNPFNFqYh27BoHRsWlO18FBcubQHO5Na18sUbm6QSkUC+TcIyXmsD5i
 rXHpZltfdZg8DTREYZQdwfSIg27i93Xm3/pWicS8Zdk+koiRbiJAZVjfBLMw83ePDbaM6tGmSrP
 enOYXotVh6DXbn+cXfKpHuCnIiibUz/M3YlQXUIVwhYRAD3HLzXJKHFDR3hJc+w1yedmB3yDxRD
 b3Tzo0zzHml7BZtjxeYwGv9jRO3QI3XE51h23/N5R2OMnmc+hrTg+N4t9MI6hc68pAZpJkz+84+
 Yuv0917jW4WdbvQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

MDSS/MDP v12 comes with new bits in flush registers (e.g.
MDP_CTL_0_FLUSH) for Layer Mixer 6 and 7.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index 1c14770865b4b5f83a95feb35d8ca6b0c87fdb53..43a254cf57da571e2ec8aad38028477652f9283c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -254,6 +254,12 @@ static void dpu_hw_ctl_update_pending_flush_mixer(struct dpu_hw_ctl *ctx,
 	case LM_5:
 		ctx->pending_flush_mask |= BIT(20);
 		break;
+	case LM_6:
+		ctx->pending_flush_mask |= BIT(21);
+		break;
+	case LM_7:
+		ctx->pending_flush_mask |= BIT(27);
+		break;
 	default:
 		break;
 	}

-- 
2.43.0


