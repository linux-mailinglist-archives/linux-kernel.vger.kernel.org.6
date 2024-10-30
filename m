Return-Path: <linux-kernel+bounces-388131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3159B5AFE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 06:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53AF1F21654
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB95F199392;
	Wed, 30 Oct 2024 04:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GURAcYsa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA171991CF
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730264393; cv=none; b=CymFK8GnTiWnO0d+UEMPaywTYpQl3NTR736vDnq3Yof4+UjtcLUNY3MFK7kpRj49j/Ef3pPkjBN1AT/mOcdVV9BlorDbmBmbA5HXKhIQaMooZVv8tTKBgGaW0zxiC7QaY13nTUKJDWLP34WPuh1rxl1Jx8csHMfXJuJCWb7EHlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730264393; c=relaxed/simple;
	bh=clwkCkL3BZR7sqMAfkQC96bSOyRLVozXznaixOXl9DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoV+vDSPUrhOBFfIsK3u8xAzkfhtaJmLcDt+WbqnGZML00rODw75HxsVGD1VJopSvNuCnRHPpsO8EgIHnl476xk9QhnXWoR6qC3rp/i6D+kQyhL660+ukqZK4SgopFVTYwORR+vx0RXRBY3C4vEakEN0bGthDDxEpm65ILxe7rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GURAcYsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DFAC4CEE4;
	Wed, 30 Oct 2024 04:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730264392;
	bh=clwkCkL3BZR7sqMAfkQC96bSOyRLVozXznaixOXl9DE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GURAcYsarscbouOoVAkYLa3mgqib+mMtxhOmhXZhTMYl+WV9MczAevmN78y1o0Ssn
	 Zak27Gd4PMmkVsYjF9pgQ3Cy8BLzS1YOb9FJFO20epHkNoV1Yy2u59HmKuWRNK4o8D
	 vH5i1aHb8tJ0zf7HwYu1gZby+3jLyD/CSkmJ6/YxmXtX6axNYc2qqOpQtuG/olDzcv
	 RqQrUzVeWFHfTK4aVWGGBAypmeO8lUQxiOSmVs+d7rWEExPQ9+agnNlSRJlwtQN0cw
	 /KvBdv1H/m3SSx9h4vXVEd4GoPVXi0ZEJk71t8nn+wr8DUpfduK335zRcRxJmsxuMi
	 ReiuUH97ViYDQ==
Date: Tue, 29 Oct 2024 21:59:50 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Waiman Long <longman@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 1/6] x86/uaccess: Avoid barrier_nospec() in 64-bit
 copy_from_user()
Message-ID: <20241030045950.p6fc7xnkd3rq2gob@treble.attlocal.net>
References: <cover.1730166635.git.jpoimboe@kernel.org>
 <5b887fe4c580214900e21f6c61095adf9a142735.1730166635.git.jpoimboe@kernel.org>
 <CAHk-=wgaPk0tB-RtVAK4b6dTrtTAC3WkL1LmGO==ATrDLL-DRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgaPk0tB-RtVAK4b6dTrtTAC3WkL1LmGO==ATrDLL-DRA@mail.gmail.com>

On Tue, Oct 29, 2024 at 04:03:31PM -1000, Linus Torvalds wrote:
> Hmm. So it strikes me that this still does the "access_ok()", but
> that's pointless for the actual pointer masking case. One of the whole
> points of the pointer masking is that we can just do this without
> actually checking the address (or length) at all.
> 
> That's why the strncpy_from_user() has the pattern of
> 
>         if (can_do_masked_user_access()) {
>                 ... don't worry about the size of the address space ..
> 
> and I think this code should do that too.
> 
> IOW, I think we can do even better than your patch with something
> (UNTESTED!) like the attached.
> 
> That will also mean that any other architecture that starts doing the
> user address masking trick will pick up on this automatically.
> 
> Hmm?

Yeah, it makes sense to hook into that existing
can_do_masked_user_access() thing.  The patch looks good, and it boots
without blowing up.  Thanks!

Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

