Return-Path: <linux-kernel+bounces-525961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF53A3F7E0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2043BEBEB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F3B213243;
	Fri, 21 Feb 2025 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Su3emQaM"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4186620FAB4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149849; cv=none; b=AUZaT21hi7+qRU5Eo7eR5HRpWTNpUFg1uLvIWDNl2KLu98StPEQCgHs/9zKJanRUSoESlOwMZZyVNcw+ZebIQkOTbJuV+IjjqRkYWzTPPCmBd89e4MtfBkrFHFIVKrriwy47iz56jXzOWeCB8XwQmnofLWUJ2WID7N2n4mr+W/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149849; c=relaxed/simple;
	bh=37qdTKtD627l5e6Qxc7x2IExKolZyjtaGfIkopSnfWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UyQokJSfCnfztSqzO/QqGVTtclPZOxLzkdoeADLPhJwMLdfEgfzJbXZ0dDdQqb1g9geZOhZBLW0j2mqHN80NOxeRX8sc8mHB9yZDNRMcYzkvV2HqgINfu2Z1sjhVUACPdeXdITTfgZkkgVOztj+B0t9pNl47fyM4lcMcNouX0ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Su3emQaM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so15363905e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740149845; x=1740754645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5+0DAJFyGg9dqAHMt/74M2g7aCiRWRLOEFqoe5G5I8=;
        b=Su3emQaM6/e+yrUGQ2HLrfnmUQ2eX1nRZlwtA0uVF9oXMSn9DD+RkO8iM4IUPYm3wR
         2Jgu7IQegeG3LdXwKMBrw2BsX8oqWG8f6BUQMhkHvK/hnFjCcNHuRMO9JuaceYHmX7oU
         YN7ib1wuxSxLQCdHg6zknxXy3cuxtbSEaaGcbjnteb2MACMoxLOIO2Oq8I1prVrAvueY
         a7mEGlHc0STb584B39bPVf9P510KjUn5V4e7mq9H4VajEztAoXDfp9kyCrb6jWP81ePX
         rike1u8Rt4BU6wig0t7ZnHZ6Xaq4op5OiVFEp43EI+PbepUlJbOynZJPFZ17VM89ADKr
         FLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740149845; x=1740754645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5+0DAJFyGg9dqAHMt/74M2g7aCiRWRLOEFqoe5G5I8=;
        b=YPwDHUggr4MnZ6jd53J15XD/gS/RmDYSSZ2gTJ0l0Nu/54SriYPbXAu44sPqSrbJej
         Xhxt3+nKFGiSqqvObzOEj/HzuZkW5IyX6T6rB/0mEOHZJxByNfRy61SH0lhTF6xMpuwp
         ahxUgbAyhgnxXi2cQx0MoHzLMvdmLJ6369a2woqQ8OpHAkedkqTQtcx1mK+Nn3A+Lc/V
         ehXoZDOEik5f5eIXqUYChJLTK70lhgtCX4//cxMQ2UYDAQl+/0esWy7D/bl4JMgppofS
         PB+0Z+NDxIl60ERhsRNIGWWGODIbm3WE/P3vh+HaVKdvHfaYXV7EXB/bTTYT3m+A9xXU
         BaDg==
X-Forwarded-Encrypted: i=1; AJvYcCWGcKlKRs+7LiFVO716jkOO2o2Am2+rAnuEboiJzqm2V8G1s0DGp1oTcN3AL9bflomGlAgPGXiZafwBeEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIXab81n2i/15TsvL0FBQZ+wY5GcILwxcXj1ALkZwXcXe2e/PN
	Mni5n7Yq42/PXNOc7OrwqB70mH+F/Bw5x01UTz/y3w9sw35JsP1xNeGmt5PRLMA=
X-Gm-Gg: ASbGncuxGjZOYfEvoI5YwOLBbV3uxUZ/Ir9plRG2O7AmOPJnuvDuCuNcGtJkLRwreTa
	I5FYf/aiZsO8fx8ttbFc4qAd1YfkUnpBq8a5KHRLbMhXNNlqNYiga0MNDKItnEB0SiSdexshy6Y
	kI264FAzTQ4xrz2ZNc+rArcYzEM4SMsA9Ri08Fr0k8GnDhuOsj3cyxm+euy5iu+LvY69kDcpGYa
	3/IZjUPUWEZ1gQBpjfVz1V0wQHaHcpdlrdKXXquYL3+pnBlXvvruBslxnP8TJgTu2vk2gwMeLzv
	yb6RZo5un5cGSg==
X-Google-Smtp-Source: AGHT+IETt9kJd9Q7ffWHdL/UIZ/UKzjspmPFiByxf6WkactZKn3mvY2VzKa7KOpSc146Ehnho9+HBw==
X-Received: by 2002:a05:600c:5253:b0:439:a093:fffe with SMTP id 5b1f17b1804b1-439ae1e9601mr32867375e9.7.1740149845532;
        Fri, 21 Feb 2025 06:57:25 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::766e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce428sm20391205e9.5.2025.02.21.06.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 06:57:25 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	alex@ghiti.fr,
	Anup Patel <apatel@ventanamicro.com>,
	corbet@lwn.net,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 4/8] riscv: Change check_unaligned_access_speed_all_cpus to void
Date: Fri, 21 Feb 2025 15:57:23 +0100
Message-ID: <20250221145718.115076-14-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221145718.115076-10-ajones@ventanamicro.com>
References: <20250221145718.115076-10-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The return value of check_unaligned_access_speed_all_cpus() is always
zero, so make the function void so we don't need to concern ourselves
with it. The change also allows us to tidy up
check_unaligned_access_all_cpus() a bit.

Reviewed-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/unaligned_access_speed.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index 02b485dc4bc4..780f1c5f512a 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -218,7 +218,7 @@ static int riscv_offline_cpu(unsigned int cpu)
 }
 
 /* Measure unaligned access speed on all CPUs present at boot in parallel. */
-static int __init check_unaligned_access_speed_all_cpus(void)
+static void __init check_unaligned_access_speed_all_cpus(void)
 {
 	unsigned int cpu;
 	unsigned int cpu_count = num_possible_cpus();
@@ -226,7 +226,7 @@ static int __init check_unaligned_access_speed_all_cpus(void)
 
 	if (!bufs) {
 		pr_warn("Allocation failure, not measuring misaligned performance\n");
-		return 0;
+		return;
 	}
 
 	/*
@@ -261,12 +261,10 @@ static int __init check_unaligned_access_speed_all_cpus(void)
 	}
 
 	kfree(bufs);
-	return 0;
 }
 #else /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
-static int __init check_unaligned_access_speed_all_cpus(void)
+static void __init check_unaligned_access_speed_all_cpus(void)
 {
-	return 0;
 }
 #endif
 
@@ -403,10 +401,10 @@ static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __alway
 
 static int __init check_unaligned_access_all_cpus(void)
 {
-	bool all_cpus_emulated;
 	int cpu;
 
-	all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
+	if (!check_unaligned_access_emulated_all_cpus())
+		check_unaligned_access_speed_all_cpus();
 
 	if (!has_vector()) {
 		for_each_online_cpu(cpu)
@@ -417,9 +415,6 @@ static int __init check_unaligned_access_all_cpus(void)
 			    NULL, "vec_check_unaligned_access_speed_all_cpus");
 	}
 
-	if (!all_cpus_emulated)
-		return check_unaligned_access_speed_all_cpus();
-
 	return 0;
 }
 
-- 
2.48.1


