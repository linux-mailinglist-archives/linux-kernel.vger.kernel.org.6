Return-Path: <linux-kernel+bounces-376228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E3E9AA1DB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52EA2812CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BAF1A0706;
	Tue, 22 Oct 2024 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="coAE1ZBn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jBlctpeo"
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06F61B5EBC
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598787; cv=none; b=RIaCMBvNwHP37GTSPur7wLLfY3VVan2tIMvKzV3hddLwxQwUHiJuOF5Pd4DhfNYCsalTMcy03PnAAdcIOzE9s+aTh1Y3JH5tCkzcxnMGPVPDFXiNrleLweg13WC7nXOhO3+TMLae2wp7PAzxWmRse6foEE52TE1U43DZQv9Q5M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598787; c=relaxed/simple;
	bh=pjAmceQFt4MMrsHNqmCagnhfhP1uDtoo7Ng4WbIpUVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZqVfAZOhyXwhMzF/g/JzNXB3WeUt60rLWt5rdX5vHFkBL9gv5h3fqpOB2NXk3XcWkBiMWpp+JxEpIrpKoaLnlZ52E+r4fFt4tQjqbBe8jJ+1kqJSp6B82d9KOkijkztcglEt1v6A+ct8wA3Reknxhswa3/Zy/rgE+DD7Y/IbCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=coAE1ZBn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jBlctpeo; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E70C813801DE;
	Tue, 22 Oct 2024 08:06:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 22 Oct 2024 08:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729598783; x=
	1729685183; bh=XALMLFIneOKfWdqu2K+AmUt1MMElDGjAw56Uce222Jw=; b=c
	oAE1ZBnBERAYE0C1WWrJ1hDVvQM+qPDupItO4AT245jgKjlCdqE5pxM2o5PzlI72
	OhVuvOSWgAzOPD87T4jh3H35GvcrrdClOZriLY+q3RyF/7SCMgIBahjwsfkvJcnB
	4zopTvP2bTr44QPdEPSk930zXIVFtmZE2RZeiRSgm9qxZ/acY0mxbn8geAyg9TYl
	k4PvYheTE0ei7j4mg06ttS82EcrHKBw/4CTDnqJ9rEb57IVnUXdh9vNYn2oLtaDh
	JADmalq/4BTza21m91tFBUZET5RZQ08rCM90mCNINSPD6+b3WWhdFrTwi9ZAfMqZ
	acQ2t0N4KMFQiJPZuixRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729598783; x=1729685183; bh=XALMLFIneOKfWdqu2K+AmUt1MMEl
	DGjAw56Uce222Jw=; b=jBlctpeoo16nnW4b1y5T56neNLRYcLsqLcGTEpRKbEsV
	tvj5+lMvYfX++t74VaC70c1J/J6sMvqZWS0J/kULeVjKt3WD1tdZ1VZa3b+W8jb5
	2P7Sn2jCF3xHcEfbCUFH607FIZ/1U+rPElHXP7whUsXAKCVuK6KVzgMHW4tYu5zu
	pWj94IMuyvlN6EKV0yzfO3dUCy3hGwWEJv7mNyA9dJZQwoMyOGUvghRTc6doSdDI
	DsWZii0M0mRml9f5eSNVWjZSo7rov9WnauVaDeM6+NUznCJyNzm/lVDKVWdDYYqk
	+DReeiaPNHZuV/AeO0XLgQPZBLh+rM8v4r2xmL5C2A==
X-ME-Sender: <xms:P5UXZ4D0t5GeK9q4RmtLP0dcsNSHRW1zpn3Sb0W3IYe9GS9NEZIgtw>
    <xme:P5UXZ6g29P6jIOcAapSusyWnl7b9BbV3ADSGkKa_HajeBRLHjCqNtQOYb8nhvdsho
    CBI0Mt6dxRqSQdJvWE>
X-ME-Received: <xmr:P5UXZ7mNVgEkGiEZyJ4U_jVqOG-ShkWhc_VVhohkcXIDTXjQkPkCbAs9KNZ9PjJFR5PDug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeihedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepvggsihgvuggvrhhmseigmhhishhsihhonhdrtghomhdprhgtphhtthhopeihrghn
    rdihrdiihhgrohesihhnthgvlhdrtghomhdprhgtphhtthhopehkvgigvggtsehlihhsth
    hsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghotghose
    hlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprhhitghkrdhprdgvughgvggtohhmsggvsehinhhtvghlrdgtoh
    hmpdhrtghpthhtohepkhhirhhilhhlrdhshhhuthgvmhhovheslhhinhhugidrihhnthgv
    lhdrtghomh
