Return-Path: <linux-kernel+bounces-268310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D66C6942310
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858911F2497E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F671917D6;
	Tue, 30 Jul 2024 22:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnboNwLx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2671018DF9D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 22:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722379387; cv=none; b=ml2AW/BnEOotaprsnUk7kAgSkWDJSPFkMcD3CTOwgynR2sQBUrDws36iCcOEwnHbn0kuRsTWsupBrmtuu4pcq6cGe07ArF6alKkYG2kIhAIJgyHVWll0hxS3bYUbitmqMI8bDVMC+2g7VON8Yz4MMfrYoJW+1FWOPbbWK3P9Y8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722379387; c=relaxed/simple;
	bh=C3lXJgJCovoa1FrP2K9NxLwNt79kRXHdx71rpFLCEkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZTnnCMPL8f290nacL2q04pWco4MCKcs1Kb8WUacQnQJWM3Chcoob76R+vsjZuBwWJWvgqNttqU6gaNA9atyxFNMUoWyEkcaAAeBynS1wtYzzmyg4qNQ4TUXPOc7I8WC0mO9QvPpme0tfeNOC9iw0COBBF0QfGDT0nCeUaNafXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnboNwLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8A0C32782;
	Tue, 30 Jul 2024 22:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722379386;
	bh=C3lXJgJCovoa1FrP2K9NxLwNt79kRXHdx71rpFLCEkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lnboNwLxJyFxKtEaiWymk9Q/n8Xy6nev/WHULsWLoGXfvLKMZzR7y2YlrIeBvjlxU
	 eMF2cmvQliHYtglKf4G4fh3NFOoMZo0NBDXFtXeFC4oWc38RtPpoqFtTZBXkmoLiVM
	 RaRWYejEfeAjQuGneuuNZ+HzVf6qxnrmdaYS3oBWzfqKyh3fwA3njHUT/AUCN50kWN
	 wE0LROsis7tkzP6Qmroke4mn2IJg/R1L6XdiRq2s9BkGYGg9123JvIIyCxot3kf623
	 dQyMiRWLwtj0Fta+STtU1GplxxzJ8OBkyESgXw6fc0hlFO6YNn9tY1R2EqfjTE0Fpb
	 rn6T5vmno+9qg==
Date: Wed, 31 Jul 2024 00:43:02 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: urezki@gmail.com, hch@infradead.org, vbabka@suse.cz, mhocko@suse.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/4] mm: vrealloc: properly document __GFP_ZERO behavior
Message-ID: <ZqlsdtTWhRahFWmy@pollux.localdomain>
References: <20240730185049.6244-1-dakr@kernel.org>
 <20240730185049.6244-4-dakr@kernel.org>
 <20240730141953.a30fa50c0ba060fe0a765730@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730141953.a30fa50c0ba060fe0a765730@linux-foundation.org>

On Tue, Jul 30, 2024 at 02:19:53PM -0700, Andrew Morton wrote:
> On Tue, 30 Jul 2024 20:49:43 +0200 Danilo Krummrich <dakr@kernel.org> wrote:
> 
> > Properly document that if __GFP_ZERO logic is requested, callers must
> > ensure that, starting with the initial memory allocation, every
> > subsequent call to this API for the same memory allocation is flagged
> > with __GFP_ZERO. Otherwise, it is possible that __GFP_ZERO is not fully
> > honored by this API.
> 
> I appear to have just seen this, in a separate mailing.

What you have seen in a separate mail is a similar patch for krealloc() [1].
This one is a fixup for vrealloc() from a previous submission you've applied to
mm-unstable.

> 
> Please, slow down.  We have two months.  Await reviewer feedback, spend
> time over those changelogs, value clarity and accuracy and completeness
> over hastiness.  The only reason for rushing things is if a patch is
> disrupting ongoing testing of the linux-next tree.

There was a discussion in [2], which lead to this fixup series.

In terms of changelogs this series is indeed a bit "lax", since I have
recognized that you queue up fixup patches for changes that did already land in
mm-unstable to be squashed into the original commits later on.

[1] https://lore.kernel.org/linux-mm/20240730194214.31483-1-dakr@kernel.org/
[2] https://lore.kernel.org/linux-mm/20240722163111.4766-1-dakr@kernel.org/T/#m065a7f875b44dc945dd535c2b7168c3d77a98993

