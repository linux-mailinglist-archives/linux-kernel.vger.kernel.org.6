Return-Path: <linux-kernel+bounces-236902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6B491E865
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D8B1C21CE3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A99316F830;
	Mon,  1 Jul 2024 19:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fPMoTcqe"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E606E1E49E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719861444; cv=none; b=oH0Bb37L9PAKvCb6y9+nCPY5af2jAIqU93qGBHEGPq66OqAPxXsFdpxFi/pJBoWGlV4TRgpfy2AIRoPq/axz2zKgB7us2K9Ntvb9lbFAxAn5mRzd5DdK7ZenqGOVd40wleJJzSKeTYju0mhNY4Ful2FFJkuJz4etz6jdl1JhVXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719861444; c=relaxed/simple;
	bh=ddr01kvdyYeRrNarptiGu1P/V4UXguay91c6lhy6x88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3LW0Dvj/jkFtD8TCTHQU57x9g7grPlIX1gNkKK6CmHuSusFzu1w8d2chlFBjT36o8Rni0IL5ZHKK4xOFokzuq0eby9VK1qWr5K26geCvRX+XEBqOLvfnhY46LAlqM+5693K39kBVwvUQqvtE85uJ2mG+KjR7QMUUc2Kc+YlwhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fPMoTcqe; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719861440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PeE9dgDI6Gf1qpgn+rpp8XSSTLcwPqBaU4XSTVPMACs=;
	b=fPMoTcqelGVPhPgnRrQHDsou0dYmSMaSGo2yAqlDKRqgWmn8sihTwQhIepGILXRb+Kxw0l
	y575AYHSOKG/PSY+xqxYYjBxH0f8u1f4SDDD+i+xPOuPiJDwqm83v8XUK4Jm1Hr6qWIl0z
	Oo+xSfkw947/CN6nOzphb0j5LaPJT18=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
Date: Mon, 1 Jul 2024 12:17:16 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH 2/2] mm: memcg: add cache line padding to
 mem_cgroup_per_node
Message-ID: <do4voq2q2ixruqfe4xydinkfvoxvv6mxw5homf75arwqxn2p5t@hqsar2jsm2wg>
References: <20240701185932.704807-1-roman.gushchin@linux.dev>
 <20240701185932.704807-2-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701185932.704807-2-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 01, 2024 at 06:59:32PM GMT, Roman Gushchin wrote:
> Memcg v1-specific fields serve a buffer function between read-mostly
> and update often parts of the mem_cgroup_per_node structure.
> If CONFIG_MEMCG_V1 is not set and these fields are not present,
> an explicit cacheline padding is needed.
> 
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

