Return-Path: <linux-kernel+bounces-292134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3B4956B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFEE1F23031
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6426B1667E1;
	Mon, 19 Aug 2024 13:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Hbe97Evr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dHOmJ4lf"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201111DDC9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 13:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073382; cv=none; b=HndnunDqNFgJsxGkrzEm+lGI4zOKxOJLbg/hLVf2JdzcsfHZdDGCZrnE+XocO6cDF2wnCPmCo+AV3RdtBB9XHgxDSuxhdbI7/UVlGasXfLVaBo8Nme8TukQSLLM98bZQo1Ie8qUMLhHv+MgnoVZQWBxItOfueGhkBbnF5zBnh40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073382; c=relaxed/simple;
	bh=o2jS8YmRqk/ZSwl44c85vrWbJ2gPnELSA/aYN0R/qC4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HdKWpr3Y6Khl86TTGsQeUULKx2NaN/uifisDkbGEzbkruhMyK0CLhRL2oxk3Z8W4v0kNgaYxDZUcpe/i78tClu+DRQkpWDmLP3YnaC3rErigZyPHfMJg2Itty7q4S8V2s+YarM3ARNbLB0Y8cZf5EhbjDhbH5d4kcWjqolI6Ahk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Hbe97Evr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dHOmJ4lf; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 224BD1146DA6;
	Mon, 19 Aug 2024 09:16:19 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Mon, 19 Aug 2024 09:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1724073379;
	 x=1724159779; bh=jDAmFQuOZmZ/8EFZkRlzWsfWB0xtYWEfyAXL+PeIbBE=; b=
	Hbe97Evro2WUG41TfstmgRRPudPPuQ9GW45mvpBFwUDUxOuwFXzTQEKurlXTg3ZV
	VH4yIOSuOSgOk5pFyt4B1bVvxW0jnvBjvSwFyEk9Noy3gHcly8OWbaxfxsLq5mCg
	1NZqA9o2gvRtQhMwCqU6Z+dNzJU7YKgDIQdt5U5xZad/AG09U4ahJt0us4Gl8xLR
	SFbEUfSoAGlizx/+3tUgdK1z7o1Xn5kKOHHDW9fRUM3avf8jn3qixJ+IdRG2VhP0
	PjevxAwmvrRKjj3BsY7lMuNbjO49ZPCVGc5MXoLZDQFezfujDjNg1SKz6P8DK1Xz
	NoXxf1XDc3ruqg3UOxnzcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724073379; x=
	1724159779; bh=jDAmFQuOZmZ/8EFZkRlzWsfWB0xtYWEfyAXL+PeIbBE=; b=d
	HOmJ4lfhy4psleF0twKm3NGoIKg4K2YCRnkhoiZd2mSX5XXuBtjeLI4WWGADNkSZ
	mKAsARXPiM89lVMIVjlgWASmkTOofIJ8x2w8lx7YeUMkD8LWDTcfr//Zlfw3f8J4
	GBr2Fu8I3vAfUI4D/MZIY3KuIJwY+n5VfUII6zFIoEQZXw8N/qni+0zYjYJMQ80N
	bKpSs9XgTjy98VtzJPA1s+DED5bBneTGOvh09Ze1mjGgdVeWHAX0kL/Pyy1sK1Z1
	CZft/CbwqkhmwurQxOoA4KH4cl8p5bcP6Fd6nvPC1V+wb+RQZgqJERp5d8s/fJLD
	d1hJbNFky5WeY/S/PrKUA==
X-ME-Sender: <xms:okXDZhzi9B4NhiGRB-3iIKebdDFDMqfzA2rGpdk4jN9TSDc-Xw6Vng>
    <xme:okXDZhSKLzNgubEPA2SezP1uZmztxb_pNryReKIhQTxM9ytbxigmc1SDNtJzYyTi9
    Wu0CYKyCp8MWNEINSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhohhhirghgrghrsegthhhrohhmih
    humhdrohhrghdprhgtphhtthhopehtohhmrghsrdifihhnkhhlvghrsehinhhtvghlrdgt
    ohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:okXDZrUaHBvItwNMZVigoGjgCAKaQgqVGqQrXmJqmNDt5o0Co564LQ>
    <xmx:o0XDZjhptaTUiQtJeq7kp3f9g85ERMTNr6RYhFwzWpHNV1xHtSF_3A>
    <xmx:o0XDZjDhqemvkg_8tDPQOE4qQFZ1I4cPiVfv0KYUQcncxtDbUhKrEw>
    <xmx:o0XDZsKdzNZ0vUhYN3nCzUIubyqwIYu_lBIkhWjFCQj3K6OPvev1PQ>
    <xmx:o0XDZqM5DvepkEC6iHf9fIuQfXUdcb-5oIMdnY3iUvm-7Sg0CmPxxQAn>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DB42D16005E; Mon, 19 Aug 2024 09:16:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Aug 2024 15:15:58 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Rohit Agarwal" <rohiagar@chromium.org>,
 "Tomas Winkler" <tomas.winkler@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Message-Id: <75f758e5-a26f-4f41-8009-288ca2a4d182@app.fastmail.com>
In-Reply-To: <20240813084542.2921300-1-rohiagar@chromium.org>
References: <20240813084542.2921300-1-rohiagar@chromium.org>
Subject: Re: [RFC] Order 4 allocation failures in the MEI client driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Aug 13, 2024, at 10:45, Rohit Agarwal wrote:
> Hi All,
>
> I am seeing an inconsistent allocation (kmalloc) failure in the mei 
> client driver [1]
> in chromebooks. The crash indicates the driver is requesting for an 
> order 4 allocation
> that is unavailable at that particular snapshot of the system.
>
> I am new to this and do not know the history behind the roundup to order
> 4 [2]. According to the sources, order 4 allocations are not guaranteed and
> should be avoided most of the time. And considering the chromebooks
> limited memory, this may become an expected behavior.

I don't see how that commit is related to the failure in
mei_cl_alloc_cb(), that one only rounds the size up to a multiple
of four bytes.

What is the call chain you see in the kernel messages? Is it
always the same?

> Can we have more details on this as to why order 4 allocation is
> required? Or can we have a lower order allocation request that can be
> helpful for low memory platforms?
>
> Some solutions that I explored and weren't applicable/helpful here:
> 1. using a vmalloc/kvmalloc instead of kmalloc (Due to DMA usage).
> 2. using a scatter gather list (Would require a lot of rework in the 
> driver and still
> not sure if that would work as it would require changes in the 
> underlying layer as well)
> 3. retry mechanism (would help in few instances only).
> 4. allocating from the DMA pool?

Those (1, 2 and 4) would have been my suggestions as well ;-)
I don't think 4 helps on x86 machines though, since there
is no CMA area (and there should not need to be either).

If this happens during runtime (after the system is alredy
fully booted), another idea would be to move the allocation
to boot time where it is very likely to succeed and just never
free it again. Whether that works or not depends on the
exact call chain.

Allocating 64KB of consecutive pages repeatedly is clearly
a problem at runtime, but having a single allocation during
probe time is not as bad.

       Arnd

