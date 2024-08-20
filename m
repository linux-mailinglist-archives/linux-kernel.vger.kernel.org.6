Return-Path: <linux-kernel+bounces-293672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2579582FF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F9028677D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDC018CC1D;
	Tue, 20 Aug 2024 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hS8TOmDU"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C8118CC1E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146830; cv=none; b=d7lYWZbb/IOPnyhAxa8AGZ9Frsm0O79K1y/1YXwaoXOwFRMNFUGIduEys4jJRITI+3ykWlaa+rjkVOKaK+Fv9dMAUZOyk2Vv6ulIMlObflmmODTOMdJAxO72svVHAV3au8spq1T9MQXntdztQgCMCh4fRm5miWTT71mHp5xZaXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146830; c=relaxed/simple;
	bh=EoJtIsmmU9SrguY88s76AA2qh+Iy9f5umyZmJzjJwKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FBYRgYqSG0lte7aoadA/1n7Pw+2ROkeZZn3KFJhC1hXt2YvqeQELUvqwUhX3jLrlZ0i8pQPpmFnonkAWlxo3CCbwuCIfDskQ9GxkOUVud3VkqZ+xyzRDWofP+oDW83VIk9xOiYp0pj7otQ6hQTy9D9FhCaozWCS7VSXAhHBwMRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hS8TOmDU; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a80eab3945eso534171066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724146827; x=1724751627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ml5kmP2AZ4rRTo1ml+BArOzT8EmV3i5O4Bq4nH6wu1k=;
        b=hS8TOmDU8+WcrlVNcsMtWg4G0Q3xKdeNqb8Oki82bIESDLoknHE94gRzJj3HybvF7a
         97aewSFE0PWzUboXdSjkjETAClQR5am4dO3RYBPr4Ilyiz84Ia+RtZsKL8L7cD8PVs4I
         wSeX4vkweWNgK1ayA6T+icQY08lDhyyyk/ts/qsm6PWHx4DSCB/LMsEWlZQiUuqC0uYN
         OTjmNj0/yyyUToEM94qPWpsbyDN4ldwFFJodumftLeFAND32sSsdhagV5IoEshgpj9HP
         qpJ7VGM3DgrqOnePdvbgMO4HC81yIZTneN4vBysftc1ffLpimvXpC0eLINQ6McpLQMMI
         bwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724146827; x=1724751627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ml5kmP2AZ4rRTo1ml+BArOzT8EmV3i5O4Bq4nH6wu1k=;
        b=U4WLmAt3kgSuDwuk8ztAKm0dNvgSq8vTC7i6z2PFiIWKD7jEYd08KzeOBRdEqGvQtO
         VG4lUmp7m5eVo7v1TsnRbktr6eAl3wf0aKSniORiaj7o0WgsvZQKuy52VD39cZbh7nla
         GnCzrjrMrr0m9Tb/JWcyp1ydt4GAy1tb5pJKQ8yVWZmSg4H4KS4tyrOngh/9p+tguP9W
         /vDMjcH1eSahDOxGkV+T4Ha9jRhXM9RvfxzBILrmkhrCcVACvL5X5AWJJijCPHeGQ8ur
         W63dZopbUCRvkmQTNWyyKWLDAjmBZMdOapUmvp4bVWFrdUHCR7ceIVqr7T1AtJ0mrv/5
         kJdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOPgQoYN5O0zmzQeEyXl25wxEk9I6KC1xUHDBeiIKj4I2JwbfqV6pLV6RWYNbpYPH8fw7fWXDXrbRPNHOFlV/S+/UYJckieNv1ak1Y
X-Gm-Message-State: AOJu0YzSeabd9VQTs9IlZ95O9Mf+qU0Rd4pNQJyyhZ/IkeIOLP4imRG5
	/9RX2jjBZvI6W9zFjk1PVP2ICjV0ZVqF/kDDTBnb7TIwXgxJ2UWWw2ihbz9cpg8=
X-Google-Smtp-Source: AGHT+IFWIcPWJD7AezJob3CaaT6BEKEOeCZ2xK2iLUqEJ3Fjit54kT8/4nWS9N5eeGL5wXOTPMbcfw==
X-Received: by 2002:a17:907:e207:b0:a7a:bad3:e5b9 with SMTP id a640c23a62f3a-a83928a9ea4mr984286166b.11.1724146827093;
        Tue, 20 Aug 2024 02:40:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838d023dsm733613366b.64.2024.08.20.02.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:40:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Anup Patel <anup@brainfault.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Atish Patra <atishp@rivosinc.com>,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] cpuidle: riscv-sbi: Use scoped device node handling to fix missing of_node_put
Date: Tue, 20 Aug 2024 11:40:22 +0200
Message-ID: <20240820094023.61155-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two return statements in sbi_cpuidle_dt_init_states() did not drop the
OF node reference count.  Solve the issue and simplify entire error
handling with scoped/cleanup.h.

Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Re-write commit msg, because this is actually a fix.
---
 drivers/cpuidle/cpuidle-riscv-sbi.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index a6e123dfe394..5bb3401220d2 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) "cpuidle-riscv-sbi: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/cpuhotplug.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
@@ -236,19 +237,16 @@ static int sbi_cpuidle_dt_init_states(struct device *dev,
 {
 	struct sbi_cpuidle_data *data = per_cpu_ptr(&sbi_cpuidle_data, cpu);
 	struct device_node *state_node;
-	struct device_node *cpu_node;
 	u32 *states;
 	int i, ret;
 
-	cpu_node = of_cpu_device_node_get(cpu);
+	struct device_node *cpu_node __free(device_node) = of_cpu_device_node_get(cpu);
 	if (!cpu_node)
 		return -ENODEV;
 
 	states = devm_kcalloc(dev, state_count, sizeof(*states), GFP_KERNEL);
-	if (!states) {
-		ret = -ENOMEM;
-		goto fail;
-	}
+	if (!states)
+		return -ENOMEM;
 
 	/* Parse SBI specific details from state DT nodes */
 	for (i = 1; i < state_count; i++) {
@@ -264,10 +262,8 @@ static int sbi_cpuidle_dt_init_states(struct device *dev,
 
 		pr_debug("sbi-state %#x index %d\n", states[i], i);
 	}
-	if (i != state_count) {
-		ret = -ENODEV;
-		goto fail;
-	}
+	if (i != state_count)
+		return -ENODEV;
 
 	/* Initialize optional data, used for the hierarchical topology. */
 	ret = sbi_dt_cpu_init_topology(drv, data, state_count, cpu);
@@ -277,10 +273,7 @@ static int sbi_cpuidle_dt_init_states(struct device *dev,
 	/* Store states in the per-cpu struct. */
 	data->states = states;
 
-fail:
-	of_node_put(cpu_node);
-
-	return ret;
+	return 0;
 }
 
 static void sbi_cpuidle_deinit_cpu(int cpu)
-- 
2.43.0


