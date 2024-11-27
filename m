Return-Path: <linux-kernel+bounces-423279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1279DA54B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05429B2624F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE29198826;
	Wed, 27 Nov 2024 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cKVVFi4b"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C01194C76
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732701756; cv=none; b=b3dD4xbI3GlvlpdZYNIDRQUkVLq1HzwsqrG/G6y/OZ0ifWuSCbM+Wdam2LGTEXjKxHPLGU2Myf/mHgo5h38veV/u7OcwB6xoFiEAN0pY6HQAsR5UyhTXqzIb2lsaKQ2Ww6WjpxuL6ncQVVAPPheqQkS7Lg7mRP6KJtLONb9jcAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732701756; c=relaxed/simple;
	bh=OBclv0kx0D1prxi+rdV81bxT1otCeQV4dy6Asymp6U8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rvJMWpVIDTsDdN4xG5L5n2MQhl250s/Btz9xB7e1yturld6zjUAGMGpfYtN+2YaC0M0FyMO/Qn5jpGeqx1fSiJfKKSSQ55ba5Qxwf/K6ksNDvB8XTzSPcDJrkRA6KVUzrDSKdIrc3C3uuSqPP0WUJ2LQKyX6FhxFZATo1UVH93w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cKVVFi4b; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa560a65fd6so108354566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732701752; x=1733306552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQO33bk7JaoB2YQnA4dTR0HBdRzks1jGUji/o+mr5GU=;
        b=cKVVFi4bzl9fdNrkgNbqG9VlDvyFsM0+AtSor0opTHszK6m+LBa3Bnt8XD8n+Lee1p
         aVNVWOqK/abzbMFa1DLHPQrFyKmp7LheoheqTViw9Kem0VTYbuAqTdhRrXJUSWKAe4LI
         4ml6IekeYWmWPYI5kUbopQsV5sq+AC8RLja61s8oF3nEZjAbej7ja53xwJqsYqHHoFsP
         NzYFV/WPVmU0gd+DBibVf2tuY0O0+ZE/G/25UEARjI7IOYVWUWs7KzxKqY6vQOc5AtYc
         GPqnZBzmvxrJ/9y9pyTe3vdsw2aHszkGg/TwRralk/9BB6N0sjD6b0Hm5LM94FUrrGfO
         br1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732701752; x=1733306552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQO33bk7JaoB2YQnA4dTR0HBdRzks1jGUji/o+mr5GU=;
        b=ICbZajSQ47Z6t79zF4JvrVmP9kpwN+Gfr615VNZ3w/kEyGn8FkuwIP63o7MAqnm5Rt
         DqOLceINbkygX39HjBwLaGkC+YjqHXJFMBqaYqPvln9OQR0ZK2Vs/53bJqxWl1trzIDE
         WOCb3O65jSw/60VDyNq3jdHg8ENoysmRzPgLsc8MRYG3OX6AcwnLpM9kfhgXBRCPMSlk
         BCpOkyNwiDIT3PGf9ObMRkEoIKx5TOQyFT1UBThBnzPNoF7fsyTv0nqrsgB5R/+toojF
         H+CZABI6BaB0b5ebcPQs/ud2HfNuxoesuCYj3yz38kKro/9q9yfRKDzOzGka7Y6XtUVb
         /ttg==
X-Forwarded-Encrypted: i=1; AJvYcCVFa8zaT0Bs24ZwF3fHPrtfhTi54POMIPK1yRCnZms5VOEt7kQ2FybdcVRssFdupaFVyj1BLX487wjKbdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJDkb0qG1Tasr/zasZAcgtuGn2x3EnB67aeuEH9SK2ckScJDj8
	x/LDf1M1kiwIwAPHcDcKKBd2d18eGDpQpa/wXl63pb3jfc/ujnYp2fYqxeLHuVI=
X-Gm-Gg: ASbGncvwX1FvasYCk1wJ7O4CyY1HTyDKxxo27uIigoh8hj4X9vH37rm1pXCiyGKCWdV
	Q7eGV2PxdH5bxYC659+6lpSXDeLYen/WyT1te2eqTbATw20SnwoH3SmrU1kI9hvETIn077vyILt
	wWvgIK/RDBFDUqbXe3JSBGMq5P9kesEmJCSJjS6LancPWSp1xo/HZ8tJ+zU8QoZg2YTVkadJd6t
	erwpyNeJouzbm5YoP6/OVUbnwNoC5LLy03waoFq1q5YK4aV2A==
