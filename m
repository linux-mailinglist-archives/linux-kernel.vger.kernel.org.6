Return-Path: <linux-kernel+bounces-379853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604AD9AE4C5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD972846D0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB041D220A;
	Thu, 24 Oct 2024 12:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="UyukCu8l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R6WpSU4B"
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9081D4154
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773163; cv=none; b=tiYisxPauwQqMl2RPun83kx6a6oRkPGcTd3ggVVqNpHBDo3eR5byWhKw3KhUGp764tQumvvs/TPW1VHRh6sdZcjIodfvxCjF0HU9H8a2nqzo4f6dSMgY6MoRLnBCJvopPHCL+wBPZB6jTffazi9gQz+KNtUwRDMVXBHfE9PjN8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773163; c=relaxed/simple;
	bh=WlGeU43BFZJEa2X2aqyU6jdCoQ+8q/Eu5a2KxpLSVlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kp/vSkDKOuhLIm3IMxwwz/OSENVWWDGcIRTZ5k2wKt+GfaPxzLCljor8jG8jCzw5CMEPOP2+FvI9OiB7UwzqpgN3Uv3sgGafX0QV+RhqIUqmgj3ojxNxKkiOmYv13AsDGY5n266TAu2g7r+qkxm+YlyqNpAWV53UAK6P4Zd1GPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=UyukCu8l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R6WpSU4B; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1DD2C114016D;
	Thu, 24 Oct 2024 08:32:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 24 Oct 2024 08:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729773160; x=
	1729859560; bh=aEDUElDdAV5Py0U1C7Sd4/u9LWiYhNncIkGdxXwixvk=; b=U
	yukCu8lLeSpbZs7YiR+Mgl5TTrUQS2ooVkbhg8kdjgNFPhrZr4w/xUBUE5iy3Krr
	cged2tZdXsHfU8BNZEakIyfmq2VTURH4/IfY5Q3oIMBOLzz3P/TIt0GW9AQvjiHn
	7ymwZMtAcsNRkw+ad9oKX8X6VboUzfNgboCRDzeSMTgpvpApXcMClSK1QKRbG9fG
	J7xz7D0Qk8C4l5iRR8z+Xywd/54mJyh9oRF6PWde1yo2vrN2Vca8FFwk8laEryK2
	k8qViod/2Q1Kt3CvWNx1gYFBoDUrC7mLCMB2RvA6Hmb0ECOTf1oU1y7LqKicz+qB
	UrecnrquSGJShiiboQaAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729773160; x=1729859560; bh=aEDUElDdAV5Py0U1C7Sd4/u9LWiY
	hNncIkGdxXwixvk=; b=R6WpSU4B9bncl1zE44DQGL3RbiyoafVHdmBknx2EYyg9
	X8y+v1MKu47K17T099Re64yubF/THpuLFAXn7vyeEQ4/v/UUUuulpO0vff2WsY7K
	Zy9KHzp2XWB5yOMuuljNXXF9/fzLZ94qTrYN/APfmnBCg0ZiyCFU5x19eRn/OSP5
	JwTbJPOJT3idSmsUZTsZt7Uc06biWeRaNNnmOVrSmU4PxP1MmQS/g7qdaWH5NVNY
	ut1LVERymk8cHLSzy07vnIHSi3bhxePevNmUegKawyGDWu4a9/AobYw+YbslzHco
	5cUWEEXE2+a6xWpwoIee9KEBRg8eskPwn8vhYfeeag==
X-ME-Sender: <xms:Zz4aZ18mr9i3cjbqn5yzJxdeWGmfx3M_O5omsIvoxJ5bcYnL499odg>
    <xme:Zz4aZ5vMlqhnrfDB1J7Pk8AH5IU23vvohN6Hzsznbv2w7RQvUB77lha6WSDa830Kx
    zSsrKRQBKB5wymY0kk>
X-ME-Received: <xmr:Zz4aZzC4TETVo8YlFapLhtk9cSmGmM0FqPsZn0WiraVRoIlJOnii2m7T2Iz40sQEdtvksg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepthhorhhvrghlughssehlihhn
    uhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegrnhgurhgvfidrtghoohhpvghrfeestghithhrihigrd
    gtohhmpdhrtghpthhtohepjhhpohhimhgsohgvsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Zz4aZ5f4SLN5drDsV1SCIWdNeYLHRJirIPM91UzbzH5lV4xsgIWSmw>
    <xmx:Zz4aZ6NG4T4IkArhRXkj2a_nQ688aicLrlPUz9DcOjHi0MDvakboZw>
    <xmx:Zz4aZ7khjCSBEiMyazQuF9mN-8IRJISZE5ABF1UDwL5jHEPYN9pj0w>
    <xmx:Zz4aZ0sjIG1DCklm0qbUV1suGwCBlaahnx23uw7p_zySFId7u96rSA>
    <xmx:aD4aZ2DhPhHhg1_gyls7FVCG7oc-px09fnBdWEv733Yr_LKySNTLFjk5>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 08:32:37 -0400 (EDT)
Date: Thu, 24 Oct 2024 15:32:32 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH] x86: fix user address masking non-canonical speculation
 issue
Message-ID: <yuxpa4k3hdpplol35cdbvcaiwbi2i4mwwkww6tuab6loopdezm@qkhzxo3zlf7g>
References: <20241024013214.129639-1-torvalds@linux-foundation.org>
 <20241024110822.GBZxoqppmxp0xxG7ew@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024110822.GBZxoqppmxp0xxG7ew@fat_crate.local>

On Thu, Oct 24, 2024 at 01:08:22PM +0200, Borislav Petkov wrote:
> > @@ -2389,6 +2390,15 @@ void __init arch_cpu_finalize_init(void)
> >  	alternative_instructions();
> >  
> >  	if (IS_ENABLED(CONFIG_X86_64)) {
> > +		unsigned long USER_PTR_MAX = TASK_SIZE_MAX;
> > +
> > +		/*
> > +		 * Enable this when LAM is gated on LASS support
> > +		if (cpu_feature_enabled(X86_FEATURE_LAM))
> > +			USER_PTR_MAX = (1ul << 63) - PAGE_SIZE;
> > +		 */
> > +		runtime_const_init(ptr, USER_PTR_MAX);
> 
> Looking at Documentation/arch/x86/x86_64/mm.rst, 5 level page tables define
> USR_PTR_MAX as 0x00ffffffffffffff, i.e., bits [55:0].
> 
> So I guess that USER_PTR_MAX needs to look at X86_FEATURE_LA57, no?

X86_FEATURE_LA57 is already handled inside TASK_SIZE_MAX definition.

Although, it might be worth updating end of userspace VA in mm.rst with
-PAGE_SIZE.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

