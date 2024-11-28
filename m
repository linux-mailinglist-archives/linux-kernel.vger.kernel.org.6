Return-Path: <linux-kernel+bounces-424107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EA69DB0B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62632B21A1D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF6627470;
	Thu, 28 Nov 2024 01:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FKmA1PEC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639EF1DDEA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757124; cv=none; b=TqfSu/wVxP9zCjNyd/pJPLJ1jPJYRm/DkQi6sBX0tElukz3stvXZr0ilSFBujSNLRTlPYj5Fn5K7evE/rAmExmw5J49Zg/qk+ic/hMIWCYRl53V6hXO4wWqFdPsuB03AS1qFc3NnuZSKqYGm/H5fh2PLY78xqlzGKC24IE5z9gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757124; c=relaxed/simple;
	bh=Anhspd9SqZzR8iiUfhU6EYjKkHaNq9O5YRWJhZnC28g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XWaLOELPwJErxacf9ubmX9N/Il2XyKhdyJJOA4yjyw1jsRv0W7MiuaKmn790qOW3SwDN2jNk7qJaPe4cOBAkQaf3aqUIlCWBFwA0qVH66tDV2eTLV54zITrcHO8dwdDIpNTrAgeafIX9H6DfCKRWO9iR8kdk4J2FgutYfSUQ/Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FKmA1PEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCBAC4CECC;
	Thu, 28 Nov 2024 01:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1732757123;
	bh=Anhspd9SqZzR8iiUfhU6EYjKkHaNq9O5YRWJhZnC28g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FKmA1PECOI242VDYy4zgJCsCOffx2r+jLL5i517LV73xQVvmDiPS21Txl/9tkV2Dx
	 2gjO5WUFgMoZefdK7uqI/QJV0jVL0k1xGz2tgUre3xE9a7WwFm7XcyoVhxdQcoe3rA
	 rPColSQsqb7MkRWFNcz94Ww4JFDS5042LWNoeCtU=
Date: Wed, 27 Nov 2024 17:25:23 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko
 <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka
 <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kasan-dev@googlegroups.com, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH] stackdepot: fix stack_depot_save_flags() in NMI context
Message-Id: <20241127172523.b12b82d150aad5069e024645@linux-foundation.org>
In-Reply-To: <20241122154051.3914732-1-elver@google.com>
References: <20241122154051.3914732-1-elver@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 16:39:47 +0100 Marco Elver <elver@google.com> wrote:

> Per documentation, stack_depot_save_flags() was meant to be usable from
> NMI context if STACK_DEPOT_FLAG_CAN_ALLOC is unset. However, it still
> would try to take the pool_lock in an attempt to save a stack trace in
> the current pool (if space is available).
> 
> This could result in deadlock if an NMI is handled while pool_lock is
> already held. To avoid deadlock, only try to take the lock in NMI
> context and give up if unsuccessful.

Is it possible to trigger this deadlock in current kernels, or is this
a might-happen-in-the-future thing?

> The documentation is fixed to clearly convey this.
> 


