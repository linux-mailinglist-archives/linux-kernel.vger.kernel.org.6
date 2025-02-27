Return-Path: <linux-kernel+bounces-537169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE5BA488CC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CF2B1882576
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568E426F469;
	Thu, 27 Feb 2025 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a5AoxiIH"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EB526E953
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740683578; cv=none; b=bY5IPqlrd8GR+8PLYJAYqKcYzlVGwjoCkYKBh28ZDUpUumpNikzsLBpxeCw19W9tNf7HkX/h4ygP/6b0PNZxjlqLeyphSih8E4CocegbUbmVI7ClVrp4XQxPAu+iNZGzTYSKCOXRwEOEP9gALA1PIhZM2Jx6HRJijlkD1zoTQco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740683578; c=relaxed/simple;
	bh=co3VcKDWj0Njuazgt6Yz2lw4OZPKhNdPrBACMvEL5kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txxhj/AqlBEqtJ6KxtC9/c6127sKbflcn500iw7pIEIJYRWcVepNXis8RlugM0p3Mc360NkhwiFIC6lCrhHQX+VPIVHLqVR62/nZ2MMcmGfYskYOIAueIItr2fbkGn/upMdJjq1CuzLfhQZKjBQZZ7KhaQ28Au85HYeVhPGAJCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a5AoxiIH; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Feb 2025 11:12:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740683573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4GOHQJk3YUfcrqiLzuEZ20VE/FeleMmsKoRU8HGkVGo=;
	b=a5AoxiIHHvuOHihCLev1Nj57wARcGYHOWa/1STY74zAUpgLnYSFO13r80jGDlpaSSHQlOZ
	JRHzkCYy1ifp5Tg5m83rM/y0YfhALiPNQ1GIvLX/5VV9Z6zoXy7KhDqZwfrQcjnSgYN6H8
	CygQpjlJW9nblnIOCVos5QT3CgNGplo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: ying chen <yc1082463@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: when the swappiness is set to 0, memory
 swapping should be prohibited during the global reclaim process
Message-ID: <5u6rwht2mdwi3t4x3r5gtelruihtvfak24ci32moh2v7z52a3g@qkr2jcjgh4dw>
References: <CAN2Y7hxDdATNfb=R5J1as3pqA1RsP8c8LubC4QxojK5cJS9Q9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN2Y7hxDdATNfb=R5J1as3pqA1RsP8c8LubC4QxojK5cJS9Q9w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 27, 2025 at 10:34:51PM +0800, ying chen wrote:
> When we use zram as swap disks, global reclaim may cause the memory in some
> cgroups with memory.swappiness set to 0 to be swapped into zram. This memory
> won't be swapped back immediately after the free memory increases. Instead,
> it will continue to occupy the zram space, which may result in no available
> zram space for the cgroups with swapping enabled. Therefore, I think that
> when the vm.swappiness is set to 0, global reclaim should also refrain
> from memory swapping, just like these cgroups.
> 
> Signed-off-by: yc1082463 <yc1082463@gmail.com>

It seems like you are still on memcg-v1. What is stopping you to move to
memcg-v2 and use memory.swap.max = 0?


