Return-Path: <linux-kernel+bounces-302735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0240F9602AC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30841F235B5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3251152787;
	Tue, 27 Aug 2024 07:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XNqTUCGD"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C8B8F58
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724742339; cv=none; b=SZxUjndRukeTkk45glmHGXCncO8+HusXWb7epjSfe2Sgja3tORcgmfJ7RjawiFalmWDyJCWoHUqpaHRUIfm9gNDSoBDtbySwUhBFgpOpstaE41Ip56r98wPrGyq9kgEpQ9i80h0rQDCiarXck+a3T59IKMGiWucTatfhKOttKTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724742339; c=relaxed/simple;
	bh=3prKYL4pOuJ52I4h/yMrpCu1CaKcAl4bYK6zWomrAJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sg9AABf6XGuxtSUs2cTHFZUo7wCvzdisXEkPeYqUaGJLjUfIqTG6NBsPH7rHUFh11Rc/ozBT9h28GNfgTHc7q5tOf/DcJNoJCaaLmxvm/cu4vmY/P6C2p3iyIT49IfMV2telMOe9srYIbzi2x9VnInTxjaF7GCK+VuY7nqVCliw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XNqTUCGD; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 Aug 2024 03:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724742334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NbC7t9Ien1nGCt/SYyLxwfKS4f4sVv6OHgu5DtaqtWw=;
	b=XNqTUCGDYD34QEkKy9rj2djn0dqWUZxABFTovjz1OcieUKH1/01ZL+fGhJkUpDpEG0E3mv
	0e+SAv7j76TJpFI6J89B42q8BVrZFeb8ZVU4DNjV/FOsqIkBY3pDy7sj01W8Agufy/MUW3
	qjO4AQGYTPb13PcIFsLsmaD42sgsKG8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <y7vve7rbvpf7fq5puzszn5fwogm63dum4n47o36u5z5rn4fxxi@wspvw6mhwndq>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-2-mhocko@kernel.org>
 <egma4j7om4jcrxwpks6odx6wu2jc5q3qdboncwsja32mo4oe7r@qmiviwad32lm>
 <ZszeUAMgGkGNz8H9@tiehlicka>
 <d5zorhk2dmgjjjta2zyqpyaly66ykzsnje4n4j4t5gjxzt57ty@km5j4jktn7fh>
 <ZszlQEqdDl4vt43M@tiehlicka>
 <ut5zfyvpkigjqev43kttxhxmpgnbkfs4vdqhe4dpxr6wnsx6ct@qmrazzu3fxyx>
 <Zs1rvLlk0mXklHyf@tiehlicka>
 <ru3d2bfrnyap7t3ya5kke3fqyrnj2hgbl4z2negbqkqj7z4mr2@gqrstl4lpl5h>
 <Zs15H6sT-QhvcZqa@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs15H6sT-QhvcZqa@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 27, 2024 at 08:58:39AM GMT, Michal Hocko wrote:
> On Tue 27-08-24 02:40:16, Kent Overstreet wrote:
> > On Tue, Aug 27, 2024 at 08:01:32AM GMT, Michal Hocko wrote:
> > > You are not really answering the main concern I have brought up though.
> > > I.e. GFP_NOFAIL being fundamentally incompatible with NORECLAIM semantic
> > > because the page allocator doesn't and will not support this allocation
> > > mode.  Scoped noreclaim semantic makes such a use much less visible
> > > because it can be deep in the scoped context there more error prone to
> > > introduce thus making the code harder to maintain. 
> > 
> > You're too attached to GFP_NOFAIL.
> 
> Unfortunatelly GFP_NOFAIL is there and we need to support it. We cannot
> just close eyes and pretend it doesn't exist and hope for the best.

You need to notice when you're trying to do something immpossible.

> > GFP_NOFAIL is something we very rarely use, and it's not something we
> > want to use. Furthermore, GFP_NOFAIL allocations can fail regardless of
> > this patch - e.g. if it's more than 2 pages, it's not going to be
> > GFP_NOFAIL.
> 
> We can reasonably assume we do not have any of those users in the tree
> though. We know that because we have a warning to tell us about that.
> We still have legit GFP_NOFAIL users and we can safely assume we will
> have some in the future though. And they have no way to handle the
> failure. If they did they wouldn't have used GFP_NOFAIL in the first
> place. So they do not check for NULL and they would either blow up or
> worse fail in subtle and harder to detect way.

No, because not all GFP_NOFAIL allocations are statically sized.

And the problem of the dynamic context overriding GFP_NOFAIL is more
general - if you use GFP_NOFAIL from nonblocking context (interrupt
context or preemption disabled) - the allocation has to fail, or
something even worse will happen.

Just because we don't track that with PF_MEMALLOC flags doesn't mean the
problem isn't htere.

