Return-Path: <linux-kernel+bounces-565265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC04A664E8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD45189C233
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C9954782;
	Tue, 18 Mar 2025 01:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JlxOWMYI"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CEAF9FE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742260897; cv=none; b=f1gMjTTbZZfqsyDvQK+HPWw/c2/+NPkfxisWPjgN/1hdfSeaCYTHTtUoIbRWvBdv2RWyDDe0pJNvH1ojQL4R2AGVJYItxvVffFFOaPjn6Iig86EB5+LPTLODQjBpHuBn6pZCDrUcpxTOFtnsu519UjIHpn/WgS1BVHYGvLXpmhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742260897; c=relaxed/simple;
	bh=sBFHSQE0rn7e7JTbDXKyCjvKr68LfORNzz0Om/X/0M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niuTld9bWxCcSYTmZebkJvFX/IwH1wXiCnMWh4Nx9f7EZZUHQMUTCbgbMqFrkfDtpOYc9d0PlO74XA//0yxy1jxpgs8LDcyfg7+z4YgJ0aN4Q/GFaQiVYgASxUqS5frJemC7qASd8HXv/ywfqr7gYkvfpwtmLSueVTxxWG12IAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JlxOWMYI; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 18 Mar 2025 01:21:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742260883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2FBfPf825uoBgnO3IKpXBpQUjfyHkv9HhTBzal5/jU0=;
	b=JlxOWMYIsRLHvTktlD4cg62/b/Ze8GNm2i5K+/9eL6/f+EDBLeu8GR9yM7/WOl6lnmRX8E
	spPjHiZhhkR5i/qevx1dYRnQGFGNZYa8+5DAEe0DKVFEheehY/rkvSlhFpNInVBF5FaF2k
	wFTDd8P7wLCvVDVxnsKtZrRWk+lau74=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 9/9] memcg: manually inline replace_stock_objcg
Message-ID: <Z9jKjxtlMExbmLkh@google.com>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315174930.1769599-10-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315174930.1769599-10-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 15, 2025 at 10:49:30AM -0700, Shakeel Butt wrote:
> The replace_stock_objcg() is being called by only refill_obj_stock, so
> manually inline it.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

