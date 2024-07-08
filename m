Return-Path: <linux-kernel+bounces-244789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B713492A992
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D2D1F22689
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0880114BF8A;
	Mon,  8 Jul 2024 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ChJ3f/tO"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC10A1474AF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720465684; cv=none; b=Eo2MMeCiJb2MXfSDSqPaWXcNX46lMFjMG9jCn9Mp24BJpZvR49mGEUC/ZYoBinfOI2XwVeKQCmPguS4weSeenmBFrCBlzJMl/tiacJjhWgtwuESp3pckQQxIef429IXVSV9RAhHnSfQesdPxCf5hhsjDsMa4LhoBT06a4th89z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720465684; c=relaxed/simple;
	bh=xY+rHXRDPFt2+6Xc8N+6s7u7829wLUiFzL2ck3Zfsts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8uC6GQrrwVZGgk4n/zK4juA5U2kQUxQyc8wo4tnfH9lhaF/ru3uGfEe7oFxlHt2+OY4JeCxokQOT9peJTCmZ5vo0kp4s4J7exrvjenTpgHl+j1yHWY7YyOCn8Jf2jLHW1pyM8EL35XVtPPO7n8rij1BdpBmvNXugr9sWDy0pBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ChJ3f/tO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4260440E019C;
	Mon,  8 Jul 2024 19:07:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vQGfpxHeFspk; Mon,  8 Jul 2024 19:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720465675; bh=1HtKLhsmAYJfhAeUp+8fz+aKD3ClwbFy5mYK7dQwsbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ChJ3f/tOs8g59AvkunsLX1o4AmSPeDj9wcy4Cn00eJ3QFBXewfk4ty/S68i1bhDzb
	 aHdIF0OLC7REutOui6aCrGn6JoWWHjjltiGwbLCr4p8ZlKDmpeWaJqdxknYz63sUYk
	 WiYzCwZtX1XFMmJ2unKzUfTeskR2UiC86TrL4durA5CH92I+T+zQz7hIdkj4BqXAHT
	 x4iOu+YfiJR/VWpkapqfTeqPP3aWDKF4j+qVOQSPEtNVufMpwMWp0rYUeVf9Q6azix
	 GGRA3xU29rAkraPOEvXP1rVz9bMlyNUcV7ZUe9QjlhBAiDt92qqefvE8QlLALsp454
	 KTRCk1yltTLOvYPG3aR+gS/2hsXbrdXCOcrTbfJaHay6b7I7r8+yL1EQIppbGVi0XG
	 Z3BW9dQsLQHz+8Jr8bmjh/tWZLn3dAJPsnqTA2xLeqR+BQVTq0rb8SWDM+L+qi7IpZ
	 GcIViXhSDesc5R5pRRFYfs7zhhII/tkvpjd13Gjo47XLTkuNdJ+uaR4zhygI/h41sF
	 CjSoXew/rFfAeKuDV/vonhtbLDMNn3VA5Ubuvanv3Wj5a/4uEn9W3zYK2iApIo9kry
	 tPtMRIE2BOuCqHmyTkJY5p6pt/8z2o4JC8UkJ6CfDuwPJbXRQf0tDepaMFg5wwsYoN
	 zxKGXKFMvqnlIP64Y5VL1RyM=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5737540E0192;
	Mon,  8 Jul 2024 19:07:29 +0000 (UTC)
Date: Mon, 8 Jul 2024 21:07:24 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Steve Wahl <steve.wahl@hpe.com>, Ashish Kalra <ashish.kalra@amd.com>,
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
Message-ID: <20240708190724.GIZow47G0J8vO6J3ee@fat_crate.local>
References: <ZnBR6MgS-jzjgA8A@swahl-home.5wahls.com>
 <20240621131742.GEZnV9dn_0XVH0IZ58@fat_crate.local>
 <ZnmNKAE5qT48yhrI@swahl-home.5wahls.com>
 <20240701142704.GGZoK8uDt-2VVtclHl@fat_crate.local>
 <20240702174425.GHZoQ8edlTfB1falcO@fat_crate.local>
 <CAMj1kXGsjU5CpF655me1XNA8-5nbk3020vT2Bu5ZoFY25igovg@mail.gmail.com>
 <20240703154301.GEZoVxhREtHjk0vtaL@fat_crate.local>
 <ZowI9w7huVfcKJ7I@swahl-home.5wahls.com>
 <20240708181133.GHZowr1eznPqgvdtRw@fat_crate.local>
 <CAMj1kXG8hZ86BFbar9S5mmvKMH4a0XF0oCm36WwZxYNqc0+pjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXG8hZ86BFbar9S5mmvKMH4a0XF0oCm36WwZxYNqc0+pjQ@mail.gmail.com>

On Mon, Jul 08, 2024 at 08:17:43PM +0200, Ard Biesheuvel wrote:
> Happy to assist, but I'm not sure I follow the approach here.
> 
> In the context of a confidential VM, I don't think the page fault
> handler is ever an acceptable approach. kexec should filter out config
> tables that it doesn't recognize, and map the ones that it does (note
> that EFI config tables have no standardized header with a length, so
> mapping tables it does *not* recognize is not feasible to begin with).
> 
> All these games with on-demand paging may have made sense for 64-bit
> kernels booting in 32-bit mode (which can only map the first 4G of
> RAM), but in a confiidential VM context with measurement/attestation
> etc I think the cure is worse than the disease.

See upthread. I think this is about AMD server machines which support SEV
baremetal and not about SEV-ES/SNP guests which must do attestation.

Steve?

AFAIR, there was some kink that we have to parse the blob regardless which
I didn't like either but I'd need to refresh with Tom and see whether we can
solve it differently after all. Perhaps check X86_FEATURE_HYPERVISOR or so...

Thx for offering to help still - appreciated! :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

