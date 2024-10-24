Return-Path: <linux-kernel+bounces-380011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D52C9AE71D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015B5287805
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECE61E0487;
	Thu, 24 Oct 2024 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="XzhDMr6Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JMVObSnh"
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4521DD0CF
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778573; cv=none; b=pY36VTbPVfomEaC+NNpzXJvFA1uS1YF3W5x04tXwCN0vDDcSIRcGma7i4sG7swEIhvWaIfD0R54REI3TEeU8BcfZLFEWHDl5MkfqHraas4UtVMhUUhscui7ZXQbvmhbX6Y2kD2DKdYY4w0hRV+ujo1ppfAEbIh6FpL+vWGeNAWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778573; c=relaxed/simple;
	bh=m/b2Wa4mxWTC44eBkzN0q1ajrLPMoP24xua/RWuDKYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pahKDo66u+caJpYZm2CijVgYH6F77+/AzeFBQLDczPo8QDOvJ1eRd7pfKW7kIYccdliGbV2J49A2kldoWbISAhp1edk17wQfSMLdubDN5/yGGda/c1P9lx4QbOtc+1hNqLWD4m3w0WKsIo+sdAeUl2nTqHasWq0kBcLwgEv2mjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=XzhDMr6Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JMVObSnh; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 6FD3B1380707;
	Thu, 24 Oct 2024 10:02:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 24 Oct 2024 10:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729778570; x=
	1729864970; bh=qaKYA5JUiByowPpwi3+VO6sCxvDFk/kL4dNUw75wl7I=; b=X
	zhDMr6QtNWrAI9RyZj9Z0pof/LLtHPUR4bkM7Lyk133B1exAb9ivOKzNMCxHqXi4
	BTUBvnw+G0tq3/sFYE2aioiTyVqd4fHe8PWMxXCis3c3mL9yPhUtzCCGnGveLPaW
	HjBRMwPpAUFQ2pDneBLulQFLdryAwm+S6iR8Q3bZ5629VKSAdvMHwcJwJkOl4Afj
	r5WcCFvRhYjPxecobCFAVj/C3uMECX47VuuNJAwfAcZmTBTn6k7hzy8GiTDfYK3P
	ksiqCt3BMWzsio88m4vE94zw1IWNh/FfJm7PJPvm6rxp+p6vnWZ7cpfOt4Y+HvMU
	KYmcM5T4y29eGYHO6b+Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729778570; x=1729864970; bh=qaKYA5JUiByowPpwi3+VO6sCxvDF
	k/kL4dNUw75wl7I=; b=JMVObSnhm7vWcuoNiJKdQejOaDghzJfSu+408Yhq/ZY1
	kPT/yO25/HrCuDPLcL7hE4ZSZbpwIZwf3ilWZcOdcjB/5rCUPEJVfX4yEx9Vn1kE
	DrzbHcWU5GgMOmTUnBNv7V4cNgwrkGLOFJdOcFJ3042g7tZWpmnnHvyJR/1ErkyY
	XjsuIYkLWq6YY0CMS4Sz0VC+EuQrWJeDwcTeeo3cbA2Mi3xYipRaxrT81wLMDo2j
	HdB8KRM+RZ1SrnXu0V6/JrJ0kJjOHwWruP36b/hCh+lfkmFxgYjJiR91DoCEdZC9
	Kn0zarhmvg+5m8hUc/FdlKf/vK05Ps67DER4rSitDg==
X-ME-Sender: <xms:iVMaZ3-YEhnd8KtCpyET56sZDZonXoX_JyvoL5dOk0ByMgh2suxBiA>
    <xme:iVMaZzsk92AgBthoJ_EvrCljPV72fcZy8GXg6tGyIGooIqngA4RMfxcd4CkgnAu94
    h4kDnQpAOVOVX4ze4E>
X-ME-Received: <xmr:iVMaZ1DHi9sTgLhlzmhfR1HhMwuapJ2-drB0iA77geuIRt0z3lmcR_NXo8dxtzdF2ii9vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepjhhpohhimhgsohgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhrvhgr
    lhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgiek
    ieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifrdgtohhophgvrhefse
    gtihhtrhhigidrtghomhdprhgtphhtthhopegsphesrghlihgvnhekrdguvg
X-ME-Proxy: <xmx:iVMaZzcpOXLucO4ENuJ-xBY0u7nM8ATkblKIc8ruh-qO7hdeRhmqBg>
    <xmx:iVMaZ8O6VerVaZLDc_c5KhHYWXBhbctVk4Ssa3scl8_xb-_mm7pMqg>
    <xmx:iVMaZ1lT9pLy8Bftg5i8fh6EzbQuTj4-0OChEmmcdare530P3QiEfg>
    <xmx:iVMaZ2sEbVjCjiWwm_3mtuqAJHGNAKffCSqp0M312B1bQq5dCmKC3g>
    <xmx:ilMaZ4Ab4-caY43rsrjuiM79GHyqfZAwMaB_afjrmAnTr6yzTSmBSCF6>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 10:02:47 -0400 (EDT)
Date: Thu, 24 Oct 2024 17:02:42 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86: fix user address masking non-canonical speculation
 issue
Message-ID: <xonbgoepadskqagkprwpcse33sgl3yebo52liuskde2eiozcza@njkktzlcar6g>
References: <20241024013214.129639-1-torvalds@linux-foundation.org>
 <20241024061300.l5y4ng5gmkfrfdht@treble.attlocal.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024061300.l5y4ng5gmkfrfdht@treble.attlocal.net>

On Wed, Oct 23, 2024 at 11:13:00PM -0700, Josh Poimboeuf wrote:
> On Wed, Oct 23, 2024 at 06:31:59PM -0700, Linus Torvalds wrote:
> > @@ -2389,6 +2390,15 @@ void __init arch_cpu_finalize_init(void)
> > +		/*
> > +		 * Enable this when LAM is gated on LASS support
> > +		if (cpu_feature_enabled(X86_FEATURE_LAM))
> > +			USER_PTR_MAX = (1ul << 63) - PAGE_SIZE;
> > +		 */
> 
> I'm probably missing something but once LAM is enabled, how wouldn't
> this allow non-canonical address speculation?  i.e. when bit 47/56 is
> set and 63 is cleared, would it not go untouched by mask_user_address()
> and thus be speculatively interpreted by AMD as a kernel address?

CPU with LAM enabled enforces bit 63 to be equal bit 47/56 and raises #GP
otherwise.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

