Return-Path: <linux-kernel+bounces-414844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AC69D2E42
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE7F8B3960E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CFE1DACB1;
	Tue, 19 Nov 2024 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cf3/65uX"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F06D1D2B03
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732041226; cv=none; b=I3VTPZ4CPJ0/5WRrRmaYdr93ud28idFS7YbpPM38Eof3NO8ZDNZQ9VL7YBSbfq6/BqFj5VmrGwH+02l3YAdoJhQYLcHy1r2rQAEiJkiUcixzm33+LFDsIMgYn4lI52AtRGoc9ka0crJ1JTHqvWujpXmWjVBBmTJp+081PIFT5HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732041226; c=relaxed/simple;
	bh=SFzZp8eV5NdRysv4pItOE6KXTNEtpasdX4AXT1ZOfnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZFMFHGyP0KkD75jQ4neWtzxqRjvmskMlTvE65l7CNCopkkIUlX7MLrKZFLRDNQpudxyOJ1Rw9p/9HUZc7+/bAQuuy4qS6Ti0LFYsssfYhHn8UAelqUSpe06s/df+wTLmr3ptUYlaNjBDWKxSap6lISQwC1CY33q13l9/9xMItFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cf3/65uX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315b0bd4ddso6462855e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732041223; x=1732646023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BoqecrL37/DAtjwT3AOqIAQnIPJQLIYmFQwUP6BSc1M=;
        b=cf3/65uX8b2nNZIQ1h9BaJyKYye9fkue9Ha1NNQ3C2YSvslBR5kN503ylNzh1FiT/s
         Sg4rF0pXsEVEZP+s4Ch3CisLI2QLB9Rf1ZEunEWZlLVqPoQha0ov7yEv/dGhz0U3pt3M
         Yh85miDS3VdZ4POyg/71bPfF+cotLI2FAgQ7YemYmdCjhZq1KEpp/jd1QUyaPY2A4l6K
         xHHoYWWfxwv2SEpLqQDO7x9Mz1eeh4/xj7WDRia1SJuu6/czZ1/Il3HtToUdjEY4U5Ea
         JO+oLF+mXnRx6/VI+NuS0r3tOP/iT7Jru3+ZrpX7GIXtysgAfsm3LFJKeoSwCHKZsQ0U
         kzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732041223; x=1732646023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoqecrL37/DAtjwT3AOqIAQnIPJQLIYmFQwUP6BSc1M=;
        b=jx7wKBi6eauTEZVH4dBfsGLem9jfGh6NmJk2CPwEdrWhFRcqOFRz8Ab3Zr8lVWWBGK
         8rw1YKvUf41zKgq2LYp0Rlcc0dMNgiXLpxhy1C+wZ3n8VIYVQdlbkf4ddtp1WrGhtPWs
         cc4VEdErpUbp5wo2mzhESCrmi3GBQ0MabruW0dGfZ4bKqQf0lIxluqPQ8AeV8xxfZVBX
         qjUrngcvWUs88UFKRrK/cX6B5EnuhPKvAlCGY8KIWqJqiwvjBGJn66MHAhOpS2BVKftX
         DI/cnw9ko5NTn8sHG4UQQyEA/6Lwg+T+Z3jTj5wMMFXccBoF7nNJr1Kp4iCJ8wFWQEWt
         5Bpw==
X-Forwarded-Encrypted: i=1; AJvYcCX+Nf+U4OC4aW6BuRqc/0/79XfpFbq8FPuGe8UKOPlrveER3q6uMMwGSPls6wgyvM/2xJekVe584Je5V1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YySY1Ppuq7BgAvus+7aOvYv14Ds/XZPUVbE+cnN1OLSGCjjfQhF
	PSr5hc7uWR97U4HccRp/m+/atl+WsdCz3wTiYqB1GN4bT/7ELYIXKMJqzW/mP//h2TneDnaRBVY
	Z1v4=
