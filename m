Return-Path: <linux-kernel+bounces-439114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8599EAAF1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4502809C9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE1B22E3E3;
	Tue, 10 Dec 2024 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BcU/kg5E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O3Skgj/X"
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94892AEE7
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820401; cv=none; b=FrP9NNTSzoBGvF5/PeekgOcg8AvV9TT16lL5ZF0H3WHHPP7YOne5m16jtVINOprd2YTAj/R2iiQGu/FN7a1oVFvYVuyCwj7hpKP7j207Mgzx8CYfwgNrZuA70qqDpsDEIvXTMfv43I5gzP+40vh7OCtMTHKxj2fzwT0p4ssk99w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820401; c=relaxed/simple;
	bh=uQqwjUTPiQQt+f4tYkOg9flK7igU0UGqZy9dJWSGFNY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CEJWes8BRqdIuXS7TrXzG6VSlzcPdRYkHewAiXsRJoDlOcQIlz0ucK8LwFSSdvgrxDAsK74YDbFeHMm2XJJpcjAyhI6Ov3ADq/gRgtLBVs6zVDe4nmnQwAGvDR5JWCoAld+4YiBB++ZC2FZEC2GEogen0AyJGExRGDcioHqKj3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BcU/kg5E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O3Skgj/X; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id C45D31381D88;
	Tue, 10 Dec 2024 03:46:37 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 10 Dec 2024 03:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733820397;
	 x=1733906797; bh=85LRYKUeIbL3UcQvmEcS0/dbZ7pj+vVRPWkht8UMN7g=; b=
	BcU/kg5E19YhIVE1aCBA9Qbwu/wol6eaRPiPiSlJH7BI28RvoTR6M/AEQyKWkAj7
	CR7f6JBy/Vzao1ZVwvrIslxbDrn//duoqn0A5cOzsPr+el1Q6+A/3SK4t0Kdppjn
	BLyLiNU1d87AZSfdeClY7wzSk6G9l9DhSlcor1Boxn4YHsCYwBd5CumZFCtuz+hG
	JQmWpk3ZCsuFNGogYIMi2VL+weHjRX901p/FoN7aM79EnPfyvSwVT1d+TbD4hz/H
	2mRNjzov6NweuxpSB1teThKDkX6yUvmoxWIbbr8NDEVMHNwH8+4gN5DsBCiOmX+z
	jv7V0NhlunsW69pRop2hUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733820397; x=
	1733906797; bh=85LRYKUeIbL3UcQvmEcS0/dbZ7pj+vVRPWkht8UMN7g=; b=O
	3Skgj/XKrzu1v5ERSTy3GR+o5Jg7u0HGga27Az1k3kGVzbyqASbenx84XWalyG1c
	tskzb+l6gM2Pza1WHjk5XTuc2QnrOL8FjcoXfQM6N6xj6ep4po+QTwzB0egzENN+
	fJC/j738ryWmG/EETVJ8nij8C7TB4KVK/itUF6f3Y/TyCAV5UhVy/G6o1r0Kx+da
	AEa4VbGICJqxQ+YUame2P1j27kkPyAwCK7oF0QY48P6AFBT5UTB8Te5nhIaw8pMK
	9QzL+P3KAj0/QiGum2D4uy6C8zJdCBHJv6tKBMzBJL0N8CWIwK9Kh6JncygTVBOG
	a6keOVdfxWtDeicKEldBg==
