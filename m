Return-Path: <linux-kernel+bounces-266461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1413940032
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57F5DB21860
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B64118D4AA;
	Mon, 29 Jul 2024 21:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="PHRi+uoZ"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA38713A88D;
	Mon, 29 Jul 2024 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287468; cv=none; b=tJhIQ2jY8qJus0T2B7ofsHY7pyFAxzq/0xtANtPptA7qmaVVQmF6nhbW1raJrAvWIDhhw9ebWfxtWeSJ1/TvIS2Lcoy9uEIxlVBmpjB1eVTktgmPLgSGxeSXGueJ3YZZiMj1tnMx7MaVBJoYgnABSirSxA3OQfAEXarJCykIsV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287468; c=relaxed/simple;
	bh=7N8zGWZbkIrI+9GXsmFJK5ZBSTWzlDH21ZdcerrJyBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sYrbANE9Hdpm0+NvNy3mbkeHRHS9gxhY/6S0uqT7h+QbGF9d2kqzEheV3c5oVjZ/XCzWIHkLxkvnHvaa/j82Kpa7cMh5E2WAflZxxD7LqxkE5LQglaFdgpQ306vXMowMaQMlnbXXpMu8ypu1mNYF9AJETisHQUQeW1dWy5B91c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=PHRi+uoZ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C40E141A2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1722287461; bh=03NG19DlTxsjflgEUiClMvPn5IFMTSm0+ZrurIHM9gE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PHRi+uoZNMfc2CQxvrYzIAKPfxG1FOoXBLLICZ2V6u6dfsR/nN1xpmFP1kSzyD4P1
	 dYryOOYF4be0Z3ydD0cF4q+WYP3fx3cmmKmeBUmtKXWckrQw59kZ7g4DAbmYLLtYb4
	 9bc6/07JZwKnipBp5+5dK4vx0sFqvX8PqkUKU2irjPJXh+5lG2C8yhZYF3kTMhR/+0
	 pDGvf3o6iVJyP/6Wx5FOIH9/0RQabRa6HDmdvLudXmG9362Tbv+mwUtEq3ODlxmV2x
	 Jvi1PcZJA0rp4AffIGyL2pnajpS0DrS+yPySxiLCgBaeGRkCVNFPOy3QG3bfW0k677
	 S1hodehu8qkcA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C40E141A2D;
	Mon, 29 Jul 2024 21:11:01 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Mike
 Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] docs/core-api: memory-allocation: GFP_NOWAIT doesn't
 need __GFP_NOWARN
In-Reply-To: <20240729140127.244606-1-Dave.Martin@arm.com>
References: <20240729140127.244606-1-Dave.Martin@arm.com>
Date: Mon, 29 Jul 2024 15:11:01 -0600
Message-ID: <877cd3aopm.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dave Martin <Dave.Martin@arm.com> writes:

> Since v6.8 the definition of GFP_NOWAIT has implied __GFP_NOWARN,
> so it is now redundant to add this flag explicitly.
>
> Update the docs to match, and emphasise the need for a fallback
> when using GFP_NOWAIT.
>
> Fixes: 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
>
> ---
>
> Based on: v6.11-rc1
>
> This change also evaporates the apparent typo of __GFP_NOWARN without
> the underscores in the documentation, but that doesn't really feel like
> it merits a dedicated patch.
>
> Not sure if this really merits a Fixes tag, but the docmuentation
> update might as well be picked into trees that have the corresponding
> code change.
>
> ---
>  Documentation/core-api/memory-allocation.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation/core-api/memory-allocation.rst
> index 8b84eb4bdae7..0f19dd524323 100644
> --- a/Documentation/core-api/memory-allocation.rst
> +++ b/Documentation/core-api/memory-allocation.rst
> @@ -45,8 +45,9 @@ here we briefly outline their recommended usage:
>    * If the allocation is performed from an atomic context, e.g interrupt
>      handler, use ``GFP_NOWAIT``. This flag prevents direct reclaim and
>      IO or filesystem operations. Consequently, under memory pressure
> -    ``GFP_NOWAIT`` allocation is likely to fail. Allocations which
> -    have a reasonable fallback should be using ``GFP_NOWARN``.
> +    ``GFP_NOWAIT`` allocation is likely to fail. Users of this flag need
> +    to provide a suitable fallback to cope with such failures where
> +    appropriate.
>    * If you think that accessing memory reserves is justified and the kernel

Applied, thanks.

jon

