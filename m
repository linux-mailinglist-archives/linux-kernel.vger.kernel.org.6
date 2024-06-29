Return-Path: <linux-kernel+bounces-234960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2EB91CD83
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 16:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA168B219E5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 14:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D7E823B8;
	Sat, 29 Jun 2024 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aVl2HxFr"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1E6381AD
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719669602; cv=none; b=fO33Uf0qg0hUxLZKtRm9LF0w2IMCaIJeFGz+uiZvAHUgkbBjoLq8CEERkFZdIroueOMYYRhu3qh2StoRymkuwuA/q9qUrknTJehbRqK5ewpjj28FU4+RCegmnIZ9yyNxRb0TiNjHaY+MXddrWrGsflXW5t2uN1/YGpJvQhKb3pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719669602; c=relaxed/simple;
	bh=y/xyeGuUjLaPRofy+3kI4vniVRvilUhiHIvamon3P08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQ/IJ4nuSf6bngw91jVsuCxsw5qtXCpP/jRKxz1ypNYxhSnuer/FL3D7lbEjClfZd1MkTIPHDd2Z9w7UE77MLy+nW0SmMgvT6R4hs04mgKamPz1WwKzpHDESNocoxrtGa69DY8qN3lqJItRyeWzp/hLJr0Zrmc6KnZn3z6t+3ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aVl2HxFr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 26B8340E0192;
	Sat, 29 Jun 2024 13:59:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wbLqI-ep6Lig; Sat, 29 Jun 2024 13:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719669592; bh=gibAjF9WXEwdjtFDruiFkfc3HZzBGfeCkKLQh8VI33k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aVl2HxFrPm+JnC+QL4Ma1CyS1xk8+2XA5uDPsTYFqA9x2+gIGdZh4zS3NUXxM3kLI
	 M4VAQcrFho1TLviwU8615H5s51f+Y1ma9aJKZBMIK+3bmmCI94fDfMTQbT0kMzdxxO
	 IsHMymOSY5AyfvC800/DxzVG0CDId2YDCy6Tr8cUQEhiR+ou13E5rO+zGyDQRiPN8N
	 1zUECt5rSlIdvOMI9vQqX6jRs3Vo3VlkcZ/WMC2h8cb6f0WMKWwUOgohXt5X4kZEJF
	 h5ebZOXy+0ay5vVTQRvte9BhbsjmpthNBh9ySdwIthc3knobDOrnPqii0LZ6NWO6FH
	 S7/OFxeKuD0XT65TVGfCqO/5T0mZoz00u+9MFit6Mlq7fJ4zatkWIl2N0kWPPx280+
	 kPJUyMA3pxe3qWRBuAsOR9/taIh28ws9Z4ld2ccmpCy49SxOFCHBaYMQlfhqBGHjgm
	 762EwNdqMe7fk3rRUkW5Br4yeAr3KaLEHjRL/4jsP2cBCoXs0WLi2p2Fk5X4xIdwX1
	 m+TG3/xv7KzD2Uh6mbVdT5NEdDs/qu+kiWwkhYFcMGYAHuCzwUoiTUzNqrqDcqCnQD
	 HXvgSLOXhSyhuKMzTeu+Hh2sZ0ugSXgUbrAjYMTL/dgl17b2xTNOnzhqmKrCfi13wt
	 vj3H/XaRN+28y5gTysV4IJlQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6DE2A40E0177;
	Sat, 29 Jun 2024 13:59:39 +0000 (UTC)
Date: Sat, 29 Jun 2024 15:59:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dexuan Cui <decui@microsoft.com>, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: Fix crash on kexec
Message-ID: <20240629135933.GAZoATRVAubo7ZDdKB@fat_crate.local>
References: <20240629130621.1671544-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240629130621.1671544-1-kirill.shutemov@linux.intel.com>

On Sat, Jun 29, 2024 at 04:06:20PM +0300, Kirill A. Shutemov wrote:
> The function tdx_enc_status_changed() was modified to handle vmalloc()
> mappings. It now utilizes slow_virt_to_phys() to determine the physical
> address of the page by walking page tables and looking for the physical
> address in the page table entry.
> 
> However, this adjustment conflicted with the enabling of kexec. The
> function tdx_kexec_finish() clears the page table entry before calling
> tdx_enc_status_changed(), causing a BUG_ON() error in
> slow_virt_to_phys().
> 
> To address this issue, tdx_enc_status_change() should use __pa() to
> obtain physical addresses whenever possible. The virt_addr_valid() check
> will handle such cases, while any other scenarios, including vmalloc()
> mappings, will resort to slow_virt_to_phys().
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: e1b8ac3aae58 ("x86/tdx: Support vmalloc() for tdx_enc_status_changed()")

I'm going to zap this one from x86/urgent and give you guys ample time to test
thus stuff better and longer.

Also, what is this e1b8ac3aae58 fixing and why is it urgent?

AFAICT, it can go through the normal merge window...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