X-ME-Sender: <xms:7f9XZ50rdLGghJi6cVkt-Ia-9j_5lbvIjQyXBKFAuTnScZBcCtPUSQ>
    <xme:7f9XZwG8V5DGo8ql5QmAeZshShSiwNN6T8D95ceh74cxAkbbE4zus03NQDRE3qkHI
    CQ-zPacZzcZcrY4s6o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeejgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohephedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgusegrrhhmrdgtohhmpdhrtghpth
    htohepshhuuggvvghprdhhohhllhgrsegrrhhmrdgtohhmpdhrtghpthhtohephigvohhr
    vghumhdrhihunhesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvg
    hrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7f9XZ55KkG43CufokNv_1iaFKmxmWAAEHBQLXbFvLWu_jszg2qEtkw>
    <xmx:7f9XZ20lBcmeRkYZbtb1uRQgA5SKynlxQb8quDxv-KGw1hnLbR6ZBw>
    <xmx:7f9XZ8GhkHnY1hGgePXp0CVuu-IIofGN7FIxITANgKSwT1FLPhS0cA>
    <xmx:7f9XZ3_hurDHfKdbl6BV7l7YTLugMv2qKT9qFbqgbZuzGKb_NXM7Yg>
    <xmx:7f9XZ4gX0SAhp00-_1_jM268_u791VYrVwQGChoWA1NunWtI_YWnKqVZ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7B1282220072; Tue, 10 Dec 2024 03:46:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Dec 2024 09:45:51 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: "Sudeep Holla" <sudeep.holla@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 nd@arm.com
Message-Id: <d750f114-8a25-4c84-912e-b6fb407a5150@app.fastmail.com>
In-Reply-To: <Z1fvkpYvqpnjPZA8@e129823.arm.com>
References: <20241203143109.1030514-1-yeoreum.yun@arm.com>
 <20241203143109.1030514-3-yeoreum.yun@arm.com>
 <9e60e996-070e-43a7-80e9-efdfda9f6223@app.fastmail.com>
 <Z1ch52AthTYVhtH4@bogus>
 <0cb655ee-9401-41bb-b9cd-580e0aeef2be@app.fastmail.com>
 <Z1fvkpYvqpnjPZA8@e129823.arm.com>
Subject: Re: [PATCH v2 2/2] firmware/arm_ffa: remove __le64_to_cpu() when set uuid for
 direct msg v2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Dec 10, 2024, at 08:36, Yeoreum Yun wrote:
>> On Mon, Dec 9, 2024, at 17:59, Sudeep Holla wrote:
>> > On Mon, Dec 09, 2024 at 04:27:14PM +0100, Arnd Bergmann wrote:
>>
>> Looking through the other functions in drivers/firmware/arm_ffa/driver.c,
>> I see that most of them just match the specification. One exception
>> is ffa_notification_info_get(), which incorrectly casts the
>> argument response arguments to an array of 'u16' values. Using
>> the correct bit shifts according to the specification would
>> make that work on big-endian and also more readable and
>> robust. Another one is __ffa_partition_info_get_regs(), which
>> does an incorrect memcpy() instead of decoding the values.
>>
> Conclusionly, Yes. But the RFC 4122 said with network byte order.
> to describe how uuid is saved.
>
> but I think the endianess to load the register is not a choice.
> because the spec says:
>
>     UUID Lo  x2  Bytes[0...7] of UUID with byte 0 in the low-order bits.
>     UUID Hi  x3  Bytes[8...15] of UUID with byte 8 in the low-order bits.
>
> this means UUID.bytes[0] should be loaded to x2.bytes[0].
>            UUID.bytes[1] should be loaded to x2,bytes[1]
>            ...

I meant they had the choice and chose to specify little-endian
64-bit word to encode the sequence of bytes of the standard
in-memory representation of UUIDs. 

> That's why other software spec (i.e tf-a) doesn't loads UUID from register
> wihtout swapping byte with endianess but just copy it.

If the uuid is transferred in memory, you obviously don't want to
swap it. If they pass it in registers across different endianess
code without specifying the byteorder in the caller, then they
would have the same bug.

> The bug is "not send UUID according to spec" in kernel side
> That's why it fails when I send message  with direct message version 2.
> So, it''s not change code unportable to portable but it fixes according
> to spec (load UUID as it is in register wihtout endianess).

Sorry, but you are not making sense here.

Sudeep, should I just cherry-pick your other fix from the pull
request and ignore this patch?

      Arnd

