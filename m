Return-Path: <linux-kernel+bounces-261767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BC293BBE4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65371C208B4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 04:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CE61CA9E;
	Thu, 25 Jul 2024 04:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="iwDNzkFS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P+POIIER"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1A218C3B;
	Thu, 25 Jul 2024 04:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721883452; cv=none; b=Dlb0QrnP/bb3SEml22P5kuO9XYyHJig089WVTsjgq0aB4j3BpnfyiXv5J9iSVVkyFwAASGqk3x2EfbBtACwPSfjyk8tfIb/Df73tZY6g94DYVOjUHrTyjJ9k/jGMX6xcDn4anliX1K/k/D0h0edbNlhMS2QyrISZDayOiJ7cS0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721883452; c=relaxed/simple;
	bh=xszbH4goRWt0jsIYgEVr6nI8BiA9BMuNpDGdYj7KD3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGu1x5kOZ4hNLp2GoICV1RRphYHKy7uLp8l7GdB1DAFz+Ns0zYHpgoHVbytMGfyUWhSITSgCToSvq/VjXW25LyKV9hvAQ1CSRlWK061Cllpmw37moHr7N/ohN7VtXUIdQW539YgzWqoLid/C131+gsKJJHcKCPAUOvXcSH3gAj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=iwDNzkFS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P+POIIER; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BD2881140233;
	Thu, 25 Jul 2024 00:57:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 25 Jul 2024 00:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721883448; x=1721969848; bh=ae2g/tIS5v
	FUeEA0eBPcpC3xiZh+tD43rM1GfoFOZ5A=; b=iwDNzkFS78DR5gXbT+GXUpBXT5
	rnubgiO365GLlfPaQnkUYn2F8MThsyIwnjsLIORY2JZ07OyEmbBRatDw1pQeRzSq
	nlytT8mf48QcKBweBfrr/H/VKbZDC39pJyxDbRn3/f4mWdqTnds+6Zg92C+l5T1y
	hHR0m41FjUQYYr88ktsHoEGFkqfudv+mzx5bW/ZWK41HYyBdnMyuzNJk/2bchC5y
	ZJ5ElQD/bkle5L6wJGDb2hdgQvWzTGpZ9VHkGgo04TQuiGHFtcV9ndhccfYbK2jE
	HtcZRJifK94ifvgyowFmWZCXIK8IRVQgGhU/6YtHnILksAi2AKJTt11v40WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721883448; x=1721969848; bh=ae2g/tIS5vFUeEA0eBPcpC3xiZh+
	tD43rM1GfoFOZ5A=; b=P+POIIER7sxpl+rseT8YRBmJU0KPMuqeka2m4fck6fXv
	Gdg7F1Waac1LoI3PBerXgADxX6eNdb03C2XqBQjMOtCkyBqMpBC0sSDp9OhRfQ5y
	GDETq0dlvJfyvw4WLTUEziU4pBTIfpnu/tpA3GVkpBHgg0xGIQ1Jg69+MMKyyGUN
	Mz6qKDFNY0I/fUeRV6hevyc+ANK3D6fxHpVPkvvji1Uzghu2trUhEKCcGjNEwN4n
	z3EiGvJ+S3tGNXNPcG2eVd2/6NMoGMQaVHh0nTo/dSq0gCrEzMW4wOLjdv0NH0bD
	dUzO2jSJ1/xFmCtZqbiHQ8Uag2wYWWnkzwtX5+WKlQ==
X-ME-Sender: <xms:ONuhZoW5UmMiW2sG-P8a8yq3fxL2oUGxtTVMq1LD-KgKRXvR5m49HQ>
    <xme:ONuhZsmXeEFre-99sNVzKiGQZc9a4QeXpZCFZdy_HY-SVb-pvWzdinXanPsEhJ0iA
    ZzmT069lcio_g>
X-ME-Received: <xmr:ONuhZsaOY2sI-Mj_cyMC4Gp6Vdy-aDBbu06ag8IbnLZshcTI6P7NAXaVDBRUIKd26n8TuZf-Ju9tp3zlqyvQ-9hjwtjMcDxX25vEdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:ONuhZnUaFcM5At6qe-Tcx9aCFOQjhQ56MoFCuoMMq8mP8NFjuiZwFQ>
    <xmx:ONuhZikm4RuI4ACwZMGKwy-yTof4vy_6cFy_2QZ1Ervl5ffhzm8v0A>
    <xmx:ONuhZsex2GNuk6PUbDOhtIhn5L8wAymgfdc2igTUnjTn0ZodBbKeQA>
    <xmx:ONuhZkENDhvl2jA4omr-AbF7W38PP_472A5QhKZM7R9XmG5JxN0Ahg>
    <xmx:ONuhZl7S0-IAPBxLIQB_Jt4nkfFHE4NQ2wVsW7yEZAhQYoIdbfU_TqeZ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jul 2024 00:57:27 -0400 (EDT)
Date: Thu, 25 Jul 2024 06:57:25 +0200
From: Greg KH <greg@kroah.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] doc: rust: create safety standard
Message-ID: <2024072520-yogurt-zoology-3c5f@gregkh>
References: <20240717221133.459589-1-benno.lossin@proton.me>
 <20240717221133.459589-2-benno.lossin@proton.me>
 <2024071845-neuron-figure-2e26@gregkh>
 <59ebc5f2-7d58-49f5-83f1-c954705f3953@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59ebc5f2-7d58-49f5-83f1-c954705f3953@proton.me>

On Wed, Jul 24, 2024 at 07:13:08PM +0000, Benno Lossin wrote:
> On 18.07.24 06:45, Greg KH wrote:
> > On Wed, Jul 17, 2024 at 10:12:29PM +0000, Benno Lossin wrote:
> >> +Because unsoundness issues have the potential for allowing safe code to experience UB, they are
> >> +treated similarly to actual bugs with UB. Their fixes should also be included in the  stable tree.
> > 
> > Odd extra space before "stable".
> > 
> > Also, link to the stable kernel rules here when you reference "stable
> > tree"?  That will explain what you mean here.
> 
> Sure will add it, do you mean Documentation/process/stable-kernel-rules.rst?

Yes please.

