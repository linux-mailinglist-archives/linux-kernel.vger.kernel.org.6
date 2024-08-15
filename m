Return-Path: <linux-kernel+bounces-288503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 331B0953AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7B81F25DD8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EE713B288;
	Thu, 15 Aug 2024 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IJtNTPNz"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0544AEEA
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 19:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723750481; cv=none; b=LhGLpiATwNIn8dN8dyup+bPVyReVU2KTk6Y+H6lvpn3PW/uT3lF1t2sOvqHRTJ5r6jm+gSoAmCetvdwjpzADdz5Aboi2uDSlxSKwMHNII3ofIsLSdjFgP+V4eiOADA40UyJ20RNs87oKSeyu82vz5FT0h69bv2HyLyZm3BgK4lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723750481; c=relaxed/simple;
	bh=wmh+5u/NoknKVdww2Ij9XAmjKQSJXTj/O5xeSPlCzQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2bBecDDbAbP+I1LGB2pTCoNZqnT+JplLYxJaOywwxfmYJ/WXk7QG0aXS5l3j1drF2nD60SWMsXNUcetKqX5klULCcIyhevevb1qRT2A9R2u5QiV9TcPA4oBCTw+ANCO60AHMXXb698K0k2o15YmD5QBaeAgkJNRceY+wMiWrKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IJtNTPNz; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Aug 2024 19:34:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723750477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JX8hMzQyvTzhq1dmJHRzPorgDlX9GQbPr5AORp1ohCI=;
	b=IJtNTPNzSu0ieL/YMx9fnGOialFCiwR3A19CgU0DM1A8tqM9HgIKcKLtoYgSPWONvFHwAq
	lbnIhwsSFi8XMAacckAVG6Q8jRmU07uli16LW92LeaPj8S1s32NfTJWJyDY46rK4wq/+2R
	7255dzoZcSJ5JWIkxsaIVJxWb0/7ef0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	"T . J . Mercier" <tjmercier@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/7] memcg: move v1 only percpu stats in separate struct
Message-ID: <Zr5YSLdtHdFZoQQI@google.com>
References: <20240815050453.1298138-1-shakeel.butt@linux.dev>
 <20240815050453.1298138-2-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815050453.1298138-2-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 14, 2024 at 10:04:47PM -0700, Shakeel Butt wrote:
> At the moment struct memcg_vmstats_percpu contains two v1 only fields
> which consumes memory even when CONFIG_MEMCG_V1 is not enabled. In
> addition there are v1 only functions accessing them and are in the main
> memcontrol source file and can not be moved to v1 only source file due
> to these fields. Let's move these fields into their own struct. Later
> patches will move the functions accessing them to v1 source file and
> only allocate these fields when CONFIG_MEMCG_V1 is enabled.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  include/linux/memcontrol.h |  2 ++
>  mm/memcontrol-v1.h         | 19 +++++++++++++++++++
>  mm/memcontrol.c            | 18 +++++++++---------
>  3 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 90ecd2dbca06..e21a1541adeb 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -70,6 +70,7 @@ struct mem_cgroup_id {
>  };
>  
>  struct memcg_vmstats_percpu;
> +struct memcg1_events_percpu;
>  struct memcg_vmstats;
>  struct lruvec_stats_percpu;
>  struct lruvec_stats;
> @@ -254,6 +255,7 @@ struct mem_cgroup {
>  	struct list_head objcg_list;
>  
>  	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
> +	struct memcg1_events_percpu __percpu *events_percpu;

It wasn't really obvious until the patch [6/7] why it's not
under CONFIG_MEMCG_V1, but otherwise the series looks great to me.

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
for the whole series.

Thank you!

