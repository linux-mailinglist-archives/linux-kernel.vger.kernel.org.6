Return-Path: <linux-kernel+bounces-534588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CD4A468DE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A6F1889180
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FBD22F163;
	Wed, 26 Feb 2025 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9d1ykPI"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A50C2063FD
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593147; cv=none; b=SdSoZOUEV7u1821xMx6YUuH9PXAI4PrG+lGZ+UjUFf1fml8x37tOCmNXeNTOC9qdluQ1ZG70DZaIUd7nxH+/JCqS+vLuvMJe3dI3j51VMM2kgxppVK6kBvb7LKXZCvX+bERDWcO27hY5H7FlLbkl1GwGS45o4+dyb2X39g6fbBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593147; c=relaxed/simple;
	bh=UQtlk10D5PbqASuqCZBhI2xw+GvBFK3TWkMH16CPook=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYm3ima0KipjOnZDS/vzYSbjwKx3E/rp2CmjfPraVs9NFEephhTj+pbkW1DMfgF8HkAXCNEI/4VGK5Cv+8mXnHzi1IllOwFyvdOW0HHHELYOCRBY+/PwcMHiw2GiW6/t/9ijirXuJQ+pySkIqMrHgEc6AnzBxzn4xilnChL2WPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9d1ykPI; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3f40b8358dcso72626b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740593144; x=1741197944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mh5QCRSwNUxHFOsHYRm2HTz8oiL+OJA191UzYywUmTc=;
        b=X9d1ykPIkjBZytKCd5nleAjnmNeitHzWUh5hPt3A11bCtJJRnpBPxMfhx4pCrRiwRa
         7628cG4BY0zALGkY8xLzchV2NDKJLhqV7FnuDOD5r0/jdtbst++yo++a89YhKCP/JX4w
         TODja8vDKc8LODy5uRV57GgGrgCYCSa8kHLzq5PFfvcth3To89STweUnvPMWEBWKNxtI
         zKwGM1Il7135tLEzlzx2NZUbYkwxw7OnE958IqZqrQ6D7ZItIuMQA5xOXHx+/YvGRtNP
         X/xvbamkis0ONOXPPk4hI+osNxq40GzSSYGisg2ho7/I5WdPPyNZA99uH59pMK4XH6w2
         UhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593144; x=1741197944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mh5QCRSwNUxHFOsHYRm2HTz8oiL+OJA191UzYywUmTc=;
        b=JPU3CxtvytiA+xDcI+5L6J/BaeQeu8BvQIeqq3+Sjv2IOeRf8IVSX1+VMo/5ok+ClG
         Ov+qrP7jK1mGPNSmCEDLb5gCa29myZYa/3153Xqxivf/lPpkS41EH3w5mPzCg+r32in1
         SvsqYp5kVCLYISgplsiHFJvuHwwfx5yf+pS7Oi+Mghk16Wju51yiYF06QYfWkzIDqF9W
         xEF4rpZK697l/qWzhU5UEWaunEfV2CCwOaDT9jyEVNIH8MkOjBV5UP/6yK9wsfxOxAjC
         9Wke1FzWHbYnEjNolni23DylUGbhA9KiNDyObJEZWtvCFz/dry5ZAo75eAhh9xKCdONc
         1Gmw==
X-Gm-Message-State: AOJu0YzjZUvzQNMKnozRsq+i28ZpQpUBWaViP9Tg7WkSIkYldO+glZCJ
	ahrMKBvbtTSbnT+1MG7F2aw+jusQv233qnZvXYAr/BFRjuQ9etDF70Q5
X-Gm-Gg: ASbGnctAMa21tLu5WWrPcI72GmJPIdLF+Yxoj7N3rNkfRT7s4VHAWfwMRpTYB7l7lbG
	kIzG+wqSGnVhQ6NjuxTYEXKXcVOJeRzQw6auTDhv2TZnfffKOK42fuMKMYBGtbnRCCSOx5UGI27
	hIKOCTkLilkSvyUmSYbc3nEiPMNrr4TSB1SjGiUmGYS43LtqZ/7Y7Q6hku3ONlvp91ePczJAyOo
	B6VUEduvCQ23/7bcc3eSW4VRlPeImQngCNkhiafHtu0J1JYF4Agrs9przLk0QPga6rLTNZyj9YJ
	vXludVY=
X-Google-Smtp-Source: AGHT+IEoPG9jrqJr5ixSU63WTOykbmDB7N1zOonRAcE2uVu3tibPzhJ+cBpV3QfPT2ofHhZwl6TR+w==
X-Received: by 2002:a05:6808:2f1b:b0:3f4:159e:1199 with SMTP id 5614622812f47-3f540ee6ae3mr4712349b6e.20.1740593144163;
        Wed, 26 Feb 2025 10:05:44 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fe9428c8b3sm755069eaf.39.2025.02.26.10.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:05:43 -0800 (PST)
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
Subject: [PATCH v2 01/11] percpu: Introduce percpu hot section
Date: Wed, 26 Feb 2025 13:05:20 -0500
Message-ID: <20250226180531.1242429-2-brgerst@gmail.com>
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

Add a subsection to the percpu data for frequently accessed variables
that should remain cached on each processor.  These varables should not
be accessed from other processors to avoid cacheline bouncing.

This will replace the pcpu_hot struct on x86, and open up similar
functionality to other architectures and the kernel core.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 10 ++++++++++
 include/linux/percpu-defs.h       | 12 ++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 92fc06f7da74..92dd6065fd0a 100644
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
@@ -1065,6 +1070,10 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	. = ALIGN(PAGE_SIZE);						\
 	*(.data..percpu..page_aligned)					\
 	. = ALIGN(cacheline);						\
+	__per_cpu_hot_start = .;					\
+	*(SORT_BY_ALIGNMENT(.data..percpu..hot.*))			\
+	. = ALIGN(cacheline);						\
+	__per_cpu_hot_end = .;						\
 	*(.data..percpu..read_mostly)					\
 	. = ALIGN(cacheline);						\
 	*(.data..percpu)						\
@@ -1112,6 +1121,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 		INIT_TASK_DATA(inittask)				\
 		NOSAVE_DATA						\
 		PAGE_ALIGNED_DATA(pagealigned)				\
+		CACLE_HOT_DATA(cacheline)				\
 		CACHELINE_ALIGNED_DATA(cacheline)			\
 		READ_MOSTLY_DATA(cacheline)				\
 		DATA_DATA						\
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 40d34e032d5b..eb3393f96e5a 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -112,6 +112,18 @@
 #define DEFINE_PER_CPU(type, name)					\
 	DEFINE_PER_CPU_SECTION(type, name, "")
 
+/*
+ * Declaration/definition used for per-CPU variables that are frequently
+ * accessed and should be in a single cacheline.
+ *
+ * For use only by architecture and core code.
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


