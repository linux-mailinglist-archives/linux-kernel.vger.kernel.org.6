Return-Path: <linux-kernel+bounces-233054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CD891B19B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC05C285CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEDB1A08AE;
	Thu, 27 Jun 2024 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fv0cpirS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6865C1A01D1
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719524241; cv=none; b=B5BjQ4Iu0GLIryXW+vakNViAWyRK1JwPGsJ0jIusiejkxj85xGYJu3ilRioSHx0jldNE86i6NYtNo+CyDfzKQGJz0eEEBwVHhAkk/wagx0UfIi1m/8n9BUPu1koB+hS1kRjrH9EKfqN9IQaZA2cPKP5Nw6GMLAM67TY8Dna/0+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719524241; c=relaxed/simple;
	bh=Uj6s7FTKObh0m1tZnyKXApS7P/zAFXeFa4RDDjCPr88=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ifDcg+5Qx/fK36e0pm8i6NNlp2l6bvzkkhbB50UH/yPo2wA5l64/FldWsqlx/07FvJQD/G0aSZsfFaMIsP8ndxHMaPu/Juw0jRsw/aaetXCr8zclJNxlKBooP0uBaVQlGk2UOEdiZC86O15NgefxsMkkbdd4kR40cloOwQTsSYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fv0cpirS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F20CC2BBFC;
	Thu, 27 Jun 2024 21:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719524240;
	bh=Uj6s7FTKObh0m1tZnyKXApS7P/zAFXeFa4RDDjCPr88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fv0cpirSgC2/1kbacDMS6s8OqbhfxuEyqpc0Pc3/XXI5/fmVVOR9CQnbHSQLWLPIb
	 tdoc7XSrvD2hb2yP2UCQo2TaisCNG1l73pKyjpJt85tM+cFjuqgREER2G7sEhbMT8q
	 OBh8Wn5AynraPIkFrwDteE2XAPbxUCgXZkdRYuSU=
Date: Thu, 27 Jun 2024 14:37:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Tvrtko Ursulin <tursulin@igalia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Huang Ying
 <ying.huang@intel.com>, Mel Gorman <mgorman@suse.de>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Rik van Riel
 <riel@surriel.com>, Johannes Weiner <hannes@cmpxchg.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Dave Hansen
 <dave.hansen@intel.com>, Andi Kleen <ak@linux.intel.com>, Michal Hocko
 <mhocko@suse.com>, David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] mm/numa_balancing: Teach mpol_to_str about the
 balancing mode
Message-Id: <20240627143719.86a92240516e689c2f2d1c09@linux-foundation.org>
In-Reply-To: <20240625132605.38428-1-tursulin@igalia.com>
References: <20240625132605.38428-1-tursulin@igalia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 14:26:05 +0100 Tvrtko Ursulin <tursulin@igalia.com> wrote:

> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> If a task has had MPOL_F_NUMA_BALANCING set it is useful to show that in
> procfs. Teach the mpol_to_str helper about its existance and while at it
> update the comment to account for "weighted interleave" when suggesting
> a recommended buffer size.
> 
> ...
>
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3293,8 +3293,9 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
>   * @pol:  pointer to mempolicy to be formatted
>   *
>   * Convert @pol into a string.  If @buffer is too short, truncate the string.
> - * Recommend a @maxlen of at least 32 for the longest mode, "interleave", the
> - * longest flag, "relative", and to display at least a few node ids.
> + * Recommend a @maxlen of at least 42 for the longest mode, "weighted
> + * interleave", the longest flag, "balancing", and to display at least a few
> + * node ids.
>   */
>  void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
>  {
> @@ -3331,12 +3332,15 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
>  		p += snprintf(p, buffer + maxlen - p, "=");
>  
>  		/*
> -		 * Currently, the only defined flags are mutually exclusive
> +		 * The below two flags are mutually exclusive:
>  		 */
>  		if (flags & MPOL_F_STATIC_NODES)
>  			p += snprintf(p, buffer + maxlen - p, "static");
>  		else if (flags & MPOL_F_RELATIVE_NODES)
>  			p += snprintf(p, buffer + maxlen - p, "relative");
> +
> +		if (flags & MPOL_F_NUMA_BALANCING)
> +			p += snprintf(p, buffer + maxlen - p, "balancing");
>  	}
>  
>  	if (!nodes_empty(nodes))

Is it strange to report this via mount options?  `static' and
`relative' can be set via mount options but afaict `balancing' cannot? 
I guess not...

Documentation/filesystems/tmpfs.rst appears to be a suitable place to
document this new userspace API please.



