Return-Path: <linux-kernel+bounces-280721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8729094CDFE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8FCA1C21FCE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E3F194A70;
	Fri,  9 Aug 2024 09:51:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6001192B72
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723197104; cv=none; b=exkN4uAFQXGh0kBmARq7oPm4CeOij2QCGC3F7PqchMvq9vrGSpvYfjoINrkvfo15vk42Atx/pqP5aKSiS+tFMoKdD7ullN+jcnhIbAUBXPC85FiIMojdL/ASt6dNlC4sqzxQ5SwM6q6HX4IZFRo3r8EbnG7A7hgSM7TipITeGNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723197104; c=relaxed/simple;
	bh=yoWTOMYJ7N0gPpdKFp05wGY7L6C18hAglWYv1Er11PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+enoSHhuj9ETZTED8gPaN9gA78GZeAOO1uAD7wgM6UGldIwPdHRmjpXhnbgUt0OVmNv0Q4rP6PivSBWzoKaSBf67hQj460dV1D/PjDRWu7Z0eo+cacNePAG4azFJsZq/zrsJ04Fnwq5ePYO685eBcStKJrNYKIxD/M3pdCH3OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8185C4AF0D;
	Fri,  9 Aug 2024 09:51:41 +0000 (UTC)
Date: Fri, 9 Aug 2024 10:51:39 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Baoquan He <bhe@redhat.com>, vgoyal@redhat.com, dyoung@redhat.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	chenjiahao16@huawei.com, akpm@linux-foundation.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH -next] crash: Fix riscv64 crash memory reserve dead loop
Message-ID: <ZrXmqyhalkcY-wpx@arm.com>
References: <20240802090105.3871929-1-ruanjinjie@huawei.com>
 <ZqywtegyIS/YXOVv@MiWiFi-R3L-srv>
 <ZrJ1JkyDVpRRB_9e@arm.com>
 <ZrJ60vopeGDXFZyK@arm.com>
 <e01df216-0225-ef49-8eb3-2ccdcb424785@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e01df216-0225-ef49-8eb3-2ccdcb424785@huawei.com>

On Thu, Aug 08, 2024 at 03:56:35PM +0800, Jinjie Ruan wrote:
> On 2024/8/7 3:34, Catalin Marinas wrote:
> > On Tue, Aug 06, 2024 at 08:10:30PM +0100, Catalin Marinas wrote:
> >> On Fri, Aug 02, 2024 at 06:11:01PM +0800, Baoquan He wrote:
> >>> And I don't like the idea crashkernel=,high failure will fallback to
> >>> attempt in low area, so this looks good to me.
> >>
> >> Well, I kind of liked this behaviour. One can specify ,high as a
> >> preference rather than forcing a range. The arm64 land has different
> >> platforms with some constrained memory layouts. Such fallback works well
> >> as a default command line option shipped with distros without having to
> >> guess the SoC memory layout.
> > 
> > I haven't tried but it's possible that this patch also breaks those
> > arm64 platforms with all RAM above 4GB when CRASH_ADDR_LOW_MAX is
> > memblock_end_of_DRAM(). Here all memory would be low and in the absence
> > of no fallback, it fails to allocate.
> > 
> > So, my strong preference would be to re-instate the current behaviour
> > and work around the infinite loop in a different way.
> 
> Hi, baoquan, What's your opinion?
> 
> Only this patch should be re-instate or all the 3 dead loop fix patch?

Only the riscv64 patch that that removes the ,high reservation fallback
to ,low. From this series:

https://lore.kernel.org/r/20240719095735.1912878-1-ruanjinjie@huawei.com/

the first two fixes look fine (x86_32). The third one (arm32), not sure
why it's in the series called "crash: Fix x86_32 memory reserve dead
loop bug". Does it fix a problem on arm32? Anyway, I'm not against it
getting merged but I'm not maintaining arm32. If the first two patches
could be merged for 6.11, I think the arm32 one is more of a 6.12
material (unless it does fix something).

On the riscv64 patch removing the high->low fallback to avoid the
infinite loop, I'd rather replace it with something similar to the
x86_32 fix in the series above. I suggested something in the main if
block but, looking at the x86_32 fix, for consistency, I think it would
look better as something like:

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index d3b4cd12bdd1..64d44a52c011 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -423,7 +423,8 @@ void __init reserve_crashkernel_generic(char *cmdline,
 		if (high && search_end == CRASH_ADDR_HIGH_MAX) {
 			search_end = CRASH_ADDR_LOW_MAX;
 			search_base = 0;
-			goto retry;
+			if (search_end != CRASH_ADDR_HIGH_MAX)
+				goto retry;
 		}
 		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
 			crash_size);

In summary, just replace the riscv64 fix with something along the lines
of the diff above (or pick whatever you prefer that still keeps the
fallback).

Thanks.

-- 
Catalin

