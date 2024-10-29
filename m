Return-Path: <linux-kernel+bounces-386474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1905E9B43EA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F8A1C21425
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D536203709;
	Tue, 29 Oct 2024 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="TNSE7I3W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DCieedm9"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1747E4C6E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189653; cv=none; b=h9YZNW8LNygLHVZhxLK9FkJvryKa3TsZ9ZyZTCkxyrC2KQ1tTLE7GdSaXXFI7iHbY97vJO4EnPnyhNrhwwoGMt63un+zIQzkzbUpsTU7LbtSSPd0chELgWpisacvM2rSHsGtt5euMuSHranSiiVJuxzffTZNYFiQyVqwGaC2MwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189653; c=relaxed/simple;
	bh=Z5Xx4sdSBp1AFWyasoBZv/zBYzdQDXIdOTkEWja4AIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qc48bF/cvNQNTu5nE458jMq5NyA8F+Y/EgC53XUPcduZS8rNj7//7caX+cQGBm2W/dI39985mzFSW1XRYRVisXzxx7LXdoGPe5kdmtjs6CmdWM8kdP8DnsWMSH5KIfNnShw/Mksk/zIoL1Wxm7G6xpiOCxZ6i+noEYhmsRkyuu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=TNSE7I3W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DCieedm9; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 2CCB613802ED;
	Tue, 29 Oct 2024 04:14:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 29 Oct 2024 04:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730189650; x=
	1730276050; bh=7NYufWTOREEx4Z5cqEucmidQbanki23iE88bx4I2JSw=; b=T
	NSE7I3W1TsjDfKXuzY51IU5hXQ55kFm3D4LWkATsVfnpLUxtWYbPup8WwpQQDLOz
	mputY7BoL98rdouso4WcKMswtsZUac2Efbc44t8Drjshfs3jg+FCh5yUE6ZBHxZh
	sQalzlKan50bjUmk8kDQ4lPOKZC6Lgq+rBw1olzeoT7I2E4s/VSyCSJPHYpiqoyL
	gS044R/Py530yQalGkSaR71VeGsfIi+vH7YEOtFTE9foF5Fqljgo9DUqEFR/rZJ7
	rLVVs4jkn+w+BfIaUMBG75kGmej3VqQHvlTVxhPpGJgIhaMD64CR5ZzSflo9OmMY
	fCNnV3JT5H1vsL6OE4pHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730189650; x=1730276050; bh=7NYufWTOREEx4Z5cqEucmidQbanki23iE88
	bx4I2JSw=; b=DCieedm9ypTKyoHqyWWxL3mXx5hzloAEFNUG78bZzkxjYnHnkUf
	FDMBftlcAYJKTtg0A1Qdn1i3+9igpoNXbzmATepz2DviyVxy0kutIz5WNz7sRZrF
	H6HmMj8yeZkeSw4dOXmcvWr/99N7eZyVrSLFqFW4D95mfuT3cIwNqgHhd3HQV7rf
	BHosAbUJh+WVdJLRaInwXI3BItyRcSbatL/9bwouuVyXkHDOGV67Fqy4hpa5BCNu
	ucsb9MB6q4P+IBwk1cvWEYLbE+S+0rmc9cSDizrxAwDWpjkJkollOXQH66pEviP7
	kpf10oUUPZo5wZ4APb0E77+88RQt0gsMTLQ==
X-ME-Sender: <xms:UZkgZxJmeKw-cxUoZGYJNcMbfrooiXpMG8pP7nb-IHo5c1sAdkeS_w>
    <xme:UZkgZ9K9hZefIZ99eydd8OqwF0DYkTQgH9L589-z9JroEQGU6QgkXqk2JvcgxAJ_1
    OgFusw04uiXp7IjGZo>
X-ME-Received: <xmr:UZkgZ5vWdL1nfdYAs7OJA4MzNg68kGB2-H8a2Ww5t9U2jzlHu8qIJHDhmR67FWZRz80fQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdektddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddv
    necuhfhrohhmpedfmfhirhhilhhlucetucdrucfuhhhuthgvmhhovhdfuceokhhirhhilh
    hlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeelfedvlefgfeeu
    veevvddvffevtdfhhfeftedutdekfefgleevuefgleehieefleenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtth
    hopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhpohhimhgsohgvsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopegsphesrg
    hlihgvnhekrdguvgdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhr
    ghdprhgtphhtthhopehprgifrghnrdhkuhhmrghrrdhguhhpthgrsehlihhnuhigrdhinh
    htvghlrdgtohhmpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:UZkgZyYOVikNDhLyxkfgPuhzQCwOoW9H7jQWwKj_ivfNyBX5biGeOw>
    <xmx:UZkgZ4bupSVnyq9F5szKc5NzfOZsmh89Hlsck3q0-4c-yesVn-Facg>
    <xmx:UZkgZ2CPYbROF3cypPu2VyJxhS3BeaNO04E_ULNWWNCrxgGyFn7Btw>
    <xmx:UZkgZ2bdd1MFsARdTqC_j5C09_LYAvqiaXy9MHaPyfXDULaIb6wcFQ>
    <xmx:UpkgZ1KwqiJ4Ch7rqN8y1SRzW723d4czoHnaTOb1Rvi2RvGzfmyP0OxD>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Oct 2024 04:14:04 -0400 (EDT)
Date: Tue, 29 Oct 2024 10:13:59 +0200
From: "Kirill A . Shutemov" <kirill@shutemov.name>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Waiman Long <longman@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 1/6] x86/uaccess: Avoid barrier_nospec() in 64-bit
 copy_from_user()
Message-ID: <qc5o7g2cz2lmu2ac3bielkhr6novbjhx6k7xxzijag3fcvq4qq@fl76ynhguliw>
References: <cover.1730166635.git.jpoimboe@kernel.org>
 <5b887fe4c580214900e21f6c61095adf9a142735.1730166635.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b887fe4c580214900e21f6c61095adf9a142735.1730166635.git.jpoimboe@kernel.org>

On Mon, Oct 28, 2024 at 06:56:14PM -0700, Josh Poimboeuf wrote:
> The barrier_nospec() in 64-bit copy_from_user() is slow.  Instead use
> pointer masking to force the user pointer to all 1's if the access_ok()
> mispredicted true for an invalid address.
> 
> The kernel test robot reports a 2.6% improvement in the per_thread_ops
> benchmark (see link below).
> 
> To avoid regressing powerpc and 32-bit x86, move their barrier_nospec()
> calls to their respective raw_copy_from_user() implementations so
> there's no functional change there.
> 
> Note that for safety on some AMD CPUs, this relies on recent commit
> 86e6b1547b3d ("x86: fix user address masking non-canonical speculation
> issue").
> 
> Link: https://lore.kernel.org/202410281344.d02c72a2-oliver.sang@intel.com
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

