Return-Path: <linux-kernel+bounces-295555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1120D959E46
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E2A1C22488
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA49199FA9;
	Wed, 21 Aug 2024 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="bRMn7Y6S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fq3VlFcY"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4EC199946
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724245941; cv=none; b=XTCbXx+ktYuAIUXEL3TWQA1RsDxOFYToE/cUziQ7abtJhwGfDL4DOfrF4J79wSN2Rmt7yALaRpn5Z+KuaQU+4sKXpPb0K5HCR7ERW03OgR0yW1X7CIf1QAAD4Hmhh/q4U9t0HYMgOaZ6/KhuQKOEuenZzc58YVo223LqbI43INA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724245941; c=relaxed/simple;
	bh=tDKnUzJEUn42xx6CrGUZ/h5SFPmwKVMM3JcyigKa/Rs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i84Urogb3HVVqubmrnStDTbXj+d9pvRCaoN08KhR0YQRKaOr3PHwV7QSwgL73ZJlGd6I7WPsuO5FOZxRu1PiDWR+ov0Ge+yNv8OeX2tjIi1pdkgXdfg5jtBbtnckRS9ucOf9OyYnr2hlUWtbqVVploj+iuG8uyYXFry521jF/7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=bRMn7Y6S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fq3VlFcY; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6D16C138FF31;
	Wed, 21 Aug 2024 09:12:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 21 Aug 2024 09:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1724245939;
	 x=1724332339; bh=oYpu9hqy6eip7yofbiQCE1bFjroNNzyWUk61TL9Z+zo=; b=
	bRMn7Y6S38PSJiia0+NlHKCPbZVmfumcz8vE33bWfQB/VjcRJyWW32nrUg0L39us
	0sFQcbsBMIGk9SDwg5TlvFOQElQs/GQYMRgH5crNaNXEOe3Cb+Y1dVJLPv1hbKUU
	kndMwZ5/DCILtE85KHKJ5Ag5n/eMoUZA9oX0mQrxaNADZXlkeQTaqJU0DFY7G7zZ
	iskoqe/7SdNVbtAqKxghDOVrlGyAVFxtYcleEHQD/c/scA/HOLKtlJMHAHK68I9Z
	0bZ2Ry13XjORlYLvAmsrmPFpZYyz3X3lWBCptf3xA6jBRN1r3irsi5ccS+nLTF/G
	M01crIDhZEa9ubL212cyTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724245939; x=
	1724332339; bh=oYpu9hqy6eip7yofbiQCE1bFjroNNzyWUk61TL9Z+zo=; b=f
	q3VlFcYZArUYyM6C6BuoFPjZOHnMUj3oNZbGqKDyN6OV8PSe7997DOaAVs/ZW6M7
	8Thz4stRefbgvcRKS8J2rB/TwPdIsgUTniQOHjv+QmM7usGMUp2wXAmpqHEkRApx
	bcDiC7THZBcPFAXP24h9QAj4ObXC+5hRYyDlyXgVTN9m9MI9P4A093xm9Z06jGkq
	rlokBDwGfkJFJVkoEwGcn1bqcMpefdRHztpz3yKiZiEywOshUc0uYJ9KCzr6SWIt
	UdUbHmiimTOOimVcJpNr+WVpjrg5KAS8dGYdE73ycWHFKVZuN+EO8rgCRWMB2Yl+
	Y3xMlfF5Dken0pdstsKOg==
X-ME-Sender: <xms:s-fFZjY292vbbZksrcNBRwPd6SP-EPDKWY3LhBTuCPn_axABd6FUEQ>
    <xme:s-fFZia1tCjaMBOzZh4T3-vly41OZYqGOIlPzr4_IG2crJJz3be1HSaJekve3VY_v
    oaSW4sjkcsA64SMAkY>
X-ME-Received: <xmr:s-fFZl-dGZpe_unwR54zCWcqRB1aAbFnTKNn7vi7p7xcrh1nLGpGTaXZYkMTapRXL_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddukedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffek
    gedugefhtdduudeghfeuveegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdr
    tghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epkhgvrhhnvghlseigvghntdhnrdhnrghmvgdprhgtphhtthhopegthhgvnhhhuhgrtggr
    iheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhoohhnghgrrhgthheslhhishht
    shdrlhhinhhugidruggvvhdprhgtphhtthhopehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhm
