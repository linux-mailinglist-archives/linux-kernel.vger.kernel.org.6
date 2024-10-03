Return-Path: <linux-kernel+bounces-348944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314F698EE4D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5568A1C21348
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC30B155325;
	Thu,  3 Oct 2024 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzWt/KQA"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FB11474C5;
	Thu,  3 Oct 2024 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727955528; cv=none; b=C5pjXdWSJ2Zt6XRj7GIsryZrLVAtbEIHxJgEsgJ3o45qJZ4JD7VK6AthH+A5FuKQ11YbkoD2DnrXSIuU9RQC69pyvbibwD2+WEX4El83zzBL8MO3GJzCobn7H3GdqGS6HcCeNct5IRHm9axr+8gapNau5ZDMKARv7E/hxouhJOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727955528; c=relaxed/simple;
	bh=tzdIj7Pmuk8vTXjUwDMnaYiElu+3TR3K2rs5MMV1AJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qqNhH6BMp/gjYMv0/FE76gzePrcwwSpioRr3K0rcvAdfF0HEX183/EbwOhDm2+HTd/mkzpKPpvfHag7WIR0dM8zHRUMVTDNNUxv5L3EqCyVBwwaqgGbhbqb9aBqmTQmE/af13/A/QD5m9cbzSaQaw3n3RggOKFPKUX6cBq/0MmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzWt/KQA; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7ae3d9a93c0so87006585a.3;
        Thu, 03 Oct 2024 04:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727955525; x=1728560325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QH30CE01/KIA8vmhQ9aUPnrMhqjqonBdBshFm2UJvlQ=;
        b=GzWt/KQAbs/A3Rdc279i8cM3MurvV98HGBAovlZtQrGXDkJH7EnXf8dlvRWG5WDS49
         HIu/TXm4a0PXxolG9hMxiCgKgPBvVZEB10fGB7WC3vq/tkbYLQYCO2u5tQ0rb36Rnb2K
         aqz/VXZZaqnaW2zzFlZ0SHIulTos323Hvy7htVYbzo5v0lybOPpnskVdLu/4CXEpQJDQ
         99FGzxSxuQCl/gu8KwkM5wKyQVwt23YL9PDDchnWgnzS3LA6OHVDeAsRFPz7h2viy1sk
         mxmjnPBvnM/2Lw7HuNP2mOkO445V7jLKdlxYczAMnL5ekXKe8jrfVZ3tT4qbcbGAcVBO
         La2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727955525; x=1728560325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QH30CE01/KIA8vmhQ9aUPnrMhqjqonBdBshFm2UJvlQ=;
        b=jseUPaWUnmbsi8gD4+c+oSG7r2bpIJxqz8CGxNa2H4JkbCm74s2o+3FjMKGXWlsD60
         Nj4wcFVN6SmfcjJpR2IEadvw5BwjMCWdeLYLjp9t4AsBt16GLNKi+FtKTCKdefITI5sk
         29pDMUej6CqEWQBa0hpoe0DLJOm5oHShwvNZLrC8KQT3FRNwSjoTwDLUhU1tZTOfNbX2
         oCWIgwgB2m+5/P8ikcUNNtTbkz6X1fe7s5j9jd1vm7vD++ur5uuuG9tp6OAkGxZAcQgM
         bYYNNCPXhFuuXQ4BmtCvaSh1taeb3/G8aEB/+kw63LYTEh2mbtik1BUwSVhli4F+oJk4
         3oog==
X-Forwarded-Encrypted: i=1; AJvYcCVb4nsuXjEPneTq8wjSwPwmVWHCVep/kWQfGw+9/nH2bJDYCDspZ5wR0udZmkC5TzM5KG933m6E7SgC@vger.kernel.org, AJvYcCVczOVrVJAagx392dh2WhGToXR+DUPnjV+STLCtAUd61ABp3KpdAcGG8fZV5mLVEA23VTCicKKxddJLU/Ob@vger.kernel.org
X-Gm-Message-State: AOJu0YyApBIF+MkMI89DkxlwSvoGhs8lf8oVuSp5Nx7l6MTTtNTf71vv
	5PtLq1fSQPPIQOdLYPyUc7iGH3f6JR0N11veerSkC6ZGbkzC2Iw9
