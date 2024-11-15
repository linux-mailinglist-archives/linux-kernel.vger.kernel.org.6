Return-Path: <linux-kernel+bounces-410866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B18D9CEA99
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D341F24EA8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417331D45F2;
	Fri, 15 Nov 2024 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="nOXSJWzh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="deXa/Hdn"
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB9E1CD210;
	Fri, 15 Nov 2024 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683405; cv=none; b=pI+gcqFjR4L1wqa9O+ttE/yo3yPMoUj9tEAGy/JonjVavEPsoPTAsNtrlMm53C+3BOZzdthslIM5SU1WXkeiLmeMmLysDnH3MvPoBYsAb4GbX07FGUPoilhbMe1kca/CiaAdAzJhOxyKDeieoSBSNArNini2R1QmfnbFP4YC/J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683405; c=relaxed/simple;
	bh=s5QVE4NaR83/7M7PtsqGvjOLW1yP8l0947gtgLTI/pA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BMG3wuNFRosZJShMbfqwsulh0XEePBPRNjL92msaQzEwLjBft3OFTpveb4U0NxOxeDPiRMHal/hQIVfQBD095DMTC1q9GxGM4piSTzoQeZDFZQRpsB3Pestz7hcpb3x9EiyFqoP4k8Bwtip60bJHLhZJC5WYmIAfStYP/6lenxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=nOXSJWzh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=deXa/Hdn; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0B88D2540176;
	Fri, 15 Nov 2024 10:10:02 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 15 Nov 2024 10:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731683401;
	 x=1731769801; bh=nLE+UOTS7yHdog6ETbMGcYAEjTIcnW2Hb1xbsSa24qU=; b=
	nOXSJWzhDQ7uEdSXslDHBBwBRSTNC8fnK/NE/YQCB6PI/LdSdoPJ2JKAQIvUpeVw
	+Q794Wy/0b76KSlKhJNHNQ25mJhL8725nuoWbTKcZ9NMI2TRQaOdF7p8RM58Bad2
	HWluM9ucfcS+fB5MkBIJ51JOOJyNCz6gpla1WLh6uM6aZOuSj8EUd6tTF2QPr/YM
	p7jncsqs3egS4TVeh8djL6TZBF/wor//7nQYrQd4ZHGSsAmxokbA+9QwtjLMHFew
	OgIQetlun9Gc+1dt0cBnUaPaKTbwRiUqUcwcxKcEKa7oQA9KU7vh0dTgmwxMNetQ
	u+FrkHosWsrrGZhk2WMdyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731683401; x=
	1731769801; bh=nLE+UOTS7yHdog6ETbMGcYAEjTIcnW2Hb1xbsSa24qU=; b=d
	eXa/HdnRwNcPVOz9naGBFMhieyx9xKP+9Lb270gD7hW6j+bE7mY/xtgIM8Hv4Rio
	v/0HlWHx6Te0u9/j+jcM3nPsZIMYSmQTkxWaJ5KgYlmFUYe0zDoInZCr3LTtPbQP
	28fTozk4Zv2EsVLtBmhgy0TkCiCnGv0VL6ve38KdZ10VYLeCyVZ/ws6z1dspiwPt
	ipftlke+cQaItb4XA22Z/uIqtc/DTImPhhsF3f54uKMUDqnc5m1ryDiM3L89zseI
	77oACeSe2jaOEFwU7yUfjs/vI+Sj4Al/Ixd8AvZZnhxgMuJVeVp0riNu83zuC2CR
	4SHVJAwdKDfBSQp+WbXuA==
