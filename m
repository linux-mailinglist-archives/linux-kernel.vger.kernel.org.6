Return-Path: <linux-kernel+bounces-293117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC45957AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B427EB23839
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FED19478;
	Tue, 20 Aug 2024 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="La57jugl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0865017547
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724117397; cv=none; b=Nffny0uEB6883m7AJ08aPR+Xi+bn5z1iepTO6XQ/fD6rXq8dDXA8NIwrjMit8DWkq27fLfhZIqsHu2YpOPeLruyQGiQzIwMnrdnZ6mQ+fL8ub3irxtzqBnVQ4CDQc/q3b6E2gOxp3nWuPa8Fmhi3lQPje9AfLP7yx8LTeIXPIhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724117397; c=relaxed/simple;
	bh=Dm831pibPUVAy22FE2OyR6ovDgb8M43y05kQ9d0Nbp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kLb5JkKQf/pQd/kWazN1Xi4osMT1NfH9Pt7dheVEEVMYDnmooRQeCDaUF657/2x+XKUdfdx6VSlNuMH+2Ud2NMg6Nrh3LOX3ef2fR71wodrdx9fS1ErLTlHjRi35QIgELK3tzcq5h8ZOIPxDvVjPzV7XcRjfQP5PY44llpLIRxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=La57jugl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DE22C32782;
	Tue, 20 Aug 2024 01:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724117396;
	bh=Dm831pibPUVAy22FE2OyR6ovDgb8M43y05kQ9d0Nbp0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=La57jugllwsMiRz2JSf5GLxjOMRGHXs0OAfVqft5NcRVh0aXR7D/dP99dU3tGxLUq
	 d/xKSTSsnitQruCIdQGiRpIZnGv2kHCDWsuniRn7s8rW1hs5NboIFxySUORQxmINVN
	 NT/ORzoObN94UJ/TXP7ocS22xcsLY7f9maD4tMJHxMho9lsgivbBiUmexaD8TSxlyw
	 +Z2Jyz8063iUQrrI9IBYFfbikzRwz0cuyOzVjSXtO9S/Qr0CJ9T/GykcJifIO9bNDt
	 S495oHSVcG6BhtowZ3RyELg6Bwh77u7q6bLoIwb0qdNnir33PfmkAZsmLgvfE5tWhc
	 SUNRUJFUyzSeQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68463C3DA4A;
	Tue, 20 Aug 2024 01:29:56 +0000 (UTC)
From: Christoph Lameter via B4 Relay <devnull+cl.gentwo.org@kernel.org>
Date: Mon, 19 Aug 2024 18:29:45 -0700
Subject: [PATCH RFC] SLUB: Add support for per object memory policies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-strict_numa-v1-1-ed19f278c7f7@gentwo.org>
X-B4-Tracking: v=1; b=H4sIAIjxw2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC0NL3eKSoszkkvi80txE3bRkU8skY2NDI+NEIyWgjoKi1LTMCrBp0Up
 Bbs5KsbW1AK89VbJiAAAA
To: Vlastimil Babka <vbabka@suse.cz>, Pekka Enberg <penberg@kernel.org>, 
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Yang Shi <shy828301@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "Christoph Lameter (Ampere)" <cl@gentwo.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724117396; l=2985;
 i=cl@gentwo.org; s=20240811; h=from:subject:message-id;
 bh=WCkmlka2muGf3df5xwLt0U+IUMuVYP3f3DZ+713T/TY=;
 b=pytFnytVJB7IrVevzcGROanOnrwdyHDWZ/XhESjVY5Qg10L8R19EM7qNT0yVSpn44ZGrEUAL3
 v4iQLyirblXCnXM00TLtKmYTJhOD7PglYdV4OQpBbDKKd9v78bWf3zN
X-Developer-Key: i=cl@gentwo.org; a=ed25519;
 pk=I7gqGwDi9drzCReFIuf2k9de1FI1BGibsshXI0DIvq8=
X-Endpoint-Received: by B4 Relay for cl@gentwo.org/20240811 with
 auth_id=194
X-Original-From: Christoph Lameter <cl@gentwo.org>
Reply-To: cl@gentwo.org

From: Christoph Lameter <cl@gentwo.org>

The old SLAB allocator used to support memory policies on a per
allocation bases. In SLUB the memory policies are applied on a
per page frame / folio bases. Doing so avoids having to check memory
policies in critical code paths for kmalloc and friends.

This worked well on Intel/AMD/PowerPC because the
interconnect technology is mature and can minimize the latencies
through intelligent caching even if some small objects are not
placed optimally.

However, on ARM we have the emergence of new NUMA interconnect
technology based more on embedded devices. Caching of remote content
can currently be ineffective using the standard building blocks / mesh
available on that platform. Such architectures benefit if each slab
object is individually placed according to memory policies.

This patch adds another kernel parameter

	slab_strict_numa

If that is set then a static branch is activated that will cause
the hotpaths of the allocator to evaluate the current memory
allocation policy. Each object will be properly placed by
paying the price of extra processing and SLUB will no longer
defer to the page allocator to apply memory policies at the
folio level.

Signed-off-by: Christoph Lameter (Ampere) <cl@gentwo.org>
---
This is a draft to discuss the issue. It builds but was never run.
---
 mm/slub.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index c9d8a2497fd6..c86e7ee9520a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -218,6 +218,10 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
 #endif
 #endif		/* CONFIG_SLUB_DEBUG */
 
+#ifdef CONFIG_NUMA
+DEFINE_STATIC_KEY_FALSE(strict_numa);
+#endif
+
 /* Structure holding parameters for get_partial() call chain */
 struct partial_context {
 	gfp_t flags;
@@ -3825,6 +3829,14 @@ static __always_inline void *__slab_alloc_node(struct kmem_cache *s,
 	unsigned long tid;
 	void *object;
 
+#ifdef CONFIG_NUMA
+
+	if (static_branch_unlikely(&strict_numa) && node == NUMA_NO_NODE)
+
+		node = mempolicy_slab_node();
+
+#endif
+
 redo:
 	/*
 	 * Must read kmem_cache cpu data via this cpu ptr. Preemption is
@@ -5523,6 +5535,21 @@ static int __init setup_slub_min_objects(char *str)
 __setup("slab_min_objects=", setup_slub_min_objects);
 __setup_param("slub_min_objects=", slub_min_objects, setup_slub_min_objects, 0);
 
+#ifdef CONFIG_NUMA
+static int __init setup_slab_strict_numa(char *str)
+{
+	if (nr_node_ids > 1)
+		static_branch_enable(&strict_numa);
+	else
+		pr_warn("slab_strict_numa parameter set on non NUMA system.\n");
+
+	return 1;
+}
+
+__setup("slab_strict_numa", setup_slab_strict_numa);
+#endif
+
+
 #ifdef CONFIG_HARDENED_USERCOPY
 /*
  * Rejects incorrectly sized objects and objects that are to be copied

---
base-commit: 6e4436539ae182dc86d57d13849862bcafaa4709
change-id: 20240819-strict_numa-fc59b33123a2

Best regards,
-- 
Christoph Lameter <cl@gentwo.org>



