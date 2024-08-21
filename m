Return-Path: <linux-kernel+bounces-295396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258F0959A6E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0DB1C21784
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C151CDA0E;
	Wed, 21 Aug 2024 11:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="A1G7qmxG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rrej/QeG"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3861CDA04
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239098; cv=none; b=bDt1EyhyXRS4y4CwPPIoZTeHab46rO48HCzGJbWmF4GJsoLF2BsBqynRuLc0ZIB6A+v8vOmKUUaV8HjwFx4h4ytU1ntEBRupl5LFdvqhCE1DH+tOEMeaQ7xp4dnCK26eXec1gwE8TjFXCHaIG9IFCn5G0p/JIiYyPI6Ck8ORdBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239098; c=relaxed/simple;
	bh=1OW1DdjERVqL3qpm1YnlUe1ul3PntEOzq1r6zXOhOcM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EwV2ZFS42KbFmJZOlDMAMbOIqx/Zi/CoOer0kPCrvnozjutQD8AaxOLqwMFdi8Lbq29F0E8qVoZDJNBAKR1u0VujWg4o3GhcSjr2icjr+uYoyFkmaUyMOHetpdPp214gzhuTwvz44lEC1joTc8VWAWbd8smXiSHbpHQX4VTSObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=A1G7qmxG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rrej/QeG; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7E912138FFBE;
	Wed, 21 Aug 2024 07:18:15 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Wed, 21 Aug 2024 07:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1724239095;
	 x=1724325495; bh=Qy9R3mrH4Qsrhc+am9tt1N7hPihxmtlFQ6Ivr0UbX6c=; b=
	A1G7qmxGLuFU4AtQgzB5RjZ4jeCwqLe/8Pp9HEUSKsmvtauD5/ftu9DsNxJdzecx
	fPt2X2udrcd1cRKksPrDzk5gZoLqzkkmcnm6WI2jMAVoBFt6uta8ZwMXSyJYqCxf
	aFjvwIuWhYqq2A1incfgXcYv0Q0Efqc2zvapcbeXXe+2jPDnLt/O8Bun4mCz6lid
	HLMeYDj+W9DndMyqPe1z9+hqVvnb+IIs6l89EdiPrLoj+EY4b/ednEMenKMT0f5s
	s/356EbU+hZpOYDVyX8Y2NLL6Zb4Chvno8e611GgtpRKqpye2/IPiQg8il3w2lPz
	bnPPPMLn8qQqnDRj+9Ly+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724239095; x=
	1724325495; bh=Qy9R3mrH4Qsrhc+am9tt1N7hPihxmtlFQ6Ivr0UbX6c=; b=r
	rej/QeG1jWALqAJurcMAqt5UqWjPpuWS89g3MG5AVCkv6PQYmuRXOg0dc7rRdm9N
	eFyncgn1AD7lPfjJ1pZVUQ8YBhHSxSkhS1WQeHnF4h+iKTqo+/QllZO4nQcUjRjB
	Zpzvi0+WIfVqA1M16K5acJxEqyrusnoOPdcUJi17tNwa9SjZn3U4a7yt2MW6wz+D
	N2MnWpROVNXq2TwR9YM1JgBX34AWm1ucIvxp8J1ZDtiXJeyv3AGHFQsbuE/aYxUu
	/1uS+8x24fLWNn/AVofghM/UmqnzAQ/PX/HI9l1iHLoBYlMVhuSFVzbRLro+IqKD
	P9sNg+7K49iafGwU3gnhw==
X-ME-Sender: <xms:98zFZlIacQygLGnh0zLG-QHxTYQnRD-oixg5EfZyRIMe8Qn8h6mNDg>
    <xme:98zFZhL9W5GRX8CplQnWHPSZS3L8WjlL_9BWQuggF6fagNxR7B2DQ99C2idfLM6V_
    kD4um0OEYqHC3-1Xx8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddukedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephedtleehjeeuvdeuleeikeetveeuvdeiffehvedu
    jeduvefgfeffhedvueejteehnecuffhomhgrihhnpehgohhoghhlvghsohhurhgtvgdrtg
    homhdpvhgrrghpihgpfihrrghpphgvrhdrtggtpdhkvghrnhgvlhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnh
    gusgdruggvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehrohhhihgrghgrrhestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepthhomh
    grshdrfihinhhklhgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopehgrhgvghhkhhes
    lhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:98zFZttEgWkIYZBqMgMMoPUFb4eKZMvrEjtxp1j9iHHKlcWme6QzcQ>
    <xmx:98zFZmZ_rrgt8NfL3sDG4kFlheT76Chx0QH7CBoGG1r7OyPBapOCQg>
    <xmx:98zFZsamDYvKV7buifplfuuggHe0xqKP_m-CaGZ0tOluBqCMVx4w3g>
    <xmx:98zFZqCCFGyLTZv1bORVLL_Py7AVqz5QnhWvZwJz9YzU2XPvYqokPA>
    <xmx:98zFZkGcjtLGum_uFGO2FF7B8aMzoSZy652JSOApe8GhU_PSu4N-mbbh>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2D39516005E; Wed, 21 Aug 2024 07:18:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 21 Aug 2024 11:17:54 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Rohit Agarwal" <rohiagar@chromium.org>,
 "Tomas Winkler" <tomas.winkler@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Message-Id: <25e56199-7af1-4235-8973-cbc351325b8c@app.fastmail.com>
