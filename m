Return-Path: <linux-kernel+bounces-519896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C95A3A34A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98CBD188BF50
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2351126F460;
	Tue, 18 Feb 2025 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="UgXZQfso";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZRd3b/jt"
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5720E26F45B;
	Tue, 18 Feb 2025 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897786; cv=none; b=kMrOEUNGmdmvzgcovNVjsQ/0C03oeEOJvAVxRne+pLCLGBs7jy9/NMTNRA2Vqs5qVJYmxrnO0mc2ivEQ7NLHWIW6ucs0KMdgDuhLpawC86Dj4sqlBhspM3kqzMuoaC/4enR28T9Ob1t5h00cfbShzc/mGW9wdcJLR8oNb0E9i9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897786; c=relaxed/simple;
	bh=6m4usxxNmRhsT+xpRwZhp0FK77JkJIcmIi/FhpxNMRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZLZlSCJJ17Xj2iRPb0e7ByOGnAXVHEHc2m+YS8tFksA9fqfuzGJM7/bPuxDQcEZITyry54ZuaEeJ/QbCLALfQ2sNfjqnAiTsluGvgiJ9JL9KXx4EUq7xNYv0OKG1ZLTAAf5ZR2E8Dm1DSclFpEI4hAUxb+P15KVxU+v2Ms91dcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=UgXZQfso; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZRd3b/jt; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 060242540120;
	Tue, 18 Feb 2025 11:56:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Tue, 18 Feb 2025 11:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1739897782; x=1739984182; bh=YAimL9/MtxGqFmKWSu1QiM4kmZSk0e/L
	YupNttACQWU=; b=UgXZQfsoGDr0JmG6rD00RKfOl9x9wUdNo99MozfLSw0Xz6aC
	ih2Vmv9z+rxnTSrBSjQ1WT/a1dKKqMlYP+9nMDrSeOc3XcDbarba3aEIZpXqR6LD
	Xulfu/G4OYKwMB7vOdBR/6208YGJ0631wgJuhCb8IpBBXnYxoqn3szE9YjjZNtOw
	1IN0K3Y8rxztC7h3fGSSsxr8TLEGXX0uH5SP7iO//AlmKx4nhCmMfulUt2UctLOv
	0IKUdn5nlt+jNkKZPwc26vKGT07Q1SsQkpSjnu9i9SXD+otnU0C1/yZYiqeZtYcQ
	VHPcbUzAAhORwXvi6ZGWbMMG0FPSU23HSTCu4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739897782; x=
	1739984182; bh=YAimL9/MtxGqFmKWSu1QiM4kmZSk0e/LYupNttACQWU=; b=Z
	Rd3b/jtbRv1kySJ3A/5N557ZW2ve1EdULgyZDuTa+7dJV37pWnN5Nq9IufKhCtrw
	lqT+ofK0iy1ouNM4LdvbNdKxg7g3ybIIkp1hVmNcCmsTDAmKmhw8+4JF5dt/Ehb+
	RlAkKq2mSZBvKOE17yzwobKRjDUmVZ/69zehu4Qa3hiX5VrmtJxprSFQvb5JFesm
	LbJTdxXHb5EnPmLxH1oFIlTpzw0Qbh8xAxb6jl3f/V3gztQFgFO++IGRz757k84V
	7vf/tF/8KkBuyA4l4/07SaRH1+hwhZECRP2qJ1yaAybT9gA92Cm9jBvLYmNU7vKy
	ETLsU/yhThMvSI/9E9FOw==
X-ME-Sender: <xms:tru0Z4vRQs_ew_uwfujeBZ4OVfoRHEmv0BGyklBEneDheC_mSsrQfg>
    <xme:tru0Z1c20EWfB3cDxeuzxItEgws6wrgP2tRkC34Mjm6aoXeNL2MKwiThdZXGTo-e6
    H5fvWJD87nXGjq_X6c>
