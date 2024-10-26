Return-Path: <linux-kernel+bounces-382835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A250B9B13D3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 02:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200611F22D91
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 00:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727B88488;
	Sat, 26 Oct 2024 00:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jPQKKQwP"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85F0217F32
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 00:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729902792; cv=none; b=XzNnyNFMQ+3+P1oKXIOLuOj3An8Tp/I2xW5Tz4NvLTVjx9KlqtpbdUtI6INq6YQG2AHV9iMlSzHxiaWLLfWDHwPCg6kS1J8s7Jp+RtJ8uUsqRsVVxoegjRshAfP/CnOMAve2X9y0HROBsKr6iuAmE0buQQOSEze8dZhBApXrhDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729902792; c=relaxed/simple;
	bh=bevm/msKxG0ZASAE9bztn+8ACoioKrGtpW6arcEJydw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEDbrqXzl9Ijc7Pov0e5gQBtw/bN9YXw7CXSpdUmn3L+R4w5skPsmZrk8eLDiwVdatj9avkO6kb0L6wevEphRn3SBxaUFSpOsYst9f/OUvuscVmWmukBPiu1+ym/Kju5pck51qHy8eNekKthbF+xyiSWSnJBBgdU9vdS46oqlwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jPQKKQwP; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 25 Oct 2024 20:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729902788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6Llv4FbyoG33Y7DRteVnp4ScBswVJHYQFtwtPYmSCQ=;
	b=jPQKKQwPAbQXjJrb6J2rqhMTUO+az+tcsjfp64+0nTheciBOBly3bepDidHBrjIbYFpKDR
	hbBEE4oU9k7f8IlmuWkfBNkp+97YHiQIdZFJjv265jPYOBQVk2qnTrBjXDQmxRKiju27T+
	kvtZIUmukSZhVNEk16fHwNa1yoq2TJU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Piotr Zalewski <pZ010001011111@proton.me>
Cc: Alan Huang <mmpgouride@gmail.com>, linux-bcachefs@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, skhan@linuxfoundation.org, 
	syzbot+005ef9aa519f30d97657@syzkaller.appspotmail.com
Subject: Re: [PATCH] bcachefs: Fix NULL ptr dereference in
 btree_node_iter_and_journal_peek
Message-ID: <h5zdujzogjjckpx56aa7y7zmhm6co53vg63jmrwpu55sqvpqb2@emwizh7eaij7>
References: <20241023072024.98915-3-pZ010001011111@proton.me>
 <09A7740A-3113-4ABF-8587-8E0A4231DD61@gmail.com>
 <udcnrneobxa2nmwg47jrks6j67bsulaw7s43oldd5l3ge5wunp@r5rzrwwgzls6>
 <6uve5q7c6o4bvuifa2klcwpussxpy5cvcjf2pqdezfuvneqjaz@kdj67a2ehnrf>
 <bYeu9DQqsfsNY3FFRdkXqypW-RCyXXx63_QipilBHZIJDJluqBfaaSpO4YkudfinbGDsq91vJFmvQOge3BFGL5AkUqswR4eIpGwbwz41fIM=@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bYeu9DQqsfsNY3FFRdkXqypW-RCyXXx63_QipilBHZIJDJluqBfaaSpO4YkudfinbGDsq91vJFmvQOge3BFGL5AkUqswR4eIpGwbwz41fIM=@proton.me>
X-Migadu-Flow: FLOW_OUT

On Sat, Oct 26, 2024 at 12:23:40AM +0000, Piotr Zalewski wrote:
> 
> 
> 
> 
> 
> Sent with Proton Mail secure email.
> 
> On Saturday, October 26th, 2024 at 2:16 AM, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > On Fri, Oct 25, 2024 at 08:11:50PM -0400, Kent Overstreet wrote:
> > 
> > > On Wed, Oct 23, 2024 at 03:33:22PM +0800, Alan Huang wrote:
> > > 
> > > > On Oct 23, 2024, at 15:21, Piotr Zalewski pZ010001011111@proton.me wrote:
> > > > 
> > > > > Add NULL check for key returned from bch2_btree_and_journal_iter_peek in
> > > > > btree_node_iter_and_journal_peek to avoid NULL ptr dereference in
> > > > > bch2_bkey_buf_reassemble.
> > > > 
> > > > It would be helpful if the commit message explained why k.k is null in this case
> > > 
> > > This code is only for iterating over interior btree nodes - k.k is only
> > > null when we have a bad btree topology (gaps).
> > > 
> > > Piotr, could you add a comment to that effect?
> > 
> > 
> > Actually, not just that - when this happens we should flag the
> > filesystem as having topology repairs, and possibly start topology
> > repair.
> > 
> > Calling bch2_topology_error() will do that.
> > 
> > We definitely want to log an error message, too; it should reference the
> > btree node we're iterating over and explain that it's missing child
> > nodes.
> 
> Thanks for the clarification. I will send v2 tomorrow :)

Also, make sure we're returning an error code - your patch didn't do
that, we (obviously) can't continue the btree lookup.

bch2_topology_error() will give you the error code you want; the error
code will tell recovery to rewind and run topology repair (if we're in
recovery) or else something otherwise sensible.

