Return-Path: <linux-kernel+bounces-520669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EFAA3ACFB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2309F3B0C91
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 00:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F907849C;
	Wed, 19 Feb 2025 00:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FTphuxgJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791792F41;
	Wed, 19 Feb 2025 00:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739923951; cv=none; b=gY5WUMx1GElw7lNZ7f/kYNykQ07VAfXqjYXLgxit4A8Ym3rZyP9NiZ8GXRiHPnf+gtn92vJYgcocFByWjNPVBSGdGHnH2q0LyoyxUm4bpLHOYiP9vBT0lIyGng/LTJoPu6UOwj3pBsDs8rg4XghGHU+8DTdoMJZ2buzI022rzfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739923951; c=relaxed/simple;
	bh=4vU+jAZCyIj138jlg1feUEkgeBMxxOG8TaKKka41GUQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=H43PA/6Ya1DZ8Tvo2qEPrQb8GHItDkwdDYRc2TJrkv9E6llJOQlFzLUMZjFkGSxjdm8P5kWZBTrZrvxwsjdDpcW9DWIem0AcTpaUDyr784d/b43AiWbpof+HuZf+L6mlNNYRrbrxjjUq4Tb2m5PMrwFpnMThG31JF2y2Wph3kGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FTphuxgJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE70EC4CEE2;
	Wed, 19 Feb 2025 00:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739923951;
	bh=4vU+jAZCyIj138jlg1feUEkgeBMxxOG8TaKKka41GUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FTphuxgJE0UTh8PLcD1oFET7CshqFUo+ne0otEwBcka6XiIj1/OnI2DZOhvbneYI8
	 Hr6gmB2RhTBBcK2568Kxnj++uNIjl898ihhMplDhnxWZGCQp0+yB5TWAiIa8JOsEoL
	 PzYRxtYSRN1ynOSEWp5lc0syKT+uF25szPC8iVyc=
Date: Tue, 18 Feb 2025 16:12:30 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org, Alexander Potapenko
 <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov
 <dvyukov@google.com>, kernel test robot <lkp@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] dma: kmsan: Export kmsan_handle_dma() for modules.
Message-Id: <20250218161230.0d06d45190b1ecdbf9e97564@linux-foundation.org>
In-Reply-To: <20250218091411.MMS3wBN9@linutronix.de>
References: <202502150634.qjxwSeJR-lkp@intel.com>
	<20250218091411.MMS3wBN9@linutronix.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 10:14:11 +0100 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> kmsan_handle_dma() is used by virtio_ring() which can be built as a
> module. kmsan_handle_dma() needs to be exported otherwise building the
> virtio_ring fails.
> 
> Export kmsan_handle_dma for modules.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502150634.qjxwSeJR-lkp@intel.com/
> Fixes: 7ade4f10779cb ("dma: kmsan: unpoison DMA mappings")

It's strange that this took a few years to be noticed.

Thanks, I added cc:stable to this.


