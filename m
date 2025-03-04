Return-Path: <linux-kernel+bounces-544096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9150A4DD55
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CAB3177687
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C612040B2;
	Tue,  4 Mar 2025 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TOWIUasV"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9E9202995
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089626; cv=none; b=cbKE4A8p5gUh840ljfXLT4tt5up+XJSyVB8/nV6baVGRdfpJI83ZtPMRKU/TwJyokDQ3+awdqAl3pWjGbwU77E657IzRYvK+9NL24Yvjw9fZEAUGhG1vha58WbmGF3bp3DSNCTejFcVxK8qbyYe2cn6LGUgZ59Pg0+dgh2piACI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089626; c=relaxed/simple;
	bh=XQFofp4oQ2VYb6uesqvYvCQY5act9lGNRcE9BKooBUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMkqkurTrh/xytztto8NUxiURPZ3+BW2DkALE/uYiuD8BSlQqoDcDbkMDOyfXmcKGAQigkUdKiZN3vjmPpEocHybH/R6uQWDeq4jucZXKNdqG63/vRFliRoDZSZk7ZGwcE0MmakuX0i6mtOCDo6PGEKVCdyU9S5HN1pZiKjcGzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TOWIUasV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43bbc8b7c65so23965925e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 04:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741089623; x=1741694423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKhFFnzXyWbQAGhMWM6ZzS3r16qIjR6tEgWbgaYi/y8=;
        b=TOWIUasVD0Zy1yhUTpZPmn6YupxGAf2fhApm047i+SFOj1OCv3DoQPWp736+VwRthd
         ovqkMvKta8y4L+EJKZncyMXtWgEorT0PgHwf0q85uZ5CDJ+awTWVzhkKrWEo3Neg+fQi
         hNr3bzQnYcWSQnk7rm3kVme10lUFcN+X+H8PcTmjslAZdlSYbFf26LpDF5rgQRSxvE4A
         la5jRdQHe3iL3AkicMWFDn8gOyZc6dvI3hx/WETE9XnWyJOXRSWp0JCv2DkrPA8DSguh
         QPyWuDrAxzeLDzztvkJTImBEnStCjkY6qQ2ZkSAz9LGEGQZpnOlYy9clSYcWs3uq1PVq
         PlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089623; x=1741694423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKhFFnzXyWbQAGhMWM6ZzS3r16qIjR6tEgWbgaYi/y8=;
        b=WYozWR6d2udGmzoOnATtiORYmLe4EbuL8ViRPYi5vuvsI9ISqBX6KKW04YQPCAoMf5
         yLTyZh2ECcL2yhyHXA1ywiG4hHMq3DCiUtfYBxKNWEuU7GgNXFn/+MPPSSbrT2aC8mBz
         pjCSk2/1IAFDniXxBb9lcEdSDNWlZbbZK8Y3mL1BJUB2dnanDZ9gWZbS5B+Q602EvKeQ
         xm+kkLJX9A3Zk/pMBr0WnIibpSS+sDex0R+LYCbmU5iC+M9RnVyzfaubflaftlt09XZL
         M9x/n5ws3B/lFhu0v/V/fLs01oSG/JbT9+J47xxjxgkPczd1kf2rOzFGr+WXJ+SK/B/R
         CXyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXMVxCnB4gmfF8AuIuR3htXOQQCSkdyTlqZ05zCIp3C1j4qtlD1yHMFTRapHlVRY5AM/DimAClXkbhki8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIpOA2//XKOvLxKHYGe5i22o9fkZ6/kQ+NABrMI/BBdj3B8lFQ
	fXWCPevITZstLUn1lrbBlEdKIpVeBVjbue3Djbk3ra7001cN7B7W4GCgVBk1Ybg=
X-Gm-Gg: ASbGncvztSU1hWBpU+wvJaGf5zanVgdCAbWo7cabhHfHK57jqN/ECP/YUB6EI6KhSOI
	3r0VDn4y72Xlqd200OzmlS6Ypzx9ysE7+mxWQYYLoyBvw52F1joPigTvh2qB3GWCzzNYfVydXUY
	+1xePr/y6koEc1TlZayxrmPBxruvCWb+uLRd7OCPmzl3Ny7xVWmL3QCauY7TJlsIefvweLzgrWj
	vZZjwMOVpadHrj5Z5GX5SUHbr7KDL3bMtAJNY61GYUXxszkkZx4toG+jaWqj2DBdqKUemtvn8Jl
	N604kLVXEmGAJ5riPUFDb0kN7AsEkoto
X-Google-Smtp-Source: AGHT+IGwC3NsIIWUjYgv3G2JO2vmP8wTEbddF/LPoT4rEkNoTbLO+SirlMYHhSaFI3g4F2HReIh7PQ==
X-Received: by 2002:a05:600c:1d8e:b0:439:b565:f457 with SMTP id 5b1f17b1804b1-43ba675c3afmr162133765e9.27.1741089623258;
        Tue, 04 Mar 2025 04:00:23 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::688c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5871f4sm230729625e9.39.2025.03.04.04.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 04:00:22 -0800 (PST)
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
Subject: [PATCH v3 6/8] riscv: Fix set up of vector cpu hotplug callback
Date: Tue,  4 Mar 2025 13:00:21 +0100
Message-ID: <20250304120014.143628-16-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304120014.143628-10-ajones@ventanamicro.com>
References: <20250304120014.143628-10-ajones@ventanamicro.com>
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