X-ME-Received: <xmr:tru0ZzylDUxmbPr6O6q07Ryd7BNjP0z-fk6ekT4Y7yNZgQiBBToFe9F4DVXJWhRaenx9sXQoxfjSEUICTiCoKG4r7q5uqvNHyeT4Ne0Qx6n8R3QYBc_UUIBOkz8t35Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepufhvvghnucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrd
    guvghvqeenucggtffrrghtthgvrhhnpeegieehffethffhffefhfehkeevleevieetfeeg
    keehhfeifffgheehieejheeihfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdpnhgspghrtghp
    thhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrtggrnhesmh
    grrhgtrghnrdhsthdprhgtphhtthhopegrlhihshhsrgesrhhoshgvnhiifigvihhgrdhi
    ohdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrii
    hkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjsehjrghnnhgruhdrnhgvthdprhgtphhtthhope
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvhdprhgtphhtthhopegrshgrhhhisehlihhs
    thhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvg
    hlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:tru0Z7OudkQCQ8WODg6XJL1rO10W8-hiEqwz5aZFyD56nkTDGyOG3Q>
    <xmx:tru0Z4_4xEomSJgPEIVZsZ1CLkQI3EpOXng9Rwh2QVQIgaFmGSIRTg>
    <xmx:tru0ZzXr6HP_yrFIp0cgnXu3cINy2wPrs1zvHIuMkVzV8fpkN_tRgQ>
    <xmx:tru0ZxdV99ouswqFWYT8WTLQhws84P61NKVPp0BJqdrzawqsmoiE9A>
    <xmx:tru0ZzXJjlwkGk_3CueBPM87sCaEvEzMjgbKpdvdm-rd9_xdHoeV6hcu>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 11:56:19 -0500 (EST)
From: Sven Peter <sven@svenpeter.dev>
To: Hector Martin <marcan@marcan.st>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@svenpeter.dev>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v2 0/5] Add Apple SPI controller and spi-nor dt nodes
Date: Tue, 18 Feb 2025 17:56:14 +0100
Message-Id: <173989773063.49326.4641316959057298883.b4-ty@svenpeter.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241203-asahi-spi-dt-v2-0-cd68bfaf0c84@jannau.net>
References: <20241203-asahi-spi-dt-v2-0-cd68bfaf0c84@jannau.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 03 Dec 2024 08:57:56 +0100, Janne Grunau wrote:
> This series adds SPI controller and SPI NOR flash device nodes to the
> man Apple silicon SoC dts files. Only the subset of used SPI controllers
> is added. Five SPI controllers exists according to pmgr ADT data but the
> commits only add controllers found in use on any of the devices. The
> parameters for the missing nodes are guessable but there's no point in
> adding them since no further M1 or M2 devices are expected.
> Together with controller nodes the first SPI device is added. All Apple
> silicon devices connect a SPI NOR flash to spi1. This holds Apple's 1st
> stage bootloader, firmwares, platform and machine specific config data
> and a writeable key-value store (nvram). Expose only the nvram as mtd
> partition since it has use beyond exploring the content. Tools from
> asahi-nvram [1] can modify the (default) boot configuration
> (asahi-bless), read Bluetooth sync keys (asahi-btsync) and read and
> write arbitrary keys (asahi-nvram).
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: apple: t8103: Fix spi4 power domain sort order
      commit: 1f7af2931158a5e819ac71bcba91e961ac5ca3ea
[2/5] arm64: dts: apple: t8103: Add spi controller nodes
      commit: 556cd4bbb45bb5a73042c02b7e5c982112a6ed1f
[3/5] arm64: dts: apple: t8112: Add spi controller nodes
      commit: 0a6d561c7e46bf46b886af209e8ebedb6d500680
[4/5] arm64: dts: apple: t600x: Add spi controller nodes
      commit: d08e455a865c99a8050addf4dc001bcfdf1b7b8b
[5/5] arm64: dts: apple: Add SPI NOR nvram partition to all devices
      commit: 3febe9de5ca5267618675650871a626d0901f8cb

Best regards,
-- 
Sven Peter <sven@svenpeter.dev>

