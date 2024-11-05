Return-Path: <linux-kernel+bounces-396736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30D79BD165
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D548A1C229B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC321DD88D;
	Tue,  5 Nov 2024 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTQnSg+f"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B9F1DAC95
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822313; cv=none; b=f208UCDLGkSY7nEqcNF6niBF77b4L4ZT2qjnb0V4k2VzftrxesHgURgx444QUYkwf1/D4qX1xXLFcKb2r6cmUm22c9rzPTz9JcfDheq05ZirUSBKEARIuMGbvKVaECrNNcl7fI26vLo3jdFkDLQNs8X12OZxA8MFmZqqiWt4niU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822313; c=relaxed/simple;
	bh=EuV0NACqHVtg4LSrLDeaIKpnaPwdJx4OlSUYYC2lvOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L93Urr/5pWxZjHayCyQWlTZRt7Zl0QAx+AdwnTaTfBAK5UvzRN675UCRiyjbOkkeohQr9Gt42qUDimpLBq3J7aReI8NgY/77jen6sYOE9cYXFk7lJ23In0B9w/h71UjaXADOL9B2QMM4ZGbnhQAyVC+hfwESwNhtEeyvQtYKU4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTQnSg+f; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4608e389407so76469271cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730822310; x=1731427110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9d1wa+5S0n96mgyOsVJzjpdZOT+Q+6QsVFwpuBhfxY0=;
        b=nTQnSg+fh7x4zFEEMPiWS4vJIBRFzQsQhVgN1n8ObOZdRRNEs4IQyEqB/+WZ4GTKLG
         Od3P6MiX8c0mstH6FEW59gIVR7VEDR1GAFDG9NBKIGTO5LK//gTCayazUi9+RdM6QBQE
         1ULA9jO6TzK5znldOVNS+Z0iA+hiklxe9T0osgY7b9SV+5LREjPwTUQd9VKnCetXBWEa
         B4cQpWSXWehuBXWpj1vQn1I935QKD0lIUKx6gWR4+J/1BYikQrToBrHIsaFH/Cm/+QM7
         n4wfHJUJEBXrdUuCCwvpwosEkhuaZgGIZid16M5MpiGLEY3YPyeT/KzrYKcjfsjgmVyT
         G8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822310; x=1731427110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9d1wa+5S0n96mgyOsVJzjpdZOT+Q+6QsVFwpuBhfxY0=;
        b=s7mmBELMyBBIkrKpnzuGk7uz31qUKzCpwbcyBX/ATdSG4pYailzDmsEIVLCTM9fOrr
         +BX5mr+4VJpc5HXgern6/8vRMl/LU9c/tQbOboGiCL5JSCqolt5l9FOLPlEMBR1KUN8K
         koe8kLRUawxA3b02jOowXwzTM2Z7dX8sz3ixkm4XyIgUU75dE1kajJWJOCYyGNOUTXSf
         KHIIIwzN3shBA12y+joE/BlPPqINZVdev8kNtJVC5FGCR6mAixcqXj6Dn9d+duXlupH+
         Tq7nKgbYDSFJgR6SgEC+AQyu6q+w//aCSjhJd0VuFQn52GvYHGp3gQWlM4rCil7PQVXT
         eokw==
X-Gm-Message-State: AOJu0YwwN38xABVgCDcSESreqKdv4f/TbpnB3vGFA6KGZergWyhygCFZ
	rTZGSR4tzP6Ell6lCskUNRf/jBZi348LkdUTldZZbAsSmHGfuCM1mMPN
X-Google-Smtp-Source: AGHT+IFSTZxE/XYzyBJqcGhW9IfkFznpokEEMj8p9qUoTKv1t5jkstj7NRdVXps/On4QRDfv4wNjwQ==
X-Received: by 2002:ad4:4d91:0:b0:6d1:8c91:99f0 with SMTP id 6a1803df08f44-6d18c919becmr440231736d6.40.1730822310376;
        Tue, 05 Nov 2024 07:58:30 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc6d07sm61710586d6.44.2024.11.05.07.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:58:29 -0800 (PST)
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
Subject: [PATCH v5 14/16] percpu: Remove PERCPU_VADDR()
Date: Tue,  5 Nov 2024 10:57:59 -0500
Message-ID: <20241105155801.1779119-15-brgerst@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105155801.1779119-1-brgerst@gmail.com>
References: <20241105155801.1779119-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x86-64 was the last user.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 36 +------------------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 70830a742095..f53915f4e777 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1045,47 +1045,13 @@
 	__per_cpu_end = .;
 
 /**
- * PERCPU_VADDR - define output section for percpu area
+ * PERCPU_SECTION - define output section for percpu area
  * @cacheline: cacheline size
- * @vaddr: explicit base address (optional)
- * @phdr: destination PHDR (optional)
  *
  * Macro which expands to output section for percpu area.
  *
  * @cacheline is used to align subsections to avoid false cacheline
  * sharing between subsections for different purposes.
- *
- * If @vaddr is not blank, it specifies explicit base address and all
- * percpu symbols will be offset from the given address.  If blank,
- * @vaddr always equals @laddr + LOAD_OFFSET.
- *
- * @phdr defines the output PHDR to use if not blank.  Be warned that
- * output PHDR is sticky.  If @phdr is specified, the next output
- * section in the linker script will go there too.  @phdr should have
- * a leading colon.
- *
- * Note that this macros defines __per_cpu_load as an absolute symbol.
- * If there is no need to put the percpu section at a predetermined
- * address, use PERCPU_SECTION.
- */
-#define PERCPU_VADDR(cacheline, vaddr, phdr)				\
-	__per_cpu_load = .;						\
-	.data..percpu vaddr : AT(__per_cpu_load - LOAD_OFFSET) {	\
-		PERCPU_INPUT(cacheline)					\
-	} phdr								\
-	. = __per_cpu_load + SIZEOF(.data..percpu);
-
-/**
- * PERCPU_SECTION - define output section for percpu area, simple version
- * @cacheline: cacheline size
- *
- * Align to PAGE_SIZE and outputs output section for percpu area.  This
- * macro doesn't manipulate @vaddr or @phdr and __per_cpu_load and
- * __per_cpu_start will be identical.
- *
- * This macro is equivalent to ALIGN(PAGE_SIZE); PERCPU_VADDR(@cacheline,,)
- * except that __per_cpu_load is defined as a relative symbol against
- * .data..percpu which is required for relocatable x86_32 configuration.
  */
 #define PERCPU_SECTION(cacheline)					\
 	. = ALIGN(PAGE_SIZE);						\
-- 
2.47.0


