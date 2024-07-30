Return-Path: <linux-kernel+bounces-267797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BA6941590
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D29285850
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584AD1A3BC4;
	Tue, 30 Jul 2024 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MH+gbM4C"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36951A38EC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722353962; cv=none; b=EWu2FAs9ADoxc0iq4ngQaej/8So/yCK44TUrOyRSmBySA5Wqbqw7wDBLcRVun1/6/2U0KGupqC9IsBgIWgLzmdozL1mPuNQ9WSZiE9hhRU/X9VHoRaPpd+LklWUtO/ly5gawiw7pt2jVyOiNGuY8H7w9vQr25Jl+r7xC2VC5jQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722353962; c=relaxed/simple;
	bh=R4ZooqWbss9xGs6bIU5o5lnNh9rXB8hpYCrHpZgXAXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VOe7+Xtups5upLIx4eywbxUvUy3NlU2u1iCOCw4rJ5AbrSniSdzVv38JVV/MbEbRXrG1ktIQvF6vgxXvuwglNGa/rn2ttdQ9f0Fy6LkMMtUjBfYM2rSBbsK/gsoCMC9CoseAlNpUlPbNoVipMNP9KPD9Ap5UDrwgF4owhE/Q5iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MH+gbM4C; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42809d6e719so28944955e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722353958; x=1722958758; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxLhBkZsmeEaZb3So1QjwudQ+G7ZrlTozU/Owae9ajE=;
        b=MH+gbM4CbHKo19tibXuAPuzlmxMpRlOIqoZbl386w3lo91ifPSTvhhnQLcdi6zkRyq
         ZVa+BhBmr6nrmZlZdDtnIfwP8grv/qG9kndY95wp7O5tzJrSlegA2ohwLZEXojcZ1Ozt
         sJqAtNHE9xcm+1L/i0qKpKIb/LKFjCxmW+KRVWNviYpYLEoAoMwDu42Bu2z9pqPJtPQp
         z1rXqafgWhZg4vuMnuqYnau6bqL5llr6J2AtNhVUJPMTwAZUEmjCq+NztsRB6Ts6lI4y
         U+B5lQN8Bh3ojEkxed8RQ073AmHcsgLLKwNP+AdepIV2FWBVDgIqXuRTOI4oDg0KC3O/
         9Ksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722353958; x=1722958758;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxLhBkZsmeEaZb3So1QjwudQ+G7ZrlTozU/Owae9ajE=;
        b=xEg/TrwZodQxeRwGW54FQlClV4cVr+qDuX9bwWQTXivg3g92TF53EXdM498gi4sTC7
         XnITEVMN/YgslIb+RMjp3am4ZCxtfWlpn0PJuhUkYRQm1lHnt8bS/UuB8ZFrHln1mJYZ
         dnso3SAo9sMTizgOWS3xzAWZ9oF1ryoJEqvyyfbviD9TB7EO2/9QiLW+Bf/8ARTSoDb9
         YQhLoOX7BUHT9YA9AYTyHVZH9mGezjtDDAA2pVh8BlEnzSv6u0UJNhQsaexD1VnEje75
         QREbgM0/mH3ZZKGETKYW9GsgMnWd+wddzHvp+n7dRATVyM8R+v70NSy6NUyw3prJwlhb
         GFuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXfHNM85jELtwr000PWQ6On8khVdM9DHGlHaKB6rMvnHxD+kr1BXKIouA8TEJYWjSbME80tHT+27U64f/25w5E5g7g74D85XWC3o2r
X-Gm-Message-State: AOJu0YzDcsVU38d+uPKKBww/A+E0fangxjteWPqMdFNaumFHP2flOKAO
	EgP+eK3SF+6kqTX+tAvAxg69MSA/Ph+EM1OGyutURjXWFBtRz2V2PUXs2fzJ/HQ=
X-Google-Smtp-Source: AGHT+IH8imLvNOLJLmKJfopOT+JooKZj/DFqqPvo2Vc3XOjFHpKLCFiWyIm19qQeRu1stKkmPLTQPw==
X-Received: by 2002:a5d:4c45:0:b0:35f:f90:f383 with SMTP id ffacd0b85a97d-36b5d0dd17cmr6831632f8f.56.1722353958448;
        Tue, 30 Jul 2024 08:39:18 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ccf2:71b3:8f46:e8cb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857d5asm14952522f8f.84.2024.07.30.08.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:39:17 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 30 Jul 2024 17:38:49 +0200
Subject: [PATCH 2/2] firmware: qcom: qseecom: remove unused functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-tzmem-efivars-fix-v1-2-bb78884810b5@linaro.org>
References: <20240730-tzmem-efivars-fix-v1-0-bb78884810b5@linaro.org>
In-Reply-To: <20240730-tzmem-efivars-fix-v1-0-bb78884810b5@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2671;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=QFummjheRYx42R3XUj/t91RnTBlfQL2DLWjzOiD7yT0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmqQki4LkotceIbvXtuG/VsWPUMi/8hiDdKaZn9
 cBckW2pHNWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZqkJIgAKCRARpy6gFHHX
 ctEEEACXIEEth/3X8H6OSIH6yjzMuZiOH/b3Ke7y0bU7W4BtPjpDKAf9fyCf1X5hD8Ok4+RnKxW
 /4atYl3xxHQCbwPLq2xvNw29t/0Kmpw3XZO6DDc4Ml120gUPX2Te6fYxbUy9Et+/ge0h8g7ossh
 KVG6n24FXmwOLzkgJ35X7ViJZJKTQF3sLZwfwWOhiCcrTEnVeaWlTBhdCiJynlirYtmSFZ1oFdO
 FZLju/Op8r+3nEaAsMZmFjKl1QVzbXKQejxfOWtEKZVt6yO+ImbtiikexKrgW1p5b+flDJkTWIK
 Kj3K8B1GVuKNj2YMqec70srPjsXDfgZwC182mgZl5NLYivK313Lq1AWLZDsJehwGpn9JnnUDdgV
 1NbPLMky8HKucKuogBNqHMhY0Deu5cJd5IJlnn44FQNltFmxxyLfw4GrnBm2iLhXwgf2HPLdH1t
 RTaiHBZy7R2Uld5HBvWesgnxEtqpzuH7VfyMOHwRtUKK+W2Abkz4zyY+j0IAB3eY6doq+NHhUOP
 6kY8JmjMY+DLtuVvtmPWPNzBenFu40Dq+RAguWacdUz97wpnEV1SeOI33P7igdtsDrPs5DLP50b
 voEGX80k9kmt42dqp5XpUnLI/5SQUUEqgbvl2cZgy8UqbYiySYgcO/gWZhJpF3a/DTvoUoMOlhy
 ye7Rff4YP/xwGvA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

qseecom_scm_dev(), qseecom_dma_alloc() and qseecom_dma_free() are no
longer used following the conversion to using tzmem. Remove them.

Fixes: 6612103ec35a ("firmware: qcom: qseecom: convert to using the TZ allocator")
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


