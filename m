Return-Path: <linux-kernel+bounces-316783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A27EA96D4DF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579EA1F296EE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD81198A33;
	Thu,  5 Sep 2024 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vsQH7WP8"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A13198856
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530230; cv=none; b=ut46UrnRLiQthJXEszbhZZ+LdxwyG/9hFZvVCUp9UDv593tdhKLywaGloXPZlm+00XyE+WXwkj4zRn6dvLQ1blDlStAjLo6yY1zmtAiaEqzdzjZTyaYTBk+5Qy3AaIVbMq4NBCFEMmQ8WmtjBrWGEUzpEw18GYxsm3yZK3rhY1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530230; c=relaxed/simple;
	bh=WOUyaQlK22gl63ndLjV532iR9uXuV8+zCzMOkrK95ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRhuB8GbyGW4ib/74+O7BHnExnWpqLhiR2xyPQ+vJZ3VjKE5OeKrAbyZZq3Y2EHRe32bQ9WhpFshRgVcnOYfRhQ9zcAOrGRKkFsSwn9spkz23/CbZvElviY+7AR6/kJm/FXngEjme9I1tB4DQxArNkG23Ti+y78hrdlBR3nuiOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vsQH7WP8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WOUyaQlK22gl63ndLjV532iR9uXuV8+zCzMOkrK95ac=; b=vsQH7WP8ot8oOYTpa6FYGee6H2
	tfnG2pT99UMa3D84i55PS3MHh39uHep6+tff7mwUrf8+1ikTecKcUn9LwBOJqLWxiw68Rtfjig4QU
	5CxVtri5Q3bB5GiA6oAsFxBQlj6f8r0YFstZXo9+Olh2Ps4ZVPC/lwS3lkWPYbpl1HYrSZoio6KJs
	O8GQyF90hpoh5HZ1kLFDVJXbAIxUMwWPmAfdxcO5LHDP7Y+/Culi6j7x5qBHhR2iD6K8qiYJxZLe1
	vtH0Z6LHcTz/dPOMH64VylLwrcFpswRfl4SwvlkNQjHvNS2hLvxSyohRK9+2QpyNGQVNTK1kIgKDO
	ZllyMklg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sm9Ef-00000002Cbt-1LRJ;
	Thu, 05 Sep 2024 09:57:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 39C01300599; Thu,  5 Sep 2024 11:57:06 +0200 (CEST)
Date: Thu, 5 Sep 2024 11:57:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 3/4] sched/core: have io_schedule_prepare() return a long
Message-ID: <20240905095706.GD15400@noisy.programming.kicks-ass.net>
References: <20240819154259.215504-1-axboe@kernel.dk>
 <20240819154259.215504-4-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819154259.215504-4-axboe@kernel.dk>

On Mon, Aug 19, 2024 at 09:39:48AM -0600, Jens Axboe wrote:
> In preparation for needing more state then 32-bit on 64-bit archs,
> switch it to a long instead.

I'm confused, afaict you'll need all of *2* bits in the next patch.

