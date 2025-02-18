Return-Path: <linux-kernel+bounces-518622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F17A39213
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 05:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619E216B1A1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 04:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF13E1A2554;
	Tue, 18 Feb 2025 04:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T1GPH2K9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A426157E6B;
	Tue, 18 Feb 2025 04:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739852489; cv=none; b=qtvCuZhPFqY+EihURmvQv4iMTDgtgIJ/JM98GhNORtcCOmQjhkl/k/YJ5+lnAgPxtHx+aHR4ZLuxwhwHasZlvdYTdG7Qa3D7J2Y8yh+MwWqKmfoC0Vl99S/4DzvZ18B9unaF7yg5WMAaPDvdRSKNfrm56Aph3Npw1KWUag/IjwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739852489; c=relaxed/simple;
	bh=Y1WjWrYTI9mRHUBKbBcEKfoQLokHCNSELxid2QG5Cfc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ojyQ7j9s6QoqpYfc4cw0e+kvXg4UTUYU62XD78XRL9W3G+rq0RTluQyZDlfCjKxAAdh36XFMcJoMKOA4KTV2sxYjfkA50fgLwEkNps8xlzUNjSClThTLjwuMDAI8XuL1H1jJmj58MoEPGh78Vvb0toA5JaIyTf09pfgaYp2Y17Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=T1GPH2K9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4619DC4CEE2;
	Tue, 18 Feb 2025 04:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739852488;
	bh=Y1WjWrYTI9mRHUBKbBcEKfoQLokHCNSELxid2QG5Cfc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T1GPH2K9XHsElMReQc3f1esMMdNpUNC1G/+/KFFdRGdxzbdGY2Xrg72Sr2h0Z+UwC
	 6dLWVcuON2eB98DbKqWD5RiAdmf2HfZfcEaSgGuF3VP51kOPG4UhmBFlmlLmlmi+hl
	 v8Ix512h63FgzcNXc36TiQJP66GdEJFdjTUkMaGA=
Date: Mon, 17 Feb 2025 20:21:27 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: kernel test robot <lkp@intel.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, Linux Memory Management List
 <linux-mm@kvack.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 "T.J. Mercier" <tjmercier@google.com>, linux-riscv@lists.infradead.org
Subject: Re: mm/workingset.c:621 workingset_update_node() warn: unsigned
 '_x' is never less than zero.
Message-Id: <20250217202127.cf92afe2c0a89d5865e1811b@linux-foundation.org>
In-Reply-To: <202502160323.ZLUfooA0-lkp@intel.com>
References: <202502160323.ZLUfooA0-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Feb 2025 03:56:06 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7ff71e6d923969d933e1ba7e0db857782d36cd19
> commit: 4715c6a753dccd15fd3a8928168f57e349205bd4 mm: cleanup WORKINGSET_NODES in workingset
> date:   9 months ago
> config: riscv-randconfig-r073-20250213 (https://download.01.org/0day-ci/archive/20250216/202502160323.ZLUfooA0-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 14.2.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202502160323.ZLUfooA0-lkp@intel.com/
> 
> New smatch warnings:
> mm/workingset.c:621 workingset_update_node() warn: unsigned '_x' is never less than zero.
> mm/workingset.c:746 shadow_lru_isolate() warn: unsigned '_x' is never less than zero.
> 
> Old smatch warnings:
> include/linux/mm.h:1306 virt_to_head_page() warn: unsigned '_x' is never less than zero.
> 
> vim +/_x +621 mm/workingset.c
> 
>    617	
>    618	void workingset_update_node(struct xa_node *node)
>    619	{
>    620		struct address_space *mapping;
>  > 621		struct page *page = virt_to_page(node);

We're seeing several reports like this.  It looks like the RISC-V
virt_to_page() (actualy __pa) implementation needs some attention.


