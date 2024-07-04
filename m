Return-Path: <linux-kernel+bounces-241754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8F6927F2C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2431C21EB8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 23:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F76A143C6F;
	Thu,  4 Jul 2024 23:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PuxhPCAB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D696F13D243
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 23:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720136135; cv=none; b=ddEQeA+ADRrmOhAcVlCH8fZkvJSgyRPc1sgLbrUp+TwxV1k4ad1aPH1SXSG3ja3sJxXNEScJ1uqIeca1HsOE/wzUKsvP+BhE4+W0pJZwbxPfp1WNxiowapBTgLhcAMGjNphAIcUpAFZXgYM7ecby72X9myKVHJSo95h7l+7EwEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720136135; c=relaxed/simple;
	bh=5JFAhc6aB5DXVBgfQpgN4i9vJyrF0WBFHXGt5PUEP9w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LcuiNc94P6qrmmROdceWiPNQjapQUWj2q33v/xs3iIm0xRSchBb30y+7GfTDnEV4FBdMvYgXqAx3oHzUxYceLf39/AC2EiBteB3zxeN6xe/Nku1UOAhVHn+2e11V9P3CmBuKMNn2fZezSbwEnTCHk15phP9dOGm2LjsQbapWFdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PuxhPCAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C85C3277B;
	Thu,  4 Jul 2024 23:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720136135;
	bh=5JFAhc6aB5DXVBgfQpgN4i9vJyrF0WBFHXGt5PUEP9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PuxhPCAB1OHAVni0Df2SLIVNfWo85uIVfxxMmPu81GiGnXfe7EXvXLd1rRwwNfMtj
	 meClQmWP92REbLF7+5MFzQt/Va4r3KtcxOBMJThYeiMzzD2PP8tmEYhD0GkfKdWbIq
	 R4bYp+ZJBcki2BPmFt28Iqa8u/sykSQG+NxYLz30=
Date: Thu, 4 Jul 2024 16:35:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Michal
 Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v1 6/9] mm: memcg: put memcg1-specific struct
 mem_cgroup's members under CONFIG_MEMCG_V1
Message-Id: <20240704163534.e82b0d4108ab70319781d6a9@linux-foundation.org>
In-Reply-To: <ug2qpeiq6jrtr4qtnblquiod7rgqdqsy6nfu5idnpxqwrzdq6o@mmbsul2g6t52>
References: <20240628210317.272856-1-roman.gushchin@linux.dev>
	<20240628210317.272856-7-roman.gushchin@linux.dev>
	<ug2qpeiq6jrtr4qtnblquiod7rgqdqsy6nfu5idnpxqwrzdq6o@mmbsul2g6t52>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 17:48:54 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> > -	/* For oom notifier event fd */
> > -	struct list_head oom_notify;
> > -
> > -	/*
> > -	 * Should we move charges of a task when a task is moved into this
> > -	 * mem_cgroup ? And what type of charges should we move ?
> > -	 */
> > -	unsigned long move_charge_at_immigrate;
> > -	/* taken only while moving_account > 0 */
> > -	spinlock_t		move_lock;
> > -	unsigned long		move_lock_flags;
> > -
> >  	CACHELINE_PADDING(_pad1_);
> 
> Let's also remove these _pad1_ and also _pad2_ as well as this
> rearrangement nullifies the reasons behind these paddings. We need to
> run some perf benchmarks to identify the newer false cache sharing
> ields.

I guess this is going to be a followup patch (please).

