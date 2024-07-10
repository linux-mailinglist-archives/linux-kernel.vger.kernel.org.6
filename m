Return-Path: <linux-kernel+bounces-247386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14E492CEC2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0441C226BB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2AD18FA28;
	Wed, 10 Jul 2024 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wMZc9+h9"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AEF1B86F3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720605732; cv=none; b=AGUEI7TWkMeITvIhGkGVoUFHvv1KxqhcbqSKgWQbUesgXlUiNSgQbVeivlEjL9Xhn4WK0mOs7idO+uJE//HSynmQ7fqgYvFvi4Ekqzf3IPKf6TCjUdk99HHDS7M31DWUwuxWmMob3WDHbSGR0iR38WT0iDVP/zCZyRSCFxFR7d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720605732; c=relaxed/simple;
	bh=axahieEUpkDStuK5uw04/HqMX3E/NwACJQpjZwXlf+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bts+a2UR8AYjf69H9AXIDeGwqus9cLXFstm2fgMoZ3K18yiKevDfpll4wmiUs1+xjirtDvmbKy/2BrnkwAUhpRZgg2B6NQlPPTRfaJ8R1vI8BGXUqH15eHEYkhaQr3q3fKetnDPuYmlkGRpy3uqBhOlGfI35qtq1bvfSpHZr+0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wMZc9+h9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hCh7GQePJWsAfJ/69/17N9txU+qsCnjpL3nb1rtezh4=; b=wMZc9+h9iDCgRRQOUzJtyc/y/i
	+uedWOWK1b5bA4G901kzIriLQ3bSE8fQqLsIZ5jlmsFQa4oo791hErP8OOa0geDfv1RJbzZCTzKcp
	J5EJHQwddE7KteGJDzo3tfhwAsmbtTEB5nGZ9LWMW45QAxEpDWJwSyEWTnFjRuxf4zWtlUPVdP9Ar
	GnGZlT8r/ObQ+OoEZi4xsXy1IFhqU4SDmro9xfgkq7SUmiEDx/3wO/3KC3408DjFE4vMK08robU11
	Li9NEKce5fL4POKPI+vtf0gtPDp8EVKN+A8/3kwwHL/MW1WPYXCcq1XJDiNHzDbYfmfSJEPQI7okD
	lezta0Pw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRU9C-000000095Hl-3U0F;
	Wed, 10 Jul 2024 10:02:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4E0E3300694; Wed, 10 Jul 2024 12:02:02 +0200 (CEST)
Date: Wed, 10 Jul 2024 12:02:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, oleg@redhat.com,
	jolsa@kernel.org, clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH 08/10] srcu: Add __srcu_clone_read_lock()
Message-ID: <20240710100202.GU27299@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
 <20240708092416.010695534@infradead.org>
 <Zo4gtyzNvinXBOHU@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo4gtyzNvinXBOHU@Boquns-Mac-mini.home>

On Tue, Jul 09, 2024 at 10:48:39PM -0700, Boqun Feng wrote:
> On Mon, Jul 08, 2024 at 11:12:49AM +0200, Peter Zijlstra wrote:
> > In order to support carrying an srcu_read_lock() section across fork,
> > where both the parent and child process will do: srcu_read_unlock(),
> > it is needed to account for the extra decrement with an extra
> > increment at fork time.
> > 
> 
> We also need to dup the per-task lock held stack in order to maintain
> consistent data for lockdep, right?

Urgh, not the whole stack, but yeah, we need to stick an entry on there.

Let me see if I can frob that somehow.

