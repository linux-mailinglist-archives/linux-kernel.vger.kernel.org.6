Return-Path: <linux-kernel+bounces-553098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCDBA583CC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 12:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183FE3A8EE4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 11:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA651624F7;
	Sun,  9 Mar 2025 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="PQU72ehj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u9EwQZBU"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0DB2CCC0
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 11:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741519950; cv=none; b=bQQ/hssfYfK+sJiWFTaW+UdpRB14FidJ/8hYsoEUpyPl9NH42C62bmRaRaNWeFtd9lG0l2s/aVh2bkpVJZE9sGcSSVuqGRUTaNPI5QR04NAWZWMJfPh7RiCe3n0wWJniyq7vTlZWyTzPTmz6YdQMWlD5Cu3E7orhGN0Mf8alPq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741519950; c=relaxed/simple;
	bh=KRY3h/y6Mm8gGXlg5rX8HYhOitbw1P/955MyYYkxzMo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MAVQStXGjbhY4FEfIoLI1zYLmfHyfmRIelyjNtbtKWLbIaUObKFC2xmb228DURQzmXRGU1SILxUJNxvXjSYAdJqAPSqlDKWMpIuaKLVAIdYbL/Kbu8mZGn93FgSewaY2IJj3hgu27VLLuySvH56KZ0sA5ZaS5IpsMk9Jj4usm3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=PQU72ehj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u9EwQZBU; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E2A9138277C;
	Sun,  9 Mar 2025 07:32:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Sun, 09 Mar 2025 07:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1741519946; x=1741606346; bh=Cp91pbB5DN
	2RZua8Qzi2EZ3MeEoU2r2L7P3lFPNnfBY=; b=PQU72ehjmMOLtRay+y0HSuFSMg
	CJsQjmj6Xxn6dAsD2MFECU4nHG3PRAqH33ktLvgp+dmlQ/GP0K/4jDbL6Z4Lk4y9
	ZWSD0oWQPitmZjueSe4B6BcuN7qHQwNfqLUxwrcUKv3NGqEtg50EIj2l3hxb+9Qn
	gDd+3UEyeq2hFr/J2GhWBjwuxpvAF+7KAlKKTBwiPfA8XHy5xxsQ8zOTWPVmAmhv
	b8qpo4UiCGJGkCs7a6cZ2pgogE7myPTBIa+06uwRqQTO1NknO4DqVK83pUK60nPN
	a3jIobf1fNhkLjfSSQ0gSMWdXt11eRpEGn9cCtuXzsK94FXzhUk6zba7ti5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741519946; x=1741606346; bh=Cp91pbB5DN2RZua8Qzi2EZ3MeEoU2r2L7P3
	lFPNnfBY=; b=u9EwQZBU2ecARqRlwjNuXFotaZQIfFKVF7Eve4ypZ9BjdIUJaqA
	a90V7dnjKUAStnU3atPwt1EvftBMCJqYpHufat0JVN/bZZ0ZwgKCL2MYq+Z+FSXf
	cfa8bIgtc6KooCCoW30Rt8BrPmuAiN5vM/Lmk//qW7cEjcCKqb+4cqR67EDbn6s8
	v8dug2SMkcimAmg7Fl9qVkNtBQbjZnl3zgFmNWyyzrB2cWKxcBlOx9FrV8jI/kvh
	caxMTxA3Xf4XG6tRXJRVVr1nPorjW1DNedzyp88+ySdqtCd+IoXydxG1t+4/A9qT
	yDh7KpPCxy8XZJi92JWXHFwFgonMHcffoAA==
X-ME-Sender: <xms:SXzNZ25iLS_exPE_cN1I1JaG2f1JDlX9osjrHo3wonjzmRjksf32kQ>
    <xme:SXzNZ_7YH0baFb4_jYaWuseCv0oQ1vvaTcnZ7kVRxKpTmQJSsWpIcTJ6579IXp27T
    FGxL6yyXwOrVDNkZWg>
