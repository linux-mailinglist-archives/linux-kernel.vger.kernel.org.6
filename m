Return-Path: <linux-kernel+bounces-199491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A08C8D87AF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0831F22FC3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194AE136E09;
	Mon,  3 Jun 2024 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YtpaGEgv"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B061369BE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434648; cv=none; b=ofW3Z8/70XdoOl3m2wGpbivoeVXIMwbmpp9mAb31otnC+hRvVnJO1zU1vUS1VMJbwFQypouMmdhvlOtcWPLzBv/qyUYWMtacR2GuzEHp1CzdsDyn5mfhWm8J4klr4QGtiZN+VrZaE021lfY2mQHFK3q/pYmHKBa6aRtPJv6c5uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434648; c=relaxed/simple;
	bh=nVaFjjXn/MwhXdmFoQOD6ITDGNIfVz+e2X434EJIAeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szNo50nT2TgpAg2Ef04Ok2IqCgbcPl0ExeE2H7uxP/ehaDBffFHhtNw/kzzFHYqLh/2vBpxe7pDnm7H4pUT92zA5/avQX+5RvY1gyCcLRo1skc7FoBSFgfJ43Y7Y0kRyEGLPiTcsCize4NoJB/lapzBbG43UTzVRv2KxBpAoTew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YtpaGEgv reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7CEE240E016E;
	Mon,  3 Jun 2024 17:10:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JCzJOiEVf_pe; Mon,  3 Jun 2024 17:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717434640; bh=VZi4MOG3Bn2AbfCCHa5aneDrHuPFqyTpnVMCPDS33j0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YtpaGEgvCC5TvSU3Bq1/2vHn0QfDG78lWUt1tzTvTVNMX99QjUeyus6DhFCr/hp1j
	 DtkMxtsyU2aIUsIf7KH2azMibL1NEZLwqaqcjpASxLdReZghHOQBhsuHxMjpI99ACL
	 qW9ambyFZqg3X3gFZ8kbOaZdLSzSOp0KFMDk3x4yImpiOTdhEycZbfzJq3YPH4NrwJ
	 rrP0DiJlY8H8B4o0fb9GlIAUIMKQO5vwVZhSqD2lzto2qPblJ2GHbC7hV7WFdpYoA2
	 QIfxA0VBBa7R9YZITjUHCrrMZbtsLXKPYw4//tDCnIgImwWVsRU6vAC5OdUD2Y9Ski
	 gw/5rOOKhm9RQIgUEH215xXcp+T/SK6svY7IR2zauNVge30TBqerxNw2csqJva7eIZ
	 ex7jcawgdS/syMunzrSkkNP9AvtSAgRnp93uHsT83di+7tSrWVGGLkshsW4ma8AF4k
	 +faFscvzdD/XjyAPQ1bpAQZnSlejaV+yvdkZhqs39swlercy5tAnENdEEB6RTaFwDn
	 UzEj5qkezedhE+FRfkhIcMfii+a1uqaaipDdT9329ESLthnb8S44EpuuAfn7Miy8u/
	 nHZkhAIwGSd6hTJ1pWzTxzhwHFSpoVnDGwzvAzumDwfi+YydIFLVPUZSkxaj/Jh7kZ
	 KkIf4c45itL33ZSGObRabSh4=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 014BE40E016A;
	Mon,  3 Jun 2024 17:10:10 +0000 (UTC)
Date: Mon, 3 Jun 2024 19:10:10 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Mike Rapoport <rppt@kernel.org>, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org,
	hpa@zytor.com, peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <20240603171010.GIZl348oNg7DtyV-cv@fat_crate.local>
References: <cover.1717111180.git.ashish.kalra@amd.com>
 <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
 <Zl3hwYL2GDiyUfGo@kernel.org>
 <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com>
 <1d03466a-052c-4152-9dc4-0b72d95cde6d@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d03466a-052c-4152-9dc4-0b72d95cde6d@amd.com>
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024 at 12:05:45PM -0500, Kalra, Ashish wrote:
> Re-sending this, last response got garbled.

And this got linewrapped.

Thunderbird section in Documentation/process/email-clients.rst.

> index f0cc00032751..6f398c59278a 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -255,15 +255,39 @@ void __init efi_arch_mem_reserve(phys_addr_t addr=
, u64
> size)

^^^

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct efi_memory_map_data d=
ata =3D { 0 };
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct efi_mem_range mr;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efi_memory_desc_t md;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int num_entries;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int num_entries, ret;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *new;
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (efi_mem_desc_lookup(addr, &md=
) ||
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 md.type !=
=3D EFI_BOOT_SERVICES_DATA) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * efi_mem_reserve() is used=
 to reserve boot service memory, eg.
> bgrt,

^^^

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

