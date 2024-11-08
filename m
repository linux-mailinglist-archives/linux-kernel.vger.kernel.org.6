Return-Path: <linux-kernel+bounces-401622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920409C1D00
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52114285CD2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59D21E7C06;
	Fri,  8 Nov 2024 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="lWYdzHFR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aShVMfxN"
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1F41E8840
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068991; cv=none; b=g3j3WKQ7A6romMUm6b+wD0uoY4Rh8HApl0bX/ljrGZvBDBtx0oCJ8TzezdYHiLH6SfIe6a+2FZg0bQ1afaBE7EYjYNTJT/VLiBQwjaNfPiWnmdzjtV4lqhUoXiyskdH2BBLKcF+FF2lKlzTUWSUXeAAv1zdPA3nUnrF6sB4tlYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068991; c=relaxed/simple;
	bh=CSMu/9DpbSa0yfPZMXbHx2O/ex35iBdNqUeSMObjfwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEXYsrBaX+1KDCpUkjjS1390W0I6dy3MWyZSFlfqqfYM/qsF5MlvpNPYoQB8DppYAncj4czPtCIPh9Gs1fsqjyJNYBeRvpK/A3XMj59JbM3eJtNqXenR42TCS154Pulp344lX8bISuycSocB54i3q//E9pIkJve/JJkH3gNYQJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=lWYdzHFR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aShVMfxN; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id C3DFB114018F;
	Fri,  8 Nov 2024 07:29:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 08 Nov 2024 07:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1731068988; x=
	1731155388; bh=lswsVrGpp09FHiwhKyiPQ9xrqp9u/7/U34DSTnM8j8c=; b=l
	WYdzHFRUNkOnEdL7BrNc6ZYF/SWB5RPZVN3nBWB6JH+U/OyuErKYv2aTwGJoy5K9
	5q8DKc+NfyEHlay+Aa0xyzRIfIf/Spn2PiYEHeQDX68HXlnARunbj6xJMSrIppuM
	tHXI+x5ST1SgOhBf4kCfBBpnrZdD2pjkZ4a20HJwFZKDPDDJ22jeosTHsvX8hm4x
	BS58K3UaaoRZiR5eOGw50fYqQVy75S/q/Cn9Cd7ORqdSEm6gCMXJEz5rmkXkmeh8
	mqLlt+XtLHDhoWF/eX1XhnELYO10IBj4fM9ceLzzW+RzP6tngRiicBnMe/ZkXXkV
	pyOts2ykq0pCwZlF4xDUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731068988; x=1731155388; bh=lswsVrGpp09FHiwhKyiPQ9xrqp9u/7/U34D
	STnM8j8c=; b=aShVMfxNQMyORWY2aVc5G6jMN1xR1Qeja+/EiRYMbiKeBS8Wsbk
	8N267Y4tAcUo7emrEUMmToMcyC50xwjjECr318MZqrQglH54G/PhlJLEkcdXVUnH
	cw80mgSP5LHu6ZzeoUnzYbtek2lL+O9zp5DyffSJzc1XwdHi+vEgrh7dw0jgFfsS
	0Nq/essHXeRpGznCCq3ASKN20f3VP+VlK/cGlHlc3CM4vpNlGgaMMXYdDmzB5Uaj
	+uouRPKKP81TPnhy+8InXDaO1zT+OfvoXC8qnXLtcl9ryT/WqVquoLFzb/F8/8B1
	nGjaStpqK3rBQhgpj7q8YidNIWfmVw/WKSg==
X-ME-Sender: <xms:PAQuZ9SJ3EFN-dM369OEyB8df5YCs_Of6W7lbJIElTHzuXOrR4lf5A>
    <xme:PAQuZ2xDIV5kxXMd16eSw93M-Yrq8pJpy0iWd06UXHooVaFgPucCt8o7HK7b3AFp2
    xMGZbOOiHmS-zu9SNA>
