Return-Path: <linux-kernel+bounces-241904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 488A69280EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 05:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73301F23D27
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ECD8175B;
	Fri,  5 Jul 2024 03:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="FrgP9JBX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g4imL+Gs"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D68061FE8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 03:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720150193; cv=none; b=XVI71MZ8tHfNTbPI84S+ghXaZNfLlLJlF5ikNhBlDNGvUSP0SfZpZryPrrLpok/bW00QJff2cR65Ksv0AHS0EFr5DK3gbzqdr+4IozYuXKBNGu/1dbhtaxGJTDT9Lis1SxHAZmAzyJat0d+qF3MUAMkpU2kluZKsg2kLOlbNj0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720150193; c=relaxed/simple;
	bh=ap83z2hao5ETB7IMT4XYK+cshK5GthXc5rVQQe+DQWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g/Vnpf1uoLof8QYTyOiXKWDnqnrVQgYiIVlkf+DmyckXj9/0K5TNs2O2kTgYwvNExGvdspKvuOWRyyk2mhUROAKR6wtWwm2sw9slaKLuVN4IpGGVloc/tKQw9CUAT1dqIiLCu+i90AY/JFMIB8vCPA4G6csbWHpTuk5ur/z9ApM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=FrgP9JBX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g4imL+Gs; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5109E1140218;
	Thu,  4 Jul 2024 23:29:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 04 Jul 2024 23:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1720150189;
	 x=1720236589; bh=YFSpt6RnR2teXj06bgCnF95X5poqchuWW1uKJeAlhRo=; b=
	FrgP9JBXFSyzHnjPZERoD4Taxem/BWt5mZQ7IOxdusi9syXkaxc77SCvX0qhbJTO
	Kbd4VuVmThvJhp2SY0oDBqIcriZFBfpUFGbJ2i0MoqTk7GZ1MP5vOEKTe0q/IBzd
	/3g7XyvUjfpldYUytv+Ikyf3PpzpKef1mO0MA/2qLJHjE1LoIVw8hIDzrwIi5GQy
	3jkFqPPSuIKRJECjq26tcHcyhuFoM+N4+xwR2zG6N1miYNXQleP9n49n14JrltdQ
	Bi0Tq7zge9pybZZPnHN+F5n1oWd+2xdkAyawZifQW8OlBJvYlwbdn7cTsdgL10HR
	IWwnsfqgwL8AuWzDaScSng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720150189; x=
	1720236589; bh=YFSpt6RnR2teXj06bgCnF95X5poqchuWW1uKJeAlhRo=; b=g
	4imL+GsO23B9OVVgepuHaPEJs+PmmGK96bf7xPr7psL5s9wGKtu7KT73wOQYCgx6
	Yj4zqMlkqMFpFiUH2tWub6mvwyJkNdeaqV9IveUI025xrQTqbO1Hm8Kl4+PkRUkn
	VaXxXHljgRcj6W2PnfV/dW8aSyjGfyAXZWiFMCB0AQ5hi4/GqhSE7DOuXkhRg+yl
	ZxvmGR/6Q0/kQXax9bfbM3U9m7vJykRQEcb8ol731LKTKRyCQ9wclWyf+9eNwVG0
	s9QSXg4BzOHC+36xYLJEomETNe0i6B8f8WRp4AGD03GHuT3JrzhTsKPR9GksYmzb
	VWS58iMkw+Uwxnub0DcSA==
X-ME-Sender: <xms:rGiHZq2h_ysvSaBLkcO6FNTRJ48Ga3xbDjwM_eNyl_x9dfpw22pk4w>
    <xme:rGiHZtFgi8Dz9npCDaxyipc1XWNNwA-NfPFcFKCpjs-CZnCMEnaEKeUk3leN1ftOg
    JNoSiwJrXXNvDMZ7FE>
X-ME-Received: <xmr:rGiHZi5XYKquW0F_NXGvelB5CvFJc4DnWpk1M3K67eTspZDt4ukgieUd4mRLXRFY5wU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefhueev
    geffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:rGiHZr3eo6BvNPYjj7wm7IrO37kQzWFbyL13QeAcGTGFokbIrqZv7g>
    <xmx:rGiHZtFoYxir5OkC_viLY39B4UOlkyIYYqP-uXKUcWVAs-P1AfK6Dg>
    <xmx:rGiHZk8DEhIC8Vz8dFy8YFqlyF_i1oBcMcQZihLbAzQF3rurEeLz4A>
    <xmx:rGiHZin0FeLMMvcUqq9-ckQAooRekc9YEPLWAHUVNmG6QXbnx-7CHA>
    <xmx:rWiHZk3BQiu97tMlrk8p3GTgr66fznSg9u5jEThf7Rv3t8HRzH9Ex2rn>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jul 2024 23:29:46 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 05 Jul 2024 11:29:38 +0800
Subject: [PATCH 2/3] cpu/hotplug: Weak fallback for
 arch_cpuhp_init_parallel_bringup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-loongarch-hotplug-v1-2-67d9c4709aa9@flygoat.com>
References: <20240705-loongarch-hotplug-v1-0-67d9c4709aa9@flygoat.com>
In-Reply-To: <20240705-loongarch-hotplug-v1-0-67d9c4709aa9@flygoat.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=858;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=ap83z2hao5ETB7IMT4XYK+cshK5GthXc5rVQQe+DQWk=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrT2jCWlx9xF7tRkWK7ZKiEZ8muHlVTnisuZHa3zz335P
 X0Nr/7EjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZgI2zVGhskf9HUOXb9td0lk
 5aQp2z875/qYvdK15v2+RPrkNvN2pcMM/9S7Lv55tSVJf6qKX/hiQc0qppTFNlMf97y5q/PO3Nd
 tCRsA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

It is a general assumption that architectures entitled to parallel
bringup with CONFIG_HOTPLUG_PARALLEL do expect parallel bringup to
be available.

Provide a weak fallback arch_cpuhp_init_parallel_bringup function
to match this assumption.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 kernel/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 2ab3f68a1bb1..c925d0f4b0c8 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1820,6 +1820,11 @@ static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
 }
 #endif
 
+bool __weak arch_cpuhp_init_parallel_bringup(void)
+{
+	return true;
+}
+
 /*
  * On architectures which have enabled parallel bringup this invokes all BP
  * prepare states for each of the to be onlined APs first. The last state

-- 
2.45.2


