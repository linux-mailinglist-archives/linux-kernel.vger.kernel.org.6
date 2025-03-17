Return-Path: <linux-kernel+bounces-563730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DBCA6474F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCF31895C66
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3A1221F14;
	Mon, 17 Mar 2025 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fheKkLq6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A262133987
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203693; cv=none; b=oAnAfumRDSRH8kWKGaWyGWzNnMa1k0zG3MZvafhEFG0ywjopo30bZ+iW4XbAtoqvhfphb4e/N9d95OfA3zajDvuauvLIr8/t+Mdw5dF1TSr1wertzzEV3fzqcxRH74r8kSrCGX0qw/No4ykLsxqmqEfjc5S2b+kf33UPqw44zNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203693; c=relaxed/simple;
	bh=E2Q9rXhOJFqwklf98cKy7dtPqCvcux6p5MfxkmZmZJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9MxHFs/yUta9f4zpi6yPF0wwzlVslFWPcgAMG1AZ4PRMDEPw5MhAGkmx9ZaVHTBrl8iuibSfjJTeEBgPYq+y349Af0WRXWwN2YldKMZx/VdEDvlfaO6QrSmEYACyJMj6EkHMAv3Inx8W7r3WLnHNZZLGbBTb5tp0DLZijoX40I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fheKkLq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8E3C4CEE3;
	Mon, 17 Mar 2025 09:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742203692;
	bh=E2Q9rXhOJFqwklf98cKy7dtPqCvcux6p5MfxkmZmZJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fheKkLq6pvP7eIcaH91nP/rulfVhd9RwDXl7BARXs6Rb0vdxp4kBd5y9j1T2IV1Hp
	 hew0tgbqxAOtiiPbWEj4BkyXXu/N9VT+7l6hi/QVtu1KLseO6SNyWGNAis2oTd1IQL
	 8X0E7IYNv1MGvbuOHVs8SxDxkluWAjg+x2E8dOFn5EJwPAbHHpOFrNkyo9fo5U50c4
	 pHxgqsmd61uqCd+EVrY3XffRZgImeG0jBRiW1+WvdSkawOOk6hbUk2ZCcjd/oLpYal
	 2vWh4mljcOK1T3vZ9CYyuAfEDfWMyAyjFCuVpo81WgMtoHZLV87ebFWCTQnrX/W3C4
	 gzsQ+ZlX0ww7Q==
Date: Mon, 17 Mar 2025 10:28:08 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/asm: Use asm_inline() instead of asm() in
 __untagged_addr()
Message-ID: <Z9frKMLYnhZI0MDD@gmail.com>
References: <20250314093111.654359-1-ubizjak@gmail.com>
 <20250314112504.GBZ9QSEL1hgjp376ey@fat_crate.local>
 <Z9fk2NMBRHB9Eu5h@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9fk2NMBRHB9Eu5h@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> But GCC cannot always do proper inlining decisions due to our 
> complicated ALTERNATIVE macro constructs confusing the GCC inliner:
> 
>   > > ALTERNATIVE macro that expands to several pseudo directives causes 
>   > > instruction length estimate to count more than 20 instructions.
>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Note how the asm_inline() compiler feature was added by GCC at the 
> kernel community's request to address such issues. (!)
> 
> So for those reasons, in my book, eliminating a function call for 
> really simple single instruction inlines is an unconditional 
> improvement that doesn't require futile performance measurements - it 
> 'only' requires assembly level code generation analysis in the 
> changelog.

Note that at least in part this is a weakness of GCC: the compiler 
isn't looking at the asm() closely enough and the 20 instructions count 
vastly overestimates the true footprint of these statements.

Yet GCC is also giving us a tool: "asm __inline", which tells the 
compiler that this piece of asm() statement is small. A tool that was 
created at the request of the kernel community's complaints about this 
issue. :-/

asm_inline() is functionally similar to __force_inline - which we 
regularly apply if it has code generation benefits.

So I really don't see the harm in these patches - they have benefits in 
terms of GCC code generation quality, documentation and performance:

 - It documents small asm() statements by annotating them asm_inline().

 - It sometimes avoids function call overhead, improving performance.

And because single-function inlining changes are next to impossible to 
measure in practice in most cases, I'd suggest we skip the performance 
measurement requirement if the code generation advantages on a recent 
GCC version are unambiguous.

Thanks,

	Ingo

