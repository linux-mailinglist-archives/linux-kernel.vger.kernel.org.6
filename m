Return-Path: <linux-kernel+bounces-278098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6689D94AAD4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1760D2821ED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C223F81741;
	Wed,  7 Aug 2024 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="agfj9nYg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q2pOlN4i"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A6D8120D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042659; cv=none; b=ZG2T8nhsQwCGPLg8BFGe8fcWCKHIMsReOyjAqX93Qm42Wz1xFKzaDlJ6ohhajWr3MIU9XE2rpcBZU1ZxZFwIcGiWmvykzXhlyTsdH56k7jx3ZaihWSQkvxST+NGdznKfU97WyC/2CSiu/h/qd632NnlorGD0QvlnAXxklZ+FMXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042659; c=relaxed/simple;
	bh=3aP9K4B7juzX56vt7E6OrqGb60S0shertZ2jcYxfXEo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZLc5LoltuaUnzLKfuUq3M2YkXm4dy6OaBfbj/dSxOIzPu6hO8DrQ0AVUg9SyTqfBSEUd6D7CNFHmIuXBUiOqIewcE1PxNx4gi6Q73WNkkGW52MXZ2bIQxkTfVVk8HXjEWJfwjPTR5hfGEb27bsdPPQtzq0X39TZNn8XWmcCPrqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=agfj9nYg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q2pOlN4i; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4CE151388026;
	Wed,  7 Aug 2024 10:57:37 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Wed, 07 Aug 2024 10:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1723042657;
	 x=1723129057; bh=SKhiuzky2s355ePdeYR6vOR9bJWsi88XGi4FdI2nQq8=; b=
	agfj9nYgX9u9r4IK58is+dOwqXl48GKfU8zIiGA4hudJIV9fTn3hDjWAi1QJh2T2
	MhQ86z3wuHGf7hThYvQrFfRZ1IpHgl1h63FZcCgFARe4cwINdmRu2rN5iA8tFCWR
	UhylR/u5ipLDvx/DI0Gpgc9rP299gfmkLYp8mrO1HDrOQkWaWncQN5K3a0CnZkpm
	MerDKW2RAwd32TtkQew4GbUMR2rUAac56HECYIuNKD9PFtMAScwDhvBlBUpFGJ90
	tnwXpn6emIOOmKx08AtGu/B5XlJU2pYxxnA8e92YOzFWJr8cLG08jNazAhODLNtZ
	9eoS9V8lagq2FHi2QNqKug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723042657; x=
	1723129057; bh=SKhiuzky2s355ePdeYR6vOR9bJWsi88XGi4FdI2nQq8=; b=q
	2pOlN4iuKkSvZL6D/+eiLN5oAAKZQfzqxvvklOn1saWguvO4FKQWI54sGCwoY6TA
	JA+SO5zc8QFctJbqyKcSOjzoSww3BY9AvS+b5tCvy1fDeIcHZsLtFMPwibucdZER
	c/yjChKIksFzrewEax+noJ4vqUgUiuPGILYB9JoJuQn4rhG7Ox2MZC6NXFuyFwU3
	iN2TUMidH/giIXVpFGX4YNaBGERphqwo9DVp8o4PYuTHUgtykAYrGd0wU/7O0Fyq
	eZ2Mb+Xe04yEtBBN6yMERVJbIW0tFpsWBGbTlXPpAhdBSI8HxcAn65tmjGnINXn0
	FGPJODiB7Q2knPMFDnzag==
X-ME-Sender: <xms:YYuzZvXaGFvDmJsd8hmWk9t5lxZtxGvPPPr74mz7s3TN0vTL4c85Jw>
    <xme:YYuzZnl0H7atKd42EuhvtcOBFv7m7DzjZpWlX54_whGascYi-iUxCvF7fIc9fvS7Z
    hb-xfO7985VBcR5xJM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevueejtdfgtdejudeltddttdevffdvledugffhtdfgueekgfekhffgfeelkeei
    jeenucffohhmrghinhepghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphht
    thhopedt
X-ME-Proxy: <xmx:YYuzZral9RL8knvosn2sIzo5Eeh60yzfEIG2p3UnIQeKnSNqLt1u5g>
    <xmx:YYuzZqV-JKJLXUdgJk3URc8YAlgZLxR0Fg_0LnCE6CErn7BwKs6GDA>
    <xmx:YYuzZpnuseU_dqGRaDuoWgO_DEcVR0eeIQJQ3wYtBER72FpUiqz4Xw>
    <xmx:YYuzZnepEs1cRNMnEmPOpzf1MZqYLTHLLzVhQHV3ZopSmRdMzNupUQ>
    <xmx:YYuzZvgmhFOzD42mw4ijITqB2te-YuHduwpCTJqpMAn1od7S4Txr6WNC>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1E30BB6008D; Wed,  7 Aug 2024 10:57:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 07 Aug 2024 16:56:56 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Peter Zijlstra" <peterz@infradead.org>
Cc: "Josh Poimboeuf" <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Message-Id: <4afdfafc-ca43-4919-97e8-aefdb1feadcc@app.fastmail.com>
In-Reply-To: <20240807141801.GB31338@noisy.programming.kicks-ass.net>
References: <ea203f8e-8dd4-46f6-ada5-a2bf5ea8185e@app.fastmail.com>
 <20240807141801.GB31338@noisy.programming.kicks-ass.net>
Subject: Re: new objtool warnings with gcc-14
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Aug 7, 2024, at 16:18, Peter Zijlstra wrote:
> On Wed, Aug 07, 2024 at 03:56:45PM +0200, Arnd Bergmann wrote:
>> I see some objtool warnings with gcc-14.2.0 that I don't show
>> up on gcc-14.1 or older:
>> 
>> vmlinux.o: warning: objtool: adis16260_write_raw() falls through to next function adxrs290_read_avail()
>> vmlinux.o: warning: objtool: adis16400_write_raw() falls through to next function adis16400_show_flash_count()
>> vmlinux.o: warning: objtool: x86_init_dev_msi_info+0x61: relocation to !ENDBR: irq_chip_retrigger_hierarchy+0x0
>> vmlinux.o: warning: objtool: rza1_irqc_probe+0x257: relocation to !ENDBR: irq_chip_retrigger_hierarchy+0x0
>> vmlinux.o: warning: objtool: .export_symbol+0x5908: data relocation to !ENDBR: irq_chip_retrigger_hierarchy+0x0
>> vmlinux.o: warning: objtool: .export_symbol+0x35b18: data relocation to !ENDBR: stpcpy+0x0
>
> https://gcc.gnu.org/PR116174
>
> As such, I've been blissfully ignoring all GCC-14 issues.

Ok. I can confirm that reverting b644126237a1 ("Align tight&hot
loop without considering max skipping bytes.") in gcc-14.2 avoids
the ENDBR issue.

The first two warnings in the list, about adis16260_write_raw()
and adis16400_write_raw() apparently already show up with older
compilers, so those are unrelated.

The problem here is the unreachable() in code like:

      adis_dev_auto_scoped_lock(adis) {
             if (t >= 0x0A)
                      adis->spi->max_speed_hz = ADIS16260_SPI_SLOW;
             else
                      adis->spi->max_speed_hz = ADIS16260_SPI_FAST;
             return __adis_write_reg_8(adis, ADIS16260_SMPL_PRD, t);
      }
      unreachable();

     Arnd