X-Google-Smtp-Source: AGHT+IEsftUbErs0PEHHR3fZPjrpqAZaPwPf+30Hv6n3XFmFyIPXQLxmLuXNFR3P1/kV98FpLv5gzw==
X-Received: by 2002:a05:620a:1921:b0:7a9:bb10:e072 with SMTP id af79cd13be357-7ae626bda77mr996374285a.23.1727955525448;
        Thu, 03 Oct 2024 04:38:45 -0700 (PDT)
Received: from localhost (fwdproxy-ash-004.fbsv.net. [2a03:2880:20ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b39ca00sm43757985a.43.2024.10.03.04.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 04:38:44 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: mark.rutland@arm.com,
	will@kernel.org
Cc: leitao@debian.org,
	catalin.marinas@arm.com,
	robh@kernel.org,
	saravanak@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH] of/kexec: save pa of initial_boot_params for arm64 and use it at kexec
Date: Thu,  3 Oct 2024 12:38:40 +0100
Message-ID: <20241003113840.2972416-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 __pa() is only intended to be used for linear map addresses and using
it for initial_boot_params which is in fixmap for arm64 will give an
incorrect value. Hence stash the physical address when it is known at
boot time and use it at kexec time instead of converting the virtual
address using __pa().

Reported-by: Breno Leitao <leitao@debian.org>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Fixes: ac10be5cdbfa ("arm64: Use common of_kexec_alloc_and_setup_fdt()")
---
 arch/arm64/kernel/setup.c | 8 ++++++++
 drivers/of/fdt.c          | 6 ++++++
 drivers/of/kexec.c        | 8 ++++++--
 include/linux/of_fdt.h    | 2 ++
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index b22d28ec8028..a4d96f5e2e05 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -194,6 +194,14 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
 	/* Early fixups are done, map the FDT as read-only now */
 	fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
 
+	/*
+	 * Save dt_phys address so that it can be used later for kexec. This
+	 * is done as __pa() is only intended to be used for linear map addresses
+	 * and using it for initial_boot_params which is in fixmap will give an
+	 * incorrect value.
+	 */
+	set_initial_boot_params_pa(dt_phys);
+
 	name = of_flat_dt_get_machine_name();
 	if (!name)
 		return;
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 4d528c10df3a..9e312b7c246e 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -457,6 +457,7 @@ int __initdata dt_root_addr_cells;
 int __initdata dt_root_size_cells;
 
 void *initial_boot_params __ro_after_init;
+phys_addr_t initial_boot_params_pa __ro_after_init;
 
 #ifdef CONFIG_OF_EARLY_FLATTREE
 
@@ -1185,6 +1186,11 @@ bool __init early_init_dt_scan(void *params)
 	return true;
 }
 
+void __init set_initial_boot_params_pa(phys_addr_t params)
+{
+	initial_boot_params_pa = params;
+}
+
 static void *__init copy_device_tree(void *fdt)
 {
 	int size;
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 9ccde2fd77cb..ca9f27b27f71 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -300,8 +300,12 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 		goto out;
 	}
 
-	/* Remove memory reservation for the current device tree. */
-	ret = fdt_find_and_del_mem_rsv(fdt, __pa(initial_boot_params),
+	/* Remove memory reservation for the current device tree.
+	 * For arm64, initial_boot_params is a fixmap address, hence __pa(),
+	 * can't be used to get the physical address.
+	 */
+	ret = fdt_find_and_del_mem_rsv(fdt, IS_ENABLED(CONFIG_ARM64) ?
+				       initial_boot_params_pa : __pa(initial_boot_params),
 				       fdt_totalsize(initial_boot_params));
 	if (ret == -EINVAL) {
 		pr_err("Error removing memory reservation.\n");
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index d69ad5bb1eb1..dbd99bf21ac8 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -31,6 +31,7 @@ extern void *of_fdt_unflatten_tree(const unsigned long *blob,
 extern int __initdata dt_root_addr_cells;
 extern int __initdata dt_root_size_cells;
 extern void *initial_boot_params;
+extern phys_addr_t initial_boot_params_pa;
 
 extern char __dtb_start[];
 extern char __dtb_end[];
@@ -73,6 +74,7 @@ extern int early_init_dt_scan_root(void);
 extern bool early_init_dt_scan(void *params);
 extern bool early_init_dt_verify(void *params);
 extern void early_init_dt_scan_nodes(void);
+extern void set_initial_boot_params_pa(phys_addr_t params);
 
 extern const char *of_flat_dt_get_machine_name(void);
 extern const void *of_flat_dt_match_machine(const void *default_match,
-- 
2.43.5


