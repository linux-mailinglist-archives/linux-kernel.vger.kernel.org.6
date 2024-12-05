Return-Path: <linux-kernel+bounces-433544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B30E9E59C4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE532825E2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F61B21CA1D;
	Thu,  5 Dec 2024 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LQwBT1I1"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2503D218E8B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412841; cv=none; b=ZrZLsr/zGLLIRyMK6NOiDG22VR1HvUFhID+zLz30vgcWk+HTe6kNgEG0yFSDymluVsM9vwVY5wT1ktlqO8cGxWYPu6wXswGaFiI+xsyx4R0MTZJw4xVlWLRNye1YjYukzMB8hAos3BsbdG9om88MZi89w12OEs/Xeh1swQ6Vu9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412841; c=relaxed/simple;
	bh=4G1dwuKi5j5hukJsKtHQTnOK312oh/BUWKz5OC4SG7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ei90R8nbx5mQqf2mnsB0CO9ihc/S2We4kXYbM8xmkTtr3jMu8t7fBU9m/HC9ep+mdE04T658L816g68NdkVyMcBxKxNVrCoqEAb1eowos+SmdZeGth5Pk7ANz4nAAr7LYDwSHXZF0DRqJQbgNjfupok9gl4ooBqEQ+8Gb9aUh48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LQwBT1I1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=n1NxLTesaxf1CmVmrYGt0DtpmfeNYvqyA55PeXFrYQI=; b=LQwBT1I1tgzvK5VpQKCeLWCjPP
	P1i7QKG/TI5/JWlMSK7zGtWltMMtDmitz0vvv4F962VQsj6BdCFJ/1+YhgIXZLhpIg7dud5x+Tbip
	l7SZjwZnXFWGj+NYsOz8LAdOHo0gYzjXZdjEGwJXnZhgMymq9NQteKWnd8eMXi3KJq0lJnrPgRuv/
	p+uHF7oSahzzf+HodaeW3slwbyGeTsRVfYINYG2yGlakDjLIOQ3VLQb02tnzpVhvFuc2KFuTmXQga
	WGi38rBF8riZKChKNbXb7I8oOgfVkzLadoG1+UhSqMqgtqyEQfhusLBToEcDTPC+dbwg3n2/zcvbt
	MRh42dsg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrO-00000002wEz-0j20;
	Thu, 05 Dec 2024 15:33:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrN-0000000DyM8-3AEi;
	Thu, 05 Dec 2024 15:33:45 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [PATCH v5 14/20] x86/kexec: Add CONFIG_KEXEC_DEBUG option
Date: Thu,  5 Dec 2024 15:05:20 +0000
Message-ID: <20241205153343.3275139-15-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205153343.3275139-1-dwmw2@infradead.org>
References: <20241205153343.3275139-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

This does nothing yet.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/Kconfig.debug | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 74777a97e394..9dde32865a9b 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -56,6 +56,14 @@ config EARLY_PRINTK_USB_XDBC
 	  You should normally say N here, unless you want to debug early
 	  crashes or need a very simple printk logging facility.
 
+config KEXEC_DEBUG
+	bool "Debug kexec transition"
+	depends on KEXEC_CORE && EARLY_PRINTK
+	help
+	  Faults during kexec can be difficult to debug. This installs exception
+	  handlers and attempts to report faults through the same serial port as
+	  used for early_printk.
+
 config EFI_PGT_DUMP
 	bool "Dump the EFI pagetable"
 	depends on EFI
-- 
2.47.0


