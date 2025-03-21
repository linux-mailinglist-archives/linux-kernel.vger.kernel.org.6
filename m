Return-Path: <linux-kernel+bounces-571159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253AEA6B9E3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777AF3AB599
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4C9222596;
	Fri, 21 Mar 2025 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="DIKL1tTH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="puHOAml5"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5C222256E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742556456; cv=none; b=JPYmFPbWJg8Ud63xWhaJAOnNtkvmq9suhEHejB/JRwsu+bFFGEaYvJoArshrlh49CLJizyhwcC6UA0C9ZeMUty19AaDtoFfxZlFcimMCNphblN7qjpMIiwVwpG4cHFVDd/TJuyOTt1zFte5g7n3u1hvncslRJQzjwFBi5b1h844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742556456; c=relaxed/simple;
	bh=Bk/jPsHAllESCNFDiIfIEnidduiv3UZG+R2+EQp3ZVo=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CKPVJmKUnZLjKFjsYNvg1PYVtfmjkNJQ71peEb4KbxDUGTlr2AwpBXU7MoP2HrFM2ka+63TiT69vfJ+UTYJP9GuMqCqYpgJp66372s3mdOxB6IKlGR4EXGKH9M/5aTDPww4ONM4LhHLB0JJ1JW4xzVCIHijl7Ab9g4Yl8kiCnSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=DIKL1tTH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=puHOAml5; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id F351113835F8;
	Fri, 21 Mar 2025 07:27:32 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Fri, 21 Mar 2025 07:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742556452;
	 x=1742642852; bh=oeGdq3COhEWXv4dkT1qL2ZEynnjMCsY6SrnZu9bkeuE=; b=
	DIKL1tTHnn27XAyQhSQTzYdLrkf30fiyRUvXNaIvwg7pBhlPnrW4MA6ZEssqAad7
	8/ulmcr5Sslb211v505HTLvmZYv4vxgSiLv0BgJjDax+EyKuB5SrYP42/+U3sKrG
	2KyxKKhoo4zhyH0rzOKelbydtLnoNm2XcUn6PSE9DhFVHlBkVyN0MCBd4N64UrQe
	8Pyjvdd7EBTev6A1kAmcWTW3oNtC78/YVn0CdFOyY+VmITWSuSS1q+JDWcnO/aCl
	4LahDpv1jTb16+MeUojrCBnfefBsXWpkw7tJ/44JZ+KAWe8Ur5lchTJf4SlTZIgK
	qpORxVtFyimFm8I3EAB10w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1742556452; x=1742642852; bh=o
	eGdq3COhEWXv4dkT1qL2ZEynnjMCsY6SrnZu9bkeuE=; b=puHOAml5XGRJ0hV/H
	DBjYE9cTqJDttlQeAg+irpYlQwg3MKitZe4CuvkmweW44MO+NbTyjebGG6PL6p6e
	6k9LKTTmjFotLpo8M151MZM7iLtE+zU9csTX0dTKEKgSSpnnEHDp4tl7omLtx2V3
	U+S/gUdi9/0j4G87z5Fskqfv5f7sd3qEcC9keiu0I7cBODMn4LYW70h3OfaHM9ec
	PcF6rt4t4uya+W4a28dwYBF6hVXLtIa7XmeVHsAzA4FenqkXxINmEI+T2oOXMdyk
	uGChQDvddQj87f4pk4JChvv3sbN9l4iW0UTUm0e4dW8vJ8gg31aIZv3/ca08OBnN
	4qihQ==
X-ME-Sender: <xms:JE3dZzH6hPN0NKKYvbV-GoUsuFY1a1OrMvr2_wBQvFh_ZLUI8hwfYw>
    <xme:JE3dZwWpiJM5-WQzV-1lsbS6ea5yc9FGSeyjJTRjlAAioRlnVgGnasgRZ9BVbEABn
    sl_-RtcYweI4KpkwgM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedtleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhkeeltdfffefhgffhteetheeuhffgteeghfdt
    ueefudeuleetgfehtdejieffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehpthgvshgrrhhikhesshhushgvrdgtohhmpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JE3dZ1LNBrfN9FFWMlyKA-3jJnP4eckpQ463ffw1gRlltE6yehgxDA>
    <xmx:JE3dZxGE2LK67U34xXvGJFfwL8ZsBx5Xu4csfIZuzcB0OYPc5RcDhQ>
    <xmx:JE3dZ5VFx2ZyQ8Tq11Kf_-uZSEspxB2RJugG5rHYwdBoRE8ZTQ8meg>
    <xmx:JE3dZ8Man6dOfmg9_o4dvnQnh5ohSDNBZoAWgA9zYrSCZK23Poo-ww>
    <xmx:JE3dZ2iQO1paWEux75_QP6C3TINoQQ_9PZKdMoDXG-jjA0UepUPvkGHs>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A0EC12220072; Fri, 21 Mar 2025 07:27:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T9b21d87368416b97
Date: Fri, 21 Mar 2025 12:27:01 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Brown" <broonie@kernel.org>, "Petr Tesarik" <ptesarik@suse.com>,
 linux-kernel@vger.kernel.org
Message-Id: <31f54b9e-6140-4a21-bfb3-ce07febe4e36@app.fastmail.com>
In-Reply-To: <b32120b4-3805-43f0-956d-3c28810fc8b9@sirena.org.uk>
References: <20250320-regmap-spi-write-read-v1-1-31666bc6ebe8@kernel.org>
 <b32120b4-3805-43f0-956d-3c28810fc8b9@sirena.org.uk>
Subject: Re: [PATCH] regmap: spi: Don't use spi_write_then_read()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Mar 21, 2025, at 00:08, Mark Brown wrote:
> On Thu, Mar 20, 2025 at 11:00:34PM +0000, Mark Brown wrote:
>> Currently SPI reads are implemented using spi_write_then_read(). This is a
>> convenience API which as well as constructing a SPI message from parameters
>> basically the same as for a bytestream read operation also bounces things
>> into a memory buffer to allow callers to use stack or other non-DMAable
>> memory. Since regmap should already be ensuring that everything can be
>> DMAed further up the stack this copy is redundant so switch to using the
>> underlying spi_sync() API with the buffers provided by the core directly.
>
> I think this actually needs to be part of a wider series, but pushing it
> out there just now since there's the other regmap paths which also use
> spi_sync() and will need any adjustments anyway.

I can see some code paths that are potentially broken by this
patch on its own, e.g.

struct sc16is7xx_one {  
        struct uart_port                port;
        struct regmap                   *regmap;
        struct mutex                    efr_lock; /* EFR registers access */
        struct kthread_work             tx_work;
        struct kthread_work             reg_work;
        struct kthread_delayed_work     ms_work;
        struct sc16is7xx_one_config     config;
        unsigned char                   buf[SC16IS7XX_FIFO_SIZE]; /* Rx buffer. */
        unsigned int                    old_mctrl;
        u8                              old_lcr; /* Value before EFR access. */
        bool                            irda_mode;
};                                                     
sc16is7xx_fifo_read(port, one->buf, rxlen)

By no longer going through the spi_write_then_read() bounce
buffer, this will do cache management operations on
sc16is7xx_one->buf, which is not cacheline aligned.

What particular operation is done depends on architecture,
but commonly the dma DMA_TO_DEVICE is a cache flush while
DMA_FROM_DEVICE is a cache invalidation, which can cause
data corruption on the members next to buf[].

If your plan is to have _regmap_raw_read() always do its
own buffering (at least for unaligned buffers on noncoherent
devices), it will still work.

     Arnd