In-Reply-To: <4d6f3331-5a9c-46f2-8e27-3484ba6f6eab@chromium.org>
References: <20240813084542.2921300-1-rohiagar@chromium.org>
 <75f758e5-a26f-4f41-8009-288ca2a4d182@app.fastmail.com>
 <4d6f3331-5a9c-46f2-8e27-3484ba6f6eab@chromium.org>
Subject: Re: [RFC] Order 4 allocation failures in the MEI client driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Aug 21, 2024, at 05:20, Rohit Agarwal wrote:
> On 19/08/24 6:45 PM, Arnd Bergmann wrote:
>> On Tue, Aug 13, 2024, at 10:45, Rohit Agarwal wrote:
>> 
>> What is the call chain you see in the kernel messages? Is it
>> always the same?
> Yes the call stack is same everytime. This is the call stack
>
> <4>[ 2019.101352] dump_stack_lvl+0x69/0xa0
> <4>[ 2019.101359] warn_alloc+0x10d/0x180
> <4>[ 2019.101363] __alloc_pages_slowpath+0xe3d/0xe80
> <4>[ 2019.101366] __alloc_pages+0x22f/0x2b0
> <4>[ 2019.101369] __kmalloc_large_node+0x9d/0x120
> <4>[ 2019.101373] ? mei_cl_alloc_cb+0x34/0xa0
> <4>[ 2019.101377] ? mei_cl_alloc_cb+0x74/0xa0
> <4>[ 2019.101379] __kmalloc+0x86/0x130
> <4>[ 2019.101382] mei_cl_alloc_cb+0x74/0xa0
> <4>[ 2019.101385] mei_cl_enqueue_ctrl_wr_cb+0x38/0x90

Ok, so this might be a result of mei_cl_enqueue_ctrl_wr_cb()
doing

        /* for RX always allocate at least client's mtu */
        if (length)
                length = max_t(size_t, length, mei_cl_mtu(cl));

which was added in 3030dc056459 ("mei: add wrapper
for queuing control commands."). All the callers seem
to be passing a short "length" of just a few bytes,
but this would always extend it to 
cl->me_cl->props.max_msg_length in mei_cl_mtu().

Not sure where that part is set.

> <4>[ 2019.101388] mei_cl_read_start+0xb8/0x230
> <4>[ 2019.101391] __mei_cl_recv+0xd3/0x400
> <4>[ 2019.101396] ? __pfx_autoremove_wake_function+0x10/0x10
> <4>[ 2019.101399] mei_pxp_receive_message+0x39/0x60
> <4>[ 2019.101402] intel_pxp_tee_io_message+0x112/0x1e0
> <4>[ 2019.101407] i915_pxp_ops_ioctl+0x536/0x6c0

Curiously, I don't see any evidence of i915_pxp_ops_ioctl()
ever making it into mainline kernels, though I see some
discussion about it on the mailing lists [1]

Do you see the same problem with a mainline kernel?

The only reference I could find to the DRM_IOCTL_I915_PXP_OPS
ioctl in userspace seems to be in
https://chromium.googlesource.com/chromium/src/+/a4de986102a45e29c3ef596f22704bdca244c26c/media/gpu/vaapi/vaapi_wrapper.cc#2004

>> Allocating 64KB of consecutive pages repeatedly is clearly
>> a problem at runtime, but having a single allocation during
>> probe time is not as bad.
> What if the length of the message is greater than 64KB, wouldn't that 
> be an issue?

That would make it an order-5 allocation. 

     Arnd


[1] https://patchwork.kernel.org/project/intel-gfx/patch/20201114014537.25495-5-sean.z.huang@intel.com/#23762967

