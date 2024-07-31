Return-Path: <linux-kernel+bounces-268724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F532942857
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B50E1F23ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE201A8C06;
	Wed, 31 Jul 2024 07:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UyiJyy1A"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1261A7F7D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411918; cv=none; b=B8rHZWQg94tlVqp8MywqwrmsyJ4zS9XysF/0R5U+liUMfm/tQyFPEoALqcL+U6VOI7rdfSRVFTCAd7TyM1MPnnNiRQp2YYc43OjsXJTL0Nrmg+Ok9TRxMoSxFlQtP8C+UMfek668a8WWSS/RZNDl25mb8EiEe3CtuxnW/Sv5Wb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411918; c=relaxed/simple;
	bh=3YTeKq7Hhj9wWwiBgBNcp3zvJA1JlvWkmbWTXFd22dI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jflpb3zT2yShqzeg2uox+CXd2o+MemaOCrUxpPOKr9zIonAfJsI9Nhpc5qDxEgOjN3UChKoYoVvwmCK4ACuR4kpV7vMn7D+JAg5idiMbQjrTgZTYY6eejdxM/LPjrpMS9FNpP/WYmdPdt79WeBJtU1AuB15TcJVcOSOQVbd7I+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UyiJyy1A; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so26138535e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722411915; x=1723016715; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PDjPcViKZ7vA42Kh18gcoG8ctnOeMWODlMqSdJ8Mpeo=;
        b=UyiJyy1AlmI8dtQJWxvlH/MULzP+jJZulG1kSkhfQvK2AX4GJZX6S3sfppTIuILpAS
         a7mq40eu7fIFNJzQga96z4UWy9t1F5zdYT+J62uiLxg+pkfeJBICnmatHRgVDTdEdeAK
         7U6fojaIO6GrLA/NmH2PlFeMULtOo+xCAzGKBXMjfacA5UbUbR4wdNwDjGOKlifs/OYx
         qmnSAAKl11vG1KC/2I9BcXi1L2CHHKXGQ5klwW1qVQ9KKUi5M0Uv5MdaN49OdWNAcyB9
         fgHZOAfeUu96db+FzFA/ofvOwN16EEjLVgv4iks1Zn/GYCnWMycuA1fiKxW3Qu8ufjD8
         //Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722411915; x=1723016715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDjPcViKZ7vA42Kh18gcoG8ctnOeMWODlMqSdJ8Mpeo=;
        b=N5ZDXzXquFgdR4YMgQ71cmkWfOg/hvSNd/Y+720DjPcBHb3EE0hN54U0c/czLDJce1
         EB2pBIVEIU/iQWLlScfDJwJilSNNhf31BVxsjGFXUhS2ANrgtNbdMJiBvQqqtUA0w8I4
         KSH0d/MH3LUyENncQVkw3J28c72S3z7KuSm/dt9CMwAATxt890Y8BnXbYFIkcAiYgNdr
         DMKhAjMdMMi3us7v94lat+u3H5UsLiZKpNsrWomn9loi9s86eHCt0WPCQSmLeukCgxJq
         5ZD+LH6Tr37FCW4+FcdeHyx39wMOWHIfTProF24V80AwAvZJ75237N75Rq4xoPgw3+FV
         a+aA==
X-Forwarded-Encrypted: i=1; AJvYcCWYDOcaZLenGQBgw9KrMaB58l2kXPeBwnAiaeqlZXDy9Zrplb+Q+qsFotHrG/ciWgcl3kA7J+epctAGbovEyoEkaO+HC4x01BE59xai
X-Gm-Message-State: AOJu0YwsAieRYLdr5/dnSwmKD1ggFXjeH2a2ljpG4DUu2MTY//kBdXkn
	ci1NugDFsIO05hR5fClKMC0Zl/v45udaNFwt0OvwUNxOhWYTaie3G+OML+cEY5o=
X-Google-Smtp-Source: AGHT+IF6LRgUjSn+1+ryTYGv3zfI7p6aOVRqBNrcU7ZN4NC5Up42c6AOJaSRuU2cqgX8xjMlZM8rZw==
X-Received: by 2002:a05:600c:1c02:b0:428:387:79ac with SMTP id 5b1f17b1804b1-42811d8642bmr105856635e9.6.1722411915312;
        Wed, 31 Jul 2024 00:45:15 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:9c3f:3dd8:b524:cb31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857dcesm16283104f8f.85.2024.07.31.00.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:45:13 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 31 Jul 2024 09:44:57 +0200
