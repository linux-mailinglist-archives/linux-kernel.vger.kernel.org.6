Return-Path: <linux-kernel+bounces-527430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FCDA40B1D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C179B170836
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7232214222;
	Sat, 22 Feb 2025 19:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqeKrO7l"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16F3213E71
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740251213; cv=none; b=XszLAYPJZL9Wu7/xJXrxiewLrsGpHsnDpkWRb4qiaHoT4WEolbKhBdVjsNYsEb0dIsx5W/DCY+R7ucZ3uVLzUADKEJs1oU5Ntu+YwCxRIz6sHuov2XP23NAKQGW51F+b0zRAsA9lWOQA190Gla/6GfNLwvkfcYnfNIfQi9fCc7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740251213; c=relaxed/simple;
	bh=T7mEmpFC1wFdy0W9hebceemBNBWGIYtmF1qKxtl3z7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcUXkdXzPmpWe1PQzxbh6Hi6CteZtKarE238aK9yAjBVZNDMIi9W0npvYTFUlPoBSFKMlQvzJdFXvp3PqOn86heEA3VuQb9Fj3sLt8074jCkTtau14OIicNXT8r4bg2jAYIc8Vv0602+4i7bLxlavecyAp9YLTVDlIBHArHSai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqeKrO7l; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0a1c4780bso328431885a.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740251210; x=1740856010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEr+HVsM6xtJa9sjUwL5+hzjYi8sZRQw9jjeFW5Hz0I=;
        b=AqeKrO7lWVnZQJ5+MYm72xsgxVQ3HBG4nx/zGodSlzbXGxbaHU5EUN86KH9vAxh+vg
         ULJB0kJjmsN+V9zl/ae6fr493Tf/CO1/BA2TliAmBumY9yfsjhNz/NnUzgV1r24pLe1i
         ZfuMwbDzPpoROPW3e8TLAj8m0kIZ/PQ3BJ4OuBJVsxKD1TqKbDuwJWHVoXBJMPeYa6E1
         2wiM4bm/4petORt47U4mL4mzrK6ki1AJIEZxGvjXJyUm1ccOQJayc0tKykL+LqCbSyBf
         EHnTvokKyIpVRF8tRUxnbXMkYRR+eusiEcATzyt7Fw2BzGWsOtPfUCNri1nzqZx9CEHB
         XV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740251210; x=1740856010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEr+HVsM6xtJa9sjUwL5+hzjYi8sZRQw9jjeFW5Hz0I=;
        b=Kp7W/SvG29NpcxuSHZjJLXlxyopb6UaJMU0nwM1gsf3WOF+KvuDVgck2dp1fiilr+g
         FhU0eg6Wr4yrKQj8hTbE6aIOkYaOVGdR3UaIlhGYBtuCf4J313gDgyzIRAwsUx2xCoBM
         ct+7aXYkrwhJSRJbjrHSNbmPsuCEa08kuymcbEE9J1cp+2Xz1M2y/RWFI4nSjL0irQnc
         1rDh3TgVhOFe9lHFRhK0jrb8lkDvTGTTHyIt4l1kY4x7dSJQpAOMECjJCwEfZANF4hsQ
         z3PoQvwrDb92QtPe2U1UQkuW1BfL9eaQfnmrxEd3lcsUWRfmovYYAd3JoUciRPHUkeYS
         EhBw==
X-Gm-Message-State: AOJu0YwKPywUANUK1/JZfnHlLmaHF7CQ6x6pp1hObgT+XuCd4q8Q3/KE
	1dIgP/DnRNPjz0vqVzRdSZtCNsg3ipDxltqE16pp3Ovbzs0cJmR2+vn1
X-Gm-Gg: ASbGnctjFAmK/hLDXF9m7L8oxG+6LHZWrE+/r0VJ3IMkh/z5L0yzjdomPlX1y3RVUga
	m78RtcklvbPYIyZwosZ4MMRB/58PbfWu6ieigOycjAhMvXBBPf/gsYNt3OgkXVD46TX9JISurpn
	O8dpg2xCNWCQzVv/ixnBzdTDgbRpCOnwC4qVKQ7kC0xbLjnvBpYMagt5uaBmPoDJAtvBu89Raxy
	shIH1pYTRJVZJvOGZ4laSAwHJNNvU8+TwQbsXN4CGtL4Hj4MtQvmcvys35PhvvSN48i8ZBgzkTa
	BSZs3/g=
X-Google-Smtp-Source: AGHT+IG0M9k0xj06pItA+FR6Si4ubLa+8PsF+seWp5HNzoXUonYRUtnC0WRiuLDwyL8a8Q1Lw+eMiQ==
X-Received: by 2002:a05:620a:444c:b0:7c0:ae2e:630d with SMTP id af79cd13be357-7c0ceefe6c0mr962405485a.16.1740251210169;
        Sat, 22 Feb 2025 11:06:50 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b1ef73b8sm550185285a.65.2025.02.22.11.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 11:06:48 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [RFC PATCH 07/11] x86/softirq: Move softirq_pending to percpu hot section
Date: Sat, 22 Feb 2025 14:06:19 -0500
Message-ID: <20250222190623.262689-8-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250222190623.262689-1-brgerst@gmail.com>
References: <20250222190623.262689-1-brgerst@gmail.com>
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
 arch/x86/include/asm/hardirq.h | 3 ++-
 arch/x86/kernel/irq.c          | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index d51299af6145..6de46e2ae2b6 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -16,7 +16,6 @@ struct pcpu_hot {
 	union {
 		struct {
 			void			*hardirq_stack_ptr;
-			u16			softirq_pending;
 #ifdef CONFIG_X86_64
 			bool			hardirq_stack_inuse;
 #else
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 6ffa8b75f4cd..fa8ae99d62dd 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -66,7 +66,8 @@ extern u64 arch_irq_stat_cpu(unsigned int cpu);
 extern u64 arch_irq_stat(void);
 #define arch_irq_stat		arch_irq_stat
 
-#define local_softirq_pending_ref       pcpu_hot.softirq_pending
+DECLARE_PER_CPU_HOT(u16, softirq_pending);
+#define local_softirq_pending_ref       softirq_pending
 
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 /*
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 385e3a5fc304..1b51d5c05583 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -31,6 +31,9 @@
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
 
+DEFINE_PER_CPU_HOT(u16, softirq_pending);
+EXPORT_PER_CPU_SYMBOL(softirq_pending);
+
 atomic_t irq_err_count;
 
 /*
-- 
2.48.1


