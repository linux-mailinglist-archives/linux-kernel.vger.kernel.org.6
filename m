Return-Path: <linux-kernel+bounces-265936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC25993F7DE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22543283072
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197AF155A57;
	Mon, 29 Jul 2024 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ser8xwaf"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B0E15574C;
	Mon, 29 Jul 2024 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262942; cv=none; b=Of4Q119mHcPhleCq+9DQXhgSE8622m9fyLZwckz8/DP6yS7RHZewta1g28TMCCTtWzG7KsjhV5bnBvlMFc/kAOVUBaUYGDHuBoIEUwuNuGbjECh/G/YRH8J6dkqnmtxXxGwwucz1h19zkdw/GGpBcY1DpylYaDsGxxRxaAiWaMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262942; c=relaxed/simple;
	bh=mcGe54sTD5m6mrjn8OqGOGxSLwe26LZQ+XOwG2+U4Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oposB8GMghac2iY3E+5WFIBc9T+U5zTDF67xfdK2xbfe+QeWuSMVEgFV7ZTlhS8NvQL85l6Wyi5YNOrFSwqvgbP1gfkwoDdg68UpvVZnCTpnvQIt62f2kp1bauW2rOGG1S4ichK2kHGKt8jimKXZ4j73vUuocMzbXUqsyR/F9zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ser8xwaf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vyD221SM/OrwfROkZfJAo8aEFiDQQt9H1/Csmecg7Gc=; b=Ser8xwafpItMP2OMwG/tZ7dRg0
	jLok6PpxiG+RiJiRcJQG+Pxc3n8wavZzOzim6SHSLNIqFMZYNnn4TNgA82bTSl/UIRi+Fqy3hs6je
	FMtmk8W+sZwoFEPOR6kBQFLtzijczxqt3pdOHpKCoET6yrPbVt2Jtgc9bfRQ4ItPFxej/O1MGwon5
	0xHymvCPT/TFJ+pKQFPFvNLoqOflJKssTh97TKSoxwM00fuaAq9CqXdkWgyn+Rw0ZJiRKO7rr/CaV
	BQrKWXBgyMGx9ID8kzZK5rX/MVhYPRr/0xGsuablti+s8RUFVh0b4kBlQlneL3PZwwg1jZEhSZ1X2
	CsxfMhwg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYRGU-0000000DeKZ-26O3;
	Mon, 29 Jul 2024 14:22:18 +0000
Date: Mon, 29 Jul 2024 15:22:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] docs/core-api: memory-allocation: GFP_NOWAIT doesn't
 need __GFP_NOWARN
Message-ID: <Zqelmlk0cYyPzasF@casper.infradead.org>
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

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

