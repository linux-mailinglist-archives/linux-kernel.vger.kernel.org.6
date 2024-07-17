Return-Path: <linux-kernel+bounces-254628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC0593359C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA77284B33
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 03:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD930FC0E;
	Wed, 17 Jul 2024 03:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="i99Fu+ag"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E43F9CB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721186241; cv=none; b=ZxBOrJucKz9WMbxfC73hOkfIroLFF1Uc9db/Va/AyELlU9HhrF4U+PDC8mSNYinC1rBMJj3daYWjboG8JOIuu3U8rfrKZhgu/OSNxRJ9HU7NFNXDzz6sLx3GL01sPF+GD0HYczBrfrteeZonkOWHVLcQfteTPu7tV9GAnOMJ2EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721186241; c=relaxed/simple;
	bh=BYi7JF7JviodMKR1XWkL3leD6zFc6Tx4uZcJQ4DKtVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VR0/HK5jb4322RdP1/BTzIyQBMz/54AcHIpDmdwbGPqmysl0MS8fRn8Oqacq8nE/8uBRZa/yiUBykmgMvqwdOn3rVxfX6q8Dy4PXL1cR/RH6lg7aUCCIWHhVPpN1M7HKiHz3rL9q+iFNAqpLB1oixvzSBEptEZ+VqqMWNssUP94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=i99Fu+ag; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70b7a528331so2507504b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 20:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721186240; x=1721791040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EWFTiGO2f2frr9eRub/zRL4HHqNe2quijaeDAf3euww=;
        b=i99Fu+ag/1yDgx3mVGE2xM8mhEaBhva87wvNaioJpmHhX72YvrL1oQIFCuFu3czyb7
         7p34NfLyzgogf0uuGu7grPp3I1/D+nzMa0cKWnYtRxYQrKq9IrSOg3AYhtt+ALiRE0Ga
         nt2S/6Cp/JeqMsoHuN7GkQIViYLOSwbPgiqhMRUQWnphgEpYDm1n6Lva5JJ3SFzD6NHX
         3dnv7a7QrtUghMT+dZ6HvE+bguFs/Zlzz3Cn2itinNqILcJCVFcRYivWf42P2DZQL+NI
         ev2HTWTJ4IlxYwr/48UsU1ZKgqavAcXk8/LJoiBSMUzhSxj4VZ2x+S6LkVFMFO3UqOia
         zMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721186240; x=1721791040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWFTiGO2f2frr9eRub/zRL4HHqNe2quijaeDAf3euww=;
        b=o49cXnBq7J5oQ8Wg0wlb/fd9AK+Y7xtXXRVKy8Dk81aUH7YbEt/UED8iXT4YjWZdOY
         5r392ShTqbgFEQ+2mdePMPe5Ih6ml2WuJWUNfvy2JO7gV7wR7ZpU41O5tmVGaT/k/V1g
         5Bd17JZfRKNDeCcmDMPF0PCnzHYP6rI5xZZG4yIsTGOfDCxjpVicr+TpGyiLpZ30yI8w
         AG5iRT7SiU7FhKTtdp2IFJh4NbYSk1E5L1cEFo3dDQYSnYBgIpe6bl0DrFaM2CoJpSWt
         D48lOzPARCA6tGvQgOaQN6ASR58qEO4y5KqScXBgh1hnfYis4tljs8NHvLrjjcPwJgco
         mjuA==
X-Forwarded-Encrypted: i=1; AJvYcCUY37/2HGOgMuniCoQm24g/Yr483upL0rSFUAEx6mSMTP/x72yDkMK/4PoDaEfPl/imYRYw3tj+HWFnmEi2qsIrp6XijqcBnsxHcE51
X-Gm-Message-State: AOJu0YzM6N+px6n+iIXnh/DDnZwZqRdB5fI76cDZ4ux7vCkHN3PHIxLL
	i8Uc3Y4gcf9N/IXjkWpPFqxshbR3wNBnb8mrvvcviokRTnH/eM33Q7DSwcYrVRuC8li/ERuSPbk
	WXHc=
X-Google-Smtp-Source: AGHT+IGGGKe/YDY7Jqbt+uu0lBcnWReQ6Ngm795GpgDGZAx/hc0Kd5oCqQl26XxwWyLa4NjoXv1cdg==
X-Received: by 2002:a05:6a20:918d:b0:1c0:e9f7:29da with SMTP id adf61e73a8af0-1c3fdca1d6fmr668586637.24.1721186239453;
        Tue, 16 Jul 2024 20:17:19 -0700 (PDT)
Received: from hsinchu35-syssw01.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bbc4db1sm65392615ad.112.2024.07.16.20.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 20:17:19 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	tglx@linutronix.de,
	peterz@infradead.org,
	anup@brainfault.org,
	samuel.holland@sifive.com,
	tj@kernel.org,
	alexghiti@rivosinc.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	greentime.hu@sifive.com,
	zong.li@sifive.com
Cc: Nick Hu <nick.hu@sifive.com>
Subject: [PATCH v2] RISC-V: Enable the IPI before workqueue_online_cpu()
Date: Wed, 17 Jul 2024 11:17:14 +0800
Message-Id: <20240717031714.1946036-1-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes the hotplug cpu stalls at the arch_cpu_idle() for a while after
workqueue_online_cpu(). When cpu stalls at the idle loop, the reschedule
IPI is pending. However the enable bit is not enabled yet so the cpu stalls
at WFI until watchdog timeout. Therefore enable the IPI before the
workqueue_online_cpu() to fix the issue.

Fixes: 63c5484e7495 ("workqueue: Add multiple affinity scopes and interface to select them")
Signed-off-by: Nick Hu <nick.hu@sifive.com>
---
Changes in v2: Rename the cpuhp_state of sbi ipi

 arch/riscv/kernel/sbi-ipi.c | 2 +-
 include/linux/cpuhotplug.h  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
index 1026e22955cc..0cc5559c08d8 100644
--- a/arch/riscv/kernel/sbi-ipi.c
+++ b/arch/riscv/kernel/sbi-ipi.c
@@ -71,7 +71,7 @@ void __init sbi_ipi_init(void)
 	 * the masking/unmasking of virtual IPIs is done
 	 * via generic IPI-Mux
 	 */
-	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_SBI_IPI_STARTING,
 			  "irqchip/sbi-ipi:starting",
 			  sbi_ipi_starting_cpu, NULL);
 
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 7a5785f405b6..0a8fd4a3d04c 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -147,6 +147,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_LOONGARCH_STARTING,
 	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 	CPUHP_AP_IRQ_RISCV_IMSIC_STARTING,
+	CPUHP_AP_IRQ_RISCV_SBI_IPI_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
 	CPUHP_AP_PERF_X86_STARTING,
-- 
2.34.1


