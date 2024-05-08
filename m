Return-Path: <linux-kernel+bounces-173781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3158C0548
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA131F22B19
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CA1130AC0;
	Wed,  8 May 2024 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N4GX6Zhc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="innIsTEy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D7A38DF2
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715198031; cv=none; b=fTLVxzLrN488LEsBE92MhXHzLFG241aPJxiEQT0FXmRDKBgE5+WByu5tGyg5rd1wOj/yZR9cWWHYFb1y4zXJnY25WIgYZWuy1Rqo7XNCaFCC0u12sYrnUoBmoXOSz6tn3IKpEKf9VuUCRq6icF7EIt/dvjJrQFmLwcjpGOzu6v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715198031; c=relaxed/simple;
	bh=QxOpoHTxeKxkvLy0yYHQBmZAY8o/hWqfG0stvAHRgOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BAa5j9opZbEuw88q7nuG+NVFaDme9+y/vzZ2leqm73TKXUAIDhyHV1mmoH+nkJ2MVxme/m3pW72nJlz1CCRwFuk31LKgt5kS0sgnVxUrfo6LS5BWhPp3LTE/pEGn3oeMCIc9ucaEc2TDuDoGLfIEyzP4AxesqxNeN1vd6Nb8U94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N4GX6Zhc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=innIsTEy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715198027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PHZAXCOEXcGPwR1zHInsLpn+NjYZkvzjn9mg8CTfNIU=;
	b=N4GX6ZhcQRgGoU+/6m3duXoFIz+//57RJYUB04l8qLsYlTcoQHgrfpLpiwZ1FvxEe63z7u
	pXnZfL6UYNvNjn+Rg0LPFlXv0amOW5Oj4JhVFzBmsY9J/fWD8PYFzOCDpoGNwZeHKBzeBl
	sECWqxuMFntYGlT5CQfU7FUR3QFVO9xgRR7dCOH+KFuWOnGOFptIMNERHfWlKbTH8taZlI
	ToAcYUUtNH7aw4H82DDVC59CVCgzwqqilnouWClUZ1crvGFu7VajJc3TYb3PjWn8isw6EZ
	XeXTbmRN4/o2dbadhiDv2TFa08TWUdJwjTw1QXra02vGKw5Re70l8pYizIo6TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715198027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PHZAXCOEXcGPwR1zHInsLpn+NjYZkvzjn9mg8CTfNIU=;
	b=innIsTEyOqyEN84jSzkZJjPaL8XoClSasWkHhFQ2P84HgGB3a+GdJCSimPZBBk74JmeMp5
	kbk30OriXFxzKNAA==
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
 "andy@infradead.org" <andy@infradead.org>, "arjan@linux.intel.com"
 <arjan@linux.intel.com>, "dimitri.sivanich@hpe.com"
 <dimitri.sivanich@hpe.com>, "feng.tang@intel.com" <feng.tang@intel.com>,
 "jgross@suse.com" <jgross@suse.com>, "kan.liang@linux.intel.com"
 <kan.liang@linux.intel.com>, "kprateek.nayak@amd.com"
 <kprateek.nayak@amd.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "mhklinux@outlook.com"
 <mhklinux@outlook.com>, "paulmck@kernel.org" <paulmck@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>, "ray.huang@amd.com"
 <ray.huang@amd.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
 "sohil.mehta@intel.com" <sohil.mehta@intel.com>, "thomas.lendacky@amd.com"
 <thomas.lendacky@amd.com>, "wendy.wang@intel.com" <wendy.wang@intel.com>,
 "x86@kernel.org" <x86@kernel.org>
Subject: [patch] x86/topology/amd: Ensure that LLC ID is initialized
In-Reply-To: <PUZPR04MB63168AC442C12627E827368581292@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB63168AC442C12627E827368581292@PUZPR04MB6316.apcprd04.prod.outlook.com>
Date: Wed, 08 May 2024 21:53:47 +0200
Message-ID: <87msp0nkqc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The original topology evaluation code initialized cpu_data::topo::llc_id
with the die ID initialy and then eventually overwrite it with information
gathered from a CPUID leaf.

The conversion analysis failed to spot that particular detail and omitted
this initial assignment under the assumption that each topology evaluation
path will set it up. That assumption is mostly correct, but turns out to be
wrong in case that the CPUID leaf 0x80000006 does not provide a LLC ID.

In that case LLC ID is invalid and as a consequence the setup of the
scheduling domain CPU masks is incorrect which subsequently causes the
scheduler core to complain about it during CPU hotplug:

  BUG: arch topology borken
       the CLS domain not a subset of the MC domain

Cure it by reusing legacy_set_llc() and assigning the die ID if the LLC ID
is invalid after all possible parsers have been tried.

Fixes: f7fb3b2dd92c ("x86/cpu: Provide an AMD/HYGON specific topology parser")
Reported-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
Thanks to Yuezhang for providing the debug information!
---
 arch/x86/kernel/cpu/topology_amd.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -119,7 +119,7 @@ static bool parse_8000_001e(struct topo_
 	return true;
 }
 
-static bool parse_fam10h_node_id(struct topo_scan *tscan)
+static void parse_fam10h_node_id(struct topo_scan *tscan)
 {
 	union {
 		struct {
@@ -131,20 +131,20 @@ static bool parse_fam10h_node_id(struct
 	} nid;
 
 	if (!boot_cpu_has(X86_FEATURE_NODEID_MSR))
-		return false;
+		return;
 
 	rdmsrl(MSR_FAM10H_NODE_ID, nid.msr);
 	store_node(tscan, nid.nodes_per_pkg + 1, nid.node_id);
 	tscan->c->topo.llc_id = nid.node_id;
-	return true;
 }
 
 static void legacy_set_llc(struct topo_scan *tscan)
 {
 	unsigned int apicid = tscan->c->topo.initial_apicid;
 
-	/* parse_8000_0008() set everything up except llc_id */
-	tscan->c->topo.llc_id = apicid >> tscan->dom_shifts[TOPO_CORE_DOMAIN];
+	/* If none of the parsers set LLC ID then use the die ID for it. */
+	if (tscan->c->topo.llc_id == BAD_APICID)
+		tscan->c->topo.llc_id = apicid >> tscan->dom_shifts[TOPO_CORE_DOMAIN];
 }
 
 static void topoext_fixup(struct topo_scan *tscan)
@@ -187,10 +187,7 @@ static void parse_topology_amd(struct to
 		return;
 
 	/* Try the NODEID MSR */
-	if (parse_fam10h_node_id(tscan))
-		return;
-
-	legacy_set_llc(tscan);
+	parse_fam10h_node_id(tscan);
 }
 
 void cpu_parse_topology_amd(struct topo_scan *tscan)
@@ -198,6 +195,7 @@ void cpu_parse_topology_amd(struct topo_
 	tscan->amd_nodes_per_pkg = 1;
 	topoext_fixup(tscan);
 	parse_topology_amd(tscan);
+	legacy_set_llc(tscan);
 
 	if (tscan->amd_nodes_per_pkg > 1)
 		set_cpu_cap(tscan->c, X86_FEATURE_AMD_DCM);

