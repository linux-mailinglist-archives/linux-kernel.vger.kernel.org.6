Return-Path: <linux-kernel+bounces-409417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A67EB9C8C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6621C28126E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F19322331;
	Thu, 14 Nov 2024 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="h13JjBZ2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC86B1C32
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731592935; cv=none; b=fCHdtXGKW3fjUPIuXyBJdqzePrpqPuB8mL7CZTXTDapqpbGhB9QcOPTB1PxflTMEBkmLzrUGZ13z2+CqJ0qKDUn5AGblj+oeBq18feFr5gf2r5f8uojRW3RGlEnDTDZjDyplW1dzDwOfDKViD/xuwTs4Pre291TN+Knsj9jEvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731592935; c=relaxed/simple;
	bh=2B0kHull0C9HMPTRmwhc2kwVmgjQEVwia+Uz3FzQT+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVpk9ofxgWtr49huotT9CuDI3lyY0aTxPjy2Zhmt61QN3gidT0x8T242ud+G2iQDkQZ/Um3d5OQ3M0sqOHYjOx1KX0ThmqB1GjoFTePHVsAHSMY9xYTYBiSjYCeiwaj4OV7mcfzAHz8guCZu/2yHbMwwTn11MQQO10xU6gMV3M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=h13JjBZ2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BDC5E40E0276;
	Thu, 14 Nov 2024 14:02:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zeNkSjtj-slj; Thu, 14 Nov 2024 14:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731592922; bh=koBo2U6ekC1sDkg14ZMmQqR4z47QLaw1cK9qVWgnVSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h13JjBZ2O6rR0HlyOHF0wlMNv9vZA7/YMb4biWM5lqmGyd96/SxA4m6iVvWjJkw0a
	 MDJCjMiezIyylkwMEdMzgAYU0hoz0g3n/CgN7AtbdB6bHl0wK9Jxxx4/Gxhc8ADFhL
	 xVZjNn21vPsuiERdAuAnYsJ8GsOci1+JRTwXM5klGGjnxlgHr8TGfYRJjhxuC5Lqns
	 +3uzeJzrV1qkZh+i15s1b4UoEKXbgL3dii+kIx/lkDXNmqNlHOid313Hj2uzDG92a7
	 CqUNE97tkyMEpn0x2/rl5IOMedSJi8bzMSOIXjK6dpQOKGO0xFAumxGRbz+b2Qn2Qc
	 RckpoZ7b+ckmCkUjntz+WoVOnFiRHFG0d5Uv+BpHis9Ofa9j+rhKwTNUwVHPsrXAS5
	 GrcjCL6iqYbXKA+nmSaWk26tRGD6MmJbrFqrpzqbH43hu0O16I5IxIRz5T18ePFuDq
	 YMnuPatucIYXBHFBITkWSbbDeT6aCmnhqO+Y75kJWTU6f9TvZT1jfIC4CYL7NcQMK1
	 10XkmBCq/L6fXaZyDzEk5FAQc15UZ7RXQVW9XZH3x9+WzgvOeWAyaZRdAES5Ffi4GI
	 4F30owEdTwFJ1OV86rTaYKWDx0FPbR73iRBJR3Dyaklk4BSQNRXl2xcwZ1gh4mBPTr
	 Lz4pP+EWA9qU+l73f1AtPDrg=
Received: from zn.tnic (p200300ea973a314f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:973a:314f:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 51E3B40E0163;
	Thu, 14 Nov 2024 14:01:59 +0000 (UTC)
Date: Thu, 14 Nov 2024 15:01:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/microcode/AMD: Make __verify_patch_size() return
 bool
Message-ID: <20241114140154.GFZzYC0ifEztvQ49-P@fat_crate.local>
References: <20241018155151.702350-1-nik.borisov@suse.com>
 <20241018155151.702350-3-nik.borisov@suse.com>
 <20241114125818.GFZzXz6vdhwPdSa4dk@fat_crate.local>
 <d5708abe-40ed-4885-919c-b491f61cceb7@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5708abe-40ed-4885-919c-b491f61cceb7@suse.com>

On Thu, Nov 14, 2024 at 03:19:33PM +0200, Nikolay Borisov wrote:
> For the older families we have a hard upper bound so we want to ensure that
> the size in the header is strictly <= than buf_size, which in turn must be
> <= max_size .
> 
> 
> i.e Is it not valid to have sh_psize < buf_size rather than strictly equal ?

Let's look at all possible cases:

* sh_psize > min_t(sh_psize, buf_size) == buf_size -- means the buffer is
truncated so the patch is incomplete 

* sh_psize < min_t(sh_psize, buf_size) == buf_size -- this is actually ok
because we're working with the whole buffer and there can be other patches
following. Now I remember why I had ">" there.

* sh_psize > min_t(u32, buf_size, max_size) == buf_size -- truncated buffer

* sh_psize < min_t(u32, buf_size, max_size) == buf_size -- that's ok

* sh_psize > min_t(u32, buf_size, max_size) == max_size -- some mismatch, fail

* sh_psize < min_t(u32, buf_size, max_size) == max_size -- ditto.

So this needs more staring and I need to make it more readable.

Btw, one more spot:

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 01ea25f31c0c..7554d83f00e6 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -303,7 +303,7 @@ static bool __verify_patch_size(u32 sh_psize, size_t buf_size)
 		break;
 	default:
 		WARN(1, "%s: WTF family: 0x%x\n", __func__, family);
-		return 0;
+		return false;
 	}
 
 	return sh_psize == min_t(u32, buf_size, max_size);

---

IOW, I'm thinking about something like this (pasting the whole function here):

static bool __verify_patch_size(u32 sh_psize, size_t buf_size)
{
        u8 family = x86_family(bsp_cpuid_1_eax);
        u32 max_size;

        if (family >= 0x15)
                goto ret;

#define F1XH_MPB_MAX_SIZE 2048
#define F14H_MPB_MAX_SIZE 1824

        switch (family) {
        case 0x10 ... 0x12:
                max_size = F1XH_MPB_MAX_SIZE;
                break;
        case 0x14:
                max_size = F14H_MPB_MAX_SIZE;
                break;
        default:
                WARN(1, "%s: WTF family: 0x%x\n", __func__, family);
                return false;
        }       

        if (sh_psize != max_size)
                return false;
                
ret:    
        /* Working with the whole buffer so < is ok. */
        return sh_psize <= buf_size;
}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