X-ME-Proxy: <xmx:P5UXZ-z5na7gTuq-gPsDbmzcOTMkur0Bx1Hf1OGV-rk8AALgjMAM5g>
    <xmx:P5UXZ9Q1oZGpXp4iyrGZwmEBpAZokhVNba7iiX_OZBUM8d3apF7zUA>
    <xmx:P5UXZ5b_VtBBedhkNv4aUvMo86gBv2vi0kjCuc1oKbhzKj6QWifYug>
    <xmx:P5UXZ2QokQP7SMve-sP3koPmqYbShCNSL4V_dSxikGrTibzOckWXPA>
    <xmx:P5UXZ4FWmNNbj-cL1O0S1qnmfkNQa6uTbWjmmqEuAphFACVdVzM2RQC6>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Oct 2024 08:06:20 -0400 (EDT)
Date: Tue, 22 Oct 2024 15:06:15 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, x86@kernel.org, 
	rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
Message-ID: <tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta>
References: <20241021034553.18824-1-yan.y.zhao@intel.com>
 <87frop8r0y.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frop8r0y.fsf@email.froward.int.ebiederm.org>

On Mon, Oct 21, 2024 at 09:33:17AM -0500, Eric W. Biederman wrote:
> Yan Zhao <yan.y.zhao@intel.com> writes:
> 
> > The kexec destination addresses (incluing those for purgatory, the new
> > kernel, boot params/cmdline, and initrd) are searched from the free area of
> > memblock or RAM resources. Since they are not allocated by the currently
> > running kernel, it is not guaranteed that they are accepted before
> > relocating the new kernel.
> >
> > Accept the destination addresses for the new kernel, as the new kernel may
> > not be able to or may not accept them by itself.
> >
> > Place the "accept" code immediately after the destination addresses pass
> > sanity checks, so the code can be shared by both users of the kexec_load
> > and kexec_file_load system calls.
> 
> I am not at all certain this is sufficient, and I am a bit flummoxed
> about the need to ever ``accept'' memory lazily.
> 
> In a past life I wrote bootup firmware, and as part of that was the code
> to initialize the contents of memory.  When properly tuned and setup it
> would never take more than a second to just blast initial values into
> memory.  That is because the ratio of memory per memory controller to
> memory bandwidth stayed roughly constant while I was paying attention.
> I expect that ratio to continue staying roughly constant or systems
> will quickly start developing unacceptable boot times.
> 
> As I recall Intel TDX is where the contents of memory are encrypted per
> virtual machine.  Which implies that you have the same challenge as
> bootup initializing memory, and that is what ``accepting'' memory is.
> 
> I am concerned that an unfiltered accept_memory may result in memory
> that has already been ``accepted'' being accepted again.

It is not unfiltered. We check it against bitmap that maintains the
accept status of the memory block.

> This has
> the potential to be wasteful in the best case, and the potential to
> cause memory that is in use to be reinitialized losing the values
> that are currently stored there.
> 
> I am concerned that the target kernel won't know about about accepting
> memory, or might not perform the work early enough and try to use memory
> without accepting it first.

The bitmap I mentioned above passed between two kernels via an EFI config
table. This mechanism predates kexec enabling of the systems with
unaccepted memory support, so there should not be a problem.

> I would much prefer if getting into kexec_load would force the memory
> acceptance out of lazy mode (or possibly not even work in lazy mode).
> That keeps things simple for now.

You can always force this behaviour with accept_memory=eager, but it is
waaay slower for larger VMs. It is especially bad idea if kexec used as
initial bootloader and most of the memory is not yet accepted by the time
kexec is triggered.

> Once enough people have machines requiring the use of accept_memory
> we can worry about optimizing things and pushing the accept_memory call
> down into kexec_load.

It is already here and it works. Despite some bugs that need to be
addressed.

> Ugh.  I just noticed another issue.  Unless the memory we are talking
> about is the memory reserved for kexec on panic kernels the memory needs
> struct pages and everything setup so it can be allocated from anyway.

I am not sure I follow. Could you please elaborate?

> Which is to say I think this is has the potential to conflict with
> the accounting in try_to_accept_memory.
> 
> Please just make memory acceptance ``eager'' non-lazy when using kexec.
> Unless someone has messed their implementation badly it won't be a
> significant amount of time in human terms, and it makes the code
> so much easier to understand and think about.

Waiting minutes to get VM booted to shell is not feasible for most
deployments. Lazy is sane default to me.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

