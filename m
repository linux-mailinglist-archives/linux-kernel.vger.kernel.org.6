Return-Path: <linux-kernel+bounces-562705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F00DA6316F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 19:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D3E3B2FA8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 18:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7532054F5;
	Sat, 15 Mar 2025 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rbdk3/mO"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DD5188734
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742062868; cv=none; b=GBw7/h4bPx3cF1bPJmjwMIYHeeDbdd9bQXKwwOQXlA7ukok/WPrsg888QMAZKDZUEAU4nDO+/JC88Pl2tvzjveS+ewyDpB9kj7hZAPaYSCYN3A3mO5f2P5i0EgpiwI2/GS/sWCxZrrQ1NSkuIrO76V8MH7f6ncir5bFDvqs1ySU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742062868; c=relaxed/simple;
	bh=mwSTBkUlk3Libq+Ntngy4NxtyyABG9GPKJEKLuBMURE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=janqI6t3R2mURSF3jiNE3gCJTNon34PDsR67Kisrn12b1mrnPApzyBp0+n2Zh6WykLYbPdvUVuxHk3Q41i9Uv0XnI+2iYKoumc1/R2IBYVC6//VHDaqFbvKGG0xJDsLlrV5Arnh1VxF05S9BInCi72TLYF3WaGTYlYp4ogZTmrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rbdk3/mO; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 15 Mar 2025 14:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742062861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gG92VM/xyO5WfWxQATJ6Qs1ENZnJ5RaitPv/Wu6ha1o=;
	b=Rbdk3/mOko8t7zjVAHCEbeF67SFakEAPtzjGNqS6wJRVo6fegCQkeM7FSUaufnuN5O2q6Y
	bdTqeTeipyOCEcRFi+5o7U7sXrm0S96FNDNfCEYABu5gojO3QBR69nBSlEgcrUW7vOO0Yq
	HUbG8+DLYfjBAa69tD4foygwgQj23ho=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] random: get_random_u64_below()
Message-ID: <olt5s7scbosagj4fpq25xun4kdvi6puwqdocgsvhpzguvpt7jt@dyy37p4uturh>
References: <20250313163810.60564-1-kent.overstreet@linux.dev>
 <20250315135234.65423e07@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315135234.65423e07@pumpkin>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 15, 2025 at 01:52:34PM +0000, David Laight wrote:
> On Thu, 13 Mar 2025 12:38:10 -0400
> Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > bcachefs needs this, for sampling devices to read from based on squared
> > device latencies.
> > 
> > this uses the same algorithm as get_random_u32_below: since the multiply
> > uses the top and bottom halves separately, it works out fairly well.
> 
> Adding two separate copies of much the same code is silly.
> Given what the code is doing, does it ever make any sense to inline it.
> 
> Inlining the original get_random_u32_below(ceil) that did
> 	(random_u32() * ((1ull << 32) / ceil) >> 32
> (for constant ceil) made sense.
> While good enough for most purposes it was replaced by the much more
> expensive function that guarantees that all the output values are
> equally likely - rather than just evenly distributed.

Expensive!? It adds a multiply.

That % gets constant folded, in the inlined case, and in the non-inline
case it's hit only a small fraction of the, time, for typical ceil.

