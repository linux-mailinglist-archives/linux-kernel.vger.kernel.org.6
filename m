Return-Path: <linux-kernel+bounces-539900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC33A4AA99
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 12:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979E21896FAC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 11:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C521DE3A6;
	Sat,  1 Mar 2025 11:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="1Zt7TsYu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3WyofDg3"
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487CB1DD526;
	Sat,  1 Mar 2025 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740827539; cv=none; b=Zu09vXUJ1/Pp43/MqV5y3lGoZd6oQAZ+EL1hgrwGJw5v1cD88367wd/qo/GhEgbc6YvjdyRCO9WT3Kr+2gV25HswJm6AE0VSnQGi4ZWULgMBmRZW9de4nEjmiMmzexHsJIxSuuPAlSUOZRdVLVSxoxAPaIDTh7wJKGy8VM5Ssxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740827539; c=relaxed/simple;
	bh=emQgneBQx2GkDTPzVDPMrpW49qKtnf5Ma/tpnHu+lM8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MgTSTsXrF1OecjA4wLxupmQrae7pBrT1cEgH6WtAvZ8kXMx9CM5ErVWC/eNxs0CwILG+a4U03HqJg5CxmNnpPnBCvDijQR3zvfpraVTdEYrYhh/vPCZ9DVeemKwxwVy1srI3j5unIgD+A+McJAYz1TAokJj1V2XGAqdvkLRvyis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=1Zt7TsYu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3WyofDg3; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id F422C114005D;
	Sat,  1 Mar 2025 06:12:15 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-03.internal (MEProxy); Sat, 01 Mar 2025 06:12:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1740827535; x=1740913935; bh=emQgneBQx2GkDTPzVDPMrpW49qKtnf5M
	a/tpnHu+lM8=; b=1Zt7TsYuUPsDseNNo+8ZboYjCukZzltRCNGiZobleRAAbZ61
	+DEINfPW7ytAU8rVoVDJIB3DnW6CeFwaoks+WiJOFSJ74HD5L+5rhVwMgouXydkc
	rr1a0/j1aDORpVQ48GqE5XG38eVlb+U3yttBq1tIQuwPVeptxGEEg3gEmL97XSop
	+UTjQEI2uuTTZhEWUv0k5Qkor3EYFs7kz7QlXU/tT1lTBKo1PP5iUyfbu6qje0pc
	3zBrTStTxf+1yz2SI7UBIwv3xJWNxPHwQ3P0u6Fy1etvTu70XwaRP541BuWhdGtt
	mestxjOgZrG7vsXHwP/pSqBfKPq2AhfWQnh3Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740827535; x=
	1740913935; bh=emQgneBQx2GkDTPzVDPMrpW49qKtnf5Ma/tpnHu+lM8=; b=3
	WyofDg34NEAmG1IIbppF+U+1WYRDdsyTAgbrRU5x4m/xU9ucGDhPnLRp/fXCUOps
	LMEET1BKDEfKft3fpl+QEzAlweuwJLcnfb0Eab/xo1RvywpSWa/mI5OyK3fDU2qW
	hJ7yGYltO9rjYeSDcH1S2aSByKMaomDA0wEG2KTS9gZfbsGENuWhRESrDhgh6Mb3
	w49wb1xccO6vzHaQ6wT53y4lP4dbp/k8YzulaX1/ehAYU2mv39EMX/cjx41y7EAG
	oNAQep5BFF7797+oMHuA2fRmkHLCKVBh2sEvPccIXWv035rrT7dM5wDqls1ZY3jQ
	4u6XrOQWAB24UiRDpxT0Q==
X-ME-Sender: <xms:j-vCZ7nS1S8n2KRkLrQ3IQd3zaGY8WHneGQou7T2mdXF_7mjf3chMQ>
    <xme:j-vCZ-0K33EQgZhAoCbAZJkyJs_qYMFkkZ9ovSDTNMtxuoVdT01rVAlQEUswhMlx8
    tOjtDsZYVPZnxojPVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelfedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfuvhgvnhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvg
    hrrdguvghvqeenucggtffrrghtthgvrhhnpeelfeetueegudduueduuefhfeehgeevkeeu
    feffvdffkedtffffleevffdvvdeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohifihhntg
    hhvghnmhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvght
    pdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsth
    hsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghsrghhiheslhhishhtshdr
    lhhinhhugidruggvvhdprhgtphhtthhopegrlhihshhsrgesrhhoshgvnhiifigvihhgrd
    hiohdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:j-vCZxrtpG8dOD1kK1nkjZB6mI2ZPo6C7AaojHHjZYhzH2iYKEshlg>
    <xmx:j-vCZzm8GRtOJv5mWT60XiAx9_kTuadqz9kcfylk9k3RhgKAYnkjwQ>
    <xmx:j-vCZ50e4NdzY9S2AKD3q7qkTIFNbU7Ea7adFSXec8amrAoc2EtrSQ>
    <xmx:j-vCZyuzkCXjW1_BhRx-vmmfht-du1u8zjqt8y3z0zXqAcE7Z9qQBA>
    <xmx:j-vCZzxd6ttZESm-38Va9fihMJk8oIDuoOU3vGte09e8X9CEzl7mxHl1>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 02609BA006F; Sat,  1 Mar 2025 06:12:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 01 Mar 2025 12:11:54 +0100
From: "Sven Peter" <sven@svenpeter.dev>
To: "Nick Chan" <towinchenmi@gmail.com>, "Janne Grunau" <j@jannau.net>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <4670e5f8-2a92-46bd-8faa-dd3774517f3e@app.fastmail.com>
In-Reply-To: <20250220-caches-v1-0-2c7011097768@gmail.com>
References: <20250220-caches-v1-0-2c7011097768@gmail.com>
Subject: Re: [PATCH 0/9] arm64: dts: apple: Add CPU cache information for Apple A7-A11,
 T2 SoCs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

On Thu, Feb 20, 2025, at 13:21, Nick Chan wrote:
> Add CPU cache information for Apple A7-A11, T2 SoCs. On Apple
> A10 (T8010), A10X (T8011), T2 (T8012), only the caches in one of the
> CPU clusters can be used due to the "Apple Fusion Architecture"
> big.LITTLE switcher. The values for the P-cluster is used in this
> case.

So this means that the cache information will be "wrong" when the CPU
is in the lower power states and only correct for the higher ones?
I'm not familiar with how these values are used; are you and do you
know if this will have any weird or unexpected effects?
Would it be better to use the cache size for the lower rather than
the higher states or does this not matter much?



Best,


Sven

