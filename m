Return-Path: <linux-kernel+bounces-300196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A60DC95E037
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 00:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385DB1F21D88
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 22:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09AD13A888;
	Sat, 24 Aug 2024 22:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayJJX7Gq"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622B81EA80
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 22:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724537072; cv=none; b=iQx59fEOj2FvcE4CLVfJNEquMrv8+szIf2gVvFpzZlxv+2Jb0qR7roNVHR64cqVMyXzP9r5Z2DDk8PQC+Pnt5WCEWEuGz5Vp2FMYqclxW9OP5K0ZMSie2B8igQHdjnDH0Ar1RgcObQpMgnVX5lqrh1Pc9IF3iHCkvg8Ck1e7f78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724537072; c=relaxed/simple;
	bh=FVE9d4D/eK/OsENjBJ9J+E/S8WNnEdRYN/cAZsELJdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OwhoWsC1PmcWdD6x3QSvFWvErJNPjC4zRVhAEzP/r2utqy1rTUBqdkrqrO3nmXL8Ro5zkSbT3p1w/oGhkcyhV9Ulb6Ynhw5iD25pJYzaHgPDOnRQxmaWHlac3+yIJelM2vmyME5he4tKUociz1uEW7urqsf7gW4FAqvKM64KdLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayJJX7Gq; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5334b7c9bb2so632578e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 15:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724537068; x=1725141868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cI9QjfsYevZ0D06wl4+hXDHJRv8/BsCXbfcfhSDGJtY=;
        b=ayJJX7GqAwyOQjeRaKXkCtkho9rDfPRlGZzCtzI1I+Ldb4H8wf4bQdQN+bowWFY5Bl
         SzmkHgbbyDnYbsuMhYgbn/iom8f1CCIcaJeBgfDIyFVhkzn/xoWZylM37PSEg+7niB12
         M8PhyXr8mwlyfIP5NZiQaX5uie6FQO9VifFJv3ca3JLLOopd49MVz6dR+e3S/v04mXB3
         Sxo1tFaZUcnsIh4bXOlKmCMoYnNGIuasGS4YVvrmTTOkHxpIs2YvKzz7T7e1rTfELdZJ
         uzby+RKhSfubsPkDodolciyWVXnPV5Kqla4kpX2apMdW6ztzR62D9ONQ7+yHdogDp59b
         Zv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724537068; x=1725141868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cI9QjfsYevZ0D06wl4+hXDHJRv8/BsCXbfcfhSDGJtY=;
        b=dXLHKCj4ekisSfxgJPUE+0vtObgNrU5Xc4atmQE3JmoumzTgnyu//fyeUhhDcLnl4a
         sudJaCd5Ev4iEZW7TycEUHDG+KyF+uuh13mo8EqNAm91lUUeUvUgn+8zNiGphbYDGRUn
         z6BpjlXPf4k5mrjs17QdEs2RvuxEz3z7oZ4JgIcLOVHpnTDXvAbYrAZ+PeRsFAmWpcYs
         wxAqarExQJkYAEbBLzLSiiEBvJP+wbzQVDn2aFRlBjnjVD5jzPX+aXW4ur5gsAG378tB
         YpJFlnts9ofcnxokKJobOntc2VugsT8H9dVB7PubqVeElMnl3IVUPKndUbk79E+gkW9o
         hg1A==
X-Forwarded-Encrypted: i=1; AJvYcCWIYA7Ounbcbb8NKqze3IhFP+V7Zp545JucFRP+QkAFtFlpCIkXkyeiSQ1PIh/ztj9kJhNDmM/o2LyUk0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCf+Ds8kXBKTq8IyQ+GqAOzZiTjCPO66bvAumk7b14nwgOERmM
	RfaL+2lJwQWuwzQhgxCLRE9fcB6+c6XEbHC3sggWOb2O8Qq+rTHC
X-Google-Smtp-Source: AGHT+IFCXCtvqXzxiLDv/dnRpCyVxJj80C3PmX+GUzcdKtnS2Rg9NwAHSCvh17A7hJE20kFnPYVTvA==
X-Received: by 2002:a05:6512:3b98:b0:52f:cad0:2d4a with SMTP id 2adb3069b0e04-534387cd659mr2374970e87.9.1724537067876;
        Sat, 24 Aug 2024 15:04:27 -0700 (PDT)
Received: from localhost.localdomain ([46.53.242.108])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea36f8dsm965968e87.96.2024.08.24.15.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 15:04:27 -0700 (PDT)
From: Max Ramanouski <max8rr8@gmail.com>
To: x86@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	hch@infradead.org,
	apopple@nvidia.com
Cc: Max Ramanouski <max8rr8@gmail.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4] x86/ioremap: Use is_ioremap_addr() in iounmap()
Date: Sun, 25 Aug 2024 01:01:11 +0300
Message-ID: <20240824220111.84441-1-max8rr8@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Restrict iounmap() to memory allocated in ioremap region, by using
is_ioremap_addr(). Similarly to the generic iounmap() implementation.

Additionally, add warning in case there is an attempt to iounmap()
invalid memory, instead of silently exiting, thus helping to
avoid incorrect usage of iounmap().

Due to VMALLOC_START on i386 not being present in asm/pgtable.h,
include for asm/vmalloc.h had to be added to include/linux/ioremap.h.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Max Ramanouski <max8rr8@gmail.com>
---
 arch/x86/mm/ioremap.c   | 3 ++-
 include/linux/ioremap.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index aa7d279321ea..70b02fc61d93 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/ioremap.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/mmiotrace.h>
@@ -457,7 +458,7 @@ void iounmap(volatile void __iomem *addr)
 {
 	struct vm_struct *p, *o;
 
-	if ((void __force *)addr <= high_memory)
+	if (WARN_ON_ONCE(!is_ioremap_addr((void __force *)addr)))
 		return;
 
 	/*
diff --git a/include/linux/ioremap.h b/include/linux/ioremap.h
index f0e99fc7dd8b..2bd1661fe9ad 100644
--- a/include/linux/ioremap.h
+++ b/include/linux/ioremap.h
@@ -4,6 +4,7 @@
 
 #include <linux/kasan.h>
 #include <asm/pgtable.h>
+#include <asm/vmalloc.h>
 
 #if defined(CONFIG_HAS_IOMEM) || defined(CONFIG_GENERIC_IOREMAP)
 /*
-- 
2.45.2