X-Gm-Gg: ASbGncvyoNzfFOS18J222DkAh8E3IUhLYJep6MwkhG2bstfCEsYrQPJ6/f+OQ2ZmqH/
	Lav72pvVt2IVoIWVZjB4mdRARZHcVnBa10HMitV4l2SOzK1K8yfGIAzvaX8MJ3SET1JpCdCLaxs
	b3O1q4T/dYncoHgkrCTbLVP5UiPsCBWeEIitvrgGJbrYhmoKat9BAQBCry1OiSm8Rc8/FEMKv4W
	DWoW/pMtJHYLFwAL3tC0Bp2HXhYkgeo0K3vC7OZKjj8NiQf3Ju8QQPCg94EUuOE3g==
X-Google-Smtp-Source: AGHT+IHOrcjjHaLDMTLK8UxL9+wDArIxvlT1ACQkrO+kq/R2slaop5UZZub8bYHqNPV6OusAxfTTow==
X-Received: by 2002:a05:600c:19cb:b0:431:4e33:98ae with SMTP id 5b1f17b1804b1-432df78f563mr65298605e9.5.1732041222793;
        Tue, 19 Nov 2024 10:33:42 -0800 (PST)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac1fb7asm201566805e9.42.2024.11.19.10.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 10:33:42 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 19 Nov 2024 19:33:20 +0100
Subject: [PATCH RFC/RFT 4/6] firmware: qcom: scm: Cleanup global '__scm' on
 probe failures
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-4-7056127007a7@linaro.org>
References: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-0-7056127007a7@linaro.org>
In-Reply-To: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-0-7056127007a7@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Mukesh Ojha <quic_mojha@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Kuldeep Singh <quic_kuldsing@quicinc.com>, 
 Elliot Berman <quic_eberman@quicinc.com>, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Avaneesh Kumar Dwivedi <quic_akdwived@quicinc.com>, 
 Andy Gross <andy.gross@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3699;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=SFzZp8eV5NdRysv4pItOE6KXTNEtpasdX4AXT1ZOfnw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnPNn7p96iktcla4ydpDa30tUfiLwoJDStR88bR
 JTTZEbYodWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZzzZ+wAKCRDBN2bmhouD
 1/AFD/9b6VnCDvEdB9t0DB7B85gXFuJ6noDo1EPx0ViYulSeEa4+0dUYOMlTkFEGffWYloFBt3M
 aS+2EBKtd5IRmGuMef640tQHLOSBP3NUiOlRxyGZjHHVXVW4CA0V/fFEsmHJbx9MlZEIna3HyLm
 63NP1g2M8dgWguJ6ODMsf4b1iIxPMKgd3+Cu2r0X72NxQHpVOXnikUwNCUDaRJgMIragj+Pk+ga
 7v0QCnolSXlq3xvyER0TBEx+WiJ+4Ov4fAQM98GC/BhWi3Iqg/dTXUtqCzIY/BJjSXjw0zAqZve
 5mzQ/3EVmlT7Ns0mJ/8h1jceO3XJS9xYO4QXBrYFanEsqxp9dtxTJUZ0e5khAotGKPUSIC/nn2W
 vxCEGoXhobWOD47ZIS0BMEx/+PiD1lgTijH/4gFcxSUuqZE+d6yY1s4Hn+z6MSQtEIEI3x8ivq6
 bQ/UKILyPkHuTNnn2SHmPDBYbfwfA0n9V4RG6QubDThutCZPbGiY7VGbxsEIoGUoR5NdLxWPXKG
 g9Enx4457g+AxMdD3gKo6MpyYchGFuo70pyDzH+2CuDWCQ1PGi8azcWYgFvhFQvZjXG35tbii0t
 qzsMzn6e8HxZcsdkGij27VfPnoBYdo9ZlhA2iQzZfg1ZNbkn1B0HW0COtR4kJ9+1qfWLJfflHdn
 R+SfIUDamRuF0sg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

