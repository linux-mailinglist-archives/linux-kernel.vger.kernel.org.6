Return-Path: <linux-kernel+bounces-263760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E900C93DA37
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 332E8B21E10
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB803149E0C;
	Fri, 26 Jul 2024 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jAPv+8+o"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7C41859
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722029860; cv=none; b=bh0nxgZPCBEfZ89pUihx3j1am35XsMZuWe0zZPt7usIuGR+Yct35fwIF/sxwygTlQow2a9W4ZAwEJNE/VzIRZoVPDmKLN9hNkIqV4gqa63TOZH1/0rFz2VgwzKKHsaxbcWWzZKaR63ofDZPVuFXS3x+Oh80zXy5v3xU06UWvpr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722029860; c=relaxed/simple;
	bh=8P4ojRzIkt1ZvPCkJDA0uA7TI9XKXu+s8frbuaDlVQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJpvOGTwBYfgaHlMrlZ00boX3jQuLsyAHs/if/1pCx33Kbdz6MrR7kCrlbg/QnjxBYui/i/gSQ27fX2WfHIq9aWB/GeV4ORT3+qrDNOYkc9fo3MAXu0/XX15qZ6umW3fsefMFXUueRGBBDgKsj9Qz98HyuFieDUadZVT6VkTvq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jAPv+8+o; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 26 Jul 2024 14:37:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722029855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P99i5QBtM7i6ThYxV+/35Zv+Vi6ayIksvhARpdzg4e8=;
	b=jAPv+8+oVlJyY1u/DZPH6nJSQPHXK+dxcuxm7LacUNmzx4fFDNjFHiC3kiybrVUPLKgWWu
	Oe6yrtpz/yR5dtqtfpzQEQjqAHjHofFIciBYO2or8rwLWPqdZwoMQTm6kcTTIllB24+fRh
	UZblJMIRKGQAQIEwMAjf90eBHXi1/20=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v3 3/3] mm: page_counters: initialize usage using
 ATOMIC_LONG_INIT() macro
Message-ID: <rlg2wtr2b3l4gdtaga4vaz2v4xzkdc75q35uau4wxlhi4vodlf@nfrgh3tgyhvn>
References: <20240726203110.1577216-1-roman.gushchin@linux.dev>
 <20240726203110.1577216-4-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726203110.1577216-4-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 26, 2024 at 08:31:10PM GMT, Roman Gushchin wrote:
> When a page_counter structure is initialized, there is no need to
> use an atomic set operation to initialize the usage counter because
> at this point the structure is not visible to anybody else.
> ATOMIC_LONG_INIT() is what should be used in such cases.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

