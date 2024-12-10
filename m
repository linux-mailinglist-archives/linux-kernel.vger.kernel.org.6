Return-Path: <linux-kernel+bounces-438770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EB39EA578
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 03:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E71B16A2DD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B6E1D1310;
	Tue, 10 Dec 2024 02:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fDcER2k5"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA281C07C9
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798494; cv=none; b=Q0D1oAnfn6+oMm7FhdWUCKxmsokyTLwYCQrjmsP0qAl9QtVwviLD/keZwyI6TQVmIAzVtZhGsKCo1RHfPXq+VZh0siW2ZlYrHWCR8AE7VqllTiGcOND06mn0T/n4ly3IyxnQxR3Ams3YWTijdF9wWtGe1La2GXI1M/iSQ/0TH64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798494; c=relaxed/simple;
	bh=XV1LugKdz2DpbBeuplWv0YYTqCyV+/pUJf+iX2EDwnU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LNUHN8cCxLRfDhdRhKkLQVeizSCxsxeXkSIbhioR/4vtVYb5rJ035EZJ49SkhPfXKjT9QCG5y0An9NRUsngGC6UX/0/X65MKrE7bI+ed1vqLFm1lfwhXAQot7Sp7bs1u/LAdcBEGQaIfgpdI3jwODrqt6d3Gp9hGExIS5SegWXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fDcER2k5; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-724fc3f60c1so7284548b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 18:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733798491; x=1734403291; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=68DM57EM10Oy1Phx/X5P68W7yQkXIjbCrTpN7G3wDA4=;
        b=fDcER2k5i55JkEtmoMN7JjD21fhpKrJ/WuN4OLRK7RrQyWUhggG167Da3/G5knqten
         ZNxYsEIHxZPQzJ5cnNEg3An+JYtxenP0d5CoVGAC2ElJlcEwsBqqB+fT7S5aFVj6ONCd
         aERbnDRlphBZYTeH5uXIS6O8cY1fXhrg431RNuFfTsc9vCrjLClTnzA3+xghq9cKHIAI
         95Cmt4gVmGHS/qgBF8FnPUiWC3BVubSS9MyerdKbsQfinUcQY7eziRmzKp3IOJZ7GC3o
         qEMwY8Mf6ATkz6hBuAEE9xeFw4gV2nIrzTItDh9f1yyeFiHFJ5x0bRrOqHdGZc9M/D1I
         tgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733798491; x=1734403291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68DM57EM10Oy1Phx/X5P68W7yQkXIjbCrTpN7G3wDA4=;
        b=XTNRYxW/AxP/hlKuryWCQJvBjJL4+Z1a8bJKXSLEpMkVWlmBasPihKaUZLcTjycYBo
         pGv566084iJT/N0BhjbRMWu52r/Y0FSzPnD7H+VQOS5wou2HWkEV6fxoAEmodvtA+qo5
         Yod1pyQoPW7WOoe7ADUXqbNNNP+SiR5N7bE1PfXIXqNQvIsTqQVz7Yp54rmpVcRMWuSE
         qn1Yp6k15TuimNL64HGwWltqEi/PrWJ7qNpTbm2lk+lsPE3Y2mcRBE+tp/jEndJ+pt8r
         C9Rw1v8rwz7W6GUU4Q7UBcEopKXmJhBRkTb0QvyZnsicufery3nzC1n2z5iaLLCwe8v0
         V+NA==
X-Forwarded-Encrypted: i=1; AJvYcCUddzq3N6AN3Yjj9Tw+7t8P9SCLFEPpkJSgZYEG9Y7d6GFpKa2kJo+iPJFSd020mmTZUzpOCVyacf1XeIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfcJRf9zR39hMZYigfp+RTsGcX/WwC0917xoNbjqeoLh/iFLCz
	fXEqztm+SYr3lpeyW5HvLOiyK+PZtY2oSlMDDjFliSJRwknVbffLhgsaVEmdQtFWbYm8uKEfMba
	Siq2MRcwdT9VsK1czrDWTVw==
