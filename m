Return-Path: <linux-kernel+bounces-298479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4580595C7DB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01CBA283C1D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B031428E4;
	Fri, 23 Aug 2024 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbWTZKm1"
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066276BFA5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400983; cv=none; b=J+g4+fpN/e0rog5kkEigPlmkBfh4ItFjZsjNEWCdqU4xsvVEii1If3nNChinjS+2wSyV4kK0bmdPsjGHHnnVr6aYFcvAmuk7wxIwwDiJv1p9IgIhpZHcODaymdwTty57bAmZ0Fq/VqbZE+khqao/J/jko75alPEShoywfpqxdm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400983; c=relaxed/simple;
	bh=KI6UYRq+rgvaclGq7ohbm/9P/YfTHVP6j0DINhC4yvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6dVNA/csLgSaCD5FBRpl1hN2CHqu8qEMDHtOr7jUIgiVSQJdrUMLViMUMzzKzJgPJ8HLEPfQyhQIF5N9iwciXTnh1PNn04Fmh5Hf9cLZr++DUIkP9olj9J/4tXRgjbrJT29lg6UWEha+DgFXutnqoq4RtVvvZthSDrhsMCN5zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbWTZKm1; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-7c3ebba7fbbso1235824a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 01:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724400981; x=1725005781; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVs8ovsioYb/jBtwmui0jT/FnRnFGdBoKTN69Nh6L/8=;
        b=QbWTZKm1EwDZFSda0Ci89bONxP1pvq83ZFm8LRe83m1GctKZSGIlNXbj7dUJg74KDB
         bXxs07BkGgIPRvaDnT4C7eWadOU2WC/qPkbiiuFR/HzT/Hf5hBs1wnDSxQfqrtIMhiu1
         JpOV76vBGE/zHZsOauQ/OxMSyrGMq6afeiUf0EqvfNFs2rPXcrjZHHZ3WKfmWgRXWExo
         VApzIE3GqgXA7ih++ntzkpwtht5l/ZVWTBxVjoNjIQMmQJesWC6P+JngYaikvXF9SJ7S
         MSyrKhkVyrZFrO0++4cqsdzstBKHTfm3PJntsiVFlWIcS+IF84AEgEYrTNG9+i64PHnv
         FbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724400981; x=1725005781;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVs8ovsioYb/jBtwmui0jT/FnRnFGdBoKTN69Nh6L/8=;
        b=tmN1WaEPazcUhYIBY48pCQAxJHCUYELbdyfgkbpWpI0bXLH3+HLMgQyNH/d6q828zK
         ejcRU/5LbunQHIMgpcW5rB4Y7rl0zx9H/RRSQ0mYFppoylOmMHgUnAL6LfK+AZ3zpKz9
         gxLqfFyUTDIfB41qSbmkcXu37NrlBsYhdO0KRUkYqiU26B+Na+neygAxvtOubErEwhMQ
         9VEHR7XEOaP2rAKVtZa5LAG2mpHQ469GRdjFX3MoA2V0tsKjmegLPrvWvpyFI/FPe2u4
         jQBQVquSEiVlgfhayPPcz5E4GPTLPVmSlC7qA5Dti14HqbbXPZb5Sq3WcOtsTkhnoycN
         iZcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlJNAQCyXYB+l21Aoqq+3bsvd1AfPzgpo6wdI1iq3tSvaKQI3D0beO6DwpUq3GJkTmusZkvjrgg3y/3HE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2EFBV4MEukO0BCYYXjfqBTp35U0XKL4xV4viPTPIPiqzEFea5
	gMITE9eRm8MP1poRm4SsD9hAusegMUksvD4apZDiYk9Q9vO/fPPV
X-Google-Smtp-Source: AGHT+IE+IsrKF1O8miMYodXivWoG7xNnmlaOzb1s0IrT6ktrPyzogfcX36jU45iv1oHLxVRJgclOOQ==
X-Received: by 2002:a05:6a21:170f:b0:1c3:a760:9757 with SMTP id adf61e73a8af0-1cc8a084893mr1652024637.49.1724400981144;
        Fri, 23 Aug 2024 01:16:21 -0700 (PDT)
Received: from systemsresearch.io ([2a01:7e03::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385bdca50sm23587095ad.245.2024.08.23.01.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 01:16:20 -0700 (PDT)
Date: Fri, 23 Aug 2024 08:16:18 +0000
From: Hao Li <haoli.tcs@gmail.com>
To: Liam.Howlett@oracle.com
Cc: akpm@linux-foundation.org, maple-tree@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maple_tree: simplify mas_wr_node_walk for improved
 readability
Message-ID: <20240823081618.GA23044@systemsresearch.io>
References: <20240823073719.GA18274@systemsresearch.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823073719.GA18274@systemsresearch.io>
User-Agent: Mutt/1.12.1 (2019-06-15)

Sorry, this patch misses a line. v2 has been sent.

On Fri, Aug 23, 2024 at 07:37:19AM +0000, Hao Li wrote:
> Refactor mas_wr_node_walk to make the code more clear and easier to
> understand. The main changes are:
> 
> 1. Replace the forward-iterating loop with a backward-iterating loop.
>    This simplifies the logic for determining the correct range
>    containing mas->index.
> 
> 2. Eliminate the ternary operator.
> 
> The new implementation maintains the same functionality as before, but
> with improved readability. The performance characteristics remain
> essentially the same, as we cannot predict which interval mas->index
> will fall into.
> 
> Signed-off-by: Hao Li <haoli.tcs@gmail.com>
> ---
>  lib/maple_tree.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index fe1b01b29..a180f54f5 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -2213,16 +2213,14 @@ static inline void mas_wr_node_walk(struct ma_wr_state *wr_mas)
>  
>  	wr_mas->node = mas_mn(wr_mas->mas);
>  	wr_mas->pivots = ma_pivots(wr_mas->node, wr_mas->type);
> -	count = mas->end = ma_data_end(wr_mas->node, wr_mas->type,
> +	mas->end = ma_data_end(wr_mas->node, wr_mas->type,
>  				       wr_mas->pivots, mas->max);
> -	offset = mas->offset;
> -
> -	while (offset < count && mas->index > wr_mas->pivots[offset])
> -		offset++;
> -
> -	wr_mas->r_max = offset < count ? wr_mas->pivots[offset] : mas->max;
> -	wr_mas->r_min = mas_safe_min(mas, wr_mas->pivots, offset);
> -	wr_mas->offset_end = mas->offset = offset;
> +	wr_mas->r_max = mas->max;
> +	idx = mas->end - 1;
> +	while (idx >= mas->offset && wr_mas->pivots[idx] >= mas->index)
> +		wr_mas->r_max = wr_mas->pivots[idx--];
> +	wr_mas->offset_end = mas->offset = idx + 1;
> +	wr_mas->r_min = mas_safe_min(mas, wr_mas->pivots, mas->offset);
>  }
>  
>  /*
> -- 
> 2.21.0
> 

