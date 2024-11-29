Return-Path: <linux-kernel+bounces-425901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4D69DEC62
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EEF1B2128E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BE51A2544;
	Fri, 29 Nov 2024 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5TPKQZn"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB8F1E489
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908463; cv=none; b=hT7nasXaGE/k0lSp6EThdlqA2Rtf6JCGKk8nALN+8s1pn3u0Vvb3nfFz+MytolDyxrKZI86hgrefR8O1/0srWqWccOaPJv0uBvcSRDR3fSIjfVxM940TxCE/ejixBQTNy+i/wmRegUbqPeSBGiw/q4NIQ06MmEEVBAX6Z/8iFqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908463; c=relaxed/simple;
	bh=QDC15UkYZ/+s/I5ls+EjNIy+tFDyDigncRmIJx3W+zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEvkBjD6x7N9PxfNgjElAykUvp1dBFeVxylzOJ/yVNGdHdaZIwYwcM5P5i+qsmLInk/tsbjK0nj042PS9UPaprSZNOPVjcLAYwhJm/gGGcq0HBr1YWRA3+uN9XzBBPLE8X/zoh2BeIWBf5nxCbMDf/pk1oNxsCkgJHydXHIfp54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5TPKQZn; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7242f559a9fso2155657b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732908461; x=1733513261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cHxTKw+tgsW+cNBVKDVH2eHtvRv/xPBbqCeToCysQC8=;
        b=c5TPKQZn8JHFCTSgIT9CXmwiK5P2ve6Mks8XlVl9LF14VVkSjRO8WJQd7YNI+IUBXJ
         4R6kEJvlZUIe3gg0/S50/QHm92KB9cZqq1A9IT+gsPBORUhi5GJ1Q1wTjyEKVYKxPtjM
         EeYr4Faq8/YL5JLQovG8MlyrBjpChWHrpxKzn22HtcyAffYfkXcPaO/niHrRaAhZ7QaZ
         f8JCPH+qd1f3KDvtJoj993taEJhsCUQEWNHoUFz4QEM6JEQbSo7/gDih+A71h1kU01Ig
         HosNogLiyZJh8feIrwXcL6M42LwhXn3ylZfKEJTI8K35fnlNdvJLUIG3ZOcMAnaVgadG
         OeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732908461; x=1733513261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHxTKw+tgsW+cNBVKDVH2eHtvRv/xPBbqCeToCysQC8=;
        b=nlr7IKClIEB9DviMxZAEPqrUUsQkVBcQF+PWcaJwh+25Xeav8oCXluxV1wcLKEEXoy
         EGe8F2k0ePhX+2Z37jQudYK+2XwcvsLAFXxDBlQkBkC+yKR1n754D7V8TXGFg4OBlA3/
         lV7EwiFy5pIE4Kn6NL5tUuGgtAI88Buhr3/Nw/E6tPfrLMjovaTLhXrXLYLHd+J658QM
         Lf3Mb971reorOFkkzr3lgBsJvU09XuQU1rCRPM1eHTvwY6OkqSmjlspuGhh4IuoycXNa
         vFRdR3R9NpJkX2A00zdDcRQUAbiVdk7JPhU44ktuKMohs/pSMZYSj0dcSFoXYrtelwzK
         ry2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6RWw37sIqUxcjOCIhwbfiNT/3ck0XP+/oTsC+xY6ivk7wb7pY9Ch3XCx2lStAX62ql0USA2f4LwEKyOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVnT6Anqi1TA8LKhiZyAvDQxCQ/WNH01MosYR2zctHT8L7fRyQ
	bglJr5U2mVtJIXmzOv0eluT6P76cncorThHhTT0AUwZKebGcUTNN