X-ME-Received: <xmr:SXzNZ1fwC76ILiwN1yjLQJDR50RsJ-GhwvrWZZPfVK1wq_lMa_T2iYpJ47cFPJvPHK7hAoSV8UHIfYWXlm_md4frNjs28M7RplHrxpQDozOE7BiQNwmKAEWguVJMscw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgvthgvrhcuoehs
    vhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnhepjeelveffvd
    efgeeuteefueetgeeghfelveevheeugefftdelleeuudefvefhieelnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdgu
    vghvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hsohgtsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheprghsrghhiheslhhi
    shhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnh
    gvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SnzNZzLrGuwSnzZhhua0RIYir2QSycKhL4Nr0VfLVJi0kRiRSciAmQ>
    <xmx:SnzNZ6LUICEe7rI2mDX8zXiVGzm3kOFOU2awiOoGMZQgYT7OZvScHA>
    <xmx:SnzNZ0yxQpzmG6s-jypPAZftYb7FnRZjZRVgwKMfQCQV705_fjcRmg>
    <xmx:SnzNZ-JWXUCxzguKEGVoLSGTM7WlBUrGX1zMSR2-SAWCV5b6VnwCqQ>
    <xmx:SnzNZ_EfmoYfk3PkPkvj65VP3uGWSz83iIRnyv4w5J502ZWNWMMF9BG4>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Mar 2025 07:32:24 -0400 (EDT)
From: Sven Peter <sven@svenpeter.dev>
To: soc@lists.linux.dev
Cc: asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Third and final batch of Apple SoC DT updates for v6.15
Date: Sun,  9 Mar 2025 12:32:12 +0100
Message-Id: <20250309113212.48137-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is our final pull request for Apple SoC device tree updates for v6.15
based on the previous one [1].
Drivers for the M1/M2 touchbar screen and pre-M1 (iPhone, etc.) backlight
have been merged since then and this batch includes the required device tree
nodes. Both drivers and these commits have been part of -next for at least a
few days. The corresponding drivers are scheduled to be included in the 6.15
merge window as well.



Best,

Sven


[1] https://lore.kernel.org/soc/20250302115808.59172-1-sven@svenpeter.dev/

The following changes since commit 44db68dee1f77260d7037319e911e9883a6ffe0e:

  arm64: dts: apple: Add touchbar digitizer nodes (2025-02-26 15:33:46 +0000)

are available in the Git repository at:

  https://github.com/AsahiLinux/linux.git tags/asahi-soc-dt-6.15-v3

for you to fetch changes up to e1bc21d8f8fde47173073a2d6233f5faa4864cfc:

  arm64: dts: apple: t8015: Add backlight nodes (2025-03-06 20:54:28 +0100)

----------------------------------------------------------------
Apple SoC DT updates for 6.15, final batch:

- Added touchbar screen nodes for M1/M2 platforms
- Added backlight nodes for iPhone, iPad and iPod touch

----------------------------------------------------------------
Nick Chan (5):
      arm64: dts: apple: s5l8960x: Add backlight nodes
      arm64: dts: apple: t7000: Add backlight nodes
      arm64: dts: apple: s800-0-3: Add backlight nodes
      arm64: dts: apple: t8010: Add backlight nodes
      arm64: dts: apple: t8015: Add backlight nodes

Sasha Finkelstein (1):
      arm64: dts: apple: Add touchbar screen nodes

 arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi     |  4 ++
 arch/arm64/boot/dts/apple/s5l8960x.dtsi        |  7 +++
 arch/arm64/boot/dts/apple/s800-0-3-common.dtsi |  4 ++
 arch/arm64/boot/dts/apple/s800-0-3.dtsi        |  7 +++
 arch/arm64/boot/dts/apple/t7000-handheld.dtsi  |  4 ++
 arch/arm64/boot/dts/apple/t7000.dtsi           |  7 +++
 arch/arm64/boot/dts/apple/t8010-common.dtsi    |  4 ++
 arch/arm64/boot/dts/apple/t8010.dtsi           |  7 +++
 arch/arm64/boot/dts/apple/t8015-8.dtsi         |  4 ++
 arch/arm64/boot/dts/apple/t8015.dtsi           |  7 +++
 arch/arm64/boot/dts/apple/t8103-j293.dts       | 31 +++++++++++++
 arch/arm64/boot/dts/apple/t8103.dtsi           | 61 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8112-j493.dts       | 31 +++++++++++++
 arch/arm64/boot/dts/apple/t8112.dtsi           | 61 ++++++++++++++++++++++++++
 14 files changed, 239 insertions(+)

