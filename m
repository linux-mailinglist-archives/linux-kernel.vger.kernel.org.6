Return-Path: <linux-kernel+bounces-237341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2039291EF75
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA101285F0D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34B984DF1;
	Tue,  2 Jul 2024 06:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b5sUKZOU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C13BA37
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 06:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719903132; cv=none; b=QbqiLtpNvDsIawSY5fn+/8vRW+a1oyljVFKKC2kBXQJGC95uM4rZhv39aikHDprrH+tpVbFr0hmApVGgJ/Ne90nKsHL8UqYCfkS7oRLfii2WFg/X5VZpPaDEqqgoyoYakfTHWTzYwYAaM5hXffEnbqP/moMAaNsaptgIqOzwEHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719903132; c=relaxed/simple;
	bh=Cx7oKnK/yqUuIul3LjeJTQABZLRvnE172mVlu2DwQEc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=L2zPEusfPtwwJZ9FsXLLfoGm/gjT/CxMMA3un5UxzCqCkSLAD8+EjmJi9p+MPkoJMqKTjzBqGj815kVItAMBiGCqMpqKhtUzyrNdW+HeI3MVSp2jrMVrWWyFuZgzshmmMjTr4KuFbFUIwYoj1gCbACnhaXx4sgEeiEVw3j0nPzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b5sUKZOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507AEC116B1;
	Tue,  2 Jul 2024 06:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719903131;
	bh=Cx7oKnK/yqUuIul3LjeJTQABZLRvnE172mVlu2DwQEc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b5sUKZOU429aGue5jA1Ng8scXotKK10GgtDEDHLY1uH2vKa9ClNbNk5NbtxgbnS7Q
	 nqjz1W43MtpbmlhhfCe8/zdbwA4+bAWLwWqw2GqA1+SBxszj3fL/djkV5e95nobMDa
	 xLR92isA5PkcLRFHbB091/WOazwR6XiZiV3ZPqwY=
Date: Mon, 1 Jul 2024 23:52:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Barry Song
 <v-songbaohua@oppo.com>, Yosry Ahmed <yosryahmed@google.com>, Nhat Pham
 <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, Chris Li
 <chrisl@kernel.org>, David Hildenbrand <david@redhat.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: zswap: fix zswap_never_enabled() for
 CONFIG_ZSWAP==N
Message-Id: <20240701235210.5c187c85aa225292d034cafc@linux-foundation.org>
In-Reply-To: <20240629232231.42394-1-21cnbao@gmail.com>
References: <20240629232231.42394-1-21cnbao@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Jun 2024 11:22:31 +1200 Barry Song <21cnbao@gmail.com> wrote:

> From: Barry Song <v-songbaohua@oppo.com>
> 
> If CONFIG_ZSWAP is set to N, it means zswap cannot be enabled.
> zswap_never_enabled() should return true.
> 
> ...
>
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -68,7 +68,7 @@ static inline bool zswap_is_enabled(void)
>  
>  static inline bool zswap_never_enabled(void)
>  {
> -	return false;
> +	return true;
>  }

Well, that code was as wrong as it's possible to get.

But what effect does this have?  Seems "not much"?  Perhaps we'll
attempt a zswap_load() which later fails for other reasons?

