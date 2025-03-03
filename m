Return-Path: <linux-kernel+bounces-541164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCA6A4B96B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068BC1889AFE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FFE1EB193;
	Mon,  3 Mar 2025 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jI/464iD"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19951E9B31
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990879; cv=none; b=VveCNNZx/FQbHf/wI8TF3grnuIS3WwhxpO1orA9yKnY7GGx+IyjRa2RXEz2JcMmcMW0lxZY15X64QVc5IEjjFZQcQuSbVCT8gfHu7sdwZZwlNDrxW6FTa3fv89L9z9f6AQPIACeiqdEE8DP7xSyKo6rl/rXHuO0oMoMFr41Mq8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990879; c=relaxed/simple;
	bh=Lp1gbVGcqJ1nXjiXJP86mZY5erZ71tjosxRZXJwFwCw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=NNJG1CZAJFCfMQEA/YkfH/i4V3+J/bFOwyoJ9iJz6GyJGAEJEyR4Wenr54xVTYzs033OLsM9MT7k6USHHl4AhKG/NSWoQOeyET2f48ReC82yflBkukFaMEMsnpT7rPu6U9bQJXrvE6wjmGbE1cinKerRG3VeEjORO3bWwAP0r8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jI/464iD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223a7065ff8so21328445ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740990877; x=1741595677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=di2WoUZvURtoNarBPZOzepS2NtA7sut6LRw/YPG0p/I=;
        b=jI/464iD4dvpOA0hQThxdxjY/L7myA6VNLgZAF9EQ3xFD8hykCr0UTllApnwxxEw87
         gA8J/kI6r5Y6h/GhKzM0ylckHcIDGnSP5YXTsdOcZIP6KhPmdpZRm1TfVY1ALbCt4+7b
         IaqaVepxbd/0PptiQRy7s6sVl6Wh3F5RjmEUxmAnpcDmTdJoGNHRIaFj+gNrnot2EAZB
         waM0vHdiCVBVWcpEhGgAGuQfjGivsHrlut8ygM/VB9JiQ9Pmu6ELM9rl2HRAAJ5LrcSm
         OXA+jkKrRyzCTS93XcvIN3wYB5YVCYWEJB+s1Q2XHo+HlO77by61smfeqBwPzd3HxPRa
         xrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740990877; x=1741595677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=di2WoUZvURtoNarBPZOzepS2NtA7sut6LRw/YPG0p/I=;
        b=fuhLKQI1hqe4SYI/udXl0bOHjqrr4P9xTSB9JOFTDVP56gmIv19y7TDQhT4meJlIk+
         o8yNhbN56/HrPXiowaDB1GTm7NN4kqs8t1pL0qGIGI5WQkvnJYGtn/EhD238Qpz6AL62
         G3RLygFVAIAKM6kvB56X94gEuIV/shY6uayu9DqIJtpWR+zq/BjKyWb6mu3vIcc0kPpZ
         N833nNWP4ISf8wkEiagzeFQ6W2jaWa/MtBAKli9gU+vSS4d1KbBdV2JTnDpf1LOPJg6I
         6aQIET1f7ayhyrzTibRPn6pqUjUTqhDGBt3iYcSS9zEQN4kecUu31W8Me16KvmMRaFfM
         EaIg==
X-Forwarded-Encrypted: i=1; AJvYcCX6UzFHW+lj4FUPNp1METEZT4vo/i+VpAvWnJxFYxbFWDHkf3zx4AgbXL9G1M+F/8KEP/MVzWlIOLG7kEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Ews36GxDFbtSEVoWFa1ihdIC9sYgTiSJr/cF89nRS6lHtgu+
	+cJd33LOhJ7Db6IvzXIFViyLh+3aJ202Jd5ScFat+pvAun2eXRJXEkm4vh/p1No=
X-Gm-Gg: ASbGncuSQ9Co6dZykswmgc1MB7qlCBuPC6Nx7OZy05MdtJs6frfWJpgv+MrsVhI5sEN
	0FJKWQADq/f/DuXVl0sIFM8zfYIaR1wTqN4Gqta3kEq+1ymFrYAhIh86ZGdUoAW0R8HNiPbIBxw
	zDSEYs/zVP6xi/VwR9KLF5jYu74cU+LZSUecY4eC5xtRw5sX46xTFE/G8imHA12/tOAn2savlm3
	XOnFtvgypOYpxCf2DqCRxgY2z/ODHg/vlXee6OZ+ro9cESTQtEOI4TuWAfh+CTeROmKvU7Rtxx5
	+9SvgqIy3X4gvdeoGEU/12A642LdfLbCL/bvfGlx8wgvfesy9mzsZotd2S5/qWU+U8hnni/xZpj
	rF1c=
X-Google-Smtp-Source: AGHT+IEk0WrjnIZ7AWKUanS9IbxIHGJTjqY1Da4XJZVIQYRkq7p3R9SLY1NnZNNc1YpQ+wvncNLDAA==
X-Received: by 2002:a05:6a20:c891:b0:1ee:c093:e24c with SMTP id adf61e73a8af0-1f2f4ddb73bmr23471716637.30.1740990876998;
        Mon, 03 Mar 2025 00:34:36 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe48882sm8289808b3a.48.2025.03.03.00.34.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Mar 2025 00:34:36 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: apatel@ventanamicro.com,
	atishp@rivosinc.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	cuiyunhui@bytedance.com,
	samuel.holland@sifive.com,
	alexghiti@rivosinc.com,
	jassisinghbrar@gmail.com,
	takakura@valinux.co.jp,
	valentina.fernandezalanis@microchip.com,
	ruanjinjie@huawei.com,
	charlie@rivosinc.com,
	conor.dooley@microchip.com,
	haibo1.xu@intel.com,
	andybnac@gmail.com,
	ke.zhao@shingroup.cn,
	tglx@linutronix.de,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: print hartid on bringup
Date: Mon,  3 Mar 2025 16:34:24 +0800
Message-Id: <20250303083424.14309-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firmware randomly releases cores, so CPU numbers don't linearly map
to hartids. When the system has an exception, we care more about hartids.
Adding "dyndbg="file smpboot.c +p" loglevel=8" to the cmdline can output
the hartid.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/kernel/smp.c     | 2 ++
 arch/riscv/kernel/smpboot.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index d58b5e751286..e650dec44817 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -48,6 +48,8 @@ EXPORT_SYMBOL_GPL(__cpuid_to_hartid_map);
 void __init smp_setup_processor_id(void)
 {
 	cpuid_to_hartid_map(0) = boot_cpu_hartid;
+
+	pr_info("Booting Linux on hartid %lu\n", boot_cpu_hartid);
 }
 
 static DEFINE_PER_CPU_READ_MOSTLY(int, ipi_dummy_dev);
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index e36d20205bd7..601a321e0f17 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -231,6 +231,10 @@ asmlinkage __visible void smp_callin(void)
 	riscv_ipi_enable();
 
 	numa_add_cpu(curr_cpuid);
+
+	pr_debug("CPU%u: Booted secondary hartid %lu\n", curr_cpuid,
+		cpuid_to_hartid_map(curr_cpuid));
+
 	set_cpu_online(curr_cpuid, true);
 
 	/*
-- 
2.39.2


