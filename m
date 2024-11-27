Return-Path: <linux-kernel+bounces-424053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F9D9DB01D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CAD166091
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 23:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B699D198A22;
	Wed, 27 Nov 2024 23:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sck6kqcE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B2615E5CA;
	Wed, 27 Nov 2024 23:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732751721; cv=none; b=sZeXSWijVg0kk0Gd52UP8+ptxrp/NTC/R+v2vwSNp52v8R1m1MOCFg09g8diXwIpZFD5H8hbJEObVW0y1/TRCWr2Cpnv9geYWz2NiJaysEN3hghOyCZ5hFn2Rvdicvz84zLEPCa1CPjby15g8pZjZbD36NEEhGnjcsAb7rsaW54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732751721; c=relaxed/simple;
	bh=B8fmrdHc5Dk+tV9vqznlHk8uhc8a+Z9ZoKSIWsmGcZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjK0vJWnE+B9RsdFY99JjeQwW1O72A46J9QCfIBdNa63YziuFpXF3orANLrCtsW9QKRLrQ3k+nVC4+YbuhvVokI3arLgg9o2Khuq+hBLd6qcz0swrgd4BvBmMGYDlo7GLIO8M2xObF1eof5HFn2oW72vmotr1ExHB/jURuXV8B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sck6kqcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629EFC4CECC;
	Wed, 27 Nov 2024 23:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732751719;
	bh=B8fmrdHc5Dk+tV9vqznlHk8uhc8a+Z9ZoKSIWsmGcZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sck6kqcEhmkHMzpT5LDf3tOcIJCa3/s+iQOAIaT5ZpqM2ifqzFlG2/Gvoub7sb+vv
	 dDqles6QUj5bvKk3tgsSGCCvfbu/INxm5URs9GhKDLzua4nXfyFLb1InAjffWBMZSG
	 0y4hq1rQeVMxzS7BSIyB5AFYFBFKa9SIqraeow+6Gu7wlUazFAE9bO051oxMqmwkVu
	 YbAWICOOQaHMdnsy2OmONBZXjTrXDYoLVMXr0lLEmYHX9yDHUEi+Fs35ClyJV/EcIN
	 sq4KbdtfuFJ5uHxi673qdOhO41AItQDuMFnQsi+hrRHj7M708OrpZkP2nEUWrJAOb7
	 GlD5HVYQYIVPA==
Date: Wed, 27 Nov 2024 23:55:18 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Ragavendra <ragavendra.bn@gmail.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, x86@kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/aesni: fix uninit value for skcipher_walk
Message-ID: <20241127235518.GA870796@google.com>
References: <20241127234347.1739754-1-ragavendra.bn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127234347.1739754-1-ragavendra.bn@gmail.com>

On Wed, Nov 27, 2024 at 03:43:47PM -0800, Ragavendra wrote:
> In crypto/aesni-intel_glue.c most declarations of struct
> skcipher_walk are unitialized. This causes one of the values
> in the struct to be left uninitialized in the later usages.
> 
> This patch fixes it by adding initializations to the struct
> skcipher_walk walk variable.
> 
> Fixes bugs reported in the Coverity scan with CID 139545,
> 1518179, 1585019 and 1598915.
> 
> Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>

This should be fixed in skcipher_walk_virt(), not in every caller.

- Eric

