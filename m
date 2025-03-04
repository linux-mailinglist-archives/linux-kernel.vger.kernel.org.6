Return-Path: <linux-kernel+bounces-542964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E94BA4CFF4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9B518962A1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3BF6AAD;
	Tue,  4 Mar 2025 00:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kpzoPATY"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0EB262BE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 00:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048369; cv=none; b=QNuSSY/FmXNtzZrakI9xyVj7sGWOGZWRsT4QMzU3DSCjZoX67lxR8MSTya2QlRF5yr/hzgBqBQGzx/mkap7ceALy2ygxqOfnzbu902Qy+rLnlTe2lU2OJ37QFFtsaogtExFXOkUkFpBDbIfgv7tnhTtt3Tj7EjEY7Vo/NFpRMF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048369; c=relaxed/simple;
	bh=bFQHniKIvSuR78w711suUM8eKtNcV3Kas3fecaB9ie0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLOHMdSAbExvmwbsb1l1mBkNNyVfK1t/uVEomzwVlv9fmgYTa7YCkTJ9d92ooa+JC073l76Horug6yI/0eZmhXK2AkE3qjQwIHaMHNPAbdpo7YxHDTnK2cdzVsM9+oY0vdHMVXnFGLClPWZYt1DVuNA5AF2cgMhApqzdItbu/RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kpzoPATY; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-474eca99f9bso22048331cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 16:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741048367; x=1741653167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pw+9bjqD0Zwi6XTLWN9K32oaqVMQWYgDhTNGSzicq5Y=;
        b=kpzoPATYMbZMbPf0Vpx6VaacPuNow19UKVT3D+io/hffzg82D+2BeoihlnnvJ7tWRI
         rRpgg0YsX51CzWadboxgcN0QHb+LPea0YziNdQDcM+BM8PGtx1mqZ7bfU94Y/FFg54gN
         qbK/8OUYUmBD7vdXqmwhLkLr+MIKMHjKmOYL5Ic1Io8NITO5f7Xw0z5XoB2nd/+lUA2G
         mngb0Mu4PhVm/pVXnAQaPAAGyup+gPR2rlv/zysqBY+9vq7COrsD6nTS34wMBwd2DV0j
         zu3HCBhnYRZiKy+d++28RQIm31ueyV5kHYW223/A3JW0+Ku0SfknX0hGL5ErY1FPDI2d
         Z7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048367; x=1741653167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pw+9bjqD0Zwi6XTLWN9K32oaqVMQWYgDhTNGSzicq5Y=;
        b=fwX29osHjCS9Jqhex7gHfe/dPPLg+D2L9YSdNhQ4CVWJfVTUgHB8IFXF0RYmWfj+sq
         +7VG+CKpx/REIizEZpv8VIjyOqSVEvzo+t/XMdBbla/bqW5jWPhy93kUXvctHE4Bc6e8
         qKiy9+BsZ5/XaH6SfOnWRBQQj0oJiKPta9xRevK518WvvDor4+SBGj3lKi6Jjjr6LzmV
         T7Whl0cVSZJMmxb54uZ4+zfuKnhKQpWKnnVKCAToF2BFCmmEpIf8XCmvdQkbhEvR3zlp
         HKfxlE43gt+GzmWG/JxkeUoYJX1IO44ZYfhVYX4phtk83YZoR9rX8h6yEXhn/Ahxxg7K
         iVNw==
X-Forwarded-Encrypted: i=1; AJvYcCVx3YpKZkvnwj3bsSYr61BYGtAL2f2UihUp9KqBztKD1RdUVQKpxVuvOGoS9AFbEXKydizT3kNJc8EYDZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3i6c2rXhIy1yGI3OCTF7oEqYJnoc+ocpBR7AEw5vhHtNk97bH
	L0PcBErTSHzxHrGTTPE+ewHf/G7qnLcUXc3MN7+6BtRHiNS1Vx4TabrshMxldvA=
X-Gm-Gg: ASbGncuM32A3px+uES8atzkKwCnmCw+cr5/S1fo9zsvXNjGsctx3RjShsygSkxqEEj4
	p9Nc+JpEh6eQDbHy7KAKwUmjtkDqAn/HTq4A3R7wPRiOJpreTwGofOMwZTd5tlbuWH8xT2cxjUF
	7K7FzIj6RITm8VeQHlfvgcGS43coBoWQcfF8i11kezHkAeaj9nSXYnTbhcQzJBMCj3OxBzb8stT
	gu0zrjqr3M53M+7UCO+y+GG2qKwK6NotMeBwjgyDpgewR/ZmsLVImoq7f99Qp+ysx1BcE4PSsqw
	tqzpZc2elNZSzIEBZutgbLkezUOiQbi6zesJoKCzdJ8p66bd7+32JKcRNV4C0SoSAHP6F1wIIFg
	7veP1cLQL2aQ073rVGyuEsy9aRPI=
