Return-Path: <linux-kernel+bounces-197738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675268D6E8E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575CB1C214CC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 06:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42915134BC;
	Sat,  1 Jun 2024 06:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SnMlZvS7"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127E017BD9
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 06:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717224473; cv=none; b=oIVUrJsmp965PLMA9gIg15lTuLVNlOw2ZGqisoMyukETDmepbvHgec/Bdgm9xtZpTwmw1qenwoH0w3ibBx4OJrB/c08lZ2yshA5k1LY2WDB8lvJbOKX6Z/AheKV29oLnhsPK+Mo6hGIZ5tnfy/rNm7SdUyr5G3f/NCH03ITUKmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717224473; c=relaxed/simple;
	bh=yD1y4aLy8D5qV53IkWkU03ouCcVezpWTp2WbHU8jqRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcgkxR1JErIXK77x8O1mSIAuIdNArfThgKF5bpW/KJPjDzQB77SGZfAiNFO1FnM9Ta/WUZlINiLW1zs2B1gafFz5JwD6wv06DlgNKefaRLw9GXwCTSdcBHzZV4cFr4jTafRsZ4IvI5NzV+bbjUInsktOsWfPujTkwfrzMOVaYxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SnMlZvS7; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717224470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sjLZZRzBZcTCQY3kC3rZ1Hok+tlDm5Px6KNoO2+Q8ls=;
	b=SnMlZvS7KOj0xhhJCHn+El31RwcaODxWUU61//d2H0RnO5zEf9Rr+PlMnX0X+904K+YKmD
	zHENlx9nL4F1M0jXyshhqT9bVFzX3OW+KNrPt9SoiylPJcOcVnanGG/MvHVmvYfyd5uny0
	DRPEpwoxKj8nHoMt35aL3o1778gm39M=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 31 May 2024 23:47:45 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 08/14] mm: memcg: move cgroup v1 oom handling code
 into memcontrol-v1.c
Message-ID: <73dfsckpotrrgmq3zsatinqwkfwpbid3eniegigonbsnz4ewl7@ywuahcwkcl3r>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
 <20240528202101.3099300-9-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528202101.3099300-9-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, May 28, 2024 at 01:21:00PM GMT, Roman Gushchin wrote:
> Cgroup v1 supports a complicated OOM handling in userspace mechanism,
> which is not supported by cgroup v2. Let's move the corresponding code
> into memcontrol-v1.c.
> 
> Aside from mechanical code movement this patch introduces two new
> functions: memcg1_oom_prepare() and memcg1_oom_finish().
> Those are implementing cgroup v1-specific parts of the common memcg
> OOM handling path.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

