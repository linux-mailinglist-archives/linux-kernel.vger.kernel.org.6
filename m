Return-Path: <linux-kernel+bounces-420216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C7C9D779C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 20:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C62CB364EF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCDF14A088;
	Sun, 24 Nov 2024 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="SFcF02ZV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LVVY2pME"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999E013C67C;
	Sun, 24 Nov 2024 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732471034; cv=none; b=iyqxLlw7h1adVvL76bkNiLpICMNLsMGPBvdvbpc35AIpc/inwWFaoj4/1S7fXDtMmRUaAvtCRHxaxoIPeIG9F890wKBLiTfLIl7T7iE7tt7Va/H+D6TJVcMtpdDnuS7muaW+ujGFkFMt9K0jjeJv/TIDYFYZA6t209KxUeL/puM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732471034; c=relaxed/simple;
	bh=AoEYjMpCajo5+LVgExvIA8kQRuPmtSTPy30HlAvW1gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D+6CklfYws8PbGOZmWxN79qTxppMNlJQq0Egk6IF8wlzu8WZhGEo96OrQMNJTyhSAOYyrk/mwnhRLgO+4rUvfZhhTmr4Qir0gdGX8HQjpBiwIgnNHCjJSZ5wiF6hqDJtUUOHGokbsAhw76ntmlexioQsHMkpxk+VCe93+9F+/o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=SFcF02ZV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LVVY2pME; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9D86213800F4;
	Sun, 24 Nov 2024 12:57:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 24 Nov 2024 12:57:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1732471030; x=1732557430; bh=PsTjrP/zN41TGyrwJbyG0
	aUjZNZR/ScZKsMHHcShUo0=; b=SFcF02ZVRnIOjHXLkFXTZn+EW2a1u/wti3xDg
	2RvIIcyXO9thMqNVLMK2lwt7Ww/NpKDTXZs0J0UjDIwobe8hrjycw9eHvMueSvkR
	lp+jL1YnMnqygKtYhnR9vjvgAhPpOQuF530GDWrX5evp2w3fO5+wfi8xcoa6ZFDb
	Mzn5XiMJK+i/0D25bZIVCVWgyJGLjIkL4Us9JV7mBjip2yA6kkqWGIjaHh6Viqq2
	yKjq8fEnrmBvC9Ejd7zZ3/wQidgc8n7o1gKI8+DSfi96qAnYwpee1KVsHOVfLgav
	EBJoxbb/xnnD6ohk4kWQhA/URPqCLG42dShCZaeModUUHyglA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732471030; x=1732557430; bh=PsTjrP/zN41TGyrwJbyG0aUjZNZR/ScZKsM
	HHcShUo0=; b=LVVY2pME1KMQV3KQQG1v6EV8YQvd5SZvu2FDqzaXuZQ21/VmeCS
	S7MfPWUNLp1SrGGAwhH7Yks85zWJyXBtYfYdQBYe/BGiuVnSShErR31WQZwjSQMY
	xWdZnpgokSDOjV7OzAFKcxvat30rSusowyzjzozFJjnzVUPe1+rK3qjHO/A3q26k
	Yq745UKGuMMs7j61my3qVD7BfvUcs307XYHs8OPuVaStOtcSAQAfeZS0bUO8Iknr
	g5brspR7zkT8ZYtzw1CGi0K2gtNm0hPPVbBYv4oEDnY9Z8VvU2XFH9lGKH2w/r3P
	hUZFZwAMFFjnBjl1LizKr4VEBmg0/DYElOw==
X-ME-Sender: <xms:9WhDZ7bvjRPO7TsMe6n7ByV65EORoxcBcaNSY1QYpyT9KIvgPlcpiA>
    <xme:9WhDZ6awivCEXngBZKoSbyY-BEq8x2ITVPJQdfM-cjTq_bPmAhmTIrsmvl6IGMKxk
    JWVXMqdqk68hFHEaQ>
X-ME-Received: <xmr:9WhDZ9-yKsrHfAQmMvS8QxGF9v4SofKdBVzv0SL9_G26GRg24okIg71K_DWbrDlwqCkPid23v0QISFYEjARYu0DSbtfY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeefgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrf
    grthhtvghrnhepheekgfdtveettdekuddugeeugfdujeehuefgleegtedthfffudfhhedu
    hfduuefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    ephhhisegrlhihshhsrgdrihhspdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlse
    hlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghsrghhiheslhhi
    shhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehmrghrtggrnhesmhgrrhgtrghnrd
    hsthdprhgtphhtthhopegrlhihshhsrgesrhhoshgvnhiifigvihhgrdhiohdprhgtphht
    thhopehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdprhgtphhtthhopeguvghvihgtvg
    htrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9WhDZxrvWf0HJPlprkcU5lnN4jwaTtUu-HI-ch8GLdVHVE23VT-u0Q>
    <xmx:9WhDZ2ruV-BRnbplcVWHv0LzGdKc-ZDit0FyrJUQEtzVHG1EpQl_Jg>
    <xmx:9WhDZ3RbQrw6auqmQRzCeO5WN1HKUllulWWELWDft4Ug-x4BgMh4NA>
    <xmx:9WhDZ-q5-B_ZbCDiqAxRR8nm-2xmFgxaa87Yd5bW_baJ58ztK1dXDA>
    <xmx:9mhDZzjvnv4bavyDmMnm8P7Cu4JUAH-O8IX-672Awuc0VwC_9rXz32Bn>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Nov 2024 12:57:08 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id E2160A8A6; Sun, 24 Nov 2024 18:57:06 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: apple: t8112: fix typo in comment
Date: Sun, 24 Nov 2024 18:56:19 +0100
Message-ID: <20241124175619.230330-1-hi@alyssa.is>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

j493 is the M2 13-inch MacBook Pro, as specified in the model set below.
The M1 13-inch MacBook Pro is j293, and is from 2020.

Fixes: 2d5ce3fbef32 ("arm64: dts: apple: t8112: Initial t8112 (M2) device trees")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 arch/arm64/boot/dts/apple/t8112-j493.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/apple/t8112-j493.dts b/arch/arm64/boot/dts/apple/t8112-j493.dts
index 0ad908349f55..10f7c635e4d5 100644
--- a/arch/arm64/boot/dts/apple/t8112-j493.dts
+++ b/arch/arm64/boot/dts/apple/t8112-j493.dts
@@ -1,18 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0+ OR MIT
 /*
- * Apple MacBook Pro (13-inch, M1, 2022)
+ * Apple MacBook Pro (13-inch, M2, 2022)
  *
  * target-type: J493
  *
  * Copyright The Asahi Linux Contributors
  */
 
 /dts-v1/;
 
 #include "t8112.dtsi"
 #include "t8112-jxxx.dtsi"
 #include <dt-bindings/leds/common.h>
 
 / {
 	compatible = "apple,j493", "apple,t8112", "apple,arm-platform";
 	model = "Apple MacBook Pro (13-inch, M2, 2022)";

base-commit: 9f16d5e6f220661f73b36a4be1b21575651d8833
-- 
2.47.0


