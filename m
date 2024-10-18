Return-Path: <linux-kernel+bounces-371277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D2E9A391F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74410B22DEC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC57318F2DA;
	Fri, 18 Oct 2024 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Z3dLR58s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ejJML6iW"
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801B117839C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729241480; cv=none; b=eheLxQ47QdQYMR0tGsvFFB/J2wzlPEdIZ5+aLB52D5uvDpsixUN2ECvoF6VhlY9KHK0x9ZQXYXb5X3K/lpFl0QBzuuF1n2095Uup4hBLvm9uZ3GC0sJLmEadK9HM0vNqxeY7sezbm0BOpDCbuNgEb9iseYtJefWqdcdF/jpRr6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729241480; c=relaxed/simple;
	bh=JSmdMnRt/cQMfOaUbklcB1w5+Ed2Ivt7vyjyr/r9Qk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7t5vppL4RfB0Xm31ta9cvbBjp18prWKkJ4eeeYm6IcL/pYpchFGWcLcUg68ow+Uxh3UKuFX9DjAQfwTCQnpUB7pipOtIUbhdaLXpi8huTxig7Gu0Dl8ChrcTuCOCtMpLv4Vyo4k8HMZUrvrvD++b8VLpmuWfsYJVMBG5gibxoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Z3dLR58s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ejJML6iW; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 971D01140193;
	Fri, 18 Oct 2024 04:51:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 18 Oct 2024 04:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729241477; x=
	1729327877; bh=ujq12Rn1ZYuFrl0E2Y4gVr1fgaquKynz6QQkqj20W+0=; b=Z
	3dLR58snKKcCJZgZI3xeVE1wHwQdEhFcXogbDo3AZ9gydToFBWoKlvMNdW3k/uW6
	jCbmBS6p5qc3MNzRv9O0MH4FbMWnATsWlYwT/xu+NMD8Vy3206zBov19LsihtNoA
	5G7Qfo1A7R8SrUTivKRMGUsl917LkD2L0MC5Lc1WNScOM0WADNJlaoY8rzRFq0/t
	YydyrvyCUyRAjGTgjRhczBmGBSCEAcTowEjesgUcB/Cq8POTzcZgiFvXMHZ5SnpO
	SRsjVToGLmjHGCnE/DHje9zIw+qomL2+D3aQNC5D7wgNzuQMBLfaBnc6eblMXDTb
	4AryKgbnxwj0YKPNuiJMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729241477; x=1729327877; bh=ujq12Rn1ZYuFrl0E2Y4gVr1fgaqu
	Kynz6QQkqj20W+0=; b=ejJML6iWBsqgueuBT4fZuvsdujksEjLlVtrckefdgsrI
	Xa3bvEDZBt9GiFTgDWQK7q4AZuwIztZCiCo9PwMKcp33lokDnrIvsjtdcJoqAMme
	XdkKdIozTOxgDYolF4GlFiaFFPH89luiGJHwP6arft65XLKccD1chVmcTMsqnevL
	7HpBJEDDCMw6rJdyswhxup7SxIXrxuxD6wh1t9dqnSlTGbybyPJF3c/ezFtoVPhM
	DpVaYHXpErwN5stUMXGAOOuwkCmDXmezctQ3HlItD1ZhyvUT6tr9B9TnJq1cOYt2
	XURzh+eN50Mt2nAXAhOWiPuzyfXDkbjc+egK4gsAMQ==
X-ME-Sender: <xms:gyESZ6XSXpFEmaS-7geuqxyPc7tEhjHMImlRe461ajghgIdeWRQwEA>
    <xme:gyESZ2kKsqTZ3ESMyubcy5HTU4ObhKnCt37BkbE_8e6b1Zz73h6fsecWhSj0MigDw
    I3cJ5JPNUgxCqXbBX0>
X-ME-Received: <xmr:gyESZ-YcVbPyquP6e-_F1TyzjTV2ly6RhLx_pbLwIIbco9IbF4sbQTRVYYDn60dQOw5blA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutecurdcuufhhuhhtvghmohhvfdcuoehkihhrihhllh
    esshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhepuefhkeeiveegheev
    ledukeffheejfeeivdfgjeeukeehkefgvdeifeehvefggffhnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhho
    vhdrnhgrmhgvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepjhhpohhimhgsohgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeei
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihig
    rdguvgdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopehpvghtvg
    hriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehprgifrghnrdhkuhhmrghr
    rdhguhhpthgrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhonhhgmh
    grnhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhi
    nhhugidrihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:gyESZxVeHzCRD6MAiqT2S6T207Wd3kzCe8Zfc5Ej44QKsFKILE-PXA>
    <xmx:gyESZ0mxgdkcEWjNKUEIx2l89WdjgL35BSRXD0HtleLh5TfcPMCBYg>
    <xmx:gyESZ2eusl9wn4Upuji7Eayx0BuCyhXnOirBUWRzJ4HorabHAperlg>
    <xmx:gyESZ2FdVtPX2R5ogsOIA_tr5uYKdf5owyjz2umGDCOl1wos0dbeuQ>
    <xmx:hSESZ4lkrKXKaV_5i95opjMMhO4ccmSeRUZGg3GphxIwdeo7Q1ziXh2k>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 04:51:10 -0400 (EDT)
Date: Fri, 18 Oct 2024 11:51:06 +0300
From: "Kirill A . Shutemov" <kirill@shutemov.name>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Waiman Long <longman@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 3/6] x86/uaccess: Rearrange putuser.S
Message-ID: <srdcfvwgmm4aiyny5ex24puhi7u4rohy2sjb2htrzqhr7igekx@bh3c22loauzb>
References: <cover.1729201904.git.jpoimboe@kernel.org>
 <7818233ecd726628a3eb9cbb5ed0ba831e69af4b.1729201904.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7818233ecd726628a3eb9cbb5ed0ba831e69af4b.1729201904.git.jpoimboe@kernel.org>

On Thu, Oct 17, 2024 at 02:55:22PM -0700, Josh Poimboeuf wrote:
>  SYM_FUNC_START(__put_user_2)
>  	check_range size=2
>  	ASM_STAC
> -3:	movw %ax,(%_ASM_CX)
> +2:	movw %ax,(%_ASM_CX)
>  	xor %ecx,%ecx
>  	ASM_CLAC
>  	RET
>  SYM_FUNC_END(__put_user_2)
>  EXPORT_SYMBOL(__put_user_2)

This patch provides an opportunity to give these labels more meaningful
names, so that future rearrangements do not require as much boilerplate.

For example, we can rename this label 2: to .Luser_2 or something similar.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

