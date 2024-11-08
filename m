Return-Path: <linux-kernel+bounces-401558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0669C1C40
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B04282DCF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A253C1E47A2;
	Fri,  8 Nov 2024 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="MuVSr4D+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ixf6vJSL"
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D948F1DE8A8;
	Fri,  8 Nov 2024 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731065819; cv=none; b=YtbKTKRvvG5DYbSacZ4Bp3PNxCLlwM4Qig5tQJam2JThfLcpYwrLyR+gghF4cCFeSQVLYryz0qELgfeX3SMURW6FJF69HDs9kQy1cFw5eGZKt0v3yoyuLVSx50+jIFH9zVIQmuGqMwCdrRj7QLEHSCvkhLq9dbcNh0dVJICfXFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731065819; c=relaxed/simple;
	bh=P9Y2KKJd1Gvbd/DFSCbNqOTaC2pGZHzV7UHgZB4KQEA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eebE07s50Kk6+ET0RPqmAhBG/MzWo088Mo9XvD4vmqug4mkSCl5bHfT91LIRLkBDw/kvHF8hNQw/p//MJRpk8SMco6qtVJgbD4YL+ZTYJnSugBdtV4RhdRKqKLyC8SxzKA5ExBuknVO3qCM7zQfYyNV21+KFBOUWeewac0F0F5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=MuVSr4D+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ixf6vJSL; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id CF0CA1380105;
	Fri,  8 Nov 2024 06:36:55 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 08 Nov 2024 06:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731065815;
	 x=1731152215; bh=/UFtKcqpLPOta++bN4mFB7tkrh4R7OEgdALO6YFmI0E=; b=
	MuVSr4D+T6p4whmx3kZLDxSrzJOGMq2Vmcjh7b3D8frFZDnJ0IT8CbwQgxM+qkmr
	pxqE6wQc3kAZW5poHHCzaIwGwxYTlPCey3NcHltcxiq126slsqWEySLpQsLaG8ZW
	R8kRVWp1nvRF+XhhMpCtBAmfqfe6SKe0asX8uTuqA3O1jqudLjAyxQKy5BplaTmx
	PkW/RjfCZoVyXHigJCnhg8hJSlrtL7ACBXZ4vW5JvL4k/cQt/PfLg1SVGIXGg5R6
	KO6IfQt6UjkwgvoBsIUGIRKEF4Mb26Mo6KBD9kD4ofqYbrk6hZAxMw8jfFnofiSt
	MkZsvG1x37waeGtvmqM1XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731065815; x=
	1731152215; bh=/UFtKcqpLPOta++bN4mFB7tkrh4R7OEgdALO6YFmI0E=; b=i
	xf6vJSLL4f0cC5iEMeeWu8by72bZDrQX/WlIklb7WXuOcYaEGQkZZAIVLPN+2pZA
	SXlhxp0xn4VI9A+GyBKrYuF/iUOWa9gNmAyreuaM6xySvy+3fe4IXwSCGMsQWbZP
	ZXZx2yCjvOZlO2XvwSqPProe2heY0EjHiZ/SFj4yRTi15LNoG9YgzQGHPVhkAmmC
	e5lvXucZGYjT8kOm/tnA0V7h3kvhX5ZU95zA8wkvl6NcNFdgkw2o/GOsGzgHejWX
	yfN6DutSX3WbZJPMXKoVe48IDK8dgx/tnbnrBHcIhtUjq4HjPKOaXDkS63PQmFqj
	3Gf7k0/yP5tCfAlZvaEfw==
