Return-Path: <linux-kernel+bounces-280658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A9094CD64
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9BC3B22132
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC4E1917DD;
	Fri,  9 Aug 2024 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gsEZ0ZBY"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3F21DA21
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 09:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195992; cv=none; b=VN999Ji1rFDX3A0C/hM3KBJDGThHoSk7LZaRerNGs6kqXOerCgW9vfv2oz/Sa9zd9uGD8JoxWgrYvE0bsn6ddQWm1Gl1GJYHbK1b2nbadXyQHU7gIg20eV53P0DxDVJZ9Yy5GxRBrWzTXx9+MJ91p0toAvcTJFNkfzBeptZeAkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195992; c=relaxed/simple;
	bh=IBwrB0o9SVpqTpTVocBbFbx6YptYnKJObwRP76FZGEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFAh79JXTJ6OtTtkKw87rALLVBLlEFZ6zGZzUg/1l4fNekRMFfjtIbYYXt6KqH7PW1aHcu3u0A/LofWaw7pn61vEla1kAo9P7kPsDF9AE0MfqGx5xseQBGpe9JoyB2lOMsFwQUDYYuQHtf1e9b559kCGGR+aKLEB7Q8BL78c5TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gsEZ0ZBY; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bba25c1e15so2180209a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 02:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723195988; x=1723800788; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YQ/7W0REmhBJNkhRjRfuyyIjuxfuImnqXUUGuD9v0J0=;
        b=gsEZ0ZBYwt039/YlPB46jnjXHMUEBB3komhYblW4RGh6MLJGJrdhpLNuD+M0RTMF66
         93iVEgVbq16vV2yNvmcihGfUpdKOoGx35oSPuJ6Jzw6YcK1y1OrLNFuJEiVzTCxeEdnU
         3xIMcnkQeXeJ57Ev0DAvTnqOw0PEQqp7BG8w6UbCRSw+xKzCR1bb1H4F0zT6ENJAUPzo
         4d0Cx+iuAJo9rJno/OOK+X95MMEuUmV1rhTeetxZUG8oK6+Zt2F5y4Jgrs8/YnGSvcSD
         ByPV2pbehdUog5e/g3GaD6Jxvhx8LKtG2CBKyPn85LqwVxR1UQmzue6Bdrkqobbt1Ie3
         wgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723195988; x=1723800788;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQ/7W0REmhBJNkhRjRfuyyIjuxfuImnqXUUGuD9v0J0=;
        b=Uv5kLxr5ODvLK1BrjvuC+/08uBtjO+nqvu9sZIiQlULtu+gbIsQusYwvnsKY5lpBYe
         bgMG7hde5VL3fGuhqCaBOp3F5I2z5Ufu9sww8r47HQfpeQLRTXxZsadDO45Sza8+0wGS
         o88r3CAGI7WMlAyokwPUZypEj/8WECimicGfHl9gZG5PKz/8Ny8HTMVjl38+uOVKUAhg
         LB9QR9ux8sft42w4T2luMg+bA51zepLMfLUIyk2WJakomxbJ7Bf7m3zlWUHtTPEPOZsS
         8N2btdS/Z9b/3DCfZrAurYAp25vGduanFUWIQ9MOI1OAtfBSRLTDpoiYJ8ekvmHXbBlj
         HdyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzHAl242hPL510tROV5kjSZl54nStIjolZLz8XY6VzvjcCEdW4aEuw47dg8gk501TRS3ngETaRbtVEoL9nnonADvn8Lf8HaHCaNAQi
X-Gm-Message-State: AOJu0Yz8SVPAx+QliSpZtRkrewQAz+sf6+LX+4Sy6ScyNtddltoHiJCD
	GT6HQKkJlYa+Wzkiofd6IdQVzRm0Oe9VQ6TbSED4IuNWVG2k8Pf55qBkRC7CiuQ=
