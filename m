Return-Path: <linux-kernel+bounces-298691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 973D995CA42
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EEBB2875EA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53E913AA3F;
	Fri, 23 Aug 2024 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YRjikzsL"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F49A18735F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724408174; cv=none; b=mu+aR6AkyJbG2967BVmQUSV3BsdOuxW7kuav7foDbTyTHvbjerf2IQcbrwisGVC/qQzvJUyu/ka5DIcWDiqTZ9kTGulz1/fz/WfXAJJgqaK431ZjbrIr77PQWIKN18UEMR7SX2Nvhfwg3RPOREAlAkru+/TeXIOVil19VZZKB7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724408174; c=relaxed/simple;
	bh=c3EBYma5kTUA/zOkUfd/wHDJYd2x1OE5BHWso7TEYUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SOiC6xa3aduaZieCYE7lDrryOtqHGsDE2vjvTcD91z/LCJnVK+ZetLNgJ0ivENdaz8DuqOg+IgdaZpQcOalkUlREGVGARCF7XO4Rp0mEkCAx6MujleBsFQa6P+BTxRMCdbUU6L2HhRFFVziZm7hh75baqd+BJbiMd0fMmEmswJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YRjikzsL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4280ef642fbso2200245e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 03:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724408170; x=1725012970; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=st6dBA4B9Nv1zPtX9T/2rfu/snV3K8fE/9qGZsxtuyY=;
        b=YRjikzsL4dgJBjyLeXnpVRcsiMRRrAdVUd4EcATsv6dKan5ELzRSPk44kYbDQa6y5o
         nO3NbdWYn/stJqtkN82AnVFApEWXy+iebgZJB2Xm0CTbvBqFDyW6xNxX5kGgmySgFs4J
         zzDqCibWqyhfMOwAQ5N4lyDT1/m886sIVQledSuNY4ppZqHAEvoGItIjBoqk+KJQWYUM
         4hQYnZLyhiwq8SjMnE0R/GOWRCwoS016JRAtzi2IdiA0MPIV1EcqJ6/sqbD/X3Unm9vR
         hT4kFEaqRJ29b8heSZAK9IvXr5Otxu1GONM7zuDNEOEtwxO9RZJLaf1IL7CmHPsNYZOJ
         tngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724408170; x=1725012970;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=st6dBA4B9Nv1zPtX9T/2rfu/snV3K8fE/9qGZsxtuyY=;
        b=IcegSaCJGP12BTLbA7Si+2Cxye6bqZrjFHw37+X6fWc4wkjcIoPcVm3tCT0ZMmXGHG
         NmkAZbXv5zlt3AbFUY4Euu3hNztYYiu0z4HKt6AVy6ZYWAogZcmMrYUo1COZM+jYezQB
         vcKkUzAXfieh16j9fb0EuoMPbjYR9g8fAwGA+eOV/yhU88TxW1Y3ElzF5DbcvPRuRIHq
         6NJdk3zp7zoC1ctK39f+GNqYpq5KVIBuhGtwXAqzun4wG8WS+IhOcTPbTjSRz2jif+tE
         q/d86k+trGU0o6gw9QwxYIHnFGVNPzw6eDM60SqrqpBDYi2YkB7Fp0NZtkUGyGRUbmgl
         pmcA==
X-Gm-Message-State: AOJu0YwP6FaxhuhyEc2suNilrNh18m17nPYD6rlnZcW9bS+7gW/MyTPP
	QP4PffIK4Tue8OlTwWlD29hfU+KiLQsvZWMNnzr+Hn9+028VzgvqHdE1WDsp/a0=
X-Google-Smtp-Source: AGHT+IHh+J5equdBgJ4usKEKsDj7Qu7AiwgUQ/PKWo7hs5cHZCzKxrqsYJ8/hj1kRnLZzBypj0LIRA==
X-Received: by 2002:a5d:64cc:0:b0:366:eb60:bcf2 with SMTP id ffacd0b85a97d-3731185bd1cmr541652f8f.4.1724408170571;
        Fri, 23 Aug 2024 03:16:10 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2a1df5sm237912166b.68.2024.08.23.03.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 03:16:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 23 Aug 2024 12:15:58 +0200
