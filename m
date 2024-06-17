Return-Path: <linux-kernel+bounces-218162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C33E090B9F7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4233D1F249C6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C203D198856;
	Mon, 17 Jun 2024 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LU89wOgN"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA6716E867
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718649796; cv=none; b=JrgcaGVKrD6LDXl2FrxwuO7jXHg1w+su/9aIfCMceRlDJZf+4Cy9w9pj9t3sz6lKpWsXy9pFLap2gEBmyeeMOfyy7ebpbmofBP2r8ftPKADKrECoC/BcKVN0Vgw+XIfcmLfPvIUArAor1RCXAn/yUM+uIVlS1DjQY57Ji/j28YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718649796; c=relaxed/simple;
	bh=3yrTxQ3DG6T5oCgKuUEorhYhmhZ0MuzsCEvv1oQ/q9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjOD8u2oJyj3xHeFxf9PS9MkXhS5dMHPQWyQc7Pu4/8rJDhV5snSZ8TdZj70sYgYKFb3bVMNN61ldmHd6C757bckyyvToSGeJuIRRLDFixVC2Z4Fcrkxfr3I2yO8zbX14cN8q14teAdeAeDkeRkdKl/o2D7xLJf1YkSFdtkUSGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LU89wOgN; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f862f7c7edso28548855ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718649795; x=1719254595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CoPiKI0U6LA2omS7Ipp4BoMP/HdGi49YS+lwtk8HxUE=;
        b=LU89wOgNlZ0Z+4Fov/RhnQnNVfCwhFk7quC0L0q38LsXoW6aj577U0up+SGwZyDzq1
         /xP9lIIcAVn5DwVbwkrBbb4EMiq0rbuLm/HIa3C/aMgnER/KCmhz0mKqFJ64/ME+yqGS
         g1X1uV/TRwpnqkBee5//DdYVaeSe/ncpGOJxu3n69sycNNdGmj+AsL2yxyNi84KGt/eG
         Jg0r2vZFhIHdDZOeq0IA9OCu6Z/7SjrHCPj3ESTtW0sDwbJuQEg51kVMrTuJtiqsTE9L
         YINNfQojbIhrNx2FRJ9c8MTjcqyb8P0KAq8jKlJkZnLmLkV1VCUGtvnLdZcZ/jWsjN4a
         LZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718649795; x=1719254595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoPiKI0U6LA2omS7Ipp4BoMP/HdGi49YS+lwtk8HxUE=;
        b=ey/A6Kq1IXd03B+XrENxxjslaY5vvEqHQxbBHxbZuJqmxYbvvKnlt4+INjVttaRIQX
         VqNWuWnvYN3Hhqp0FUfCeaj4jRnbjDO4orfC4guTn0CducVj2EELgo+Ag95BPUKf8Vla
         e8+a4DvVq9mPDWG6ZifRYBtF15+Beo9kwKwfrhTU5YMnwrzj4DsHTg7Wh0rdf6euwlLG
         0sP3s4Tg5oCif/ab5gFmAVLZ2AruV6P/QHGHUA9Um3Ld1ifuqItqGwWixgKEpuqsXDKc
         ypb8yS94/LJxzXTJfzCyw3obZIWpQiWrEvAYWjPY65qjeMGGTyk8HFAFYLhSLt5aOFGU
         0YwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTp5YaWmYodefKdwKaE+A47QpqGWanIl5bGmLKGcgXhceHjy/BKuHApbTeuDlBVf+JPB0nvDoXy4/Ll2+q9H/5r5iz5UZaAA3IzJuy
X-Gm-Message-State: AOJu0YwPTZbVtlg8WiwuzRejbQqcH8biXFULGguIqM2caGV08+PdAF6e
	YkjSNZ0/k+3DDZge5c9ggRpgHSol+70Hae6IF0tisEepr0a5f0m3f0NikERDzA==
X-Google-Smtp-Source: AGHT+IGqZHWP33nG1x4wd+f3SUeCgN7e2qGKlwEFDGEt4WU3Ux+p18XxGUVIa8UdaXOz8okfKa4XwQ==
X-Received: by 2002:a17:902:d4c7:b0:1f4:b859:cb60 with SMTP id d9443c01a7336-1f8625c04a7mr118124205ad.10.1718649794346;
        Mon, 17 Jun 2024 11:43:14 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f8988c2e97sm6789405ad.170.2024.06.17.11.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:43:13 -0700 (PDT)
Date: Mon, 17 Jun 2024 18:43:10 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Lei Liu <liulei.rjpt@vivo.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v3] binder_alloc: Replace kcalloc with kvcalloc to
 mitigate OOM issues
Message-ID: <ZnCDvpFveS6X0a1g@google.com>
References: <20240614040930.11119-1-liulei.rjpt@vivo.com>
 <ZmyOJJmA7h6sZ_8A@google.com>
 <c46a07f5-f504-4c6f-af54-cfa00f987ce3@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c46a07f5-f504-4c6f-af54-cfa00f987ce3@vivo.com>