X-ME-Proxy: <xmx:s-fFZprHwloJsZ8zpO4Qhg7ZVWYgfHd0RxEQ-AuriZNMl3iekFcQbA>
    <xmx:s-fFZuocf24KmvU6KkZbhlG6mvf2nEYTeeqof4ZMbmcrT9zKzByevQ>
    <xmx:s-fFZvQnuFSZYOYn7wBgfBBRQiD-gxnL0tEJ4veeYy26X-DDMTxBTw>
    <xmx:s-fFZmrM22WqtdnjeHuMZHU_uz8W2VX3KER6AgvJk3rOSRw_KyZ4dQ>
    <xmx:s-fFZrDFvPR6gi96mvobryTMu8DEG-IjE_6JQWcPrwAF0JX2sQ8rJoJv>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Aug 2024 09:12:18 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 21 Aug 2024 14:12:15 +0100
Subject: [PATCH 1/3] LoongArch: Move pcibus_to_node to pci.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-loongarch_archnuma-v1-1-f47b191beee8@flygoat.com>
References: <20240821-loongarch_archnuma-v1-0-f47b191beee8@flygoat.com>
In-Reply-To: <20240821-loongarch_archnuma-v1-0-f47b191beee8@flygoat.com>
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2095;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=tDKnUzJEUn42xx6CrGUZ/h5SFPmwKVMM3JcyigKa/Rs=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSjzzdknNqv0lanG9rMc87y8MEzJqzlJ6Mc9kYa53tfW
 +wwsXFuRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExEZinDT8Z/zHbJp62vsx5/
 v0ZDLOBNK6/umbXr9dw/xBRt1PyTuZ6RYc7WWIMjuTdrOmybdco2Pd5hnM57fd7kG+bL1XYuYWs
 24QIA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Align with RISC-V and prepare for removal of numa.c.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/loongarch/include/asm/pci.h      | 12 ++++++++++++
 arch/loongarch/include/asm/topology.h |  5 -----
 arch/loongarch/kernel/numa.c          |  6 ------
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/loongarch/include/asm/pci.h b/arch/loongarch/include/asm/pci.h
index 846909d7e831..0ecb3668ed0c 100644
--- a/arch/loongarch/include/asm/pci.h
+++ b/arch/loongarch/include/asm/pci.h
@@ -19,6 +19,18 @@
 
 extern phys_addr_t mcfg_addr_init(int node);
 
+#if defined(CONFIG_PCI) && defined(CONFIG_NUMA)
+static inline int pcibus_to_node(struct pci_bus *bus)
+{
+	return dev_to_node(&bus->dev);
+}
+#ifndef cpumask_of_pcibus
+#define cpumask_of_pcibus(bus)	(pcibus_to_node(bus) == -1 ?		\
+				 cpu_all_mask :				\
+				 cpumask_of_node(pcibus_to_node(bus)))
+#endif
+#endif /* defined(CONFIG_PCI) && defined(CONFIG_NUMA) */
+
 /* generic pci stuff */
 #include <asm-generic/pci.h>
 
diff --git a/arch/loongarch/include/asm/topology.h b/arch/loongarch/include/asm/topology.h
index 50273c9187d0..6bed5001c2e3 100644
--- a/arch/loongarch/include/asm/topology.h
+++ b/arch/loongarch/include/asm/topology.h
@@ -14,11 +14,6 @@ extern cpumask_t cpus_on_node[];
 
 #define cpumask_of_node(node)  (&cpus_on_node[node])
 
-struct pci_bus;
-extern int pcibus_to_node(struct pci_bus *);
-
-#define cpumask_of_pcibus(bus)	(cpu_online_mask)
-
 extern unsigned char node_distances[MAX_NUMNODES][MAX_NUMNODES];
 
 void numa_set_distance(int from, int to, int distance);
diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index 84fe7f854820..3b69f2b847e0 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -392,9 +392,3 @@ void __init mem_init(void)
 	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 	memblock_free_all();
 }
-
-int pcibus_to_node(struct pci_bus *bus)
-{
-	return dev_to_node(&bus->dev);
-}
-EXPORT_SYMBOL(pcibus_to_node);

-- 
2.46.0


