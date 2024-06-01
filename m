Return-Path: <linux-kernel+bounces-197726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E91C8D6E7F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD997B26D5B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 06:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CC712E75;
	Sat,  1 Jun 2024 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ll8GEtyK"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA07E28EA
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 06:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717223635; cv=none; b=MCAzHQ4EL3qyfSA5DEsEadlGPTrakG3mZi3L986aCGaBm0mUD9z1yA3tJg1wG4ffWoXZjPk2403JKmSBQ6D59LLzHeOJqspl1w53mxyvtXW0t3NsXibkLNnjYIV5yIjG25E7X7Qj6ZDOTGPzuTDUEV+97+gzzU4e7UMDSBFh1v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717223635; c=relaxed/simple;
	bh=2QF/nnbydiwBbBgg3EMekE3jzL8UxdQ2DQZh+XfISW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByBKhlS4s7W+zinOOepy/5yNRH+ndZqgkHRcRZ6MOuxQcfQFQmj/4VT3QDaO8PtoldYN2MjTv13fKxgh8vTD6fy1xiPIDJpiB9/ulIClpTAkmwFxAB0n4oitH1M+IEsYzDXUckUlzWkNzVhby6M0SdCP1Hl0fRsZJoTLdXT15tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ll8GEtyK; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717223631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EsG6D93BOxWJChAFk9t6t87YMq7GqVbu/s/KkXeOw6w=;
	b=ll8GEtyK/oRSIyPppRwO1dXJnpsrjRl+DuOu446eDo1KWJIn0df3nhUQKRnZDfTGOnwrkK
	fV5OEvdQzGHb9jTFv0j3DY1Q3yg7qLBMQ3fS5SAFzvNITLxmCYlm4otGFiRssOiMnB5YzR
	7QVxtcxg/5zfgAs2EAmYGyEorrqkfTk=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 31 May 2024 23:33:46 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 06/14] mm: memcg: move legacy memcg event code into
 memcontrol-v1.c
Message-ID: <q74ns35d6j3e5m6hx7t4cgoezvfhsk2nzi6ogmlh5ygsb3qdtl@zupnd2ngb4g6>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
 <20240528202101.3099300-7-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528202101.3099300-7-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, May 28, 2024 at 01:20:58PM GMT, Roman Gushchin wrote:
> Cgroup v1's memory controller contains a pretty complicated
> event notifications mechanism which is not used on cgroup v2.
> Let's move the corresponding code into memcontrol-v1.c.
> 
> Please, note, that mem_cgroup_event_ratelimit() remains in
> memcontrol.c, otherwise it would require exporting too many
> details on memcg stats outside of memcontrol.c.

In the followup work, we should decouple v1 only fields from v2 fields
and then we should be able to move mem_cgroup_event_ratelimit() to the
memcontrol-v1.c file.


