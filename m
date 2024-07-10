Return-Path: <linux-kernel+bounces-247567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D1092D143
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA751F2313D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCFE190045;
	Wed, 10 Jul 2024 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EtFJ3cN1"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A53084A35
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720613129; cv=none; b=q0IzuZMkzeebPKBdYByM6at9CDr4zYY0CVg26dnCCN/+NhftqrdplE1sd5vlGWZbFvsKmHoTb8MXwPRdm42lOyesjHU2/NNajNzxOJKTEKIbfRSjiJDIPE37OYbt7ADOLNvog4VlIlBTfdfcTEmqZhGc0aqEVYtFcu7cqNily9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720613129; c=relaxed/simple;
	bh=cwYrQDVubfmHIIQTxf/oakGcgeCXhp5ZT1iYvn/NvHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6/qwxksH3tdBZW4gxzDMB2eyzQZ/i3CG9Ev+JUvOpVXMbyjPhQqM6Q/j0+lEzAXLPTU8K1jc7dfyTBJyNUO33P9R5AjgCTbidLt8HKj8atarQQqZlIeaWGgawzxU04VzymgCeYf9VKs+yaDzsHeNeUwdmIJS7BBSstSat+AdlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EtFJ3cN1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Zb0rr64RAc9NH99bhfbrYCHxbMOUZzI99hc+h4zjp34=; b=EtFJ3cN1V3xN42fLGIDNeV0xJm
	DpsM5fNaWFp7k1cZfAUkPP09OuJWO8xXz83mq/8NgUeaZkvm4TtfTlR+iq90AH6jsVbZWhUzCCOoq
	8NJSYQAVRAXDorqSRofDP6lRBDcvX4xy8ENV2btsujizV86aPAXSdUZEa+NlkOlFUS9Y7XRtGlGC2
	ZMBHsDz0LvLRnjMzRH4bSENi+O6ftU2DSkeKeZZKh4/0qMdXJq88cfHNzJCHWdpLqeXKDLMPLuXSZ
	0pnLMcwJtACx+1+fzaMUW2DkMJoOqSz/nl4iI2otHvgFTOvcnFAaUoD6uTC3a09+j1w7a/1r4NYLO
	W7VC+wPQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRW4Y-00000009Dte-1b64;
	Wed, 10 Jul 2024 12:05:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 08C223001FD; Wed, 10 Jul 2024 14:05:22 +0200 (CEST)
Date: Wed, 10 Jul 2024 14:05:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, oleg@redhat.com,
	jolsa@kernel.org, clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH 08/10] srcu: Add __srcu_clone_read_lock()
Message-ID: <20240710120522.GG28838@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
 <20240708092416.010695534@infradead.org>
 <Zo4gtyzNvinXBOHU@Boquns-Mac-mini.home>
 <20240710100202.GU27299@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710100202.GU27299@noisy.programming.kicks-ass.net>

On Wed, Jul 10, 2024 at 12:02:02PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 09, 2024 at 10:48:39PM -0700, Boqun Feng wrote:
> > On Mon, Jul 08, 2024 at 11:12:49AM +0200, Peter Zijlstra wrote:
> > > In order to support carrying an srcu_read_lock() section across fork,
> > > where both the parent and child process will do: srcu_read_unlock(),
> > > it is needed to account for the extra decrement with an extra
> > > increment at fork time.
> > > 
> > 
> > We also need to dup the per-task lock held stack in order to maintain
> > consistent data for lockdep, right?
> 
> Urgh, not the whole stack, but yeah, we need to stick an entry on there.
> 
> Let me see if I can frob that somehow.

Ah, since this all is across userspace, the easiest solution it so also
use __srcu_read_{,un}lock() and ignore lockdep entirely.

