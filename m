Return-Path: <linux-kernel+bounces-381309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7C19AFD79
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBB2F1F214DB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190571D27BB;
	Fri, 25 Oct 2024 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="fYlUkdjh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FZQouovp"
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C162922B645
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846911; cv=none; b=WZmkOHBdXf/92syndsGEPEqBAt7X6LE8b/EbNxrR9nPZYGU0wy5jLQ8mizEkk/BkGY+gmUfwTSaGSRb3ldY6sVFbRY4gXjDevBggdWk6thEMpffQwLrJ+MJ+mZrICui5ivseuDUB4wyVgCaHu3DvECCiCT3LftbCnmIyEW49fC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846911; c=relaxed/simple;
	bh=f40bl+bDnNMSeF6tiBj6jAMQNsTgkTkFyQYCLRy73UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeMu3vVY+VRUc2vF3ccgY+fz8sehgSqhoNi7rmdoEEqi/CzY7C6XFkVFgfQW96Bb9WE3DWLvpIH4w4k1puA+U7VCcBHDmA1ZiNnm/ozpdjy4EUj6bg+1pOvasdaJU5zQAek/qEn38BYHLin23wTyPXIlUYNIae3nn/kdXg+sed8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=fYlUkdjh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FZQouovp; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9D38413801F6;
	Fri, 25 Oct 2024 05:01:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 25 Oct 2024 05:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729846907; x=
	1729933307; bh=VJyoij9gQj7K9r+mYyYBMOHs+agIRsVJ5VPI6PMEB7Q=; b=f
	YlUkdjhsmR3kgHsKiZ1pLbHZ9G+I2mCIWDXlVl1qSQLuTuQLyf3HnsGyyOH5C252
	+aozPsHZ1ZAbDEPGM4ExXuwwUBWMvSe8ctJzQoqtJtRY3SYOQ6qQnV0gXPc0xZrL
	a0JwKI8HdHCzVltTJSEia2QYCDYwYBFFpKIU6SoYBZyzXWW482gSaOd2+bNefiwr
	1RToAiL+F4QmWQ5CJQ+2R44a8sywDUZoq7WpeD5WggsfEkuFx4Lx8QdjrTy0Neuw
	uyKj6TQH/OmT4Vp/pd07El4HrK6zlbkfpAbQGgH9qD6t+YDvKxgfkS7rxXw0N8eI
	VhSJY6FF+9B9d63r63KDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729846907; x=1729933307; bh=VJyoij9gQj7K9r+mYyYBMOHs+agI
	RsVJ5VPI6PMEB7Q=; b=FZQouovp1FDF37GRzX7TkK/pIWpIJFj1W7hYmu7EOQ3H
	W2bfDojCyAL7Ohm11d/097NDM5KZzejQ7E4mr3tMk6wR1dHliiJ11bbm77iYhfQw
	bxiLyzvXW5jnPrv9uOMW3in1+sXc8x08I3dQ/IiW5ul2+Lf7yUVqv3KIATVx0lhn
	KJLvWyCCpXP2qPIlTyOUjP/wL1LhzocVrYtDq8ByE3CnHU9yYrA4SQD+pNiyALKw
	37n70dawK1C6aQlfQsPzgTY6HM9eABzMj4O1EmuTEhMt3WJ5O8dQsGOmj5cxCamy
	4GR6P+5L5ghI/iC5VE6QHefimHNeBujLFrWNEUH05g==
X-ME-Sender: <xms:e14bZ0MCX-ZmzmTqAJsNIP4m0cjkMPy7grVQDJqDKxOPm8hWZzdYUg>
    <xme:e14bZ69ENupVm7nNSDtm329llQvWxLDUWyhAvBUg667MflhQHFXnfW2hn-hKm-69n
    HunAiEGoa5PI1fZ8IE>
X-ME-Received: <xmr:e14bZ7TQhIUhEJxgDW5xpvn6w01ZrERpICLXxSSu2FBcm4g9Kp7cFwtgHLEMNdxrUJRMww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejvddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgt
    phhtthhopehjphhoihhmsghovgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgiek
    ieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifrdgtohhophgvrhefse
    gtihhtrhhigidrtghomhdprhgtphhtthhopegsphesrghlihgvnhekrdguvg
X-ME-Proxy: <xmx:e14bZ8sA4u_223ZPRQTBiLiv3pmJQr2ddoqfv_EhvatrN_H0ZdVMsQ>
    <xmx:e14bZ8d8WDH1NJaJnjLn2vvKfqu7O8v5ZQbjexdIVCwA5FIUcL8tUA>
    <xmx:e14bZw2HIp11-LqEnc3Y0DiT9u-wxnn6qEwhcPjixLD7D9TBRRfArw>
    <xmx:e14bZw_AoiXFzh4X4kTiApxTs3CNwP-11wj6Y-PG08W8ZNaTHLs8LA>
    <xmx:e14bZ0R-7Q1u2081nzS8btzoJYwsYEsYEd9YdwrQyOdKOPHMO5LF0MIT>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Oct 2024 05:01:44 -0400 (EDT)
Date: Fri, 25 Oct 2024 12:01:39 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86: fix user address masking non-canonical speculation
 issue
Message-ID: <m3xpbkhc3vuk3so5fxjs7stx4fmhkhvew27uhhxyht3s4yhm7d@etnhvnhzln6k>
References: <20241024013214.129639-1-torvalds@linux-foundation.org>
 <20241024061300.l5y4ng5gmkfrfdht@treble.attlocal.net>
 <CAHk-=wihBAdfL+OgaO71H_n4NFVyDdTXWEA_fjrdEFUc-=D1Sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wihBAdfL+OgaO71H_n4NFVyDdTXWEA_fjrdEFUc-=D1Sg@mail.gmail.com>

On Thu, Oct 24, 2024 at 10:35:33AM -0700, Linus Torvalds wrote:
> On Wed, 23 Oct 2024 at 23:13, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > I'm probably missing something but once LAM is enabled, how wouldn't
> > this allow non-canonical address speculation?
> 
> Once LAM is enabled, together with LASS, non-canonical addresses
> basically don't exit.

That's not true.

With LAM, canonically check is relaxed to bit 63 == bit 47/56.

I try to confirm internally that we don't speculate past this relaxed
canonically check. I believe we don't, but I want to double-check.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

