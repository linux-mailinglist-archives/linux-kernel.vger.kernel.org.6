Return-Path: <linux-kernel+bounces-236935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2784991E8C7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A961C21820
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ADF16F8F2;
	Mon,  1 Jul 2024 19:43:42 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643A316D9BA
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863022; cv=none; b=gUJHbU9SVGWvu3XqptuYDhVJGewLgNyQ9Fi3DYBAP1Wd7RcO6nkYPGYey/EEQWK61E/ScgetEjPDHCfcYFSR4CxCxGlA32C1DvfjWLN7RrpZLQjeRaLBiNkKT/aki3GUbAeskgsboGdLXuhV0sLiwPYukzBCwBN1hrf3Hr/8k0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863022; c=relaxed/simple;
	bh=9tluj+ESFGK2toce68w+B8e3E8tY9EUxRxgN+2wSu28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7OotFYiiioPp9mMVfbTNd4LoackYY1Idh5tu4UtXDNczJic+4xLaw7lTDPKqWMiGcEsCFEB0xKKceT1JsyXnwMi4oLBk9g3pzXPO2kJ3bm4RrTNMI5mSqCedXVUQ5UoOIbzZseFSH3r7S3wq6eL4+c3IBTp1r2yOPkfmlfFVD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695F9C116B1;
	Mon,  1 Jul 2024 19:43:40 +0000 (UTC)
Date: Mon, 1 Jul 2024 20:43:38 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, will@kernel.org,
	anshuman.khandual@arm.com, david@redhat.com,
	scott@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
Message-ID: <ZoMG6n4hQp5XMhUN@arm.com>
References: <20240626191830.3819324-1-yang@os.amperecomputing.com>
 <Zn7q3oL1AE8jdM-g@arm.com>
 <773c8be7-eb73-010c-acea-1c2fefd65b84@gentwo.org>
 <Zn7xs6OYZz4dyA8a@arm.com>
 <200c5d06-c551-4847-adaf-287750e6aac4@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200c5d06-c551-4847-adaf-287750e6aac4@os.amperecomputing.com>

On Fri, Jun 28, 2024 at 11:20:43AM -0700, Yang Shi wrote:
> On 6/28/24 10:24 AM, Catalin Marinas wrote:
> > This patch does feel a bit like working around a non-optimal user choice
> > in kernel space. Who knows, madvise() may even be quicker if you do a
> > single call for a larger VA vs touching each page.
> 
> IMHO, I don't think so. I viewed this patch to solve or workaround some ISA
> inefficiency in kernel. Two faults are not necessary if we know we are
> definitely going to write the memory very soon, right?

I agree the Arm architecture behaviour is not ideal here and any
timelines for fixing it in hardware, if they do happen, are far into the
future. Purely from a kernel perspective, what I want though is make
sure that longer term (a) we don't create additional maintenance burden
and (b) we don't keep dead code around.

Point (a) could be mitigated if the architecture is changed so that any
new atomic instructions added to this range would also come with
additional syndrome information so that we don't have to update the
decoding patterns.

Point (b), however, depends on the OpenJDK and the kernel versions in
distros. Nick Gasson kindly provided some information on the OpenJDK
changes. The atomic_add(0) change happened in early 2022, about 5-6
months after MADV_POPULATE_WRITE support was added to the kernel. What's
interesting is Ampere already contributed MADV_POPULATE_WRITE support to
OpenJDK a few months ago:

https://github.com/openjdk/jdk/commit/a65a89522d2f24b1767e1c74f6689a22ea32ca6a

The OpenJDK commit lacks explanation but what I gathered from the diff
is that this option is the preferred one in the presence of THP (which
most/all distros enable by default). If we merge your proposed kernel
patch, it will take time before it makes its way into distros. I'm
hoping that by that time, distros would have picked a new OpenJDK
version already that doesn't need the atomic_add(0) pattern. If that's
the case, we end up with some dead code in the kernel that's almost
never exercised.

I don't follow OpenJDK development but I heard that updates are dragging
quite a lot. I can't tell whether people have picked up the
atomic_add(0) feature and whether, by the time a kernel patch would make
it into distros, they'd also move to the MADV_POPULATE_WRITE pattern.

There's a point (c) as well on the overhead of reading the faulting
instruction. I hope that's negligible but I haven't measured it.

-- 
Catalin

