Return-Path: <linux-kernel+bounces-213545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C948E9076AE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404401F2181C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B461494DF;
	Thu, 13 Jun 2024 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MbFOWK/O"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74569266A7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292575; cv=none; b=egiZXkDbFz3xIkJjI0VRzub5lEFQ53Pvx+mcqeZ95xLE5Am9zTl9JeL0eeJGQt2Z/npzWOoVh5bYYvuXZEuitgDOMrvHrV07toCEq0iAZGMTZpEbuH6Ky6pfjQLhPS2ubnk5OdlnAa3ruYfie4PpTYTUGN0LnQh3IFbsZc3DgfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292575; c=relaxed/simple;
	bh=EKluefSAeBcFIOlVa9Bl687D5tm2TGmvjy6DvHsiWhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIpmUgqY4ZSVktmbS5qoSkjCj2Xwa2E3wd7n0BvllJsnTW0pzL7HxyuFg4mrh/CDHHmEO1AxEz3ef2TcoATghH4JJtBl9PT6NIambBm50LdO8v4dAxc32gHGsHI4qf55lsxLzt6tzraKyf7KrbYoRj+Xv/Ds2B9poZs4q4RNc1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MbFOWK/O; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B271440E00C9;
	Thu, 13 Jun 2024 15:29:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6FosomFFqHn3; Thu, 13 Jun 2024 15:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718292567; bh=r/CggczeGNy7zdlqumo0uYFttdY5j2TXbeYU3k1iY9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MbFOWK/OwMRvpJncAbMjzvxQ9kWd3/t1L9hHcDjIKplD4KLGOPkZi58CyhHxIgVZw
	 qFrtQkS7jCbNjP9aHSHPCgOCUpRhXqUKagmCtYFAqNROnjmeuvAFJDpw1EXBw7Kqcy
	 6I2ci0MkT9IpNNdpu5U2hXoY0kN2lcfQRzKSVe//1kKL0suZyUhD428eTQevO8BYOk
	 WAPZx/4AJJZ+Ffbc5sqBiU5S+BrKZG7CxJP2oEBUfQLtBzhdd7N9Es2fv+a8tMNsCB
	 B6zibRx9oRhkg9xQ0z+TwnrvEXJ+Y/Bh48tCSDhI7sEI9TG7JgCUSw/TSqyQB0umPN
	 8RcsH+4szppTm/evHiMEspUSX3Dd+wTF5hpllWDm6E5BgDBl3rVl1OpNgRk8/MQOKf
	 fceIZrVQUFT3K0bX9IJhZTwxPpiKmYr4jplM05T7MJvBZJsqrMtDB8uy3xlNvD3QTX
	 bZB2NgXuDT0zGtXKwOdW4k29NCd3o2jCuMjqvqm9JKUuFAssb+khQjMmT/OrbpbKt7
	 qtP6xNzsM7K9/hTqV0YrwxzPPGqyR80gXxaRbMjoQGkJ1E24KW3jFAxbJLsyDt4kwc
	 7kRHkdB7963KhLjPWH1g3i8C/QuEejjaF8cGzkgYBTYcfR73A6JIq9KPUZd8VUsxm8
	 dAzB9z6abWXC2Bsg07cDJcXs=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 14EB740E0176;
	Thu, 13 Jun 2024 15:29:02 +0000 (UTC)
Date: Thu, 13 Jun 2024 17:28:56 +0200
From: Borislav Petkov <bp@alien8.de>
To: Steve Wahl <steve.wahl@hpe.com>, Ashish Kalra <ashish.kalra@amd.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
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
Message-ID: <20240613152826.GKZmsQGnO3OthLH3Vu@fat_crate.local>
References: <20240520183633.1457687-1-steve.wahl@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240520183633.1457687-1-steve.wahl@hpe.com>

On Mon, May 20, 2024 at 01:36:30PM -0500, Steve Wahl wrote:
> Although there was a previous fix to avoid early kernel access to the
> EFI config table on Intel systems, the problem can still exist on AMD
> systems that support SEV (Secure Encrypted Virtualization).  The
> command line option "nogbpages" brings this bug to the surface.  And
> this is what caused the regression with my earlier patch that
> attempted to reduce the use of gbpages.  This patch series fixes that
> problem and restores my earlier patch.
> 
> The following 2 commits caused the EFI config table, and the CC_BLOB
> entry in that table, to be accessed when enabling SEV at kernel
> startup.
> 
>     commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
>                           earlier during boot")
>     commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
>                           detection/setup")
> 
> These accesses happen before the new kernel establishes its own
> identity map, and before establishing a routine to handle page faults.
> But the areas referenced are not explicitly added to the kexec
> identity map.
> 
> This goes unnoticed when these areas happen to be placed close enough
> to others areas that are explicitly added to the identity map, but
> that is not always the case.
> 
> Under certain conditions, for example Intel Atom processors that don't
> support 1GB pages, it was found that these areas don't end up mapped,
> and the SEV initialization code causes an unrecoverable page fault,
> and the kexec fails.

What does Intel Atom have to do with SEV?!

> Tau Liu had offered a patch to put the config table into the kexec
> identity map to avoid this problem:
> 
> https://lore.kernel.org/all/20230601072043.24439-1-ltao@redhat.com/
> 
> But the community chose instead to avoid referencing this memory on
> non-AMD systems where the problem was reported.
> 
>     commit bee6cf1a80b5 ("x86/sev: Do not try to parse for the CC blob
>                           on non-AMD hardware")
> 
> I later wanted to make a different change to kexec identity map
> creation, and had this patch accepted:
> 
>     commit d794734c9bbf ("x86/mm/ident_map: Use gbpages only where full GB page should be mapped.")
> 
> but it quickly needed to be reverted because of problems on AMD systems.
> 
> The reported regression problems on AMD systems were due to the above
> mentioned references to the EFI config table.  In fact, on the same
> systems, the "nogbpages" command line option breaks kexec as well.
> 
> So I resubmit Tau Liu's original patch that maps the EFI config
> table, add an additional patch by me that ensures that the CC blob is
> also mapped (if present), and also resubmit my earlier patch to use
> gpbages only when a full GB of space is requested to be mapped.
> 
> I do not advocate for removing the earlier, non-AMD fix.  With kexec,
> two different kernel versions can be in play, and the earlier fix
> still covers non-AMD systems when the kexec'd-from kernel doesn't have
> these patches applied.
> 
> All three of the people who reported regression with my earlier patch
> have retested with this patch series and found it to work where my
> single patch previously did not.  With current kernels, all fail to
> kexec when "nogbpages" is on the command line, but all succeed with
> "nogbpages" after the series is applied.
> 
> Tao Liu (1):
>   x86/kexec: Add EFI config table identity mapping for kexec kernel
> 
> Steve Wahl (2):
>   x86/kexec: Add EFI Confidential Computing blob to kexec identity
>     mapping.
>   x86/mm/ident_map: Use gbpages only where full GB page should be
>     mapped.
> 
>  arch/x86/kernel/machine_kexec_64.c | 82 ++++++++++++++++++++++++++++--
>  arch/x86/mm/ident_map.c            | 23 +++++++--
>  2 files changed, 95 insertions(+), 10 deletions(-)

Anyway, + Ashish who's been dealing with SNP kexec. We have identified one EFI
issue so far:

https://lore.kernel.org/r/20240612135638.298882-2-ardb%2Bgit@google.com

You could give it a try and report back.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

