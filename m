Return-Path: <linux-kernel+bounces-265260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE0F93EE97
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9053A1C21A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D0312BE91;
	Mon, 29 Jul 2024 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="M5JVOAhn"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87858405D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722238642; cv=none; b=NV2SpBy6lTtSYp2JVxA8xYzktN+aDme1Fe2/KoNtqH6sSWI6yd9y1fus0HA7PCkmcHkvvaPQeDZwxOJ1lNXYijbgHzthQvBT0mIEVBiawz/FoBrPp0Ryx98rnSaOBShOF8tgDWIjelWlQu5mJA8n+uurGvuPxpJ4hHhiTKHCHHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722238642; c=relaxed/simple;
	bh=xh35lWVybpfb50jbud+d9GoOn8NzNc1b7hY3gmkMAhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maYJRlYT5umNPo/in/FV3UWY7cIw8qu1cU76h37zjwZ83u/kFyyuUj7huq88TUeeKyNZw1RC784BG/KNmj5N0jJ6eu4fXh2squp0vuV2b4jE136Ad905TNB7N93NC/Ntdxv5DAL/UpLlQ/f8C/TeKXWfwK+2kmBgwMPxvhi/Ov4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=M5JVOAhn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2732740E01CD;
	Mon, 29 Jul 2024 07:37:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id omumRzOIxJFO; Mon, 29 Jul 2024 07:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1722238628; bh=8M2kh7pb9zb2h2r+Zlz6AdOcPVeXs0BRF+Vy8SM5Gaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5JVOAhn6ZGXN6HNTF/2k8lSwSK/HG/NvMU9DEeW65T/9ZsdhOKLiOtaSX4jFHbg9
	 F82qPA8U3AfMTqtDohYvLCmlDsxo8RJjxD5VJeKylRP7Nq2e1gaM2bKgjctoB3J7FV
	 dKwvUOSNL0uiVNuJHmp8ivIubxnGnJjvvEWrTFJKasAb79CG9yvKw21tvSplzSFKRl
	 p/jYtbgHlRHoNDmOB76tDBYGJQZaFgbNCKQNRrSRZ0TM39XzPC2kiLS/wfZ2rFTQpE
	 wbjWa7PGv0F+gyHdrwO7w8mj8m8A1IYf6nt2v+OVNIdk0OJP0vQYVAdzT7Cyy6XiUX
	 Ho4surnrimTzC0I+iUoiWx/ApbBEUhLuFy+EJ6GRnwWDjhAAFGIBvjDJJR3V3NNYIJ
	 zzbjk3BsI9cagfvyOLVUXb8yVulcV7KklJpzsDe1PLHy5IqrZ2TxROyQVPJ1biGLu/
	 CPFBFoL6pZiH+cIUFEOAj/noRtYOfusNeNtLL57PUf6uEs04P13ZF7XdbafKsMPnPD
	 KuDcKHe43t//GLT4iVXKfRd0bunOXydIeTM8IJxdc5jXwxiv4ajJHIuY8CNbWB3dnX
	 Drqe9MWlWodwkD5fRWvoSW014QKwU4MuGhOtjTeOYqWoJd/E/1TG9oetLzJfibR/EY
	 T7sMWvH03n/lzNgSQmVFOP54=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C32940E00F4;
	Mon, 29 Jul 2024 07:36:58 +0000 (UTC)
Date: Mon, 29 Jul 2024 09:36:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob <rob@durendal.co.uk>, Christian Heusel <christian@heusel.eu>,
	regressions@lists.linux.dev, x86@kernel.org,
	Joerg Roedel <joro@8bytes.org>, Tony Luck <tony.luck@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>, Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH] x86/apic: Remove logical destination mode for 64-bit
Message-ID: <20240729073651.GAZqdGk97FQzkGCPS8@fat_crate.local>
References: <5e08cab0-c6b5-4169-8d42-ddb0ffb4a6c9@heusel.eu>
 <20240725105029.GAZqIt9aLsIaG7JqN5@fat_crate.local>
 <12df8b45-6100-4c8b-b82a-a6a75bed2e05@heusel.eu>
 <87a5i4whoz.ffs@tglx>
 <ZqQSmw51ihns03ob@vendhya2>
 <ZqQl79UhhSQ5IobX@vendhya2>
 <8734nvuvrs.ffs@tglx>
 <ZqTufKvJKvotC-o_@vendhya2>
 <87cymyua9j.ffs@tglx>
 <877cd5u671.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877cd5u671.ffs@tglx>

On Sun, Jul 28, 2024 at 01:06:10PM +0200, Thomas Gleixner wrote:
> Logical destination mode of the local APIC is used for systems with up to
> 8 CPUs. It has an advantage over physical destination mode as it allows to
> target multiple CPUs at once with IPIs.
> 
> That advantage was definitely worth it when systems with up to 8 CPUs
> were state of the art for servers and workstations, but that's history.
> 
> Aside of that there are systems which fail to work with logical destination
> mode as the ACPI/DMI quirks show and there are AMD Zen1 systems out there
> which fail when interrupt remapping is enabled. The latter can be cured by
> firmware updates, but not all OEMs distribute the required changes.
> 
> Physical destination mode is guaranteed to work because it is the only way
> to get a CPU up and running via the INIT/INIT/STARTUP sequence.
> 
> As the number of CPUs keeps increasing, logical destination mode becomes a
> less used code path so there is no real good reason to keep it around.
> 
> Therefore remove logical destination mode support for 64-bit and default to
> physical destination mode.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/apic.h         |    8 --
>  arch/x86/kernel/apic/apic_flat_64.c |  119 ++----------------------------------
>  2 files changed, 7 insertions(+), 120 deletions(-)

Boots on my Zen1 but then again, it never had those Zen1 client problems to
begin with...

Anyway

Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

