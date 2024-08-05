Return-Path: <linux-kernel+bounces-275087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F58948081
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE02B2826AE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD37016BE04;
	Mon,  5 Aug 2024 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VaBMSlaM"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781A3165EF4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879505; cv=none; b=ohbA4gX7RDDh9FZsyr0I+7+TQg118e4imLcH1K9stpRtZYFSMYOxmyQ3lyf61auV/2yL5HUpF2SyDpLaAn3feKB4bAbCsgEdJDIQpAN6BjuwIrptYEy7KlWNw+84huyMGfUPR9dXhq5mCGoGsWM57EIfNmjPefHArYzHjpCn5rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879505; c=relaxed/simple;
	bh=gzNYS6EG/C+/J22vSWSVkK/INf8H7WnGIxBg1zVunOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qPu3kfQ2Nqm6+bVt8Vca783Q5MWde6RfAahYGAjMYMEhDfU08SbrsWD9furGrPcIxxauJmT/1taY2ALlbbR3lepEqrTymf6ykOaShVno44wlb/LfHHdWHKCTJZ0azTpssYfMNZjnK3FBcWFMeBqbXAHzAR4mylOrYRHUbxYb374=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VaBMSlaM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fec34f94abso86437475ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722879502; x=1723484302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yIqXJOcsWTmDQT18ltvBkvSKfPE+CI0ACIv+CWuAfhQ=;
        b=VaBMSlaMR0hX6hVSyqusF1FI1H7DHUBlj8ECknqViRb9PSx55hIg4rlEMbB0/9/5YD
         l74bRlrADBGdX2kWRysOX8URZ9ks+Vlw5PoJP0VoiDmyVQmNIrvUl3e14TEhF3YTkYnr
         P/CKFYTnjZkWyiXGqkaX1wYej4di0Y/WeuTW7ly2Bpu2qKIY4q94agWyxj7fmXMCScul
         jumnDHt2WJljzBY1hupEh+FXH9XZA2jq5yTVP0A4LAv6qKEJ+dSzoIufTkaWttKAJVeF
         N0/q/drELwTdEIoqCR5TeeSkhyy8jvL9jkRuRhOVwfDcTuGvJVVapOWG/0sAkvkWJUMG
         JuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722879502; x=1723484302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIqXJOcsWTmDQT18ltvBkvSKfPE+CI0ACIv+CWuAfhQ=;
        b=UZ30BU3m1B0mb6p4ODl6Z3CoDUzLR+eACAiaX/mbZlOkb4pk0206iWj6xBtjfVflI4
         voe72VSVp0ozuc7VK92XR6h/IguzDcKEcAXrWus+tywQtlf4qEZNlcDc6cYGaYlIeDYN
         TEXTf1BbVv8yJ4xh8gzn/uXA9nMJ9vKCMNjHveTEWTI1LGGxTre+f9JGeBTJQX7q97WB
         UL9pgEZRUUTLJyHaW3eWCKVNowz4glDlEcPpejQg0fAzk3AIzgzuz1KVNcr5JmDJBojj
         pMeUTKcRxSqt61WCRTLP10jB5RrG7Cbe6zeLqjrMjMQgoQxm7/WBGuB6Hzgoepyjy8Wq
         704w==
X-Forwarded-Encrypted: i=1; AJvYcCVJpR6ZCqIfsGYxehN+0vsRTs4qzSBESZuxbybNJ4lzNSntTtTJrBDLf9lCHtsYLkFX9Q1yLKuBeagAzpCZQ3fBgh1CoAxjDdhBXxwr
X-Gm-Message-State: AOJu0YzFL1/O2siLiRpTe5SH817ioEBmWLmFxOfy3hmUVo84SmxApZvY
	Jy1Ku/taHb7X95UTijFaQ7KRzkSfwEvKqW/HfDLAqKDU6Y2MNVo/3K3NcJTmBso=
X-Google-Smtp-Source: AGHT+IGA4ao6KXpD/OA6uBRaBG7aAABpIJEYunLTtbMZ72A9gi5Guwmmt27eLbpuv2kqVPSBJEaCbw==
X-Received: by 2002:a17:902:dac4:b0:1fb:90e1:c8c5 with SMTP id d9443c01a7336-1ff572c487fmr112872505ad.33.1722879501771;
        Mon, 05 Aug 2024 10:38:21 -0700 (PDT)
