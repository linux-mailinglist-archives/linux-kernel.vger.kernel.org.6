Return-Path: <linux-kernel+bounces-268722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F3B942853
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798AA282993
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24631A7F91;
	Wed, 31 Jul 2024 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="oHgCpHLZ"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE2B1A7F60
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411916; cv=none; b=N4nb6AJiFRLgOtT2XuAx3TRBEN8xDvS7JRnMmMUlVF0QgGckOCkVNHmV+5CvLkCo/kGHchyfOYgDf8YeSdRFX9nmD+r0JtqAu3Y+JojMLQjkqql2/ETYCiQxzwGZuwsuVP4Xaz1GeAZEdbd8YFH7AG/xx6iBxf+0sp+maFNVByo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411916; c=relaxed/simple;
	bh=yKNBl2Ktp0gu6KA4Su7k3OuZ3Sd55/hO3UH0fIFPbXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uo9G65NZ0+9HBJ1VYESQZR9aHdUGO2JcWpVpNTRxIvoUdlePc+AGFmLfawqXbgKJ+niklpQGJNsfqhrPzVlWzBxE3YLRqWAykdAuMFekAv+lKTdt4pz1P4BnPzBj1IBS0fVvRljWAKd3KXwuRPqUbtCZZNy56yrJzYSqibIQ7bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=oHgCpHLZ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-36865a516f1so3771458f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722411913; x=1723016713; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vHNBN/ufCdXcl7pdCh4RFeocbeeTwZ3+FK4L26OSDs=;
        b=oHgCpHLZBp3r7MSoayyE6J7kjcWTHqtnvzjDFLkO3rujhjwzIWTzxVMlggX+YyOUok
         TJxdbmWZqPerheL6veQvzYKUo8PdC0AqDrbF5r5ODAZG9adDKZlXHZVGZiXv0GeFPvFW
         /NpGZu5yWdC5cP3fzNlGyWTH7IeVZVmmNnlAgvfpQq/wpzRO78hWhU1B+Lk7p8u3xZp4
         5djxgNpNQnQM61tIdBpu4ghjyTOrSJvsSayI6Scf0Mb6axn0l4ONCsVyBrcuC/ZbAUkm
         Bu09aJ3QCmvFt47FkR1EEA5/svV6DFUNDB36q+DTtpC4NLSAtXhSvvWUq32rk2MPCfWS
         U6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722411913; x=1723016713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vHNBN/ufCdXcl7pdCh4RFeocbeeTwZ3+FK4L26OSDs=;
        b=QgYhrl5cReD0UUBDiM/q/Wy6hi62vjJAEr4mn3RYYBFajP3cLwe5rniByYw8UmES0E
         Y+Y0KQCOIzzJdMFSq4CqlX9s9EXefzVx0LIJuKHh6VK9UtbJjcCsqKXwhZzeJo84udnU
         Mtx8mdkDrjZsHMsR40CrpXCXXr+uwtN51MV8Nx60PMocgusMDT16OcBHhoB46kNHRZfQ
         SpQAwbW/29uLntkqI1lcMyOhhw1r4bzWKiG5Mliv6VrBL273DpTe0fXATwdOMBxlodvF
         FaTK+4xHxUlFcValQ7FU1Eq5oDPgbQjE81oM6SF9tjmBCtAxYr3nfLxQvPjcaVka8RhB
         rdQA==
X-Forwarded-Encrypted: i=1; AJvYcCUjvFlQtU/XEZJokMc5RS8t4g7g4vZZ2XbFKZeOx8ieHa2F1eygizLiqLjWjXuDAgGiBXL/xZllAZMrcgW0aIViyaKU6gahOEZjb8aS
X-Gm-Message-State: AOJu0YybiSk8O+AXhQJN0NnQhqR/IL/WOv5dg3kH9Y0UeyQh7A0uyaMY
	ZAbGAcVRFR6qt3zZsBwb5BaxsClWj/3Mu4929qPwoHtKlm33PUOdnDbDgdqHGD0bT4fMRVeqz7N
	f
X-Google-Smtp-Source: AGHT+IGT0LdCk+C3EeslcKV3qT4fsUUqFk3w+JR1pHdpJa+ltDEXYxaFPmr1VLvVwt7VKmeJrtW85Q==
X-Received: by 2002:a5d:5751:0:b0:366:ee01:30d6 with SMTP id ffacd0b85a97d-36b5d0d1076mr11141130f8f.49.1722411913302;
        Wed, 31 Jul 2024 00:45:13 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:9c3f:3dd8:b524:cb31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857dcesm16283104f8f.85.2024.07.31.00.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:45:13 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 31 Jul 2024 09:44:56 +0200
