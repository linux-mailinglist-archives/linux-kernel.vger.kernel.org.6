Return-Path: <linux-kernel+bounces-570947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BD0A6B68F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05A7188450D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59861F03D5;
	Fri, 21 Mar 2025 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="merId6y0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="48cHDPDA"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3E01EFFB7;
	Fri, 21 Mar 2025 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742547807; cv=none; b=UXunc1fhxLPbVz+CzWzYpJNGZOCoUUKfIzLWIBspVwUstxB33rmHYtKIvPsKTLEu62PY9aWRnB4GUm90eB0Uw0yo3OCQVkrttcoe2SIH+80HOPbuqS0xNODXy0QYNLcyGTtXofqEQ8mkTeu02W/8c7LblTHrDBOtiASoUMeHiRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742547807; c=relaxed/simple;
	bh=yEakNrR6k4To7zC5212PfPE/73eTtqh49DTLIXPESMQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZqOyAGziFa38qPnVafSgJw8z98LhkqGsZPz9c6q1oUvt4CALpWqMRoxGcWAz2Y+SWVxamIdcO/fQoasYYNrX8t2jZ+Dh4Sivbr/E0EhU4bizX43SZjuifXFxzQQuK9ipISwsXKk2sicmML7EFcJzNwHlLIq+rnjKUo20zGn7cks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=merId6y0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=48cHDPDA; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AC130114009A;
	Fri, 21 Mar 2025 05:03:24 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Fri, 21 Mar 2025 05:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742547804;
	 x=1742634204; bh=LEbT5bPhP4WcLW38oXwnbwZDnAF+BgzvO4LRwbs0urQ=; b=
	merId6y0RnVKyxyTClbhwQo21y2zU3NJxajhrt0fwZPHI+8ZlSZKs1rmPXGGM+1H
	sCvRMNPcaI1oXd3+O4OHEeQMznRuy2+rcW3sXw9b4RHZC+qkkmticQcS+aP73L6l
	F9AiD4V9/Vyi9Ar4zjMWzJ8oHciiUBhjm1TeZkR8e/xKaunEaS1MjihdpbAWlPFt
	Ujd35Beeyye8C0NX02uziSfoRHdmSMAIuw+S6jWFbTWZS6r01Dys3iPz2tKTbgle
	HBL0TOAGIpOIGkm1Z17dAHyJGwtow8eBZ+xrieySqcmFSO2elOT4Tm0D4yMZVp4X
	FnphFbMXueWhfoNrIj1zFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742547804; x=
	1742634204; bh=LEbT5bPhP4WcLW38oXwnbwZDnAF+BgzvO4LRwbs0urQ=; b=4
	8cHDPDAZKTxz20VisSEmp78kpWp9L10BOI63t4yyNCLxVjDh6A38ALDDxxVgNOn2
	HVRk1iudMu4KiXWeZOB9F4ATNoF5esEUHVnI2TON9DCmyp7Dyeb9TOUkFNsKGxaQ
	53N+G19oC5fHKGWEFHsjp3RAUvfyQSxL+GnD1gkfS0lFTOgQHnqhfG9aeCP6MlAb
	v0M3BKwDFxd2i/qo8i1eqlKiMafUIWEwFq9ErmojD+yoqG0bvKTSrnoTdJ1z9kCD
	/UkiUUlFNOsF7VG0U8N93NLambZrE4dfYLhV6CVID/WGkJTetpkzrcyaYq162VJ8
	fY5Vj24JAiojVL8CXN3Hg==
X-ME-Sender: <xms:WyvdZ1vUgCVAHBf2-ld5VaanSDcjKBI90axcl0vtE5wRZooozLZVyg>
    <xme:WyvdZ-dIfqxJVKpJ1wR2iaSkNluIGnsDtEUaMxv9rns2zQZFdT4YSQWHFs8ob2tKS
    6pLuX5R-xxbutazdYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedtieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    uddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghtrghlihhnrdhmrghrih
    hnrghssegrrhhmrdgtohhmpdhrtghpthhtoheptghigidqkhgvrhhnvghlqdhuphhsthhr
    vggrmhestghigihtvggthhdrtghomhdprhgtphhtthhopehfuhhgrghnghdrughurghnse
    gtihigthgvtghhrdgtohhmpdhrtghpthhtohepphgvthgvrhdrtghhvghnsegtihigthgv
    tghhrdgtohhmpdhrtghpthhtohepmhgrrhgtihhnsehjuhhsiihkihgvfihitgiirdgtoh
    hmrdhplhdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WyvdZ4zsmGXN-tX6IEG1VMG842mhYjzOzA1BtsfWle6yrOArGRhlcg>
    <xmx:WyvdZ8PrlWRu1LA6oEn060yebTb1Ag-AqebjIH87b3By2Q7dwt6Isg>
    <xmx:WyvdZ19YrjPNr1rAc-u-ofNIqs40tfCCjaalcyFFnqlMxquFvSXLaA>
    <xmx:WyvdZ8WWG_8MBf2yt3HQFiv3e7gQRrkVgr-LDOeyBXcjVlOK_s-Wfg>
    <xmx:XCvdZ8XkCG1VoR2k-iT0qkyzlOA75Au0yJWyl33coS3AcNt7gadovbxl>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4B6622220072; Fri, 21 Mar 2025 05:03:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T1bdb747f5f593b3d
Date: Fri, 21 Mar 2025 10:00:59 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Peter Chen" <peter.chen@cixtech.com>, "Rob Herring" <robh@kernel.org>,
 krzk+dt@kernel.org, "Conor Dooley" <conor+dt@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 marcin@juszkiewicz.com.pl, "Fugang . duan" <fugang.duan@cixtech.com>
Message-Id: <59619096-bfb2-428c-a4f5-2dfb031d126c@app.fastmail.com>
In-Reply-To: <20250305053823.2048217-7-peter.chen@cixtech.com>
References: <20250305053823.2048217-1-peter.chen@cixtech.com>
 <20250305053823.2048217-7-peter.chen@cixtech.com>
Subject: Re: [PATCH v4 6/6] MAINTAINERS: Add CIX SoC maintainer entry
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Mar 5, 2025, at 06:38, Peter Chen wrote:
> +ARM/CIX SKY ARM ARCHITECTURE
> +M:     Peter Chen <peter.chen@cixtech.com>
> +M:     Fugang Duan <fugang.duan@cixtech.com>
> +R:     CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>
> +L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/arm/cix.yaml
> +F:     arch/arm64/boot/dts/cix/sky1-orion-o6.dts
> +F:     arch/arm64/boot/dts/cix/sky1.dtsi
> +

Looks good to me. You can also add a regex keyword entry such as

K:       \bcix\b

to match any filenames that have 'cix' as a whole word.

    Arnd

