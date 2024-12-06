Return-Path: <linux-kernel+bounces-435322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6455D9E7611
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D02A16CBE2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0F72135D7;
	Fri,  6 Dec 2024 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yBAOtJpZ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5112C2063D2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502677; cv=none; b=RjW1Nh/0ezPbY8JqofDmO0GrLfxfXCZMhRpujz7fw6uU9sAsJ2itnK3par18wGztjwygEuSsLYQNnGyVshI3ZoV61V7FmNnv2zLg/Y6D9R/5qTuYgEInhTUCMSPaxp/1zjhkghyKAodyWnmJ7P7p0aIVsQrBotGJUCXL464xXhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502677; c=relaxed/simple;
	bh=8aGdi4n+OgIuGS1aTYKtvEclOCI87M6OQhVWoyS/obM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7POsrQEPhM0CXaoxMu3TtMwN1ipFL8dA6zOEDtyXhLmGrhIzqs/iBT+roJbcXU4LE2jNb97NIiJtQDy2L0x/s4UH9Lbx/h23U2KLw7ViASOqvggfR3BcSDw8Y5Jc6DHBkM6kRrgzxMd/t2OYYrhoKLhJwtrhe3JP6X/Unl9VjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yBAOtJpZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso22146915e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 08:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733502673; x=1734107473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pTgQSov7vYTWNucdQE0t9hyfOwyYPp0snQQ1hygLdA=;
        b=yBAOtJpZ/Y2Y5GXwfL7sJwLGO1YB9d5TLfzwdJY6nR6ELbkUblNckmDvwb7bQK2N9p
         Xc6KjIV2TfDX5WikrBekQoQrmvrcR+5MRs8lQwjL/M+O/wXkS/zQfkEijEdHtUoo6zEx
         WqMhqWju8SPwh3JODIdwJvJZZoRxZWZYObuCcBW9v+E0BJU/kJsdePMW1F1O5HBLPjCi
         GNmmIS+rE+ft4DWiH5EJ/ugYXXo2SIup04BS3toCK1qKZ+/1krI24SmPXhEfkFpBXQTP
         Sxw6sbtKQAnuyu/s2lqxjpqcxjPQwuSudAdpwd2JF9lkBL7i1wDkeFrMrigqb7Bt7yrk
         efjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733502673; x=1734107473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pTgQSov7vYTWNucdQE0t9hyfOwyYPp0snQQ1hygLdA=;
        b=P2dep8jmAtK8Vgey4BEKKL0KKwLSst2cvsajH766ADBefdPEoSuBfSiVHuVzxoFm/b
         NYV1WZRtWdU19zfr+Q3JpnKHASuumJ00Pe6MbPu6ZYOv2dExK/HrL5OrPUMT2VtOdXO4
         Jvgs7RNbcgPzv5/QAYKen96vMYli+4IGoyVUh5xIOAi5rQDFIDLRivm4UqzpQTFwDHL+
         wZlSWKsswMg/gngDWZCLGR5Hb/vqIGy6MuuL21XJUIKqz01y70TcDjSS46Y512bACJDl
         9F1VQWnbxIMIUMQ0YG7ljN+ZAswDN9z6RyfKahsj8zxLOpc9pOfoSBvjpk1k0feEn4+l
         Cudw==
X-Forwarded-Encrypted: i=1; AJvYcCWYoerHjAm0SRot/XJ+wdM169sKeliGqMosTCc8fpQ2mjnMvyvvyjd/sZv3uHKwmPCWPgQ890ZSia5MM/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfMX0RMcwU02GQZeTByXViLf1neX0PhaExaqrddig8MG4M3bS8
	lEjr7Wa8jO7IT7gVXXY3ESlA3uf5BbObRa0v06FIh+G5UEF4pycLiX4YhAOoLcA=
X-Gm-Gg: ASbGncv4kyXIyhTZ8yRuSISPaZI8I+RSaaea8k6qCYiyD73NeGV+U5hjUO4aOeothfu
	JZrKEuZa9YIo2V13PeswE/GzMhmX6zezOr93E47w8oszMh1/kbHD3OdgvES4iKHrpQJvYTPn/Gu
	6FnEyg6z2H60lUdmChOqpAVzteHnA3b1lTz6BkF3eKQ9dgatjWV95+Ovk5eMCEpQAWMTHjQPjuQ
	HlgBN8uvNPR+FE+yKbfVZxSNqRc/J4wOnJush1rq90DEw4rUVI=
X-Google-Smtp-Source: AGHT+IEXqcNtnOQtrn9HCLkcY6FnKIIl9CkgV9xxYEovPWiiPgpTNBlpOFS9Y9bIrLbUO0lLfarFWQ==
X-Received: by 2002:a05:6000:1846:b0:385:fb2c:6034 with SMTP id ffacd0b85a97d-3862b3e6fddmr2723661f8f.47.1733502673558;
        Fri, 06 Dec 2024 08:31:13 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862f02f5c3sm1151942f8f.65.2024.12.06.08.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 08:31:12 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Xu Lu <luxu.kernel@bytedance.com>,
	Atish Patra <atishp@atishpatra.org>
