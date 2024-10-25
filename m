Return-Path: <linux-kernel+bounces-381814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FB89B04CA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F3D4B23D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2161FB886;
	Fri, 25 Oct 2024 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="HwoQyiz2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JMuyYIFa"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0139E1F76A9
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864612; cv=none; b=MHb5fxzX2XXjVCRpQ4G8o5EZ+1fhi+mU1ghlIzI9LYTNgmD6OMCl33P1UZk9Q6/Rjss3RwVEShZ9sk7Dg4IW7iCCCf+f2WAc6m8pCT6OKFPCjjjtFM+EU+7DAof9bIIsdyOK9klIb/BxoKhpfO56HEMvzmWI3wGEVGFhQKd7oW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864612; c=relaxed/simple;
	bh=OiT8JxOAoTd4Z4TYTOXoIXQTR2pbbQsAKCp0QTemFOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyBaZ/E0SyJjVH8v7bUY2Xeu0JEk97Wpbb2zjUiXJmjDCC3eTzQG3H7/FM+JHdwxZqdt8woMfQ/80Kn9oj80Ydb/Rj35rcaBZr85P7tZ0UTFkmdBYrD3pfBY9UMLY0QG3nHJorOep3ZuxlvF8v8tW8/XKo753wAeBDXkG4z3Ttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=HwoQyiz2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JMuyYIFa; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id ED908138013A;
	Fri, 25 Oct 2024 09:56:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 25 Oct 2024 09:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729864608; x=
	1729951008; bh=Mb7CPbDsMkHl3VCngl15IkB9nuLUepRzV8CtrrDN0C8=; b=H
	woQyiz2iNFAHeR0dS6ZYSOpHMPgtWoy9McKD4O8aqbP0QpuUK9w3Zf/TdL20Cy/a
	CDMrY1BvSwTUoodjGJedvXihF2ZfZq0JlXcderHEZZzbBIT4xsK1bEOTusr3wCU5
	kzqLtiaboKv+sdPM9d9jknkg2crINH6Kgv/gKlBrx/TYo8C9znKFrfH2OEkQ9TPP
	ntOdx84XZVnDYORp+TybjM3sXbMAo34rXL2X7Djs239w13MaQEtbS3VGv0z0m8gg
	o8YcoAdWYntDeJk99T5TMvo4N25wS4GeE8a4zkHI9dNYQPRK7DRKhNMXjRCPOufM
	soyG+YzuVNVd7vT9a8yAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729864608; x=1729951008; bh=Mb7CPbDsMkHl3VCngl15IkB9nuLU
	epRzV8CtrrDN0C8=; b=JMuyYIFaDVcWVEQUrjnP08uMto9mpVdu37QKcIZzhX5Y
	/1ThO6+thlfO5x/9H5p+ASWP/pGAwocyRsj1LGbdTmkixhPJW72v7cOXa9+erLGd
	1vyqi1wTf6mLzTDRbIXBEZiMbPIbf4S49AxV50UCoi9CjbWU+ohRNSOhToPEhAM/
	UL4k+ICO9zCZL+hYRtb2DHofFosJu6uIxP9wGorKUxWRAQM219b6v4FTxNhyIsd+
	GglVSgSTgWn8CzGVtO4ekiMyVSo/WVt0FTQ7ZlixLzu+NbfisgVGViaj93CWusA4
	MV3TtBjbzKWNzffwY+f6qljU16YpHX/V25ahKHEskA==
X-ME-Sender: <xms:oKMbZx4d2WHRHwJHgW2TA896BymT8wN01WRxp9o3PaZOWhhPkG8jLQ>
    <xme:oKMbZ-51ON1PdeIeNVdVnQjS3J-DQrSTVBq0hjjRt1Tb38NRHbNp3gHOJxB1y0NvZ
    ApJiJOI_pCeCR-L8P8>
X-ME-Received: <xmr:oKMbZ4dixv32WIGNe8ECo7jN2tMme3kRsaWdg32wN8HRM9LlmcU4p5aSmH5YQdaNw94NTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejvddgjedtucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:oKMbZ6KpVHWW-L9Sdqww0-9T1IY4QZmOTj3blLEnxvIXQ6Khw2sjQw>
    <xmx:oKMbZ1KKDx88TIR_ypqZNeF1R8OgkHv6hp1F6u3eIxAJFLSnbw37fA>
    <xmx:oKMbZzwtYlDtTJQHBevKysof0eXIsPSg5H0DwScUnP6qkqb5JKb3oQ>
    <xmx:oKMbZxK8Xpzg_RGRuBBUH6jLnc6snORzs3MRYYoWD9DxTu0o1NWKMQ>
    <xmx:oKMbZ8_6_niIEGeFyIZ5jH9P-rFaknS4k4TlVxnuqK18b5nEhL88HZro>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Oct 2024 09:56:45 -0400 (EDT)
Date: Fri, 25 Oct 2024 16:56:41 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, x86@kernel.org, 
	rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
Message-ID: <ihzvi5pwn5hrn4ky2ehjqztjxoixaiaby4igmeihqfehy2vrii@tsg6j5qvmyrm>
References: <20241021034553.18824-1-yan.y.zhao@intel.com>
 <87frop8r0y.fsf@email.froward.int.ebiederm.org>
 <tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta>
 <87cyjq7rjo.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyjq7rjo.fsf@email.froward.int.ebiederm.org>

On Wed, Oct 23, 2024 at 10:44:11AM -0500, Eric W. Biederman wrote:
> "Kirill A. Shutemov" <kirill@shutemov.name> writes:
> 
> > Waiting minutes to get VM booted to shell is not feasible for most
> > deployments. Lazy is sane default to me.
> 
> Huh?
> 
> Unless my guesses about what is happening are wrong lazy is hiding
> a serious implementation deficiency.  From all hardware I have seen
> taking minutes is absolutely ridiculous.
> 
> Does writing to all of memory at full speed take minutes?  How can such
> a system be functional?

It is not only memory write (to encrypt the memory), but also TDCALL which
is TD-exit on every page. That is costly in TDX case.

On single vCPU it takes about a minute to accept 90GiB of memory.

It improves a bit with number of vCPUs. It is 40 seconds with 4 vCPU, but
it doesn't scale past that in my setup.

But it is all rather pathological: VMM doesn't support huge pages yet and
all memory is accepted in 4K chunks. Bringing 2M support would cut number
of TDCALLs by 512.

Once memory accepted, memory access cost is comparable to bare metal minus
usual virtualisation tax on page walk.

I don't know what the picture looks like in AMD case.
j
> If you don't actually have to write to the pages and it is just some
> accounting function it is even more ridiculous.
> 
> 
> I had previously thought that accept_memory was the firmware call.
> Now that I see that it is just a wrapper for some hardware specific
> calls I am even more perplexed.

It is hypercall basically. The feature is only used in guests so far.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

