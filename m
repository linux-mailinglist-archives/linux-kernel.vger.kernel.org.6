Return-Path: <linux-kernel+bounces-282061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E7B94DF45
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 01:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7011F2182A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 23:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EE6145358;
	Sat, 10 Aug 2024 23:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Le7wwKbQ"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B83A14431F
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 23:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723334080; cv=none; b=fYSpiBd0IEubdRiW3k0aNgDk5T9GqyixyHI7NycVqS4hL10Y9EwGuFW80NPjZ9XSinu7Ek58BVt3vzm1bqDQ6aCQyuJ4FIinBkXZrsMzN5LHUzNjgZyPau3sRVuVMRMTetSW/U6yNUBSjw+5KDhismdBtSI3WmGmNcszn1uADdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723334080; c=relaxed/simple;
	bh=6P0A7FpSLHTGitN9MQjoscGYq7XoUHY7xMizbSAh+k0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OLcEablW7hUuuCQcDZE0N+CAeA76bOav0lhZkNVPL3Dz6yHSBXWyE7fvbq6L4sO5t231noecnk1Cvd8kHpMD5WIZ41HWNOwVAxfgMGXvRp+t/RYQV1x65vYloP0Ep6yjXygLLYdBHjZnHIQoQY7/hKGjfm43fD/c43oXH9ViGN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Le7wwKbQ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4ED91138FE11;
	Sat, 10 Aug 2024 19:54:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 10 Aug 2024 19:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723334077; x=1723420477; bh=m354HSntUIw53mWwYckb3QrVoIhw
	BudqJw1LrOjJosM=; b=Le7wwKbQi7oYt9UzKSLW7e0kkZWkCc9y6i03i0VRNg55
	+dFc9KriAe53A/rlOSpO03ImDGmYiza0qRH6ZpEx2Tpu43/RNp6bBZZS/YoTraNX
	3rYub5D2h5JJWQaSxbM6/Z3XYlr1827kFxqtLReMB7Sg+6ZoXH9i4LxrUXctWHsK
	iC1KJQ+8Xxu1xLiZkj1b6eqAZmYSYSuILs5sZHLkuzOvqOHRdRB3i61UqyEQy79m
	XdIE3A/+yRikAXSYrDKtHYma6j8uQztLJgz17L1V7LNtYnzPeecDofihXDVOs1nq
	pQVNM8r/8fRW/k7XKxZqo5FW8tQq128Fjhe/XIonIw==
X-ME-Sender: <xms:vP23ZgCqEC1IIzBVDH_rD-E5madC9V6RkzRNCdBQrxC6NaKhvDACjg>
    <xme:vP23Zih-yijOubFJdzFZnGIdkdkuSbrm7uaZpYcWgZO1WNT4quVcvQJsuhW39c1m9
    MOYKT96VtOkBKz46FY>
X-ME-Received: <xmr:vP23Zjn_zz9zr7w7mx_GqFYZ4FvIKk5FirIK0oYG81_QnGjp0x5Bk1ELjYu1URg-o_BGvhUjQbWnBN3cxR6ClZ-7N-_K56pOUtE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleejgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfh
    rhhomhephfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdroh
    hrgheqnecuggftrfgrthhtvghrnhepleeuheelheekgfeuvedtveetjeekhfffkeefffff
    tdfgjeevkeegfedvueehueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgvvghrtheslh
    hinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghgvrhhgsehlihhnuhigqdhmieekkhdrohhrghdprhgtph
    htthhopehushgvrhhmheejseihrghhohhordgtohhmpdhrtghpthhtoheplhhinhhugidq
    mheikehksehlihhsthhsrdhlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vP23ZmxNTAaDTsqfSZHpDiKpSqOulMP9-X-_8m6wRfWvEqbsHWectA>
    <xmx:vP23ZlTD3394Xfipf3g3H2mOloVHS5_aXrVDE8Z69tMGwKw5zhLw6Q>
    <xmx:vP23ZhY_GuYjj5qA8rrV4bNGih4Emfr_tfeHaJzQPEd4-SurHhiIow>
    <xmx:vP23ZuQxwDw0Yv7JBMO0SMJmohq5sfLECx6xl9xoX7JAgsOoQTPQVw>
    <xmx:vf23ZuICurxguAF7gShVSGunD0D1xPW2IddGUvd6QNQ1h_uLDEeUhyix>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Aug 2024 19:54:34 -0400 (EDT)
Date: Sun, 11 Aug 2024 09:54:42 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Christian Brauner <brauner@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>, 
    Stan Johnson <userm57@yahoo.com>, linux-m68k@lists.linux-m68k.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: Fix kernel_clone_args.flags in m68k_clone()
In-Reply-To: <CAMuHMdURykHCL1KEvgK=yC5sW-DAkEo+C+bbOBMUsbhD8aPSMw@mail.gmail.com>
Message-ID: <1f7aadab-29f2-b8fa-4d5f-090fc49cf0b2@linux-m68k.org>
References: <ac8100050f448caa1dc46c131079e615e73021a4.1723273396.git.fthain@linux-m68k.org> <CAMuHMdURykHCL1KEvgK=yC5sW-DAkEo+C+bbOBMUsbhD8aPSMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Sat, 10 Aug 2024, Geert Uytterhoeven wrote:

> >         /* regs will be equal to current_pt_regs() */
> >         struct kernel_clone_args args = {
> > -               .flags          = regs->d1 & ~CSIGNAL,
> > +               .flags          = (lower_32_bits(regs->d1) & ~CSIGNAL),
> 
> While other architectures (nios2, sparc, generic code) do use
> lower_32_bits() in similar code[*], IMHO this is misleading here, as
> regs->d1 is never 64-bit.  What you really want is to avoid the sign
> extension in the promotion from signed 32-bit to unsigned 64-bit.
> So I think a cast to u32 makes more sense?
> 

Yes, I think your solution is better.

