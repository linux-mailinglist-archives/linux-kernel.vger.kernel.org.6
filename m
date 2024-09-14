Return-Path: <linux-kernel+bounces-329311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10E7978FE0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 12:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24E31C21D10
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 10:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D94313B280;
	Sat, 14 Sep 2024 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="aORr7H8J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U9Nm20lH"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B71CE6FE;
	Sat, 14 Sep 2024 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726308715; cv=none; b=RBaqC1/rBTyRVQP+wKPHEV4MYiZ7NnkwA4bj33sbJ/TsMVxPa/hfZrUcuYnEjsYq2w6PuHHT6uZO2NFQPrOiU/zdbc0gNBhbZghKEYxkgWYsx7y7RhSd4VF1GKCg9nLAApo4OZxnRJML/s7p72/RoSkpiYKY2vCt2EZTShUc4wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726308715; c=relaxed/simple;
	bh=c7hrh1mNhY5Po59linuz91/Lp273Kl2sAkDSofcmW3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCMzOt6OkbAe/h9Sfqeyn5elVWiTNHxlUZKRhWr+bwwepxzKmfAhkFQyKxf+B1we468J6vI1Cb0zXk/pTQI9uPnMphHobHuurlgyKZ1wVVGQJDv+TEyiIG13rxvwGwaS4HqkFTKllBeUfox6bvxYdFCVglIxZoOxh8cJzVkYR1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=aORr7H8J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U9Nm20lH; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D141138034D;
	Sat, 14 Sep 2024 06:11:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sat, 14 Sep 2024 06:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1726308712; x=1726395112; bh=wdYBlJH1j2
	NJdmrQ3AgD6IKbm38HR2Yf3Znhh5VlisQ=; b=aORr7H8JGhZkcbuntmIvaMOGA0
	/MNDvEBK3EaaffdNtywXEszDv4oT8lgmjaAJSQ6hG4BZw3pyXUZ0HuxCFgW51Jho
	3mxbyvmk50xrGYlquXhO9YOAOFGgFsltTBmbcmDFqDlo3RqCG9omkTpF7ayriiuJ
	HxjmMyu8tF7M7aprtQ8tnmEszHEQLWNueWq5efKeL4iw8HZciroSaRIqJlDdr9Bn
	8xrCLzoGJ05vb0DdrlD43/tXcrLeGGYtF3NMicV9HmVnUolIb0DH3O6WwBH4S84v
	Op/8/PmCnq1TsZQqWGzYVx5XtRJUdpUStYtXAiSyjFzJn3UJ22qS14RzkREQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726308712; x=1726395112; bh=wdYBlJH1j2NJdmrQ3AgD6IKbm38H
	R2Yf3Znhh5VlisQ=; b=U9Nm20lH/voTbRJWFA4oNdsQX1ya+5iERjCc+qxE3p9N
	V6H3QXBWhGBNMpDapVyukAbnWJkhnoNY18qLSVd8bKe3irf9zwvfZrn+7KSepErX
	w3Zt9TGVJspLYGoC5482obPRi5YoxGuIb9hXjuDJLO2Q9jLLi252gYPhVXzXTJBn
	XHYqPUxlR5VWYeNnYUIFaqiOteX1j7xIaD0kz/A9cp2hOvuxOLzzfG2nfaPOZv+6
	4g8rDYXNBd5B0iwEjg12ecYIH0xzUDAhusQWpWI7o4TbmTycae11hBm0MKvCc0EC
	20vZIXKSTkSdDcnkuN4lGVjCK/aTKYGf8HBFo7Gx5g==
X-ME-Sender: <xms:Z2HlZgLGCIZ8gWL6kJFrNK_OJRgX8CdROU6K_bAEQdAXwk5Z7xh3-A>
    <xme:Z2HlZgI3cIECw5vwULhBTJ8t9KgInmT1VhnPb5-_kVfEnoo2lqfrZegd5WmuoMDEU
    Lz5XPEa5LAwbZcr2cs>
