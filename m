Return-Path: <linux-kernel+bounces-302064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FFA95F95B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F998B22C3B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE83A1991A9;
	Mon, 26 Aug 2024 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R+cGw2Tp"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E147A2B9A1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724699075; cv=none; b=joqDEim/vMV4GQVxmTC7SBNY9/F1QpirHJA7+utxbEi90crIbCbGWt5L/LOVi7IUefQT8HjY3pQzxshGBRs0zUQPiF3XO46CU8XYi5ZQQALHw343oRk11jepcm95DOdKSf2hjKXJeaLtxSFgdXwcXu9BMfVxsdID0GrERbC4fFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724699075; c=relaxed/simple;
	bh=LbA+6N21gTi0f62vFD35gocwERgw9HNhgHdKfmklcG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmzU8F9YgrsmUVbvCet1GDO08Rfk4J3b0nqGi4kF7SuuwhoGga/MFahupxrqHrvH7wAf+cUgEBWeumXN/r5eB5qjeiGici92VOUElvAyKfIrKkQ4DtOEcQ5HLOYp5FDiwqm+NYZ2QXsg6740VPfRD19CVve3wmefkX+h5IZb64M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R+cGw2Tp; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 Aug 2024 15:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724699070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4Ic9Fq8l/YRsMsbrKHAvIEYDvZrJ7Rz8RzOxpo/lhI=;
	b=R+cGw2TpUaJ84nERzAZm5TNmUYh7XrjcjIzhqMaWFPsw+ctPzCjwwcJhwJ7as4GwRQwOlS
	qR3JJ7MXwbLIpzIePIZRY5zfJ4VItwn1yj8RXDs7aFM2gP2EtGGX++FAMuv3bwLSvzAFc3
	UAH+oBwr1sZn5+0OygfTSiLdlPrRnPI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 2/2] mm: drop PF_MEMALLOC_NORECLAIM
Message-ID: <dertpwh33crhjpghdsn5n3svrwhrv7cv446hyrqdblc3wcw3pp@a7ds4wsgvehg>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-3-mhocko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826085347.1152675-3-mhocko@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 26, 2024 at 10:47:13AM GMT, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> There is no existing user of the flag and the flag is dangerous because
> a nested allocation context can use GFP_NOFAIL which could cause
> unexpected failure. Such a code would be hard to maintain because it
> could be deeper in the call chain.
> 
> PF_MEMALLOC_NORECLAIM has been added even when it was pointed out [1]
> that such a allocation contex is inherently unsafe if the context
> doesn't fully control all allocations called from this context.

I don't really buy the unsafety argument; if it applies to anything, it
applies to GFP_NOFAIL - but we recently grew warnings about unsafe uses
for it, so I don't see it as a great concern.

GFP_NORECLAIM is frequently desirable as a hint about the latency
requirements of a codepath; "don't try too hard, I've got fallbacks and
I'm in a codepath where I don't want to block too long".

I expect PF_MEMALLOC_NORECLAIM will find legitimate uses.

