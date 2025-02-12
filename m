Return-Path: <linux-kernel+bounces-511436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F80FA32B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67472167EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D4E2566D7;
	Wed, 12 Feb 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCC36UzI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC3B253B40;
	Wed, 12 Feb 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739376042; cv=none; b=oafA05I4dGlukuKTV5vze351GoFbiPSxZ8oY9Xtthqg2YaHY2EX4lgBg2TG+X7pELX5EcGVmCoSrDjexuJ3ochq8I5habDq+CS9SSbY2Lil9vhrc/1UojHSJwUrqXBoHzfw+A2o6K7wsL8HEpkAE7Rq6JJN50W3AVUzSrEKxits=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739376042; c=relaxed/simple;
	bh=P2PvM3qZ0BEUNG+xxCfwPu3336ksPgx0VFrUhWZNXA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QO0RZmAf+84TBnsNTfdDy9uA+RMUyRMjDZ0X6xMe7QLrHna5RMmeM5eUu5acO+WS5bDhehqrK6jEDof6x7G1CwaJ3Pw0egvbAM5wPs3n09N6BcDmnkNYv83uZKrKl/9+tdgqw91MoHnBFLDY0d5qbBu3XqFxaqlvfrpB8Gx/Woo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCC36UzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA975C4CEE4;
	Wed, 12 Feb 2025 16:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739376042;
	bh=P2PvM3qZ0BEUNG+xxCfwPu3336ksPgx0VFrUhWZNXA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HCC36UzI5XBvCVDEyZmkpEjKTweo4lRn22Jcr57O8TYA4WG6yztDM7xUPMpbHXwPA
	 6ik2sjCWTK0Demi17AUvltnpwZJs4K21ZaxEOhIlLsoX2/gKsbDoao1B4LyUk3Gt+7
	 RLzMvpg1RTwslbWYmoqoSEp5phjfBi/bAWroTHzeNBMwQuhzqelFPR9Bth1s50o/Cu
	 t762+vVPiI4XQFx/Q36/eBPYLe9Se/7uXtevG82OKGZbPPnAfHpZVkE/pHCGPluycY
	 b0sJBqsOa66GQ2IOn3SvABlnQv2cQEWXragDbof3+ALbgRqjK+8gMM93Qrt5GFCJFb
	 P+dBLJrUeXXaw==
Date: Wed, 12 Feb 2025 18:00:20 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
	Alexander Graf <graf@amazon.com>,
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
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
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
Subject: Re: [PATCH v4 14/14] Documentation: KHO: Add memblock bindings
Message-ID: <Z6zFlKU3Cm3nHI74@kernel.org>
References: <20250206132754.2596694-15-rppt@kernel.org>
 <45df0d7a-622a-4268-9683-c5c6067483c3@kernel.org>
 <Z6jFZII5b-j7hzkj@kernel.org>
 <a3cca0ed-64ca-4921-bb4c-27c0e06b78c6@kernel.org>
 <Z6kTCvex3DGhB-3C@kernel.org>
 <18529b1f-dc79-4c85-a485-a0a2cdd48670@kernel.org>
 <aa4ec16a-b35f-41b0-92f7-40b3eb64124a@kernel.org>
 <20250210191539.GA3765641@nvidia.com>
 <2fe7a404-be2c-4ac8-8980-2b3d07a74bca@kernel.org>
 <20250210202040.GB3754072@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210202040.GB3754072@nvidia.com>

On Mon, Feb 10, 2025 at 04:20:40PM -0400, Jason Gunthorpe wrote:
> On Mon, Feb 10, 2025 at 08:27:34PM +0100, Krzysztof Kozlowski wrote:
> > On 10/02/2025 20:15, Jason Gunthorpe wrote:
> > > On Sun, Feb 09, 2025 at 09:50:37PM +0100, Krzysztof Kozlowski wrote:
> > >>> Ah, neat, that would almost solve the problem but you wrote:
> > >>>
> > >>> +$id: http://devicetree.org/schemas/memblock/reserve_mem.yaml#
> > >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >>>
> > >>> so no, this does not work like that. You use devicetree here namespace
> > >>> and ignore its rules.
> > >>
> > >> ... and that obviously is barely parseable, so maybe one more try:
> > >> "You use here devicetree namespace but ignore its rules."
> > > 
> > > It makes sense to me, there should be zero cross-over of the two
> > > specs, KHO should be completely self defined and stand alone.
> > > 
> > > There is some documentation missing, I think. This yaml describes one
> > > node type, but the entire overall structure of the fdt does not seem
> > > to have documentation?
> > 
> > A lot of ABI is missing there and undocumented like: node name (which
> > for every standard DT would be a NAK), few properties. This binding
> > describes only subset while skipping all the rest and effectively
> > introducing implied/undocumented ABI.
> 
> I agree, I think it can be easily adressed - the docs should have a
> sample of the overal DT from the root node and yaml for each of the
> blocks, laying out the purpose very much like the open dt spec..

I'll update the docs with more details about overall structure and will
make it clear that it's a different namespace.
 
> Jason

-- 
Sincerely yours,
Mike.