Subject: [PATCH v3 4/4] perf: RISC-V: add support for SSE event
Date: Fri,  6 Dec 2024 17:31:00 +0100
Message-ID: <20241206163102.843505-5-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206163102.843505-1-cleger@rivosinc.com>
References: <20241206163102.843505-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In order to use SSE within PMU drivers, register a SSE handler for the
local PMU event. Reuse the existing overflow IRQ handler and pass
appropriate pt_regs.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 51 +++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 1aa303f76cc7..bd7ab15483db 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -17,6 +17,7 @@
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
 #include <linux/of.h>
+#include <linux/riscv_sse.h>
 #include <linux/cpu_pm.h>
 #include <linux/sched/clock.h>
 #include <linux/soc/andes/irq.h>
@@ -946,10 +947,10 @@ static void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
 		pmu_sbi_start_ovf_ctrs_sbi(cpu_hw_evt, ctr_ovf_mask);
 }
 
-static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
+static irqreturn_t pmu_sbi_ovf_handler(struct cpu_hw_events *cpu_hw_evt,
+				       struct pt_regs *regs, bool from_sse)
 {
 	struct perf_sample_data data;
-	struct pt_regs *regs;
 	struct hw_perf_event *hw_evt;
 	union sbi_pmu_ctr_info *info;
 	int lidx, hidx, fidx;
@@ -957,7 +958,6 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	struct perf_event *event;
 	u64 overflow;
 	u64 overflowed_ctrs = 0;
-	struct cpu_hw_events *cpu_hw_evt = dev;
 	u64 start_clock = sched_clock();
 	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
 
@@ -967,13 +967,15 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	/* Firmware counter don't support overflow yet */
 	fidx = find_first_bit(cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS);
 	if (fidx == RISCV_MAX_COUNTERS) {
-		csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
+		if (!from_sse)
+			csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
 		return IRQ_NONE;
 	}
 
 	event = cpu_hw_evt->events[fidx];
 	if (!event) {
-		ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
+		if (!from_sse)
+			ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
 		return IRQ_NONE;
 	}
 
@@ -988,16 +990,16 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 
 	/*
 	 * Overflow interrupt pending bit should only be cleared after stopping
-	 * all the counters to avoid any race condition.
+	 * all the counters to avoid any race condition. When using SSE,
+	 * interrupt is cleared when stopping counters.
 	 */
-	ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
+	if (!from_sse)
+		ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
 
 	/* No overflow bit is set */
 	if (!overflow)
 		return IRQ_NONE;
 
-	regs = get_irq_regs();
-
 	for_each_set_bit(lidx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS) {
 		struct perf_event *event = cpu_hw_evt->events[lidx];
 
@@ -1053,6 +1055,22 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t pmu_sbi_ovf_irq_handler(int irq, void *dev)
+{
+	return pmu_sbi_ovf_handler(dev, get_irq_regs(), false);
+}
+
+static int pmu_sbi_ovf_sse_handler(uint32_t evt, void *arg,
+				   struct pt_regs *regs)
+{
+	struct cpu_hw_events __percpu *hw_events = arg;
+	struct cpu_hw_events *hw_event = raw_cpu_ptr(hw_events);
+
+	pmu_sbi_ovf_handler(hw_event, regs, true);
+
+	return 0;
+}
+
 static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	struct riscv_pmu *pmu = hlist_entry_safe(node, struct riscv_pmu, node);
@@ -1100,9 +1118,22 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
 static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pdev)
 {
 	int ret;
+	struct sse_event *evt;
 	struct cpu_hw_events __percpu *hw_events = pmu->hw_events;
 	struct irq_domain *domain = NULL;
 
+	evt = sse_event_register(SBI_SSE_EVENT_LOCAL_PMU, 0,
+				 pmu_sbi_ovf_sse_handler, hw_events);
+	if (!IS_ERR(evt)) {
+		ret = sse_event_enable(evt);
+		if (!ret) {
+			pr_info("using SSE for PMU event delivery\n");
+			return 0;
+		}
+
+		sse_event_unregister(evt);
+	}
+
 	if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
 		riscv_pmu_irq_num = RV_IRQ_PMU;
 		riscv_pmu_use_irq = true;
@@ -1137,7 +1168,7 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 		return -ENODEV;
 	}
 
-	ret = request_percpu_irq(riscv_pmu_irq, pmu_sbi_ovf_handler, "riscv-pmu", hw_events);
+	ret = request_percpu_irq(riscv_pmu_irq, pmu_sbi_ovf_irq_handler, "riscv-pmu", hw_events);
 	if (ret) {
 		pr_err("registering percpu irq failed [%d]\n", ret);
 		return ret;
-- 
2.45.2


