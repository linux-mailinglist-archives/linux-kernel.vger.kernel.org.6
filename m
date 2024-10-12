Return-Path: <linux-kernel+bounces-362638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0021999B783
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 00:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3701C20F78
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 22:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C144E19B3FF;
	Sat, 12 Oct 2024 22:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RG8Yk8Co"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE2B187328
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 22:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728773010; cv=none; b=oDvT1ftIjqXzmehcKfVBO3C/sQwXfm3He/OVL/c8I5BPaJ6n4AMom+ihwP2OkJ/enUftFT8ABr+NcJQKwuOyouM/lYzgU8uY1LMnq/hHdKWuKOG302ywky5TBtxlXi7rLSDhGR79wzoPxBKo53SAQ96jELfmDXvgLJwStjpREHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728773010; c=relaxed/simple;
	bh=3jFqQBNpVUwRg0qqzJg9Z/ssOTaokRJaKPK5Qb8nrwk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pB6qs6kz4A/08IwXbpylcBkfUi0BaJ/RuyldrC/T5D4nrfVaWYJl2i0o3hVl3vtxtlx8mdzG9YyJz1LHupA5Bkcyu19kbZWaK6VT9cVQpQIIQqNXIfYCLIQrdonJEok89/pylvTx5mpO+w6GVddgltCF9VF4nYFK21R/hPzDegQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RG8Yk8Co; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F239C4CEC6;
	Sat, 12 Oct 2024 22:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728773009;
	bh=3jFqQBNpVUwRg0qqzJg9Z/ssOTaokRJaKPK5Qb8nrwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RG8Yk8CoQJzkrKneL6NEZL3q0bJ6BABh1zXM4L85UnjG6Mhsmc9q5a332GcI/0/+c
	 Sy0DFF2buPwibDz5RtUKRT4JKsz3vMOWhOc2AR7q/cWuoA/wq9tQkDZN1U0VcZi4md
	 Oel3fPwbXDrTFifXG9MKy+iRagvUFjcS7jDwjSDk=
Date: Sat, 12 Oct 2024 15:43:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: alexjlzheng@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 alexjlzheng@tencent.com, MengEn Sun <mengensun@tencent.com>
Subject: Re: [PATCH] mm: make pcp decay work with onhz
Message-Id: <20241012154328.015f57635566485ad60712f3@linux-foundation.org>
In-Reply-To: <20241011103609.1992042-1-mengensun@tencent.com>
References: <20241011103609.1992042-1-mengensun@tencent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 18:36:10 +0800 alexjlzheng@gmail.com wrote:

> Subject: [PATCH] mm: make pcp decay work with onhz

"NOHZ".

> Date: Fri, 11 Oct 2024 18:36:10 +0800
> X-Mailer: git-send-email 2.39.3
> 
> From: MengEn Sun <mengensun@tencent.com>
> 
> when a cpu stops tick, quiet_vmstat may flush all the per cpu
> statistics counter.
> 
> while, the shepherd is needed those counters to kick the
> vmstat_work.
> 
> when a cpu in nohz with a lot of pcp pages, and do not do page
> allocating and freeing. the pcp pages of the cpu may not be hold
> for a long time
> 
> we make shepherd keep a eye on the pcp high_min and high_max

I can see what you're saying here, but it's hard to understand.  Please
spend a little time clarifying the text?  And please start sentences
with a capital letter!

> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -2024,8 +2024,13 @@ static bool need_update(int cpu)
>  
>  	for_each_populated_zone(zone) {
>  		struct per_cpu_zonestat *pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
> +		struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
>  		struct per_cpu_nodestat *n;
>  
> +		/* in onhz or nohz full make pcp decay work */

"NOHZ".

> +		if (pcp->high_max > pcp->high_min)
> +			return true;
> +
>  		/*
>  		 * The fast way of checking if there are any vmstat diffs.
>  		 */
> -- 

