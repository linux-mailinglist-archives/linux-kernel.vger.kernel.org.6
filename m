Return-Path: <linux-kernel+bounces-269721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE40394365C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA22E1C21D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDB916CD10;
	Wed, 31 Jul 2024 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpHCC2iy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005EF16C875
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453230; cv=none; b=fVtVO0ndHyWkgWisfeAoI8jcB/Ool9sxWTcGoivy1N30G1quPhsJlHqGK7VBU25rBOPdFBFEBl2kd17nXsjPPjf8OKw6hmHKvi085hJ/tolaSIme59vMYn7NxZiEngrGrhtkHgla76BnBTUd7Y7i0TWD5qGB+E8XDJ9fMOs3xK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453230; c=relaxed/simple;
	bh=CMcboot57RSTYnL296q0XouRciqxcSoATVdJoTZjTN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eIQiefEFjhRt/+THn3uHRS9t4tNtJrmFxWOolZCsqtMBgCxNKWq6m4HZKApxM4bfKdX0o2D+7EWeRhevkcbPYCgwyTOlbQFw6iaXSBhvJGuBXlkgpyz/Fs50NEidjdGL/27+vwRYeSKeYlNzwEOO38+4EaPgWYZ/zw4vJwHFH5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpHCC2iy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AEDC116B1;
	Wed, 31 Jul 2024 19:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722453229;
	bh=CMcboot57RSTYnL296q0XouRciqxcSoATVdJoTZjTN8=;
	h=From:To:Cc:Subject:Date:From;
	b=XpHCC2iyR+WteuZ4QMtDWmr3TJdHXq8UavBJ/jCjZ6tEOmWWY7cW1gz3YBjSpN1Iv
	 Te235UnH+18oWkWMNHafbdUB0ZRmzEU9TcfNnyyw42czjJZRsjt0MxAXtRaQN/t+ED
	 gV49wUx/PYkSk9ARhac+PO4UF189NMljaVEp4pihli8h0g7hJjIBpvbWAUFNEk/OVJ
	 ZNlJeTj4bV/9P2S7wO8GMpoxcz3uytHN/ILTbv9Boleh5wvVfIeqNbV5LAUOUbnmlx
	 eT3lpbRrNiS8pPhHNs53fTe5K0czC1e/geR7DhMwrxUna4kDVQmCQ89+Q/np9+AoJm
	 q9heEj4a07uhA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Use of_property_present()
Date: Wed, 31 Jul 2024 13:12:47 -0600
Message-ID: <20240731191312.1710417-9-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_property_present() to test for property presence rather than
of_get_property(). This is part of a larger effort to remove callers
of of_get_property() and similar functions. of_get_property() leaks
the DT property data pointer which is a problem for dynamically
allocated nodes which may be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 2 +-
 arch/powerpc/platforms/powernv/opal-lpc.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index af3a5d37a149..3d072a7455bf 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -860,7 +860,7 @@ static int pnv_eeh_bridge_reset(struct pci_dev *pdev, int option)
 	int64_t rc;
 
 	/* Hot reset to the bus if firmware cannot handle */
-	if (!dn || !of_get_property(dn, "ibm,reset-by-firmware", NULL))
+	if (!dn || !of_property_present(dn, "ibm,reset-by-firmware"))
 		return __pnv_eeh_bridge_reset(pdev, option);
 
 	pr_debug("%s: FW reset PCI bus %04x:%02x with option %d\n",
diff --git a/arch/powerpc/platforms/powernv/opal-lpc.c b/arch/powerpc/platforms/powernv/opal-lpc.c
index a16f07cdab26..8a7f39e106bd 100644
--- a/arch/powerpc/platforms/powernv/opal-lpc.c
+++ b/arch/powerpc/platforms/powernv/opal-lpc.c
@@ -393,7 +393,7 @@ void __init opal_lpc_init(void)
 	for_each_compatible_node(np, NULL, "ibm,power8-lpc") {
 		if (!of_device_is_available(np))
 			continue;
-		if (!of_get_property(np, "primary", NULL))
+		if (!of_property_present(np, "primary"))
 			continue;
 		opal_lpc_chip_id = of_get_ibm_chip_id(np);
 		of_node_put(np);
-- 
2.43.0


