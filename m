Return-Path: <linux-kernel+bounces-440591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A439EC16D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 02:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2A6284D5E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EB883CDA;
	Wed, 11 Dec 2024 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W8FXk+lK"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AB113AA2D
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733880008; cv=none; b=p6STk9qT04uxN/K7Nnu9cKd3x3akK2UZzO3rWsi11ZE8g9XoOjJV8WOFv5ZQFhs6E4uKbLHk3xSVF6swLF38H8QhQxHUJsUKrnMljbXGBkhlzIb82wWflotB2vLFD1O8CiThPDVodojdaSWNfVi2f3dSK54rDpdaN4Jafxcjrt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733880008; c=relaxed/simple;
	bh=mRSuzZVVbGNPLYAFIDAQ/M5Cl46LgpkiPDn60FS2ntg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwIbyvAbxfET0AF74DJ20uyVAuzrSpVZTgUdXy1EAIHlY2yEktAFRSjrlD/yK4zvd5MTGFh68KyJWbL/Sj+Ed5SJscalSW3FjYEErTLMopYgOeqJrADVssmNl3X64EV2ev7S24bVNUq83RcsmCVJ9QcZGkrOC+bksoMgUz24y1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W8FXk+lK; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 11 Dec 2024 01:19:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733880002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lUWYOlVWAIm6Lu6fcrGntawOmoLD0WlWfvbhYPm4nUs=;
	b=W8FXk+lKMiAvd1qSu7C7CfCIAfqGcVvenTagBYFoGooOJe0rWM/zAQcnjKZ6cGjpvKZVaX
	Fo4NODKoEk96GZ+AeNFle4IH+Ee51HEGkzXTBKBVgmiakBgid4S1LtkCUBodKMfW0fEtfC
	hiRmtXj1100sh5MnnQo93YurtIsGFro=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mm, swap_cgroup: remove global swap cgroup lock
Message-ID: <Z1jonM_FxZfhX6Vt@google.com>
References: <20241210092805.87281-1-ryncsn@gmail.com>
 <20241210092805.87281-4-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210092805.87281-4-ryncsn@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 10, 2024 at 05:28:05PM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> commit e9e58a4ec3b1 ("memcg: avoid use cmpxchg in swap cgroup maintainance")
> replaced the cmpxchg/xchg with a global irq spinlock because some archs
> doesn't support 2 bytes cmpxchg/xchg. Clearly this won't scale well.
> 
> And as commented in swap_cgroup.c, this lock is not needed for map
> synchronization.
> 
> Emulation of 2 bytes xchg with atomic cmpxchg isn't hard, so implement
> it to get rid of this lock. Introduced two helpers for doing so and they
> can be easily dropped if a generic 2 byte xchg is support.
> 
> Testing using 64G brd and build with build kernel with make -j96 in 1.5G
> memory cgroup using 4k folios showed below improvement (10 test run):
> 
> Before this series:
> Sys time: 10809.46 (stdev 80.831491)
> Real time: 171.41 (stdev 1.239894)
> 
> After this commit:
> Sys time: 9621.26 (stdev 34.620000), -10.42%
> Real time: 160.00 (stdev 0.497814), -6.57%
> 
> With 64k folios and 2G memcg:
> Before this series:
> Sys time: 8231.99 (stdev 30.030994)
> Real time: 143.57 (stdev 0.577394)
> 
> After this commit:
> Sys time: 7403.47 (stdev 6.270000), -10.06%
> Real time: 135.18 (stdev 0.605000), -5.84%
> 
> Sequential swapout of 8G 64k zero folios with madvise (24 test run):
> Before this series:
> 5461409.12 us (stdev 183957.827084)
> 
> After this commit:
> 5420447.26 us (stdev 196419.240317)
> 
> Sequential swapin of 8G 4k zero folios (24 test run):
> Before this series:
> 19736958.916667 us (stdev 189027.246676)
> 
> After this commit:
> 19662182.629630 us (stdev 172717.640614)
> 
> Performance is better or at least not worse for all tests above.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