X-ME-Received: <xmr:PAQuZy0Vrb26583A7WxTkx1CGLaaS3pYD_yPU5tQAEvuXhw0gICnNS0P_bSbeN-vvbnkEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecu
    hfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhessh
    hhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhepffdvveeuteduhffhffev
    lefhteefveevkeelveejudduvedvuddvleetudevhfeknecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdr
    nhgrmhgvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegvsghivgguvghrmhesgihmihhsshhiohhnrdgtohhmpdhrtghpthhtohepkhhirhhi
    lhhlrdhshhhuthgvmhhovheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhope
    ihrghnrdihrdiihhgrohesihhnthgvlhdrtghomhdprhgtphhtthhopehkvgigvggtsehl
    ihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtgho
    tghosehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepgiekieeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprhhitghkrdhprdgvughgvggtohhmsggvsehinhhtvghl
    rdgtohhm
X-ME-Proxy: <xmx:PAQuZ1DeFxSowGphQsDsnbdh-mW-uWxdGD1DW73-LKeaJqkTlSJtyw>
    <xmx:PAQuZ2hM6Y3kVJq5AsSIVArK1X75Zw32D2iiX52TPIwsD_5czR6kRw>
    <xmx:PAQuZ5qUwSd5u8ENfxYLBwSawnns1pbVOlr8RP_lfoWXQ4qz1kJ6IA>
    <xmx:PAQuZxgzhNUWFzc9UvdeXtuNexKMgbytGapWJ1bNmix6C-F1eCL-9w>
    <xmx:PAQuZ_WiLzPmTwK5YCnLSusEadyAFfOGE9Q7uMBvSR9Gk6ALJ3X1Isbo>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 07:29:45 -0500 (EST)
Date: Fri, 8 Nov 2024 14:29:42 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, x86@kernel.org, rick.p.edgecombe@intel.com
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
Message-ID: <ozlssxlgc7a7hkwbq3tndam65l6l4ttfri6x3dmzye5qr5ehtn@qflzhgnipuxa>
References: <20241021034553.18824-1-yan.y.zhao@intel.com>
 <87frop8r0y.fsf@email.froward.int.ebiederm.org>
 <tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta>
 <87cyjq7rjo.fsf@email.froward.int.ebiederm.org>
 <ihzvi5pwn5hrn4ky2ehjqztjxoixaiaby4igmeihqfehy2vrii@tsg6j5qvmyrm>
 <ktwgnbsni5pt2cznxj2g6qyb3xwkhjrciym6lpk3uvsxgi4324@tllciap26vb5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ktwgnbsni5pt2cznxj2g6qyb3xwkhjrciym6lpk3uvsxgi4324@tllciap26vb5>

On Mon, Nov 04, 2024 at 10:35:53AM +0200, Kirill A. Shutemov wrote:
> On Fri, Oct 25, 2024 at 04:56:41PM +0300, Kirill A. Shutemov wrote:
> > On Wed, Oct 23, 2024 at 10:44:11AM -0500, Eric W. Biederman wrote:
> > > "Kirill A. Shutemov" <kirill@shutemov.name> writes:
> > > 
> > > > Waiting minutes to get VM booted to shell is not feasible for most
> > > > deployments. Lazy is sane default to me.
> > > 
> > > Huh?
> > > 
> > > Unless my guesses about what is happening are wrong lazy is hiding
> > > a serious implementation deficiency.  From all hardware I have seen
> > > taking minutes is absolutely ridiculous.
> > > 
> > > Does writing to all of memory at full speed take minutes?  How can such
> > > a system be functional?
> > 
> > It is not only memory write (to encrypt the memory), but also TDCALL which
> > is TD-exit on every page. That is costly in TDX case.
> > 
> > On single vCPU it takes about a minute to accept 90GiB of memory.
> > 
> > It improves a bit with number of vCPUs. It is 40 seconds with 4 vCPU, but
> > it doesn't scale past that in my setup.
> > 
> > But it is all rather pathological: VMM doesn't support huge pages yet and
> > all memory is accepted in 4K chunks. Bringing 2M support would cut number
> > of TDCALLs by 512.
> > 
> > Once memory accepted, memory access cost is comparable to bare metal minus
> > usual virtualisation tax on page walk.
> > 
> > I don't know what the picture looks like in AMD case.
> > j
> > > If you don't actually have to write to the pages and it is just some
> > > accounting function it is even more ridiculous.
> > > 
> > > 
> > > I had previously thought that accept_memory was the firmware call.
> > > Now that I see that it is just a wrapper for some hardware specific
> > > calls I am even more perplexed.
> > 
> > It is hypercall basically. The feature is only used in guests so far.
> 
> Eric, can we get the patch applied? It fixes a crash.

Ping?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

