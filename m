Return-Path: <linux-kernel+bounces-252607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C15F39315E0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E8A1C21357
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D7918E775;
	Mon, 15 Jul 2024 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="E3KPs+yo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i8Cf1EmP"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2744518E767
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721050551; cv=none; b=qKpnqSHlh0ndNz4kiqWf2XSA+KX06r0KKGRAGMi/yLCkMTSkVHvLHcSjimfD1fd4RATKzutn23W2dHdx471eOt/qeU9z7vN3qVWUMUEq8EVNu76IpWIHX7o46Y9rtih0PVpu501u9IWsCeqvLqcE0V/aajDLALCI+VlKvKTqGYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721050551; c=relaxed/simple;
	bh=Q4Js0j6Sv3g87oah8phZc5hFd0opwGeKNyGx0qz8Jl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tQCPKsAT6zPsG/hRYg9xOyJy34Xn9hloY2X1I4hKQ9s1i80mknZHgIBRXE0K9WKUhVAboTWyixyHLI0oGtK/pXfwp7lXjskBQm8pmsDkqYHSnLJ93ZSb3Vc4ER8NZte+twHBD46sELUIwuL5fHESjSyJDaFQW+98xnTFhspvMlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=E3KPs+yo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i8Cf1EmP; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5A2011388BBA;
	Mon, 15 Jul 2024 09:35:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 15 Jul 2024 09:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1721050549;
	 x=1721136949; bh=l7AHCxMgNqzI1B/7Gr9EX4MgOWfEuaHkRWhzdciw6I8=; b=
	E3KPs+yoam9z/BXArKNUHnsEx4i5X1t2hbust0HTQOb4DZHArRtFBcyKX+zlS9h7
	EOAsYJaiXfnI4pKnMfJ3yPuk0uIIgChHlWW7P87BUN4pX9ZAiFHThctEf2Hvf811
	Jq2wJxyi3Qk3TnVdYl2CnZR3w6jSsCzKm55HPQryWIdxyB+KM52ef4Hd3PsjSDu1
	DhhFSxYCHlJ+3CEqkgBOMkHYAUlDKrdRgg+i8j2bO2W8Gb7dEKh1UG95OGhyClvI
	dSZPctjCtKY6mKQnxwqhzLwGb9A9j1NanyQbvrylepa+c5RDH5T1TXI2NtITYks0
	hYmRb7wv0RjjDsYS35lSZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721050549; x=
	1721136949; bh=l7AHCxMgNqzI1B/7Gr9EX4MgOWfEuaHkRWhzdciw6I8=; b=i
	8Cf1EmPbu8csqvieJsGScTW1n2stTmX0FD6sSRxkDjtCuUdJKsuVORn2ahbT6ux/
	erhezKhjU/Nj1z3NDvPDblkIIRd/3QmxMJjCg/zNV/ah5jD1QUE83L1dHqIi5tEc
	nxnNCqIb9he6hCz5GIYYim6VExs4h4Q4bDuPCsm6zM8ujvDkJXGN8s0ThoKRkmUX
	QY8l7Tt2Mba9/0ejoGx0JfR8M/UI1ue5kxh7D2vViARQ/8yKWzsyvTWI3ZJh224N
	wmXB28XMymJcu7xEBx/uEJSaI6B4vPK//h4tZ5sDOe8WDZxErSDQkJyzCvT+sYLt
	HWqTfgkcZDGkQCJ0o5/bA==
X-ME-Sender: <xms:tCWVZgdgz6Qabo-bd0RoJAxaznctEq4Bu-lQ-dAh0X6ZM6Tgq1umGg>
    <xme:tCWVZiNJ_FxTTn2rIdzHN8blVH7zOrfVXXqj-3BxzMPw3_eEzqwF8e0LYHD6_wIlz
    H_QNb5wGxGUkPpJ4ew>
X-ME-Received: <xmr:tCWVZhjuxP7xxpSZk8N5ggHLWi5Ylwvpp90G1IQKX5x7ekDIrNO6SdYt5NngPzze831C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgedvgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefhueev
    geffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:tCWVZl9cxvrRb6Wz_7CNjaT0dgKqgzRrjr2hHzpg7c6_VzQLg5pCDg>
    <xmx:tCWVZstySsOSCO2caMXd-86ebTa06F1dbOXyPcEdz2rMtHYEo6ziVg>
    <xmx:tCWVZsHe32f4DgFoB3kBbrYS126KntHVgONcCU8FYyMyHX8Q4Ffy5w>
    <xmx:tCWVZrPP_IahX-8cn_0LJ4BiKn06hmjHi049LOvNHQMCC9lo4xFqLw>
    <xmx:tSWVZh9i5sod970tTIhO_3CYyQbI3JC-Zyx7APgpAqi49U535RIeeKKk>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jul 2024 09:35:45 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 15 Jul 2024 21:35:29 +0800
Subject: [PATCH v2 2/3] cpu/hotplug: Weak fallback for
 arch_cpuhp_init_parallel_bringup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-loongarch-hotplug-v2-2-7d18b3d46b11@flygoat.com>
References: <20240715-loongarch-hotplug-v2-0-7d18b3d46b11@flygoat.com>
In-Reply-To: <20240715-loongarch-hotplug-v2-0-7d18b3d46b11@flygoat.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=858;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=Q4Js0j6Sv3g87oah8phZc5hFd0opwGeKNyGx0qz8Jl0=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSpqiumPrpjmtHx9P+7HUsyXdZMuu/ytJpv3cXOw94Xs
 23fpNy531HKwiDGxSArpsgSIqDUt6Hx4oLrD7L+wMxhZQIZwsDFKQATSZvAyLDddPqaFx2btUVu
 /n0exPHc22h2+K1kf+FvqYbvbsR+VxVk+GczubfhTK2zzB0+7v9P7706qfqeqXTtoq0K01WKlfL
 1NzMDAA==
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
index c89e0e91379a..16323610cd20 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1829,6 +1829,11 @@ static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
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


