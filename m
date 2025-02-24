Return-Path: <linux-kernel+bounces-528999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E37BA41EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD9E188A3C0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CEB23BCE5;
	Mon, 24 Feb 2025 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lkjm2+nG"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C331233711
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399335; cv=none; b=LGGnezePCuKKMclNSZV4hl+scSoJw428nwOR/8M4bTEfVU7O728T+yRV6oGRZtZZyzixoRGfnMUxWX8Ksf86lPAkesOIhXTGZte0e6m0zFUG19IPT1hzlD0cuv7YbAF9I6wnG8iLoL0pZW0/bPlOgk27frul7z+rJO6yPLV1mhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399335; c=relaxed/simple;
	bh=SZOmX+GBdQV5i7lchQoN/uuPmQGSo/TEMUUu60Qhdeg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RLJKeE9a4jLobc1cNhQCMsDSi3JW0/GysJ0aCZ/o8KvqVr1JN0QMvOeZ8v2GLpKLd5HPyAnZT0BheHbc3IEGF3yJ8QlEg2YRP9BqBPRejLDtZ9I1UFKTPGPrXprxZ2ygrljLpm9SoQjT6X5gyEV2OPM27aS5gcV0DlVKP//juMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lkjm2+nG; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43998ec3733so21963395e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 04:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740399332; x=1741004132; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ejK/8C7FFyT3tSgpfGWkSSasOGDMcKAf9YWEPj8A/I=;
        b=lkjm2+nGUyEx2XTUQbjKlCG58edYgQKV7dtrC15TG8z+syk/Pr6gGFx7eWAShAYXI6
         jx4B8EFyEkJAGqo59RUfEib7/Sgime/BRnorm8ne6NpmPt0I14Ya3/YCFit9BYPAQp1O
         9MG7GrJY2bNpHGA825aHU8DpcEKOyeYHjsdXrchyJuHxR0/SF4KE8q4zRrJwsnICRKtq
         rDMKA1+aSuFvgMNEs1cMjl9aAIAyx+4Yne7/BxtxyfZqjr8r67+zp+Xycg6sYJ6J5gxc
         KP0J/mFrWrqy0J5MxE5Erj9FFh5ghJR5WxeFZ60pyLqNE+5q0TXfqvUU3rGwXQjFpgDB
         aFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740399332; x=1741004132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ejK/8C7FFyT3tSgpfGWkSSasOGDMcKAf9YWEPj8A/I=;
        b=XPHPwKxcHRU38Gy7DgMkYawm0Cz4/TsqAoni/5RUyoqtJxrPvdWPSbsMnkUUq8kSiA
         qpJckLwcWYjf7+deKNGFMF3MRiqf2Rg/vLh09WDQADAYXJwORzVdCQrJJ1StCu3fy1ce
         qbCaxWhpHpSfOLF0i6mray+ZRN6nMPF+aBC6a3Wuv3sJtM38LtKUuhU3YSXcyXXyH9Eu
         GLBiJs0MqADtq4ABlBUbA6iYJDVnCCY4R12iFkxULIhT2WNvtsExPj/gCGa68kRO7b/O
         lZ3levxsorUREFWv0eOkPcB/c/dNdqz2XPfw2aAC5Ysg5RQwbIKzpp139jX2NzQJUuxg
         mv3w==
X-Forwarded-Encrypted: i=1; AJvYcCUG4VMXeAgdjgzIlM550pM/3Pb8TNdbEKtY8s2cw6dzDUdYNRiNOP5zft4x5QPPXBAvb4pewCWMuwz2+Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvVm9xPywnyQXUWlpVl6pnRvCDGDcAH+E7vIb2o1gHankVWrhn
	xpEL4kiiWmXkyFKynaGDQQrYnqsAzEFTRx8FUDk5NGpqEs0MQujrXhjY7O/AlSZ6m7HIbrA3But
	9WV2DV1IQxj9v53rI3w==
X-Google-Smtp-Source: AGHT+IGeFNtDkwoWNu5EnPAqlAhToiw57l/wri43FL+yg/iv8i7KY5/rJKLalMmMg9RRoQsj6qXyYOVqroYVfbye
X-Received: from wmqa20.prod.google.com ([2002:a05:600c:3494:b0:439:8b09:7257])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:674e:b0:439:9a5a:d3c4 with SMTP id 5b1f17b1804b1-439af7f97a4mr100497985e9.2.1740399332141;
 Mon, 24 Feb 2025 04:15:32 -0800 (PST)
