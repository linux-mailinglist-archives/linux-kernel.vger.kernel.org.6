Return-Path: <linux-kernel+bounces-372470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B9C9A48F8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B0F28415E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1791718E756;
	Fri, 18 Oct 2024 21:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ivEc+vnm"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0725976C61
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 21:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287303; cv=none; b=dm009sTzlCm2EBAvPwCaZXFQU5JiKRir9sI+7Atw++2y+PjgZbpyW9P5CmrzLI7Hn0SvsLS97irQur8843GFGg6jCuq3wgsywuBohANPKfMUaDVX7Pt0Vf7S0RpnCburT4gRKzLCefyqoa+28x/DpPMifLuZNfScEwFKf6ym7kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287303; c=relaxed/simple;
	bh=PMlZHNkq7GZjGVzz/mABrmdB4k8PswYcMuFOfNJ0bjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOqmlpKNJJHhuARijrXqyXTOk3htSzMJjsQQThPaw6gxlSPcDVIR+Vy4iSMyZAIt1/dhaShTWE/zbwq3flvpOjb5n0dKX66GWkKLqnYfI727/dtHVr5Iob7jESkLX/gFdwkoh3HvPrx1Yfm2ZAiHtJb1H6hCwHqKcRgh2HJ3rhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ivEc+vnm; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 18 Oct 2024 14:34:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729287298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hvC423U1n9cjJ+Cz4Y5WpHvfXoLa7fjRoh3nCRJpriI=;
	b=ivEc+vnmwNehe0JbqPgNJYuRggaGBJEIIBOklEXpayICxA8OyCOQNyyB7J0ElZXF+/T2qp
	LoNk3JDfMclh5gZNLwuv0axXm4nM1/Dlq57pYOhLARqZKLNfIUl95biehsYRfQNNOLcujL
	ArBydMUIyMDV+bOzNC2vupV5RzO2eio=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, lnyng@meta.com
Subject: Re: [PATCH 1/1] memcg/hugetlb: Adding hugeTLB counters to memory
 controller
Message-ID: <bhcxyl2xir27ds7jlcsncajathj6fbpzo5hoymdvb7h6a44gfu@lxdsu5up344n>
References: <20241017160438.3893293-1-joshua.hahnjy@gmail.com>
 <20241017160438.3893293-2-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017160438.3893293-2-joshua.hahnjy@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 17, 2024 at 09:04:38AM GMT, Joshua Hahn wrote:
> HugeTLB is added as a metric in memcg_stat_item, and is updated in the
> alloc and free methods for hugeTLB, after (un)charging has already been
> committed. Changes are batched and updated / flushed like the rest of
> the memcg stats, which makes additional overhead by the infrequent
> hugetlb allocs / frees minimal.
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

I have an orthogonal cleanup request (i.e. after you are done with this
work). Hugetlb is the last user of try-charge + commit protocol for
memcg charging. I think we should just remove that and use a simple
charge interface. You will need to reorder couple of things like
allocating the folio first and then charge and you will need to do right
cleanup on charge failing but I think it will cleanup the error path of
alloc_hugetlb_folio() a lot.

