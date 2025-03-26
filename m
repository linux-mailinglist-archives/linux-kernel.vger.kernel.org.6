Return-Path: <linux-kernel+bounces-577495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D38B5A71DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595D4167D09
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD3623E332;
	Wed, 26 Mar 2025 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="dhLqSs8D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o1lA6Uqt"
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5619246BF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011955; cv=none; b=rGZsv+mTFX2qIF3n47zFSdQ/3AeIrt+NsLgSzd3WuEIVlus3HE/qlthT/0YGdjMcwnw8PiL0Ay0ShONaiyqsNgVvV1fMuxDluHFzW3oYPS6EuYluuSLdp5Sa69S1CqpAXT+a1sZMiD2cM412nOBDTVqGCxEVbT5eOWzUlEaD0xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011955; c=relaxed/simple;
	bh=1wJZtJcA231/5rdekLdowq+LaWaUkK482BPfA9qzTRM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=RF7QIqDvpprWD/9xcHlJm0fkrMhzLVd8fbw4uW4VCIdekZzwD/ebcMZqJs8K6ifgMcK8KZn6HHGgNb6fti6Xu9FBKyesVQIU5DDBKKUUNfZAzzYarFDgA9bVKMnFQntr4//GU7/mRj4soM7OafGXkJBMUV57JJ7q0QL9UfqTKAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=dhLqSs8D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o1lA6Uqt; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 50A171140159;
	Wed, 26 Mar 2025 13:59:12 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Wed, 26 Mar 2025 13:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1743011952; x=1743098352; bh=+n
	NwjWzuvNkREHvvhvrO0eWUH9hc78f5a/5U12q4Geo=; b=dhLqSs8Dx4HmtnzqHo
	WT9tMYJ56QcYmspFLoPDJP06hKHaqRIQ6/enR5vOdotiY/FHC3tJSjiwQTtdKlCN
	spOUuinfHaGy5dojne5iqfDIeNj6XsPwmSij5c2OcsRsSRdW89PceEwip3wHxf71
	lZlqfu3qCLo0gt98HfWToYw1xfm0KV0M9eJ1RV3YwipuS8zg0ZBve+syMI+OJRiz
	3erSUATSafjPVnQ7ZCpDQH3mrsMTzjCogleolNt66f/reUttBNSyTNG6QWIjWkkw
	L0tnMhMA3G7KtiHvUMK6DAyyR51ojE+LTFiVukNGnwTKtRRVPS7SLB1tegcHchKp
	vomQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1743011952; x=1743098352; bh=+nNwjWzuvNkREHvvhvrO0eWUH9hc
	78f5a/5U12q4Geo=; b=o1lA6Uqtp4ptLbg1ZvB2oPp5JENe4g71FlV5Oe12yMoU
	uwUNa1D3JMYVZo902OPblrpBqFbPqADOYZn/mMEfYX7FVOwVMiJVHIerHEcGefKP
	Dfqqc06ThvxKIP+A38iywCCniIluribv/lugfqA1bHVnX53huoH+AJq9jAW/pk20
	3DzHJ6YJlsGSN7MkYtv7atX0q9R8iH8mRbDcWDe+3Ls5uVVm64kcapgfA7KLCcOp
	AhC813FnORc577T8/OmQRzxoAK/2C1oT40vol4AC7rFUgAfsCp4VdNcjKj005s50
	JhWCvRgaywAvqlSuSOl7aJPvDvE6GxucGz9+u0oPMg==
X-ME-Sender: <xms:b0DkZ5ul_BsbNOD6BQRaIAfs7-BnGEqf2nXlVoEPa2iQ4zhXtpQWsw>
    <xme:b0DkZyfhNUTvWTeYYOsByAFrtR4abtQtvGPYwwBq7a529B43pOVpIHVe1LpoFf43u
    O9RZsRfuZO5cQZNYIk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeiudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkffutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepffffffehuefgfefhudevgfelieejkedtffefieej
    tdfhvefgieeiveejueetfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqd
    hfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghr
    nhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsohgtse
    hlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:b0DkZ8w_jsxseN7UOMPTyF0-gD6ce-KOYK8NnkgDHnZklv_MLaKreg>
    <xmx:b0DkZwPe1eJMYCxfRUIDlYW1QLXCiR3LDN4PReguRdKRSljhsSJwqA>
    <xmx:b0DkZ5_9jTusg8zwzjNGItnYRFRbUWaijqrgqxjY8SMwXpOqKJ2ULw>
    <xmx:b0DkZwVzzB4q51t_t4xL1jO2iOJDlaXBZ7mehw9GxQqGoPSCFSRgvg>
    <xmx:cEDkZ0ZULJQ5O0lotlhr0XWi2MoyHu4QQguYbUC7BiSgkttNUbEeQW68>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B87142220073; Wed, 26 Mar 2025 13:59:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Mar 2025 18:58:50 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 soc@lists.linux.dev
