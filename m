Return-Path: <linux-kernel+bounces-411758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC319CFF3D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 15:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A6EB25E65
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 14:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1881426C;
	Sat, 16 Nov 2024 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="QfzbBeD1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IniUWIzZ"
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5318C8462;
	Sat, 16 Nov 2024 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731766869; cv=none; b=oRNGuwTwys5CXnmBZTZKJ8BXNBefkZPxyeBTk7NrXrvEb1l6KxPi+l7xQCpFO2Lqnur8XiVaNz95ahV5xHPRRyfsUaKu3o6Z1gib9v8UvqI8QCftxCJ4s3fWhRyP7fLVsfwxAsI6rqNsPip/w/j7NtTQQr/YQomz3sMMJk7ENhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731766869; c=relaxed/simple;
	bh=83ROZP99NHhTBCZDaK6Qiko/B+ob6DGV88osQP9CYow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyWpb8on3Rz2cDjY7CY12mt/zkw74s9cqKc0bsmsV518b3NMJlqGEgaUa1csMNQLcZTEBiqaDp6tAKRPBx+9SlioquEfbZLZskoziRxcvKUb7sV1hHxoVkANVnPhGmcrID7AH69hSYdi1YvsjlNrTHW4iwSwP+xWHKaz1UFNXKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=QfzbBeD1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IniUWIzZ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4B05C1140135;
	Sat, 16 Nov 2024 09:21:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sat, 16 Nov 2024 09:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731766866;
	 x=1731853266; bh=NnZ+71/DdSs2iQZjBK1OW6Bj8CARVk7Y17qna5/pE2E=; b=
	QfzbBeD1RW/sWNjFNlzCSXgCVpVSGop3t7yqoUBDXT/zIHbFXXZnQUTy/gClkqN0
	KdkGaF1dpXHcTT9cTz4L9F2UIaoJfJyahVri7boWGXscUDwRKBJpzclLM5y/z4qx
	N8US60oPqTga9qfTaf8iPuubS/GpqWR6E5VtU++Tn7HlASRIEz5E+j0SoLXbHV5z
	FQuSKyXeJZfT3jSLiTmZrj8k6HxSHHsKiB9dtTOMbQG0kW1dxWIZfntJ4HoVucP0
	/UK/F3+qEEg3PIZQr/s0YrYX1VhIxTA1QY7YtKKsyOzx0OBbDdoCNQGhmZ9m/D8t
	qtJcKJeN4YnXZH2QUIoSow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731766866; x=
	1731853266; bh=NnZ+71/DdSs2iQZjBK1OW6Bj8CARVk7Y17qna5/pE2E=; b=I
	niUWIzZSVccQU9QPJoduSkdkMzUMyph5sqPfidr+xGwaHqDPCArdbPOJR6dB0fWo
	y4d5aIdQnOdhOLt14C20UD87lA6isoditurhOgliQoAFPnBrzJRULnSya/68cjgx
	V8cwH8L2kto4utteQH70+rK1rMdvxAecGtU89+kZfPziJEdFdfsI6/IqT5E3Fz+/
	OLhTCyNpFzaU8ZPGQ9UFkFF9DIG3h3ULUrnvBrj1b3KtyFrJIwLFH8U79PKSp2hT
	2hPhwgITlwug6MD/6BwLYzUKNeRloyRwiN3bg41qhWoF0S0hpPiEdoMQyIeCNZxs
	v4Z9WQtOtn665u+aGIxQw==
X-ME-Sender: <xms:UKo4Z5Jg5J0aoDA1rmMNY5Wig2A2OUrnElqf6nmCqBUiAIlZd0O00w>
    <xme:UKo4Z1JmjlNLHRB8FNObvmlYKYi1-5pTPsnVUdOQg2HJiammnwExEBdoEl3s8G6MO
    npo241FKzyTZMjcYCM>
X-ME-Received: <xmr:UKo4ZxuVh-qB-M-11LzYZGAkIhBjZlCj2mB1-9RFaZU3AoyLMcgwwF7SX56JVbjiskiw3IFRxhg3cAZmdfTXFumSjFrLt1weiP8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdeigdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomheplfgrnhhnvgcuifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenuc
    ggtffrrghtthgvrhhnpeevfeekuedutedtvdffvefhvedvkefhgfevheefhfffheeftefg
    teffuefgveefhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohepvdeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehlihhnrgesrghsrghhihhlihhnrgdrnhgvthdprhgtphhtthhopegu
    rghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgt
    phhtthhopeifvggushhonhgrfhesghhmrghilhdrtghomhdprhgtphhtthhopegsohhquh
    hnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhu
    ohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:UKo4Z6YqeM8yjUblx70moc4kZkBcvu1sWGaSMDfwEV3CUnhC5z927A>
    <xmx:UKo4ZwYRx81ttBhVaoTF-CkILBbssejrXpzukB6i9ujXTfh4fLvZuA>
    <xmx:UKo4Z-A_fN2BtxLKkyq1wgxMXL_CfcJO-VfAOOefuZvQe8aXJYO71Q>
    <xmx:UKo4Z-YDaITSK8AMfTOKk-LmPuapH2MJe9zB-Kwa--4nVNMwF-AuYQ>
    <xmx:Uqo4Z7tvoU4ARpzlIbgFvoABTViD_HY5gL8b1pbdhChvZxIbQcwrW8Ib>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Nov 2024 09:21:04 -0500 (EST)
Date: Sat, 16 Nov 2024 15:21:02 +0100
From: Janne Grunau <j@jannau.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Asahi Lina <lina@asahilina.net>, Danilo Krummrich <dakr@kernel.org>,
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org,
	asahi@lists.linux.dev
Subject: Re: [PATCH v9 00/29] Generic `Allocator` support for Rust
Message-ID: <20241116142102.GA1484376@robin.jannau.net>
References: <20241004154149.93856-1-dakr@kernel.org>
 <3b843e34-48f3-41ca-bd83-9bc137ca6c76@asahilina.net>
 <CAH5fLgg68b-pfGhDubJMzGA8w4dywviMv+ghw0KV1emFvNKe9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgg68b-pfGhDubJMzGA8w4dywviMv+ghw0KV1emFvNKe9Q@mail.gmail.com>

On Fri, Nov 15, 2024 at 03:00:43PM +0100, Alice Ryhl wrote:
> On Fri, Nov 15, 2024 at 12:33 PM Asahi Lina <lina@asahilina.net> wrote:
> >
> > We (Asahi Linux) noticed that this doesn't support unsized types, which
> > is a regression from the alloc Box. drm/asahi uses boxed trait objects
> > to generalize across certain object types like render commands, so this
> > breaks the driver.
> >
> > Is there a plan to add this back in? AIUI this would need the
> > coerce_unsized unstable feature, but is there any other blocker?
> 
> We're already using coerce_unsized for Arc, so I see no reason we
> can't just add that for KBox too. Soon, we should be able to use the
> derive macro [1] I proposed to do this without unstable language
> features. The limitation that the RFC mentions for custom allocators
> does not apply to KBox because it uses PhantomData<A> instead of A for
> the allocator field.

I have branch rebased onto rust-next and Danilo's "Device / Driver PCI /
Platform Rust abstractions". In addition to coerce_unsized for kbox
kvec misses the unproblematic methods clear and truncate and
array_try_from_vec. drain() as taken from the rust library looks like
more effort considering kvec's IntoIter.

Janne

