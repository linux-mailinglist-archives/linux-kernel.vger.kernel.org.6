Return-Path: <linux-kernel+bounces-228234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8DA915D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2558A1C212DB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC3543ACC;
	Tue, 25 Jun 2024 03:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KHafoOKd"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD15212B93
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 03:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719284713; cv=none; b=QUPXjkddGoQ4rKL1Bs9BTDR26aoEyXX2wdev801DfwaGvimwTz1lGPT4LkL2/EeN4OvBBWkG2Q7wHRdt54BmA2JSJQc25JE6IH/xodsLeG/x4RdBYaB1IgxD+Hee2a3bWLn8RPgH2sxQYXw+4SqNskgeSOQKJ5K/Foi0CTjmioI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719284713; c=relaxed/simple;
	bh=XfOFKdE9hUufZU8y6Sa2ZLlLi2R6XOvdzIp9gvD7yAE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=nAh0RCCCKZjgcDKgwX5hSC3PM9M4jkax2PwXztk7H7TUPFBzfJ/kehS82yj4JVTkK4tU1Hy/AL9O3oLqhmU7utQlr/jaWO6YGLyHoRc0EDXwVoNlfRGvWLXwmS3b0ZAZsdit17rIEFrdx+YHxOYscEZfOc6dfKwlgTtXg5GecNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KHafoOKd; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-25cba5eea69so2414677fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 20:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719284711; x=1719889511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zyv67PSeQklNr28uKAOt2rKwosz6YdgLMWHbFyWOHQA=;
        b=KHafoOKdd7nkNIFE5qellh5ppry8477rsUTkKgE4zMpFIbZtKyVHMscKvOAb0qc4S8
         gYqoQlb22wFq9/uatWAoXvJy9e46XaCm/XdJcvma/hY8w5KDl2epmn2006VrRxIQa1vN
         r1P2E4CMr/VeY8fxLXb/8murB+Wl7okUzfjVAhs0qFOSkVFfXvW44P1KLA4nYOBfjdXf
         sVqPGntCYxW/dKnQPH/pZ6Tbhc1FUvXOycf63RaXvCksoQ3FuZI+hELJe+tyopZwvkvO
         Qw6XQj2wpvHYDhyD9AEKJSiEraR/jG3XgVYKYhX5Aar/shvr0cQUZ8XCvbh+L2j+NSDQ
         3y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719284711; x=1719889511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zyv67PSeQklNr28uKAOt2rKwosz6YdgLMWHbFyWOHQA=;
        b=HFHnSN8Ov18ITJctLlRjYzPTSuhUztKB/2HIeEczq0IHvLurrz1oRa6B0GpMYcySfD
         EGmyjQltW+hdz5Ry4ht/0q/gQhFNhuDmt/81JV5qPArrPbU1yvOK8ZOv+RK1IvS4aH1B
         KdQm+ciCEgrf6olcA4zaTUc+GZp3FLcEbYi3coJA3e5FgJy/dqpn1gD+gxFZvoeLvDvd
         EJMIzyHsOnrMcBtupKdIrWhH+5jyYDQXo1uujB+XpRnuyJfMx+lVAbOgkLoqF3DxbwrF
         zwTsQBphhVyP9eflymJrIYjIR3pH93Az+JjuXIEU/6xsWsLdkzPo3odXjBZWK7uC1j+X
         46tw==
X-Forwarded-Encrypted: i=1; AJvYcCVAU6KMdq2gbcErQqEA2rHlfhD20+EOPV/dkhCr5JROxNxiibm4wb7c4xYz++6LzIoh8PkxRO6LDxuOyvZ9z3P/X5SqP0+ncaexs9ZV
X-Gm-Message-State: AOJu0YxgDa5t4CLfRWqOqy7z3meyeFdyHvK1e7E5iemf9828Qb6xb7iO
	nxJHYaVEPUT4ORm3NE+MxRuMxP+g23lfMc1HLEVlCt3/gGJnIsPORw6S1BDyOTE=
X-Google-Smtp-Source: AGHT+IF/DCn5jWj92MzkN0yS/LWMwk7ZFFRCntu0ONoViUjMQuwNY8dwceKK1l9FQfJHBePotKTjNQ==
X-Received: by 2002:a05:6870:524c:b0:254:9c46:8877 with SMTP id 586e51a60fabf-25d0168c516mr6589661fac.16.1719284710706;
        Mon, 24 Jun 2024 20:05:10 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065129acc6sm6953329b3a.157.2024.06.24.20.05.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Jun 2024 20:05:10 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	cuiyunhui@bytedance.com,
	andy.chiu@sifive.com,
	alexghiti@rivosinc.com,
	conor.dooley@microchip.com,
	bjorn@rivosinc.com,
	sorear@fastmail.com,
	cleger@rivosinc.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Randomize lower bits of stack address
Date: Tue, 25 Jun 2024 11:05:02 +0800
Message-Id: <20240625030502.68988-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement arch_align_stack() to randomize the lower bits
of the stack address.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/exec.h | 8 ++++++++
 arch/riscv/kernel/process.c   | 9 +++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 arch/riscv/include/asm/exec.h

diff --git a/arch/riscv/include/asm/exec.h b/arch/riscv/include/asm/exec.h
new file mode 100644
index 000000000000..07d9942682e0
--- /dev/null
+++ b/arch/riscv/include/asm/exec.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ASM_EXEC_H
+#define __ASM_EXEC_H
+
+extern unsigned long arch_align_stack(unsigned long sp);
+
+#endif	/* __ASM_EXEC_H */
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index e4bc61c4e58a..e3142d8a6e28 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -15,6 +15,7 @@
 #include <linux/tick.h>
 #include <linux/ptrace.h>
 #include <linux/uaccess.h>
+#include <linux/personality.h>
 
 #include <asm/unistd.h>
 #include <asm/processor.h>
@@ -26,6 +27,7 @@
 #include <asm/cpuidle.h>
 #include <asm/vector.h>
 #include <asm/cpufeature.h>
+#include <asm/exec.h>
 
 #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
 #include <linux/stackprotector.h>
@@ -99,6 +101,13 @@ void show_regs(struct pt_regs *regs)
 		dump_backtrace(regs, NULL, KERN_DEFAULT);
 }
 
+unsigned long arch_align_stack(unsigned long sp)
+{
+	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
+		sp -= get_random_u32_below(PAGE_SIZE);
+	return sp & ~0xf;
+}
+
 #ifdef CONFIG_COMPAT
 static bool compat_mode_supported __read_mostly;
 
-- 
2.20.1