X-ME-Received: <xmr:Z2HlZguQa1dRX1HqSEuHnyIrsg3uN2AoNXiXIL9wWhUTJARPgtvtSegE0y1IC9Fmx5vYQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomheplfgrnhhnvgcuifhruhhnrghuuceojhgrnhhnvgesjhgrnhhnrghurdhnvg
    htqeenucggtffrrghtthgvrhhnpeetkeegfffhhfekhfdtveejueevtdefkeehgeekgeel
    teeluddugeeuvddukeeuffenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrnhhnvgesjhgr
    nhhnrghurdhnvghtpdhnsggprhgtphhtthhopeefvddpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhk
    hheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegrhihushhhse
    gsvggrghhlvggsohgrrhgurdhorhhgpdhrtghpthhtohepfhgrsghivghnrdhprghrvghn
    theslhhinhgrrhhordhorhhgpdhrtghpthhtohepugdqghholhgvsehtihdrtghomhdprh
    gtphhtthhopehlohhrfhhorhhlihhnuhigsegsvggrghhlvggsohgrrhgurdhorhhgpdhr
    tghpthhtohepjhhkrhhiughnvghrsegsvggrghhlvggsohgrrhgurdhorhhgpdhrtghpth
    htoheprhhosggvrhhttghnvghlshhonhessggvrghglhgvsghorghrugdrohhrghdprhgt
    phhtthhopegrfhgusehtihdrtghomh
X-ME-Proxy: <xmx:Z2HlZtaiPXWo0hoNfwFmPC9K2ADDDofXYS8ZgxTLBNIaDKBpiSKpDQ>
    <xmx:Z2HlZnZdFjkun-rTi_pNVt9B7MhEdaB-MEYhEQnEPnt7l3WQBz4S6Q>
    <xmx:Z2HlZpBrLGThc8Oyk8ay8ddteDZxWvpwHx7WsmKyt6rhy076VLNfMA>
    <xmx:Z2HlZta96gou4U4zmRiYrSQYPZ7O0VpCGl0y45bvGn_lJHxiPLwY6A>
    <xmx:aGHlZkwpfgeBBy3OeE8ggur4QJ_hWsPnlquY6Hme4l7QxApo3RtW2okr>
Feedback-ID: i449149f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Sep 2024 06:11:51 -0400 (EDT)
Date: Sat, 14 Sep 2024 12:11:49 +0200
From: Janne Grunau <janne@jannau.net>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ayush Singh <ayush@beagleboard.org>, fabien.parent@linaro.org,
	d-gole@ti.com, lorforlinux@beagleboard.org,	jkridner@beagleboard.org,
 robertcnelson@beagleboard.org,	Andrew Davis <afd@ti.com>,
 Miguel Ojeda <ojeda@kernel.org>,	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Rob Herring <robh@kernel.org>,	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,	Arnd Bergmann <arnd@arndb.de>,
 Nishanth Menon <nm@ti.com>,	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev
Subject: Re: [PATCH 1/8] rust: kernel: Add Platform device and driver
 abstractions
Message-ID: <ZuVhZV2KW2Gv340V@robin>
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
 <20240911-mikrobus-dt-v1-1-3ded4dc879e7@beagleboard.org>
 <2024091106-scouring-smitten-e740@gregkh>
 <ZuHU5yrJUOKnJGrB@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZuHU5yrJUOKnJGrB@pollux>

On Wed, Sep 11, 2024 at 07:35:35PM +0200, Danilo Krummrich wrote:
> On Wed, Sep 11, 2024 at 04:56:14PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Sep 11, 2024 at 07:57:18PM +0530, Ayush Singh wrote:
> > > +/// An identifier for Platform devices.
> > > +///
> > > +/// Represents the kernel's [`struct of_device_id`]. This is used to find an appropriate
> > > +/// Platform driver.
> > > +///
> > > +/// [`struct of_device_id`]: srctree/include/linux/mod_devicetable.h
> > > +pub struct DeviceId(&'static CStr);
> > > +
> > > +impl DeviceId {
> > 
> > <snip>
> > 
> > I appreciate posting this, but this really should go on top of the
> > device driver work Danilo Krummrich has been doing.
> 
> If everyone agrees, I'd offer to just provide platform device / driver
> abstractions with my next patch series. This way you don't need to worry
> about aligning things with the rest of the abstractions yourself and throughout
> potential further versions of the series.

Covering platform device/driver abstractions in the same series would
be appreciated from asahi side. It hopefully results in earlier merge
since it avoids a dependency on the device driver abstractions.
Feel free to reach out to me for an earlier preview / rabsing of the
asahi driver.
https://github.com/AsahiLinux/linux/tree/bits/210-gpu has all relevant
rust changes from 6.11-rc but I plan to rebase onto 6.11 in the next
days and possibly import changes from 6.12-rc* / rust-next.

Thanks
Janne

