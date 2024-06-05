Return-Path: <linux-kernel+bounces-202248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3BC8FCA05
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB21281E25
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3431192B61;
	Wed,  5 Jun 2024 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="asNtDGm0"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A050319148B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586166; cv=none; b=lcAo+HXzLYorUIZOW5RyZvDfdjpck4gjNVDIGxQzwPnwYF1EGv0+2LrQCaXP+0x550AlszC7ZGR+qEcqEvvJLTQy2WGWAHJCtI5KB33XEXEqySltq7QG8eZSs08hEhJ3We2gO4S2/MixesxXi+kXjSQVQA17GW6uXQjgQELRDgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586166; c=relaxed/simple;
	bh=OB4bbDHOpovQgbK+NjxUZFEWt16fgvGMy+LZiN5kFCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxkLYdNolBfNivhXELwm4fM7w65NAS5Y9UcOhfMZVc6xEfcbrcw1SzmuA2/xEtedxDSC612vtyqV6m07aWivQpIlToPEyQ//M2W2pIGcSLM0LiOR9RYAp2qPl5bksH951mgnDCWyQy/s1PzfNzcd6xLN1Xxpuxp6H4N3YEPbvLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=asNtDGm0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5CC1E40E0191;
	Wed,  5 Jun 2024 11:16:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2MM_uH0b_vZ5; Wed,  5 Jun 2024 11:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717586158; bh=MyNP/8A3mneC0TU0vkHmFz9QbD6ZPJz2lnq7g0nJwME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=asNtDGm0aWrqbbyqfz8gB/pIkAwBrS0jW1fszHDBAAE73YTZ1RXmITordyLpNuAhX
	 tUz7P7b7vWLs+JLMUA35+eo4pHvEJXdcODIEuYvYcNEAP7586+vjckHFwuDboH1ljM
	 OE5XYQzs1qvsg5G4qWvi5TqHshLp5wFVV/fBxmdsChG0uOrJSWAxt17BAD+0TRbTWy
	 ye+MDYoA+c3o8gUTX9RQqa19pNy62l6UKhx+TT1AWuKyorUWYwmnhHQ5sCDFTyxMpV
	 UQwfYaQTey+ui3KYvP+gHOXsKX/n2Nc62GvrjxlA2Y+DEqRE9zk+iPtEZTBnI6SSIt
	 ZGQFLFMOp6qDBWAadS70VF9O8UUJIlmRQ1lFlZybAyEYnhkd5CBWvrtSI3nAHZ/gzm
	 4Sr/r0cb7UGb/VMo/3bBRtYjavnG1zO6gfSR02K9obmsBgFXoUSziNzeTJJNRER5aX
	 Py1DQa6A1lYwmXiw6mFSSky198TDK0p7NWndsTKW9JDo9+RkmCerytU3W94k7rDZQg
	 IxoiUgrhUHgJDTBSiMzkXxnNyGUSU0v723hRw990dEOJUGPu4JYGi8mta1rgJ6FzXn
	 4FkfWdMKfAdj5xWNC3fq9Nyno77B4x1ZMMiPutVhTMC5YVy+u5Pk78y9vfPKQ+jSUK
	 xiThwe6cbzf+amDt7WH8S3Ys=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2559440E016E;
	Wed,  5 Jun 2024 11:15:29 +0000 (UTC)
Date: Wed, 5 Jun 2024 13:15:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Dave Young <dyoung@redhat.com>, Mike Rapoport <rppt@kernel.org>,
	"Kalra, Ashish" <ashish.kalra@amd.com>, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	rafael@kernel.org, hpa@zytor.com, peterz@infradead.org,
	adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	jun.nakajima@intel.com, rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com, michael.roth@amd.com, seanjc@google.com,
	kai.huang@intel.com, bhe@redhat.com,
	kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <20240605111527.GEZmBIzwpsrai31qWT@fat_crate.local>
References: <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
 <Zl3hwYL2GDiyUfGo@kernel.org>
 <CALu+AoSnA4323QbQG7wrNptosz7tfEfztsE1=o6G=FaLbQ_tKQ@mail.gmail.com>
 <20240604094358.GBZl7h3otTCYJ5rkkt@fat_crate.local>
 <CALu+AoS=-=PbMRxC-1rpfSTPpMOmM5BGRBjLhDwgOC3=4C71ng@mail.gmail.com>
 <20240604180212.GHZl9WpAfNVERTjMqw@fat_crate.local>
 <CALu+AoRqNmsWXi+HXYNYTY=pXJ3sLTLKyXNeJz9EoxEsHzFdQA@mail.gmail.com>
 <20240605074257.GAZmAXAbkc5TGVds5u@fat_crate.local>
 <CAMj1kXFweoskB_qnUFA1b+QXWhjovwMfpM00cGb9KMcm4Zr7EA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFweoskB_qnUFA1b+QXWhjovwMfpM00cGb9KMcm4Zr7EA@mail.gmail.com>

On Wed, Jun 05, 2024 at 10:17:22AM +0200, Ard Biesheuvel wrote:
> I'd argue for the opposite: ideally, the difference between the first
> boot and not-the-first-boot should be abstracted away by the
> 'bootloader' side of kexec as much as possible, so that the tricky
> early startup code doesn't have to be riddled with different code
> paths depending on !kexec vs kexec.

Well, off and on we end up needing to be able to ask whether the current
kernel is kexec-ed. So you need to be able to access that aspect in
kernel code - not in the bootloader. Perhaps read it from the
bootloader, sure.

But see my other mail from just now - it might end up not needing it
after all and I'd prefer if we never ever have to ask that question but
just from staring at EFI code it reminded me that we do need to ask that
question already:

        if (efi_setup)
                kexec_enter_virtual_mode();
        else
                __efi_enter_virtual_mode();

*exactly* because of EFI and that virtual_map call nonsense of allowing
it only once.

And we check efi_setup here because that works. But you can't use that
globally. And so on...

> TDX is a good case in point here: rather than add more conditionals,
> I'd urge to remove them so the TDX startup code doesn't have to care
> about the difference at all. If there is anything special that needs
> to be done, it belongs in the kexec implementation of the previous
> kernel.

Sure, but reality is not as easy sometimes.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

