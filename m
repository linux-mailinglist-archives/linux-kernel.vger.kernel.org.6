Return-Path: <linux-kernel+bounces-527424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6D4A40B18
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B997003EF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCD6211A34;
	Sat, 22 Feb 2025 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLvMBLo+"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D0C1E7C24
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740251199; cv=none; b=uy6OZDxsdqU6wqZPL2z2DcbhUFdZzGnnKKQgqDD6IF7wVDHDhKDsue0IIiTNCJzOXYVXPAeQviBVdYcoSvqrAN/0ru5C5sgqkKg52NU4f0IhH2Ow6Zcp8R1GFLZDODvciE+aPuavmJSkBtkg0kOIQY2k3u8rQlq57CKaGfCngkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740251199; c=relaxed/simple;
	bh=MAYGHgbYKY62qo0XK/PUpsTFLR0EoTZHSLQDaF1ALp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODSs+4+ZPexqQk2LSnb/dI15pFdVAk0ez7GvFGzgRquvQpOqQmxd3DOQtofUGNJudD7ZDFQaC/GP54hqZWg41NZTWupl0uhezzb0jUuekM1Vwx2PUKBIrH4fDSkeuTiywlGA7uTPyAELn4EmIWcdVMpbk1xQcJLhLEwlj9lG7CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLvMBLo+; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7be3f230436so313323185a.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740251196; x=1740855996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xb9ZMWEswnCZqxNt4mNRr92ZbyiwfGCzO2RoU9QiMyc=;
        b=PLvMBLo+1fd1XYglQAXcde0fZCfV194Zn2fRy90Yt64GfX3IJwxQx5QtZdOhDyN2rt
         ftJm5e7f6WYq5BpyWt4Ft21hJdS7xI3eYYNDVajicH+YqvO1qi9s3u85kdDygXiNU19U
         SVTcHpG00RehtGr2cMi5caaWr3++dmX28fb0v/BDP8SPr8UlSfRoZnk1Xo67xdEh9vZM
         H9axsSr1YPgxgn61lmvaHEuJYm0wJEz2pJrsOUGbaGHQ2WCEOymxBRQxwkaGRrmBBwqu
         sH791ic3pHBAaL/lupinUKFdl8h6wZEwZud61ee2JR9hRRhoF7t6Bg+sTAebmcuK5Cxw
         bZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740251196; x=1740855996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xb9ZMWEswnCZqxNt4mNRr92ZbyiwfGCzO2RoU9QiMyc=;
        b=CQfvg+M9GD7zDaIjm1sGB4jll4Qrw/ceL3dD7uxxtON4kAqXu5Ug1Alfuh5Cjf/HG3
         ixs7fWZg9h+5/TQlMuNF6tIPUeUw9tq2IvGxNFMIdfg0pIX/hrsSttiNxyJ/5rwzFz5D
         U8Gz9YPqDsVF1Q+aBPeyHL1nBvEKXEoItDL5/dpz5ReJQFXHgDZ9vz5vVlIWxeZef/GY
         CsxCxu4Y3dk+rKVXNp9nYIYpYzEcAHuno/Pn4wjC38Bt0UnOa9ZtXV2fBn7nb5IOejJ0
         1Yrd1MB/oitNRT5Zau/9UmTiujlT53pIS28XsdOjS/znesHOmn8TYBDn+WwUPSYoP7ID
         3xDQ==
X-Gm-Message-State: AOJu0YyX0xnrT7BmmY8HIqkBpgQURmMHeKyMM59OqCszkG0/WnqnrFHG
	SkH8HgtguGUM72hLYHIzCj0IG4Ln+4S3NIhHO2VqrHAAVb8LP7QXukyB
X-Gm-Gg: ASbGncu5DefXAUZLASogIPJVF42qHQUZCv8ssh+AYbD/0vcmspzvEaWMUwVT9s45rey
	me+0QQ53+BIiojaJZc23cOQFIywlhxpwe79ADo9aAl9CzT4k0xH57OU8CDjyP7SmAqdlDgYloSC
	ahuJZGU2+QnIkJ+thuJkEQVkUrKBDh6E5RG/oasGNcYjyF5DYzgxYNDzthz6buZDoI/MOFz8cLq
	D+nfzgUTNbj5ZeLPpb9vBLiVgiaopCxpl3MJuvMC0P7Ye5G36QpLIHSzWk8U7z64rcKc404leef
	xCjAniU=
