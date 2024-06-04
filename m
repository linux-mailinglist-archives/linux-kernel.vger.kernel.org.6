Return-Path: <linux-kernel+bounces-201358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0481A8FBD7B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1001F25534
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0929B14B95E;
	Tue,  4 Jun 2024 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="rt5wkcnM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EgwAZyHx"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC09A17C96
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717533870; cv=none; b=bAPKiuUJdXNP+IniEBc36ImI5LrOmlfOtSy7n6M5nlA0BbTdaj2uj507ZUttkdzQoSJj59qmtFZQ4Es0ihC1x7CcFNdZMJykM/fydhawvNLqs6Lex/LG7xrDkzFkBVgMuBUlqHxEv3x73xuBa49LyZyocq2SX47tkatvIdPVGEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717533870; c=relaxed/simple;
	bh=qGsJoVWGIXRR6EZOQ6zWSLZrKA+DNRVmMtHVIStMYw0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Gu2ZWZ4+AW4R765QRLzmbREL1Rc8qFIOQNdyNU3CIVP2sLAHLKIBqFtWkww0vMeTfIinv1+DIdUs2vBB8ueM9Vq5VwgKcU8+fE8+3acMFwKW9gbraY+q7ET5Udx4BWG229UpGFSpUgOC+4Xy5jxoEzCnnOOk+kHmmyYIX4BZhOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=rt5wkcnM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EgwAZyHx; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 5ED041C00103;
	Tue,  4 Jun 2024 16:44:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 04 Jun 2024 16:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1717533867; x=1717620267; bh=DUlLXHTsEg
	6djmJNv5xbb47t6tnsAq3EkbdxwP3J7f0=; b=rt5wkcnM5nfIBC1sUpUxILqk/h
	3hUNWTKdIdRhZUbhMnvdZvnU4dUS48V7gGT34W/W56hmC9hjAAVha8kUw0JWkJDf
	gS5z8hUszl1kNWEo+ijtgL/mbufSt0U1UAFyGubzl2+yTiSBnzg/NU1ViuJsfoIM
	8NggfvouU0v3DWa2VGemv/HplpzozxKD8uF4Km4ckxmlzqVor8lEq5mkoHY3C8XU
	nd7SeQ7/kfqTcPgsFikusF2cY6UrI91h+w7dbxIKlMgPftcbhATmqPeYmb8HMxte
	HefpVq/tN7Rx4eBc5qBMsK8SHewA5T7v5L5aGd1LyvJn513HrqpOgYWp+Hzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717533867; x=1717620267; bh=DUlLXHTsEg6djmJNv5xbb47t6tns
	Aq3EkbdxwP3J7f0=; b=EgwAZyHxsON2JAOoKIyxIn0R6dgGdjsaUa/l5E7LmzLR
	wi8kUXc1jAv7EAMIyONKUqW1LCylDdn1cLZcIjkW6msibQZ+fb8+9hs0zEXY/JSn
	CjYhQgBmWyvMkE6Qp4qIXyoSAbeiNNI/f6yBPxdC76s8n+p8zw5v89vsoo3cSNH2
	O0b+Dt//Ft25UQUhW2dbD0bZ3XFkwcXwfzpsvBqSaEpjI+OXl5HfIwyemwrbp4LU
	q+fb1oAuXmVkOmgCJFaKODjPAsRwWuu/cuXZccftPuvsoijH9de/dVwL0x81XIoS
	w5e4kLZMG2LcZayDZUw3GJgZxTcsVQDYZWUyHhIw/g==
X-ME-Sender: <xms:qnxfZlm33EsG7kaWg5RRxv0CAI_6wVyuSI7IPOFoRsGRkp8BuoQ4KQ>
    <xme:qnxfZg0jthXVsqBSQp5ZMsvSe-SJ_FlJxCHAMytWXcZkc4UUdjAaWf1hna9raRDey
    tWrGl9rR00SkPAk0qM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:qnxfZrryZm8ASfWGAgfJyjSWumZUAelgwwDTokNFhvOHGi3zyJlXfg>
    <xmx:qnxfZlnhQ0FnXfgfPkKrSupESQMwp4_t_h5i-lSRoykF0eZdSlXzLg>
    <xmx:qnxfZj2trO5LWEtB5mrjPNxwfAFAGg-VHaIG24zQ7fiz6Wphcs-Oog>
    <xmx:qnxfZkstTd7BtVz8fAK9QPhTG8JITSi6EjHk32lhx9dpkMFqne5RXw>
    <xmx:qnxfZlwKaLOx7T1_MUXpr-sI1PKCBEUj8y_qR7kZlDkL_vdVglM80fd1>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6F0A5B6008D; Tue,  4 Jun 2024 16:44:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fd2b865e-ddde-40ff-95a9-bc43bd48b549@app.fastmail.com>
In-Reply-To: <20240604201251.GA791043@ziepe.ca>
References: <20240528153717.2439910-1-arnd@kernel.org>
 <20240604155536.GA20674@willie-the-truck> <20240604201251.GA791043@ziepe.ca>
Date: Tue, 04 Jun 2024 22:44:06 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jason Gunthorpe" <jgg@ziepe.ca>, "Will Deacon" <will@kernel.org>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Baoquan He" <bhe@redhat.com>,
 "Kefeng Wang" <wangkefeng.wang@huawei.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Mark Rutland" <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] arm64/io: add constant-argument check
Content-Type: text/plain

On Tue, Jun 4, 2024, at 22:12, Jason Gunthorpe wrote:
> On Tue, Jun 04, 2024 at 04:55:37PM +0100, Will Deacon wrote:
>> On Tue, May 28, 2024 at 05:37:11PM +0200, Arnd Bergmann wrote:
>> 
>> I think this is superseded by Mark's diff in reply to v1, right?
>> 
>> https://lore.kernel.org/r/ZlcODqVXTDh6n0h-@J2N7QTR9R3
>>
>> If so, Mark, please can you post that as a proper patch so that we can
>> get this fixed?
>
> I wouldn't say superseded, but I agree with Mark that we should have
> the __always_inline added to the __iowrite64_copy() and
> __const_memcpy_toio_aligned64() in addition to the stuff here.
>
> When I originally wrote this I copied the fairly common pattern of
> having the builtin_constant_p test inside a macro, but I see now it is
> quite common to put that into an inline. Putting it in the inline is
> definately much better, so I like Arnd's patch.
>
> Arnd can you just make that addition and repost this?
>

Yes, sorry for failing to follow up earlier. I'm doing a little
more build testing now, will send soon.

   Arnd

