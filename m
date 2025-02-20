Return-Path: <linux-kernel+bounces-523422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EEBA3D6A1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19EC03B6731
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D1A1F3BA3;
	Thu, 20 Feb 2025 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HhlLcV3k"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183EA1F2BB8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047194; cv=none; b=lVTvv5apHejE0QfEarXfYYzkzovmdWTZ0VBtGBykb+VNz4QHp9Vd78YX32uiB0bG9RtSj+yP9C6XW69d2NdAUORrZeluKstBUh7kQEukM4YI1ATRLW2wEb5MtHsJPGQwOD97rfi2J+7G1kb6nuPg2LjctTmrcWfJi2ZkZoFw30U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047194; c=relaxed/simple;
	bh=R+chS185SijcfPYYCgAaRcXeK8VYBg1VE8B3d9ZjF0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HySxjEE4OwaOZMueLsb4tu3FGxFzRTzA2GlOcfrrrPgsg/jxPUm1KVDDxxxCo7eYdohiAJRwRHnXrAFzDPJfsiYInu6didY89ONelRtobH+HvUup1Tuv5Ef3bCbAykfhGDjKnzIGVAMbhuzfhTYy+eK0LVqa/YuvChH94OFadJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HhlLcV3k; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5452e6f2999so804487e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740047190; x=1740651990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ff7ItJ+SnMHnASEHcZ5O+TpGECb0jLJ30NNOzaJgwmg=;
        b=HhlLcV3kCqxD9LX7+YGNmUwUgCGkk4JHVzNeC8f0m1qDJS647pxcmEdzXo4bZgOUAk
         9c5WjAHFLhEoDbHTEf+ixS0rDc9kcpSM60kzTXIXo7TDVTtLA14bqZBbj1n/2xyntxv8
         SInlOwDVpGsE5ilCDBSDb68FKP+bW70Zf5SoYdxZTRKdn1y2Wl8dEbH9HBLlE7tZ0Jfy
         EsyCRw+FbcgQlsxeYoGO20NsWYZPrMVXHLhksDeIL8aQspGxNpX9gkxVQASxRZZowTM7
         g50ofM9SG/FbpC3gBkox12e1Llzjv8wUe33dod8QZwF3Pu/YbeiBIT/0flfUq/7ifre1
         BxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740047190; x=1740651990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ff7ItJ+SnMHnASEHcZ5O+TpGECb0jLJ30NNOzaJgwmg=;
        b=chSI1shZSnlG2hAFv7s+T4CJwxTjwBGnL8YFBBHb5+bdS0Ch9KOr85ts7W39Ssuvv/
         tPIYKrUTWHetZlHGtRrV7Zcj9We7o99eJTD80YuA6xQ1SLUapJN4Zdhhrj7lbe6qbzjy
         PPDZ3dvpihFZxuwofbHgX1sq5QyP5ow2xtI8/WeMy0HDAn2ELMcqRNdPoXJEXzhiLXfm
         nvDntOGq/eGVHp2B6Qi4NNLDuBzzJ84wJMuqGwq2YCa5Bt1Jv7+EQsbD8DOEWw5aBHLc
         EyHOivak2PWu9xielr1vNIy2+UCBkuC5i1ykO8Ui2xbb7u77AKJWQpVwpHInlqbMahIO
         L3bg==
X-Forwarded-Encrypted: i=1; AJvYcCX7xFUU6u0/VNQioucedzZpwSnJZFunWDl4OijCix/GJrbUyJIlEbzhPsI8LuS+FOs1W6BSFGOaYyXz+SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwA2KEAkfkMz6Zm8k+ct2dBcU6P9c8RAu3jfG7f/rh5SDVyYbo
	H68tIrDyL0q+kDbe/jTKOjiyKXqr+ZJ53/ynuDKEtzvy/n2RC4DaDwv0D6zJU0A=
