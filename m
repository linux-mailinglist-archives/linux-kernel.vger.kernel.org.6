Return-Path: <linux-kernel+bounces-253518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84399932267
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E3D283145
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634031957FD;
	Tue, 16 Jul 2024 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TllO/yT2"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BC44C74
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721120730; cv=none; b=OgEP+ybtdpyvn/LQPCS3aFefxXLGlK3gBMku+Ts2He4hdf60JIeapQ9m8l8aVRfWBNquQy74OWsR6C1JloVOWhfxX11YGo9T2bL/NPDrclu7QER755Bt68+Gc+vn4E2JF2cF/so8ObUuEdOolD/9n1h3PgHPiFQZwRZ3AqasX14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721120730; c=relaxed/simple;
	bh=Mg96qArHZfwpqQq21AXGnV5/4jJWVJFXj0BShYLEWnU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Af3O12kLGYzEI45AImVZsrkxDLlqzEn2qkMmCbFMFd/ifA07irVHp4K/qvTKbfETOa3eDuCFVSBA7KYTLtFNbEUufA3LhCgJ7+AFicuXHpxBRRfxjRjFiGABGEZW0GAPBaW53i9OtOmWI+7wErMi+viBXVsA64PSDLaBqFN5WXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=TllO/yT2; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-25e16380bc9so2537224fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721120728; x=1721725528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fur+9iY39EnHu790PCA6BLD0AfhClKqjFPG8SfLx3b4=;
        b=TllO/yT2braM5r2yZvKRxSYcRpaDCUXeE+rE5xeed64tJSsFpECxH6jOZ98rulkBm9
         x314iZdttR2lVBqKCmdOU/HBrY+iJK7ZSQlkH5om39Nq1Bda9Eaxxxw+zgGtqwJYPIiM
         QHtmfDI1Uq9BRi16vJ+YF0POvigpPJoMsH/6Ry1GQnwEO6VyRYhMZR1+l+9XZNlQuD4F
         kbDN2WvRMiC46MnBITOmE8tTe9SquvThmvDiJTkYvv2t80ou/S+7NOeDMHj3OFYrphVY
         pp+BH/7dPa627jL/Oz0nST/Jz1FnASRih83Hmgm5t3TGchOyjSelBoN3iNAW6ipUvvd8
         kb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721120728; x=1721725528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fur+9iY39EnHu790PCA6BLD0AfhClKqjFPG8SfLx3b4=;
        b=ndOMzALFzm+QSl/aZK703OckmuxzWJWZ+L709JTtD5xz+E7DH5fK8Sokeei61nXH3J
         sXhlfDslb7v+t5JI0V28fyrq4vj1gfzEbFjnNb7izNhVtLa/F9aHe40LBFuCVgE0YBif
         wKNBCrTrWQARp7OegD9POcQshrWBop6LOuSDUZOtG7azDBnEy4Cg7Pc4zUQdfRzRZpos
         W1Eo6jkrn4PUKWhGJS+/lixu1nA1ueFZMB9et16K2NpTUUxWaZt6Ag3N5fLqurMHmJTG
         MeJsAkovDNLey2YBUnO4f8m1qopkDQOOL7okSt4rN+gNGVPLH50leeKlihEDGfkTXh0o
         yqcw==
X-Forwarded-Encrypted: i=1; AJvYcCUTfF9VwrAjm7+GlQakedjrbdrdz4ztMuyhqyXq1eLx6UtGAwiwBP71dNRVLOhaXY1Ceo+C1UPSFBZ0fSy/xnZFbJsDTgiqlNb39SGa
X-Gm-Message-State: AOJu0Yxsl533cv7JFphvjVpdZ9XrC+i4umWDcADiXag4VKAYoXafKfOu
	3cHU6letI0VPmXvxZGmS196kcD20vqNrFh5E1kROm2M+OY/r+p795o0p1emEgq0=
X-Google-Smtp-Source: AGHT+IFUTI7bRK0GiRyBdxnIcwWFeziW4Cg/oaSJr7SOONPnOwSkImxAoJVzGyTprsvzWvSALI90Yw==
X-Received: by 2002:a05:6871:294:b0:259:cdf1:b8af with SMTP id 586e51a60fabf-260bdffe1efmr1191734fac.46.1721120728055;
        Tue, 16 Jul 2024 02:05:28 -0700 (PDT)
Received: from hsinchu35-syssw01.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eccc48bsm5770157b3a.203.2024.07.16.02.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 02:05:27 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	tglx@linutronix.de,
	peterz@infradead.org,
	anup@brainfault.org,
	samuel.holland@sifive.com,
	tj@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	greentime.hu@sifive.com,
	zong.li@sifive.com
Cc: Nick Hu <nick.hu@sifive.com>
Subject: [PATCH] RISC-V: Enable the IPI before workqueue_online_cpu()
Date: Tue, 16 Jul 2024 17:05:21 +0800
Message-Id: <20240716090521.1752166-1-nick.hu@sifive.com>
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
 arch/riscv/kernel/sbi-ipi.c | 2 +-
 include/linux/cpuhotplug.h  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
index 1026e22955cc..e05e68de8871 100644
--- a/arch/riscv/kernel/sbi-ipi.c
+++ b/arch/riscv/kernel/sbi-ipi.c
@@ -71,7 +71,7 @@ void __init sbi_ipi_init(void)
 	 * the masking/unmasking of virtual IPIs is done
 	 * via generic IPI-Mux
 	 */
-	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_SWINT_STARTING,
 			  "irqchip/sbi-ipi:starting",
 			  sbi_ipi_starting_cpu, NULL);
 
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 7a5785f405b6..57dcf1229b27 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -147,6 +147,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_LOONGARCH_STARTING,
 	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 	CPUHP_AP_IRQ_RISCV_IMSIC_STARTING,
+	CPUHP_AP_IRQ_RISCV_SWINT_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
 	CPUHP_AP_PERF_X86_STARTING,
-- 
2.34.1


