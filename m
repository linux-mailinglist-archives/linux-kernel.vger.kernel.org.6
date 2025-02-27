Return-Path: <linux-kernel+bounces-537208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84682A48929
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E0A016D7B0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5862226E96E;
	Thu, 27 Feb 2025 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcziDZq4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB165270054
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740685331; cv=none; b=Wcbl29VmzL82AQ/G9Q1ZDW+n/T2+tWJF3yTn+1+DTuOzSLCcGiiMXRuI9aHWY3VCNv2UvhWAzsiR/4XJkvh4i/dhbO3T5wv1WYAJDzhlxULxCHIOPbEpVIVz3yt2/4OnIDsQdip7swKjaVBrkMA/UtgH1QNWinAkUtqLo1KQOjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740685331; c=relaxed/simple;
	bh=58ADl/cAVUGO9i4kpPpRX/kg9mOejz2kZqQIsZHWQI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLYDhBOEEis58kMMkzdRpglG6RiYAAcBTKP43jGoAJNEeNCdh2mRvZk7a3UuwCN+wfelwwi7KAxMKE9VRNX9ItAWickQshA7swFD54Nvz+5BIW8EF+RxXyfcbbHWEmSAJdo45QOELJnnM6iB+xUi3EvmF5FzXAAM0xilx5qRFdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcziDZq4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7A1C4DDF7;
	Thu, 27 Feb 2025 19:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740685331;
	bh=58ADl/cAVUGO9i4kpPpRX/kg9mOejz2kZqQIsZHWQI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rcziDZq40o8A045R9IPSY2fJmgjjfTg0Xgj3eh8v48tI8qb6qfANe3WTyWZ90JNLK
	 6WdrDb+6eu29Hwjghj9b2xzuIItR2QFVuWj/sXbnleNnWatEyXN13LNiYZP4OZ8nTl
	 FXaP/fqHhSj6geQjP9xK5Lp9NFVjZMP+Tv5fxPPANuD3NfYa2L3VGabVLVeBVhkBUm
	 IV1aFp6vwBoeNLIXZ+9LLN1km18xZeWEDSr1kJ8lIwuXozj6wDIyG/Re0aP6yMpirn
	 EmAnISnAo7UXAMzvq1cHJKn94BuQPaQo56kYt7GPw90MHBTNFr+2fGQnaK9pm1QD9l
	 daRdC+iumznkA==
Date: Thu, 27 Feb 2025 20:42:00 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: dave.hansen@intel.com, bp@alien8.de, chang.seok.bae@intel.com,
	dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
	mingo@redhat.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH RFC v1 02/11] x86/fpu/xstate: Introduce xstate order
 table and accessor macro
Message-ID: <Z8DACBJUqZ8WwgpO@gmail.com>
References: <7fa02be2-0884-4702-ae73-a3620938161b@intel.com>
 <1a73d33b-e943-4ddd-9373-4678ff85c90a@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a73d33b-e943-4ddd-9373-4678ff85c90a@citrix.com>


* Andrew Cooper <andrew.cooper3@citrix.com> wrote:

> On 2/27/25 19:03, Dave Hansen wrote:
> 
> > On 2/27/25 10:44, Chang S. Bae wrote:
> >> The kernel has largely assumed that higher xstate component numbers
> >> correspond to later offsets in the buffer. However, this assumption
> >> does not hold for the non-compacted format, where a newer state
> >> component may have a lower offset.
> > Maybe "no longer holds" instead of "does not hold".
> >
> > This never happened before APX, right?
> 
> I'm afraid that AMD beat you there by a decade with LWP, index 63 but 
> also overlaps the MPX state.

https://giphy.com/gifs/moodman-TJawtKM6OCKkvwCIqX

> Except LWP support never became mainstream, and it also got 
> sacrificed to make room for IBPB in microcode, so you can safely 
> ignore it[1].

yay! CPU makers always chose the right solution, once they have 
exhaused all the alternatives.

Thanks,

	Ingo

