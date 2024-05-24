Return-Path: <linux-kernel+bounces-189189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EE68CECC7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 01:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B00F1F21E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 23:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BB6158868;
	Fri, 24 May 2024 23:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="agDyVbk1"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB96685936
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 23:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716593205; cv=none; b=FByFGELpjp3IqW7WpgBsyO48T9rjbzqFFq+yjpIYfim8BV7WNTVYNbpLMhmLE1E7VPX8YqYgwZyJ+te3gAHUpsKd145MKSmmL0AZOn94FuqC+RHzvTcXy2/bfvFj+zEy0K5fiGB0qd7QBfrZ4FKhKyUuBbE1k2z3ZQf/brpzDwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716593205; c=relaxed/simple;
	bh=u3LXnRNSMEFYkVGu4Hl2g6Gy9SUnQc1J8YGkPSu6FIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKFD9wa04+k4YAewwTejK8VfQ7N+OZ5HT5kAy5A/t/2cdxPX2r2tEkporavThKGRQ5euZDqMJ57Uy+gKPBL/+Xpx3sRZjJcT1AGMipKAJUQEy6GfLk30I4ZzkJ0yToAkPfdEg+UOb69reN7fe5HrWvuP8nqzCrjA2dtWdpJrhI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=agDyVbk1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f44b5ba445so12750565ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 16:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716593203; x=1717198003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rAjF+8L3fyaBjPnruoNhZhHPvWxDSPr1FotbktRhuLw=;
        b=agDyVbk1LkUC8KuhN9tee4QpLwyoYfqzMjDEBRgPxc+39X9qB92SaUJaKqe7YleRax
         JeRmA7X8EnAJNn2/JXQV42FZUjeSeSMt8jAs+eyA64RvUJLgcXH83Rw2xp+o6MyFQOis
         L3efg04yBekxh9/6q8uLU7jhXcgROXJT3pIVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716593203; x=1717198003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAjF+8L3fyaBjPnruoNhZhHPvWxDSPr1FotbktRhuLw=;
        b=sbLQPM7ZNPyorXeq3N/wikKbftfPWxtC1nOSNP2oh+QIJ9JLHqSX5gnkLRUm5LEspC
         DkVEwRhjK8yzv+j4pQ3YhjaOKJkc7u7kTbqnfyaxzpG+pZxNWEj4eFmGA55Tbmt1H2IG
         dxKzYAfC6E1PLivBz6of5ctCIFc6uDh0vX8vZ1wGzuWm2LMytpfuAgylwZwj1TTzOk09
         PG49AkugCQOAQycptWbeX/l2H0quip58rwCAJ3rptS0YEPYWlJWjcIyW67Z4DnwSpk+e
         TlybqQLdyyhlcUWDmJ/jDZtwNcfrFHoU7AC0G2wdXTU24hfzPQbeHuNeSKK3iPqt7L4r
         C+6g==
X-Forwarded-Encrypted: i=1; AJvYcCXLrSc6b+2uW3cpA9Py+/MCvVkQ1p9v2OEtg7rCFiTmWXuWPv47Dj3A3TeVR3trlJZNKfObEveurB/kFLV8eomdb7GG0xS4UxD2t3Vy
X-Gm-Message-State: AOJu0YykNPCGpChx9q4RVvebmcn1Nv37upvw0Mbc7cbQuZPPyIdu/4yj
	2pJIvpl5+Z4bkzP0fq3H6zQBFcP81LSpRyvrqpw64khwuoMLuwI30TxT253cKgUkjcd4Uqv0lr4
	=
X-Google-Smtp-Source: AGHT+IEKSUTMSPiBH8r09nVCDOLoiwzQ16beQH4Ep6n2vku2uU40EqC3Cg63ix+EKM+uTQAs1qDohg==
X-Received: by 2002:a17:902:e883:b0:1f4:5b00:401 with SMTP id d9443c01a7336-1f45b0008c4mr19940655ad.54.1716593203148;
        Fri, 24 May 2024 16:26:43 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c7592c1sm19078485ad.57.2024.05.24.16.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 16:26:42 -0700 (PDT)
Date: Fri, 24 May 2024 16:26:41 -0700
From: Kees Cook <keescook@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] mm, slab: don't wrap internal functions with
 alloc_hooks()
Message-ID: <202405241625.9FF3B5E@keescook>
References: <20240522095037.13958-1-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522095037.13958-1-vbabka@suse.cz>

On Wed, May 22, 2024 at 11:50:37AM +0200, Vlastimil Babka wrote:
> The functions __kmalloc_noprof(), kmalloc_large_noprof(),
> kmalloc_trace_noprof() and their _node variants are all internal to the
> implementations of kmalloc_noprof() and kmalloc_node_noprof() and are
> only declared in the "public" slab.h and exported so that those
> implementations can be static inline and distinguish the build-time
> constant size variants. The only other users for some of the internal
> functions are slub_kunit and fortify_kunit tests which make very
> short-lived allocations.

If it's only internal, I'm happy to drop it from fortify_kunit.

-Kees

-- 
Kees Cook