X-Gm-Gg: ASbGncsoEAv3jqyNSFuvXvDzFLUAst+HnrBa+fyckXN2JRTT/fDcqYQp/ZO9rBqnhvb
	Kplk4nppoKhWbIySQEbs/YvnDyUJ7GCr/FbuvA2scYIdOHVulp1ahj2w4ieXrobRAWAjL5ir0tu
	H9MWF40YCIGhI6bVQThzoPo9Kd5PCItAJNv7EcTxPXYqNZ4tsAi/6sQdBsZH1PEZThnWa8JmBkH
	1p7oBvjAeJMxECnfTUnd/ry550RyaiZa8uPX1ndCu9md7O47w==
X-Google-Smtp-Source: AGHT+IF/T1Vb/QV/gqlkoH9fY4JGFndHqbP8raWpOLMWLCxX6I4TJtpK7d/NClHaFR/+TNRaWVNexw==
X-Received: by 2002:a17:90b:1e51:b0:2ea:bf1c:1e40 with SMTP id 98e67ed59e1d1-2ee08fc9026mr14535123a91.22.1732908460566;
        Fri, 29 Nov 2024 11:27:40 -0800 (PST)
Received: from localhost ([216.228.125.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee2b22d08dsm3629096a91.24.2024.11.29.11.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 11:27:40 -0800 (PST)
Date: Fri, 29 Nov 2024 11:27:37 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nodemask: Introduce
 for_each_node_mask_wrap/for_each_node_state_wrap()
Message-ID: <Z0oVqfrfsMjmvdZX@yury-ThinkPad>
References: <20241129181230.69213-1-arighi@nvidia.com>
 <20241129181230.69213-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129181230.69213-2-arighi@nvidia.com>

On Fri, Nov 29, 2024 at 06:54:31PM +0100, Andrea Righi wrote:
> Introduce NUMA node iterators to support circular iteration, starting
> from a specified node.
> 
> Cc: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  include/linux/nodemask.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index b61438313a73..c99cea40dfac 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -392,6 +392,16 @@ static inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
>  	for ((node) = 0; (node) < 1 && !nodes_empty(mask); (node)++)
>  #endif /* MAX_NUMNODES */
>  
> +#if MAX_NUMNODES > 1
> +#define for_each_node_mask_wrap(node, nodemask, start)			\
> +	for_each_set_bit_wrap((node), (nodemask)->bits, MAX_NUMNODES, (start))
> +#else /* MAX_NUMNODES == 1 */
> +#define for_each_node_mask_wrap(node, mask, start)			\

There's a very well made historical mess of how nodemasks are
implemented. Contrary to bitmaps and cpumasks, we pass nodemasks by
value, not by pointer. For example, try_to_free_low() in mm/hugetlb.c
takes a pointer, but has to 'dereference' it before passing to
for_each_node_mask():

  static void try_to_free_low(struct hstate *h, unsigned long count,
                                                  nodemask_t *nodes_allowed)
  {
        for_each_node_mask(i, *nodes_allowed) {
                ...
        }
  }

That's because all nodemask functions takes an address from a variable
provided. For example the below nodes_empty() is implemented like:

  #define nodes_empty(src) __nodes_empty(&(src), MAX_NUMNODES)
  static __always_inline bool __nodes_empty(const nodemask_t *srcp, unsigned int nbits)
  {
          return bitmap_empty(srcp->bits, nbits);
  }

It means that your 'MAX_NUMNODES > 1' version doesn't match the
existing for_each_node_mask(), i.e. doesn't pass a nodemask by value.
The opencoded 'MAX_NUMNODES == 1' version does, although.

> +	for ((node) = 0;						\
> +	     (node) < 1 && !nodes_empty(mask);				\
> +	     (node)++, (void)(start), (void)(cnt))

This cnt is a leftover from v1, I guess.

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
> +	for_each_node_mask_wrap((__node), &node_states[__state], __start)

Can you also add for_each_online_node_wrap() to align with the
existing for_each_online_node()?

> +
>  #define first_online_node	first_node(node_states[N_ONLINE])
>  #define first_memory_node	first_node(node_states[N_MEMORY])
>  static inline unsigned int next_online_node(int nid)
> -- 
> 2.47.1

