Return-Path: <linux-kernel+bounces-419278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808D99D6BAF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 22:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0E9CB2227B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 21:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534E31A01B9;
	Sat, 23 Nov 2024 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="wqNEyzw0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RYdH079U"
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941BB433AB;
	Sat, 23 Nov 2024 21:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732398930; cv=none; b=gn1umexq+jS9xTa0O68vhz2ft0XRM4cSTt5VI5iUv+/94Y4+O508sbm1c22pB+7Y7XWZRMb4L1JEp7ek9G+r/ifs30yxTE58iKer5VHTOvjZvVGfp02q/rYZyey/LlgpcQVinMmMX+f3xGrxgAE3EUCSZlBVH4XcgkXY/7FUARE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732398930; c=relaxed/simple;
	bh=Zm0X8fq4YUcxLOenPGPNsE5Ecb98VxC895SXkjIgr44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhKmFE35fHEPOC17CB1a6fgsJUBWqXaJ0pWsQ4zeX4kjplG3Oot3yTBj7l2oX6QqlDZMuRxNS6DgCZjkxTSIpRSyI90eAeiWpsmBkFqYlbn4Sbn3eH2D/0+m+bkCbjOfFL7v9I3bnRzc3evUkvSYUrzMgmjxxJdPP0Yf3LaJABw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=wqNEyzw0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RYdH079U; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 483202540133;
	Sat, 23 Nov 2024 16:55:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sat, 23 Nov 2024 16:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1732398926; x=1732485326; bh=E5wILRT4AS
	8VZN9JFqdkKAhXm0BT9f0VwX4OKcgHv2Q=; b=wqNEyzw0IGshKMb3jr9mmAOa7y
	ovdK3Wg7pmz0BVQUTSp4Y8M7ukRDgxBUHD8MS2ZvtEL3EluaXKC3nuQ7K958+KrO
	0Z2mXXkO/hapDA9KP0rQ/miriax4iHUgzcYZzRfnh0f0new2wVirk27w4Y4Zm8bo
	pXF/plgMjq3njCkDuiY1lJCl+qA5jwCulQFTN0cne+D5fbbgHWp90WOceGdSyQF3
	7hW9YyATWamP3nQOCPyCeqJnAa3CIqjKIyHzuxIMgsw/C8gIkztf22N5EzLDG/Nv
	xhacPAy/L7XeImCZX/EXCYZMd1MAhwrRBP0Cg5W8iYWjxtkz3ldhj45Ui3jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732398926; x=1732485326; bh=E5wILRT4AS8VZN9JFqdkKAhXm0BT9f0VwX4
	OKcgHv2Q=; b=RYdH079Ux8/0wIiszDS0lHQY10umfcpdOudMPSnYO0Emd6ljim9
	HC4Tbt7FZpQjawXpI7OFNkGREL0gtOnh8YaZ7hLXQwhNgA6hZzr3q1YH7AH3XTId
	WEizw+ZYAjkMqFLlvQGSr08+jR/NwhGO6kln1kZRfSp08Nw8tTClaitl0nObSO7U
	UMsb12q3fDPbBE3/eY/IL3EJIwURrF8aI6CD8QJ+L8ZDMt5Y7j8fh3e0W3J1aEVH
	tQIhE/nllzeVOU2Jrvdr7A+yqs17zvaSYbSq04t8YowhjLUx63KSp/mPp3MViHmg
	XHb50SAPWSh5xYQph7IigHdj+1xZnTKsoOQ==
X-ME-Sender: <xms:TU9CZ6sS_h2A8V8NTFibpB4xxKQEiojrrXrWkwIxo67FNNmLr1lfxQ>
    <xme:TU9CZ_ewjdFMUOyNma7pt-BF1kQj4Fky1Y_eJ9GY8Xs1AlPZ-TkG-r_mIl4Afoy9c
    hhmQBGpYlqtUS8B7zA>
X-ME-Received: <xmr:TU9CZ1ybZtPkd6Wx7GgvQ_mzWbEX9yjWiatUZA700QY1cbaVyXwKL-p0g7VbviagmWXVNs3533FGAVBG9pzZXsj5XSc8RLxAnp4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgedugdduheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomheplfgrnhhnvgcuifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenuc
    ggtffrrghtthgvrhhnpefgvdffveelgedujeeffeehheekheelheefgfejffeftedugeet
    hfeuudefheefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohepudegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhgrsegrshgrhhhilhhinhgrrdhnvghtpdhrtghpthhtohepohhjvggurges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilh
    drtghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgt
    phhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfe
    gpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegsvghnnhhordhlohhs
    shhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:TU9CZ1M6-Hcw9LD1QEA52hymW5RJm7jHaJaNuN9UyugI3MbWer3aGg>
    <xmx:TU9CZ68r3xM-SWO0ElPHjIv2JXKztc90SwEjDk9iAXXEA5yDWmhnrA>
    <xmx:TU9CZ9Vvf392EhsSHltcmUPwSR_864JBCcR8Rlo9kX89grIJGufhig>
    <xmx:TU9CZzeNtQjT3nhfYTSbPxffLtDUHPediC5wqhdGmUEyPmg5H-Mk8A>
    <xmx:Tk9CZ-VJgvmhx-rnAme-EEJ_ujk0coWlR-pwKamfAdEPQjMKHn9q2hL1>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Nov 2024 16:55:24 -0500 (EST)
Date: Sat, 23 Nov 2024 22:55:22 +0100
From: Janne Grunau <j@jannau.net>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev
Subject: Re: [PATCH] rust: alloc: Fix `ArrayLayout` allocations
Message-ID: <20241123215522.GB2171629@robin.jannau.net>
References: <20241123-rust-fix-arraylayout-v1-1-197e64c95bd4@asahilina.net>
 <Z0I2Q_vGErIQ0xdn@pollux.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z0I2Q_vGErIQ0xdn@pollux.localdomain>

On Sat, Nov 23, 2024 at 09:08:35PM +0100, Danilo Krummrich wrote:
> On Sat, Nov 23, 2024 at 07:29:38PM +0900, Asahi Lina wrote:
> > We were accidentally allocating a layout for the *square* of the object
> > size due to a variable shadowing mishap.
> > 
> > Fixes memory bloat and page allocation failures in drm/asahi.
> > 
> > Reported-by: Janne Grunau <j@jannau.net>
> > Fixes: 9e7bbfa18276 ("rust: alloc: introduce `ArrayLayout`")
> > Signed-off-by: Asahi Lina <lina@asahilina.net>
> 
> Good catch!
> 
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> 
> (I'm just back from moving and just starting to catch up on what was going on
> in the last few weeks.)
> 
> Is this related to the performance regression that has been observed by Andreas?
> Or did it turn out to be a false positive?

No idea. We noticed KVec allocation errors with page order 4 to 8 under
memory pressure which weren't observed with the previous allocator (or at
least not that easily).

I haven't noticed performance regressions with asahi's usage. glmark2
score was roughly at the expected value.

Janne