On Mon, Jun 17, 2024 at 12:01:26PM +0800, Lei Liu wrote:
> On 6/15/2024 at 2:38, Carlos Llamas wrote:
> > My understanding is that kvcalloc() == kcalloc() if there is enough
> > contiguous memory no?
> > 
> > I would expect the performance to be the same at best.
> 
> 1.The main reason is memory fragmentation, where we are unable to
> allocate contiguous order3 memory. Additionally, using the GFP_KERNEL
> allocation flag in the kernel's __alloc_pages_slowpath function results
> in multiple retry attempts, and if direct_reclaim and memory_compact
> are unsuccessful, OOM occurs.
> 
> 2.When fragmentation is severe, we observed that kvmalloc is faster
> than kmalloc, as it eliminates the need for multiple retry attempts to
> allocate order3. In such cases, falling back to order0 may result in
> higher allocation efficiency.
> 
> 3.Another crucial point is that in the kernel, allocations greater than
> order3 are considered PAGE_ALLOC_COSTLY_ORDER. This leads to a reduced
> number of retry attempts in __alloc_pages_slowpath, which explains the
> increased time for order3 allocation in fragmented scenarios.
> 
> In summary, under high memory pressure scenarios, the system is prone
> to fragmentation. Instead of waiting for order3 allocation, it is more
> efficient to allow kvmalloc to automatically select between order0 and
> order3, reducing wait times in high memory pressure scenarios. This is
> also the reason why kvmalloc can improve throughput.

Yes, all this makes sense. What I don't understand is how "performance
of kvcalloc is better". This is not supposed to be.

> > I'm not so sure about the results and performance improvements that are
> > claimed here. However, the switch to kvcalloc() itself seems reasonable
> > to me.
> > 
> > I'll run these tests myself as the results might have some noise. I'll
> > get back with the results.
> > 
> > Thanks,
> > Carlos Llamas
> 
> Okay, thank you for the suggestion. I look forward to receiving your
> test results and continuing our discussion.
> 

I ran several iterations of the benchmark test on a Pixel device and as
expected I didn't see any significant differences. This is a good thing,
but either we need to understand how you obtained a better performance
from using kvcalloc(), or it would be better to drop this claim from the
commit log.

The following are two individual samples of each form. However, if we
could average the output and get rid of the noise it seems the numbers
are pretty much the same.

Sample with kcalloc():
------------------------------------------------------------------
Benchmark                        Time             CPU   Iterations
------------------------------------------------------------------
BM_sendVec_binder/4          19983 ns         9832 ns        60255
BM_sendVec_binder/8          19766 ns         9690 ns        71699
BM_sendVec_binder/16         19785 ns         9722 ns        72086
BM_sendVec_binder/32         20067 ns         9864 ns        71535
BM_sendVec_binder/64         20077 ns         9941 ns        69141
BM_sendVec_binder/128        20147 ns         9944 ns        71016
BM_sendVec_binder/256        20424 ns        10044 ns        69451
BM_sendVec_binder/512        20518 ns        10064 ns        69179
BM_sendVec_binder/1024       21073 ns        10319 ns        67599
BM_sendVec_binder/2048       21482 ns        10502 ns        66767
BM_sendVec_binder/4096       22308 ns        10809 ns        63841
BM_sendVec_binder/8192       24022 ns        11649 ns        60795
BM_sendVec_binder/16384      27172 ns        13426 ns        51940
BM_sendVec_binder/32768      32853 ns        16345 ns        42211
BM_sendVec_binder/65536      80177 ns        39787 ns        17557

Sample with kvalloc():
------------------------------------------------------------------
Benchmark                        Time             CPU   Iterations
------------------------------------------------------------------
BM_sendVec_binder/4          19900 ns         9711 ns        68626
BM_sendVec_binder/8          19903 ns         9756 ns        71524
BM_sendVec_binder/16         19601 ns         9541 ns        71069
BM_sendVec_binder/32         19514 ns         9530 ns        72469
BM_sendVec_binder/64         20042 ns        10006 ns        69753
BM_sendVec_binder/128        20142 ns         9965 ns        70392
BM_sendVec_binder/256        20274 ns         9958 ns        70173
BM_sendVec_binder/512        20305 ns         9966 ns        70347
BM_sendVec_binder/1024       20883 ns        10250 ns        67813
BM_sendVec_binder/2048       21364 ns        10455 ns        67366
BM_sendVec_binder/4096       22350 ns        10888 ns        65689
BM_sendVec_binder/8192       24113 ns        11707 ns        58149
BM_sendVec_binder/16384      27122 ns        13346 ns        52515
BM_sendVec_binder/32768      32158 ns        15901 ns        44139
BM_sendVec_binder/65536      87594 ns        43627 ns        16040

To reiterate, the switch to kvcalloc() sounds good to me. Let's just fix
the commit log and Greg's suggestions too.

Thanks,
Carlos Llamas

