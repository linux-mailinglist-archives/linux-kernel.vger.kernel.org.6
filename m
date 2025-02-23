Return-Path: <linux-kernel+bounces-527893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DE1A410F4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04561731D9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 18:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796EF17B505;
	Sun, 23 Feb 2025 18:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AC8V4qpt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05F4CA64;
	Sun, 23 Feb 2025 18:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740336708; cv=none; b=YZVHLO6XfIE3HCdazNCRg6Jd3T5iAgw9l2vcUGlgvS0ZY2T/emR98rTsiVT0G9agi1HMxJTuV67j5NwA+RybxPC+Qw4zDVCMt5d3TLPrcj+N7IfviP1/VdSn2G1PY/sQ3q9bCDzBfqNbWApNXU2vfG2zMhINi/nc07/RIT6V0o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740336708; c=relaxed/simple;
	bh=tco7lF+ns8c6//J7LH3Pw1kK1mQ+wFDcdS7oH71ovZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P33rLOOFhG+hiP7u+BmtHHzqp8uVWYe82Enc5cvw5pxIDBISig2UFS/U8JKJBNW4quEDXDxZU+1wG+SlElut35RMBKXzh0c8GZLKkonQhV70JJCIOJNLBVmOVMU8Zk7ClYtZk5RyAk0wnBh1NxBY+/13iP5XiqrS+At87DMzUEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AC8V4qpt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCCAC4CEDD;
	Sun, 23 Feb 2025 18:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740336708;
	bh=tco7lF+ns8c6//J7LH3Pw1kK1mQ+wFDcdS7oH71ovZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AC8V4qptb+AtjX51lQpQkK+feFUMV6tEPciZsc50vgPEZZgXJ1Mr4Wzt7gW7ncRVo
	 Pt9qf6/7Xj1nucn97rkBAvcg1gvIbSBfi4vLWNYW1Bti3Pp9XJRm1yUzDZOyQsQked
	 X34aOkKQ9k+9y02frKQDZp3NLs+3NcckJUmxCX9gLcUhTieOhWf166eJVGsyLSlOR9
	 lWRj/Ck4JYsdvBrvGHwpNQCWs/LyFm4bpcEkILuW9yIPoYj373AD5iOcoPBVBLranD
	 XyPmKBdMuZXi/JeAzNVhBDavpPR/JhEriZkg8Hu83FZNMSODeSrM13Nax7awzelSqN
	 yk0gFpZg0lLSA==
Date: Sun, 23 Feb 2025 20:51:27 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 05/14] kexec: Add Kexec HandOver (KHO) generation
 helpers
Message-ID: <Z7tuL-FInR7KLD1l@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-6-rppt@kernel.org>
 <20250210202220.GC3765641@nvidia.com>
 <CA+CK2bBBX+HgD0HLj-AyTScM59F2wXq11BEPgejPMHoEwqj+_Q@mail.gmail.com>
 <20250211124943.GC3754072@nvidia.com>
 <CA+CK2bAEnaPUJmd3LxFwCRa9xWrSJ478c4xisvD4pwvNMiTCgA@mail.gmail.com>
 <20250211163720.GH3754072@nvidia.com>
 <20250212152336.GA3848889@nvidia.com>
 <Z6zOqtaLQwnIWl2E@kernel.org>
 <20250212174303.GU3754072@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212174303.GU3754072@nvidia.com>

On Wed, Feb 12, 2025 at 01:43:03PM -0400, Jason Gunthorpe wrote:
> On Wed, Feb 12, 2025 at 06:39:06PM +0200, Mike Rapoport wrote:
> 
> > As I've mentioned off-list earlier, KHO in its current form is the lowest
> > level of abstraction for state preservation and it is by no means is
> > intended to provide complex drivers with all the tools necessary.
> 
> My point, is I think it is the wrong level of abstraction and the
> wrong FDT schema. It does not and cannot solve the problems we know we
> will have, so why invest anything into that schema?

Preserving a lot of random pages spread all over the place will be a
problem no matter what. With kho_preserve_folio() the users will still need
to save physical address of that folio somewhere, be it FDT or some binary
structure that FDT will point to. So either instead of "mem" properties we'll
have "addresses" property or a pointer to yet another page that should be
preserved and, by the way, "mem" may come handy in this case :)

I don't see how the "mem" property contradicts future extensions and for
simple use cases it is already enough. The simple reserve_mem use case in
this patchset indeed does not represent the complexity of a driver, but
it's still useful, at least for the ftrace folks. And reserve_mem is just
fine with "mem" property.
 
> I think the scratch system is great, and an amazing improvement over
> past version. Upgrade the memory preservation to match and it will be
> really good.
> 
> > What you propose is a great optimization for memory preservation mechanism,
> > and additional and very useful abstraction layer on top of "basic KHO"!
> 
> I do not see this as a layer on top, I see it as fundamentally
> replacing the memory preservation mechanism with something more
> scalable.

There are two parts to the memory preservation: making sure the preserved
pages don't make it to the free lists and than restoring struct
page/folio/memdesc so that the pages will look the same way as when they
were allocated.

For the first part we must memblock_reserve(addr, size) for every preserved
range before memblock releases memory to the buddy.
I did an experiment and preserved 1GiB of random order-0 pages and measured
time required to reserve everything in memblock.
kho_deserialize() you suggested slightly outperformed
kho_init_reserved_pages() that parsed a single "mem" property containing
an array of <addr, size> pairs. For more random distribution of orders and
more deep FDT the difference or course would be higher, but still both
options sucked relatively to a maple tree serialized similarly to your
tracker xarray.

For the restoration of the struct folio for multiorder folios the tracker
xarray is a really great fit, but again, it does not contradict having
"mem" properties. And the restoration of struct folio does not have to
happen very early, so we'd probably want to run it in parallel, somewhat
like deferred initialization of struct page.
 
> > But I think it will be easier to start with something *very simple* and
> > probably suboptimal and then extend it rather than to try to build complex
> > comprehensive solution from day one.
> 
> But why? Just do it right from the start? I spent like a hour
> sketching that, the existing preservation code is also very simple,
> why not just fix it right now?

As I see it, we can have both. "mem" property for simple use cases, or as a
partial solution for complex use cases and tracker you proposed for
preserving the order of the folios.

And as another optimization we may want a maple tree for coalescing as much
as possible to reduce amount of memblock_reserve() calls.
 
> Jason

-- 
Sincerely yours,
Mike.

