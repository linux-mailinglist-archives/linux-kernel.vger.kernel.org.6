Return-Path: <linux-kernel+bounces-429838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFACA9E2763
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5CB716449D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECEB1F8ADC;
	Tue,  3 Dec 2024 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/PO+z5J"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD5F1F8AD2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243253; cv=none; b=ohqGrnwDpeSISOUg6IK67yRRdRpN1crpIPArQhwxdLXnJAboAELNNPI0V6PizyFXWsgdNOwTbxVSVTeA14tzOVzfJk7kRiT+MS0fuURFAUCKQc2t5mOCK1ACY2ivMzKNbipFgWo772XkjcqxCcOqYpzjdWuUhDGn6MJJSkcYvcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243253; c=relaxed/simple;
	bh=vVyjb1phtZTCVmrmyyd1nuTmB+Jo1u75Uw9zcqveelg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtxReEGq/6/ezhZKUiaVlV0V8zBSp1GYupjyhEnWP43URv+YSb6/mUWS9jKdEvd8Y0qV2QXFQbvlA13Itvb8VEeWOxuYVJhbAj0/ibZuV8pcN9CP3u37fhAnZwlS2WeLY07x97GJRRvbPj/iF9RVr9nw8yL0FE9fY5Nvvc/22js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/PO+z5J; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-724d8422dbaso4830481b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 08:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733243251; x=1733848051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iFuvzEv7PFpiGv/kCgoJ1Tl7hxsdy5bMIuNbHpqUVHY=;
        b=f/PO+z5JLxoGwdP2BVeGmxtWQplmc2GkgruMnJ8Xz3V7Lk7Ecj6NiHEPfJrsqap3U4
         oBFRFdZ0dCB+MuvZ61epIgOkp+bpnyF7CvX5o0ayEdN6lRRyi5ciPjmsdFrgWYOClpzz
         srXAeGtB8L1egLkfyWui47R3ErPi8BQbtCCfoJvUepcLn4KxD6WgGLAUsOe5/ejVujBJ
         xcmyY8o0mjLFSFFoUn8By7fhlpNG7H9wI8zJAolH+9gMgkV5Gm51uK6lSbXE3D7NGbE9
         JpjSED+xRXG+a917YMysKoDtuDQQBFDpc9DiHU63aqdnkAospcbEBElZsO63JfpuelSO
         0CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733243251; x=1733848051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFuvzEv7PFpiGv/kCgoJ1Tl7hxsdy5bMIuNbHpqUVHY=;
        b=A8TBJSfMW123BSdSCd4X2deZAR1fvdAhj3tc/JHtfcpVke93fDEyI8gM38o7JSzgIQ
         CdKjBjxEgJ3gWMUpFNK13+7+RwpF1PBuWkWF0leWuN40b8OG2gO5Bh8QINza1fTn/FBi
         dWz84qsSHOS0Jqj7uytWISMY2DqXBazUSY25hDvGFbg4+++xJ6NOmjskPaV0d7Ysr3y8
         ys5TYJPHEL+7fYEaL7nZTSTuI4ISOxTpgthnXgdVmc+rFfJ60vbjrRLOGv0PRV4XQtsZ
         /fBZS7ewIuEkOLvQ86JcC8b+7gM9qmaciN8gcdnztsr3GpQAC/z5AebXNXvoOh3dcAaf
         O7gg==
X-Forwarded-Encrypted: i=1; AJvYcCXd6Z9ODAjYRij/NxjyfLvDwLWkJnBj4K93y/M4DZjBmMVa2qkU5iDSpxwI7/8JGEwnRNRGY6NrYvBzCgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeu5wop5xzbvdH8pwKXjjy3w9fail15OavSI0OhlKkCrJJDSa8
	YgcMR7v6ConazHv7rpmgZ09mxR0dFxHt16u3myxz3FJV643U1fgg
X-Gm-Gg: ASbGnctjeoVH/DDOCPt1HUL4Q8IpbUc6ETaG1rl16zsZ9xK8KTimbqe2zYTj3DKoEzE
	CAr/EGNu6Nloe0uUEilIJA6E4+LeAd8YXJrsmuYpEdEnkqA4gjdSb25XRIQknXOOUnfaSUcf+ML
	nVeu8AsHsQA+F6tD+faGFEFuj8oRmO027s6xul4upgw6HAQFKyEOvGOvV8c6hYnMuRCRsPhwop/
	prVbcUXio0PdphnVtjXcij8Lblt5N1zoeuaXPJvRk1HEFgzZw==
X-Google-Smtp-Source: AGHT+IEqgP/QuuF7b3JU2TABnP2w72P9BpX/wqfVmf3eCCHUiDB/Ys76sWbhJeD6TG3W9lClnt3+Iw==
X-Received: by 2002:a17:902:d4c2:b0:215:77f8:6c1e with SMTP id d9443c01a7336-215bd168dd1mr36515595ad.41.1733243250893;
        Tue, 03 Dec 2024 08:27:30 -0800 (PST)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21536d67e95sm85948855ad.76.2024.12.03.08.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 08:27:30 -0800 (PST)
Date: Tue, 3 Dec 2024 08:27:28 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] nodemask: Introduce
 for_each_node_mask_wrap/for_each_node_state_wrap()
Message-ID: <Z08xcDyBhLB_RhzP@yury-ThinkPad>
References: <20241203154917.123419-1-arighi@nvidia.com>
 <20241203154917.123419-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203154917.123419-2-arighi@nvidia.com>

On Tue, Dec 03, 2024 at 04:36:10PM +0100, Andrea Righi wrote:
> Introduce NUMA node iterators to support circular iteration, starting
> from a specified node.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Acked-by: Yury Norov <yury.norov@gmail.com>

> ---
>  include/linux/nodemask.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index b61438313a73..7ba35c65ab99 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -392,6 +392,16 @@ static inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
>  	for ((node) = 0; (node) < 1 && !nodes_empty(mask); (node)++)
>  #endif /* MAX_NUMNODES */
>  
> +#if MAX_NUMNODES > 1
> +#define for_each_node_mask_wrap(node, mask, start)			\
> +	for_each_set_bit_wrap((node), (mask).bits, MAX_NUMNODES, (start))
> +#else /* MAX_NUMNODES == 1 */
> +#define for_each_node_mask_wrap(node, mask, start)			\
> +	for ((node) = 0;						\
> +	     (node) < 1 && !nodes_empty(mask);				\
> +	     (node)++, (void)(start))
> +#endif /* MAX_NUMNODES */
> +
>  /*
>   * Bitmasks that are kept for all the nodes.
>   */
> @@ -441,6 +451,9 @@ static inline int num_node_state(enum node_states state)
>  #define for_each_node_state(__node, __state) \
>  	for_each_node_mask((__node), node_states[__state])
>  
> +#define for_each_node_state_wrap(__node, __state, __start) \
> +	for_each_node_mask_wrap((__node), node_states[__state], __start)
> +
>  #define first_online_node	first_node(node_states[N_ONLINE])
>  #define first_memory_node	first_node(node_states[N_MEMORY])
>  static inline unsigned int next_online_node(int nid)
> @@ -535,6 +548,7 @@ static inline int node_random(const nodemask_t *maskp)
>  
>  #define for_each_node(node)	   for_each_node_state(node, N_POSSIBLE)
>  #define for_each_online_node(node) for_each_node_state(node, N_ONLINE)
> +#define for_each_online_node_wrap(node, start) for_each_node_state(node, N_ONLINE, start)
>  
>  /*
>   * For nodemask scratch area.
> -- 
> 2.47.1

