Return-Path: <linux-kernel+bounces-288601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B455953C48
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B226A1F26712
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE0E14901F;
	Thu, 15 Aug 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaZ27JMR"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E216F2E6
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755631; cv=none; b=MvxVAr3Jl4X5F+kr+1tZLvR+ABdehrqA8FgEU8x/KK5Ln8Ot3KSMQWwiZB59/tO7+VVkxbiWHqH4tFcBvthBJm+myHUThnOrXyymxcmqyPmXRBaN5Va8Fm7ky/sGWqfGl/PFHPbbzCglim8ftuqy7ooobWSkrtaCSsRgQpEqaJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755631; c=relaxed/simple;
	bh=3NCh6U/S1j3mtc4yuKgpz2cFRrT8IiPjEYNnNdjxIGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TzNz5mj2Qhy6S3gx8egpZA3h/iyysEuF0rkpkDboplw/aP1IrxvPe/GFlNlWBuXoWn2D6TeXydDSDk342pORuUQWa3EBbuZe0WwRG/uKSMfmhQ5E5kjzetMbkub5q6iFVLVvDtUwGoV/Id3ApFMJAUyuI3OJCX14Om59l/hI3tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaZ27JMR; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ef2fbf1d14so22424641fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723755627; x=1724360427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nw+i6a5BQdCkk4Mdx+fFTiDbWj87Rjwq5IfRXwZ8bow=;
        b=eaZ27JMRogso1jUylnW21JNEFA3oseCzhaZbKozW4Jz+2u+XJdXCo3a2Lhy4YKkf+3
         z3G/CPSgKDJxit0HVASmXd4QB013mB/98j4IQeP+UVlPPTXbErsutlVLagGFYPo5P7om
         jSCclCLy1f7d9B9tRCYYiZZJDWDxs3CW07B/D1Ci3pBUHABtBru2yjicPhY5j3gpOsy1
         tu+v9S85wF0+HOLiafMPBTz3PCQ2rDRaf92E99c41Pnz1hkaBBkKERXR6gvAYTBpWDFY
         gIeGtbRLSs4lqz2WLEuESbf/9pYNu8fcm7429eLiZdM0cFKWvhTGiQbR/k11EogEi3bu
         2v4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755627; x=1724360427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nw+i6a5BQdCkk4Mdx+fFTiDbWj87Rjwq5IfRXwZ8bow=;
        b=qGdfkFyvht4MD8c9scM5QIthM9Wc3kAkbGnn2oOjoUFtf/YARha+Ha2jpzOSzzwmq4
         8yZc2ovRXPaS33bdgkTOxohxWz7mjC7N0wc4PaMOP+J279n2SqGSWmelcMv6aLPF4jWj
         lK9zS5jl8AdDRK9s7X0Mw+nD0shSoWdaL4+iLoHxi6QzLkPmQ6k3U0zYGIcl0hktr7sF
         DFtVlGM0QUAhG3/QKiT2cbQ9p31CS4Csk4L60CEmOGV/GfryPQ7jF3OQgmPJfZN+m9DB
         G+XG67E+lM/16eaMi/DBEIecybT2JaAnHCYKxKsUiKpUAG1meM9GyhW1snnwzCKxiygk
         NUDg==
X-Forwarded-Encrypted: i=1; AJvYcCXnz3ZmVWqr10DXR+IhQDkqkWJQWEgfbT30PsCy9a/e0BROlCPUE8T1zuxnYK+ZTb1+pT/fvPioWYGbfS6E7JKDLxOjQ55/znRkH5Mk
X-Gm-Message-State: AOJu0YztoMxloZUEUFvuzfBIoCFw4hllQqAoP7PJQUPbCrdd2ErPHlHR
	bzCRl2AjXlS1T2ghrTZkOldPDNiMo8+pPpl/sC1CuOEWmhKEJ2PV
X-Google-Smtp-Source: AGHT+IFWbSQBpKicv3Y8V2rBGWp+KhKB1btNuBp2B33rekQlBdE3v7MLXbPaGifVd1rmUt5je4u8SA==
X-Received: by 2002:a05:6512:b10:b0:52d:ab43:b276 with SMTP id 2adb3069b0e04-53307f740c2mr1076264e87.2.1723755626896;
        Thu, 15 Aug 2024 14:00:26 -0700 (PDT)
Received: from localhost.localdomain (nat2-minsk-pool-46-53-193-144.telecom.by. [46.53.193.144])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5330d42466csm331998e87.257.2024.08.15.14.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:00:26 -0700 (PDT)
From: Max Ramanouski <max8rr8@gmail.com>
To: x86@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	linux-kernel@vger.kernel.org,
	jniethe@nvidia.com,
	jhubbard@nvidia.com,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	hch@infradead.org,
	apopple@nvidia.com
Cc: Max Ramanouski <max8rr8@gmail.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3] x86/ioremap: Use is_ioremap_addr() in iounmap()
Date: Thu, 15 Aug 2024 23:56:07 +0300
Message-ID: <20240815205606.16051-2-max8rr8@gmail.com>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Max Ramanouski <max8rr8@gmail.com>
---
 arch/x86/mm/ioremap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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
-- 
2.45.2


