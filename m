Return-Path: <linux-kernel+bounces-370698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3E19A30E5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302911F22DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EA81D7E57;
	Thu, 17 Oct 2024 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKbqSTVB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A381D5AC6
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729204969; cv=none; b=hZyis3SIhWkqlJZZdWD82KLylvznkzFhgXSZYkR+BVCAY1W8WcI9HfBYRZFJOHs/2czTgzZKLjYozW/Z8VIXbSfsw20RluEExJ0EQr8RM/SP3ZitUUgHXzoEYAHolNrFRQ0bohwavlJNgj6rODFwYWEi5DnlEgd2mjY6n419RVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729204969; c=relaxed/simple;
	bh=JHtXMaB+CPINg+B2vnayFI8jLb4ohNW0ndJszacXDdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cItmR4Mdz/sD3g8aBP8+rmph++bswFLnhZ0oJX4OSeVwE3/5Fe0JWqsOFAtC2OtB3X2nxMtpHcVQSGcq8bW/gGgqRSfbmRuGHxszAoG/75YPdgQYb2yJHuWVp+M63I2iMS6i7LLxQaX2vfrcX0MavdVqUoXB0rEXNzoZNjKFxUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKbqSTVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FE8C4CEC3;
	Thu, 17 Oct 2024 22:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729204968;
	bh=JHtXMaB+CPINg+B2vnayFI8jLb4ohNW0ndJszacXDdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OKbqSTVBk5in3oaJm16Cu8TrK3dMAju+EqjhWQVO0uyQWvf3ROGYOAEY1Bdzraslj
	 VKSYT3M6sB9TQysgCUGRvqVPF7s37PIWMECySqi43QDVrJtYSlfSL9G17elD+ZFYmZ
	 GCzDtQOcW7rVBECyHJ+IR74xt3/NbjqDMFArnZzXiJ9F/eXMalfuiyp/iKZ0bgNCLJ
	 vM+3W0OmnWkjjNHCPwvDyJJyT0hqjaRPEBLOuZNGjdoLHhfeUwo1S6lU/Tl5ed21Pr
	 ZYfZFMDuPANvrMljA1iya1rOgq6J+SqilS1Ak6HNZp8Oah90EJvVXM1TQ7p98BCnYg
	 957xWZEfcbRlA==
Date: Thu, 17 Oct 2024 15:42:46 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Waiman Long <longman@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, Mark Rutland <mark.rutland@arm.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 0/6] x86/uaccess: Avoid barrier_nospec()
Message-ID: <20241017224246.5pcgeeiforndgiha@treble>
References: <cover.1729201904.git.jpoimboe@kernel.org>
 <8baa42b8-2529-44d8-99e5-341132c09264@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8baa42b8-2529-44d8-99e5-341132c09264@citrix.com>

On Thu, Oct 17, 2024 at 11:31:30PM +0100, Andrew Cooper wrote:
> Even if you can get Intel and AMD to agree that STAC/CLAC are really
> LFENCEs (and I think you'll struggle), they'd only confer the safety you
> want between a real conditional that excludes the non-canonical range,
> and the pointer deference.
> 
> Any path that genuinely deferences a non-canonical pointer is not safe,
> whatever serialisation you put in the way.  The attacker wins the moment
> the load uop executes.
> 
> The final hunk of patch 1 is safe (iff STAC is given extra guarantees)
> because it is between the conditional and the deference.  Patch 4 is not
> safe (if the comment is correct) because it removes the conditional.

So the naming is confusing:

  - put_user()   implementation is __put_user_*()
  - __put_user() implementation is __put_user_nocheck_*()

Patch 4 only affects __put_user(), for which the user is expected to
call access_ok() beforehand.

The current implementations of get_user(), put_user() and
masked_user_access_begin() avoid the conditional.  Those are the ones it
sounds like you're worried about?

None of my patches remove conditional checks.

-- 
Josh

