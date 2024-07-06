Return-Path: <linux-kernel+bounces-243135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ED392924D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6521F21F78
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 09:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F354D8C8;
	Sat,  6 Jul 2024 09:47:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5098B446D2
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720259242; cv=none; b=PmzztmCQlfo3du309uzk2u+9wFSCcVvWxRWUpa4APQv2URAC0WNHVR95HgU9K3peaKHTO8rn2amf/WbrOXqcIlWyeoZ8Rnhfo5DwXkAgkcGQNUDBtOeCpzPjdw5afRqVdZfRQcBUk6lwsk4HViVGvHtA/2dpxO2489N47iky++4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720259242; c=relaxed/simple;
	bh=SNpNHhUcv0Nu9x6lfjzmHZ7ku7HEgmZlGoB55wIMZj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTokd4vvlgvfvXhKyVke7wbCXgezC+irp62jrTjZbFiAVj1DY3r1mbL3BUZHBwwMlo5RKQqgLsr1K7MTaWi/IuxAOmej6bhCj7vovikyfPtLIYFEjerVz+NdxapBi43bHxuCXCrIavt7cAYznkJie2JwEMU3AiwsEmD0T9A9ypY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBD5C2BD10;
	Sat,  6 Jul 2024 09:47:20 +0000 (UTC)
Date: Sat, 6 Jul 2024 10:47:17 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org,
	anshuman.khandual@arm.com, david@redhat.com,
	scott@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
Message-ID: <ZokSpUr16xmfY8Z6@arm.com>
References: <Zn7q3oL1AE8jdM-g@arm.com>
 <773c8be7-eb73-010c-acea-1c2fefd65b84@gentwo.org>
 <Zn7xs6OYZz4dyA8a@arm.com>
 <200c5d06-c551-4847-adaf-287750e6aac4@os.amperecomputing.com>
 <ZoMG6n4hQp5XMhUN@arm.com>
 <1689cd26-514a-4d72-a1bd-b67357aab3e0@os.amperecomputing.com>
 <ZoZzhf9gGQxADLFM@arm.com>
 <b0315df9-b122-46cd-12b2-7704d4a4392e@gentwo.org>
 <Zog6eFF1zDl4IRHX@arm.com>
 <b1b52185-595a-b4e7-cc96-90faf34c8077@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1b52185-595a-b4e7-cc96-90faf34c8077@gentwo.org>

On Fri, Jul 05, 2024 at 11:51:33AM -0700, Christoph Lameter (Ampere) wrote:
> On Fri, 5 Jul 2024, Catalin Marinas wrote:
> > People will be happy until one enables execute-only ELF text sections in
> > a distro and all that opcode parsing will add considerable overhead for
> > many read faults (those with a writeable vma).
> 
> The opcode is in the l1 cache since we just faulted on it. There is no
> "considerable" overhead.

This has nothing to do with caches (and many Arm implementations still
have separate I and D caches). With the right linker flags (e.g.
--execute-only for lld), one can generate a PROT_EXEC only (no
PROT_READ) ELF text section. On newer Arm CPUs with FEAT_EPAN, the
kernel no longer forces PROT_READ on PROT_EXEC only mappings. The
get_user() in this patch to read the opcode will fault. So instead of
two faults you get now for an atomic instruction, you'd get three (the
additional one for opcode reading). What's worse, it affects standard
loads as well in the same way.

Yang Shi did test this scenario but for correctness only, not
performance. It would be good to recompile the benchmark with
--execute-only (or --rosegment I think for gnu ld) and see post the
results.

> > Just to be clear, there are still potential issues to address (or
> > understand the impact of) in this patch with exec-only mappings and
> > the performance gain _after_ the THP behaviour changed in the mm code.
> > We can make a call once we have more data but, TBH, my inclination is
> > towards 'no' given that OpenJDK already support madvise() and it's not
> > arm64 specific.
> 
> It is arm64 specific. Other Linux architectures have optimizations for
> similar issues in their arch code as mentioned in the patch or the
> processors will not double fault.
> 
> Is there a particular reason for ARM as processor manufacturer to oppose
> this patch? We have mostly hand waving and speculations coming from you
> here.

Arm Ltd has no involvement at all in this decision (and probably if you
ask the architects, they wouldn't see any problem). Even though I have
an arm.com email address, my opinions on the list are purely from a
kernel maintainer perspective.

There's no speculation but some real concerns here. Please see above.

> What the patch does is clearly beneficial and it is an established way of
> implementing read->write fault handling.

It is clearly beneficial for this specific case but, as I said, we still
need to address the execute-only mappings causing an additional fault on
the opcode reading. You may not find many such binaries now in the field
but there's a strong push from security people to enable it (it's a
user-space decisions, the kernel simply provides PROT_EXEC only
mappings).

In addition, there's a 24% performance overhead in one of Yang Shi's
results. This has not been explained.

-- 
Catalin