Subject: [PATCH 3/7] memory: omap-gpmc: simplify locking with guard()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-b4-cleanup-h-guard-v1-3-01668915bd55@linaro.org>
References: <20240823-b4-cleanup-h-guard-v1-0-01668915bd55@linaro.org>
In-Reply-To: <20240823-b4-cleanup-h-guard-v1-0-01668915bd55@linaro.org>
To: Santosh Shilimkar <ssantosh@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Vladimir Zapolskiy <vz@mleia.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2384;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=c3EBYma5kTUA/zOkUfd/wHDJYd2x1OE5BHWso7TEYUU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmyGFgGrbj7x0yA560ueSSqqbWUdMCZ0SabmhuE
 ym90ud3QVCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZshhYAAKCRDBN2bmhouD
 12IOD/9vL/BYpE4yYF+b/K4kXxcWaYRXgrsbhNWRg8XaVfPIallsAQsvyKUqWN6t518a1OLo3b4
 sn+hB2hXu7k9fg9FpOuCZehdoyMlkh2YuTIEXXIaxkenyb0u+pRzSaEcYgMJPGz72RkYlvK2I2v
 gERCuH1mD0G8KfBVSw1rCNMMtcpv5pOzbS1lFBIFLKCLssCwGCze2vpMhQlsSLKyvWEEroUqqv7
 oz1hkNFujKVJEroViUTY3wnR0QAoR4Td2Uw0Pqc1sSvW6xLBFqp254JVqa9/cdTyEH4tTgQtanz
 T1jYRgOK3LuLs11JAveVcE4eaYM6M/hyoKgjj4YlFoaa7wdHpjYkCXhmLUiz+Q/fOb9ccZ16W02
 ZZMUPeD/w+wqYHRFAabYbiHztb3l6CYiM3S5KkDR4+XpgzoxSAMxFG8Ps99oqasdJd2rohlJxA/
 iPYIzJauth0VYLZzeNX6vTL5njvNWh37M++OXEv6bby67HJlhAGw4x2ZVNQyO5KsNq8TuBImT9o
 eijwwReaEd/XELR2g//Ai5o7jd/Cdfe4PEQc3DrdzIU3anUzRmIE3gE2kQsTn0RjeQ8BCLYWwVy
 VW6KvoTVgVf9msP1Zv8rL4XEu2NpYSICA5MFQXps7GgewmpcUxeWw7kgbfMpC+7NtuinXO1beS/
 MyWW70f2i9MKLEg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Simplify error handling (less gotos) over locks with guard().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/omap-gpmc.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 80d038884207..c8a0d82f9c27 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -9,6 +9,7 @@
  * Copyright (C) 2009 Texas Instruments
  * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
  */
+#include <linux/cleanup.h>
 #include <linux/cpu_pm.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
@@ -989,18 +990,18 @@ int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
 	if (size > (1 << GPMC_SECTION_SHIFT))
 		return -ENOMEM;
 
-	spin_lock(&gpmc_mem_lock);
-	if (gpmc_cs_reserved(cs)) {
-		r = -EBUSY;
-		goto out;
-	}
+	guard(spinlock)(&gpmc_mem_lock);
+
+	if (gpmc_cs_reserved(cs))
+		return -EBUSY;
+
 	if (gpmc_cs_mem_enabled(cs))
 		r = adjust_resource(res, res->start & ~(size - 1), size);
 	if (r < 0)
 		r = allocate_resource(&gpmc_mem_root, res, size, 0, ~0,
 				      size, NULL, NULL);
 	if (r < 0)
-		goto out;
+		return r;
 
 	/* Disable CS while changing base address and size mask */
 	gpmc_cs_disable_mem(cs);
@@ -1008,16 +1009,15 @@ int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
 	r = gpmc_cs_set_memconf(cs, res->start, resource_size(res));
 	if (r < 0) {
 		release_resource(res);
-		goto out;
+		return r;
 	}
 
 	/* Enable CS */
 	gpmc_cs_enable_mem(cs);
 	*base = res->start;
 	gpmc_cs_set_reserved(cs, 1);
-out:
-	spin_unlock(&gpmc_mem_lock);
-	return r;
+
+	return 0;
 }
 EXPORT_SYMBOL(gpmc_cs_request);
 
@@ -1026,10 +1026,9 @@ void gpmc_cs_free(int cs)
 	struct gpmc_cs_data *gpmc;
 	struct resource *res;
 
-	spin_lock(&gpmc_mem_lock);
+	guard(spinlock)(&gpmc_mem_lock);
 	if (cs >= gpmc_cs_num || cs < 0 || !gpmc_cs_reserved(cs)) {
 		WARN(1, "Trying to free non-reserved GPMC CS%d\n", cs);
-		spin_unlock(&gpmc_mem_lock);
 		return;
 	}
 	gpmc = &gpmc_cs[cs];
@@ -1039,7 +1038,6 @@ void gpmc_cs_free(int cs)
 	if (res->flags)
 		release_resource(res);
 	gpmc_cs_set_reserved(cs, 0);
-	spin_unlock(&gpmc_mem_lock);
 }
 EXPORT_SYMBOL(gpmc_cs_free);
 

-- 
2.43.0