If SCM driver fails the probe, it should not leave global '__scm'
variable assigned, because external users of this driver will assume the
probe finished successfully.  For example TZMEM parts ('__scm->mempool')
are initialized later in the probe, but users of it (__scm_smc_call())
rely on the '__scm' variable.

This fixes theoretical NULL pointer exception, triggered via introducing
probe deferral in SCM driver with call trace:

  qcom_tzmem_alloc+0x70/0x1ac (P)
  qcom_tzmem_alloc+0x64/0x1ac (L)
  qcom_scm_assign_mem+0x78/0x194
  qcom_rmtfs_mem_probe+0x2d4/0x38c
  platform_probe+0x68/0xc8

Fixes: 40289e35ca52 ("firmware: qcom: scm: enable the TZ mem allocator")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I am not really sure if authors wanted the cleanup at this point.

Also, I am not sure about commit introducing it (Fixes tag) thus not
Cc-ing stable.
---
 drivers/firmware/qcom/qcom_scm.c | 42 +++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 93212c8f20ad65ecc44804b00f4b93e3eaaf8d95..c6d526d055003a17a8f59471f93160bbccfc1658 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2036,13 +2036,17 @@ static int qcom_scm_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq < 0) {
-		if (irq != -ENXIO)
-			return irq;
+		if (irq != -ENXIO) {
+			ret = irq;
+			goto err;
+		}
 	} else {
 		ret = devm_request_threaded_irq(__scm->dev, irq, NULL, qcom_scm_irq_handler,
 						IRQF_ONESHOT, "qcom-scm", __scm);
-		if (ret < 0)
-			return dev_err_probe(scm->dev, ret, "Failed to request qcom-scm irq\n");
+		if (ret < 0) {
+			dev_err_probe(scm->dev, ret, "Failed to request qcom-scm irq\n");
+			goto err;
+		}
 	}
 
 	__get_convention();
@@ -2061,14 +2065,18 @@ static int qcom_scm_probe(struct platform_device *pdev)
 		qcom_scm_disable_sdi();
 
 	ret = of_reserved_mem_device_init(__scm->dev);
-	if (ret && ret != -ENODEV)
-		return dev_err_probe(__scm->dev, ret,
-				     "Failed to setup the reserved memory region for TZ mem\n");
+	if (ret && ret != -ENODEV) {
+		dev_err_probe(__scm->dev, ret,
+			      "Failed to setup the reserved memory region for TZ mem\n");
+		goto err;
+	}
 
 	ret = qcom_tzmem_enable(__scm->dev);
-	if (ret)
-		return dev_err_probe(__scm->dev, ret,
-				     "Failed to enable the TrustZone memory allocator\n");
+	if (ret) {
+		dev_err_probe(__scm->dev, ret,
+			      "Failed to enable the TrustZone memory allocator\n");
+		goto err;
+	}
 
 	memset(&pool_config, 0, sizeof(pool_config));
 	pool_config.initial_size = 0;
@@ -2076,9 +2084,11 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	pool_config.max_size = SZ_256K;
 
 	__scm->mempool = devm_qcom_tzmem_pool_new(__scm->dev, &pool_config);
-	if (IS_ERR(__scm->mempool))
-		return dev_err_probe(__scm->dev, PTR_ERR(__scm->mempool),
-				     "Failed to create the SCM memory pool\n");
+	if (IS_ERR(__scm->mempool)) {
+		dev_err_probe(__scm->dev, PTR_ERR(__scm->mempool),
+			      "Failed to create the SCM memory pool\n");
+		goto err;
+	}
 
 	/*
 	 * Initialize the QSEECOM interface.
@@ -2094,6 +2104,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	WARN(ret < 0, "failed to initialize qseecom: %d\n", ret);
 
 	return 0;
+
+err:
+	/* Paired with smp_load_acquire() in qcom_scm_is_available(). */
+	smp_store_release(&__scm, 0);
+
+	return ret;
 }
 
 static void qcom_scm_shutdown(struct platform_device *pdev)

-- 
2.43.0


