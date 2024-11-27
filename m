Return-Path: <linux-kernel+bounces-423843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6429DAD7F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4113D16666A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C8920127E;
	Wed, 27 Nov 2024 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cIpbPcdh"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EBA1FF604
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732734246; cv=none; b=VrW9yPi869RjXLvBj0ZNWdf559F44RtaVWo2Qlcfu8A4Yk+M+xX60MDpFt5UQbJGEnRI/gfjFuc6LAupx0+eYPha2BVS6ZtXGw15fJuuMHBVK3b6aDlMuiH99HtxTzm9gJuMenTIHFNUZ/CRZxfW3DZ18qRBXYyaLTezaVZj8IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732734246; c=relaxed/simple;
	bh=4G1dwuKi5j5hukJsKtHQTnOK312oh/BUWKz5OC4SG7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDx1dnhS3/c0TSxsMJdu8B3hXjh+7vT6ZAmBK15uwLpvf/47Jxvrtw2AcCOAN2js5mS0uzdyg2VJ4RXuTDoX/S2neaN0/w/9grxPc+/yQW8UB7XjUxWULH4VnqxcVCt5+AeubIDpOly4gP5URDK6HbvCN5T2gOqNEZsa0qSpWwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cIpbPcdh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=n1NxLTesaxf1CmVmrYGt0DtpmfeNYvqyA55PeXFrYQI=; b=cIpbPcdhiv/PxCBrA0udVBYnUb
	jd6ot3jhec8XiieDBZTWAPnUeNeFCD3UDuRMG/y2mzrEK75n29vfsgS4GobkTq6RnUrhNjNtj1I6N
	1C5cf7nVS3T+bi1e/pByQuKlAq/K1uUE0iJJ4bQKsLBTLQYjkSiw4SlMv0MFdDxd64aJVrVfe5W3a
	xbrr6uSzejIarUWPhENLx4HgcL7MehRPW+i3qC/PohAnOjFBjel5Ga4+FZEvtjVDid1ViAdV0z3NV
	7ZPnp732MaB2zlOkhuHr0WeExPfHFaP5LHXzumzFo2aq2FB2r1+KJmtEX2ocPPkJ70qPDNaY/OFsN
	4sxXSfVg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKF-00000001Suh-1855;
	Wed, 27 Nov 2024 19:03:47 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKE-00000000Bj6-2Qt6;
	Wed, 27 Nov 2024 19:03:46 +0000
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
Subject: [RFC PATCH v4 15/20] x86/kexec: Add CONFIG_KEXEC_DEBUG option
Date: Wed, 27 Nov 2024 19:00:29 +0000
Message-ID: <20241127190343.44916-16-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127190343.44916-1-dwmw2@infradead.org>
References: <20241127190343.44916-1-dwmw2@infradead.org>
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