Received: from jesse-desktop.ba.rivosinc.com (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5929407asm71128435ad.242.2024.08.05.10.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:38:21 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Eric Biggers <ebiggers@google.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Joel Granados <j.granados@samsung.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/1] RISC-V: Add parameter to unaligned access speed
Date: Mon,  5 Aug 2024 13:38:15 -0400
Message-ID: <20240805173816.3722002-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a kernel parameter to the unaligned access speed. This allows
skiping of the speed tests for unaligned accesses, which often is very
slow.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
 arch/riscv/kernel/unaligned_access_speed.c | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index 1548eb10ae4f..02f7a92a5fa0 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -400,13 +400,94 @@ static int vec_check_unaligned_access_speed_all_cpus(void *unused __always_unuse
 }
 #endif
 
+static DEFINE_PER_CPU(long, unaligned_scalar_speed_param) = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
+
+static int __init set_unaligned_scalar_speed_param(char *str)
+{
+	cpumask_var_t mask;
+	int ret, cpu;
+	long speed = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
+
+	if (!strncmp(str, "fast,", 5)) {
+		str += 5;
+		speed = RISCV_HWPROBE_MISALIGNED_FAST;
+	}
+
+	if (!strncmp(str, "slow,", 5)) {
+		str += 5;
+		speed = RISCV_HWPROBE_MISALIGNED_SLOW;
+	}
+	if (speed == RISCV_HWPROBE_MISALIGNED_UNKNOWN) {
+		pr_warn("Invalid unaligned access speed parameter\n");
+		return 1;
+	}
+
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	ret = cpulist_parse(str, mask);
+
+	for_each_cpu(cpu, mask)
+		if (per_cpu(unaligned_scalar_speed_param, cpu) == RISCV_HWPROBE_MISALIGNED_UNKNOWN)
+			per_cpu(unaligned_scalar_speed_param, cpu) = speed;
+
+	free_cpumask_var(mask);
+	return ret == 0;
+}
+__setup("unaligned_scalar_speed=", set_unaligned_scalar_speed_param);
+
+static DEFINE_PER_CPU(long, unaligned_vector_speed_param) = RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN;
+
+static int __init set_unaligned_vector_speed_param(char *str)
+{
+	cpumask_var_t mask;
+	int ret, cpu;
+	long speed = RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN;
+
+	if (!strncmp(str, "fast,", 5)) {
+		str += 5;
+		speed = RISCV_HWPROBE_VECTOR_MISALIGNED_FAST;
+	}
+
+	if (!strncmp(str, "slow,", 5)) {
+		str += 5;
+		speed = RISCV_HWPROBE_VECTOR_MISALIGNED_SLOW;
+	}
+	if (speed == RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN) {
+		pr_warn("Invalid unaligned access speed parameter\n");
+		return 1;
+	}
+
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	ret = cpulist_parse(str, mask);
+
+	for_each_cpu(cpu, mask)
+		if (per_cpu(unaligned_vector_speed_param, cpu) == RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN)
+			per_cpu(unaligned_vector_speed_param, cpu) = speed;
+
+	free_cpumask_var(mask);
+	return ret == 0;
+}
+__setup("unaligned_vector_speed=", set_unaligned_vector_speed_param);
+
 static int check_unaligned_access_all_cpus(void)
 {
+	int cpu;
 	bool all_cpus_emulated, all_cpus_vec_unsupported;
 
 	all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
 	all_cpus_vec_unsupported = check_vector_unaligned_access_emulated_all_cpus();
 
+	for_each_online_cpu(cpu) {
+		if (per_cpu(misaligned_access_speed, cpu) == RISCV_HWPROBE_MISALIGNED_UNKNOWN)
+			per_cpu(misaligned_access_speed, cpu) = per_cpu(unaligned_scalar_speed_param, cpu);
+
+		if (per_cpu(vector_misaligned_access, cpu) == RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN)
+			per_cpu(vector_misaligned_access, cpu) = per_cpu(unaligned_vector_speed_param, cpu);
+	}
+
 	pr_info("\e[31m%s vector unaligned access\e[0m\n",
 		all_cpus_vec_unsupported ? "All CPUs do not support" : "At least one cpu supports");
 	if (!all_cpus_vec_unsupported &&
-- 
2.45.2


