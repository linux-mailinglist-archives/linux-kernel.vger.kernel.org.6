Return-Path: <linux-kernel+bounces-525962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5144A3F7D8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040C11899420
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE490213E75;
	Fri, 21 Feb 2025 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="aeZA84TU"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C11212B21
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149850; cv=none; b=prKcPC6o79CIXvsEF4PLEtQeeK6wh8+v5kgm296oPKqKKEmqj5/c9RcUefL/NbjjbvCngzqCOZ1W5VfSlYN3hJStxmnv+ZrTMBthERzKDX+ou7vfN3pLyMaI933FSKFxhDW9bhvdPd/pHpJghkWf5TK6y7eXi+oNrNC4DbK0QPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149850; c=relaxed/simple;
	bh=ZYlkgyx4zI7Kcsijhw4F+FJvIMPd6j6bFB1dgFR6pQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erH17e5cqletxwzAdh7APaBIBSGKrFskCtTLkcSVt16DbJWVqgIwQNTtQDASkc5DHYgKV5wDsUxVnCdQbLRvVJ6ZgWcg57aLu94CcB7Id/bLl9+DcYHnzBrNycm4/yveSojkk2+cd94gHX6EY/LtW8scN8eiSE8bCOwN28w2Qxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=aeZA84TU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so14099045e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740149847; x=1740754647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuV5PBYNprCWaplq1fE9KG6ZTDkt+mehdrAbLFdmJ0U=;
        b=aeZA84TUUTxU+2K8S9K9crIro+3gNxKNfB1t9yuMHsY77yjNlPuTCnn3lCIRbRLGYM
         iz6WZxBoCPr3n/w9BWwsG5xRyhrHWy0Qmqu/TQRsHF+jaks9fu0B6pUdLXMb+qT6ajdL
         +TSVDUxu541ZP/Cbxog01hKo5ldqMClT/+v8paJ2Rtjoi5vVAwtC1MIqYE1UGNGBIhvr
         Afh/oeeIC6kZ44UAo6KezfJC9wsEbLEgCzQY6GAUrOWmcgRZtpPueqs7+xGH2snHcOuC
         F4IzFNA/XKcixs4Imh7hMFUxsqtNLS26dXCVeslVq8JORwZlm6PbvjhwXnYwcspdKp0Z
         CkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740149847; x=1740754647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuV5PBYNprCWaplq1fE9KG6ZTDkt+mehdrAbLFdmJ0U=;
        b=UKWBXqK78XOO3b7w9mc0Aidwbj99sG66+F5S9r6crWxFkQJm2ygKB1apgqPQhS82D8
         B2GkmCmsBkp/D7nuUsPUn4XNGAK71GhNcs67aZoHQNRPRVU3VoMpCH6lp7lq5C6l957x
         dcehV4lDqt73d5/JF6vk22zXB4eLAkRBiYAvAzI6PE9dWv1falB3N3i8DOQggIdnh7EH
         2xgMgMY6cO+YGAoCl2qBWuC2r0NTdsXnDN+E/tZWm0fkITXH/pjWlDeux2OHRKumVN/h
         R0jAfkm+wXf123V8owh6gbHuB3Taku1qkLO72nRvaxoeYIceY8iRi4x9SD53hxbcr5Gk
         EmVA==
X-Forwarded-Encrypted: i=1; AJvYcCVamFauwzI4LbXBItzGQaXdn8SYKe2cgt9gqOOVK8RV/oG2HdPQaLkHsmM8ryxClOanK+Zjato4Vfg/HTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0pcGb/3sFODBP3VUdUCWvbEeiMtmGlGAmlNplFZI/MOafd7iq
	fS3VMOOKLTAzOKChZ4/Thk5hjKN44Vu94KEjgdit5GxlMq0cxeCkZg1iX9CHv08=
X-Gm-Gg: ASbGncsVmFsqmHjgYBDTMiKvzKVvPgIGEUY1mVFrhwnNb8lhKkdFwSKsI/mJUCh+cAL
	72ohcUzD8Jlb9TuD/dDT4kNA+7TSlLH2xaGdUHllCrUlKL6JxQfDVQxu4VmoHCi11xnVbsJ0ct0
	HGwkWt50XfVkt72ghKL8RJABZDXEqWy7W+rmqRZiYpYXC9CR1Utw0WYh785GxocQ4BBh5GMt6Iq
	pPOIEfs2INsgowDQrlygNpqm/4oOVYpdi7GVxRYgygsjE5pft3YwrP+1VRX5pJRhFx7TVatuVbi
	Bb5H2W6D+sQThQ==
X-Google-Smtp-Source: AGHT+IGHZnZDVV5eRijtS6wrNNcgTs4f/Eq2MbcFOsu4rDM5Dk/QukfiIU0puOl95OM+JkdtWtwE1A==
X-Received: by 2002:a05:600c:3515:b0:439:9f42:c137 with SMTP id 5b1f17b1804b1-439ae1e6ee6mr35034335e9.11.1740149846766;
        Fri, 21 Feb 2025 06:57:26 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::766e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dcf08sm23925368f8f.36.2025.02.21.06.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 06:57:26 -0800 (PST)
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
Subject: [PATCH v2 5/8] riscv: Fix set up of cpu hotplug callbacks
Date: Fri, 21 Feb 2025 15:57:24 +0100
Message-ID: <20250221145718.115076-15-ajones@ventanamicro.com>
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

CPU hotplug callbacks should be set up even if we detected all
current cpus emulate misaligned accesses, since we want to
ensure our expectations of all cpus emulating is maintained.

Fixes: 6e5ce7f2eae3 ("riscv: Decouple emulated unaligned accesses from access speed")
Fixes: e7c9d66e313b ("RISC-V: Report vector unaligned access speed hwprobe")
Reviewed-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/unaligned_access_speed.c | 27 +++++++++++-----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index 780f1c5f512a..c9d3237649bb 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -247,13 +247,6 @@ static void __init check_unaligned_access_speed_all_cpus(void)
 	/* Check core 0. */
 	smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
 
-	/*
-	 * Setup hotplug callbacks for any new CPUs that come online or go
-	 * offline.
-	 */
-	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
-				  riscv_online_cpu, riscv_offline_cpu);
-
 out:
 	for_each_cpu(cpu, cpu_online_mask) {
 		if (bufs[cpu])
@@ -383,13 +376,6 @@ static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __alway
 {
 	schedule_on_each_cpu(check_vector_unaligned_access);
 
-	/*
-	 * Setup hotplug callbacks for any new CPUs that come online or go
-	 * offline.
-	 */
-	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
-				  riscv_online_cpu_vec, NULL);
-
 	return 0;
 }
 #else /* CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS */
@@ -415,6 +401,19 @@ static int __init check_unaligned_access_all_cpus(void)
 			    NULL, "vec_check_unaligned_access_speed_all_cpus");
 	}
 
+	/*
+	 * Setup hotplug callbacks for any new CPUs that come online or go
+	 * offline.
+	 */
+#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
+	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
+				  riscv_online_cpu, riscv_offline_cpu);
+#endif
+#ifdef CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
+	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
+				  riscv_online_cpu_vec, NULL);
+#endif
+
 	return 0;
 }
 
-- 
2.48.1


