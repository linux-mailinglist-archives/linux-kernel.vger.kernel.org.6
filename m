Return-Path: <linux-kernel+bounces-566821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DE7A67CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CDD21886816
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230131DF247;
	Tue, 18 Mar 2025 19:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0f245C8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8477F17A303
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742325802; cv=none; b=rrtiOeuy/fWLFwQDSM9mOIqZhMZb1S/Ijl4qb1EpzFDGM23GOX3cJDChx9tyH/NfYWBt6PUXXkjthnuihLwMewR5q763Cn+eCMxxuUN8rmF/nPxqYV1hW+YLAv/dNRYzLIoVzqkyg6urJysffsKiHqB3mW08fPa7ZsS1Xdq8sxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742325802; c=relaxed/simple;
	bh=rR5kl4eYsl4yRHFKGBdxMy3aCSYWtkBlbYl5vE39f+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3bl+E8owVwii2zmDuOxQAXE7xGpaYoV8CLiWRRRDeo6EEMuHLxgJq2vCbPQ3VXSvnAzavsCv9LyeamiLdcUAFCs2H8pJzI0wd9GNUCThmpz7q39L2HCQb5G3NK/LG3vmF0jDvPO3M9AE1v1MPZUcN1j00SSdYQEM4rkpHuOcRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0f245C8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA05FC4CEEE;
	Tue, 18 Mar 2025 19:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742325802;
	bh=rR5kl4eYsl4yRHFKGBdxMy3aCSYWtkBlbYl5vE39f+I=;
	h=From:To:Cc:Subject:Date:From;
	b=C0f245C8CdxaBXW2HBxXnQRVBW0+9L1AxH82XadnPtOCQr0I50qAV+ZqqZ63ATK5K
	 qUZesaVHxFStJam+u7qSzjTDkfalASqIhBsw1cEbYHHfizgpsKJddrJGNTNIgMKrJP
	 pkn8sDzhaMXT79gWbWzblUd5hIcdIlnXFvjJS3PO84lLUwvTzOiZVKTArHcQYmDwoJ
	 jkTDhbF09IXjSIY+aenWVw+eEPYMmyze2S1tqdMaHtONSi9yhUX5sADOKTQ1vx2Uxz
	 hgZRsCYpeuHv0yVf52X3Y/uzhd6KVw2WpmnKYmFHrcDMhDNIa9sbBaudgXX+OT+0gY
	 P2eXxR1jvdU8A==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/prom_init: Fixup missing powermac #size-cells on i2s nodes
Date: Tue, 18 Mar 2025 14:22:55 -0500
Message-ID: <20250318192256.3534046-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some powermacs `i2s` nodes are missing `#size-cells` properties,
which is deprecated and now triggers a warning at boot since commit
045b14ca5c36 ("of: WARN on deprecated #address-cells/#size-cells
handling").

For example:

  Missing '#size-cells' in /pci@f2000000/mac-io@17/i2s@10000
  WARNING: CPU: 0 PID: 462 at drivers/of/base.c:134 of_bus_n_size_cells+0xb0/0x120
  Hardware name: PowerMac3,4 7400 0xc0209 PowerMac
  ...
  Call Trace:
    of_bus_n_size_cells+0xb0/0x120 (unreliable)
    of_bus_default_count_cells+0x40/0x60
    __of_get_address+0x158/0x294
    __of_address_to_resource+0x48/0x258
    i2sbus_probe+0x564/0x85c [snd_aoa_i2sbus]
    macio_device_probe+0x60/0x108
    really_probe+0xd8/0x344
    __driver_probe_device+0x90/0x1f0
    driver_probe_device+0x40/0xf4
    ...

As there's already a fixup for the same issue on `escc` nodes, add
`i2s` device_type to the existing fixup.

Reported-by: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/powerpc/kernel/prom_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 57082fac4668..69018a2afc41 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2889,11 +2889,11 @@ static void __init fixup_device_tree_pmac(void)
 	char type[8];
 	phandle node;
 
-	// Some pmacs are missing #size-cells on escc nodes
+	// Some pmacs are missing #size-cells on escc and i2s nodes
 	for (node = 0; prom_next_node(&node); ) {
 		type[0] = '\0';
 		prom_getprop(node, "device_type", type, sizeof(type));
-		if (prom_strcmp(type, "escc"))
+		if (prom_strcmp(type, "escc") && prom_strcmp(type, "i2s"))
 			continue;
 
 		if (prom_getproplen(node, "#size-cells") != PROM_ERROR)
-- 
2.47.2


