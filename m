Return-Path: <linux-kernel+bounces-228419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D6A915FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7F8B1C20FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006BA146595;
	Tue, 25 Jun 2024 07:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RF+dlPWQ"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D899149C53
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299368; cv=none; b=qQCFCH6reFGFM65SK8UhGhTSHVGeRjKKSt+UCVLQ/soRm8zD6U/yonlOQYJ6yTqtVtRsObskbwYDMsZJCtWWZ0t2bthj9m/WGpwGX+hVrHapf4TdK8fOg1CTKKtxv/aOxjPibCDEKTqJW3CuHNmA9e4iVlPf3L/3Qv5g/4fpmfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299368; c=relaxed/simple;
	bh=4fdFjdLlY2/XEaD/MOoWgGGhEoYLJ+g2NZgYvcVBH24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8kUmS6pJV6+84EhO6nQ/nNbKzeBFBtZxp2/VF68p1Hv4inoMvYyuin+xCyqkhIQdgzziPAS65SCHW4hfpayPl5VX8zxEK0WnXpMZCO7E83wo/NQlRNxuk4PYoJ9jrradJh35F7ht4wDxo/uROWGuDxXjeq+IbXGkgzd5EacyOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RF+dlPWQ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57d06101d76so5429860a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719299365; x=1719904165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U5vXRW5dvx+Syj/FK64X0BFJAcoWaIpEJ5624gNlqnw=;
        b=RF+dlPWQ8v3aheN/By/Or6tZne6E8SHOYAgoulOBrmTOIIcnSf81BS3lMyTCuhuQuM
         lCx1LwioqDSdToWROY1C5tf8j5w2M1aOliv8l9+IY/OwTKwwcgrjXscSgHbjxB++bOad
         HJ7saJMiAmlt/AQFvksw0oANErQ+PJn53hM83irMlf3qx5+SktxG8rgi/K7JqtgEUPQy
         6jTrMqX57OSIAXkMYj875c0He34mEP8axFyBG5w1YeTrdoDpbAWyUDGaMldPymY5WZU3
         1hiU+eYnecPG789aQasjkXhDSma4YgGoz3Vk3JQHVFdiFLTfUr1gWWboi0u/68p5LkwD
         1aqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299365; x=1719904165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5vXRW5dvx+Syj/FK64X0BFJAcoWaIpEJ5624gNlqnw=;
        b=e/Mqjv5eEEFkV2YJD5i4ook9Gf9X/ufnlM8x4g/B79iNV0huVnl34WmlZUavQvwmEX
         579tb0oeKCNghRI6nyqgkhM3TWJTkGixM3wLJXSAAGM9Eh1pORrqI1wAi/xoLaRdi6qV
         BuQVNHHcwD/dHyGJFfZ3QAy3C1+7IYTXby4M3b5+S4wwfPblXU8rNrA1Mu2nERhfF1sF
         preSg87yFLYj3N78aZe6ROwPTdnCNy2ENGdxyi3x3i0NdZldXKV9/F2n5wRvfzTt6HpA
         PVjm5Y9HIw0B/gF2lzNyv4cPZhFuRWIiKGnzKX1Q2N8CxinZcTuVIzpFlwDyK4wF2jVA
         Si8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtyV3RNBBE7i7DA2ORdNi9wC0pc0W0Jt3PUuVS3GehQPAj2Tws22dLBy6i4uQaXURLkxA0BpmQCcRB2mzXZFIfvDHEPshvjztLK8iz
X-Gm-Message-State: AOJu0YxWqbz54ByrXoNYnC9nr58/2QEnivqG2870NTEH1aFVNMdyywlO
	RhXui+40Bu8v7ouOVvwXKAu1R9P4QiCagfR6KthfVH/gryZ/DFntTJV8SpwDp1Y=
X-Google-Smtp-Source: AGHT+IHYgiKW/FJ9NFC5aPZHT8xWkLKpTuEf40vlCMNANNzpkEm7W87I3SwUfKnumikspd2mcY9LFA==
X-Received: by 2002:a50:cd14:0:b0:57c:c10c:eee8 with SMTP id 4fb4d7f45d1cf-57d49dbf7f0mr4735870a12.19.1719299364597;
        Tue, 25 Jun 2024 00:09:24 -0700 (PDT)
Received: from localhost (109-81-95-13.rct.o2.cz. [109.81.95.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3041208esm5541172a12.30.2024.06.25.00.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:09:24 -0700 (PDT)
Date: Tue, 25 Jun 2024 09:09:23 +0200
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 11/14] mm: memcg: make memcg1_update_tree() static
Message-ID: <ZnptIwN50mPTLzX0@tiehlicka>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
 <20240625005906.106920-12-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625005906.106920-12-roman.gushchin@linux.dev>

On Mon 24-06-24 17:59:03, Roman Gushchin wrote:
> memcg1_update_tree() is not used outside of mm/memcontrol-v1.c
> anymore, define it as static and remove the declaration from
> the header file.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol-v1.c | 2 +-
>  mm/memcontrol-v1.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 1b7337d0170d..f89de413004b 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -201,7 +201,7 @@ static unsigned long soft_limit_excess(struct mem_cgroup *memcg)
>  	return excess;
>  }
>  
> -void memcg1_update_tree(struct mem_cgroup *memcg, int nid)
> +static void memcg1_update_tree(struct mem_cgroup *memcg, int nid)
>  {
>  	unsigned long excess;
>  	struct mem_cgroup_per_node *mz;
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index 7be4670d9abb..7d6ac4a4fb36 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -5,7 +5,6 @@
>  
>  #include <linux/cgroup-defs.h>
>  
> -void memcg1_update_tree(struct mem_cgroup *memcg, int nid);
>  void memcg1_remove_from_trees(struct mem_cgroup *memcg);
>  
>  static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
> -- 
> 2.45.2
> 

-- 
Michal Hocko
SUSE Labs

