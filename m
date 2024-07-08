Return-Path: <linux-kernel+bounces-244844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8F392AA3B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3BC1F22E64
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79B914B959;
	Mon,  8 Jul 2024 19:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="e9Pubnss"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813CC1FA3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 19:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720468733; cv=none; b=sekaqti5SQg0sBV9hnaG5vT6w7EMv1SDi0v7M/fm8RaTcgVyk+EAaYeSuaRk7adMOqMmfLFdQzkcvywwTQsgPfzT8E5aOzqf+hjTNvO02PhbJMJCkTQBQoAplmh6DYVBSo01Z/gYmFCbz1hfVSjp8r3jnCBMEjbFxyyr87Y4guk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720468733; c=relaxed/simple;
	bh=GsUfFcB6M36UY4rgWpA54r3QbUNVx88bFrUbU2Ku70c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhqVu+1++UlZYkqF0efq9THW6ffnm7yvTIBtr9vFyBHeIel+JGqzhZwhX3Jtb45vluER7AEgbXJUFKhSQ3uZ430QBteHeonbQj0HMZr6vxC9VhVkGT5ZV4sN5sm5cWvV+SyzGlvkRwXKaajunB8FYOeFQfb5wkBauBork+UoWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=e9Pubnss; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BB00340E019D;
	Mon,  8 Jul 2024 19:58:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8q5sUzVCfdGL; Mon,  8 Jul 2024 19:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720468723; bh=3vHLLBOF7qwRhaGK9IxTFmmDZWOslx4PEvWUeucnhIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e9PubnssoQHJVb77CYCKn8KITLipJDqqsxzgsVJx8gdhbK8sgblZrILtIA0kkxa61
	 gJSPq0GUpMbv6jAd2ItCUMBJmLzkaLaupIvmNwVFkq+/FA1+VVp+KrRDQhQby5xfRD
	 UGhffTmKY6IdDBL4Zs3tObH92lgruTGHnBMX4gw/ik0oj8CFYSROdtgBZ8EZR7Zgs5
	 MI+04rXfbPGL559+/OtPb4+UhPvXEo3JWZwqQjU13WnfrdUNtDtsvKW3luWeCPdZq4
	 cIxwzThR4PbmUXkm73EhNslCS/v3SJkw3V1d4Ml1NDsCqYcLSwFXU1mxLNDxnkloqT
	 xuL7zZqpn8cIdaiYBW0sEAtztZ5tJ3qUUrgc5r5XeujVktAPuptmt9Poa8hfNr6B7K
	 l9ZwWNhA+GQew+mPbAxATh9UJwSnj80LlQsAZysRuupVKDf+B/I75SJB2y/1vDXkkF
	 5tzv+0AsQ96ATevw3xG7sUHxN45qQEGytqZb4dYOu15mTn2Izna4iYn/0cxlbJKXaW
	 O6BqB2GhywXS+m8GPVe69/eh/mq+LyeIFJnPioFP8VKD/hfWBKqUfYyxngFjFk1fF0
	 phhOpEZJvzQnX4/BcJWwslQdsqBKN8ZHroqd+Rm2WAPJffh8qROui2bDYGF1wSjcpb
	 JKkGfLru93W2G7syi43qd03c=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B598040E019C;
	Mon,  8 Jul 2024 19:58:16 +0000 (UTC)
Date: Mon, 8 Jul 2024 21:58:10 +0200
From: Borislav Petkov <bp@alien8.de>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ashish Kalra <ashish.kalra@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Pavin Joseph <me@pavinjoseph.com>,
	Eric Hagberg <ehagberg@gmail.com>,
	Simon Horman <horms@verge.net.au>,
	Eric Biederman <ebiederm@xmission.com>,
	Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
	Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Yuntao Wang <ytcoode@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <jroedel@suse.de>,
	Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 0/3] Resolve problems with kexec identity mapping
Message-ID: <20240708195810.GKZoxE0pRWHEUljjnQ@fat_crate.local>
References: <ZnmNKAE5qT48yhrI@swahl-home.5wahls.com>
 <20240701142704.GGZoK8uDt-2VVtclHl@fat_crate.local>
 <20240702174425.GHZoQ8edlTfB1falcO@fat_crate.local>
 <CAMj1kXGsjU5CpF655me1XNA8-5nbk3020vT2Bu5ZoFY25igovg@mail.gmail.com>
 <20240703154301.GEZoVxhREtHjk0vtaL@fat_crate.local>
 <ZowI9w7huVfcKJ7I@swahl-home.5wahls.com>
 <20240708181133.GHZowr1eznPqgvdtRw@fat_crate.local>
 <CAMj1kXG8hZ86BFbar9S5mmvKMH4a0XF0oCm36WwZxYNqc0+pjQ@mail.gmail.com>
 <20240708190724.GIZow47G0J8vO6J3ee@fat_crate.local>
 <Zow-AXsLHjU6gfET@swahl-home.5wahls.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zow-AXsLHjU6gfET@swahl-home.5wahls.com>

On Mon, Jul 08, 2024 at 02:29:05PM -0500, Steve Wahl wrote:
> Yes, this is about AMD machines which support SEV, running bare metal.
> ("Server" is in question, one of my testers is known to be using a
> laptop, so the facilities must be present in non-servers as well.)

No, they can't be. SEV is supported only on server, not on client. This laptop
has a different problem it seems.

> As far as I can see it, the effort you're putting into finding a
> different solution must mean you find something less than desirable
> about the solution I have offered.  But at this point, I don't
> understand why;

Why would we parse the CC blob which is destined *solely* for a SEV- *guest*,
when booting the baremetal kernel which is *not* a guest?

This is the solution I'm chasing - don't do something you're not supposed to
or needed to do.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

