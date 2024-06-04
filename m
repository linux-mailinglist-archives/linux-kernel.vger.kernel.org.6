Return-Path: <linux-kernel+bounces-200379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF64C8FAF28
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09B81C20AEF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB8F1448C1;
	Tue,  4 Jun 2024 09:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XCoQSeVm"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1105812AAD6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494276; cv=none; b=YwGsaPV5q6dZFK0T3QAku6fZ7FI03y4N8wMuEwZC9U8mpJ6NAbVXT4m1juwjL+srktDIHsRYgz0WMILrFkR1V645EMoCl3suwspURDQktvJTe2tAMkamarWWdl142wWEfSvnb6wM5pTf/rbioRqRMtV+VcsBCta+5Xf9lpR+7wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494276; c=relaxed/simple;
	bh=pxFRbPGW24LmVBzQ4JhYZaaafh+WJ6V0jn0Ze+5zrWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJ1FLJjv/snI8+4qT1gUCeuDro9Ei0mJGUyTM/J0c0Q6ccorOMxU8dCjZ8MT78CkNy3TnkgXrgU/eQFC4JfJDaCl6RVmR+iaICCkIqA3Ow8xQrjoYGkTYCMhTB6b29Bdz6S4pBmJMFkl5PrgdIowo/NufWPn6BBc8/NItupRisw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XCoQSeVm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8F31340E0176;
	Tue,  4 Jun 2024 09:44:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ddGCUwBu8TqP; Tue,  4 Jun 2024 09:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717494268; bh=pIg8xe1Ns+NA9fRhRn6k+zXFxaT3zBumGkXlIKY3LLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XCoQSeVmBvXsN7Oj0IZ5XqLQmBMN11lhRhATE9jviznkzRP14Kd1hs2txtmf/4AyA
	 NCoDRxW0dgZwzakME8kA22PFD11iKTHm1yH4qH9E3hDGtrHRhJqlM1PmcaZcprC4KW
	 e5OTw9UJKJkmDY5F0H+PE/CzHSDNp8m8RYHSi9LPyrjTjD6IgtSp5tMQyobcusGgqc
	 qUyqYePgUtnHjDvNJagEur+WkeCVwX/b89H0Xpd9KZRx8lijyEtJQkgyQ0IYgktEYS
	 j3+lHQWXPR/gTsk3RJoXDsBnvtvvvaIMhrIIJtcQXc8gf6DrKtxY/Pr4TDeeq2QHLI
	 1DRED/m7UZUl8Nn4fPVzUOSNXBJsEhYlgp283ONUaF/DqdgwWwltjQ3YruAc0VBT3J
	 wcYgBbCmGHIMtzuBjgc/HdstEAS2je3fzhpv7TOym7iCDK93/OhdH7HrjBJrJ8EOb/
	 GxuRi2I37L2ARt3sD6T3k6rTayOZbw2oiWO04QcFaM+qKTPdwnMu8RtwTbVgxviMld
	 9HqDFPCq1OgIdfv5c/BRJkmvRH4j/lHQK1XOX4Nnz5lO78PcNDr39UtwyCAvlukc0P
	 0bbLlpzaBsgyS3EiwLUvyyEoX1TripsM1hYTynMQyw2RbG5oFFT2tj90oSN5x8K70V
	 MCD8Cow+w/9EbV9SbZ8oFHkU=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7573640E016A;
	Tue,  4 Jun 2024 09:43:59 +0000 (UTC)
Date: Tue, 4 Jun 2024 11:43:58 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dave Young <dyoung@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>, "Kalra, Ashish" <ashish.kalra@amd.com>,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, rafael@kernel.org, hpa@zytor.com,
	peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <20240604094358.GBZl7h3otTCYJ5rkkt@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com>
 <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
 <Zl3hwYL2GDiyUfGo@kernel.org>
 <CALu+AoSnA4323QbQG7wrNptosz7tfEfztsE1=o6G=FaLbQ_tKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALu+AoSnA4323QbQG7wrNptosz7tfEfztsE1=o6G=FaLbQ_tKQ@mail.gmail.com>

On Tue, Jun 04, 2024 at 09:23:58AM +0800, Dave Young wrote:
> kexec_in_progress is only for checking if this is in a reboot (kexec) code path.
> But eif_mem_reserve is only called during the boot time so checking
> kexec_in_progress is meaningless here.
> current_kernel_is_booted_via_kexec != is_rebooting_with_kexec

That's exactly what I wanna check: whether this is a kexec-ed kernel. Or
is there a better helper for that?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

