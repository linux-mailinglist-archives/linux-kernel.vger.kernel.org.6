Return-Path: <linux-kernel+bounces-310596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BACCF967ED6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44FEE1F221AA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 05:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1F314A611;
	Mon,  2 Sep 2024 05:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="owCC+s+6"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B63145B14
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 05:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725255112; cv=none; b=nagy/NGmFU5VWVSPPuSj8owT4g/D9yDzMonmvxfjz3wRxFvwJjpGrBs0WMY40EYPntoNsWcZ8ihN3P6oKZRNh9FXC7UMWxjSR12OBgSqV/FET1bpgEbnip1p2ovyAdpkJpv8eihXNATRuKyhRDKg112U2nxVL7lljsrFpcR7idw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725255112; c=relaxed/simple;
	bh=Q7cfUD0xE+Etw31ngKTFcFdjMIVZjmy76Ww6nw1tPQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGQkCyarmdD+r5duEeuMak5B/RySwRnk4FCSvEsp0x9vGH9NlPmkSM/+TKJFG5CIhYWOQKB7CdFcTUK3QRaERtunIUl9OOfrRWbaAt6/yhhTw/06IsO0txEtNF9ST70SHfnH3Jl/961WCeK8mOYRLp9B0XD7fvhe74FLGTzzi3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=owCC+s+6; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71428f16b09so170264b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 22:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1725255109; x=1725859909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56VTu/qXLVL5nMG+uXbgMEcYFDCqL3Blag2bpSCjYxk=;
        b=owCC+s+6e4aL4/7TQvNhkEGvAAmSOimjxLERp5zYSkgnasaZ/aCrtYItPoPJTrgKi3
         SxsyMK/4rB+DE1XUXvWC1lBzyxd8woS7gmfo/KSIEK2VhUOMV58xZ0ujNKiIs62WmQex
         P5HWHbOBxqu4c1FJgyWCUHUxORozYRfJj6uSzoYgpSbdzFp0XjSpURFuGWZ9LLIjWFAw
         mlpOVZZhVP+zUGppykkf0UDSD/MvPbyRP6iqYdjg+FUvlABwpN+kBlHWLrTPGqgF1sFs
         ihtE//IHdGsHbovs17Aci5E1zAGR3TFuy+BELHv4i2OdF1V0PYhr60QSCz1CTt/AlsGp
         LO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725255109; x=1725859909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56VTu/qXLVL5nMG+uXbgMEcYFDCqL3Blag2bpSCjYxk=;
        b=ZTdHUTrtx+5bBsztlIFJ/s5FH9PN30YrcrlCJlpuCnZmnuHB4/YiEjl04kR6Sn6Dhr
         J2vcLJs85ZYQ6zdqWDpoFTk43sGHLS/SiLXKwQ7xvWkcA/83DlE1iq/0RSka9i29D6YC
         HvNaaqq/xyX2CohXJyjET+/OLquPCFzqtl4n5kYoSMIqR4G6Q8KqT4MqUZq6F78qiuLo
         NmOyfsHd/csDMv8mmAoJUsK0l1tJV9FrV88o55tczZajdNpQAcxHmedBy9lMYPNqyw/s
         uCBDFt99wVG/zmBWI7zHIfxLeSYapqTgHkH5ZvlUrJ1noxCJeTTgxVp+P6iS0sqOdfzG
         4d5w==
X-Forwarded-Encrypted: i=1; AJvYcCWj5+Od7Ay+X5y6x5lT6Ihfw1I3cVuEo3a+R6UimUj3hzxRf/0rgsrzaXOykmI7ZkEtjy8YZ78eqv7BT0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YycNwHjqLn1RRrbFDlvfJglcwrKVmDXhiUcvh7ubtaa9t2TGyWR
	h/nMHXDemFyd1OWnppCZO99w2gF8CwGgzXKp1TOQZQCfEEajqX+eWZmtUfiFP2g=
X-Google-Smtp-Source: AGHT+IHP9EQ25y63/ZmPp8u38IbeoRt/KYiwtSvqUDmg44wFA6t/ROSaOYVvZchoffP9nEa6l2KaPg==
X-Received: by 2002:a05:6a00:1a8e:b0:714:21c2:efb5 with SMTP id d2e1a72fcca58-717305d65acmr5552903b3a.1.1725255108509;
        Sun, 01 Sep 2024 22:31:48 -0700 (PDT)
