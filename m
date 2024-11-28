Return-Path: <linux-kernel+bounces-425128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5819DBDB2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 23:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D99F2B22152
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870BF1C4608;
	Thu, 28 Nov 2024 22:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IkZP0iEo"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B20CAD4B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 22:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732834118; cv=none; b=TqgoZ4Es7+TXTsQfr/oXL3erC1isrrcBI7q7jaWYrUMTcYMbSQ1GXrFI5UdSXY2xedwMmNFZr/4ETIarUYkerNY7vpc394BNvBjRGAtIkTd2JQwfqjTYNOzN5HNqtEo8oTaKDCpbLCir8ahQD/F9PU4JhKYm8p7h6b25CZ/bNzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732834118; c=relaxed/simple;
	bh=pTPfR/zW+kl4Z619+Cl2gt6nLDKBcuupRYquAn9SV9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFlDhyshvINK2QW5qW/7RVZueq/dpcXUD0ryMFPvK5X7NARTeBlUavsuayzmgjFQuXaSsEEBA89yX08tzIegHNtf7mZAiaEAhF6CLPZ1UwY7dcmTn0REmwYGnGV4hIf++1LnwoB5sEINc/azNt+PLoaAulP41UD66Rob+7aPDcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IkZP0iEo; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 28 Nov 2024 22:48:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732834114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PLXpKhmby6MhlJ9I7MRFv11XFxLUBQGGDIGpiY97KKY=;
	b=IkZP0iEo81kS3Xn2ZctYcc0GqBjl8YXcDaT0BE8wIsvu7s5jyvcZb3TvYt4W9BGN6+xJN/
	nnmZkXEeSbV7rGV3wgMUsbzzB6G62LhlAGRrryTA6zVHrtkivlWW2TjdeXyL45SwJVCPTc
	anFcjv7qnqrhEv1nKiEejdhgYCpYHmw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: John Sperbeck <jsperbeck@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: declare do_memsw_account inline
Message-ID: <Z0jzNx1UjIJuclIf@google.com>
References: <20241128203959.726527-1-jsperbeck@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128203959.726527-1-jsperbeck@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 28, 2024 at 12:39:59PM -0800, John Sperbeck wrote:
> In commit 66d60c428b23 ("mm: memcg: move legacy memcg event code
> into memcontrol-v1.c"), the static do_memsw_account() function was
> moved from a .c file to a .h file.  Unfortunately, the traditional
> inline keyword wasn't added.  If a file (e.g., a unit test) includes
> the .h file, but doesn't refer to do_memsw_account(), it will get a
> warning like:
> 
> mm/memcontrol-v1.h:41:13: warning: unused function 'do_memsw_account' [-Wunused-function]
>    41 | static bool do_memsw_account(void)
>       |             ^~~~~~~~~~~~~~~~
> 
> Fixes: 66d60c428b23 ("mm: memcg: move legacy memcg event code into memcontrol-v1.c")
> Signed-off-by: John Sperbeck <jsperbeck@google.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