X-Google-Smtp-Source: AGHT+IE9xexf/jaxgdOt406QdW0kF6zciEkqwtsHJEbToigyZHlPq0wpM1QjfdpTcmlCWSDpFwPaOA==
X-Received: by 2002:a17:907:f19a:b0:a72:40b4:c845 with SMTP id a640c23a62f3a-a80aa65cffdmr86660366b.51.1723195987623;
        Fri, 09 Aug 2024 02:33:07 -0700 (PDT)
Received: from localhost (109-81-83-166.rct.o2.cz. [109.81.83.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3bd7sm824463666b.34.2024.08.09.02.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 02:33:07 -0700 (PDT)
Date: Fri, 9 Aug 2024 11:33:06 +0200
From: Michal Hocko <mhocko@suse.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Hailong Liu <hailong.liu@oppo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Tangquan Zheng <zhengtangquan@oppo.com>, stable@vger.kernel.org,
	Baoquan He <bhe@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-ID: <ZrXiUvj_ZPTc0yRk@tiehlicka>
References: <20240808122019.3361-1-hailong.liu@oppo.com>
 <CAGsJ_4z4+CCDoPR7+dPEhemBQN60Cj84rCeqRY7-xvWapY4LGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4z4+CCDoPR7+dPEhemBQN60Cj84rCeqRY7-xvWapY4LGg@mail.gmail.com>

On Fri 09-08-24 09:05:05, Barry Song wrote:
> On Fri, Aug 9, 2024 at 12:20 AM Hailong Liu <hailong.liu@oppo.com> wrote:
> >
> > The __vmap_pages_range_noflush() assumes its argument pages** contains
> > pages with the same page shift. However, since commit e9c3cda4d86e
> > ("mm, vmalloc: fix high order __GFP_NOFAIL allocations"), if gfp_flags
> > includes __GFP_NOFAIL with high order in vm_area_alloc_pages()
> > and page allocation failed for high order, the pages** may contain
> > two different page shifts (high order and order-0). This could
> > lead __vmap_pages_range_noflush() to perform incorrect mappings,
> > potentially resulting in memory corruption.
> >
> > Users might encounter this as follows (vmap_allow_huge = true, 2M is for PMD_SIZE):
> > kvmalloc(2M, __GFP_NOFAIL|GFP_X)
> >     __vmalloc_node_range_noprof(vm_flags=VM_ALLOW_HUGE_VMAP)
> >         vm_area_alloc_pages(order=9) ---> order-9 allocation failed and fallback to order-0
> >             vmap_pages_range()
> >                 vmap_pages_range_noflush()
> >                     __vmap_pages_range_noflush(page_shift = 21) ----> wrong mapping happens
> >
> > We can remove the fallback code because if a high-order
> > allocation fails, __vmalloc_node_range_noprof() will retry with
> > order-0. Therefore, it is unnecessary to fallback to order-0
> > here. Therefore, fix this by removing the fallback code.
> >
> > Fixes: e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocations")
> > Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
> > Reported-by: Tangquan Zheng <zhengtangquan@oppo.com>
> > Cc: <stable@vger.kernel.org>
> > CC: Barry Song <21cnbao@gmail.com>
> > CC: Baoquan He <bhe@redhat.com>
> > CC: Matthew Wilcox <willy@infradead.org>
> > ---
> 
> Acked-by: Barry Song <baohua@kernel.org>
> 
> because we already have a fallback here:
> 
> void *__vmalloc_node_range_noprof :
> 
> fail:
>         if (shift > PAGE_SHIFT) {
>                 shift = PAGE_SHIFT;
>                 align = real_align;
>                 size = real_size;
>                 goto again;
>         }

This really deserves a comment because this is not really clear at all.
The code is also fragile and it would benefit from some re-org.

Thanks for the fix.

Acked-by: Michal Hocko <mhocko@suse.com>

-- 
Michal Hocko
SUSE Labs

