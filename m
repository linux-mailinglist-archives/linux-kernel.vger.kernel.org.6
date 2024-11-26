Return-Path: <linux-kernel+bounces-421818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD719D908A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 03:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CCC28BDA8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA7E47F69;
	Tue, 26 Nov 2024 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="qhJIQKQK"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C363B7A8;
	Tue, 26 Nov 2024 02:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732589841; cv=none; b=RS0yMCyG2byDRiqd/SdyxFa/FLGoLgmivgykGoPtzwo6F9DT2WlvqhfrYMau4hUKsiNn79+G/cYsqPBsT8e3jifbfV0/+lLhuZ6rbRD+pb8Jni7BmSB4KzVkAwvPHzvHFmWgK1yh1w+DZnNE+YAjr9SoGtPXVdLnPh11QoLQMow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732589841; c=relaxed/simple;
	bh=dhHqAJXYrA8Ge/px/LWXkKSpA+yhWSIy8R7bYHSW9Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ckGaIxCx4AV9u4y3ycNTKYwgVgvjOM7nHM1bHqnLoZJ3Up2a/zLWbcANbpHBD/y8I6ro987Puo+C/emW3KgKPiO+HCtZo+qhqbNIV34DHol+TYS7pq3/uW9gc+GLlAWk8dbGR8xkYsQO41V7gHEya5E4rVe8BY4hLgmIKVYw854=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=qhJIQKQK; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1732589830;
	bh=M1EXjRSBmP+TbGxC4zWxWzgMAO1bJQeJ9HrvP6LtBWs=;
	h=From:To:Cc:Subject:Date:From;
	b=qhJIQKQKLTQaD+QnmtrGCL1EMknmPlAIm2ZuL3DNNdreJusuadCrpFcTwpJkB4Hs4
	 euIHgc3/iY0KOIjx+pltpm38SrITbir/fz43bV7xEhJnYFBrgjfxTT4rFPW3SDg/MM
	 GONOTy0X0l0gToTZb19LiQylSM6wUBJE98JuAFaXpZ+2ozi4qAO9wWQJuYsGpUo4ik
	 k1CLMT/WVyqsgu4rAMt7D44vpumDR4j8VmhVlI4TZk/7Y/Jr05jk6zkSwqLXMFtA3Z
	 uO4kemJGzo97mLVjqZMzXftHPfFTbdHiO5GJhszWl0iPf/pe3MJJlbXQbfwrjsWyky
	 OA5K+nja/Pw3A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xy6gB3dMjz4wyV;
	Tue, 26 Nov 2024 13:57:10 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <robh@kernel.org>,
	saravanak@google.com,
	<linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH] powerpc/prom_init: Fixup missing powermac #size-cells
Date: Tue, 26 Nov 2024 13:57:10 +1100
Message-ID: <20241126025710.591683-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some powermacs `escc` nodes are missing `#size-cells` properties,
which is deprecated and now triggers a warning at boot since commit
045b14ca5c36 ("of: WARN on deprecated #address-cells/#size-cells
handling").

For example:

  Missing '#size-cells' in /pci@f2000000/mac-io@c/escc@13000
  WARNING: CPU: 0 PID: 0 at drivers/of/base.c:133 of_bus_n_size_cells+0x98/0x108
  Hardware name: PowerMac3,1 7400 0xc0209 PowerMac
  ...
  Call Trace:
    of_bus_n_size_cells+0x98/0x108 (unreliable)
    of_bus_default_count_cells+0x40/0x60
    __of_get_address+0xc8/0x21c
    __of_address_to_resource+0x5c/0x228
    pmz_init_port+0x5c/0x2ec
    pmz_probe.isra.0+0x144/0x1e4
    pmz_console_init+0x10/0x48
    console_init+0xcc/0x138
    start_kernel+0x5c4/0x694

As powermacs boot via prom_init it's possible to add the missing
properties to the device tree during boot, avoiding the warning. Note
that `escc-legacy` nodes are also missing `#size-cells` properties, but
they are skipped by the macio driver, so leave them alone.

Depends-on: 045b14ca5c36 ("of: WARN on deprecated #address-cells/#size-cells handling")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/prom_init.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 73210e5bcfa7..8e776ba39497 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2848,7 +2848,7 @@ static void __init fixup_device_tree_chrp(void)
 #endif
 
 #if defined(CONFIG_PPC64) && defined(CONFIG_PPC_PMAC)
-static void __init fixup_device_tree_pmac(void)
+static void __init fixup_device_tree_pmac64(void)
 {
 	phandle u3, i2c, mpic;
 	u32 u3_rev;
@@ -2888,7 +2888,31 @@ static void __init fixup_device_tree_pmac(void)
 		     &parent, sizeof(parent));
 }
 #else
-#define fixup_device_tree_pmac()
+#define fixup_device_tree_pmac64()
+#endif
+
+#ifdef CONFIG_PPC_PMAC
+static void __init fixup_device_tree_pmac(void)
+{
+	__be32 val = 1;
+	char type[8];
+	phandle node;
+
+	// Some pmacs are missing #size-cells on escc nodes
+	for (node = 0; prom_next_node(&node); ) {
+		type[0] = '\0';
+		prom_getprop(node, "device_type", type, sizeof(type));
+		if (prom_strcmp(type, "escc"))
+			continue;
+
+		if (prom_getproplen(node, "#size-cells") != PROM_ERROR)
+			continue;
+
+		prom_setprop(node, NULL, "#size-cells", &val, sizeof(val));
+	}
+}
+#else
+static inline void fixup_device_tree_pmac(void) { }
 #endif
 
 #ifdef CONFIG_PPC_EFIKA
@@ -3111,6 +3135,7 @@ static void __init fixup_device_tree(void)
 {
 	fixup_device_tree_chrp();
 	fixup_device_tree_pmac();
+	fixup_device_tree_pmac64();
 	fixup_device_tree_efika();
 	fixup_device_tree_pasemi();
 }
-- 
2.47.0