X-ME-Sender: <xms:1vctZ6YRV91KUNf6re0_EjKNZNh2trTT95xfv1EWLUZJ53tSJnRTqg>
    <xme:1vctZ9bD6_jESSR3yvppnTOkfx0_3CNsPQYOv1RvSOg1Ui4bzyg3mYiLZ-KHCK4HF
    0KEe1dV4nqxw9NhXAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffg
    vedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvhedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnughrvgdrphhriiihfigrrhgrse
    grrhhmrdgtohhmpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdr
    tghomhdprhgtphhtthhopehjrghmvghsrdgtohifghhilhhlsegslhgrihiivgdrtghomh
    dprhgtphhtthhopehmrghtthhhvgifrdhrvggufhgvrghrnhessghlrghiiigvrdgtohhm
    pdhrtghpthhtohepnhgvihhlrdhjohhnvghssegslhgrihiivgdrtghomhdprhgtphhtth
    hopehnihhkohhlrghoshdrphgrshgrlhhouhhkohhssegslhgrihiivgdrtghomhdprhgt
    phhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllh
    grsghorhgrrdgtohhmpdhrtghpthhtohepnhhfrhgrphhrrgguohestgholhhlrggsohhr
    rgdrtghomhdprhgtphhtthhopehhvhhilhhlvghnvghuvhgvseguihhmohhnohhffhdrtg
    homh
X-ME-Proxy: <xmx:1vctZ0_-_OLnQj42eH0bq4y-7qkELYAQQz1goBf_3Z_SUGoNmfDKMA>
    <xmx:1vctZ8qt6imn11CprVNHZSBJfdVBAcuUP9Ywx53PQVjMKGyeQDNw0w>
    <xmx:1vctZ1o_i0844q2Nq7GfX0dYr63Rk7UOAMJ-BOntyTyINUC3_0iKDw>
    <xmx:1vctZ6RxE-3pT-swk7VQfEF-2mGfMN_LEmmRUpsercEQrs1Cn6xU7A>
    <xmx:1_ctZ_YzZDKLxYZqWPD7R1iVGO-lTwKwF7NNwPbdelt7EE9hqms9h70M>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C46942220071; Fri,  8 Nov 2024 06:36:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 08 Nov 2024 12:36:28 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Niko Pasaloukos" <nikolaos.pasaloukos@blaize.com>,
 "James Cowgill" <james.cowgill@blaize.com>,
 "Matt Redfearn" <matthew.redfearn@blaize.com>,
 "Neil Jones" <neil.jones@blaize.com>, "Rob Herring" <robh@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Olof Johansson" <olof@lixom.net>,
 "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
 "Shawn Guo" <shawnguo@kernel.org>,
 "Hugo Villeneuve" <hvilleneuve@dimonoff.com>,
 "Andre Przywara" <andre.przywara@arm.com>,
 =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
 "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konrad.dybcio@linaro.org>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Nishanth Menon" <nm@ti.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>,
 "Johan Hovold" <johan+linaro@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-Id: <f38f87bf-f413-4dc3-a76e-e653dd4ad6d1@app.fastmail.com>
In-Reply-To: <20241108103120.9955-5-nikolaos.pasaloukos@blaize.com>
References: <20241108103120.9955-1-nikolaos.pasaloukos@blaize.com>
 <20241108103120.9955-5-nikolaos.pasaloukos@blaize.com>
Subject: Re: [PATCH v4 4/6] arm64: Add initial support for Blaize BLZP1600 CB2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 8, 2024, at 11:31, Niko Pasaloukos wrote:
> Adds support for the Blaize CB2 development board based on
> BLZP1600 SoC. This consists of a Carrier-Board-2 and a SoM.
>
> The blaize-blzp1600.dtsi is the common part for the SoC,
> blaize-blzp1600-som.dtsi is the common part for the SoM and
> blaize-blzp1600-cb2.dts is the board specific file.

The split of files seems fine, but a little more information
about what this chip is used for would help, so that developers
looking at the git history later can have an idea.

> Checkpatch: ignore
> Resolves: PESW-2604

I don't understand these, can you turn these into full
english sentences? What checkpatch errors do you see and
why should I ignore them? What is PESW-2604 and how does
it relate to PLZP1600? 

> +#include "blaize-blzp1600-som.dtsi"
> +#include <dt-bindings/net/ti-dp83867.h>

I don't see any references to ti-dp83867.h here, maybe leave
the #include to a later patch that actually starts using it?

> +#include "blaize-blzp1600.dtsi"
> +
> +/ {
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x00000000 0xffffffff>;
> +	};
> +};

Is this an off-by-one error or do you intentionally
leave out the last bit of the 4GB address space?

If the last byte is actually addressable, please just
use #size-cells=<2> and make it the full 0x100000000.

       Arnd

