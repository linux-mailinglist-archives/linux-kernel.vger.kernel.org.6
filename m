Return-Path: <linux-kernel+bounces-300199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F3695E042
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 00:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2021F21E00
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 22:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B4F13C8F9;
	Sat, 24 Aug 2024 22:29:44 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E2A3A1DB
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724538583; cv=none; b=iUsLJaeiOuDi48HQZUUcC1lIxHAb5in92zBKoHk5+cqN2Fu44JheHC227B55fO/ZLtKsMu0r6QcjJi4fcGXDLg3kFte5NnopEN30lNFIzygZKH4rBqz9xB40qS9KvnLuRykTI0hPkMl2X+6W4tuwtNQgbaPjP8ZSUIBCAHCkDUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724538583; c=relaxed/simple;
	bh=UFawvgD5tHlyYjMs2KnLzTX+2yyvX/+zeRFrKRfa+JQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qsLlHw7Ou4kjbe1J+KOO6mva/2jZ20LJrmHz3mHuFWI0TXNXEVYCJXo7bkQYrr7JkHlOaHVN1D+TU0uYeXYmALeibGjBFq3qHb3ZeBOW5zkNQ7EChT1llDxFeQe/0+oJnia2scdSv+UKXMh5i3ncmMm7DFKEQicDXkpHMxrChoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id F0C1A92009C; Sun, 25 Aug 2024 00:29:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id E27B392009B;
	Sat, 24 Aug 2024 23:29:39 +0100 (BST)
Date: Sat, 24 Aug 2024 23:29:39 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
    Kevin Loughlin <kevinloughlin@google.com>, linux-kernel@vger.kernel.org, 
    Rick Edgecombe <rick.p.edgecombe@intel.com>, 
    Isaku Yamahata <isaku.yamahata@intel.com>
Subject: Re: [PATCH] x86/tdx: Fix crash on kexec with CONFIG_EISA
In-Reply-To: <20240822095122.736522-1-kirill.shutemov@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2408240952080.30766@angie.orcam.me.uk>
References: <20240822095122.736522-1-kirill.shutemov@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 22 Aug 2024, Kirill A. Shutemov wrote:

> This issue causes real problems:
> 
> 1. If the kernel is compiled with EISA support, it will attempt to probe
>    EISA by reading 4 bytes from the 0x0FFFD9 address (see eisa_bus_probe()).
>    The kernel treats this read as MMIO and accesses this memory via
>    shared mapping as we do for MMIO.
> 
>    KVM converts memory to shared upon such access.
> 
> 2. The same memory range (0xF0000-0x100000) is scanned to look for the MP
>    table (see mpparse_find_mptable()). However, this is not MMIO and it
>    is accessed via private mapping.
> 
>    This will cause a crash if the memory is not private.
> 
> During normal boot, the kernel scans for SMP information before probing
> for EISA, and it boots fine. However, the memory becomes shared and causes
> issues on kexec when the second kernel attempts to scan for SMP information.

 ISTM that `eisa_bus_probe' has to be updated to `memremap' analogously to 
`mpparse_find_mptable', complementing changes such as commit f7750a795687 
("x86, mpparse, x86/acpi, x86/PCI, x86/dmi, SFI: Use memremap() for RAM 
mappings") or commit 5997efb96756 ("x86/boot: Use memremap() to map the 
MPF and MPC data").  Both just access BIOS memory.

 Can you please try and verify if my proposed change at: 
<https://lore.kernel.org/r/alpine.DEB.2.21.2408242025210.30766@angie.orcam.me.uk> 
has fixed the problem for you?

  Maciej

