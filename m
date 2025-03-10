Return-Path: <linux-kernel+bounces-554543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABB0A5999B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2B5188A3AD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6550422FDEE;
	Mon, 10 Mar 2025 15:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="svrog805"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F74C22FDE7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619695; cv=none; b=p3oxp+HQYEv75L1CmD4g/ysDBfnHyymHHXYw0Bucm3zsc/dltcI4U8Zxsxzkg20ffgCi6vSuZr2Jb5JXqllr1ZyyFCN7UsZN520tV7ppfKspgYVSTlTui1SVgnMFKIzcFBkGDstI01rnDabsv4vphBCxEgwRje0XENxI/Yjk4fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619695; c=relaxed/simple;
	bh=LeEoRIbji6zEftGWkJUU0mkYKwf/Oshrl9c3/18pJs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CUW5Am78eLN4E9YPeIpdx4++qzHxNcws7Xw95Ie139q7/VMF0EnEtelD7nvKc2qroql+Z7k5QhSeeNU4SdT51hhBrLEAMxDZF3JZiCnrWczYiN3kBpf7DGf5KLWX+Ht0ixz7RF2TZXAV0A29aSO9m19BG3DQGUYI7z7+cHKi8qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=svrog805; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224100e9a5cso80811805ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741619693; x=1742224493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6l++jogwQbkZh7dICu4CyxiXIZKEwQKPb1/RHWWp03A=;
        b=svrog8055eW9BMxPKv1rykQ+uHamPBMxqaO28UMmUYAOegpwKzziJCJZan9ImGUMD4
         SQu+z/kKl3hG5cCzpRVGNsEnnjkSQiJW/AHNmvzT4WdBXYVBEZlxlrJTrAlQyMmp69rm
         H5OA5UJDGmlgHHYvFsS4rKP2He0whf10SH/K0cphv5bp+K8YkVOZfTijH8VavYu2V0c/
         gl3ZQxLpUuRTFGW6MD7paqlJWbpuKlUVjZw/WuWZBBBECC6gTvJPmHWK28wriaAMktEa
         EPmNBg8JoCd1fwo878p90845j6xs7b280G3M94HKH9PQyJIBW3d65N01nYfM4yWAKuTr
         PY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619693; x=1742224493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6l++jogwQbkZh7dICu4CyxiXIZKEwQKPb1/RHWWp03A=;
        b=e86xHiqTozNY7U6YQ5SkkDHx5VwT4d+zZDomHq9+IcWqOvG5f4/FxuxBEetQtgn90y
         e4VfLNUC9g2mCfb6pDmEYFUKJ8DJbLfdR7RF3p3ElQuzOci8R9DefbaZpYk5envA1J4F
         D4y+4UubOSdNGiVGu+3C7tYDy+0YmJ/H8AeQYm4yp5ZCgI+lIuVIr4S1Y2c1BEox3ouo
         A3/HIcgC0UeZA/B+vxRBwTN4HSF1F85sHJZnKGdrUcgLqTUKRrosXthBSxrhRuIKsTiw
         m/6j0+ZxWjyuY6+gbkt37AGnoYQkC34NqExKNk2kayIHcDoBnn7qVLLYCxcNqfLV5yiY
         h++A==
X-Forwarded-Encrypted: i=1; AJvYcCWfg+8VnMgsMZCnHAhffjXMec9dssWpQOb4j9Qp34+8Inp3Zf21Q6OlZK/keLpbVSC1AS8mNDCZIWmbpSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB8xMMWhgJ726GxT0V0TsXKRWGvEExdP7ZX1Qb34Xng0sW/Le1
	BiHv5S8rPbU7TsxT9cO1+siBukfrMEspe13o302pY46rNF4TxhwrM+cYnb9Cchk=
X-Gm-Gg: ASbGncvLhcFFawVk16NBKZLnCPfbjENYBg8AVZZNKsLRz8u+eAlIEVpyfAtumHrHnLu
	YHv9DFkOLun1f39U9crWsb53ppeklblTqUJCq79rdTAwRREuXORvsMpwOuWUYvZ9g+HPhqGKMcj
	3lPamx8MXMv06410fF3nI7oCxA/XkJ7l9fW+MuApYN+I+FrGwzfhYGXFXGrd5JRVelfb+B+rl31
	pb0tT25fOFBsSRy7Hy+vkGAOuVgFG2Scd9ia6rSL7jmLGwpyzl9LqM9c1c4VyG8Txxc1tGIaWCe
	8+qMsH09rWpN+YA6NdrxGL8jeHThErHrq9zuTqpb4OVxUT5e12C/115m
