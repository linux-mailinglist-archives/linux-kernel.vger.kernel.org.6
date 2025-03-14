Return-Path: <linux-kernel+bounces-561187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40D2A60E87
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145EC169A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236E61E5B8E;
	Fri, 14 Mar 2025 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHVNfnUV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C841F92E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947352; cv=none; b=OCFy11W6BNFzFV8HmQoZ1nvi/DA4ghjinz5Ew10flM10G2oLm94n6G6D0iyDVjFkSoZ2+Ttt8YbJwRQAS5vA5mEKwLKUohlRPrh89CURvWOxtgaJKnFZUmsTR/3MGiSyV8l25K5WZVOlSDhgdShQaQmKmHxC28G8hASevZvg2rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947352; c=relaxed/simple;
	bh=TqKc/XGsjA43ERI7qLEzT2jZaPrsaw5Zt/13YKnNgLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUsYQPac3MpzI0fRh7VQLmDemnK9TWeRD2V8Sauc3sXnardJgdZDGBeRHY+CZC1seq0D0g63rvLgjSqolkZs4K/ZJA3Z9NGuqgoNzFFDWvIyDmuU5vtKGWy/3zCSRnertkGTrizDm7GJlVeizFLrAnqM8tOITPTOaNh2eEd8tYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHVNfnUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70947C4CEE3;
	Fri, 14 Mar 2025 10:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741947351;
	bh=TqKc/XGsjA43ERI7qLEzT2jZaPrsaw5Zt/13YKnNgLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHVNfnUVu1uE3oZuTM9un+2qatUt8E4Thpl3keUHHeQ1IZkfTMrgc9T4cw2Vvw8iI
	 FioZ94pPw6ixhShcEv3QYLlq1Zm6aZEkIcn5wTBSdNjEJmdGwrgKm/qzCAwEdcHD3M
	 5uhH0he/4wD+5e2hwpKl1klNuNPfr8AucYZKIilnqcSVOWT2g4/JS+7CFlha2NBGTc
	 Wwk5DnavfK2jDepStfS23uun8rCojO3f/3BXxMyJr0msv9Zlu6WTx2FGzeSaBfeijT
	 nqEWigOJ8CbLuRSRAmQ6sCS4/DY6IFdtOvctTALWoyWyIuWPASbc6d+FNRAnKBMMIA
	 o4g5eTla/SqlA==
Date: Fri, 14 Mar 2025 11:15:46 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/asm: Use asm_inline() instead of asm() in
 amd_clear_divider()
Message-ID: <Z9QB0nP6Mb3ri3mj@gmail.com>
References: <20250313191828.83855-1-ubizjak@gmail.com>
 <96E2026E-CEF1-4A4C-B107-7FCE2CD9121F@alien8.de>
 <CAFULd4ZTkBwFo3nWXNZKXSKiy4dgPoZ8i95nj3UdtQPApKdj3g@mail.gmail.com>
 <B7AB40CF-165D-448C-963C-787D74BB9042@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B7AB40CF-165D-448C-963C-787D74BB9042@alien8.de>


* Borislav Petkov <bp@alien8.de> wrote:

> Sorry but this doesn't justify this churn. There's nothing 
> quantifyingly palpable here to warrant this.

I disagree, asm() is a known-bad inlining interface for fundamentally 
single-instruction inlines like this one, and there's various 
performance benefits to cleaning this up, as evidenced by the benchmark 
numbers and analysis in this pending commit:

  9628d19e91f1 ("x86/locking/atomic: Improve performance by using asm_inline() for atomic locking instructions")

asm_inline() was implemented by the GCC folks *at our request* to fix 
such issues.

So these efforts are not "churn", at all - on the contrary.

Not merging such fixes/annotations would be similar to keeping build 
warnings about unclean code because they don't cause problems right 
now. While most build warnings are benign with no runtime effect, most 
of the time they point out an underlying problem.

We also asked Uros to submit careful, finegrained patches that might 
bloat the kernel, and this patch is the result of that request.

Thanks,

	Ingo

