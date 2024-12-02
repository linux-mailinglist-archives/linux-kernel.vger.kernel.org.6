Return-Path: <linux-kernel+bounces-427925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C4D9E084E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1A3170ADA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E086278685;
	Mon,  2 Dec 2024 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rb+Fn9RI"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBD6745F2
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154547; cv=none; b=qc2ff1R2ic3gsVUAJFx4pqzA1YNcOPs29MMbBNVbBMzq1q2Tv+43Ynru3jfhdSRsl29D3oT8KGeANzSdABi1oRxUN3sKVcjQxEJmo6+Ud8kFisjjo7Bm2gbzjZAzRyCCUGPDer/sXYDt2sfjIxgXtfUax9FdL4tsxcU3V30hfRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154547; c=relaxed/simple;
	bh=PvVRFc17KBl0HuETq2wYDb3pI0+SysSE/C2/Z7gJPXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nHPUXrs9KA4KXe0wsra7Z7PCbUPPdOSXGZEGzexzNh/41roMzbePkVdEQ55bFNg+wojA0sGoZ/ybIdf3awM5DbJqMY36O6bq34QO4WJQvC15seSLPxa9/22DqlFxbiCF8jta7ZymQlyaekqKVUkWoxbiX3dtasRI4VynIn6VFyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rb+Fn9RI; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733154543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uD9wlcdgr+495Yqpkm0OP1E+ksdFV3b6uUdgVFXlDZI=;
	b=rb+Fn9RI73OPUdp0Aw7Ih3CNOchIpr1oU6wHZlag1lyPnQekT89D7ruSOAtevwdaOPW9nw
	nIEbKrTsfSN3ZRhIGU40BkAlxd5DifmppRfeul78L8n6oykj3JvT8BhwnuG9mbWJ6AR0Ls
	2HLz84bW+1lWfj3wcHPRb/4M0WobZhg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Russell King <linux@armlinux.org.uk>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm/pgtable: Remove duplicate included header file
Date: Mon,  2 Dec 2024 16:48:39 +0100
Message-ID: <20241202154840.1343-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The header file asm-generic/pgtable-nopud.h is included whether
CONFIG_MMU is defined or not.

Include it only once before the #ifndef/#else/#endif preprocessor
directives and remove the following make includecheck warning:

  asm-generic/pgtable-nopud.h is included more than once

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/arm/include/asm/pgtable.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index be91e376df79..6b986ef6042f 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -19,14 +19,13 @@ extern struct page *empty_zero_page;
 #define ZERO_PAGE(vaddr)	(empty_zero_page)
 #endif
 
-#ifndef CONFIG_MMU
-
 #include <asm-generic/pgtable-nopud.h>
+
+#ifndef CONFIG_MMU
 #include <asm/pgtable-nommu.h>
 
 #else
 
-#include <asm-generic/pgtable-nopud.h>
 #include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
 
-- 
2.47.0


