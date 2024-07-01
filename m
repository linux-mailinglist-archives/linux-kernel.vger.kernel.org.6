Return-Path: <linux-kernel+bounces-235416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 515B391D4D3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 02:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525AA1C20AD9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292C11366;
	Mon,  1 Jul 2024 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J3Y1lEDO"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8317BA32
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 00:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792656; cv=none; b=sLn+Jx+Ahxh3aCQRD1ONyz8iA+x3AjGKwjFhCEJt1+qvrTdL1xXyrGJMSfCtb2SusBtISMWejoqTYAtdDazvX5FSUfWWfI2IWkbxTkxVOYyS0C0m3gCfX5j8aefdUmQ/JGh8nkZkRnEMwyq4fINWWW6SaEg1r5hYJsdMZz41G4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792656; c=relaxed/simple;
	bh=MSDGdmCFNnXXOj6sst7sFQtnunwHzx06tOR+fw9RGKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoYb3H2LuC8U4K/fCSoh3mkWXRSpTJ76ySuBT6wQ+iJTIYVb44owr0p5LQ5q+I9Oi78LXpSFOrjL/8DcDS8kIv6kxGTb6RvomMYBsJTgoESQIW0rlwd0sSnYLPH7+1ManVUM3E5Jl8IC3qwvSVvRsdKvcJhgu+BbieRllDes22Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J3Y1lEDO; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: longman@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719792651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m2RizITCd0YeA67LIVIxZJb2AgG5jun9KIygHofoiTg=;
	b=J3Y1lEDOyKjBoFYxmSu0yQ+Z6ollIqwaOt79ZDq5aPfcKhKaDQcPUBsJw4nNEfQQ+M+okL
	jUIgVkdrOMd7vk282xfAkzDGrVeG4Rb74f2CARna5YOUvZ+++iZpojsuY6Hmh0mPRySMAq
	kXMVlDZsAhIdgtBtKk/BxUXoyRj3jfM=
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: peterz@infradead.org
X-Envelope-To: mingo@redhat.com
X-Envelope-To: will@kernel.org
X-Envelope-To: boqun.feng@gmail.com
Date: Sun, 30 Jun 2024 20:10:45 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] lockdep: lockdep_set_notrack_class()
Message-ID: <uvf4ilncakodvwmu6kbzs4lrxgeegtanhyhsk52xj7foil65jm@p54wibff6bgc>
References: <20240630051037.2785156-1-kent.overstreet@linux.dev>
 <016f2bd0-a192-4ec5-9c4b-d48e8e001cd6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <016f2bd0-a192-4ec5-9c4b-d48e8e001cd6@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Jun 30, 2024 at 06:08:21PM GMT, Waiman Long wrote:
> On 6/30/24 01:10, Kent Overstreet wrote:
> > Add a new helper to disable lockdep tracking entirely for a given class.
> > 
> > This is needed for bcachefs, which takes too many btree node locks for
> > lockdep to track. Instead, we have a single lockdep_map for "btree_trans
> > has any btree nodes locked", which makes more since given that we have
> > centralized lock management and a cycle detector.
> 
> Could you explain a bit more what the current novalidate_class is lacking
> WRT to the bcachefs lock? Is it excessive performance overhead or some bogus
> lockdep warning?

novalidate just switches off checking of lock ordering, but the fact
that the locks are held is still tracked.

bcachefs takes more btree node locks than lockdep can track, so I'm
switching to a single lockdep map for "this btree_trans has any btree
nodes locked" instead.

