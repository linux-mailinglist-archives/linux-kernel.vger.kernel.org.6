Return-Path: <linux-kernel+bounces-199471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4968D8787
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1CF1C21C91
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA25137755;
	Mon,  3 Jun 2024 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TE1Juqy6"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE773136E00
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717433905; cv=none; b=s/ro9YmQeogL6LlSG8D1p5IopE7idnDrlNqKjJ4ZI8WczLbbQBj3A+2pjwCkTyUTgDePkPr+Y9xq/hZKWAqe9cO6VlAL9gCrNyiU+TiFnD1EydThGo32Hg6VRK28ndNuvDckNlaf8IjLy8ickt8asOSJlmMtsFOYInkZWrC+dWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717433905; c=relaxed/simple;
	bh=nAPoQ7pw7Q5+locS/uIjlUCHlvPFcUGQNCw7PSBrjh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJHq6zdoqMcZYCVuZMwG3eEDO8BefO7eA5PSryFmKfsgAixIYa9GtzxnbOZTOk7tcNiCyHJ81oYHTPZJy32ph32rvV3dTMpavS3GcGEWPsmQGO5ya+Ao/fFoepkA4ePuqgA8qJ7Z+o2bbOrcAgL9JT+jzlxngEp8dpKMIKqBqTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TE1Juqy6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9475D40E016E;
	Mon,  3 Jun 2024 16:58:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7mEEOYRQqEWz; Mon,  3 Jun 2024 16:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717433897; bh=5Ye8WQXQcDM0Pbn/WLfdstI1LprqRnXUsBOMSmIce1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TE1Juqy6WPbqwr6uB9fEtuD3rF3JlqT7316Kf427rRDAvagZPD12LRCbcRhJtiCEG
	 A+IbVVBf/HxDtMrzsg/i43YFHSIBUQ0jKZw2Slc52HIdCWpy8WQtm9cqKrCvqjo9hL
	 0i0RNRAoojit05frOOu2qH7rMOoIn1KmWU+5w5tSie6d89Mbj/+uPDIFwZTY3VU+b1
	 Jf04JSqAqYa/wRKrfJxjQnVWQGQZjCIQhc3dXMKXesQeqs0zmrh5MQ1iutL6uCs6Vy
	 4s6NQoearde7AF9/5hOpDlGiZ4rN+G2L/W8PqbSqokd3ldcswvipHcksTZJtn6nrFi
	 VgZ42KmNxeLpdQN3zKZ4UaXm/G0JirSW9fGp56NtAdl6gSnVufixs8seDODtpA40RK
	 6Zhh7E+2cRvFfWa/ZShtfnkAoFnU4LC22n2N1fygbD8e0lk8U6KiZ5yIBJU+ZXpYM9
	 CavqhJurk9OFIP+JaOl88Y4uJXUKi56SaMzdLhk741XRX3uH0KzyFIsFFiFedzqCAD
	 RKWQnhlaPlezhC1erdtYPJjKBQ27Gs4QDcMUul0/Ddl/4SlzV1bDCV89Y0cXENwCpU
	 QFLvzqUfjt4tRoGzqaA+3p4chOhbEU4CVGExemMMBE4KH97LH66t4/dJLPAtOexNCT
	 QmBw/4QTQvWHDolYRXt4dgiQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 22DF840E00C9;
	Mon,  3 Jun 2024 16:57:48 +0000 (UTC)
Date: Mon, 3 Jun 2024 18:57:47 +0200
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
Message-ID: <20240603165747.GGZl32C9yrmXJ4nhPT@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com>
 <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
 <Zl3hwYL2GDiyUfGo@kernel.org>
 <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com>

On Mon, Jun 03, 2024 at 11:48:03AM -0500, Kalra, Ashish wrote:
> Yes, something similar as above, as efi_mem_reserve() is used to reserve
> boot service memory and is not necessary for kexec boot.
> 
> So, Dave Young (dyoung@redhat.com) had suggested that we skip
> efi_arch_mem_reserve() for kexec by checking the set EFI_MEMORY_RUNTIME
> attribute as below:a

efi_arch_mem_reserve() or efi_mem_reserve() altogether?

Btw, that below got really gibberished by your mail client. Snipped.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