Date: Mon, 24 Feb 2025 12:13:46 +0000
In-Reply-To: <20250224121353.98697-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250224121353.98697-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250224121353.98697-5-vdonnefort@google.com>
Subject: [PATCH 04/11] KVM: arm64: Add clock support in the nVHE hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

By default, the arm64 host kernel is using the arch timer as a source
for sched_clock. Conveniently, EL2 has access to that same counter,
allowing to generate clock values that are synchronized.

The clock needs nonetheless to be setup with the same slope values as
the kernel. Introducing at the same time trace_clock() which is expected
to be later configured by the hypervisor tracing.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index c838309e4ec4..355bae0056f0 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -144,5 +144,4 @@ extern u64 kvm_nvhe_sym(id_aa64smfr0_el1_sys_val);
 extern unsigned long kvm_nvhe_sym(__icache_flags);
 extern unsigned int kvm_nvhe_sym(kvm_arm_vmid_bits);
 extern unsigned int kvm_nvhe_sym(kvm_host_sve_max_vl);
-
 #endif /* __ARM64_KVM_HYP_H__ */
diff --git a/arch/arm64/kvm/hyp/include/nvhe/clock.h b/arch/arm64/kvm/hyp/include/nvhe/clock.h
new file mode 100644
index 000000000000..2bd05b3b89f9
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/clock.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARM64_KVM_HYP_NVHE_CLOCK_H
+#define __ARM64_KVM_HYP_NVHE_CLOCK_H
+#include <linux/types.h>
+
+#include <asm/kvm_hyp.h>
+
+#ifdef CONFIG_TRACING
+void trace_clock_update(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc);
+u64 trace_clock(void);
+#else
+static inline void
+trace_clock_update(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc) { }
+static inline u64 trace_clock(void) { return 0; }
+#endif
+#endif
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index b43426a493df..323e992089bd 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -28,6 +28,7 @@ hyp-obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o
 hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
 hyp-obj-$(CONFIG_LIST_HARDENED) += list_debug.o
+hyp-obj-$(CONFIG_TRACING) += clock.o
 hyp-obj-y += $(lib-objs)
 
 ##
diff --git a/arch/arm64/kvm/hyp/nvhe/clock.c b/arch/arm64/kvm/hyp/nvhe/clock.c
new file mode 100644
index 000000000000..879c6b09d9ca
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/clock.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Google LLC
+ * Author: Vincent Donnefort <vdonnefort@google.com>
+ */
+
+#include <nvhe/clock.h>
+
+#include <asm/arch_timer.h>
+#include <asm/div64.h>
+
+static struct clock_data {
+	struct {
+		u32 mult;
+		u32 shift;
+		u64 epoch_ns;
+		u64 epoch_cyc;
+		u64 cyc_overflow64;
+	} data[2];
+	u64 cur;
+} trace_clock_data;
+
+static u64 __clock_mult_uint128(u64 cyc, u32 mult, u32 shift)
+{
+	__uint128_t ns = (__uint128_t)cyc * mult;
+
+	ns >>= shift;
+
+	return (u64)ns;
+}
+
+/* Does not guarantee no reader on the modified bank. */
+void trace_clock_update(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc)
+{
+	struct clock_data *clock = &trace_clock_data;
+	u64 bank = clock->cur ^ 1;
+
+	clock->data[bank].mult			= mult;
+	clock->data[bank].shift			= shift;
+	clock->data[bank].epoch_ns		= epoch_ns;
+	clock->data[bank].epoch_cyc		= epoch_cyc;
+	clock->data[bank].cyc_overflow64	= ULONG_MAX / mult;
+
+	smp_store_release(&clock->cur, bank);
+}
+
+/* Using host provided data. Do not use for anything else than debugging. */
+u64 trace_clock(void)
+{
+	struct clock_data *clock = &trace_clock_data;
+	u64 bank = smp_load_acquire(&clock->cur);
+	u64 cyc, ns;
+
+	cyc = __arch_counter_get_cntpct() - clock->data[bank].epoch_cyc;
+
+	if (likely(cyc < clock->data[bank].cyc_overflow64)) {
+		ns = cyc * clock->data[bank].mult;
+		ns >>= clock->data[bank].shift;
+	} else {
+		ns = __clock_mult_uint128(cyc, clock->data[bank].mult,
+					   clock->data[bank].shift);
+	}
+
+	return (u64)ns + clock->data[bank].epoch_ns;
+}
-- 
2.48.1.601.g30ceb7b040-goog