X-Google-Smtp-Source: AGHT+IGtMqipPUgghWjpfZ6ZkTy1ft1+oxAHrUN4YZ5GS8RdVCB2lFCZnqkm3CMl7QqHMx+cAywiQQ==
X-Received: by 2002:a17:902:f648:b0:220:d601:a704 with SMTP id d9443c01a7336-22428a967a4mr207702705ad.18.1741619693398;
        Mon, 10 Mar 2025 08:14:53 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e99dfsm79230515ad.91.2025.03.10.08.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:14:52 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 15/17] RISC-V: KVM: add SBI extension reset callback
Date: Mon, 10 Mar 2025 16:12:22 +0100
Message-ID: <20250310151229.2365992-16-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250310151229.2365992-1-cleger@rivosinc.com>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, oonly the STA extension needed a reset function but that's
going to be the case for FWFT as well. Add a reset callback that can be
implemented by SBI extensions.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/kvm_host.h     |  1 -
 arch/riscv/include/asm/kvm_vcpu_sbi.h |  2 ++
 arch/riscv/kvm/vcpu.c                 |  2 +-
 arch/riscv/kvm/vcpu_sbi.c             | 24 ++++++++++++++++++++++++
 arch/riscv/kvm/vcpu_sbi_sta.c         |  3 ++-
 5 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index cc33e35cd628..bb93d2995ea2 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -409,7 +409,6 @@ void __kvm_riscv_vcpu_power_on(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_power_on(struct kvm_vcpu *vcpu);
 bool kvm_riscv_vcpu_stopped(struct kvm_vcpu *vcpu);
 
-void kvm_riscv_vcpu_sbi_sta_reset(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu);
 
 #endif /* __RISCV_KVM_HOST_H__ */
diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index bcb90757b149..cb68b3a57c8f 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -57,6 +57,7 @@ struct kvm_vcpu_sbi_extension {
 	 */
 	int (*init)(struct kvm_vcpu *vcpu);
 	void (*deinit)(struct kvm_vcpu *vcpu);
+	void (*reset)(struct kvm_vcpu *vcpu);
 };
 
 void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run);
@@ -78,6 +79,7 @@ bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx);
 int kvm_riscv_vcpu_sbi_ecall(struct kvm_vcpu *vcpu, struct kvm_run *run);
 void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu);
+void kvm_riscv_vcpu_sbi_reset(struct kvm_vcpu *vcpu);
 
 int kvm_riscv_vcpu_get_reg_sbi_sta(struct kvm_vcpu *vcpu, unsigned long reg_num,
 				   unsigned long *reg_val);
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 877bcc85c067..542747e2c7f5 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -94,7 +94,7 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
 	vcpu->arch.hfence_tail = 0;
 	memset(vcpu->arch.hfence_queue, 0, sizeof(vcpu->arch.hfence_queue));
 
-	kvm_riscv_vcpu_sbi_sta_reset(vcpu);
+	kvm_riscv_vcpu_sbi_reset(vcpu);
 
 	/* Reset the guest CSRs for hotplug usecase */
 	if (loaded)
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index 858ddefd7e7f..18726096ef44 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -539,3 +539,27 @@ void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu)
 		ext->deinit(vcpu);
 	}
 }
+
+void kvm_riscv_vcpu_sbi_reset(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_sbi_context *scontext = &vcpu->arch.sbi_context;
+	const struct kvm_riscv_sbi_extension_entry *entry;
+	const struct kvm_vcpu_sbi_extension *ext;
+	int idx, i;
+
+	for (i = 0; i < ARRAY_SIZE(sbi_ext); i++) {
+		entry = &sbi_ext[i];
+		ext = entry->ext_ptr;
+		idx = entry->ext_idx;
+
+		if (idx < 0 || idx >= ARRAY_SIZE(scontext->ext_status))
+			continue;
+
+		if (scontext->ext_status[idx] != KVM_RISCV_SBI_EXT_STATUS_ENABLED ||
+		    !ext->reset)
+			continue;
+
+		ext->reset(vcpu);
+	}
+}
+
diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
index 5f35427114c1..cc6cb7c8f0e4 100644
--- a/arch/riscv/kvm/vcpu_sbi_sta.c
+++ b/arch/riscv/kvm/vcpu_sbi_sta.c
@@ -16,7 +16,7 @@
 #include <asm/sbi.h>
 #include <asm/uaccess.h>
 
-void kvm_riscv_vcpu_sbi_sta_reset(struct kvm_vcpu *vcpu)
+static void kvm_riscv_vcpu_sbi_sta_reset(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.sta.shmem = INVALID_GPA;
 	vcpu->arch.sta.last_steal = 0;
@@ -156,6 +156,7 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta = {
 	.extid_end = SBI_EXT_STA,
 	.handler = kvm_sbi_ext_sta_handler,
 	.probe = kvm_sbi_ext_sta_probe,
+	.reset = kvm_riscv_vcpu_sbi_sta_reset,
 };
 
 int kvm_riscv_vcpu_get_reg_sbi_sta(struct kvm_vcpu *vcpu,
-- 
2.47.2


