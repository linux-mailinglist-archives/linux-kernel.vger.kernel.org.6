Return-Path: <linux-kernel+bounces-532450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21A4A44DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F283A4E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECBF20C46B;
	Tue, 25 Feb 2025 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6guUG6n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A761A315D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740516013; cv=none; b=EMcQQM1Y42TnF1tIAOhLX23bfUTNNg+XwndG0VWW0qV9nRb0GcUgEquvoGM5J/chd5oREkXPBcDjIA6ywPB0AeIoGKi6R/55kkWsTvlMDeFGKJnJJH8FoBs0BnjxF22VfH7DsAr9i+jzJkRqUvbYb4ly2PXiKY0MQVv8SxWhrPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740516013; c=relaxed/simple;
	bh=FoMb4vNnywlE0FhKQCch/wprfuMI40Th2kAR34+pqsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAQpO4GvRAp9ZVsYKK+d7gOdPh0d4GXyod3y9WOmE/FcLz95Btqm2MjKj6VQP4pU+fUz8Oe4xKNdR6feG8J9tMj4BAuSj/5ro5it3YrSw4VYB5PFOS0RndS+eGak1D6S3FZK4EGtpxrErviT/AlPTwh5kJFTLtoUc3oIWIHzQXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6guUG6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78152C4CEDD;
	Tue, 25 Feb 2025 20:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740516012;
	bh=FoMb4vNnywlE0FhKQCch/wprfuMI40Th2kAR34+pqsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k6guUG6nTTRV7DS46LQdf5Y07H7nIAEhGmYEdwJ0fbHVwDxZSkQdFsn+i0Ouz1Rsn
	 /CC7m7A5pQBzULJsMI+VNuV15Ipf5SNk7x3qCrCsee0ZDHxAvnYP4meyZzwucAitd7
	 Ekpke6UeYAHkTGAoZPIlFb+urxe4n7G695yif6WDuhoBM+MZlYXolDypEVJxLSLPPF
	 6ULVTWfbfdcNNLXxXTgWL1pfWlQQeY/rhYmNOz5tkadRT45L6S6gu6xuHPNmqd2dxa
	 8BajurgwDsw1pEjlSkPEm6a+yB0TV35SABXbhgqiguJVXvaKLNaG/n5/PaAKOz8qhh
	 5D1iW+RO1fbeQ==
Date: Tue, 25 Feb 2025 21:39:59 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Roman Kisel <romank@linux.microsoft.com>, akpm@linux-foundation.org,
	bhe@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	kai.huang@intel.com, kirill.shutemov@linux.intel.com,
	mingo@redhat.com, pbonzini@redhat.com, tglx@linutronix.de,
	x86@kernel.org, linux-kernel@vger.kernel.org, apais@microsoft.com,
	benhill@microsoft.com, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH] x86/reboot: Don't corrupt memory on non-BIOS systems
Message-ID: <Z74qn-iQDPb3NrXS@gmail.com>
References: <20250109204352.1720337-1-romank@linux.microsoft.com>
 <Z74nKGVfkhmYppCo@gmail.com>
 <03D69594-6E5E-47B1-ACF7-B0222F642DE5@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03D69594-6E5E-47B1-ACF7-B0222F642DE5@zytor.com>


* H. Peter Anvin <hpa@zytor.com> wrote:

> On February 25, 2025 12:25:12 PM PST, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >* Roman Kisel <romank@linux.microsoft.com> wrote:
> >
> >> native_machine_emergency_restart() writes unconditionally
> >> to the physical address of 0x472 to pass the warm reboot
> >> flags to BIOS. The BIOS reads this on booting to bypass memory
> >> test and do the warm boot. On the non-BIOS systems, other
> >> means have to be employed, and this write is a memory corruption.
> >> 
> >> Fix that by moving the offending write into the case where
> >> the machine is rebooted via BIOS.
> >> 
> >> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> >> ---
> >>  arch/x86/kernel/reboot.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> >> index 615922838c51..6eec8653493f 100644
> >> --- a/arch/x86/kernel/reboot.c
> >> +++ b/arch/x86/kernel/reboot.c
> >> @@ -637,9 +637,8 @@ static void native_machine_emergency_restart(void)
> >>  
> >>  	tboot_shutdown(TB_SHUTDOWN_REBOOT);
> >>  
> >> -	/* Tell the BIOS if we want cold or warm reboot */
> >> +	/* Tell the firmware if we want cold or warm reboot */
> >>  	mode = reboot_mode == REBOOT_WARM ? 0x1234 : 0;
> >> -	*((unsigned short *)__va(0x472)) = mode;
> >>  
> >>  	/*
> >>  	 * If an EFI capsule has been registered with the firmware then
> >> @@ -681,6 +680,7 @@ static void native_machine_emergency_restart(void)
> >>  			break;
> >>  
> >>  		case BOOT_BIOS:
> >> +			*((unsigned short *)__va(0x472)) = mode;
> >>  			machine_real_restart(MRR_BIOS);
> >
> >If the value of 0x472 is only meaningful in the legacy 'BOOT_BIOS' 
> >case, then at minimum the whole block should be moved to that case, not 
> >just the setting.
> >
> >Thanks,
> >
> >	Ingo
> 
> Does the memory corruption actually matter, though?

I presume the issue came up by auditing & reviewing host writes to a 
barebones non-legacy VM?

I'd argue that we shouldn't be writing random values into random legacy 
addresses, especially if that special address doesnt seem to be covered 
by any modern spec? Basic defensive coding practices and such.

Thanks,

	Ingo

