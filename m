Return-Path: <linux-kernel+bounces-534594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA08A468E7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60E9D7A84CE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E084235C1D;
	Wed, 26 Feb 2025 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqMByGRD"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D39236A66
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593162; cv=none; b=V7tuIndqmE/xSg7l561702V5aDvbtAdTUT8hKFzQKMwxLlWrI4TDsSgZe+9Rs4AcVC6lQa6PDuGdkwzchZ33jZJEebmgY+ZzE7DwLv/f6yhbQVM+Z6MZ3q1HM/WT3I7CgusFw6O6mN1Ki7pvm8XMvX0gbAdHCnf/93j0y7kqoG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593162; c=relaxed/simple;
	bh=ZOVzoaSmhcjrh/GBlAxtX+PZyTOVsF7qh2/MNwXFnDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXQes2UdW4Regj6fiWe0h2Z6r+1S6J+9fIFAiLsOQ+7txsT/3RlemPytNAG400CMyGqcTd2v2MB11iej2LNiN/lJ2JUmqLoYF1ApUyvTfvzIqi76EV/GaZB7VxDBXOqe5LOZw4DkPfGsmfhOdaTFLwHYKH6cAKIPWaEVlVvBb10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqMByGRD; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5fd19b469b0so20935eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740593160; x=1741197960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMJT51D6J+8ddUG6Tvu8PMUF0tVoTnLdtTaq9cp5nVI=;
        b=TqMByGRDxHJhWrqev9FYQEWwE9/IZbIGqoE4WohGVsR8Mj5qoGRk6IQyZIiiYeKFwh
         8S6pNHXdMBKw6WJnstFWlL37CHz/SKjareXBDdLK5xM+nwZQYvggcXnVO1eo4Aj+dVBK
         WIK2VtIzmzOkxfoW2BxFzIGXDdPaeOpOKuFDZOMTNDNHHLophqzy7vsi3bCR0PdGHbbg
         y6Fh8dw4G4PqCx/weBPaYqLP+5t18T7NXjUojhoS5zs4bqGERCeMMw/vpORl+CNa83Z8
         4daCr30tPjsxRoKTmqMcz5FS5bkIS8IHnTNVFTig+OEzpKdiVQJoxjkrCRKSrt+ya/7G
         uygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593160; x=1741197960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMJT51D6J+8ddUG6Tvu8PMUF0tVoTnLdtTaq9cp5nVI=;
        b=ELF6DGET5mhnAbDLGtMY/4hanBvJFyjIxzigWHNDOcFbD8xjTzgVsyNRZ4gZFfWkn3
         ct3utwXHhn/5lzkF20+iTyGNkqMM2yy+2skVOa4pj+ZNcdrn19o8A4bR8ehGnDEXW46y
         iOklQyOpqgW4TSWTPhTKNxoWpGxaViPkSrRuEnxK/tIvkRdDIb+087oCSW2CputQ6lhx
         Gj/zKDLjdPCkuWH/tQ9e3d7ToO/2NYHsqO+Y44ZMPlMkN45UIohnBPZIfXUO6uTuBRSd
         tcRP4/vQW52iqtIIdlNx0F4ysdA0a5LOjPwzXi7RrUb6Epg46N9TP4lZTr+lawnNs6bt
         qmRg==
X-Gm-Message-State: AOJu0YyvqZRx9KPt4RnwjXGlGFU19L5POJ3o6R2Zua+2tZMuVEURj2Tb
	6p/E2pkgndR6eKbnN4Uzrz8bWDxx7xxM47xkyrucqlGQBnTzmIZDMB0G
X-Gm-Gg: ASbGncvloOHk9QDXNCPi7gybJm1+EFj3o7IWo9o76NblACcP/MGaGyl8LDGRan3/AGF
	saDbMR62bP4aHR/8SabX3wM6AF47ND+QMQC/0Js6En1fVA5lQH1Z3V4bmVZ7+sEtVXqKPkWz1fo
	aC7OtJqrCybEg+l/2ZuH2G6jZEpnhXDaIKgLY+dC5KlM3bfLS7IS04LzqO86gD52DfykZMo8H0z
	E+bKsrgpMY5rYy4baU+nf+yd6rE5Idb/leVVY5/TclsCwzz4YGYGFRcdzbY3ZbOoqdOE+YXqZOY
	Z9GHjAE=
X-Google-Smtp-Source: AGHT+IHr9DMJKqlbTPlfd+NbNgwh28HNT/sX+1cFkWdHXRAm5MpFyWtzzGZ2a4JtB5gChaumfktONg==
X-Received: by 2002:a05:6820:812:b0:5fe:9769:d1b9 with SMTP id 006d021491bc7-5fe9769e2ddmr2688301eaf.5.1740593159785;
        Wed, 26 Feb 2025 10:05:59 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fe9428c8b3sm755069eaf.39.2025.02.26.10.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:05:58 -0800 (PST)
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
Subject: [PATCH v2 06/11] x86/softirq: Move softirq_pending to percpu hot section
Date: Wed, 26 Feb 2025 13:05:25 -0500
Message-ID: <20250226180531.1242429-7-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226180531.1242429-1-brgerst@gmail.com>
References: <20250226180531.1242429-1-brgerst@gmail.com>
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
 arch/x86/include/asm/current.h | 1 -
 arch/x86/include/asm/hardirq.h | 4 ++--
 arch/x86/kernel/irq.c          | 3 +++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 8ba2c0f8bcaf..f153c77853de 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -16,7 +16,6 @@ struct pcpu_hot {
 	struct task_struct	*current_task;
 	unsigned long		top_of_stack;
 	void			*hardirq_stack_ptr;
-	u16			softirq_pending;
 #ifdef CONFIG_X86_64
 	bool			hardirq_stack_inuse;
 #else
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 6ffa8b75f4cd..f00c09ffe6a9 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -3,7 +3,6 @@
 #define _ASM_X86_HARDIRQ_H
 
 #include <linux/threads.h>
-#include <asm/current.h>
 
 typedef struct {
 #if IS_ENABLED(CONFIG_KVM_INTEL)
@@ -66,7 +65,8 @@ extern u64 arch_irq_stat_cpu(unsigned int cpu);
 extern u64 arch_irq_stat(void);
 #define arch_irq_stat		arch_irq_stat
 
-#define local_softirq_pending_ref       pcpu_hot.softirq_pending
+DECLARE_PER_CPU_CACHE_HOT(u16, __softirq_pending);
+#define local_softirq_pending_ref       __softirq_pending
 
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 /*
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 385e3a5fc304..474af15ae017 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -31,6 +31,9 @@
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
 
+DEFINE_PER_CPU_CACHE_HOT(u16, __softirq_pending);
+EXPORT_PER_CPU_SYMBOL(__softirq_pending);
+
 atomic_t irq_err_count;
 
 /*
-- 
2.48.1