X-Google-Smtp-Source: AGHT+IFOprwWyU0EZiK3CjnWXpdoY6pqFDChObj/uIZutCL8jO6QK+gWZSMBFJTM121i68Qn0kESKQ==
X-Received: by 2002:a17:907:775a:b0:aa5:2a63:e93 with SMTP id a640c23a62f3a-aa57fac4512mr248698066b.12.1732701752519;
        Wed, 27 Nov 2024 02:02:32 -0800 (PST)
Received: from pop-os.. ([145.224.90.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa547ffb152sm421887466b.62.2024.11.27.02.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 02:02:32 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: maz@kernel.org,
	kvmarm@lists.linux.dev,
	oliver.upton@linux.dev,
	suzuki.poulose@arm.com,
	coresight@lists.linaro.org
Cc: James Clark <james.clark@linaro.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	James Morse <james.morse@arm.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Shiqi Liu <shiqiliu@hust.edu.cn>,
	Fuad Tabba <tabba@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 7/8] KVM: arm64: Support trace filtering for guests
Date: Wed, 27 Nov 2024 10:01:24 +0000
Message-Id: <20241127100130.1162639-8-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127100130.1162639-1-james.clark@linaro.org>
References: <20241127100130.1162639-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For nVHE, switch the filter value in and out if the Coresight driver
asks for it. This will support filters for guests when sinks other than
TRBE are used.

For VHE, just write the filter directly to TRFCR_EL1 where trace can be
used even with TRBE sinks.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/include/asm/kvm_host.h  |  5 +++++
 arch/arm64/kvm/debug.c             | 28 ++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/debug-sr.c |  1 +
 3 files changed, 34 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index ba251caa593b..cce07887551b 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -613,6 +613,7 @@ struct kvm_host_data {
 #define KVM_HOST_DATA_FLAG_HAS_SPE	0
 #define KVM_HOST_DATA_FLAG_HAS_TRF	1
 #define KVM_HOST_DATA_FLAG_TRBE_ENABLED	2
+#define KVM_HOST_DATA_FLAG_GUEST_FILTER	3
 	unsigned long flags;
 
 	struct kvm_cpu_context host_ctxt;
@@ -1387,6 +1388,8 @@ void kvm_clr_pmu_events(u64 clr);
 bool kvm_set_pmuserenr(u64 val);
 void kvm_enable_trbe(void);
 void kvm_disable_trbe(void);
+void kvm_set_trfcr(u64 guest_trfcr);
+void kvm_clear_trfcr(void);
 #else
 static inline void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr) {}
 static inline void kvm_clr_pmu_events(u64 clr) {}
@@ -1396,6 +1399,8 @@ static inline bool kvm_set_pmuserenr(u64 val)
 }
 static inline void kvm_enable_trbe(void) {}
 static inline void kvm_disable_trbe(void) {}
+static inline void kvm_set_trfcr(u64 guest_trfcr) {}
+static inline void kvm_clear_trfcr(void) {}
 #endif
 
 void kvm_vcpu_load_vhe(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 0c340ae7b5d1..9266f2776991 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -337,3 +337,31 @@ void kvm_disable_trbe(void)
 	host_data_clear_flag(TRBE_ENABLED);
 }
 EXPORT_SYMBOL_GPL(kvm_disable_trbe);
+
+void kvm_set_trfcr(u64 guest_trfcr)
+{
+	if (is_protected_kvm_enabled() || WARN_ON_ONCE(preemptible()))
+		return;
+
+	if (has_vhe())
+		write_sysreg_s(guest_trfcr, SYS_TRFCR_EL12);
+	else {
+		*host_data_ptr(guest_trfcr_el1) = guest_trfcr;
+		host_data_set_flag(GUEST_FILTER);
+	}
+}
+EXPORT_SYMBOL_GPL(kvm_set_trfcr);
+
+void kvm_clear_trfcr(void)
+{
+	if (is_protected_kvm_enabled() || WARN_ON_ONCE(preemptible()))
+		return;
+
+	if (has_vhe())
+		write_sysreg_s(0, SYS_TRFCR_EL12);
+	else {
+		*host_data_ptr(guest_trfcr_el1) = 0;
+		host_data_clear_flag(GUEST_FILTER);
+	}
+}
+EXPORT_SYMBOL_GPL(kvm_clear_trfcr);
diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
index 9479bee41801..7edee7ace433 100644
--- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
@@ -67,6 +67,7 @@ static void __trace_do_switch(u64 *saved_trfcr, u64 new_trfcr)
 static bool __trace_needs_switch(void)
 {
 	return host_data_test_flag(TRBE_ENABLED) ||
+	       host_data_test_flag(GUEST_FILTER) ||
 	       (is_protected_kvm_enabled() && host_data_test_flag(HAS_TRF));
 }
 
-- 
2.34.1