Message-Id: <1ef00af5-0196-46c4-95f3-7c6b90f3e293@app.fastmail.com>
Subject: [GIT PULL 0/4] SoC updates for 6.15
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

These are the majority of the SoC tree updates for 6.15, with a
handful of patches still waiting for a build regression fix.

There are a total of 658 non-merges patches from 165 developers,
the most active ones being:

     29 Nick Chan
     24 Sudeep Holla
     19 Krzysztof Kozlowski
     19 AngeloGioacchino Del Regno
     19 Alexander Stein
     17 Quentin Schulz
     16 Michal Simek
     15 Frank Li
     14 Ryan Wanner
     14 Rob Herring (Arm)
     14 Ahmad Fatoum
     12 Oleksij Rempel
     12 Ivaylo Ivanov
     10 Tudor Ambarus
     10 Markus Niebel
     10 Jimmy Hon

The overall dirstat that this time the largest updates are for
Apple's T2 BMC based machines, as well as boards with rockchip
and mediatek socs:

   0.1% Documentation/devicetree/bindings/arm/marvell/
   0.7% Documentation/devicetree/bindings/arm/
   0.1% Documentation/devicetree/bindings/clock/
   0.1% Documentation/devicetree/bindings/firmware/
   0.2% Documentation/devicetree/bindings/soc/samsung/
   0.1% Documentation/devicetree/bindings/soc/
   0.1% Documentation/devicetree/bindings/sound/
   0.2% Documentation/devicetree/bindings/
   0.5% arch/arm/boot/dts/allwinner/
   0.1% arch/arm/boot/dts/amlogic/
   0.1% arch/arm/boot/dts/intel/ixp/
   0.7% arch/arm/boot/dts/microchip/
   0.2% arch/arm/boot/dts/nvidia/
   2.0% arch/arm/boot/dts/nxp/imx/
   0.7% arch/arm/boot/dts/nxp/mxs/
   0.1% arch/arm/boot/dts/renesas/
   3.8% arch/arm/boot/dts/st/
   0.8% arch/arm/boot/dts/xilinx/
   0.1% arch/arm/boot/dts/
   0.3% arch/arm/mach-at91/
   0.1% arch/arm/mach-shmobile/
   0.2% arch/arm64/boot/dts/airoha/
   0.3% arch/arm64/boot/dts/allwinner/
   0.2% arch/arm64/boot/dts/amd/
   0.6% arch/arm64/boot/dts/amlogic/
  22.0% arch/arm64/boot/dts/apple/
   1.2% arch/arm64/boot/dts/arm/
   1.4% arch/arm64/boot/dts/exynos/google/
   3.2% arch/arm64/boot/dts/exynos/
   8.2% arch/arm64/boot/dts/freescale/
   0.4% arch/arm64/boot/dts/marvell/
   8.0% arch/arm64/boot/dts/mediatek/
   0.2% arch/arm64/boot/dts/nvidia/
   3.0% arch/arm64/boot/dts/renesas/
  14.6% arch/arm64/boot/dts/rockchip/
   4.5% arch/arm64/boot/dts/st/
   1.1% arch/arm64/boot/dts/ti/
   2.4% arch/arm64/boot/dts/xilinx/
   0.1% arch/arm64/boot/dts/
   0.2% arch/riscv/boot/dts/
   1.4% drivers/firmware/arm_ffa/
   0.2% drivers/firmware/arm_scmi/
   2.6% drivers/firmware/samsung/
   0.2% drivers/firmware/smccc/
   0.1% drivers/irqchip/
   0.1% drivers/memory/
   0.2% drivers/reset/
   0.4% drivers/soc/apple/
   5.1% drivers/soc/mediatek/
   0.2% drivers/soc/qcom/
   1.0% drivers/soc/renesas/
   0.3% drivers/soc/samsung/
   0.1% drivers/
   1.2% include/dt-bindings/clock/
   0.6% include/dt-bindings/reset/
   0.1% include/linux/firmware/samsung/
   0.2% include/linux/

New SoC support this time is for variations of chips
from ST, Apple, Mediatek, and Microchip and AMD, as well
as the Morello chip from Arm.

      Arnd

