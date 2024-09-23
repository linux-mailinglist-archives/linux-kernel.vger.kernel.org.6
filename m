Return-Path: <linux-kernel+bounces-336109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE1797EF53
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC7B1F21E78
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EF119E975;
	Mon, 23 Sep 2024 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DVO4w1U1"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D74D28E7
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109267; cv=none; b=u6H1GNCgrC3BGqmuPV4HtTR1D3c7LRtOBspF9xM9LBkkeyB2s39W4xbI842ST3sUQMmsv8JEMSlLL+IFcoJb3Wz60OgqS/ycD8EpDSacUYieBvvla9OOPRvmI7CVHzjqaMbFeQfMnfFrYalMvHHqVkHf7/RrrpbXs3NbXX/Ny0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109267; c=relaxed/simple;
	bh=h4v9OYnRZNhMPn+5djLjpHSOScNpyCT0LoeVjQVY24w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orPFlJvM8aoKGMOxqForbYymXNft+XSpuCoPG8VC+5Z2kfmFTrOEHJmTfFq3oFkHE1WxJRHANIf1vdGXdSuRFDVDvzBu2rdDNrSt+XCjALNpEvjB3IYZUNHv7GwnoSz0FnWV2oFcnur+TwpEphWISgVhHrjmkPDx06kS61yjLFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DVO4w1U1; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 23 Sep 2024 18:34:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727109262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CgkOyvRzcQt8DWIWxTPwt0/lbMq45yhB4pZdSeTlzrw=;
	b=DVO4w1U1RlWamzPtBfj73uNHbpawrbsvYZJuW/z8NbaqpRa8yvNgjMKhPauHHvHvGxJa29
	118l47++JmY5ebEK5w9HdRUm+Hv+YK1RcN7oSPya/ysV9K1eBjcNAiFcblMeoP4RCpb9YI
	ddSMCpjAS5DXif7Ns7wqPK8TB2Mc0a8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Phil Auld <pauld@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Giovanni Gherdovich <giovanni.gherdovich@suse.com>,
	Kleber Sacilotto de Souza <kleber.souza@canonical.com>,
	Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Provide a sysfs enable_seq counter
Message-ID: <ZvGYjKAB07VJW7jq@gpd3>
References: <20240921193921.75594-1-andrea.righi@linux.dev>
 <ZvCKPkwwC9-o2dsQ@mtj.duckdns.org>
 <20240923104548.GA308802@pauld.westford.csb>
 <ZvGJ_xT2LhYJHQbZ@slm.duckdns.org>
 <20240923160007.GA313849@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923160007.GA313849@pauld.westford.csb>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 23, 2024 at 12:00:07PM -0400, Phil Auld wrote:
> On Mon, Sep 23, 2024 at 05:32:15AM -1000 Tejun Heo wrote:
> > Hello,
> > 
> > On Mon, Sep 23, 2024 at 12:45:48PM +0200, Phil Auld wrote:
> > ...
> > > It's not a per scheduler counter, though. It's global. We want to know
> > 
> > Yeah, the sequence is global but we can report the sequence at which a given
> > scheduler is loaded on each scheduler. That way, e.g., you can tell whether
> > a particular scheduler instance is the same one you looked at the last time
> > too.
> > 
> > > that a (any) scx scheduler has been loaded at some time in the past. It's
> > > really only interesting when 0 or > 0. The actual non-zero number and which
> > > scheduler(s) don't matter that much.
> > 
> > Not necessarily. e.g. You can also detect scheduler failing or being updated
> > for other reasons.
> 
> Sure, but the primary purpose is practically boolean. 
> 
> > 
> > > And it needs to persist when the scheduler is unloaded (I didn't look but
> > > I uspect the per scheduler attrs come and go?).
> > 
> > Yes, the load sequence number should stay persistent across all schedulers,
> > but each scheduler should report the sequence number at which *it* was
> > loaded. Note that this doesn't really change anything now. If you only care
> > whether any SCX scheduler has ever been loaded, you'd always look under
> > root.
> >
> 
> In my testing root is not there is nothing is loaded. 

Right, there's no root if no sched_ext scheduler is loaded. Maybe we
should always keep root present, or have a global counter and one
per-sched?

-Andrea

