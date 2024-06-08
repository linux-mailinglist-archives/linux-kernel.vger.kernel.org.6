Return-Path: <linux-kernel+bounces-206858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD59A900EF7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 02:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4A91F21F64
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC9D17F5;
	Sat,  8 Jun 2024 00:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VubIbvPv"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3856125
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 00:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717807506; cv=none; b=JwIYI02Cs10jtfShCbUqV04fcFoGoCkT84g7t+LQPF3ZIqpTEHHTPQd6R2HbFrQIoo9SNACi0ZuHKq1srmXmKRezPsUIPZU3BV/9N/MabnzBYKixEOLTOocIL9mj6XzNJImDMzhyR/nYB/guYlAna2DY4a1DL8SUzeEFAD4lJAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717807506; c=relaxed/simple;
	bh=Wl+2lKNswfZ1UvsEDId1UIIcXxEoxp0W4XsxnEUKq1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6wq50Ut3/yeoXG9ovXrxR/rQl68FxbpncHmt5KUYGeG0QfpT0yhgBsRtNzpHrP0pGMbtenZjjo64TVo6X5FcqfrN/73ESD4jXMuhCg7D/x4eQmFvdGx3RMab7rB9wmb4c7+fsKEHtLjPzKmYb0+/DCbCcm78W5VOmKorMLqfqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VubIbvPv; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so331124566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 17:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717807503; x=1718412303; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fee0X3PndXsbwlVs4kMm9LMqHNhfW9Zp37mKixoORPg=;
        b=VubIbvPvmvCVdAojDa6qKA4SoqOFw1d7GXCGEYmfPHKL7G7s8pR1KwLJbFpVGaghXB
         SnWBpHWQoy0aGRuLMXgivg0WIRIqNOYdS5NAt9oGoJxMgPREHuOxESXUWpnW+AY7cl7v
         H4AJ5ODG3kUr5PNqpGjVoIrctP7JxKBclGwR2m/Mx7nTcIHj2RYUeK0DFfMR/rdIw2eM
         BAL9xQu3a29QdmPAkX0rzSEdr/ECzr0sv8MLSf/uIu0N8LiDfCvJ5YFYZ65sEIwFQc3J
         dLWkt8FRdBMgZqaZwwvgKfuf6GNt4NWm104sp+nInMlBQgN6z0CZFDw9VNrsVMlFTifl
         z1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717807503; x=1718412303;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fee0X3PndXsbwlVs4kMm9LMqHNhfW9Zp37mKixoORPg=;
        b=eWlO3rfIa1hPB7A4lfV+5YsNyCLovxc5fdEvemejQuj2sdRXayJW/n56PmYBYHBsqB
         wTKPB7EDf83Li5mBnT+pSvpOAYMpSK4tbVIdYwL3erlhPjUsUYnipl+hm4Y5mSVdSiz8
         BJtoRj3kK6ePmWQgr1BYZz6U2F8NaRBs3ChNJDjqKrX1SXfc3S/eWNETPf+g5OCXrqoQ
         HrUVP/a98Mxr8PHnAtE2JXyp22Hm/YJC5jjsCB2OO9/7pgrIZeejjlLXg2Iv0gFMi7QE
         cBpmU/2w/903CZSVNFE9XM6Kuzd5YGY2i8b9HascBPvpRCSLWi2SgQEuttUi/rRJSQRN
         R0mg==
X-Gm-Message-State: AOJu0YwkY3xD1R+KjqkSBaXSOszBhQApC2zH6HWYcxx7vZ9KSlolfO1Z
	a0I8Xn9k0hFuN/EEc8mL/7Fm6tgOxLA7Kd7+GO6IYSbu6hnhm94xmbPPet6P
X-Google-Smtp-Source: AGHT+IGQb+i2fGNydYMU+1BA6+rdW15xMO65ktQKpewwZhVK791wlma4PPICgc4lDd+SHIArVAr1cw==
X-Received: by 2002:a17:906:c1d0:b0:a67:b440:e50e with SMTP id a640c23a62f3a-a6cdb9dc4bfmr247916566b.71.1717807503369;
        Fri, 07 Jun 2024 17:45:03 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6ef7913eb8sm77499366b.178.2024.06.07.17.45.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2024 17:45:02 -0700 (PDT)
Date: Sat, 8 Jun 2024 00:45:02 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 0/2] mm/highmem: don't track highmem pages manually
Message-ID: <20240608004502.bm6pqus3ny2hbxq5@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240607083711.62833-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607083711.62833-1-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Jun 07, 2024 at 10:37:09AM +0200, David Hildenbrand wrote:
>Let's remove highmem special-casing from adjust_managed_page_count(),
>to result in less confusion why memblock manually adjusts
>totalram_pages, and __free_pages_core() only adjusts the zone's
>managed pages -- what about the highmem pages that
>adjust_managed_page_count() updates?
>

Thanks David

I have looked into this function and willing to get rid of it, but not found a
good way.

Your change really look nice.

>Now, we only maintain totalram_pages and a zone's managed pages
>independent of highmem support. We can derive the number of highmem pages
>simply by looking at the relevant zone's managed pages. I don't think
>there is any particular fast path that needs a maximum-efficient
>totalhigh_pages() implementation.
>
>Note that highmem memory is currently initialized using
>free_highmem_page()->free_reserved_page(), not __free_pages_core(). In the
>future we might want to also use __free_pages_core() to initialize
>highmem memory, to make that less special, and consider moving
>totalram_pages updates into __free_pages_core() [1], so we can just use
>adjust_managed_page_count() in there as well.
>
>Booting a simple kernel in QEMU reveals no highmem accounting change:
>
>Before:
>  Memory: 3095448K/3145208K available (14802K kernel code, 2073K rwdata,
>  5000K rodata, 740K init, 556K bss, 49760K reserved, 0K cma-reserved,
>  2244488K highmem)
>
>After:
>  Memory: 3095276K/3145208K available (14802K kernel code, 2073K rwdata,
>  5000K rodata, 740K init, 556K bss, 49932K reserved, 0K cma-reserved,
>  2244488K highmem)
>
>[1] https://lkml.kernel.org/r/20240601133402.2675-1-richard.weiyang@gmail.com
>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Wei Yang <richard.weiyang@gmail.com>
>
>David Hildenbrand (2):
>  mm/highmem: reimplement totalhigh_pages() by walking zones
>  mm/highmem: make nr_free_highpages() return "unsigned long"
>
> include/linux/highmem-internal.h | 17 ++++++-----------
> include/linux/highmem.h          |  2 +-
> mm/highmem.c                     | 20 +++++++++++++++-----
> mm/page_alloc.c                  |  4 ----
> 4 files changed, 22 insertions(+), 21 deletions(-)
>
>
>base-commit: 19b8422c5bd56fb5e7085995801c6543a98bda1f
>-- 
>2.45.1

-- 
Wei Yang
Help you, Help me

