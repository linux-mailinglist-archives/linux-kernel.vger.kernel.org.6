Return-Path: <linux-kernel+bounces-411300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7949CF61A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 21:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BEC9B35856
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4BA1E2835;
	Fri, 15 Nov 2024 20:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m51T3t48"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831261E261B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 20:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701974; cv=none; b=E4TdPPsXp2OJLk2eWwl2qecJJKvN5QsNpJ3JusZet8s6LNxyKrC2mhFLxPn08hGx9xiupLICZpNnww7E6YRFx2qpt8EgvYzt1yPbX4ihvcok9Z9U3Dz4w0O+II+Q4NwGAQG9+IEdT7ZeKCcPilT3nU+u//4mgAomZ4yiALiDnFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701974; c=relaxed/simple;
	bh=No3tEv2Po4wOtfTaSzdDHm2nj44/Ix0K0nRqHcsJrdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbgoilkHoykeyIWIJz6UHe3DPS8obayXSjDzFqZm8YjIVNKiO51ytJhUb0wYTOl5LAGchgbyDv+JxBGqJT+rzUwsIm2MQPmctNaFo7LAW6jC5it8I3DOSyneFlI/rviMK6oJiXLysnFHjlwGPr7EgenDX6B9Yf9D4Jny7w3QPIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m51T3t48; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 Nov 2024 12:19:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731701970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0zAJGhchRoBADrhT+zd71hoHYOWBCEKuIklnr6QxgXY=;
	b=m51T3t48gnRHJd26lp/bv4kWcqiydqG9DeEgIC01PJB4T7HmmBCyak9KvElN5pIZR6Rp37
	+/N+hAIKTVE52pRWPyqnPQ8JxHhCPhXuo/POBm3q4q+Ty2MczovyNyYwcs4iB2h0p2mIZ+
	/TRoQVAs5aVVq34o0pMXZgHR6SMC7VQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 2/2] mm: swap_cgroup: get rid of __lookup_swap_cgroup()
Message-ID: <otbcl5dpbzvlyogebjo2cpc45ipuktr57ekbvk7ss65lxe63a6@hkyjf6vj2jnm>
References: <20241115190229.676440-1-roman.gushchin@linux.dev>
 <20241115190229.676440-2-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115190229.676440-2-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 15, 2024 at 07:02:29PM +0000, Roman Gushchin wrote:
> Because swap_cgroup map is now virtually contiguous,
> swap_cgroup_record() can be simplified, which eliminates
> a need to use __lookup_swap_cgroup().
> 
> Now as __lookup_swap_cgroup() is really trivial and is used only once,
> it can be inlined.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

