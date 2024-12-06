Return-Path: <linux-kernel+bounces-434784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1499E6B44
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68EBF280F8A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F331F4737;
	Fri,  6 Dec 2024 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="taDKLzgB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pLk7R9x1"
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E051DFDAE;
	Fri,  6 Dec 2024 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733479522; cv=none; b=HiftvcKngyRQlMoWX1ujnov7Rsxc3Le3IScyt5MK0X/vT9iuNDNHbpPD8tm1sjzDZGZ3Q3BZiBO8BuMqdplL+rfgNRSExXmnMpXeNlh944oG1ssgHuyT1U0nIZeHEs10O5fF0TAftfCZ9zNqKjjB/io4Dz1TyAnlVpYQPNCAQsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733479522; c=relaxed/simple;
	bh=RrA8I8dF0J92FZTcmFvmsnpScWk0YFpUbKH70ww5FzI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FUdXXqNdDYNoGwFOsDAXoYmcjIgGiaSruaE0KlzxRARSCmQnHjIq2NErdwh93RYLGUpu53hxX5n49P1RrNHxJtDllvRC5LIlvGpVRSsoxldlfrjnaJwCyMwmdzbLLhG5Y7EDNdrVpIeSLpNfr7TYWpqQTfsok6wPqaELf80Hq2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=taDKLzgB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pLk7R9x1; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 16D072540190;
	Fri,  6 Dec 2024 05:05:19 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 06 Dec 2024 05:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733479518;
	 x=1733565918; bh=inPW88KNR+Skr6L3XiROaAs7CBIGj/blbIFxaE3cAdA=; b=
	taDKLzgB3LVPGgKXx9CVvD9CFlR8mKmUw2wyqungAF8LOmhJmywxorozkHJzyNEg
	+09OJ0rbmFYpW3eAiWL7XngrtXIOMGob1Bkr2VBxsYrkIeM3flR1m2PA8cSVVKQy
	BlWux3u24Lg6UaA12/oeOPkO8/wlD4XSx/+Arq0SRYNvBQ1IzmYNIpNdcLr94fxc
	SqFhvJqc5MTvbc0IIUL8B0o8NAGZouuBPaMufX4n3l84OH9val1lnGXUXtGA7k3r
	8I6ahpo6rLlCPIemjSd55vQfhPFHdXQuX7zI4cbGWZfwFhz4YEc1KPPtWLcqMG1h
	ns6pAr7IpZ4W/hQyFcoxsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733479518; x=
	1733565918; bh=inPW88KNR+Skr6L3XiROaAs7CBIGj/blbIFxaE3cAdA=; b=p
	Lk7R9x1R9MVIUPlREpL5Wi80EBtc6f0BxfVs4yN+t+Z/9FNBB9cFYzrS74vH3Q8p
	njds9mr7+a30GjDQyHSrur4w42auc3ZVQ7Kz90rRIQMexV3z0tneUT7ji7hwpnF3
	yJfNlWdz/StqX66P7uC2sXnOyipdG9VcuzY7kxwqfO2zvie0+dlNO3i67R2Q3NSq
	G9+sABtSfcqt5Mv7OqUByQcSUvLi+zdt7ujXPdLCnwKgit4FyI93pN0PJH5xNpYe
	1HtMJZ8QiS9EHFJyKgTNCo06wespVgMTc7jqWtkzf4fT0SWBrkBw4JQ6bbb7XEC/
	MB8BMxgCLrvJm3sUBURMQ==
X-ME-Sender: <xms:XsxSZ51DMsHQtsOy1NFCl3mf9jM3AXQdxcnERVf3tI813Omnm1WCIA>
    <xme:XsxSZwH01y0x_9Ma-VsAUXwVFuof2yco1Hos1Vc89r4NipTFSpwJJQq39pZiSvcmJ
    aSCnb6S49KAG39yMXM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffg
    vedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedufedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvg
    htpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphht
    thhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopegrlhhitg
    gvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrrdhhihhnuggsohhrghes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhh
    sehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsggvnhhnohdrlh
    hoshhsihhnsehprhhothhonhdrmhgv
X-ME-Proxy: <xmx:XsxSZ54ieFB7nJHhiGNt9BbAgOfWqZsK1lPt855ZSq6oQQW2qG70xw>
    <xmx:XsxSZ20dzGQY39KJJBERmnDSJKG2PdJog0uvqAFO7ZIxXbARTNFaVg>
    <xmx:XsxSZ8E5GDBqdjOEr1at5iCm82ozWC93F6QSN_wJgIk65gVPU6pwYA>
    <xmx:XsxSZ3-ZBluVtrDRRYNzRI4b7Dsol543PPVWnzmCMmv6rhqsdzZ81A>
    <xmx:XsxSZzfft_Xlo4HEVGEON0HDZ3EFDnMmOWnLkI0EecQ8Ir_iQyy5pU4U>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7AAB22220072; Fri,  6 Dec 2024 05:05:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 06 Dec 2024 11:04:57 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lee Jones" <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org
Message-Id: <57c35f7f-76e8-4e21-8288-c66a1b6e7069@app.fastmail.com>
In-Reply-To: <20241206090515.752267-5-lee@kernel.org>
References: <20241206090515.752267-1-lee@kernel.org>
 <20241206090515.752267-5-lee@kernel.org>
Subject: Re: [PATCH v4 2/4] samples: rust: Provide example using the new Rust
 MiscDevice abstraction
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Dec 6, 2024, at 10:05, Lee Jones wrote:
> This sample driver demonstrates the following basic operations:
>
> * Register a Misc Device
> * Create /dev/rust-misc-device
> * Provide open call-back for the aforementioned character device
> * Operate on the character device via a simple ioctl()
> * Provide close call-back for the character device
>
> Signed-off-by: Lee Jones <lee@kernel.org>

Could you include a compat_ioctl() callback in the example?
I think it would be good to include it as a reminder for
authors of actual drivers that every driver implementing
ioctl should also implement compat_ioctl. In C drivers, this
can usually be done by pointing .compat_ioctl() to the
generic compat_ptr_ioctl() function, which assumes that 'arg'
is a pointer disguised as an 'unsigned long'.

      Arnd

