Return-Path: <linux-kernel+bounces-215107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA03908E38
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C7228D311
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C911B012C;
	Fri, 14 Jun 2024 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vgW65Jd8"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4431181D1F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377400; cv=none; b=jOAmbMwwaffWZAZmW7NWbVQai85WdimIJYDRU7MDWHR9gV/KGGPyyU7qmN5fdAi822ytj9WzpvxcvwwL9AfpDh1NfukdRyMeuGAEM6vzQ58ygS1Z6oKb0IcEQ7yhFoEiFHvjyZL0JT+AkcEQy/00mGOzdGNAWLZdDEu30xD1NQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377400; c=relaxed/simple;
	bh=tbqO0nM73sxGeOhzCDR3cQjJBLpEqVEwNgHhiBQrnOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6GOtvWCOLkxRyKTqxCL5tY055v8m7x9oLDbyAaCekcuYDpeYDxHVSK9pjl8FrGpFIkfWGxTqsiaKUU+NaejTIDK5YULG+AKmhjbXLhH1bnl0P7ljeg5BvbzVpvW6gE6ii+zbc2rTk5vOuFa5K6WNlGRySkS5ccJBdnND1+oq0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vgW65Jd8; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: baolin.wang@linux.alibaba.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718377395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MkGNSxl+h9z5YLWRwO1nvyFUAAj208IaWD4lkOkSdJo=;
	b=vgW65Jd8yLdKDIVGxsjhfPgWlr30uaqU08jhcoEaAe56TzhobuoV8WAsiGt/N5HG2xLY3m
	rHe8wDF4dgaRE7t4+LWnFR0jNEeJPPOc0HMu3mJHPLVxbUJGEw/3GGQHaMZ+ztBp1EI/n2
	skOVz1ufzzPLMezwvXDQeIrr2wwBoLw=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 14 Jun 2024 08:03:09 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, hannes@cmpxchg.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: add VM_BUG_ON_FOLIO() to catch lru folio
 in mem_cgroup_migrate()
Message-ID: <tyduss47imvg725gvm34djfficzvdof6k2r2ump25jejbqwq2l@yv67li65phld>
References: <66d181c41b7ced35dbd39ffd3f5774a11aef266a.1718327124.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66d181c41b7ced35dbd39ffd3f5774a11aef266a.1718327124.git.baolin.wang@linux.alibaba.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 14, 2024 at 09:07:42AM GMT, Baolin Wang wrote:
> The mem_cgroup_migrate() will clear the memcg data of the old folio,
> therefore, the callers must make sure the old folio is no longer on
> the LRU list, otherwise the old folio can not get the correct lruvec
> object without the memcg data, which could lead to potential problems [1].
> 
> Thus adding a VM_BUG_ON_FOLIO() to catch this issue.
> 
> [1] https://lore.kernel.org/all/5ab860d8ee987955e917748f9d6da525d3b52690.1718326003.git.baolin.wang@linux.alibaba.com/
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

