Return-Path: <linux-kernel+bounces-534301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC71A46550
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791AC3B8D30
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA6221CC6C;
	Wed, 26 Feb 2025 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="hqQmJw3B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zFZVtVeR"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441CF21CC5B;
	Wed, 26 Feb 2025 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584292; cv=none; b=u5/70rf+/YDYWpwcU+bHtjSbVqQy34MrI+UoyCtHj884X7IyDMGu1hmhlfiquqR0Y1mzTTbFTlTu8BreJ8ZyggPfT/xFklOamx4SwGjuXvC6/ZBTn5gkuTHsrL8KHASLcNFKBb3mYZF3h97MUqF/v2VKCdJDAJMUvh4XT+Czd70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584292; c=relaxed/simple;
	bh=tcRMozX9e/qFFqOuAJP2caCl0qWMhOn4bApkOgqU7D0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2VxDXLiJ2afPIEwsc3jNslOoY4fwPZDNPdH1I2c4FXl+m8jkZLgYHHkmgQyqL52zwfEBzVfZow9Fk0u6hmQLRKneCWJ6wKuqiCGTDd6OQHBmpLkyMNf0XVuN5my8tn2BH8/zreP4RQEn1oWoS4e7Gf+NsfSXAmK8zvOzuuH8T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=hqQmJw3B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zFZVtVeR; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 2BC1013800D4;
	Wed, 26 Feb 2025 10:38:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 26 Feb 2025 10:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1740584289; x=1740670689; bh=7BRNNMSZ1nsDm78pbs23hdXvMS5Y1hQR
	DJsmGna8aKU=; b=hqQmJw3B6O87WgF9RFzJZuo2e90Jnbe65wb2PG/LOQpLYqpe
	sWyEpfnpa6ifghRlejdo51/t/YAyE8cEIW9CMwVrnnUvhzaFt3HFjluLR70+Y7yG
	LXn+TtcSIn+6irAmf29HOJOymWHNj3LZOxcpKw9U+GSSqEv09a8PNvR/h115ZGJT
	wcZjheM94RjwwOMgkeavH9gjv5pYwbbVCnP4UMPt32DG6OonHkjbn1AzCO1PycHd
	WbI8xu5jv+LkGTCdxFRLy4YeGObv5q2O57xEyc99Tggz7/6mfnpekcYQ4gPrIy9D
	OgTuKRQw2AyhFxe3Gm2chkAis1iNSWxCCH9OAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740584289; x=
	1740670689; bh=7BRNNMSZ1nsDm78pbs23hdXvMS5Y1hQRDJsmGna8aKU=; b=z
	FZVtVeRtpptHolXr5+BA3DBIHFIM9vZlizPH9VUwBkoxbNltxh9bJAHaR7QtMgds
	qf+6sjvYmJlNRlmeuuYLnhf7IOMZRXJDtlJWEVs1bWNTjGzwIjtYqlFvnieANcWR
	efl4Js9qYZPi52tLRugu+ZNEHdZQYRfhmOr7Qyk7WqPZDiXBZPTebHBumhc8mKZH
	2ss/5ac1fDcCvQZAV+b7kvskaJl/I5S012PnLQHCsZj7yHP7JI6hB21du+mHZT59
	IVpWuYTkuqiJvfJURr2qhssKgCZT8Qlipn51SR6rbzMcy5sy9qYdzScPJrdgm8Zt
	+plmOpjP5WbrZTwIWiyjw==
X-ME-Sender: <xms:YDW_Z3N_Xze10n7C5Jk1t24xEpByoRSCfc7H6tA3BL-LobH3rtXpUA>
    <xme:YDW_Zx-yJOCDw9VGxDLqFu6YHFJRW5YBjC9R48hG04ddBx87-HMuWB0MBaHreE_fG
    zcYwxTKLQXiyZhZvgw>
X-ME-Received: <xmr:YDW_Z2QJnHUMzk7K3XHy5rzUWuV9FbpZwTQuXcD0efBt-cM0M49joT2TYcvXekqh0IBvUltTUImYCTWAWbXKLYZ4-GLssxQOa_6LN_JfJdDjT-xlXdA0FcfUyWsXg5s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepufhvvghnucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrd
    guvghvqeenucggtffrrghtthgvrhhnpeegieehffethffhffefhfehkeevleevieetfeeg
    keehhfeifffgheehieejheeihfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdpnhgspghrtghp
    thhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrtggrnhesmh
    grrhgtrghnrdhsthdprhgtphhtthhopegrlhihshhsrgesrhhoshgvnhiifigvihhgrdhi
    ohdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrii
    hkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehfnhhklhdrkhgvrhhnvghlsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepshhvvghnsehsvhgvnhhpvghtvghrrdguvghvpdhrtghpthhtohep
    rghsrghhiheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqd
    grrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-ME-Proxy: <xmx:YDW_Z7tD8-h1Frp9eX9qoXYhMUNxPad7YtzBFaFmedhJUiKFhSA6JQ>
    <xmx:YDW_Z_ecFZWnICHi0-UBLkkGmyrcjWb2WlHhNysX6GKZ0kTu6T9l9g>
    <xmx:YDW_Z31b1Eudz90MjAiWvuQpW42GY-srpSYlJceM_i0M8FgZeQ49bA>
    <xmx:YDW_Z7_TdkOtpbPGVPxKoIB6Zpe0H43gj912mzX_a09Ang4xRGRMjw>
    <xmx:YTW_Z68UFZIgjV22UGAs1wIof1oJzP1nWKiGY01lBcVP8lGpX_iI5LGC>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 10:38:06 -0500 (EST)
From: Sven Peter <sven@svenpeter.dev>
To: Hector Martin <marcan@marcan.st>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: Sven Peter <sven@svenpeter.dev>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH] arm64: dts: apple: Add touchbar digitizer nodes
Date: Wed, 26 Feb 2025 16:37:53 +0100
Message-Id: <174058420088.275008.203693012021387035.b4-ty@svenpeter.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250225-z2-dts-v1-1-df101a7c17c8@gmail.com>
References: <20250225-z2-dts-v1-1-df101a7c17c8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 25 Feb 2025 22:19:54 +0100, Sasha Finkelstein wrote:
> Adds device tree entries for the touchbar digitizer
> 
> 

Applied, thanks!

[1/1] arm64: dts: apple: Add touchbar digitizer nodes
      commit: 44db68dee1f77260d7037319e911e9883a6ffe0e

Best regards,
-- 
Sven Peter <sven@svenpeter.dev>

