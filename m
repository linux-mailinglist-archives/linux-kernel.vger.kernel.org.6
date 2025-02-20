Return-Path: <linux-kernel+bounces-523419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD7CA3D695
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03876189AB2D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E7E1F1523;
	Thu, 20 Feb 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMh3Ven7"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CC91F0E5A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047186; cv=none; b=V7vmkTlSp9QupCFjiDRTZAJtaW3SHpaZNYIE+zYQKfUKXc9TeRyXgjzPKsDCb0TDHFTW5YWV4s2EYwG3kOeUknRjWcv4eW9Do8hbvllWpxELSFfrKb2N9G9qVKuVn7NvxGz6vwH5FzCG6JotTY9gvFEJeqpOIn7n7ifovCYCzxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047186; c=relaxed/simple;
	bh=w10ZfN4br6Ap7llW/HC7sm0zGLP894PWSldkoISRy7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jIN3fI0YBRb5kIHIWobTSuD0otyVLMbX735eBU98EAtWJZM15uvxUFwvRTl9iXFaw7DDRrGWmrrqFY6y8t4BO3QtiAaYVZFOTzVbybWj6BsexYH7q0JTzUH9mufP4PMprr72hNZ+j/2D129IvTtdNdanyTDvodrAFclU5NUOjSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mMh3Ven7; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-546267ed92fso941211e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740047183; x=1740651983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BHG5/92JHG16RLprBRzXgLa8hI+3p50zsk7zJC6YSjI=;
        b=mMh3Ven7JY6+5/SrwKzboHhkJCBEE8ky2Jsgkj4agEYR6xVOiTeUKbRZW0tCCGLHVr
         7ehuEoi5djLbifkSHxBQU8DwfCkP6jD0/gHBkJpAyg4d9834TOOXQFkshtwE/6I9QuAK
         u2ZhFU5qhM5mh+BJVdkiw9l2GlaAsBugnMOQbQk+lNjAe1GrXZngmxvo8wR+BRtGj37R
         CUMan3rT1GadxJuXkqLXHvfTEr3FVC6LG4Lwos1oadqtIdDo41j+JTHVnd5BD/v32hLW
         q4/tLAqlddH35G8py8mVYczQ8sIdFFpn9sxaYn/HzVOpGsCLN4UrG2gpQGHDjk6GFid2
         UNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740047183; x=1740651983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHG5/92JHG16RLprBRzXgLa8hI+3p50zsk7zJC6YSjI=;
        b=czuCayuzKfPBrwxNHIcspTeC68UQ3ZdB3AMftFJCPaERPjwYuaQG2AvwbafSNw+nfZ
         f2GqYeBEhz6OEYp+R4kdw6+ToEtCbvKLafBlRoLDKL+EkRE9AY6Xs30uJVif2/ZNa74+
         h5O+EbBEawjaB59t2aVWgmeqJ2OmMDWc5ypKsUnQvHxInAEDX1XvT3TLbGBdl8qgq4QN
         LLMYDOx+ZyImPw6Xw6SUZQ1M2Lqsqbw8nED07jghIy8zQr1TfOd4okAyUMxoEUr6PEye
         fRSNFxq5zzrBbLWSimzDMRIJzwM8JvUNJossHJ7AcOWyh96zIQuRYtFurHj1f3HN5/3e
         Lx0g==
X-Forwarded-Encrypted: i=1; AJvYcCWZcxr7XRqHoJpZY497X+cB3PLWdmK/2RfbJdfh1qKj5ShXz5NZmJ85qrAoRFnEJB0H+m1rqf3cpgtB7l4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfH4MGVaaCd37jw/E7+boqNVOfxNmQApMofS+twHd1Qz9kRN9T
	g73zXvZkaMcTuYpGS3m1KzHeBFdW3jWAAcEDrZGRo62HhHZCnIUWQa8r+AweimY=
X-Gm-Gg: ASbGncsAIifaxVVT2Zw4JN77wXQ1bmDn1udtwgB6gXCmMw4xC+InSA0WtHBX1Ndi+Ta
	ii1zL30cQJjwcBIHFc0knPF9SUf5uqiUug1AIk6oxYXm42EMELAS7rI2/JaqpS+QuLyyzg9tge4
	i/vU0lBlU7+NfiwivpybbGTLfSrR+rONUxheQbC6rp8QyQmb6Mz/iL9e6v9xYcXSb/4r+Yvjdtx
	gnm/Y4zB+NMKoDNpgdoVgUu5VEtybMy4JxaI6PALz1CpXDw4HVRqJ1kW9Nc7tS1i1DIhuPGiPdt
	gCI4Bt2qjSmJWuDwwq6YKYw=
