Return-Path: <linux-kernel+bounces-261593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7E693B99A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866FB1F222A0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 23:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63709143C6E;
	Wed, 24 Jul 2024 23:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dim9/0xJ"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FE7446DB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 23:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864728; cv=none; b=MYLWbdLZh78tWZMkuajZMSPxBJKonbCC6g9S9izYWsZuwvdJcHY9th94blUlGO692b3QeenvY0zte/pleR8MT0JblVY1i0jWStVie2kUjv9baLW5y8f+b25sUQNeqySwgLYiVrCJvjUZIzdk44N7SIyD3Ojl0i1zQPbExdo2hdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864728; c=relaxed/simple;
	bh=+nkNjjLOlzFzrnJO8AV8SjYmkvNTVez301hOgaFCQMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEClC4Xg5SCqBBgJYvFexrRlEphoYm89NzObsmQi8sNz3kfjrdtl2TONcdi/Twf8FGXdSfp0+dW8jjjisgsptEhQ3FVKDrc64wA3qOyTaeikVRcpMKwA3sddysjSoI7o8nqzg9lNzxy0y8XWaBNylw/FRYbViNonAMNKaZ6EXo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dim9/0xJ; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Jul 2024 16:45:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721864725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AI1TXTzhhjqS4/9WRTAg2HjObG04704T4GoRm6EnXwc=;
	b=Dim9/0xJnClF4yZEgMZEDkgUeELIDbb90gS+hREhzduhWNqEAMrKJTZ8R0vEvDng0q4jq6
	CRwrxN03b+DwPz/9XsZLPyRZ64qglV766gFROymx1FG3YVOct3ZF68AUlwySXBxajxRMnV
	lnNMpAQY76q8W9wDB13xBaDWUWUqXzQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v2 4/5] mm: page_counters: initialize usage using
 ATOMIC_LONG_INIT() macro
Message-ID: <ovyyzcutvovgur4gnhmzis5xvxi2y2okudqoc2drmxapoix6ux@jyebslweicgx>
References: <20240724202103.1210065-1-roman.gushchin@linux.dev>
 <20240724202103.1210065-5-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724202103.1210065-5-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 24, 2024 at 08:21:02PM GMT, Roman Gushchin wrote:
> When a page_counter structure is initialized, there is no need to
> use an atomic set operation to initialize usage counters because at
> this point the structure is not visible to anybody else.
> ATOMIC_LONG_INIT() is what should be used in such cases.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

