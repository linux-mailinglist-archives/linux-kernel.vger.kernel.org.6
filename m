Return-Path: <linux-kernel+bounces-542373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60397A4C8FE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42BAB188D41E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B165B25DD19;
	Mon,  3 Mar 2025 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXsTR8l9"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A10825DCF7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020797; cv=none; b=I2Y57LkTvVnZBMq3PPEWzArHHlBl1Qu/+P6X7dhtTB2k1uFI2wj4qIQl5+j4qG1HMPN/e+wakEBbVpj1iTCzUnR/1Cpi240F5Paf7ybjwHkSEfaHUUeWybz6Eusmiyuy/wjJRcq98GI2HZBwn4myaao8gb+I9OBWT3cc4we0tRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020797; c=relaxed/simple;
	bh=ie9S/8MDQErq++hnfAmXc+Lw3UbKnIj84zN+yIyykiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ms8o/1SroNSqNQbGUgN5QbSwLg4PpFT1xK+KMP+jdEEa8wP7pd+e8oJtHY7Jo6DF138f8YHmikYXOFgAKm0sb+tCshazIm/sK98gyizaROkJPpm66lQyYOpf/HBYVDkZDBS+UH8rdKTke5rk5hr6m7exzv9MLmtJuZP3JX5+/Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXsTR8l9; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c0ac2f439eso571675585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741020793; x=1741625593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXpU/uYR4oxAkP1tzBNe+du+KzjtuWOQI3OyRLVRl8s=;
        b=EXsTR8l9BM3+DJxW/GeJB/wWUZsachVbJVo2NdFfM3hsHrIwch0r/YWepCNxZ1zsrL
         eeYFfTPSaa0xS5EBU5TVDHe2YJrDXfHQnqRrx05n3SKTbLFjtluvfZMVhzuF9ZsmmIMv
         Q8QJLxwmNRdeez7yWL2m4APrbZhN8sLUiPAvts/SMLNxJeUYRtcIPvE8OQbx5ggVgx/0
         Cyl29zMxaWVcnP7mOIGQHycY26h1h+LMyhDDc49f6x2+T4x65SDem2Je0qEX8L8iGRac
         h7qkxmIZDk24yNTCx+dIRhD7Wwlo0dqLPnI5dQNoqLtUb+lksY8+PA2BhqUBwwtk6I+X
         oB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020793; x=1741625593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXpU/uYR4oxAkP1tzBNe+du+KzjtuWOQI3OyRLVRl8s=;
        b=goZXXoKGPFoKV+HQc22SPbTjdU9f+/+WCTunyBUBUpfBt9E1IhhO79Tuepx5Rk+64r
         RUj2Jpn5QpjMx5ohbFyJ/eZk/sWY3+GIKBY2K+N/1MARDO15qIelZCAyRaTeBfRAoytA
         rHXHPQZLJRYhWUmrb6mIYwZp6PQyo9aasmT28KH9oruBDXcVwENvKzWjTPbPuQs9vWxR
         G0Np3Yd0xpJTpXmWl2mlpkccVVCBeORT5Z+eMrnjkUqm3RdGjcL+gDl7/4v9c1m5kVyU
         wgCZmvetxVMGQfNwvMp7Gn3XfirJa6dQYTbXPPRE9KIJ96ZqoHdMPq9PWqxsV+M0h5aA
         QuBQ==
X-Gm-Message-State: AOJu0Yw97C5sl8+VpqKqBFpi5a7F3yX/BQ4V7gA71BXMofFWgRgWuvng
	upozIv7hePjUvF30IoVkPMkT/b1zLbI0ZY6YyM7mM+moplPUQ9fAuQug
X-Gm-Gg: ASbGncuol35HSrlmAYHB/D9TB9d119bowVo7ME0WR/Jg0vZ9RSYWJZ81cBdnm7PimfB
	c+WC1rRDxKHC6ZSko/nxmzPU/rInX+KZ6iy+gDUf/jJqKcv5tBAXvR5ZUF1gnP99uInQttcZw1S
	iujBp52iYh1qN23Uspz1Bpd2kH5NTAuUe7/0lkt3W8WWmWv/A41V3AsFd0P4v9FCUgQTkt1x7GK
	GDT3tYkg2MBT8k6sNDDB2rlEal6F7qCPB9m/TrShhQBF8ZZjT2LrpMpSWyYtxRLnd94RC65XJ7W
	ofZgOIqZLSTA2gnFWNTMcZ+GZw==