X-Google-Smtp-Source: AGHT+IHoB8cGAPCGqCy5Ys3Z/ClpL2nQWVmYQHHBfQ6tZBAycg+fN9nJybcNHcZmN/tcLAhsEfwZzQ==
X-Received: by 2002:a05:6512:308d:b0:545:2f09:a3fc with SMTP id 2adb3069b0e04-5452fe26402mr9020270e87.3.1740047182645;
        Thu, 20 Feb 2025 02:26:22 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545e939224esm1588052e87.135.2025.02.20.02.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:26:21 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 20 Feb 2025 12:26:18 +0200
Subject: [PATCH 1/7] drm/msm/dpu: don't overwrite CTL_MERGE_3D_ACTIVE
 register
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-dpu-active-ctl-v1-1-71ca67a564f8@linaro.org>
References: <20250220-dpu-active-ctl-v1-0-71ca67a564f8@linaro.org>
In-Reply-To: <20250220-dpu-active-ctl-v1-0-71ca67a564f8@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2119;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=w10ZfN4br6Ap7llW/HC7sm0zGLP894PWSldkoISRy7I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBntwNKGB2SRGw4F+CCKnh3jnyyk4Z50hcLkYJZL
 WDHvV06OyuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7cDSgAKCRCLPIo+Aiko
 1dz1B/9E+EDZuiyFKbu+SOvzfZfWbAo0fN+Z7dtd6euH0aZu3Xj0jlLMVWKP5Gp98xq1o+/fBQw
 mSvUCdUuEsf4Dx1B8IDw0NCpJq0SpYCgZFjQo7jy3jNGrM0s2dYkT/+ZDRzQQtIu34oiYi0AFLK
 lvPc8qzUidfSVyfB/LarXGTT/HPKmqn7uFjrDVOqFJeQLV8PNLTjQbjNp+Mc17t3dYlv+hXXnSU
 mj30TPmuI6n0Y0GFklZBoHHtNHaUZVJXsRHm1q2V8emUk6Y+8cnCQ+PO3xm1qSb7PNSl8Wi0ZIM
 CXxZrghI2QOhgosSlmSjvUD2JTpAKq91N3VTX1O6/N/HZIfC
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

In case of complex pipelines (e.g. the forthcoming quad-pipe) the DPU
might use more that one MERGE_3D block for a single output.  Follow the
pattern and extend the CTL_MERGE_3D_ACTIVE active register instead of
simply writing new value there. Currently at most one MERGE_3D block is
being used, so this has no impact on existing targets.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index 4893f10d6a5832521808c0f4d8b231c356dbdc41..321a89e6400d2824ebda2c08be5e6943cb0f6b11 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -548,6 +548,7 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
 	u32 dsc_active = 0;
 	u32 wb_active = 0;
 	u32 mode_sel = 0;
+	u32 merge_3d_active = 0;
 
 	/* CTL_TOP[31:28] carries group_id to collate CTL paths
 	 * per VM. Explicitly disable it until VM support is
@@ -562,6 +563,7 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
 	intf_active = DPU_REG_READ(c, CTL_INTF_ACTIVE);
 	wb_active = DPU_REG_READ(c, CTL_WB_ACTIVE);
 	dsc_active = DPU_REG_READ(c, CTL_DSC_ACTIVE);
+	merge_3d_active = DPU_REG_READ(c, CTL_MERGE_3D_ACTIVE);
 
 	if (cfg->intf)
 		intf_active |= BIT(cfg->intf - INTF_0);
@@ -572,14 +574,16 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
 	if (cfg->dsc)
 		dsc_active |= cfg->dsc;
 
+	if (cfg->merge_3d)
+		merge_3d_active |= BIT(cfg->merge_3d - MERGE_3D_0);
+
 	DPU_REG_WRITE(c, CTL_TOP, mode_sel);
 	DPU_REG_WRITE(c, CTL_INTF_ACTIVE, intf_active);
 	DPU_REG_WRITE(c, CTL_WB_ACTIVE, wb_active);
 	DPU_REG_WRITE(c, CTL_DSC_ACTIVE, dsc_active);
 
 	if (cfg->merge_3d)
-		DPU_REG_WRITE(c, CTL_MERGE_3D_ACTIVE,
-			      BIT(cfg->merge_3d - MERGE_3D_0));
+		DPU_REG_WRITE(c, CTL_MERGE_3D_ACTIVE, merge_3d_active);
 
 	if (cfg->cdm)
 		DPU_REG_WRITE(c, CTL_CDM_ACTIVE, cfg->cdm);

-- 
2.39.5


