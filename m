Return-Path: <linux-kernel+bounces-379233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E65649ADBC8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3BF2823FA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0962175D2A;
	Thu, 24 Oct 2024 06:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgB6TvR0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF4B17BD3
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 06:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750382; cv=none; b=S2eW2hraH2aUMAwRnPkPSASiEaax1E0GGzZzhhk9cVmydQnYTQJoDykvxfBKQ2le6V6ICkV/53uC1qTCCeNNH13/oEouhSxaEDedvPffSymwCMTRxDU3Y8RXCdzyf8IHwKoJkaUbs2f3s+vWuqVbrJJW7NFrxLSydLpBjQzuGdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750382; c=relaxed/simple;
	bh=1I5YyxwXyx2BeLg2MZ6oAChrLKy8U9hBi5yEgSnehug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBGAHJ2JdEvfbDef9/wviDgLDNezS+k+9vTHUHsTIbFFTSos/Z+8Oy+WRLnykY63m9rBQ0+6atlPOZJsrCSlDYZHG3lEGMkkkiecB3AktWE83WsmcajHStUeA1EShLz6mq1xma4QcuwAMdIOYw2S2XQhqu38nJ05fTo2In56FM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgB6TvR0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E589C4CEE4;
	Thu, 24 Oct 2024 06:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729750381;
	bh=1I5YyxwXyx2BeLg2MZ6oAChrLKy8U9hBi5yEgSnehug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FgB6TvR0PAxVsoQXxZcIrMuBgHkG9PWKCuxgZLfST+rG5jjtowIkynlm2hqjfbktv
	 2hcQqzqmzI82g8tO78joDyVKljNxy78HJ0zVlpZ/CKeC+vdEOCU0vvg23TqzCCKpa4
	 ZQ3e3Zd6gN/IXo77OVmmbAmvS7r/Y8ksVy5BJr/uZDr4zM1zzlrWGjNohZLZXMYNP5
	 8gCgwPthDYll0RV1PbdZdNusasIT9qxIgMUtnTlljkGM+zqmIUZmm8dYnSeMdMcfHJ
	 iW38JF+CX2siKeTiv2uhDnZQUAARh8t9O2ZKINzWKT6vwFKMSic5WiELJqZDABzLP8
	 Ep5ZQZW8QPQxg==
Date: Wed, 23 Oct 2024 23:13:00 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86: fix user address masking non-canonical speculation
 issue
Message-ID: <20241024061300.l5y4ng5gmkfrfdht@treble.attlocal.net>
References: <20241024013214.129639-1-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241024013214.129639-1-torvalds@linux-foundation.org>

On Wed, Oct 23, 2024 at 06:31:59PM -0700, Linus Torvalds wrote:
> @@ -2389,6 +2390,15 @@ void __init arch_cpu_finalize_init(void)
> +		/*
> +		 * Enable this when LAM is gated on LASS support
> +		if (cpu_feature_enabled(X86_FEATURE_LAM))
> +			USER_PTR_MAX = (1ul << 63) - PAGE_SIZE;
> +		 */

I'm probably missing something but once LAM is enabled, how wouldn't
this allow non-canonical address speculation?  i.e. when bit 47/56 is
set and 63 is cleared, would it not go untouched by mask_user_address()
and thus be speculatively interpreted by AMD as a kernel address?

Also, the comment above __access_ok() now seems obsolete:

/*
 * User pointers can have tag bits on x86-64.  This scheme tolerates
 * arbitrary values in those bits rather then masking them off.
 *
 * Enforce two rules:
 * 1. 'ptr' must be in the user half of the address space
 * 2. 'ptr+size' must not overflow into kernel addresses
 *
 * Note that addresses around the sign change are not valid addresses,
 * and will GP-fault even with LAM enabled if the sign bit is set (see
 * "CR3.LAM_SUP" that can narrow the canonicality check if we ever
 * enable it, but not remove it entirely).
 *
 * So the "overflow into kernel addresses" does not imply some sudden
 * exact boundary at the sign bit, and we can allow a lot of slop on the
 * size check.
 *
 * In fact, we could probably remove the size check entirely, since
 * any kernel accesses will be in increasing address order starting
 * at 'ptr', and even if the end might be in kernel space, we'll
 * hit the GP faults for non-canonical accesses before we ever get
 * there.
 *
 * That's a separate optimization, for now just handle the small
 * constant case.
 */

Other than the LAM question, it looks good to me and the code
generation+patching works as expected on a live system.

-- 
Josh

