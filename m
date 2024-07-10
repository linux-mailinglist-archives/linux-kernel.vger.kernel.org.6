Return-Path: <linux-kernel+bounces-248111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A3292D883
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ABA02814AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AD81991B5;
	Wed, 10 Jul 2024 18:43:22 +0000 (UTC)
Received: from relay161.nicmail.ru (relay161.nicmail.ru [91.189.117.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F134198841
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720637002; cv=none; b=kSFIttmtmizIGvXT0KJpekVDN320ObZbR2ALJVd1LhOSVu+tMzpgkTsqFZQ1hJy62LA4YvRDgjGsPzKqKZ6eBMs4eCkOVA8gmea+uLfqDWawp7bT4167SkzYnzvA0CnVtv9G1PzyhNMxvpFdbzCtqoHFAaYaVaW1Lm9dw29u77s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720637002; c=relaxed/simple;
	bh=FXyy7el8tImHX3hsOefOnZVcVLb9tiLHPU90G68igp0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZIDFt8LuXyTWZFD4RnijUO//98ursWrMxOzOuKRZDNRbog2VhGTstHyBH1x+XOWqRT+EMBowb4VJZffEwN58A3p5nD0z96Ka63RjB+aT4i+5RKMSdAhnV1Ox8jEYa9dyIcSSNSZiKw/v4R+IFC1w3qTDyVAI+/Jp70kLOVkXxO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.152] (port=11668 helo=mitx-gfx..)
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1sRcHG-0008Aq-3k;
	Wed, 10 Jul 2024 21:42:54 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO mitx-gfx..)
	by incarp1104.mail.hosting.nic.ru (Exim 5.55)
	with id 1sRcHG-007YFG-09;
	Wed, 10 Jul 2024 21:42:54 +0300
From: Nikita Kiryushin <kiryushin@ancud.ru>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Nikita Kiryushin <kiryushin@ancud.ru>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] x86/smpboot: Mark memory allocations in smp_prepare_cpus_common __GFP_NOFAIL
Date: Wed, 10 Jul 2024 21:42:40 +0300
Message-Id: <20240710184240.389395-1-kiryushin@ancud.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MS-Exchange-Organization-SCL: -1

As of now, zalloc_cpumask_var_node for various maps in
smp_prepare_cpus_common is not checked.

As memory allocations here are critical and there is no reasonable
allocation failure policy, the allocations should never fail.

Use __GFP_NOFAIL flag, as suggested in
https://lore.kernel.org/all/ZhaUZFY5MUyy6hWK@gmail.com/

Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
 arch/x86/kernel/smpboot.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 0c35207320cb..76fabb74b8ea 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1044,11 +1044,11 @@ void __init smp_prepare_cpus_common(void)
 	for_each_possible_cpu(cpu) {
 		node = cpu_to_node(cpu);
 
-		zalloc_cpumask_var_node(&per_cpu(cpu_sibling_map,    cpu), GFP_KERNEL, node);
-		zalloc_cpumask_var_node(&per_cpu(cpu_core_map,       cpu), GFP_KERNEL, node);
-		zalloc_cpumask_var_node(&per_cpu(cpu_die_map,        cpu), GFP_KERNEL, node);
-		zalloc_cpumask_var_node(&per_cpu(cpu_llc_shared_map, cpu), GFP_KERNEL, node);
-		zalloc_cpumask_var_node(&per_cpu(cpu_l2c_shared_map, cpu), GFP_KERNEL, node);
+		zalloc_cpumask_var_node(&per_cpu(cpu_sibling_map,    cpu), GFP_KERNEL | __GFP_NOFAIL, node);
+		zalloc_cpumask_var_node(&per_cpu(cpu_core_map,       cpu), GFP_KERNEL | __GFP_NOFAIL, node);
+		zalloc_cpumask_var_node(&per_cpu(cpu_die_map,        cpu), GFP_KERNEL | __GFP_NOFAIL, node);
+		zalloc_cpumask_var_node(&per_cpu(cpu_llc_shared_map, cpu), GFP_KERNEL | __GFP_NOFAIL, node);
+		zalloc_cpumask_var_node(&per_cpu(cpu_l2c_shared_map, cpu), GFP_KERNEL | __GFP_NOFAIL, node);
 	}
 
 	set_cpu_sibling_map(0);
-- 
2.34.1


