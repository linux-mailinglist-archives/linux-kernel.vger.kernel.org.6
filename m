Return-Path: <linux-kernel+bounces-300198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5D795E041
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 00:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE94C1F21E75
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 22:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0823313C677;
	Sat, 24 Aug 2024 22:27:24 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4013A1DB
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724538443; cv=none; b=Z6pc9+OhCq6Fp362AEHGfiU0skHf/irMM16QCcjpltvzfz8h6oMUEAlrHInzKCejiNMge9/fvKQ1AHc+41fw9M+Ca5eYkLseOPvrfzh15AmlSCj1OTShYVX8qi+dWazPuIkMAzwoJCujREsZ+KkV+EfvUJmV18lIKQJpeaLMJMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724538443; c=relaxed/simple;
	bh=iv/lNNOEab19um3DFuHm0/su5FdPyA+yQpxGNpGqdKg=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=SMTtB6TgF2dyTLoNI+of0FMZUiIYaDCZ5W199vfk9DsQi+jhOn1e26zxMvqB5DOLG9otkIgiDT4BeMTq8x11BV/W6Sgt/ENkbJufQVck7v+MAG+CqAecoDIv82INpiX04yvB6eLqWfdK1kTBEMIPVn6Q6JJgBVFZmxrvVJs8Evk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 3D03692009C; Sun, 25 Aug 2024 00:17:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 2E2C692009B;
	Sat, 24 Aug 2024 23:17:10 +0100 (BST)
Date: Sat, 24 Aug 2024 23:17:10 +0100 (BST)
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
Subject: [PATCH] x86/EISA: Use memremap() to probe for the EISA BIOS
 signature
Message-ID: <alpine.DEB.2.21.2408242025210.30766@angie.orcam.me.uk>
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
Hi,

 It's not clear to me if pieces added with commit 6a92b11169a6 ("x86/EISA: 
Don't probe EISA bus for Xen PV guests") are still needed with this change 
in place; it's not my area of experience and the submitter of said commit 
clearly didn't realise this is really an access to regular memory rather 
than MMIO.  If they are not needed, they can be discarded with a follow-up 
change.

 I have verified this change with my plain EISA i486 box, and just to be 
sure with a debug patch to report that `EISA_bus' (hardly used nowadays) 
has indeed been set.  Please apply.

  Maciej
---
 arch/x86/kernel/eisa.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

linux-x86-eisa-bus-probe-memremap.diff
Index: linux-macro/arch/x86/kernel/eisa.c
===================================================================
--- linux-macro.orig/arch/x86/kernel/eisa.c
+++ linux-macro/arch/x86/kernel/eisa.c
@@ -11,15 +11,15 @@
 
 static __init int eisa_bus_probe(void)
 {
-	void __iomem *p;
+	void *p;
 
 	if ((xen_pv_domain() && !xen_initial_domain()) || cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return 0;
 
-	p = ioremap(0x0FFFD9, 4);
+	p = memremap(0x0FFFD9, 4, MEMREMAP_WB);
 	if (p && readl(p) == 'E' + ('I' << 8) + ('S' << 16) + ('A' << 24))
 		EISA_bus = 1;
-	iounmap(p);
+	memunmap(p);
 	return 0;
 }
 subsys_initcall(eisa_bus_probe);

