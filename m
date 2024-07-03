Return-Path: <linux-kernel+bounces-239730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01B4926499
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 142D5B22716
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68688180A86;
	Wed,  3 Jul 2024 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AuLmbNGA"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD74F183082
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019595; cv=none; b=p2lHLhWjCWzh56I9+6GJ0wHhHitN4w7f6MSo5U4pdHQ/YxBwUCFUebNmR3QjUBfBY1G4Ak5SRC6p93n9G1aHRVgu1VE9LhzbQtbuNMWE35ByS9YTTV7IG3CggMQ/dWQd//QUbkhimg2YQjBo00R7KTosA+1GhzSgr5lrp8MFXIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019595; c=relaxed/simple;
	bh=kLGvhvJ1BFft2q2WOkw9CwoHgbOSnnQs8kam5fxr0Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyBauP0GGYU1Et/0ztEqbM4RTlbwDm0yUjtuy3L8Ggcz7VP8McGZIONnPLhzfGkZlxuU1uvl0QvjIqdiNZ1ivzOEdYhGYAz5wqBvKvV6GAvqY8XlpoeBQi5kGwqq1tOCSU91F7m6GmPc+7Ju9pozwHNRFzcGo/6jyd/yXLM1LCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AuLmbNGA; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720019591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2TVE147ScDSXAmnCz3k5fBC3GoQlHqoQWlOxSgb5OB8=;
	b=AuLmbNGAMf4yG3Jk68vJ+bYxrqV0hI0CutcX+SBzxEC4grXWogPM9/wL8oRFDF99n/BV7O
	2kuPDiHIq3jVmpOaKn1j87bYkZx2fA+D+07pxVy2+O0vV7CyF9Ji/cM56Zn786xjYqIEKr
	2pHWLR8womthhItsflOaPVo5MxsfXig=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
Date: Wed, 3 Jul 2024 08:13:07 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v1 7/9] mm: memcg: guard memcg1-specific members of
 struct mem_cgroup_per_node
Message-ID: <36ale2uu2krtis2uzya3pmpye4kaidkftm232cybqlsvovkj5z@xz4uowv5ajbm>
References: <20240628210317.272856-1-roman.gushchin@linux.dev>
 <20240628210317.272856-8-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628210317.272856-8-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 28, 2024 at 09:03:15PM GMT, Roman Gushchin wrote:
> Put memcg1-specific members of struct mem_cgroup_per_node under the
> CONFIG_MEMCG_V1 config option.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

