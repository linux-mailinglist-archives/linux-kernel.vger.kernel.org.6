Return-Path: <linux-kernel+bounces-567615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F07C5A6885B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7740884BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578FD25D1FC;
	Wed, 19 Mar 2025 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WA23J/ew"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB13225D1EE;
	Wed, 19 Mar 2025 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376769; cv=none; b=Ryv/wddjAzQiDy+YxMXKzdKBI4WCcSo6bktPJEMA/kOhh6wmsCvb7JLj1Rw40X4Be1uozSU7LvgoMVd1M5raRrO07fYA1b6Xlj5CgfdIwwuye8BJX3ALz6dPMVTIg/JMYYaQkXt3A7ORumy8Ej1GPBiyjArfafBfkeQDmg1s4+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376769; c=relaxed/simple;
	bh=X8wudJPii2FdSLgylneYrvJlLDA9ojvTW0l/YVqFwHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqBBzDJmlw1ZxJpi/UuUpl9qDKZfwU2mkciXMgfDw5DtUDbnGt5bwwbqhpdPy7tspnxN0BXPjCdxqB55SoZejYIqaQsxb6HFolppwJKT17sboAD8dZMLAQTcTCTJXURotnDY4qnX+LgHprm+oSqQnRvrPomysfiWC+wA1mjOjr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WA23J/ew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54191C4CEEA;
	Wed, 19 Mar 2025 09:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376769;
	bh=X8wudJPii2FdSLgylneYrvJlLDA9ojvTW0l/YVqFwHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WA23J/ew5erlnbkD8lMQ/orw9PaZX4ufHQyXg/QR7SfKTRRWVBBeM4N12tcYBpvzS
	 98CjAsimJH+LuRMhGZWqQ6O01+GNGScujWglkOFG0DvhOqpq7RfR/ly5b7VL00IHil
	 UXqMwW3/6YRiV5d0ETYoKj+C0VTg6EbVBUent8d2Ym4fdievKjLAz3cpycGaok+X7A
	 4bhYKwXMnNuOhbIkaZ4JiS1EbMej3FnFf0F0qPOBVJO1LNf35pmbFPm2CXKvGY1cMU
	 3fPKYgeZfpLa+vyspFvtbVmvKSJzZjEPyHihzaOj7S8M5AKwmwEgYzd1Ja4MBKfR1u
	 8vHS8lwsGx1wg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Geoff Levand <geoff@infradead.org>,
	linuxppc-dev@lists.ozlabs.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 39/57] irqdomain: ppc: Switch irq_domain_add_nomap() to use fwnode
Date: Wed, 19 Mar 2025 10:29:32 +0100
Message-ID: <20250319092951.37667-40-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

All irq_domain_add_*() functions are going away. PowerPC is the only
user of irq_domain_add_nomap() and there is no irq_domain_create_nomap()
complement.

Therefore, to align with the rest of kernel, rename
irq_domain_add_nomap() to irq_domain_create_nomap() and accept
fwnode_handle instead of device_node.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Alex Shi <alexs@kernel.org>
Cc: Yanteng Si <si.yanteng@linux.dev>
Cc: Dongliang Mu <dzm91@hust.edu.cn>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Geoff Levand <geoff@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/core-api/irq/irq-domain.rst                    | 2 +-
 Documentation/translations/zh_CN/core-api/irq/irq-domain.rst | 2 +-
 arch/powerpc/platforms/powermac/smp.c                        | 2 +-
 arch/powerpc/platforms/ps3/interrupt.c                       | 2 +-
 include/linux/irqdomain.h                                    | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
index f88a6ee67a35..44f4ba5480df 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -141,7 +141,7 @@ No Map
 
 ::
 
-	irq_domain_add_nomap()
+	irq_domain_create_nomap()
 
 The No Map mapping is to be used when the hwirq number is
 programmable in the hardware.  In this case it is best to program the
diff --git a/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst b/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst
index 9174fce12c1b..ecb23cfbc9fc 100644
--- a/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst
+++ b/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst
@@ -124,7 +124,7 @@ irq_domain_add_tree()和irq_domain_create_tree()在功能上是等价的，除
 
 ::
 
-	irq_domain_add_nomap()
+	irq_domain_create_nomap()
 
 当硬件中的hwirq号是可编程的时候，就可以采用无映射类型。 在这种情况下，最好将
 Linux IRQ号编入硬件本身，这样就不需要映射了。 调用irq_create_direct_mapping()
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 09e7fe24fac1..88e92af8acf9 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -190,7 +190,7 @@ static int __init psurge_secondary_ipi_init(void)
 {
 	int rc = -ENOMEM;
 
-	psurge_host = irq_domain_add_nomap(NULL, ~0, &psurge_host_ops, NULL);
+	psurge_host = irq_domain_create_nomap(NULL, ~0, &psurge_host_ops, NULL);
 
 	if (psurge_host)
 		psurge_secondary_virq = irq_create_direct_mapping(psurge_host);
diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index 95e96bd61a20..a4ad4b49eef7 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -743,7 +743,7 @@ void __init ps3_init_IRQ(void)
 	unsigned cpu;
 	struct irq_domain *host;
 
-	host = irq_domain_add_nomap(NULL, PS3_PLUG_MAX + 1, &ps3_host_ops, NULL);
+	host = irq_domain_create_nomap(NULL, PS3_PLUG_MAX + 1, &ps3_host_ops, NULL);
 	irq_set_default_domain(host);
 
 	for_each_possible_cpu(cpu) {
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 1480951a690b..984d0188f9ec 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -431,13 +431,13 @@ static inline struct irq_domain *irq_domain_add_linear(struct device_node *of_no
 }
 
 #ifdef CONFIG_IRQ_DOMAIN_NOMAP
-static inline struct irq_domain *irq_domain_add_nomap(struct device_node *of_node,
+static inline struct irq_domain *irq_domain_create_nomap(struct fwnode_handle *fwnode,
 					 unsigned int max_irq,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
 	struct irq_domain_info info = {
-		.fwnode		= of_fwnode_handle(of_node),
+		.fwnode		= fwnode,
 		.hwirq_max	= max_irq,
 		.direct_max	= max_irq,
 		.ops		= ops,
-- 
2.49.0


