Return-Path: <linux-kernel+bounces-542372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADFCA4C8FC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C594188CA17
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E186E25DD11;
	Mon,  3 Mar 2025 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATpBB0s5"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8EE25DCF0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020796; cv=none; b=RQVTPCzbrOPI2yyi942D+ihSPo3mKXF9cvOfnBTuIjlettdioDbK6d1KcKdGAU21xZy4swvIiqFdXxhyTPeRR0vf6qQHml4j8GEtuuZNgtNg/gik+m8sUweTeFUG40oInSeS3gNA0yrJpiYo4Uv7rv1Pt+pdHn7wCGvP6Sd85SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020796; c=relaxed/simple;
	bh=PiXmU6lUBB5AxY09cRXKal52ViVGG4MfYTE3SZPxqoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlY1UdED31e0Ty74fOLC6j6Cx8C6QIwRcYFZK5R1TbNgVFJnILQ2Q7eK/H/ez5AL0nen0o3A7bgR7W+d5K/7n0WOEL+K2nC1Ns+IHM5kN4hrchMByl0AXES0au4BHKUZdxCy4/btM8Ns52lBvwq1ti3sG6PhCMZxktm9C3ya91o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATpBB0s5; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6dd01781b56so55034586d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741020792; x=1741625592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3glzTjf8IgiUSBtnGndwG/CjLpV6ZT+iGSPTYBmwgQ=;
        b=ATpBB0s5xF0/1c+udxIXo9f+zN/V7gMJwZPknMHBivZVqeQgq/w8YMuWOoAMPVjoZo
         kIWk9S/CSi1613gQv0Q0KtRLXyZmS1iVCg9b+b1UfuR2nSV9HpNvUke0hXY4wL0LHMLj
         Zsu0lol6PlI9DnYGP0iCxHjbtfb0CC4dzOp+YUPawj8kFdmiLEndEJxJ9TaJjkZQ8udH
         qDvSsH4D3ROdAT3AUm1keXTWPUDuRPqgvxvv86R1qkVIFTmJkBu+Rl79vnvy+Tz2Yz/V
         ZJfmXjDEzxsBIaOijyPOUqyDmgVSyv4TeZbb0SVd0n08Cm6r7pvL5N12MHFpqdFLYDWB
         VWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020792; x=1741625592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3glzTjf8IgiUSBtnGndwG/CjLpV6ZT+iGSPTYBmwgQ=;
        b=dfoe8LciiviF4C6agExAmmFflKyr/7fUEYFQHMb+FCrBfuvjw8/ZgSL0sTUY5tlPOF
         56DVPF6rkMMNmR2FjmXRFxHc0I4qQXwaRx7w3aWIEOipwDEDLKHXmVhDDHfpdOOcsDbo
         lhOcze6WKgEntrUvcFRQhidjB9k4+YpK9OJQfwgr9sMS7t13JnK8Yxe/poe6fQwwA6e8
         3kL/BTZRQ8EILOs2xpEctMtDeo2I8VX6YN6w8Vs6uJqdC0vPH3zZLzw4kUFxdXC/QDeK
         RX5Zt1LAOXxYivkmz79deOYdqy/Tcq6DatmS7S9jObPnSz9yNjUijSCBt0A8qpFa1IVJ
         CNdA==
X-Gm-Message-State: AOJu0YyS+VwHit3EginEZgmSd31rHgdYFv8tNG6SJChudbisod/NZ6Ki
	sKuMTcWygMViRyXvxeHMFat9EyGVJK83NE/uYUB7DtRIA4lcm3EZlkO5
X-Gm-Gg: ASbGncsSMoE5S/bj3vyqqzOMc4qteXZGlPleB2WNBKbNWXr+9yMtjc1XlJ7zHyxm9nP
	+RW++Els8e3ZP3BU1z6f1GhfHnRdl8684OZs+Il9hYKJ1o1je7E3geLdxdJ6TY2psnBrrU0+RaT
	U6+jA+rq3Vp+pOqjyb6uLSRXyF+Jm+H+H4d0gUwT4zkNLf4Y6YQL/MUuw9cTTnkXnExd0Vx8R/t
	k7joIokxWL06WItVjJeMi7mX8nfyMHh3787KJkjC+T1+lolDZoefemrlcI0AlLzQFZ8p+mjixZ7
	a0UOUoWD4LrqucUxJysT8GnG0A==
