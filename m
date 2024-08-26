Return-Path: <linux-kernel+bounces-301150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F3895ED05
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2806D1C21688
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177C814375D;
	Mon, 26 Aug 2024 09:21:58 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AE013A88D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724664117; cv=none; b=u0JmGXKrho2QFAFEzb06gq7U32GfxReGRsL0UIl8v/s+eOokASxEL7KJHg+qP+fLSn6c88vVjFIzvXyymFDkE/gJX5Dtu6vCsrzjBFPoN3bRkF1DYCOZYBGMejK+M+D81XjidQFLfGNFEa59I8l7+CV5iyzmzehRFhKVlLiydTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724664117; c=relaxed/simple;
	bh=54vAyqWzP74SvcfqrhJzsG+kPxYADVWM+AOyl2jeO7s=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=Wvw4gCsM6MO1TCOFA0tHU4ptFjxZqLTaQXpKC29FshQMuctXEDDmgFB7c2ao4G/vkyDhai4rmqmwtvyGvq2DYy1VKwcQiSN/qtRcyLZyV0G+ta0QtXK0JLxbb+/0rr4wGTiJ7VyUbWIBRtPPAvsweeAQKANGezvLmPGFTI9KKOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 92B7F92009C; Mon, 26 Aug 2024 11:21:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 8B53A92009B;
	Mon, 26 Aug 2024 10:21:47 +0100 (BST)
Date: Mon, 26 Aug 2024 10:21:47 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org
cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
    "H. Peter Anvin" <hpa@zytor.com>, 
    "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
    Rick Edgecombe <rick.p.edgecombe@intel.com>, 
    Isaku Yamahata <isaku.yamahata@intel.com>, 
    Kevin Loughlin <kevinloughlin@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/EISA: Use memremap() to probe for the EISA BIOS
 signature
Message-ID: <alpine.DEB.2.21.2408261015270.30766@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Area at the 0x0FFFD9 physical location in the PC memory space is regular 
memory, traditionally ROM BIOS and more recently a copy of BIOS code and 
data in RAM, write-protected.

Use memremap() then to get access to it rather than ioremap(), avoiding 
issues in virtualization scenarios and complementing changes such as 
commit f7750a795687 ("x86, mpparse, x86/acpi, x86/PCI, x86/dmi, SFI: Use 
memremap() for RAM mappings") or commit 5997efb96756 ("x86/boot: Use 
memremap() to map the MPF and MPC data").

Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Closes: https://lore.kernel.org/r/20240822095122.736522-1-kirill.shutemov@linux.intel.com
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
Changes from v1:

- Access the signature directly rather than via `readl', fixing a sparse 
  warning found by CI.
---
 arch/x86/kernel/eisa.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

linux-x86-eisa-bus-probe-memremap.diff
Index: linux-macro/arch/x86/kernel/eisa.c
===================================================================
--- linux-macro.orig/arch/x86/kernel/eisa.c
+++ linux-macro/arch/x86/kernel/eisa.c
@@ -11,15 +11,15 @@
 
 static __init int eisa_bus_probe(void)
 {
-	void __iomem *p;
+	unsigned int *p;
 
 	if ((xen_pv_domain() && !xen_initial_domain()) || cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return 0;
 
-	p = ioremap(0x0FFFD9, 4);
-	if (p && readl(p) == 'E' + ('I' << 8) + ('S' << 16) + ('A' << 24))
+	p = memremap(0x0FFFD9, 4, MEMREMAP_WB);
+	if (p && *p == 'E' + ('I' << 8) + ('S' << 16) + ('A' << 24))
 		EISA_bus = 1;
-	iounmap(p);
+	memunmap(p);
 	return 0;
 }
 subsys_initcall(eisa_bus_probe);

