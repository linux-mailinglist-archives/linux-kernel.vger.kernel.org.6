Return-Path: <linux-kernel+bounces-342353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A109988DE7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 07:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0CC92818D7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 05:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A49C1714B6;
	Sat, 28 Sep 2024 05:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KW9y1xCc"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3460E143C4C
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 05:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727502023; cv=none; b=FaVe7WNGcv7Wiqm8eE5H0VvBkv2k1IB55NGyS1zXX0M1WmNK7EiNztPoTphNM4B4w4mTU5jCC51fvUJD+8HsiIXr3q6SHX76G7Yibw4YR4oTarV2u9hQgMPtfo3NSohP3KSKGtly82xKOuuXQv1KfCfTnAKW/lokcKj/fqM6HXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727502023; c=relaxed/simple;
	bh=Z32CX75DvLuSBsA8Hq5kIFN/fVlv1wk9DVCnjwlI3h8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0BH2IIcFciZOzyiT1/sGW7r9+BYCnfKdjOiVMkGLmada6SFeHK+OdlJ4rtsuWmIba8fvRiWSuYqHlSwzfPTjPyY0gUPu5VX7oDr8ZHdeqdWzqGVXVnsnnUIWpXbjXzUs964QW+lxSNSnV9QzZxno947xP3Jvn4YJ3mj0YGQfH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KW9y1xCc; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cf76a8df-33f5-4667-aa90-edd9f26b6cf7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727502013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3G6MJxlUtYVBaUZll/5jjDyeLSE35bLoeWF0+hX/w2o=;
	b=KW9y1xCcJ78BdGBjKE6FR7lMoPqpgFcEXj3f3fGUzsqovH6hTILiU+KRS2u6cw5wPZSTd8
	2wK0ByWIKdhUQMRiSWV3zyTUy5b+ilcEPb65q95Gj4MRbyH1jIwJG+ZFsCFwGp0/HMUi/4
	JJiY+f6t/4xiVFGC3mIzWrGl6ise+mg=
Date: Sat, 28 Sep 2024 13:39:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 1/8] mm: Define obj_cgroup_get() if CONFIG_MEMCG is not
 defined.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 yosryahmed@google.com, nphamcs@gmail.com, usamaarif642@gmail.com,
 shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com,
 21cnbao@gmail.com, akpm@linux-foundation.org
Cc: nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
 <20240928021620.8369-2-kanchana.p.sridhar@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240928021620.8369-2-kanchana.p.sridhar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/9/28 10:16, Kanchana P Sridhar wrote:
> This resolves an issue with obj_cgroup_get() not being defined if
> CONFIG_MEMCG is not defined.
> 
> Before this patch, we would see build errors if obj_cgroup_get() is
> called from code that is agnostic of CONFIG_MEMCG.
> 
> The zswap_store() changes for large folios in subsequent commits will
> require the use of obj_cgroup_get() in zswap code that falls into this
> category.
> 
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

> ---
>   include/linux/memcontrol.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 34d2da05f2f1..15c2716f9aa3 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1282,6 +1282,10 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css)
>   	return NULL;
>   }
>   
> +static inline void obj_cgroup_get(struct obj_cgroup *objcg)
> +{
> +}
> +
>   static inline void obj_cgroup_put(struct obj_cgroup *objcg)
>   {
>   }