X-Google-Smtp-Source: AGHT+IFZQ88ZlYfzX2N54kSWRFQ+paaHStvVgF3kPHPVSggP3M6SGgBSnH7+SCEx/2ZbKT/ghbDPMg==
X-Received: by 2002:a05:6214:21e7:b0:6e4:9b59:d9ce with SMTP id 6a1803df08f44-6e8a0c7fdf6mr213591196d6.5.1741020791886;
        Mon, 03 Mar 2025 08:53:11 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976cc9cdsm54730936d6.88.2025.03.03.08.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:53:10 -0800 (PST)
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
Subject: [PATCH v3 01/11] percpu: Introduce percpu hot section
Date: Mon,  3 Mar 2025 11:52:36 -0500
Message-ID: <20250303165246.2175811-2-brgerst@gmail.com>
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

Add a subsection to the percpu data for frequently accessed variables
that should remain cached on each processor.  These varables should not
be accessed from other processors to avoid cacheline bouncing.

This will replace the pcpu_hot struct on x86, and open up similar
functionality to other architectures and the kernel core.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 11 +++++++++++
 include/linux/percpu-defs.h       | 13 +++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 85fc0524f161..4ed0e6a013d0 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -385,6 +385,11 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	. = ALIGN(PAGE_SIZE);						\
 	__nosave_end = .;
 
+#define CACHE_HOT_DATA(align)						\
+	. = ALIGN(align);						\
+	*(SORT_BY_ALIGNMENT(.data..hot.*))				\
+	. = ALIGN(align);
+
 #define PAGE_ALIGNED_DATA(page_align)					\
 	. = ALIGN(page_align);						\
 	*(.data..page_aligned)						\
@@ -1064,6 +1069,11 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	. = ALIGN(PAGE_SIZE);						\
 	*(.data..percpu..page_aligned)					\
 	. = ALIGN(cacheline);						\
+	__per_cpu_hot_start = .;					\
+	*(SORT_BY_ALIGNMENT(.data..percpu..hot.*))			\
+	__per_cpu_hot_pad = .;						\
+	. = ALIGN(cacheline);						\
+	__per_cpu_hot_end = .;						\
 	*(.data..percpu..read_mostly)					\
 	. = ALIGN(cacheline);						\
 	*(.data..percpu)						\
@@ -1111,6 +1121,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 		INIT_TASK_DATA(inittask)				\
 		NOSAVE_DATA						\
 		PAGE_ALIGNED_DATA(pagealigned)				\
+		CACHE_HOT_DATA(cacheline)				\
 		CACHELINE_ALIGNED_DATA(cacheline)			\
 		READ_MOSTLY_DATA(cacheline)				\
 		DATA_DATA						\
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 40d34e032d5b..0fcacb909778 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -112,6 +112,19 @@
 #define DEFINE_PER_CPU(type, name)					\
 	DEFINE_PER_CPU_SECTION(type, name, "")
 
+/*
+ * Declaration/definition used for per-CPU variables that are frequently
+ * accessed and should be in a single cacheline.
+ *
+ * For use only by architecture and core code.  Only use scalar or pointer
+ * types to maximize density.
+ */
+#define DECLARE_PER_CPU_CACHE_HOT(type, name)				\
+	DECLARE_PER_CPU_SECTION(type, name, "..hot.." #name)
+
+#define DEFINE_PER_CPU_CACHE_HOT(type, name)				\
+	DEFINE_PER_CPU_SECTION(type, name, "..hot.." #name)
+
 /*
  * Declaration/definition used for per-CPU variables that must be cacheline
  * aligned under SMP conditions so that, whilst a particular instance of the
-- 
2.48.1


