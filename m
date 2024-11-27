Return-Path: <linux-kernel+bounces-422946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18C99DA03F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 02:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8112285306
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 01:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CCD4A07;
	Wed, 27 Nov 2024 01:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqoFnG07"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AADD2629C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 01:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732670631; cv=none; b=nI+nB2p1ZZdf8bqzWa3rniT5+uWJwqjfqkWN6rr7zqg+7dui9NfrBfyf18dVaI69nmj/C4HJcn9Kzz7FBDQFVn4pW74a4dh3Dfb1jZGEam5lde7xFxa/3TsmABM0X7HtKg0dA8l6bIIYNux7z6O64HOp9hB9yJmLxFLGTUZoRr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732670631; c=relaxed/simple;
	bh=/V0Mw+laqNh/WAdd0krMl3jcgkQJKTE1ngnFscZCsQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjuHrQT2gJz6+XDlucnTuKzoViYajkz5pFob4s6EAyhmF/ZMToKCgO11s3DyjCBbTdaWe0AUv8LEm5lYfh6BbhrShjfGunkWjZdTRPuWIvyUpPPQvxKeZL5YrviJ8l9aEeGW9QMuf3lKbEbcwABSi1IwsVl8kNIHS5My18XREWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqoFnG07; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7248c1849bdso6304997b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 17:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732670629; x=1733275429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1A+JAzVHQOEB3W4kQG1asiYHJ8fIiP9uHFr3P54hgyM=;
        b=XqoFnG07B2kfdBr1PJ3qsVMjUNXfF/gy99JubH5dC+x5I4OiNk31b9zgy1uGh32eXK
         kizTLTcfenrKocyryviS4qxtKHrPiqO7bg12dlejfv986PAjobsfDB6xd9/w5mBXIIUD
         KRes+9wfvYBJpvXNSJd+EUJpXPw9VY3L7uxuUwFQp+3vs5KAjYnCRMAa+LPIrAtF3Gzs
         98F5aNMXAp1GFJG9kKFaY8CI3xZy6iFNYmTIH0Z2YpoD/lxCSB03VS71oUvf0F1HyGvQ
         1DasNre2nyg8qKRhaso0LQuVZRzQinK+X9gaJC31563uY5KdSwQtXXPs8IKHRRLcEHl5
         oOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732670629; x=1733275429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1A+JAzVHQOEB3W4kQG1asiYHJ8fIiP9uHFr3P54hgyM=;
        b=SweLNbcashIrPnBIU0uWw2IlUFp8Xm2Z/4ETqs0FzQB7mLQFuuNQSSqOB6ewLxu2q1
         Ma201804lwP88hHnb8oWQh2im1aUVO6iklgv+yFXNWYgL901jk2Wv+QH1/mbN9ensSHk
         Kc3Toli8g7HfTRZrIr/5fvkPKvmNXEusnt5LyShHydOcE5rPM4yMfWiK1SOPbL5sI9Kk
         UGkksVaR/KhAdwFAPuyt5eiPp6LArwkcZYb+NHSYhd60cB1JowAPNGnnYavfQC8Hu6zr
         i48k+Q8COiJbU7h8Q0iJm1gY2nIbOIOtLoUQqvFH/KnSXXYqb+0Ha5mZdZa7+IrHu8bK
         MvYA==
X-Forwarded-Encrypted: i=1; AJvYcCXaG3pSU3OaHujuhE57sEGYhZAlVnF+kWX7ZiUV6W6pc2iy7z5zkOGRMJktJuUIYgQ5Tm1seoNs7+0u7Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWwsTMlziPFAtMBLn1h7+T4vMpMGWSO54XBhvWyLrnfKg5Nchj
	VMyTM1tx9Hu/nb6hbQjn8uUeDeWgv3IieD/vO7U3diGMFikzbozCWWQsXotk
X-Gm-Gg: ASbGncuIdgFFYLy+NpsKZEnBGT7b0O748309hsKoZhUWP7LUl3kw463QZtZNWyfEOQK
	eoebw1dnlSB4LCap8ITf0HO8rKsP7AvB/6cnYC6U+sPRCdy5/UXtOYkBmw+KwqOQDFp4bf6RoKS
	LKVgiZLxefX7O6A4Pgurs6u9ZtmZVSjt7cJ1i0A4hca7Km/u7hdWtwVDu3QsZa+owgWSl4X/O4W
	NaNazfHnKxd9DUeo9cjhSe7zwcHxBUvNg2gAu/gEpSktdE5JA==
X-Google-Smtp-Source: AGHT+IE6gAarn73uGIk0rwSvByBczaLyUoyjJi5/9u947IAOuf0d2m+bwDIZuc7Y6nGIHE95uL75cQ==
X-Received: by 2002:a05:6a00:22ce:b0:71e:6f32:df07 with SMTP id d2e1a72fcca58-7252ff9fd84mr1931892b3a.1.1732670629352;
        Tue, 26 Nov 2024 17:23:49 -0800 (PST)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de5587d0sm9037291b3a.153.2024.11.26.17.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 17:23:48 -0800 (PST)
Date: Tue, 26 Nov 2024 17:23:46 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nodemask: Introduce
 for_each_node_mask_from/for_each_node_state_from()
Message-ID: <Z0Z0omMh5f07xv8H@yury-ThinkPad>
References: <20241126101259.52077-1-arighi@nvidia.com>
 <20241126101259.52077-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126101259.52077-2-arighi@nvidia.com>

On Tue, Nov 26, 2024 at 10:56:39AM +0100, Andrea Righi wrote:
> Introduce NUMA node iterators to support circular iteration, starting
> from a specified node.

We have a special suffix for circular iterators - "wrap".

> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  include/linux/nodemask.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index b61438313a73..35f1fcdd6a84 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -392,6 +392,21 @@ static inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
>  	for ((node) = 0; (node) < 1 && !nodes_empty(mask); (node)++)
>  #endif /* MAX_NUMNODES */
>  
> +#if MAX_NUMNODES > 1
> +#define for_each_node_mask_from(node, mask, start, cnt)			\

You can just use for_each_set_bit_wrap() here, and avoid this ugly
'cnt' in the interface.

 #define for_each_node_mask_wrap(node, nodemask, start)			\
        for_each_set_bit_wrap((node), (nodemask)->bits, (start))

(not tested though)

Thanks,
Yury

> +	for ((node) = (start), (cnt) = 0;				\
> +	     (cnt) == 0 || (node) != (start);				\
> +	     (cnt)++, (node) =						\
> +			next_node((node), (mask)) >= MAX_NUMNODES ?	\
> +				first_node(mask) :			\
> +				next_node((node), (mask)))
> +#else /* MAX_NUMNODES == 1 */
> +#define for_each_node_mask_from(node, mask, start, cnt)			\
> +	for ((node) = 0;						\
> +	     (node) < 1 && !nodes_empty(mask);				\
> +	     (node)++, (void)(start), (void)(cnt))
> +#endif /* MAX_NUMNODES */
> +
>  /*
>   * Bitmasks that are kept for all the nodes.
>   */
> @@ -441,6 +456,9 @@ static inline int num_node_state(enum node_states state)
>  #define for_each_node_state(__node, __state) \
>  	for_each_node_mask((__node), node_states[__state])
>  
> +#define for_each_node_state_from(__node, __state, __start, __cnt) \
> +	for_each_node_mask_from((__node), node_states[__state], __start, __cnt)
> +
>  #define first_online_node	first_node(node_states[N_ONLINE])
>  #define first_memory_node	first_node(node_states[N_MEMORY])
>  static inline unsigned int next_online_node(int nid)
> -- 
> 2.47.0