X-Google-Smtp-Source: AGHT+IEVAevyW2OR0o4+vVHk933xbD+rCHnDoRi5qyqfNQX2/sa4Qf+bjeIiSl09eve86dbBFG8pFA==
X-Received: by 2002:a05:622a:5c6:b0:472:1275:6967 with SMTP id d75a77b69052e-474bc08782dmr261346811cf.21.1741048366820;
        Mon, 03 Mar 2025 16:32:46 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4747242fe2dsm64847301cf.75.2025.03.03.16.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:32:45 -0800 (PST)
Date: Mon, 3 Mar 2025 19:32:43 -0500
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 1: BIOS, EFI, and Early Boot
Message-ID: <Z8ZKKwDnuAjtyohz@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6LKJZkcdjuit2Ck@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6LKJZkcdjuit2Ck@gourry-fedora-PF4VCD3F>

On Tue, Feb 04, 2025 at 09:17:09PM -0500, Gregory Price wrote:
> ------------------------------------------------------------------
> Step 2: BIOS / EFI generates the CEDT (CXL Early Detection Table).
> ------------------------------------------------------------------
> 
> This table is responsible for reporting each "CXL Host Bridge" and
> "CXL Fixed Memory Window" present at boot - which enables early boot
> software to manage those devices and the memory capacity presented
> by those devices.
> 
> Example CEDT Entries (truncated) 
>          Subtable Type : 00 [CXL Host Bridge Structure]
>               Reserved : 00
>                 Length : 0020
> Associated host bridge : 00000005
> 
>          Subtable Type : 01 [CXL Fixed Memory Window Structure]
>               Reserved : 00
>                 Length : 002C
>               Reserved : 00000000
>    Window base address : 000000C050000000
>            Window size : 0000003CA0000000
> 
> If this memory is NOT marked "Special Purpose" by BIOS (next section),
> you should find a matching entry EFI Memory Map and /proc/iomem
> 
> BIOS-e820:   [mem 0x000000c050000000-0x000000fcefffffff] usable
> /proc/iomem: c050000000-fcefffffff : System RAM
> 
> 
> Observation: This memory is treated as 100% normal System RAM
> 
>    1) This memory may be placed in any zone (ZONE_NORMAL, typically)
>    2) The kernel may use this memory for arbitrary allocations
>    4) The driver still enumerates CXL devices and memory regions, but
>    3) The CXL driver CANNOT manage this memory (as of today)
>       (Caveat: *some* RAS features may still work, possibly)
> 
> This creates an nuanced management state.
> 
> The memory is online by default and completely usable, AND the driver
> appears to be managing the devices - BUT the memory resources and the
> management structure are fundamentally separate.
>    1) CXL Driver manages CXL features
>    2) Non-CXL SystemRAM mechanisms surface the memory to allocators.
> 

Adding some additional context here

-------------------------------------
Nuance X: NUMA Nodes and ACPI Tables.
-------------------------------------

ACPI Table parsing is partially architecture/platform dependent, but
there is common code that affects boot-time creation of NUMA nodes.

NUMA-nodes are not a dynamic resource.  They are (presently, Feb 2025)
statically configured during kernel init, and the number of possible
NUMA nodes (N_POSSIBLE) may not change during runtime.

CEDT/CFMW and SRAT/Memory Affinity entries describe memory regions
associated with CXL devices.  These tables are used to allocate NUMA
node IDs during _init.

The "System Resource Affinity Table" has "Memory Affinity" entries
which associate memory regions with a "Proximity Domain"

        Subtable Type : 01 [Memory Affinity]
               Length : 28
     Proximity Domain : 00000001
            Reserved1 : 0000
         Base Address : 000000C050000000
       Address Length : 0000003CA0000000

The "Proximity Domain" utilized by the kernel ACPI driver to match this
region with a NUMA node (in most cases, the proximity domains here will
directly translate to a NUMA node ID - but not always).

CEDT/CFMWS do not have a proximity domain - so the kernel will assign it
a NUMA node association IFF no SRAT Memory Affinity entry is present.

SRAT entries are optional, CFMWS are required for each host bridge.

If SRAT entries are present, one NUMA node is created for each detected
proximity domain in the SRAT. Additional NUMA nodes are created for each
CFMWS without a matching SRAT entry.

CFMWS describes host-bridge information, and so if SRAT is missing - all
devices behind the host bridge will become naturally associated with the
same NUMA node.


big long TL;DR:

This creates the subtle assumption that each host-bridge will have
devices with similar performance characteristics if they're intended
for use as general purpose memory and/or interleave.

This means you should expect to have to reboot your machine if a
different NUMA topology is needed (for example, if you are physically
hotunplugging a volatile device to plug in a non-volatile device).



Stay tuned for more Fun and Profit with ACPI tables :]
~Gregory