X-Google-Smtp-Source: AGHT+IEtrC2iviCeXWAtkatWkkbrcoIFQnKfltvUj9wZA43T/YasMAjSbDISIyM+Y3e/Wy24hv9IDhoi1rtLFpgStA==
X-Received: from pfbcn3.prod.google.com ([2002:a05:6a00:3403:b0:725:db2d:370e])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:12c5:b0:1e0:d867:c875 with SMTP id adf61e73a8af0-1e1b1b5c646mr3881670637.36.1733798490862;
 Mon, 09 Dec 2024 18:41:30 -0800 (PST)
Date: Mon,  9 Dec 2024 18:41:06 -0800
In-Reply-To: <20241210024119.2488608-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210024119.2488608-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210024119.2488608-5-kaleshsingh@google.com>
Subject: [PATCH mm-unstable 04/17] mm: alpha: Introduce arch_mmap_hint()
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, vbabka@suse.cz, yang@os.amperecomputing.com, 
	riel@surriel.com, david@redhat.com
Cc: linux@armlinux.org.uk, tsbogend@alpha.franken.de, 
	James.Bottomley@HansenPartnership.com, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, davem@davemloft.net, 
	andreas@gaisler.com, tglx@linutronix.de, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, chris@zankel.net, 
	jcmvbkbc@gmail.com, bhelgaas@google.com, jason.andryuk@amd.com, 
	leitao@debian.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
	kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce alpha arch_mmap_hint() and define HAVE_ARCH_MMAP_HINT.
This is a preparatory patch, no functional change is introduced.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/alpha/include/asm/pgtable.h |  1 +
 arch/alpha/kernel/osf_sys.c      | 29 ++++++++++++++++++++++++-----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 635f0a5f5bbd..372885a01abd 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -362,5 +362,6 @@ extern void paging_init(void);
 
 /* We have our own get_unmapped_area to cope with ADDR_LIMIT_32BIT.  */
 #define HAVE_ARCH_UNMAPPED_AREA
+#define HAVE_ARCH_MMAP_HINT
 
 #endif /* _ALPHA_PGTABLE_H */
diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 86185021f75a..68e61dece537 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1225,6 +1225,27 @@ arch_get_unmapped_area_1(unsigned long addr, unsigned long len,
 	return vm_unmapped_area(&info);
 }
 
+unsigned long arch_mmap_hint(struct file *filp, unsigned long addr,
+			     unsigned long len, unsigned long pgoff,
+			     unsigned long flags)
+{
+	unsigned long limit;
+
+	if (!addr)
+		return 0;
+
+	/* "32 bit" actually means 31 bit, since pointers sign extend.  */
+	if (current->personality & ADDR_LIMIT_32BIT)
+		limit = 0x80000000;
+	else
+		limit = TASK_SIZE;
+
+	if (limit - len < addr)
+		return 0;
+
+	return generic_mmap_hint(filp, addr, len, pgoff, flags);
+}
+
 unsigned long
 arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		       unsigned long len, unsigned long pgoff,
@@ -1254,11 +1275,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	   merely specific addresses, but regions of memory -- perhaps
 	   this feature should be incorporated into all ports?  */
 
-	if (addr) {
-		addr = arch_get_unmapped_area_1 (PAGE_ALIGN(addr), len, limit);
-		if (addr != (unsigned long) -ENOMEM)
-			return addr;
-	}
+	addr = arch_mmap_hint(filp, addr, len, pgoff, flags);
+	if (addr)
+		return hint;
 
 	/* Next, try allocating at TASK_UNMAPPED_BASE.  */
 	addr = arch_get_unmapped_area_1 (PAGE_ALIGN(TASK_UNMAPPED_BASE),
-- 
2.47.0.338.g60cca15819-goog