X-Google-Smtp-Source: AGHT+IEfdZpFbpSpMDgGCY6ETqFQtXvQfYD1sMc7RZZLk2OOuuz+yvpinSd1ztTERkLeFeCanmi1mg==
X-Received: by 2002:a05:620a:3726:b0:7c0:a357:fe62 with SMTP id af79cd13be357-7c39c4be40fmr1871198385a.19.1741020793336;
        Mon, 03 Mar 2025 08:53:13 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976cc9cdsm54730936d6.88.2025.03.03.08.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:53:12 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 02/11] x86/percpu: Move pcpu_hot to percpu hot section
Date: Mon,  3 Mar 2025 11:52:37 -0500
Message-ID: <20250303165246.2175811-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303165246.2175811-1-brgerst@gmail.com>
References: <20250303165246.2175811-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/current.h | 28 +++++++++++-----------------
 arch/x86/kernel/cpu/common.c   |  2 +-
 arch/x86/kernel/vmlinux.lds.S  |  3 +++
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index bf5953883ec3..60bc66edca83 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -13,32 +13,26 @@
 struct task_struct;
 
 struct pcpu_hot {
-	union {
-		struct {
-			struct task_struct	*current_task;
-			int			preempt_count;
-			int			cpu_number;
+	struct task_struct	*current_task;
+	int			preempt_count;
+	int			cpu_number;
 #ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
-			u64			call_depth;
+	u64			call_depth;
 #endif
-			unsigned long		top_of_stack;
-			void			*hardirq_stack_ptr;
-			u16			softirq_pending;
+	unsigned long		top_of_stack;
+	void			*hardirq_stack_ptr;
+	u16			softirq_pending;
 #ifdef CONFIG_X86_64
-			bool			hardirq_stack_inuse;
+	bool			hardirq_stack_inuse;
 #else
-			void			*softirq_stack_ptr;
+	void			*softirq_stack_ptr;
 #endif
-		};
-		u8	pad[64];
-	};
 };
-static_assert(sizeof(struct pcpu_hot) == 64);
 
-DECLARE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
+DECLARE_PER_CPU_CACHE_HOT(struct pcpu_hot, pcpu_hot);
 
 /* const-qualified alias to pcpu_hot, aliased by linker. */
-DECLARE_PER_CPU_ALIGNED(const struct pcpu_hot __percpu_seg_override,
+DECLARE_PER_CPU_CACHE_HOT(const struct pcpu_hot __percpu_seg_override,
 			const_pcpu_hot);
 
 static __always_inline struct task_struct *get_current(void)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7d33c45ad241..c33eaca1e9f9 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2049,7 +2049,7 @@ static __init int setup_setcpuid(char *arg)
 }
 __setup("setcpuid=", setup_setcpuid);
 
-DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) = {
+DEFINE_PER_CPU_CACHE_HOT(struct pcpu_hot, pcpu_hot) = {
 	.current_task	= &init_task,
 	.preempt_count	= INIT_PREEMPT_COUNT,
 	.top_of_stack	= TOP_OF_INIT_STACK,
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 1769a7126224..7586a9be8c59 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -187,6 +187,8 @@ SECTIONS
 
 		PAGE_ALIGNED_DATA(PAGE_SIZE)
 
+		CACHE_HOT_DATA(L1_CACHE_BYTES)
+
 		CACHELINE_ALIGNED_DATA(L1_CACHE_BYTES)
 
 		DATA_DATA
@@ -328,6 +330,7 @@ SECTIONS
 	}
 
 	PERCPU_SECTION(INTERNODE_CACHE_BYTES)
+	ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <= 64, "percpu cache hot section too large")
 
 	RUNTIME_CONST_VARIABLES
 	RUNTIME_CONST(ptr, USER_PTR_MAX)
-- 
2.48.1


