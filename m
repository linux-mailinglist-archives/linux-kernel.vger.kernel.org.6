Return-Path: <linux-kernel+bounces-537230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5A1A48961
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7401890238
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4282826FA54;
	Thu, 27 Feb 2025 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OO/4wyg1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A388526F467
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686783; cv=none; b=aV3cVEwjhHq4qR/45AH3OH3nTZIPcxAMuQbs/ZxHoFrG9idLJbpjgIRaqVdggMoV0+NCJDRBYgUmaBB5Z6N2fhfJ7Nr/sRqMghOnCJS6DERwDy7vJUGQ8ab0vgqz4xYe6fUiGXuG9p8KXCvuUB8N4bOuflajsnMRgVrUaonlkcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686783; c=relaxed/simple;
	bh=trjmY3raMYBxwgZ+Z1XVxGKufDoMTrsniOghkTlRumM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kM0JUMZzPaExNjHW/zfX7fP70zgMGmENO/0V32gnxwFJ1K2hWCvyNlCdss93xogJwGmyUBOTjXg0JiBEPZlfIUCqf7bU/I6l/xTST7kFQ1JOv+plVAiXA0qkwQMmx3KhK6S8QvfDYFjwsIQrX3tUYVIidUh5NKyvYwK6M5/r6MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OO/4wyg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8DCC4CEDD;
	Thu, 27 Feb 2025 20:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740686783;
	bh=trjmY3raMYBxwgZ+Z1XVxGKufDoMTrsniOghkTlRumM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OO/4wyg1ye86mukwrCvUqHaa8qNqWzMlTP9Ed8H8wHUazNvvDwWtZ5DL2dHhwGI3/
	 RNRhrUsBzLC+Lt78V1FGM02An7uAcFireahJPOOiK7eGUZRUCk2cwMmlalrwWT842E
	 j3Rlp4CAp6Xtdgq+ooCYTbdiP5dVU3kKsK55s5U2scsOIr/qV1inaBmbpMPiGyU/Ks
	 /1kMov8gJSc6r8aHynrc3UPM31aRBNQCO0+loOWZ65va4Y2RIWCTfsGovaOlQ2OMMg
	 ZQdhYip1Xze+JuUb7inapl2ovvmSUdIMsjdo/6HZqxZHbRFAKYIGkjckNoq4g8CcC5
	 wRXuceXDxzh0g==
Date: Thu, 27 Feb 2025 21:06:18 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: bp@alien8.de, chang.seok.bae@intel.com, dave.hansen@intel.com,
	dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
	mingo@redhat.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH RFC v1 02/11] x86/fpu/xstate: Introduce xstate order
 table and accessor macro
Message-ID: <Z8DFusMiUYPZ3ffd@gmail.com>
References: <Z8C-xa7WB1kWoxqx@gmail.com>
 <94083f1c-dab1-4b57-bd45-a4d4f8ac262e@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94083f1c-dab1-4b57-bd45-a4d4f8ac262e@citrix.com>


* Andrew Cooper <andrew.cooper3@citrix.com> wrote:

> > I really don't see the issue:
> >
> >> There were basically three choices: 1. Reuse XFEATURES 3/4 (MPX) 2.
> >> Create a new out-of-order XFEATURE 19 that reuses MPX space 3. Create
> >> a n in-order XFEATURE 19 that needs XFD and an opt-in #1 risks
> >> breaking old MPX code in weird ways. 
> >
> > This is a false trichotomy. ;-)
> >
> > There's a 4th option:
> >
> >    4. Reuse XFEATURES 3/4 (MPX) only on APX-aware kernels, keep it 
> >       disabled for old kernels.
> >
> > Problem solved.
> 
> Forget breaking MPX code in weird ways; there's very little of it, 
> and it was distinctly of negative value.
> 
> What options #1 and #4 will cause is the virt people to come after 
> you with sharp implements for creating incompatibilities in an ABI.  
> The XFEATUREs are the tag(ish) of the union that is the xsave buffer.

There's no incompatibility for a default-disabled feature that gets 
enabled by an AVX-aware host kernel and by AVX-aware guest kernels. 
What ABI would be broken?

Kernels need to be updated for AVX support *anyway*, so it's not like 
the proposed approach is a simple shoe-in for old kernels.

Thanks,

	Ingo

