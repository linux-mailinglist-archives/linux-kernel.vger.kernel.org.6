Return-Path: <linux-kernel+bounces-367272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4209A0062
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F7C1F2605B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D2618B484;
	Wed, 16 Oct 2024 04:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BIn4zwsg"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0441189BBE
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 04:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729054616; cv=none; b=oBYLgMBrJQEaZKqW2ILt2Wie7wOaPBMO/thyHx7p8KxUTbygye2WxlZfIs/9B8hmuEcEiA/MZc4Zypu9VocpmJPWCJvIURPq+y7pU5o80tkwv70mXR/VNmonWGr+W+7Kg5GXFQqqwoShMWIzY3uDrI+AhuuYSW7ra8fF/8blwks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729054616; c=relaxed/simple;
	bh=nHy84Y8CTYZVb4TV5CBRAhImO1xkcbqDChgNM3VOBqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RABfevU93tNtm4OFTkNzecwDdqhcs1AOL3JlIzsB3ePxljAEHzD7qZ+Ik2v9CnKtghPSxCkAtNuKGlCbW6lmYQ2FEipP59LKXrOe1FJyEJAT1ojDCI7hE8nj2yQhpXelGf7nv6HOciErJQEYboKX0+3dxLxlqJjZPmexnVHfPXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BIn4zwsg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aVmIGSz20klS9BwIwrqXLAa+YKrvR1eU4YmQC013FKY=; b=BIn4zwsgqexoDCuwPI98ylZZ1s
	AXIF288+7kSjgvl6Xi9cYsX10ZNj+lSxG11jn7YKHWh+P5Ag0EBk6QAuHlGyo8DrXK9Msv8TtclYA
	CHky/h7XFBXZuGZklLFNKXhuz5KFoWXf8XxB+F4kgnRRGH4W1+9oQbFKjtK0KYXChIomh+r+On55i
	ELMeqGMu+uBBsN6PU6zuExJLgLRKhvEmQ9oHpw2FvJLX1m6MdCXged+KqkmKZbFwJPdR6uIjsBUKF
	xtL0gJsrYoRuJAi9cI6nSAAnsg4eVMCOdDPF2yZg1PpYAalumDkMUUGoIOsIxGvbvES+IEIb+nQeQ
	3v1VtPyg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0w5b-0000000AWro-0Mzz;
	Wed, 16 Oct 2024 04:56:51 +0000
Date: Tue, 15 Oct 2024 21:56:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: lizhe.67@bytedance.com
Cc: peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC 1/2] rwsem: introduce upgrade_read interface
Message-ID: <Zw9Hk_9OO-Aqsshc@infradead.org>
References: <20241016043600.35139-1-lizhe.67@bytedance.com>
 <20241016043600.35139-2-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016043600.35139-2-lizhe.67@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 16, 2024 at 12:35:59PM +0800, lizhe.67@bytedance.com wrote:
> From: Li Zhe <lizhe.67@bytedance.com>
> 
> Introduce a new rwsem interface upgrade_read(). We can call it

It's obviously a try_upgrade_read, right?

> +extern int upgrade_read(struct rw_semaphore *sem);

No need for the extern.  Also please make any new advanced funtionality
like this an EXPORT_SYMBO_GPL.  That is if you actually had a modular
user, the current one is built-in.  (although we could use this in
XFS if it lands).