X-Google-Smtp-Source: AGHT+IGfMN71LzcwED6XyaagweDEqY2fd50Igd+UD/UEpy3LK9qv1UdfCEflzEfWCcFLjbYW3Ff6cw==
X-Received: by 2002:a05:620a:4148:b0:7c0:c13f:4181 with SMTP id af79cd13be357-7c0cf8adfdemr972294285a.2.1740251196445;
        Sat, 22 Feb 2025 11:06:36 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b1ef73b8sm550185285a.65.2025.02.22.11.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 11:06:35 -0800 (PST)
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
Subject: [RFC PATCH 01/11] percpu: Introduce percpu hot section
Date: Sat, 22 Feb 2025 14:06:13 -0500
Message-ID: <20250222190623.262689-2-brgerst@gmail.com>
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

Add a subsection to the percpu data for frequently accessed variables
that should remain cached on each processor.  These varables should not
be accessed from other processors to avoid cacheline bouncing.

This is intended to replace the pcpu_hot struct on X86, and open up
similar functionality to other architectures.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/kernel/vmlinux.lds.S     |  2 ++
 include/asm-generic/vmlinux.lds.h | 10 ++++++++++
 include/linux/percpu-defs.h       | 10 ++++++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 1769a7126224..049485513f3c 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -187,6 +187,8 @@ SECTIONS
 
 		PAGE_ALIGNED_DATA(PAGE_SIZE)
 
+		HOT_DATA(L1_CACHE_BYTES)
+
 		CACHELINE_ALIGNED_DATA(L1_CACHE_BYTES)
 
 		DATA_DATA
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 92fc06f7da74..aaa83ec3afe4 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -385,6 +385,11 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	. = ALIGN(PAGE_SIZE);						\
 	__nosave_end = .;
 
+#define HOT_DATA(page_align)						\
+	. = ALIGN(page_align);						\
+	*(.data..hot) *(.data..hot.*)					\
+	. = ALIGN(page_align);
+
 #define PAGE_ALIGNED_DATA(page_align)					\
 	. = ALIGN(page_align);						\
 	*(.data..page_aligned)						\
@@ -1065,6 +1070,10 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	. = ALIGN(PAGE_SIZE);						\
 	*(.data..percpu..page_aligned)					\
 	. = ALIGN(cacheline);						\
+	__per_cpu_hot_start = .;					\
+	*(.data..percpu..hot) *(.data..percpu..hot.*)			\
+	__per_cpu_hot_end = .;						\
+	. = ALIGN(cacheline);						\
 	*(.data..percpu..read_mostly)					\
 	. = ALIGN(cacheline);						\
 	*(.data..percpu)						\
@@ -1112,6 +1121,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 		INIT_TASK_DATA(inittask)				\
 		NOSAVE_DATA						\
 		PAGE_ALIGNED_DATA(pagealigned)				\
+		HOT_DATA(cacheline)					\
 		CACHELINE_ALIGNED_DATA(cacheline)			\
 		READ_MOSTLY_DATA(cacheline)				\
 		DATA_DATA						\
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 40d34e032d5b..7db773ae5b52 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -112,6 +112,16 @@
 #define DEFINE_PER_CPU(type, name)					\
 	DEFINE_PER_CPU_SECTION(type, name, "")
 
+/*
+ * Declaration/definition used for per-CPU variables that are frequently
+ * accessed and should be in a single cacheline.
+ */
+#define DECLARE_PER_CPU_HOT(type, name)					\
+	DECLARE_PER_CPU_SECTION(type, name, "..hot.." #name)
+
+#define DEFINE_PER_CPU_HOT(type, name)					\
+	DEFINE_PER_CPU_SECTION(type, name, "..hot.." #name)
+
 /*
  * Declaration/definition used for per-CPU variables that must be cacheline
  * aligned under SMP conditions so that, whilst a particular instance of the
-- 
2.48.1


