Return-Path: <linux-kernel+bounces-328162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3CE977FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08962836DA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E31B1D932C;
	Fri, 13 Sep 2024 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lb8yhYTK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AX2NWoKp"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5D81C2BF;
	Fri, 13 Sep 2024 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230298; cv=none; b=XXbxsCjHfGrCcrxSmhlSnpqSt1W+ebxKTJ1F5J9xbsirWjx3VRPFi8p9Z9gS8HP54MuzWEwP3ypvmQ7Muga35/8DSbL5vgsJPHeMtl39w473Uzfna0pH8gnTq/EdjM4WfqiTADHA/39tQcMvKmUgTawSW+tRmzufipUQzayT9AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230298; c=relaxed/simple;
	bh=4PYF1Jr9bWGi3HzqF5uU7EgHTiAs3MxzS1XFJM2iD7o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BeG2Xyyc/zfaxaNQ2ZjlRdmsZae3FEiDfwIE7v5E5pLkaS4dkdrdlQ6ugfB728/vJOZwo4b3CN3G09OLGWn9zB4kHDn+mBlM9hMq5p3+4d2USRwDo2X0a/UPOW8ia6EMPdeeqFq7wCMfuy4ASLaW7wdnkY4TZ0+TXtnia9kEKGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lb8yhYTK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AX2NWoKp; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EBD081140203;
	Fri, 13 Sep 2024 08:24:54 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 13 Sep 2024 08:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726230294;
	 x=1726316694; bh=E6Cqr6blYSXbC1Q7pSrIaOAl79ieSQztc8I/sTEdB3g=; b=
	lb8yhYTKVVqktNUJvgfMaAqRN43f87L/5YR7kugg1qS3ThUzZsOjlYyZhaWZK+nF
	zRpELm63Velc4UCH9/5oXiPiqEXNarBEo3hDYCLG7NZXzO4cfU/gqwnWMZzlERkX
	xdz8izovL2BQAgO+Pab7BAJbBZGi7W/XXlomQGK2LW05H9bnYH+VGMb6nfGw53vT
	mqBv275czXA4j41piEbbOuHVTozXT5no46mUO8hlFll6DGqsIFeDLto3IEwE+H9Z
	qDkMqXhgC+uGYhNdaZdFBQuQ3ByfFxaV1YQWo9gdpAYMB3qY3BvcuXA4m+Ht0tsv
	TATWN3FDyWX9PfdMfGdcCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726230294; x=
	1726316694; bh=E6Cqr6blYSXbC1Q7pSrIaOAl79ieSQztc8I/sTEdB3g=; b=A
	X2NWoKpfKmBGB71Acht5TsA4TPkfOpmXz5oJjOb91ginMnVuQAeR6OrRALahb0MD
	Y0N0Y9eWxKM4mBnv/gaBD5//sMrkvTQG61p3XiiRWUU/Gf467oiibPXz3kM1Aitq
	5fbXGwHjSmpXettk0vy09mkvZYAsKgDtBXCEp7YWc04pKIb6JaP13QAEoUcQE9+A
	ZIiezNVkHCeUqHOc/WxraOO+rwXfSgVkaKKI4cYhksQ8dxw24iij1ef8crLZIOfJ
	kFbhcCk521kvnZjOqk67aVQwS7tSaecfW4isnzYEM4u1NqnjmVrEufgkyoV0lgAM
	ONnsrSJQoHjpllI26cC9Q==
X-ME-Sender: <xms:Fi_kZkQLb8sR8nzJgNAJAMqf6lGPI36DeFkv_lv7laZ9e-thvtY9LA>
    <xme:Fi_kZhwADQURpaHpJdQ44YTvOTCN2rDip9DvJBNklvc4ylO5cJuiYDTDQRTm-vtC4
    tJT4l6bv6kZLuCYHKI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejjedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhukhhmrgesuggvnhigrdguvgdprh
    gtphhtthhopegrlhgvgigrnhguvghrrdhsvhgvrhgulhhinhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehnihhkihhtrgdrshhhuhgsihhnsehmrghquhgvfhgvlhdrmhgvpdhrtg
    hpthhtoheplhgsuhhlfigrhhhnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehluhhk
    rghsrdgsuhhlfigrhhhnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehkvghrnhgvlh
    dqjhgrnhhithhorhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephh
    hsfigvvghtvghnsehvihhsihhonhgvnhhgrhgrvhgvrhhsrdgtohhm
X-ME-Proxy: <xmx:Fi_kZh2M0i1mVwF7W5evj-YM9aH-0Uidy0n-xw0BZRhZGdpTY2aS3Q>
    <xmx:Fi_kZoAiJ0Lbmu8ExGDwJXqK93g6qVIxgL0uqTeDz2A5-3YgkapYlQ>
    <xmx:Fi_kZth07F23AW2xdlwcMEC3227ZaPEb4dlbc6L7YruKI0blse96uQ>
    <xmx:Fi_kZkpsrvb8I1q3nxNnc1vX0EDZGKNjEwOec2SByK1PHnH9KYujyw>
    <xmx:Fi_kZljJZuHsr5MYh8sRHSKYKYjaOHoMl2DOZqucm93G5Bi04U3nKQdi>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3FF6D222006F; Fri, 13 Sep 2024 08:24:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 Sep 2024 12:24:33 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lukas Bulwahn" <lbulwahn@redhat.com>, "Lukasz Majewski" <lukma@denx.de>,
 "Nikita Shubin" <nikita.shubin@maquefel.me>,
 "Hartley Sweeten" <hsweeten@visionengravers.com>,
 "Alexander Sverdlin" <alexander.sverdlin@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Lukas Bulwahn" <lukas.bulwahn@redhat.com>
Message-Id: <d125b5a5-8118-48ec-8af4-243a217170df@app.fastmail.com>
In-Reply-To: <20240913115021.58405-1-lukas.bulwahn@redhat.com>
References: <20240913115021.58405-1-lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: move BK3 machine support to CREDITS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 13, 2024, at 11:50, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> Commit 3e0bae7f35c9 ("ARM: ep93xx: delete all boardfiles") removes
> ts72xx.c, but misses to adjust the ARM/CIRRUS LOGIC BK3 MACHINE SUPPORT
> section, which is referring to this file. Hence,
> ./scripts/get_maintainer.pl --self-test=patterns complains about a broken
> reference.
>
> As the corresponding file of this section is gone, remove the whole section
> and note this previous contribution in the CREDITS instead.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
> Arnd, please pick this quick administration fix on top of the commit
> above. Thanks.

The machine should still work as before, I think we should
instead adapt the path to point to

F: arch/arm/boot/dts/cirrus/ep93xx-bk3.dts
F: arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts

       Arnd

