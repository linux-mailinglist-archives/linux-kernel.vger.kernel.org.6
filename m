Return-Path: <linux-kernel+bounces-199314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 052C78D8568
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B480A1F22CC6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AF582D8E;
	Mon,  3 Jun 2024 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YXkrxRbI"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9407B4A1B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717426048; cv=none; b=lgVr58a3526BySrpCOw0Rhqkmu87QMjpqcihfrcYPjm80vfzKtUgASvSpu6TqNqfdXvzGS8Etq/eZS3fT7a+entcgnkUwvrwW+rIqgDUkIOq6g4yUbMRkEQOUNFZ1zAR+9HI7lJbb6Ehb4EFCChcU5VefvoLdivV83y6GYGVvZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717426048; c=relaxed/simple;
	bh=KcbTxoi3UxmCagZVrCg+Krdeg6dZu3XolFm0vxuydMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4ofmDAKD2E5fIIT4ZFPpBq5ItZBJOg6Lc67msEbwGL60dZJ55iCm6fYH6bt5yN50ZVNaEPdrQqApfOe1esCTmYSkIKvBpKon/rn0qLmtmkPLdv76x/HD2gvoWWCoGtzhxqN6i3c+WVog9Vitzk/0t8t8fyJgCOBxDkRTz79EOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YXkrxRbI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6FCF640E016A;
	Mon,  3 Jun 2024 14:47:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Gb4dWofyMxa2; Mon,  3 Jun 2024 14:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717426033; bh=VL1yo98odqtq37ExaplA9J6PHtb1WIm7FJJQvcfweUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YXkrxRbI8PYf3jv4X7adpYPudQ/d8WcrvXAumyvQemvH/CIarQh3pyBNp7obyQlWb
	 WTEghwqKBy5z5z3E2j27MtB5rtJlHwsG3xU8PecD7Cwl+icI1oWO5Vfx6Cxp7/jdYO
	 rfW7KAuFP4PUkV7PuQxAPvE3s1CeJOYj4koJxxodLUFff17wfJ06BmGPz3e2ytnb8B
	 diH+J8bTELC6vW3P4qzGovZ9jYmnAS5E7gNAj6BdtYmwXWYOKzTeWABRJwMXwP8GG7
	 gpOJ8kucnAw99h87rJoVeP3YYIEF46mvGLNDLSfKvUoZHNwFrrh2LeJVQ7OX988xsd
	 RZ+cfjd3YQ636+6HdTbK+VJmqLwAVsHdJUFOvO8RIvQxH5TzeekLA8WzvlbI3tsqZb
	 2MAUo9S/lzjXCcmTy2O216qCeEfChlBb+xoQQvvW1yCg+NpMachzHY6ust5bGfQN3b
	 G79FA5T7Fi5Wc5GAstBPho+0xKJ5IkCPIEQv4AOWGadca1eHW9IBDVtBdsOamx4AMK
	 gTSAIdoz6wV41HWV7dXFY3zyVZLKS6fo2Pyx1KeRCUfpArw/GCpDs89Y1n9KDQaMks
	 6jdzgQmgg/H9iyABpJKAAQ5kk6qHy4F/GAgw1azq6m8CMcFkS9yYb/n44l2RVAGXi7
	 cPwi1PUA6AqljN7U6bB3bZ+I=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D763A40E0081;
	Mon,  3 Jun 2024 14:46:44 +0000 (UTC)
Date: Mon, 3 Jun 2024 16:46:39 +0200
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
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com>
 <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>

On Mon, Jun 03, 2024 at 09:01:49AM -0500, Kalra, Ashish wrote:
> If we skip efi_arch_mem_reserve() (which should probably be anyway skipped
> for kexec case), then for kexec boot, EFI memmap is memremapped in the same
> virtual address as the first kernel and not the allocated memblock address.

Are you saying that we should simply do

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index fdf07dd6f459..410cb0743289 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -577,6 +577,9 @@ void __init efi_mem_reserve(phys_addr_t addr, u64 size)
 	if (WARN_ON_ONCE(efi_enabled(EFI_PARAVIRT)))
 		return;
 
+	if (kexec_in_progress)
+		return;
+
 	if (!memblock_is_region_reserved(addr, size))
 		memblock_reserve(addr, size);
 
and skip that whole call?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

