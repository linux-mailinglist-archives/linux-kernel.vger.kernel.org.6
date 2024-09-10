Return-Path: <linux-kernel+bounces-322525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D86C972A46
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4841F23DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CD517C9B9;
	Tue, 10 Sep 2024 07:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vVSTO2TF"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10DD18309B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952112; cv=none; b=ZCACiO7/PcUUzPqX4bIo9JCkbssPYDTKetM2T0RJ+klErn6mkdNz6XUDh+ZNNAs+IAh382VnIUwDll73iA8gseBxKxJdqfKOjpGmboxNu55/4qiauXBlZ2P+KcMZYGfeSGVYg/v5DLOEENMcK5FDzINeq+cIJY3w/ZqGmKN0gMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952112; c=relaxed/simple;
	bh=OLklJSVQNOQI9DT75fzTGObFLfetL3kq3g7TnME/nQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRC71jOJiAVrDgYjhhwdzcluJHT9oFplaiPH6Ixiu5StbkfMq0VqOtlWwopp9c/ux6Zy6xbcq9JTGVOAx+U33LkQlZHDb5cxgPbx5PLOJXz2dQFxtlKFzIyWNU/kSbhwNsofTBI1pLE/I1NEy9suLfCN3+8ozQztuCk18tOULDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vVSTO2TF; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 10 Sep 2024 00:08:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725952106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vplBtqjlTg4eBgWma6lIzm6/3ie/7e5vk9lsOVwoc9o=;
	b=vVSTO2TFJfh1EBJG/XSokcOFNomrhN3BkYDziVC4NY2avzIdL6S/ILOCI72lp+3AsqkUmD
	IJkeVKGcSo68y2a+HxMZyf5W+b18idowDgAk3gy7qu1MQ1hnmkRuvVOi+EMIedD5CNhRAh
	7Rv1kTIzsdPeW7p7GQLEJ5U36BCkjeM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jingxiang Zeng <linuszeng@tencent.com>
Cc: linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcontrol: add per-memcg pgpgin/pswpin counter
Message-ID: <e5k22kuavnli72v3lmeezrewut6hvhfdpteouj3ii6dmcdiiin@2e3dlbs4ahe2>
References: <20240830082244.156923-1-jingxiangzeng.cas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830082244.156923-1-jingxiangzeng.cas@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 30, 2024 at 04:22:44PM GMT, Jingxiang Zeng wrote:
> From: Jingxiang Zeng <linuszeng@tencent.com>
> 
> In proactive memory reclamation scenarios, it is necessary to
> estimate the pswpin and pswpout metrics of the cgroup to
> determine whether to continue reclaiming anonymous pages in
> the current batch. This patch will collect these metrics and
> expose them.

Please explain a bit more on how these metrics will be used to make
a decision to continue to do proactive reclaim or not.

> 
> Signed-off-by: Jingxiang Zeng <linuszeng@tencent.com>
> ---
>  mm/memcontrol-v1.c | 2 ++
>  mm/memcontrol.c    | 2 ++
>  mm/page_io.c       | 4 ++++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index b37c0d870816..44803cbea38a 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -2729,6 +2729,8 @@ static const char *const memcg1_stat_names[] = {
>  static const unsigned int memcg1_events[] = {
>  	PGPGIN,
>  	PGPGOUT,
> +	PSWPIN,
> +	PSWPOUT,
>  	PGFAULT,
>  	PGMAJFAULT,
>  };

As Yosry said, no need to add these in v1.

thanks,
Shakeel