Subject: [PATCH v2 2/2] firmware: qcom: qseecom: remove unused functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-tzmem-efivars-fix-v2-2-f0e84071ec07@linaro.org>
References: <20240731-tzmem-efivars-fix-v2-0-f0e84071ec07@linaro.org>
In-Reply-To: <20240731-tzmem-efivars-fix-v2-0-f0e84071ec07@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Elliot Berman <quic_eberman@quicinc.com>, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Amirreza Zarrabi <quic_azarrabi@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2722;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=xeKpWG60jiq7TCX9/Uo6MbrLodxwHo60LreDVcIJbQI=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmqeuHlT3tNcon3r0ZS0xEqE/0+fAfknt08bJEc
 IXdesAlmrKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZqnrhwAKCRARpy6gFHHX
 ctZDEADES4+nW5LF+WZWDvU8c6d3AQ2rk0PmXSSa2+fkh83LofqPhIdS5xc4TXw41RNI2I1XK5m
 +eOhlvAHQ/PsTt0OTq+NzEqqoctyfew8wbeXzKfWammnhQMy1UWvxWc2WMMH9qIhXc0DrgUVf3E
 XevBrmhc8HAGwjJDL8iuOVoBez/HOdGsynpSg2ULu05hg5v6nkxBlfTc/KiQw1WoHDEGkMpwowk
 7emwM2JzhC3pPL1xpD8GcDpcma1wWMYwJ/qsMDzZu+5YdUBMCzLZ3KgSKqxSMrdeqlYqDt++wAO
 MO8eYNT0+KwOG7c0Gw5DHB26DKjciXGaq4tqTPhjSBigedsxED3V2+YoFXczRI8QuLb9N/XK/ml
 Dpc43w1BNDs8yFEx2kccvvGxvBxHBdauIjKVUy5UWaRdRgjRIf83HTNVl4FntdbQrjqFT6h9S1y
 ZGAvtFFXfddL0Tik0zEyrGTJK8UTxAEyHRjSStDu7BivkWVUfl8bospL6c6eatNoplA5hNErjrA
 rytrW1KsyhTMDSO0iozEMl375/q2Ydq7JkbXKKSgvsQW0WtS6oA02hO+sShogMiSCEqeG7dSHRt
 eIJkvfa5v86OW1lAZvXiIM5KqLvNKTyAe0pyCWGwWgpMpTCx2PMhyY9rcYc1uCW+aohz9sR3dAc
 5L6E8pA24ESXAWg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

qseecom_scm_dev(), qseecom_dma_alloc() and qseecom_dma_free() are no
longer used following the conversion to using tzmem. Remove them.

Fixes: 6612103ec35a ("firmware: qcom: qseecom: convert to using the TZ allocator")
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/firmware/qcom/qcom_qseecom.h | 45 ------------------------------
 1 file changed, 45 deletions(-)

diff --git a/include/linux/firmware/qcom/qcom_qseecom.h b/include/linux/firmware/qcom/qcom_qseecom.h
index 1dc5b3b50aa9..3387897bf368 100644
--- a/include/linux/firmware/qcom/qcom_qseecom.h
+++ b/include/linux/firmware/qcom/qcom_qseecom.h
@@ -25,51 +25,6 @@ struct qseecom_client {
 	u32 app_id;
 };
 
-/**
- * qseecom_scm_dev() - Get the SCM device associated with the QSEECOM client.
- * @client: The QSEECOM client device.
- *
- * Returns the SCM device under which the provided QSEECOM client device
- * operates. This function is intended to be used for DMA allocations.
- */
-static inline struct device *qseecom_scm_dev(struct qseecom_client *client)
-{
-	return client->aux_dev.dev.parent->parent;
-}
-
-/**
- * qseecom_dma_alloc() - Allocate DMA memory for a QSEECOM client.
- * @client:     The QSEECOM client to allocate the memory for.
- * @size:       The number of bytes to allocate.
- * @dma_handle: Pointer to where the DMA address should be stored.
- * @gfp:        Allocation flags.
- *
- * Wrapper function for dma_alloc_coherent(), allocating DMA memory usable for
- * TZ/QSEECOM communication. Refer to dma_alloc_coherent() for details.
- */
-static inline void *qseecom_dma_alloc(struct qseecom_client *client, size_t size,
-				      dma_addr_t *dma_handle, gfp_t gfp)
-{
-	return dma_alloc_coherent(qseecom_scm_dev(client), size, dma_handle, gfp);
-}
-
-/**
- * dma_free_coherent() - Free QSEECOM DMA memory.
- * @client:     The QSEECOM client for which the memory has been allocated.
- * @size:       The number of bytes allocated.
- * @cpu_addr:   Virtual memory address to free.
- * @dma_handle: DMA memory address to free.
- *
- * Wrapper function for dma_free_coherent(), freeing memory previously
- * allocated with qseecom_dma_alloc(). Refer to dma_free_coherent() for
- * details.
- */
-static inline void qseecom_dma_free(struct qseecom_client *client, size_t size,
-				    void *cpu_addr, dma_addr_t dma_handle)
-{
-	return dma_free_coherent(qseecom_scm_dev(client), size, cpu_addr, dma_handle);
-}
-
 /**
  * qcom_qseecom_app_send() - Send to and receive data from a given QSEE app.
  * @client:   The QSEECOM client associated with the target app.

-- 
2.43.0