X-Gm-Gg: ASbGncukVJPtbpwSRJkZ36iA3TxzeDm2z3uKBn+JYMa1bfY78K4CttefxXxedAxRVbQ
	2GKJ2KYiEWjUU1oBDNvJefn0E5FJUNczms56qZVm+QQAT3hrVxBAfmmIjSA6E2+xXSkA0uFRRXZ
	q/N14+30DPKKxvsiTKD753g4MTySMh4W40w0AkLIIMC0tJre0voL10WREhSkI9QAJhjY8moPV7J
	3a49ZsfWUdL8s4PGF9FvdeL/G20fce1x3TMAqfP5+C/HnmXSLIladaAEFqHF6L24saG6hY93J2q
	veFCWF9CVW2CNK8SdjROpL8=
X-Google-Smtp-Source: AGHT+IHBt9HzRKY8jmkakzOnUvvbEh4NOe+or6nzqbYZMeRyoIBCIJTZbNW9HUfXavUHGy8LrqzxzA==
X-Received: by 2002:a19:5f1e:0:b0:546:2ea4:8e72 with SMTP id 2adb3069b0e04-5462ea490bamr2874449e87.49.1740047190016;
        Thu, 20 Feb 2025 02:26:30 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545e939224esm1588052e87.135.2025.02.20.02.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:26:28 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 20 Feb 2025 12:26:21 +0200
Subject: [PATCH 4/7] drm/msm/dpu: use single CTL if it is the only CTL
 returned by RM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-dpu-active-ctl-v1-4-71ca67a564f8@linaro.org>
References: <20250220-dpu-active-ctl-v1-0-71ca67a564f8@linaro.org>
In-Reply-To: <20250220-dpu-active-ctl-v1-0-71ca67a564f8@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=R+chS185SijcfPYYCgAaRcXeK8VYBg1VE8B3d9ZjF0k=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBntwNKH5HPpczCu9L/5cp+mmYPkPzXuoJvH2zlI
 /BJSbMIVtaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7cDSgAKCRCLPIo+Aiko
 1U/bB/oDpQQYxShoHXWOQQeQDRt4B7KsbhHYKFXsqWyzLIMbrhA2+AYfan+s3Yq5pdKzRTf3LyU
 0hiFB09nCcmi8MDPcXtCiN+eDDJWkISat3ZWao6vEH81ToCIcb5opY0qewxzHsl2BB6ytR4DrrP
 tZLETlHLLEHNswnxDMFE3oQuVO18wQdNR8OItn7QnvTFV4vRr2OZly04xb6qfeWXVSaIs2TTu/q
 n038iCfbHa4xGdJ7qeiIybTB2quagcnpfdvPMe4onA/rgYIOlI3BSXZZtpWIhvX1VokAzA1oZX8
 zg4wRffj7liG//1uxiAL25vyvqYRTEGtI3vPaZmZhoWIYRcb
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On DPU >= 5.0 CTL blocks were reworked in order to support using a
single CTL for all outputs. In preparation of reworking the RM code to
return single CTL make sure that dpu_encoder can cope with that.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 5172ab4dea995a154cd88d05c3842d7425fc34ce..666a755dc74b41b79fa1bb2878339592478e4333 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1283,7 +1283,11 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 			return;
 		}
 
-		phys->hw_ctl = i < num_ctl ? to_dpu_hw_ctl(hw_ctl[i]) : NULL;
+		/* Use first (and only) CTL if active CTLs are supported */
+		if (num_ctl == 1)
+			phys->hw_ctl = to_dpu_hw_ctl(hw_ctl[0]);
+		else
+			phys->hw_ctl = i < num_ctl ? to_dpu_hw_ctl(hw_ctl[i]) : NULL;
 		if (!phys->hw_ctl) {
 			DPU_ERROR_ENC(dpu_enc,
 				"no ctl block assigned at idx: %d\n", i);

-- 
2.39.5


