Return-Path: <linux-kernel+bounces-245643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC64292B565
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878C72848C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B76F156880;
	Tue,  9 Jul 2024 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ca/tu21N"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D862E62D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521146; cv=none; b=P+drv7sYkK+Q2L6vSgCck+62GlNkcFiVCAf8Lgpotl1mUw86yyTPgXcw4VUKHuAez2KPUdqpnQYOSqwUQ51u+Ua19NcJ61Ve0Zf7hV65YMc2JLTRRoTLqVBPT3gMfYmk/rK5VPuW1ssfnPi19ttTm0Kxa3442B/SkoxaHUsfDyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521146; c=relaxed/simple;
	bh=32as1wxnPKqtDLG6btQhu/GLv/HerkEljIGguRqf/9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWr4tgSAYsg3Ij5RM/5obeC+s4RcgtYxdmB/GAHlKWCO3LRJZD8EQXU8Wmtcf8zBVdAwMUULCjMadwQosO1cAr4Vwf78d3bfCYOteevl2vFEBFWDQzomruSzKgINGZ5iZ85It84QhL17Ew8Ej0oH+0LqAkbm4HFVWZ1AL8yNtj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ca/tu21N; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B69D740E019C;
	Tue,  9 Jul 2024 10:32:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FSXQK_jsn302; Tue,  9 Jul 2024 10:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720521131; bh=pSHoX8iq7VWbszyXHyhjpFmtiT+fACuINVm+0rQvwbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ca/tu21N5oS37qecJvWm+w5U8GhBVaTU4x9bTZKmpnI+wcRvVUrMVTvg1z7dZbaQP
	 mpqBHmjSPzODofJ2N/2625XV43Vmk5Z0KdrbD4UCu08TcXNyXYNyjUiVRhLi3iFwhG
	 IsNAQNpYkjR4QITrJREHxUCc21lcfIZVGKoZwGyt6roBrRmt9bYlEVJNts8Qso4PFo
	 ZTBPS9CnQKv74eI0uOTUN5i69pGZdLkYxsCUn8hi2Yh8hJf2+Qx9ALPDkv4YHofuKX
	 DtXe+7TdbOvfvo67oMF3Ka2OaflTE+x6XzW6o/umg6pTBDBy95ytcHhlv20bFo8Tb+
	 1lrcdTMvyerQiz1wTcv1mUqOW3+JYaRbCLW5uvRRNvJTvMxxn1XBNVazQ7oimLUX0b
	 DWYosfBDiQd1CM/gTTUzS4u39CIl8oPrAoJzC0rMi0h/h/PKXdpu3QGYtuHKwi71c9
	 0yE5Xp1SWhv2zfOUAmRYAHBCI0Z3TO5fon1SgXQoVFO51qz/Yq015ar3hyzBywbGEQ
	 W78BV5JgQ7CSnoyz1BH8tmmsXHyhvL82UPT2MmO26BmXcs0bnMi6y2lTMLWpkf+IoK
	 xqLkOBh4rElmG1fLAzOs18EUyVnjAb9DyemQf4HrnadmX553uFa/Wd0zLoC75lGJye
	 DaiWXPQSpcA3kE5GUtKwr4/s=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C306440E0192;
	Tue,  9 Jul 2024 10:31:44 +0000 (UTC)
Date: Tue, 9 Jul 2024 12:31:39 +0200
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
Message-ID: <20240709103139.GBZo0Ri_ppOUNnKd_2@fat_crate.local>
References: <CAMj1kXGsjU5CpF655me1XNA8-5nbk3020vT2Bu5ZoFY25igovg@mail.gmail.com>
 <20240703154301.GEZoVxhREtHjk0vtaL@fat_crate.local>
 <ZowI9w7huVfcKJ7I@swahl-home.5wahls.com>
 <20240708181133.GHZowr1eznPqgvdtRw@fat_crate.local>
 <CAMj1kXG8hZ86BFbar9S5mmvKMH4a0XF0oCm36WwZxYNqc0+pjQ@mail.gmail.com>
 <20240708190724.GIZow47G0J8vO6J3ee@fat_crate.local>
 <Zow-AXsLHjU6gfET@swahl-home.5wahls.com>
 <20240708195810.GKZoxE0pRWHEUljjnQ@fat_crate.local>
 <ZoxOt1_w7nblRQCv@swahl-home.5wahls.com>
 <CAMj1kXGA8zG95WutMgVgeb-M7oQKJrVO6QWNzLi1GMuj1wq=bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGA8zG95WutMgVgeb-M7oQKJrVO6QWNzLi1GMuj1wq=bg@mail.gmail.com>

On Mon, Jul 08, 2024 at 11:05:29PM +0200, Ard Biesheuvel wrote:
> The EFI config table array can grow and shrink at boot time, which is
> why it is a separate allocation, as this allows it to be realloc()'ed.
> This means any bootloader that intends to map the primary EFI table
> should also map the EFI config table array, which may be elsewhere
> entirely.

Yap, that rings a bell from a past thread.

> So regardless of how we fix any SEV-guest specific issues, we should
> ensure that kexec infrastructure creates the mappings of the EFI
> system table and the EFI config table array upfront.

Because code in the kernel relies on the presence of those so those should be
mapped automatically and unconditionally?

Or?

As long as we put that somewhere as the thing we do by default, sure, I'm
game.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

