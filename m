Return-Path: <linux-kernel+bounces-525964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07991A3F7DA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 081F97AAA62
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B03214803;
	Fri, 21 Feb 2025 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="R+Zu6ThX"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B16211A14
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149851; cv=none; b=DDhOTVghs8TcH0WU49elr0EbOOmy2nyffkdUUtCoZYNxYokks5oauZH5GNqXFz1PqdW+uWQvtsv078o6Sfs9ySfjTM49l3NOc4yQKW4LJxHaN5ubEy3mXW7i46dKekoKdtOIe/VwsudeLEyhGCetnRq2NiCE6wh2SW+5JdQKWLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149851; c=relaxed/simple;
	bh=XQFofp4oQ2VYb6uesqvYvCQY5act9lGNRcE9BKooBUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0REmNH9LjOJq8x9GWgc7K984TFxJ8DQgNz5A49UeLmY4AElhIxwqZZ+yMPnEAxi1+SbuyEk0EcVFOtyA6HyNK3omd+IQRShXm0/aBr7tPggOMv7XQ6sAIh/6kvQpP0TxEF/6kAEDlkLlTcyB0wIi3QHy0a+g5N9ELb8GYErKS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=R+Zu6ThX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so21572335e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740149848; x=1740754648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKhFFnzXyWbQAGhMWM6ZzS3r16qIjR6tEgWbgaYi/y8=;
        b=R+Zu6ThXQhLx4AM4ycS68UEMhzVBDf0KRG33kJ/sfVaMe0G8Kzk8KZrye37PzTfgL6
         WoJlOBDQ8BXHX/SJRDgzYfd7iojp60D2/T/xuycxo2drrtAAkqBQajor+sX+2R84Uxin
         Fx/kbGH4362Q05ZHE8aTmLaJB4pO4074YcTwDG6Ens8qnCrdihWuY7Xd1/cVYT5qMh3W
         PME7J12gzRNfurTxQFRmJMEALks7gnGPh+uMrh+PiQ9Qm07Ia4lUC7rdbnotJD/2MZ4Q
         oAel+Qj14fzOSqrE+MRzlgFBKf0JrTqRuqvi1lyP/g42B4n/YvzY46zC2WfqSVJKHHXr
         YwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740149848; x=1740754648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKhFFnzXyWbQAGhMWM6ZzS3r16qIjR6tEgWbgaYi/y8=;
        b=GBNYlpYisZHKY2QdLjXfC5nDD1pq9eesCqA9Nmv2qNiehGwNao8Srm7ppgfL/QSsd9
         B2wfhfh0O/uqyj6N6BjvvQ5SbHnwzcajMa2bniuG+Ou6t05h7MGb+tjtsKz24FQE6kNg
         uBO4MZyn7lyspLd94cPZyhpN1FvdfaWx8Y1521YYK23t3NuM+tu/W3fDKMWCduxFB2DA
         DhA3yKODe6OZqY5w6zcJqBYmEVQHgVlevLg3dRLyi+aCRElI8KUdnNSsrEwYRh+1PRl9
         2HPq9EGH5llWXMbiaNWQSgiWKpTf0pSl3UywuOEYyynAa0xrAthxeEJA7NY42ID8iBLK
         Gz0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVX3ZlHnS4yV/oTW11pQbshWPKbhN08lpbg2y7vV/jwhqwn7+1x9ofzeBi01klqQA+IvpZ2BqtDvBa3mBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrzOyjCudyM2so3e8ljVZpNsKx3j54ZnnxOb8aSbXZk2Zlsw/Z
	8Yzo0X8YxO3Ufnp/pxwW6Z5dOOt2ZFggwbVLIIV6lfuer6Qi9LZpcTHYoxKc1ew=
X-Gm-Gg: ASbGncsJsMRQWCPbBgnMU2BcH+Iyx1iRVp0A/1tY74ZPs3u1wIZknBH7BLjfo1FgTY2
	1Ujdn1+Vktll6hlHiiz91j6VNKMiJtNnhD1wR3O4lmCNl8zwsENJORbH1Hzg55SCNBAIsXKLTu4
	/oxqXNBZCOGWJmTgJH3w/sv1eSYUr6whycwc9IceYP5+DNXRM8SVHZzA+E/iOjYNw1/CJEM26T/
	v5uGyD4oidqGhZ+6VoIZvPRbiP1ogEKtLZsfucgx3Hj2ktAm9gEAhoQa/uW7XckKUIg/6Kiuo8h
	0hwiiiXfif4asw==
X-Google-Smtp-Source: AGHT+IEkXpICcfr44M3mVSGYGMJpSIpS61Nr1K7aTqNzeXftVjarUfFAfjEfBCRs4wT7c1ZnFz5qtA==
X-Received: by 2002:a05:600c:470a:b0:439:a139:7a19 with SMTP id 5b1f17b1804b1-439aebb3155mr25569025e9.23.1740149848034;
        Fri, 21 Feb 2025 06:57:28 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::766e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b030b2c8sm19891515e9.25.2025.02.21.06.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 06:57:27 -0800 (PST)
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
Subject: [PATCH v2 6/8] riscv: Fix set up of vector cpu hotplug callback
Date: Fri, 21 Feb 2025 15:57:25 +0100
Message-ID: <20250221145718.115076-16-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221145718.115076-10-ajones@ventanamicro.com>
References: <20250221145718.115076-10-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whether or not we have RISCV_PROBE_VECTOR_UNALIGNED_ACCESS we need to
set up a cpu hotplug callback to check if we have vector at all,
since, when we don't have vector, we need to set
vector_misaligned_access to unsupported rather than leave it the
default of unknown.

Fixes: e7c9d66e313b ("RISC-V: Report vector unaligned access speed hwprobe")
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/unaligned_access_speed.c | 31 +++++++++++-----------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index c9d3237649bb..d9d4ca1fadc7 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -356,6 +356,20 @@ static void check_vector_unaligned_access(struct work_struct *work __always_unus
 	per_cpu(vector_misaligned_access, cpu) = speed;
 }
 
+/* Measure unaligned access speed on all CPUs present at boot in parallel. */
+static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
+{
+	schedule_on_each_cpu(check_vector_unaligned_access);
+
+	return 0;
+}
+#else /* CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS */
+static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
+{
+	return 0;
+}
+#endif
+
 static int riscv_online_cpu_vec(unsigned int cpu)
 {
 	if (!has_vector()) {
@@ -363,27 +377,16 @@ static int riscv_online_cpu_vec(unsigned int cpu)
 		return 0;
 	}
 
+#ifdef CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
 	if (per_cpu(vector_misaligned_access, cpu) != RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN)
 		return 0;
 
 	check_vector_unaligned_access_emulated(NULL);
 	check_vector_unaligned_access(NULL);
-	return 0;
-}
-
-/* Measure unaligned access speed on all CPUs present at boot in parallel. */
-static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
-{
-	schedule_on_each_cpu(check_vector_unaligned_access);
+#endif
 
 	return 0;
 }
-#else /* CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS */
-static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
-{
-	return 0;
-}
-#endif
 
 static int __init check_unaligned_access_all_cpus(void)
 {
@@ -409,10 +412,8 @@ static int __init check_unaligned_access_all_cpus(void)
 	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
 				  riscv_online_cpu, riscv_offline_cpu);
 #endif
-#ifdef CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
 	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
 				  riscv_online_cpu_vec, NULL);
-#endif
 
 	return 0;
 }
-- 
2.48.1