X-ME-Sender: <xms:SWQ3Z7wC3cCbw6nUGAgMVd46TBZ5uAnOYaBtv2ddjcS2KPAwRDVW4A>
    <xme:SWQ3ZzQu1YPT3qeD89nLlInWzRzg6HSfp447g4iPk0vUfodpruAxYqefN2dPww9nA
    1-lKW69DRMLP1dyYes>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdeggdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpeelheevjeevgffhteeiveffgedtvedvteekleefgeel
    ffeuvefhudetieehgfelveenucffohhmrghinhepsghlrghiiigvrdgtohhmpdhkvghrnh
    gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedugedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdr
    tghomhdprhgtphhtthhopehjrghmvghsrdgtohifghhilhhlsegslhgrihiivgdrtghomh
    dprhgtphhtthhopehmrghtthhhvgifrdhrvggufhgvrghrnhessghlrghiiigvrdgtohhm
    pdhrtghpthhtohepnhgvihhlrdhjohhnvghssegslhgrihiivgdrtghomhdprhgtphhtth
    hopehnihhkohhlrghoshdrphgrshgrlhhouhhkohhssegslhgrihiivgdrtghomhdprhgt
    phhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrii
    hkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SWQ3Z1W8l1AmoJ--C8_Z8WY90ySNt3vYnVjiEucoY3qO6S5pgP253A>
    <xmx:SWQ3Z1j6Dj1RHATybGvOg7F4c4dmq8pULORdF6D3npJ_sZLxehL3wA>
    <xmx:SWQ3Z9Brr8nDHRZLRI4_Ug5OfGNuUoDSsO6cgWWv7rUPLMdPpu57UQ>
    <xmx:SWQ3Z-JjNL-O0kEz6pY9YJ7r-GojJ5UZ5ISMJix1UO9-zW6qgpMJEA>
    <xmx:SWQ3Z1wtsBDS6K2uC0fhZz913LWUaa_TbAZd4LA3dHMmlZTgXu49Y6NN>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 46E032220072; Fri, 15 Nov 2024 10:10:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 15 Nov 2024 16:09:30 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Niko Pasaloukos" <nikolaos.pasaloukos@blaize.com>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "James Cowgill" <james.cowgill@blaize.com>,
 "Matt Redfearn" <matthew.redfearn@blaize.com>,
 "Neil Jones" <neil.jones@blaize.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Olof Johansson" <olof@lixom.net>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "soc@lists.linux.dev" <soc@lists.linux.dev>
Message-Id: <141c7d39-9f0e-4c1c-86c5-149328ab979a@app.fastmail.com>
In-Reply-To: 
 <20241115-blaize-blzp1600_init_board_support-v5-0-c09094e63dc5@blaize.com>
References: 
 <20241115-blaize-blzp1600_init_board_support-v5-0-c09094e63dc5@blaize.com>
Subject: Re: [PATCH v5 0/6] Add support for Blaize BLZP1600 SoC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 15, 2024, at 15:58, Niko Pasaloukos wrote:
> Blaize, Inc. (www.blaize.com) is a SoC designer and manufacturer
> with integrated programmable Graph-Streaming-Processors for AI
> and ML. This series adds support for the Blaize BLZP1600 SoC.
>
> The SoC can run as either a PCIe based accelerator in a host
> system, or as a stand alone SoC running Linux on its integrated
> dual core ARM Cortex A53 cluster.
>
> The SoC includes a suite of peripherals, support for which will
> be added later.
>
> This first series is just the basics to get the upstream
> kernel to boot with a UART console and ARM SCMI based
> clocks and resets.
>

Hi Niko,

This version looks good to me, but it's likely that others
still have review comments. Either way I should let you know
of the next steps for merging the series.

Since the 6.13 development cycle is now over (the
merge window starts once Linus publishes 6.12
this weekend), the earliest release to merge this
into is now 6.14.

Once 6.13-rc1 is out and the patch review is complete,
you can submit the patches for inclusion by sending
to:soc@lists.linux.dev (formerly soc@kernel.org).
This is usually done as a pull request, but separate
patches are fine as well, especially if you don't yet
have a kernel.org account.

After the entry to the MAINTAINERS file is merged,
I suggest you also apply for a kernel.org account,
see [1]. You probably also read the documentation at
[2] about the usual process, let me know if you
have questions about that.

       Arnd

[1] https://korg.docs.kernel.org/accounts.html
[2] https://www.kernel.org/doc/Documentation/process/maintainer-soc.rst

