Return-Path: <linux-kernel+bounces-371604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A55EC9A3D37
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658D0283691
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11EE201029;
	Fri, 18 Oct 2024 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JG1myLJ3"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F2A15CD74
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729250584; cv=none; b=XOdz9TAVAKdskrXWq8lapWW/fiNwemk3wv4vdIPBSyKaG63XsVCQbLcnzowKRkaIrnAg3cKS/picetHZfCm8PnSL7WU1CR5O8PxZMw+yhPgwYjmYixWKQqWxiC29mYGT3r/2b50gE5wAd7H8b6IC08BRY4B1HzBr4kUmml/9G54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729250584; c=relaxed/simple;
	bh=RERqlDyQR8kTR9BwGb4+LARBFzifqaO5Mnzgssa0r4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRujLc9DdNaiI/268yOApEphgIKiB9ZFpNWP8Q/S5r4xYv2XhWx54tRPb2vYYbRiExByvx9YhSJTVNFNMs8T763tJI8aP8lGIxjevW0tBBD6OPHA60dqpdTm/RUJjyeqwFNsjYfKnoB1nweqOqs0H0kc7VSy2kZttJt81/oHLO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JG1myLJ3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TnBUWYJksQc4i/FZQZ9o3c/s3FDZm+jk3UrFtSiyKAQ=; b=JG1myLJ3XSVvAmiWTzwlQLF8Q/
	3iwPXwdb3HY+i7dlz8H35wxN3QtTc6eD9MCNn0NcDEzPCjxVEZ8QoyluvXXZBMY4REGKKMbtwmxSa
	VURdbkuWvYik/3+8Qghd53SqajnieqwG2D0x74cmHfQzq+ZbziTSOP9fSYpEqsaHesiEdZqeqj/Jt
	eEjyZeBtCePwiXCSFrG6zDZ5pd9/1WPesDgQukSPCqhgK4THbuD8toyG+tp8m0AvuKGTv70FDHRi9
	JENGp2H/Mo77D/MV4Em8qOO/I8iY4x/Bb6IxuxfkZooop+b6ifZ4R5lPJR26Z39WanZHrzVzFOshM
	lpcYVxgg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t1l4O-00000007LHx-1iaJ;
	Fri, 18 Oct 2024 11:23:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D06C63005AF; Fri, 18 Oct 2024 13:22:59 +0200 (CEST)
Date: Fri, 18 Oct 2024 13:22:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -tip] cleanup: Remove address space of returned pointer
Message-ID: <20241018112259.GD36494@noisy.programming.kicks-ass.net>
References: <20240819074124.143565-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819074124.143565-1-ubizjak@gmail.com>

On Mon, Aug 19, 2024 at 09:41:15AM +0200, Uros Bizjak wrote:
> Guard functions in local_lock.h are defined using DEFINE_GUARD() and
> DEFINE_LOCK_GUARD_1() macros having lock type defined as pointer in
> the percpu address space. The functions, defined by these macros
> return value in generic address space, causing:
> 
> cleanup.h:157:18: error: return from pointer to non-enclosed address space
> 
> and
> 
> cleanup.h:214:18: error: return from pointer to non-enclosed address space
> 
> when strict percpu checks are enabled.
> 
> Add explicit casts to remove address space of the returned pointer.
> 
> Found by GCC's named address space checks.
> 
> Fixes: e4ab322fbaaa ("cleanup: Add conditional guard support")
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>

Thanks!

Now lives in queue locking/core, and barring robot screams will make its
way into tip.

