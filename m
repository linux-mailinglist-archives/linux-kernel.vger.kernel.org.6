Return-Path: <linux-kernel+bounces-282365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE65294E2E7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 22:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A130B207CE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 20:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9108A1586D3;
	Sun, 11 Aug 2024 20:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WGi13W8U"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838C211CAB
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 20:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723407716; cv=none; b=PW0yxXDfY/5UPXfSzKtjVvsJbbHt6LAaxDc8Vq1D1SL8LptvbsdOO7XR8cjOIgEhl3+GGJq6V9mMUpMmkPJAs7ekq75A8DfBEnnnHljddzLzN6BU7OpggYYUMjsAcIv07SDlc7PlRUI44eg/uszF+3QcWkhEs4h8DE0xUIzb2EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723407716; c=relaxed/simple;
	bh=iCtO7OAXdN6zw99EYZ2uUFWg7u0Ik1EAWzd+J5nJl8Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hvi4GsdVAad5Fd9ffLqfa0RJw6TLiwKFM35AlM9EHhR2Je7+OY5x3L/HGDUs8nQHmMlVjW27Ef/kS50+xT6Y7B+l5yI+u+QANjnQds9+TMZHsccjNmz0gBDGrwQmluMzj6T56pOtUgZgzFhLBTlBTCoUB3PWkB/FOeoFcoKfZYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WGi13W8U; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fd657c9199so163035ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 13:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723407715; x=1724012515; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Y39ocZR3ybGuuhWSwlGuXQ5fKfzXZURWW4sanMk1Rs=;
        b=WGi13W8U4vqKxYI9WZbNKK3+IvHg14IaKxpvmfYK872zjQmzzarXghyCE75MBQfhGn
         IWcyIp/wt6PecW5XfpTQ28n0/R9kxcZlV84V4xL4acliL8iZ1+qWd6RV0Kxn82zqErKK
         kj8H8AoIxsZFiOwEqV9xhlQ/7844GdbcRFV8PS6uPZb1LjfpddQl/Nc7hGCdsGOxRMog
         oyp4lFzuFX52kQRWhqlMkjUgtgl5WcixnNxPw5KTUQnPCOqXA5Pj7fey5hkMMZhyrwq9
         qGaYlwMuhxKv6ifm4dm727/LjPAuUCU8ESQIKfraJZ+Dc52b7cMFOpPjfK+O+fXZwuXQ
         1QuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723407715; x=1724012515;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Y39ocZR3ybGuuhWSwlGuXQ5fKfzXZURWW4sanMk1Rs=;
        b=Yj1/zNXHXwin+msk6S29/D1N4xmPJngetjw2h4qg9WAHX2phNrdv/0JhImPAbW7WCN
         oXIekb3tadkFRsQAi91CLu/2ZUYzbsLEhjQLmVVW4L2MDBZjtemcvQocAUDe6T2s31iX
         HgFubLbwTr7MGbIPEc1QqQJX5/z0QMLtkQqqf+lnxdCz1xwXmTbIHphqxrnbt1YGxdB6
         RjOJVVBE4PbVlwUFDZt0MZzxUmVFTMPMWLMa/7GNBkdmHeeEveJu3wLXGcp1kaf1RJyM
         b4DW2DB+b03bNipeRy4Z2NQSsZOUmaU6qYlWx1myqmI90L35qNWAbol38GGB6X4NFoj+
         hbHw==
X-Forwarded-Encrypted: i=1; AJvYcCVcpqz3ETPKix6sGe3boGR5U7ni8sfBWaWQRaAP76JDkcUQ9iOJ5/qbyh2gHSDaAvIEbQWcccHxCv3jq7EwVRlgveBIdei9WiKCbL4S
X-Gm-Message-State: AOJu0YzTXPfEs9pDWPK3BcQTNNEpYlKqUjDgzQ0dtCKMWP0XbySMxaB+
	wDLBp0RcgZhHptvUlr1TV1NEiIMQy06xj8Cw4alaPXYc0SpkfqEUP32mphPVDw==
X-Google-Smtp-Source: AGHT+IEKhuskO4u6WdIOWmXXHKq52K3lHUQHBEitTHtSryDG+qLr7BByebpaZ02yRHU/2ntsB/h0wg==
X-Received: by 2002:a17:902:ecc3:b0:1fd:d807:b29d with SMTP id d9443c01a7336-200bbe22dcfmr3255445ad.28.1723407714169;
        Sun, 11 Aug 2024 13:21:54 -0700 (PDT)
Received: from [2620:0:1008:15:49ba:9fa:21c6:8a73] ([2620:0:1008:15:49ba:9fa:21c6:8a73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb903b09sm25705365ad.95.2024.08.11.13.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 13:21:53 -0700 (PDT)
Date: Sun, 11 Aug 2024 13:21:52 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Vlastimil Babka <vbabka@suse.cz>
cc: Axel Rasmussen <axelrasmussen@google.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Christoph Lameter <cl@linux.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, Pekka Enberg <penberg@kernel.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: Re: [PATCH] mm, slub: print CPU id on slab OOM
In-Reply-To: <a1058e89-7554-475a-9cc1-90af74b90917@suse.cz>
Message-ID: <6951700d-b6c0-b9b7-6587-1823a9d8c63d@google.com>
References: <20240806232649.3258741-1-axelrasmussen@google.com> <a1058e89-7554-475a-9cc1-90af74b90917@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 11 Aug 2024, Vlastimil Babka wrote:

> > diff --git a/mm/slub.c b/mm/slub.c
> > index c9d8a2497fd6..7148047998de 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3422,7 +3422,8 @@ slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
> >  	if ((gfpflags & __GFP_NOWARN) || !__ratelimit(&slub_oom_rs))
> >  		return;
> >  
> > -	pr_warn("SLUB: Unable to allocate memory on node %d, gfp=%#x(%pGg)\n",
> > +	pr_warn("SLUB: Unable to allocate memory for CPU %u on node %d, gfp=%#x(%pGg)\n",
> 
> BTW, wouldn't "on CPU" be more correct, as "for CPU" might be misleading
> that we are somehow constrained to that CPU?
> 

Agreed.

When I suggested this patch, I was trying to ascertain whether something 
was really wonky based on some logs that we were seeing.

  node 0: slabs: 223, objs: 11819, free: 0
  node 1: slabs: 951, objs: 50262, free: 218

This is for a NUMA_NO_NODE allocation, so I wanted to know if the cpu was 
on node 0 or node 1.

Even with the patch, that requires knowing the cpu-to-node mapping.  If we 
add the CPU output here, we likely also want to print out cpu_to_node().

> > +		preemptible() ? raw_smp_processor_id() : smp_processor_id(),
> 
> Also could we just use raw_smp_processor_id() always here? I don't see
> this has any advantage or am I missing something?
> 

This matches my understanding as well.