Subject: [PATCH v2 1/2] firmware: qcom: tzmem: fix virtual-to-physical
 address conversion
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-tzmem-efivars-fix-v2-1-f0e84071ec07@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3036;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=IDWyVF531XX7Pomw+3tmuIHewwA0ELgVAiQqvm9sn5E=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmqeuHPzGm4C6NMoS6BXs7MujXbcOKc8pdbv4nL
 OjlHlDP5RyJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZqnrhwAKCRARpy6gFHHX
 cslAEADFIgiQw4X5p+/fxMQ23Kz71NyOIwEmKfqA5t52onjL9V1hihOcLhe6Ju6uTUW+8sqGk7v
 qnbiibgzHqKkhdHqRh76XDmqD49QKEaxZ8WYYaltNtH4mp0/jiM9hE3ayho6GQImrV/5mYcww8r
 nwz3xxXAZ4/Wo+BA9Lvsn4gowuhcaR8KlNkOaGXrIAHYahuQqPSti7tQUaILpvYy4txwVZrYRWH
 F17/taCanh2RPfQobYkll9plswZ1ki/RHgjtedl6z7uM37ED7NO3cAejD+HqvtgOcEAXETO5udU
 r9cY+Tj7gRd9hsjXoIESbOb0hxxbMTmoStn1YpB9YcK81jEQAmuwBRRN9/HuZvzT4cftkGy/q7v
 Y/3y69XbBdYphcMIkx8CBE/JFsh6sNNqXOFKex+ru9VCBtRqWOCcFC7ZM+/syHzwPG7K3DHtqxD
 9y9JjxQrSXBIdvqvPUHjtsvmZXoU3UeJsbnIM7nqWDf7zjVi0+aH8sSh4DUcFXpsOTRGzmuAkp6
 XXCzYRI9PTCV+L6EFZRl+mCS2+Ke+CNYbfW+kduxjdNuR9eROT6IitM6kQgbT/DUYTYzIh8jUpw
 Ne5PKfdrshrJWJ1Opol3dZdRC/hVT5S52a4939FWNC82bBd6h01qAUu305ekDKPW60wNQuKsHNG
 ZAfgiMx8e7+eDdQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We currently only correctly convert the virtual address passed by the
caller to qcom_tzmem_to_phys() if it corresponds to the base address of
the chunk. If the user wants to convert some pointer at an offset
relative to that base address, we'll return 0. Let's change the
implementation of qcom_tzmem_to_phys(): iterate over the chunks and try
to call gen_pool_virt_to_phys() just-in-time instead of trying to call
it only once when creating the chunk.

Fixes: 84f5a7b67b61 ("firmware: qcom: add a dedicated TrustZone buffer allocator")
Reported-by: Johan Hovold <johan+linaro@kernel.org>
Closes: https://lore.kernel.org/lkml/20240729095542.21097-1-johan+linaro@kernel.org/
Acked-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom/qcom_tzmem.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
index 17948cfc82e7..caedeef0059c 100644
--- a/drivers/firmware/qcom/qcom_tzmem.c
+++ b/drivers/firmware/qcom/qcom_tzmem.c
@@ -40,7 +40,6 @@ struct qcom_tzmem_pool {
 };
 
 struct qcom_tzmem_chunk {
-	phys_addr_t paddr;
 	size_t size;
 	struct qcom_tzmem_pool *owner;
 };
@@ -385,7 +384,6 @@ void *qcom_tzmem_alloc(struct qcom_tzmem_pool *pool, size_t size, gfp_t gfp)
 		return NULL;
 	}
 
-	chunk->paddr = gen_pool_virt_to_phys(pool->genpool, vaddr);
 	chunk->size = size;
 	chunk->owner = pool;
 
@@ -431,25 +429,37 @@ void qcom_tzmem_free(void *vaddr)
 EXPORT_SYMBOL_GPL(qcom_tzmem_free);
 
 /**
- * qcom_tzmem_to_phys() - Map the virtual address of a TZ buffer to physical.
- * @vaddr: Virtual address of the buffer allocated from a TZ memory pool.
+ * qcom_tzmem_to_phys() - Map the virtual address of TZ memory to physical.
+ * @vaddr: Virtual address of memory allocated from a TZ memory pool.
  *
- * Can be used in any context. The address must have been returned by a call
- * to qcom_tzmem_alloc().
+ * Can be used in any context. The address must point to memory allocated
+ * using qcom_tzmem_alloc().
  *
- * Returns: Physical address of the buffer.
+ * Returns:
+ * Physical address mapped from the virtual or 0 if the mapping failed.
  */
 phys_addr_t qcom_tzmem_to_phys(void *vaddr)
 {
 	struct qcom_tzmem_chunk *chunk;
+	struct radix_tree_iter iter;
+	void __rcu **slot;
+	phys_addr_t ret;
 
 	guard(spinlock_irqsave)(&qcom_tzmem_chunks_lock);
 
-	chunk = radix_tree_lookup(&qcom_tzmem_chunks, (unsigned long)vaddr);
-	if (!chunk)
-		return 0;
+	radix_tree_for_each_slot(slot, &qcom_tzmem_chunks, &iter, 0) {
+		chunk = radix_tree_deref_slot_protected(slot,
+						&qcom_tzmem_chunks_lock);
 
-	return chunk->paddr;
+		ret = gen_pool_virt_to_phys(chunk->owner->genpool,
+					    (unsigned long)vaddr);
+		if (ret == -1)
+			continue;
+
+		return ret;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(qcom_tzmem_to_phys);
 

-- 
2.43.0