Received: from telecaster.hsd1.wa.comcast.net ([2601:602:8980:9170::901f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a692fsm6076279b3a.60.2024.09.01.22.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 22:31:48 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-um@lists.infradead.org,
	kernel-team@fb.com
Subject: [PATCH 1/2] mm: rename copy_from_kernel_nofault_allowed() to copy_kernel_nofault_allowed()
Date: Sun,  1 Sep 2024 22:31:28 -0700
Message-ID: <c50815dee5c244274e880b0fc4253deaf72b9165.1725223574.git.osandov@fb.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725223574.git.osandov@fb.com>
References: <cover.1725223574.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

All of the existing checks are applicable to both the "from" and "to"
directions, and the next patch needs it for copy_to_kernel_nofault().

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 arch/arm/mm/fault.c         | 2 +-
 arch/loongarch/mm/maccess.c | 2 +-
 arch/mips/mm/maccess.c      | 2 +-
 arch/parisc/lib/memcpy.c    | 2 +-
 arch/powerpc/mm/maccess.c   | 2 +-
 arch/um/kernel/maccess.c    | 2 +-
 arch/x86/mm/maccess.c       | 4 ++--
 include/linux/uaccess.h     | 2 +-
 mm/maccess.c                | 7 +++----
 9 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index ab01b51de559..3fef0a59af4f 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -27,7 +27,7 @@
 
 #ifdef CONFIG_MMU
 
-bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
+bool copy_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 {
 	unsigned long addr = (unsigned long)unsafe_src;
 
diff --git a/arch/loongarch/mm/maccess.c b/arch/loongarch/mm/maccess.c
index 58173842c6be..70012ac0a5a8 100644
--- a/arch/loongarch/mm/maccess.c
+++ b/arch/loongarch/mm/maccess.c
@@ -3,7 +3,7 @@
 #include <linux/uaccess.h>
 #include <linux/kernel.h>
 
-bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
+bool copy_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 {
 	/* highest bit set means kernel space */
 	return (unsigned long)unsafe_src >> (BITS_PER_LONG - 1);
diff --git a/arch/mips/mm/maccess.c b/arch/mips/mm/maccess.c
index 58173842c6be..70012ac0a5a8 100644
--- a/arch/mips/mm/maccess.c
+++ b/arch/mips/mm/maccess.c
@@ -3,7 +3,7 @@
 #include <linux/uaccess.h>
 #include <linux/kernel.h>
 
-bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
+bool copy_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 {
 	/* highest bit set means kernel space */
 	return (unsigned long)unsafe_src >> (BITS_PER_LONG - 1);
diff --git a/arch/parisc/lib/memcpy.c b/arch/parisc/lib/memcpy.c
index 5fc0c852c84c..78758b9a0f49 100644
--- a/arch/parisc/lib/memcpy.c
+++ b/arch/parisc/lib/memcpy.c
@@ -48,7 +48,7 @@ void * memcpy(void * dst,const void *src, size_t count)
 
 EXPORT_SYMBOL(memcpy);
 
-bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
+bool copy_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 {
 	if ((unsigned long)unsafe_src < PAGE_SIZE)
 		return false;
diff --git a/arch/powerpc/mm/maccess.c b/arch/powerpc/mm/maccess.c
index ea821d0ffe16..e0f4c394836c 100644
--- a/arch/powerpc/mm/maccess.c
+++ b/arch/powerpc/mm/maccess.c
@@ -7,7 +7,7 @@
 #include <asm/inst.h>
 #include <asm/ppc-opcode.h>
 
-bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
+bool copy_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 {
 	return is_kernel_addr((unsigned long)unsafe_src);
 }
diff --git a/arch/um/kernel/maccess.c b/arch/um/kernel/maccess.c
index 8ccd56813f68..3497148e9aa5 100644
--- a/arch/um/kernel/maccess.c
+++ b/arch/um/kernel/maccess.c
@@ -7,7 +7,7 @@
 #include <linux/kernel.h>
 #include <os.h>
 
-bool copy_from_kernel_nofault_allowed(const void *src, size_t size)
+bool copy_kernel_nofault_allowed(const void *src, size_t size)
 {
 	void *psrc = (void *)rounddown((unsigned long)src, PAGE_SIZE);
 
diff --git a/arch/x86/mm/maccess.c b/arch/x86/mm/maccess.c
index 42115ac079cf..be28eda2c0b0 100644
--- a/arch/x86/mm/maccess.c
+++ b/arch/x86/mm/maccess.c
@@ -6,7 +6,7 @@
 #include <asm/vsyscall.h>
 
 #ifdef CONFIG_X86_64
-bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
+bool copy_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 {
 	unsigned long vaddr = (unsigned long)unsafe_src;
 
@@ -36,7 +36,7 @@ bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 	return __is_canonical_address(vaddr, boot_cpu_data.x86_virt_bits);
 }
 #else
-bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
+bool copy_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 {
 	return (unsigned long)unsafe_src >= TASK_SIZE_MAX;
 }
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index d8e4105a2f21..297a02b2bd53 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -387,7 +387,7 @@ copy_struct_from_user(void *dst, size_t ksize, const void __user *src,
 	return 0;
 }
 
-bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size);
+bool copy_kernel_nofault_allowed(const void *unsafe_src, size_t size);
 
 long copy_from_kernel_nofault(void *dst, const void *src, size_t size);
 long notrace copy_to_kernel_nofault(void *dst, const void *src, size_t size);
diff --git a/mm/maccess.c b/mm/maccess.c
index 518a25667323..72e9c03ea37f 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -7,8 +7,7 @@
 #include <linux/uaccess.h>
 #include <asm/tlb.h>
 
-bool __weak copy_from_kernel_nofault_allowed(const void *unsafe_src,
-		size_t size)
+bool __weak copy_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 {
 	return true;
 }
@@ -28,7 +27,7 @@ long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
 		align = (unsigned long)dst | (unsigned long)src;
 
-	if (!copy_from_kernel_nofault_allowed(src, size))
+	if (!copy_kernel_nofault_allowed(src, size))
 		return -ERANGE;
 
 	pagefault_disable();
@@ -83,7 +82,7 @@ long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
 
 	if (unlikely(count <= 0))
 		return 0;
-	if (!copy_from_kernel_nofault_allowed(unsafe_addr, count))
+	if (!copy_kernel_nofault_allowed(unsafe_addr, count))
 		return -ERANGE;
 
 	pagefault_disable();
-- 
2.46.0


