Return-Path: <linux-kernel+bounces-235537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 128AE91D653
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 04:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41DB81C21118
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 02:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD8FD534;
	Mon,  1 Jul 2024 02:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NgFimxeQ"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5ECB674
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 02:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719802472; cv=none; b=ay80dFraJt4Da2BLHlis7fm0xXlVQeXhQRSEpgKrDp6C8XM/0szsTskfF+e2ASmcyjcF/Ljn8sjvVDxs4HdJQ55LhHrQht+6OwaGfh23j1A033aETnuYAL0Ts44gB4jkhp11E6q9F5r7XAgdEpDysG0PeJCcwHuIo4Stzs5X6EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719802472; c=relaxed/simple;
	bh=jq5Tj7WszjjpprbKtlJkYdNM6VIYdlt09GA0MraPesM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKaiWDRYOZwO2MdVaPKdxy+VWWbZXmHnmAeVQ1U0nL1T00Sf8/dMkAS2vlCp2rFKWFXxxh+2wMX0kIVm5DeXvIEFApqJWaC8e6yt1K60MwaTY4iC8CqfXNjrJVKarmHcEviHOSVw84NIvVA0mFwOSVZk0IrBgTeXNLW1rq5V+Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NgFimxeQ; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: 21cnbao@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719802468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7Wf8ZN3ha7QhsRhHRdsI6h2cQEcejdhbJTIuhGiUPk=;
	b=NgFimxeQPMKdwxtmOoWE9nyY2Jl8bDZxBAfHhER6hO0q2mxbzuW1QGmJjXkaKHXrfgnXFT
	mlEGu3PtXfQ0k/T1rRA4XqkN+PyZSwFFnTTQ13T7EEeLQuzSYQwJvx6jhRzb7DKIhiJBY1
	Zdnrzr8YYCy+wt/46LJTr5fgo1DKRFk=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: v-songbaohua@oppo.com
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: chrisl@kernel.org
X-Envelope-To: david@redhat.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: willy@infradead.org
Message-ID: <399b0eeb-e6dd-44e8-abaa-65acffa25364@linux.dev>
Date: Mon, 1 Jul 2024 10:54:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: zswap: fix zswap_never_enabled() for CONFIG_ZSWAP==N
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Chris Li <chrisl@kernel.org>, David Hildenbrand <david@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>
References: <20240629232231.42394-1-21cnbao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240629232231.42394-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/30 07:22, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> If CONFIG_ZSWAP is set to N, it means zswap cannot be enabled.
> zswap_never_enabled() should return true.
> 
> Fixes: 0300e17d67c3 ("mm: zswap: add zswap_never_enabled()")
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Chengming Zhou <chengming.zhou@linux.dev>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

>   include/linux/zswap.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index bf83ae5e285d..6cecb4a4f68b 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -68,7 +68,7 @@ static inline bool zswap_is_enabled(void)
>   
>   static inline bool zswap_never_enabled(void)
>   {
> -	return false;
> +	return true;
>   }
>   
>   #endif

