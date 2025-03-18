Return-Path: <linux-kernel+bounces-565213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BB1A66375
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95AF61790DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB0B1FC8;
	Tue, 18 Mar 2025 00:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+MTO5FH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FF87E9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742256721; cv=none; b=dxI7RGMz/XVj0/Nwj8xrhQy4kv1cpSBE2NxTYOCgx3nCssJyGo0a+B6M/9Co+kRh3hGEs48yZhi/x08Z2x4PZLPWLZRilqqdB53d1Xwgu/5FklYhBVhZw2ruAYFOjiHERJWP5lIe+xgNEDB5E2OzcMsOacS3CiFF04CVPtL6GMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742256721; c=relaxed/simple;
	bh=PKU1sZWlwUGyiapNRGjhgnOqEiv8BFDfiwnbPl6AnA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWlDcWPlJlSK9z0y4iPB1iO+3HoGl81qP9LaO6ahrqgJr3sCCYB1IsnosAvGfgnyFVIdLSb9UCTOVX4Pb0ZV5CqIQnZabe3A9Vzu48jHlb5e8ceKQqisH/wNZTK22dx43ABXeyeOFtPO1JxAlBySmeRk8K1irHBaNW89FmsuGyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+MTO5FH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529C4C4CEE3;
	Tue, 18 Mar 2025 00:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742256721;
	bh=PKU1sZWlwUGyiapNRGjhgnOqEiv8BFDfiwnbPl6AnA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C+MTO5FHpVxN0laYdAKdj6m3jpqk7xKEJFdMnLgpDkXvf/bJpBQU355pLC3rtuZmw
	 j3k/46t9O+6a7HP2kAhbeyFOZ6e8mbJKdKp+dVnK6rEtp3YJYREb9mK8NAo7Gd372h
	 C1spRy8CmNdEUR7RCPKeSsaBq1LW6y/+LihKzO1kOgT433lpC9jBjtDMI2d4M+DjZ7
	 iEhHEiXQntNCEhW/QSh5DyRkino5yKVkLKfUFnxwhZOET1iOyCDlT0qvQW4BQywEMj
	 UP9mgZH1vSBKp3VTBMl8Tw35LhO3I2TFP9DNpnR3BcP2ijBxGMgS8965692hrnTY99
	 8AwF7HyvmSt5Q==
Date: Mon, 17 Mar 2025 17:11:58 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 14/20] x86/barrier: Use alternative_io() in 32-bit
 barrier functions
Message-ID: <rvrdr6yefc6fbbsuhamf7ri4nlrxvmafcqpmgg6duwpj2blhad@a2wrcdspyvip>
References: <cover.1741988314.git.jpoimboe@kernel.org>
 <1c2fe7f93c4dd8a87c2e1fa8b780a8a2968be445.1741988314.git.jpoimboe@kernel.org>
 <CAHk-=wjtvTPERDdrok2kDrSSFBjqHCCNVff95VVxhvP6wCC6jg@mail.gmail.com>
 <zfabhk7c3fucov7lpfsqf5bj7iie5324ccgn4ingzzakoyhl4u@fzg364keuphn>
 <20250317200432.1a076d6a@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250317200432.1a076d6a@pumpkin>

On Mon, Mar 17, 2025 at 08:04:32PM +0000, David Laight wrote:
> Is the ARG() necessary just to handle the comma separated lists?
> If so is it only actually needed if there is more than one item?

No, but my preference is to require the use of the macro even for single
constraints as it helps visually separate the lists.

> Another option is to just require () and add the ARG in the expansion.
> So with:
> #define __asm_call(qual, alt, out, in, clobber) \
> 	asm("zzz", ARG out, ARG in, ARG clobber)
> 
> __asm_call(qual, ALT(), \
> 		([var] "+m" (__my_cpu_var(_var)), "+a" (old__.low),	\
> 		    "+d" (old__.high)),					\
> 		("b" (new__.low), "c" (new__.high), "S" (&(_var))),	\
> 		("memory"));
> 
> would get expanded the same as the line below.

Interesting idea, though I still prefer the self-documenting ASM_OUTPUT
/ ASM_INPUT / ASM_CLOBBER macros which are self-documenting and make it
easier to read and visually distinguish the constraint lists.

-- 
Josh

