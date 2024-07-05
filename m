Return-Path: <linux-kernel+bounces-241903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0378A9280EB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 05:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6C0285E15
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41F469D31;
	Fri,  5 Jul 2024 03:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="YnjnmISl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VuZUgkzs"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428D7405F8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 03:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720150189; cv=none; b=HnYSLZQoehZ9nvjelrZVkGn9fsgGrrb4JFWDd4X2huLEYME/X15anGovn3mh4/p/vvNTrWGl0dvsVAYXxQIDNpz5gOIPsnC2X7a6GpZ7zWnENGwMnCBmQDvpDDcg2j3zq5PratqGHC8TR1rbYkp+vlchZ1BsP3g3NJdDxF3ni3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720150189; c=relaxed/simple;
	bh=BRkcuXQ3cJedwbfmLvfBW1dIeZpS3I+xSxBwfNpvU48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SpxME+AeQ8m7HhTlss7p1+syYc+Xi6osvmAmhKsIdZyD+fcUZ8yCobZjifEdI+TAfqQoQf3JqXqVOc3O1BHHSfD9V/uSfVuTe33TfXNbahVRdWQVOqa7BapO7YKxHEmEiPayMAKKzsStQ7sfIbGM3RmlQll1QkguJ1MgNEok/o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=YnjnmISl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VuZUgkzs; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 77BC21380285;
	Thu,  4 Jul 2024 23:29:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 04 Jul 2024 23:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1720150186;
	 x=1720236586; bh=41JX6fqLDkWKOiBrUjt2FO4XbxsPy1jqYEouFQLlknE=; b=
	YnjnmISlnGwkZdblviCIlIpW85K23nuqraJ5FpuqHpgKbZHTtS2yno4R6DmXyqaj
	/7R7cp00uhh3cn4ZsXX+hCqqwAcLTAG6+P5Q/NXDuENbBlHGrEuv1m9/8f97ANFq
	ORuO5KRSucOXCF0m6fDPMHvBWiSkK2vKRVjNh+Xab1DAIHqi0HjLpVGN4P5ce6Xq
	N/q8E9Xk+3RDrH9RCEkNomW3Y35jyvrO+6B7egVkHIgBGVhcs3wzRtx+h7l4dkfJ
	LN7goc7VxYrcOYlZQPpxRmBS6Zu2L1M84xXn4RZoLyZIT1NyYwaJlKq7az30Ng9S
	hWAmQQNey4gn38FN7zXjeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720150186; x=
	1720236586; bh=41JX6fqLDkWKOiBrUjt2FO4XbxsPy1jqYEouFQLlknE=; b=V
	uZUgkzs+OVT5KuiNF5Ik4trvvZ3buDPVAkyzWmGlN1m98B9Q/m+6QOt/2NI9enYr
	TvDQUEsrBcFmPTYUQeGxnp/MizJk3D0wnNeEpOTaYrmhsunD6ceemsDfoQDuf7en
	f44NUocp1N141m63XLzN+xoDwQPmK/B0ycMlBoBTfVpAPwBdDZzVag8E32fVaiq9
	Thod8QCZTezFyyMXiUmkvb/qHFNB8Ovp9vkwtmBp35k9rP7hSuutXn7ZvJFKhG5b
	aBcZAjQR/ReuL+wv+pmKcN09F8kjf/gDztZXfwe/V6iXYMpbNKNnfrmTmxyQHzAF
	I+4QSWdW0ksVx0p8BnRrQ==
X-ME-Sender: <xms:qmiHZmjPgr9qeWyAiuVBq-Its9bprHOyeD-ZAXW5qONEEjSjEhXkRQ>
    <xme:qmiHZnDb37ykZ49n_0v2Qic9_nCLzIQS4KdJcqfZMRUoB50rYl6KVs4t3DmYEQ2Ov
    w_-SY-CwZmma-C40tA>
X-ME-Received: <xmr:qmiHZuFmF-3bd6ipWcP1fvWqDM37rAT9bPMG9XY-BT0a0Vns_dcfF9z-BoEEc6V69do>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefhueev
    geffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:qmiHZvRftDOCST-8yshrW26dt-EPvlDUf6jk_6TenZEXh8s8YOwK2Q>
    <xmx:qmiHZjzXNVtKD6BQhm6nFUlsNK0XiWt0vWlKX2lNz96v1c8sxGsvZQ>
    <xmx:qmiHZt4ogykCY-7EGLriZjFDjwOA8mVw0RO77tFnasvRIfbPQ6Q_1Q>
    <xmx:qmiHZgxs1SbDWAocNPwda1ofzIVKYE9CDype4tDMkUKBh2lJTFVCTg>
    <xmx:qmiHZqwhtxXAgf_Q4mNTjFPlwXFWsZh99TdHM-iqEg4vZAqOY4nGrvKE>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jul 2024 23:29:43 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 05 Jul 2024 11:29:37 +0800
Subject: [PATCH 1/3] cpu/hotplug: Make HOTPLUG_PARALLEL independent of
 HOTPLUG_SMT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-loongarch-hotplug-v1-1-67d9c4709aa9@flygoat.com>
References: <20240705-loongarch-hotplug-v1-0-67d9c4709aa9@flygoat.com>
In-Reply-To: <20240705-loongarch-hotplug-v1-0-67d9c4709aa9@flygoat.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1463;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=BRkcuXQ3cJedwbfmLvfBW1dIeZpS3I+xSxBwfNpvU48=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrT2jCX5mVHtJSa8tf9tjkdxrA2YVyd13oZDKCss44b1D
 5EzTw52lLIwiHExyIopsoQIKPVtaLy44PqDrD8wc1iZQIYwcHEKwERCrjL8M18la9TmaasySfHl
 nnUXF72+fO3tJa0FK/9uMN1n8VlKcwHDP4PvP94d+xVufE3unIqu09n74Y5d63zuxtaxJj07c/D
 oND4A
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Use ifdef to guard reference to HOTPLUG_SMT symbols so HOTPLUG_PARALLEL
can be enabled without HOTPLUG_SMT being selected.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 kernel/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 1209ddaec026..2ab3f68a1bb1 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1808,6 +1808,7 @@ static int __init parallel_bringup_parse_param(char *arg)
 }
 early_param("cpuhp.parallel", parallel_bringup_parse_param);
 
+#ifdef CONFIG_HOTPLUG_SMT
 static inline bool cpuhp_smt_aware(void)
 {
 	return cpu_smt_max_threads > 1;
@@ -1817,6 +1818,7 @@ static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
 {
 	return cpu_primary_thread_mask;
 }
+#endif
 
 /*
  * On architectures which have enabled parallel bringup this invokes all BP
@@ -1837,6 +1839,7 @@ static bool __init cpuhp_bringup_cpus_parallel(unsigned int ncpus)
 	if (!__cpuhp_parallel_bringup)
 		return false;
 
+#ifdef CONFIG_HOTPLUG_SMT
 	if (cpuhp_smt_aware()) {
 		const struct cpumask *pmask = cpuhp_get_primary_thread_mask();
 		static struct cpumask tmp_mask __initdata;
@@ -1857,6 +1860,7 @@ static bool __init cpuhp_bringup_cpus_parallel(unsigned int ncpus)
 		cpumask_andnot(&tmp_mask, mask, pmask);
 		mask = &tmp_mask;
 	}
+#endif
 
 	/* Bring the not-yet started CPUs up */
 	cpuhp_bringup_mask(mask, ncpus, CPUHP_BP_KICK_AP);

-- 
2.45.2


