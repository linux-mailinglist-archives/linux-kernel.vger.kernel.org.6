Return-Path: <linux-kernel+bounces-266050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9230E93F9D7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7EA2830E8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07BC1598EE;
	Mon, 29 Jul 2024 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dj5a63cS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022E58004F;
	Mon, 29 Jul 2024 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722268174; cv=none; b=c8UWLT3OpUL85nOEerTY/+3971/V5oQb3jhAgnUZkksyAUSxlCQ2gC2dMWapbR1Rtu7kjzoPdqf9bcMoCPkL4LM3rNT7vdrNFpQxSvra5pdv0XUlIxKaTk/5J7Jn6lP5iHg/CgkwdZREkheQDANFJnnqSZqBr9LJY61Ryf6+ENM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722268174; c=relaxed/simple;
	bh=VAj3v+wG9wBNMTEkCgxxZzjwJ6AAZHhLzPotQhyv9GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApHOEL+5upEmm/33q3I6/bxRreuCx6lN7+a1AiZZBNep5EsIR3TH1jyQtsCElacVok/H0OG2Gc/JPWDiMhpRoksuuerdkPTILnTaCkSEU2RHgPZIhGDpYZeq9Q+zbefHn6fxDXpBSa8vQONf0TJr7BpEsPIj+1EwJ6SOg2OuGxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dj5a63cS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4F1C4AF0A;
	Mon, 29 Jul 2024 15:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722268173;
	bh=VAj3v+wG9wBNMTEkCgxxZzjwJ6AAZHhLzPotQhyv9GI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dj5a63cSTAsUcDFTd5F6TqnDM6rsOwQ1GT06JH0Kteml1IFgWsCI/qlY4La58CSK1
	 B49Quw70QTfK0sie5ONyAcYD8/ec2ch8SO8Px7qHNOBy3itJ7WHyjXciRmeh31K4/i
	 42yGmG6DhCInFfgnLpuCxInN5FqsHEu3EuAJfgeoSiCiY9f+84zC3BPjkkPElRun9k
	 y5/A6SvYMcnIWC/+zc7gZGJLa6sPB60yFs/jgbudsfO7OIgmoQabz1nTiVIZ23pdFo
	 6bxgiATEFU7ScdymjJQVTpegGnFdGugXhI97qsXca9+yV1d1BKLMFPsUWs8Ab8JYW7
	 h1BzKDtfTXYNw==
Date: Mon, 29 Jul 2024 18:49:12 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] docs/core-api: memory-allocation: GFP_NOWAIT doesn't
 need __GFP_NOWARN
Message-ID: <Zqe5-FdsrjrK9shU@kernel.org>
References: <20240729140127.244606-1-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729140127.244606-1-Dave.Martin@arm.com>

On Mon, Jul 29, 2024 at 03:01:27PM +0100, Dave Martin wrote:
> Since v6.8 the definition of GFP_NOWAIT has implied __GFP_NOWARN,
> so it is now redundant to add this flag explicitly.
> 
> Update the docs to match, and emphasise the need for a fallback
> when using GFP_NOWAIT.
> 
> Fixes: 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

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
>      will be stressed unless allocation succeeds, you may use ``GFP_ATOMIC``.
>    * Untrusted allocations triggered from userspace should be a subject
> 
> base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.

