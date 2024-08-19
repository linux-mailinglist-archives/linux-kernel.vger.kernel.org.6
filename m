Return-Path: <linux-kernel+bounces-293026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 238B2957855
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3961282404
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC59D15E96;
	Mon, 19 Aug 2024 23:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LVz/yNAW"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC8A15990E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724108741; cv=none; b=DkyOEwert/8eJKpHe/E3nBjuAr1QGkSoZNoPKZL0zhwy1JlQ1OUtoqQUPRR74Fm4/a+ACVESNZTOgVpjfyowjjkgh/RTaR7t5//TU0jjCQxfEYJVMN7PXdpqsVj0GK64b05CHSMoGk/DQRo8qsUeE0lQjE1W/Q7a6tlgcmcIUtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724108741; c=relaxed/simple;
	bh=q8DFKQ93bbQQWLQLjcZQxZkXYBIvvNZolau0fBAwipI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoWXo7QaSo6BsXcqiDF6sDVAlWjmzXcB1gO0cbSf3AaJKb83q+3M41jRxyyBMhbbwXQnaRtlxZ0ZW0z9cLO2Vr3Q4DGs4Lovo/vyeK12jT7O+Ksj8y/5jvvrxAxVc3jih4dnV9sX4pHWW75BcV6bByraOjsHy7tm6u2sSjqJ4LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LVz/yNAW; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 19 Aug 2024 19:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724108738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3kG+Xa+U5w5wwiqGK0IgD/Gy8U/ZZ5QyvaNGTPeU6TE=;
	b=LVz/yNAW2Cx8sJ3anbytxtdNhEqlM7QTRkdQtX+MXOFycJZ43YQw+3zkpO9vd1uhYv2oMe
	xtMzBEyN4AIm99G+keMM65LC1Ybu8o1cmd6l6a2fQgedEg4ULpfUEl85DJDQloRGk/S7mU
	aKU5DalHaPihs/Vg7pCzvQHT0Ehz8eY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 9/9] rcu: Switch kvfree_rcu() to new rcu_pending
Message-ID: <mc5lknkeda3nifrter5hdkqus7set2gnay4qhhvfxdml5o6axy@cnwuyybrizbc>
References: <20240819165939.745801-1-kent.overstreet@linux.dev>
 <20240819165939.745801-10-kent.overstreet@linux.dev>
 <b2f7b98f-0fcf-4fdf-82df-eb15f5a040e7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2f7b98f-0fcf-4fdf-82df-eb15f5a040e7@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 19, 2024 at 03:18:02PM GMT, Paul E. McKenney wrote:
> On Mon, Aug 19, 2024 at 12:59:35PM -0400, Kent Overstreet wrote:
> > This nets us a slight performance increase, and converts to common
> > code.
> 
> How did you measure the performance, and what was the actual amount
> of the increase?
> 
> Either way, the performance increase needs to be verified by the people
> for whom the current code works well.  As noted a couple months ago,
> I am having a hard time imagining a tree beating a linked list of pages
> of pointers in terms of cache locality.  I added linux-arch on CC in
> case I am out of date on how computer systems work.

The point isn't performance, I was just noting what I saw, and the small
performance increase just came from carefull optimization, nothing
special. The old and new versions are close enough to not matter.

The point of the patchset is to consolidate kvfree_rcu() and
SLAB_TYPESAFE_BY_RCU into something more general, and dare I say it,
something a bit saner.

