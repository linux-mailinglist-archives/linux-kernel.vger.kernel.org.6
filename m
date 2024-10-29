Return-Path: <linux-kernel+bounces-387345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16AF9B4FB7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A5228552B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E60199924;
	Tue, 29 Oct 2024 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="TBvlOEI3"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62331946A2
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730220404; cv=none; b=hho9N65TI2sHbbipc/sxK+/mJ/glwQnh0Py70H2kw0wByYClXSIuqX6qsa3a46nWGWGBiUAZvsGrLYeCXs5K/YuepONCGjy5mLCi6lEJsl2JukhKeZK+UEvkHQipC+jnbWh82HhfL2EJiRwVKrCwVOoaK7HmxwkLpBXbM4s6EHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730220404; c=relaxed/simple;
	bh=n8r+qQWqgjb3kOQxIVDiLzBEDq8D+bjmlQCbrDPcfiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFlXV2bJ3/579F7NXWA/KwVSVJrK6UekVZl12pg87ltF7yhIm7yHLMQ4LaeF1m0nJypsIctyK5zNj1IH1avD91upKVPJhiA1FygAi+0hdZ7QrhfvmfkJ7Tx85cvvNzCwDS0D7oH9ZxJBtl8+Q9Z981I5M1JRAdcDWS49S+f40D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=TBvlOEI3; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b14554468fso421695085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1730220399; x=1730825199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=09agyBT6u3egXAf7LPz9qx9GSNwu5Xem4ucSCdCX6gU=;
        b=TBvlOEI3zJxe/c9dfhuepMW2mEg8OcsDXjCtvxkg73w7N7GgannvjvOXOerbXCw/Lw
         0MWAnUir1uOW8bOVkDfPUcb3diyYbaSdrIVDzOiIMzMRopBLilLaue9a3Fk1acpiLBvm
         ZCNM2c2xCdbk3BhIzHPEyUdCReVPN9RY0VEr3JMTE0UT+ClBU6PH9N9L0sx1SayUB6ND
         B0CVoV5hVFfDWSeTSuOMzEViXYqzknwNmbhsjQANmfBnmG32/wEiTLhaXT4Eu/Y+Xa+/
         TADeIjAZ6bb+CHncMA/DJ8Z3yBTatT60bC4jLxqpF28H2cSN0SKGlVfDQr+virgUbW2u
         6Oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730220399; x=1730825199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09agyBT6u3egXAf7LPz9qx9GSNwu5Xem4ucSCdCX6gU=;
        b=IEYde+oa1/gUp4PyNWY0zZhVR0d9KYw71GAfXMYEix9eDaVYKsdn/5LJmVhpq79uxD
         eKNEJEoRmv7Dg4SLdRzq2DT2B87orjhqWwEBV2rR0UYy7SN0kkjm+l1wbhasN7w57VzH
         B82nmNgk6SMazvzfmk+z3OH5lHrF0CCn7utaH9oiuyElDV6dUnp3BaayKSNKKTH0yrZ2
         ud42hR3PKYrevmx4UmGgT7aVyXpRrcRM6PY5Lm9Durp1KJ1A9nrexjV+r8HvAR4hw/x9
         JSZcykLjqBFkVS6T2FWaGF+bFM2pJ96beLmn5GSCAMsy1zuw/qx/axD6/qn0kwrscask
         bCQg==
X-Forwarded-Encrypted: i=1; AJvYcCWuCSaD490VNq6dbr+JCLhRgA/1UQ6coDMShr5rfiES2A1sYsCP3wkssDjEo9L4U5iX4J5g01Ctb7H9/IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNfjDaw3oxuJGdzbNwdUmYdFvkTy13Y8NGPPiJMh8KCWOaxHKo
	UrFRSf4DmqQ3r82+p9DcUt0+Fj+RlwYL2VsVKo+dByCeTH0k82d1Tw+lOVD3wbw=
X-Google-Smtp-Source: AGHT+IGQE6P+m/VF3mDfVyk91GpsmWbzU9kGZv51e+x8X6IoWdYxZ/MTH4IfkaIDRbbWa8Ht4lyKuQ==
X-Received: by 2002:a05:620a:24c5:b0:7b1:1269:44bc with SMTP id af79cd13be357-7b193f0b86emr2128916185a.39.1730220399662;
        Tue, 29 Oct 2024 09:46:39 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d35a9acsm426321185a.131.2024.10.29.09.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 09:46:38 -0700 (PDT)
Date: Tue, 29 Oct 2024 12:46:37 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Link Lin <linkl@google.com>,
	David Rientjes <rientjes@google.com>
Subject: Re: [PATCH mm-unstable v3] mm/page_alloc: keep track of free
 highatomic
Message-ID: <20241029164637.GA5108@cmpxchg.org>
References: <20241028182653.3420139-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028182653.3420139-1-yuzhao@google.com>

On Mon, Oct 28, 2024 at 12:26:53PM -0600, Yu Zhao wrote:
> OOM kills due to vastly overestimated free highatomic reserves were
> observed:
> 
>   ... invoked oom-killer: gfp_mask=0x100cca(GFP_HIGHUSER_MOVABLE), order=0 ...
>   Node 0 Normal free:1482936kB boost:0kB min:410416kB low:739404kB high:1068392kB reserved_highatomic:1073152KB ...
>   Node 0 Normal: 1292*4kB (ME) 1920*8kB (E) 383*16kB (UE) 220*32kB (ME) 340*64kB (E) 2155*128kB (UE) 3243*256kB (UE) 615*512kB (U) 1*1024kB (M) 0*2048kB 0*4096kB = 1477408kB
> 
> The second line above shows that the OOM kill was due to the following
> condition:
> 
>   free (1482936kB) - reserved_highatomic (1073152kB) = 409784KB < min (410416kB)
> 
> And the third line shows there were no free pages in any
> MIGRATE_HIGHATOMIC pageblocks, which otherwise would show up as type
> 'H'. Therefore __zone_watermark_unusable_free() underestimated the
> usable free memory by over 1GB, which resulted in the unnecessary OOM
> kill above.
> 
> The comments in __zone_watermark_unusable_free() warns about the
> potential risk, i.e.,
> 
>   If the caller does not have rights to reserves below the min
>   watermark then subtract the high-atomic reserves. This will
>   over-estimate the size of the atomic reserve but it avoids a search.
> 
> However, it is possible to keep track of free pages in reserved
> highatomic pageblocks with a new per-zone counter nr_free_highatomic
> protected by the zone lock, to avoid a search when calculating the
> usable free memory. And the cost would be minimal, i.e., simple
> arithmetics in the highatomic alloc/free/move paths.
> 
> Note that since nr_free_highatomic can be relatively small, using a
> per-cpu counter might cause too much drift and defeat its purpose,
> in addition to the extra memory overhead.
> 
> Reported-by: Link Lin <linkl@google.com>
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Acked-by: David Rientjes <rientjes@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> @@ -642,6 +644,9 @@ static inline void account_freepages(struct zone *zone, int nr_pages,
>  
>  	if (is_migrate_cma(migratetype))
>  		__mod_zone_page_state(zone, NR_FREE_CMA_PAGES, nr_pages);
> +
> +	if (is_migrate_highatomic(migratetype))
> +		WRITE_ONCE(zone->nr_free_highatomic, zone->nr_free_highatomic + nr_pages);

Minor nit, the page can only be of one migratetype, so `else if' would
be better.


