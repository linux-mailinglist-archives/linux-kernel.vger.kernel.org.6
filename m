Return-Path: <linux-kernel+bounces-449052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553199F491A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D10257A4E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB54B1DDC3F;
	Tue, 17 Dec 2024 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="CP1evQie";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GKV/m6CW"
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CD91E3DF7
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432079; cv=none; b=IAmNQS2ZPJ4doHscbUIQv2Iowute2NzZV6LNzdRDwN6+chRS8GdaSERFr0NpFdFFTXTnQoRZg2jlbiEpvGSqMb6OpThfkTWektCJQEGW8fm7LQfBCcX8Oj64v7vvo2qIo7LRKwW1kVU2Xa03YOj0SImi4aWTDWVC9u2XCK/AkoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432079; c=relaxed/simple;
	bh=JbB3DqItbZT8U1Ti7EGXc9z4W3+l8Q4TSVtADO0Z+Vw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=c/cPEfCo50GgLgDwptvSRVhmwiuZdUxTgemnQCkVsBw007SsVkgVpdLT9AX6QoysVWXydbYuZF6OFLClnGyQOIIBtvuQVpcPtuI67UdZAaXB8+jf7XgoTNwBeHy9QRx1UkLvCQuMYSdgDkEo0G9zb26/OZT7A3kkFTlgefqTqhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=CP1evQie; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GKV/m6CW; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B72512540196;
	Tue, 17 Dec 2024 05:41:16 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 17 Dec 2024 05:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734432076;
	 x=1734518476; bh=nQbsDzhovafTMtuYVtRUcRqyLmRPs0PvON3BGL9CJZc=; b=
	CP1evQieaAhzpxAQEr2oVADIwswbkPIpNQbFWxdsMPhTcMc3l5epQbk+i9LOEUhq
	2E0IYGgowfxad4in6U9eEvFlSMWIH0e1tR3Tf3Fb1+t6pz+tgrmZZNHYmdq2PNYF
	1+8yDyo4f1Q2TbIxKw+wkvFZpLehKPxwxaPxdgl8RUFuVZj7/dVXJhuZQI/MF2iA
	gLYeyaNFR47jTC2GznD5I8vWZs7wTJz5gyJskQPsZcyuykUWoQj7uhyNtG7tDVwI
	gWCWA2hm3HbxL6DFkEIsTP7Hqpx0eRlwUh+eZEoOGQTQlzMQnU/YcnzKTecdRYri
	nnAI8KElUeKRLrI03SjP4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734432076; x=
	1734518476; bh=nQbsDzhovafTMtuYVtRUcRqyLmRPs0PvON3BGL9CJZc=; b=G
	KV/m6CWTtocajWP4BepishXIYIQeX3nRnmLvqKHYqWa7X+nSoHZfdB0ODAs6+VvZ
	TXSwBfRsm1gC4Ez+TyJSAG/Yy0M0zZ5UWZv2MCPOuhmAd9MYXMQcF3N65/Lowcwi
	E2BQmQhR7GXr0kuLbb9kIzJnXL0crH+aoJQZUBFE6KYHOhM9oEcEPEjduB8/u/yL
	+PfhPxW0hSZiQpoyybXDrySz2X9JA9nKdFqY8OJy8tsbFqyZjLS5zvK8ZX+lh6hJ
	mxE1SdEgD/arIEtdhuIAy7agvUHNWQxsaZGjrW36NA89/CefN7pn35nJ+SU6Bwtm
	0rZIKJD6fs3EI+HX6vn5g==
X-ME-Sender: <xms:TFVhZx2vZzfEMP35mR27vqZjy9WC6yK2Exmq_cJTAvCbpa1hJbgFCw>
    <xme:TFVhZ4G5K5uE2Ifwe0041ZzOfM4cV_fauw5xqKp14LbYs6mgJh9p5nUO7k8a_hCcD
    UcQrNzE7aih6blFzok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleehgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpeekvdefgfeigedtuddujeduueekleefuedvtdehfefh
    jefhvddtkedufeekjefhkeenucffohhmrghinhepghhouggsohhlthdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehjphho
    ihhmsghovgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgiekieeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:TFVhZx46lDJM3SPetIcDnZxRRaBIzxq48hTQxErP-pQitkMmYNlJ9w>
    <xmx:TFVhZ-0e35HHCVEub5NGWtnIrzHMhF4kVb2HET2y6c-ix2m_Qxhflw>
    <xmx:TFVhZ0HdiNZcIDsS8EPOgRijJvyVPeUXaaVFcboMA8cAcoGOBFQuFg>
    <xmx:TFVhZ_824SWtozLx3K0nIfTCVdXfPvrdwIkydFlNQ4TCZ905452l6A>
    <xmx:TFVhZ4Dds_ywSRTHoXuCYfVUBTswXr-_kXCkADRedD8ckMhe4d_x3vx0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5D8642220072; Tue, 17 Dec 2024 05:41:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Dec 2024 11:37:54 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Message-Id: <485d1139-0c09-4d56-b076-e3e0f131b738@app.fastmail.com>
In-Reply-To: <710349fd-08df-444f-b8c6-86b1249810df@app.fastmail.com>
References: <33f3a0a3-a929-4584-af81-6e020671d428@app.fastmail.com>
 <710349fd-08df-444f-b8c6-86b1249810df@app.fastmail.com>
Subject: Re: "relocation to !ENDBR" objtool warnings
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Dec 17, 2024, at 10:09, Arnd Bergmann wrote:
> On Tue, Dec 17, 2024, at 09:54, Arnd Bergmann wrote:
>>
>> 00000000000000f0 <stpcpy>:
>>   f0:   66 66 2e 0f 1f 84 00    data16 cs nopw 0x0(%rax,%rax,1)
>>   f7:   00 00 00 00 
>>   fb:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>>  100:   f3 0f 1e fa             endbr64
>
>
> I had one more look at the assembler file created by gcc and found
> that this is a 16-byte nop:
>
>         .align 16
>         .globl  stpcpy
>         .type   stpcpy, @function
> stpcpy:
>         .p2align 5
>         endbr64
...
>
> No idea why it got inserted here, or why it only shows up in these
> two functions. Having a nop before the endbr is a compiler bug, right?

I confirmed that this is only a problem on gcc-14.2, both gcc-14.1
and gcc trunk (15.0 I assume) are fine according to the compiler
explorer: https://godbolt.org/z/9xf7Ph8GT

       Arnd

