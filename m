Return-Path: <linux-kernel+bounces-420793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226079D8319
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD11D283F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959741A4AAA;
	Mon, 25 Nov 2024 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p3ySAKar"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E5F1925A3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732529317; cv=none; b=I1aVAumAO+k3o1fpRfKfadQ2yMdSTfAsss5bmfZqjMDgCrKTMlsFQ8FNApe4IrGXgDMmDqfMjPEkUZEvDn7QQ0vOfOshPbybEoziw7mJS/OSDWJIzLd3hcnlRNIa2HxT3f6zYZMIw281O9UqkOnZDOTW+W7MwxzZSzBNrvt6/v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732529317; c=relaxed/simple;
	bh=4G1dwuKi5j5hukJsKtHQTnOK312oh/BUWKz5OC4SG7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNkShyq+f5Db5lW66VGSe880su+mbK/OQI7JzsBuVqaHxHpIvdzDarqK6/OuLAkxo46/sAc8Op0bRED933KJmzohw+nszk+wPLV6aiWov5cus+KKKJajdPNzySYCCzpx0kesjxkqPGfdcfLMMgQNklK7+L43GitxO9Riqz6Z9Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p3ySAKar; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=n1NxLTesaxf1CmVmrYGt0DtpmfeNYvqyA55PeXFrYQI=; b=p3ySAKarVWgraIsayXyhAQoqLI
	HYTTmQfTwkADOlKLXFpvV4IhjIzTGqFWJWZNwiyYC5jbhzmKYpNacItSDP2+QIXE4QHHr/dEGuNhM
	xKGlM+v3QAPrXrGlgPh1C/6UBt8h1U5FzQHJxoV6yHOT+oDVR3Axywb1nndgcIFArf7UXgs2bJpoa
	KeWaqhMemP3gNKrAupjra4iQcbYb3ug8wwMzvGCY5nKFS5HLl5ATi8aPjA4gH2mJofMMEbWfZpZzF
	S0D4x9c82M6RZExcTz8lbNN+XU8ZcKK6eIUsnLDDsnGXnUdpSn6KvHsIfHswDbgIhiF0qowbDYnpx
	d6AcmsQA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW12-000000014f9-16Iq;
	Mon, 25 Nov 2024 10:08:24 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW0z-000000000lb-3cMg;
	Mon, 25 Nov 2024 10:08:21 +0000
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
Subject: [RFC PATCH v3 15/20] x86/kexec: Add CONFIG_KEXEC_DEBUG option
Date: Mon, 25 Nov 2024 09:54:45 +0000
Message-ID: <20241125100815.2512-16-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125100815.2512-1-dwmw2@infradead.org>
References: <20241125100815.2512-1-dwmw2@infradead.org>
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


