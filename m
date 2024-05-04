Return-Path: <linux-kernel+bounces-168561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C1A8BBA2D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 10:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD765B21485
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 08:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D65D12B7F;
	Sat,  4 May 2024 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxKL4RIQ"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3621134AB
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 08:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714812832; cv=none; b=iWOlRLhC+Qm0ckT1BQjVWoyODy4zVwPIS9++8xM8qozIRqKfoY/S0d6mOwJRAPd0E78vjlPacT38PjpYPaEZZgxbl4pNbXa3f4+422ZMsbX+CmEDwiE/YOnmbYdsWPUEgepy+PIGsYx+9K5uDGRktB7rT6UAgPHZAiQVUQNpNIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714812832; c=relaxed/simple;
	bh=pUN1MVfTaTVfjno5GrSLfDc4GotNmP3clGi0WmGlHmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUKn6UEFlYA4RAMGMt/KTl0kysDrD9C9NJOoGzzQ82eMplUHxxxI5i5lzpDmMXuhm+8pZMlmL9rD1FRCSc6KfA8ucccAx2JeZONVfEEwmjxDVNQYOXjtzF1J+2+O6bh/hIsOoVr4L/hPhsnozHN+JlS0blqE2ScHOCX+QPu5Ff8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxKL4RIQ; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5acdbfa7a45so141369eaf.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 01:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714812830; x=1715417630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HzZ1ZtcUwHGIBRZRqWiglIxOxU+OPXOnr8ERLM5mSC4=;
        b=KxKL4RIQu0xqDd4FUsI0dxlrC59YkvVDFWpprEa84vz5wbwVKiUSqv2On7qzWAVaVZ
         gjomci/sFafBMs2JUplF4N4SZCO609HZZGXDR4HbURHp/ZcCHbll4siKGKrFXd5DQIFS
         xaKJYAtZmW1As1u0s1rW10Hh2b85cO+vqW8undgI/6Y5qLq/1RXyT98xcK1lBxUAajxB
         fFEQ0EnQeMxPF5tSLCEz8ZRmOtZ6KH6Hikdn3DAYAyxE/jygZOz0Ezyfbwc7b7K6gMKK
         Qe49s+9b3TRtaziG/sWkuC9AdoGaNqTEb1rU+usZgOSxWbVEkGZxxgEGobI1cFrjvKDU
         ZL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714812830; x=1715417630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzZ1ZtcUwHGIBRZRqWiglIxOxU+OPXOnr8ERLM5mSC4=;
        b=wLaA4SkzvyXFYS25cxGq7iQtfHlGj6seeS4Nq/iYbrlUCrh98GoDsDx59f3qbH62hX
         7J3FKlVwK3jrGaoJdOOrkQQ803xhGrou1MPxiq5Eo5O1xzbsYtMsAbWWdHkWIoxt6SS6
         OzBq1mRqeXRsULYK80ZR/xAYNsLKzmUTZGM+hNbJjMsWf1R3c8rcYpXbtnBWvQg6ZQdo
         1lQVO9rk2JwPiCBJDbtl+z+fD8bnWkaNZXRCIb3L8YFLO4unMPPL9AeOVfmqsW7C76oS
         37HK3r8u8GBixStGr5l7rnr+hgkKTrrZvBM0TxNk7pVCBN41Pg6Sla0zUaym2HrnQtUu
         bK9g==
X-Gm-Message-State: AOJu0YxWj4Sd+65BCs3oaibkMS9s3Tl7NbXegCxHDeo0YIxKerB8e3+s
	j2TOHtt7u9KpR1+X1J3/yLmT23Fswz7aAvpHpCuiWxCfV9iLYFwxinED3t3E
X-Google-Smtp-Source: AGHT+IEqKeyLxVb+b5+ZzrBmbA2d9ztlx9Qou81WcRGjJAhz2okHp+1mJjRmkq89aZVodZU4xftGDg==
X-Received: by 2002:a05:6358:e485:b0:190:f5fd:deca with SMTP id by5-20020a056358e48500b00190f5fddecamr1540138rwb.2.1714812829801;
        Sat, 04 May 2024 01:53:49 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d3-20020a654243000000b0061dca5ff167sm2161165pgq.23.2024.05.04.01.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 01:53:49 -0700 (PDT)
Date: Sat, 4 May 2024 16:53:46 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chin-Chun Chen <n26122115@gs.ncku.edu.tw>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>
Subject: Re: [PATCH 3/4] bitops: squeeze even more out of fns()
Message-ID: <ZjX3mtNIp/ceCrKG@visitorckw-System-Product-Name>
References: <20240502233204.2255158-1-yury.norov@gmail.com>
 <20240502233204.2255158-4-yury.norov@gmail.com>
 <ZjRJnvig6EDAaJ5K@visitorckw-System-Product-Name>
 <ZjUNLAhS2F/Qxt/t@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjUNLAhS2F/Qxt/t@yury-ThinkPad>

On Fri, May 03, 2024 at 09:13:32AM -0700, Yury Norov wrote:
> On Fri, May 03, 2024 at 10:19:10AM +0800, Kuan-Wei Chiu wrote:
> > +Cc Chin-Chun Chen & Ching-Chun (Jim) Huang
> > 
> > On Thu, May 02, 2024 at 04:32:03PM -0700, Yury Norov wrote:
> > > The function clears N-1 first set bits to find the N'th one with:
> > > 
> > > 	while (word && n--)
> > > 		word &= word - 1;
> > > 
> > > In the worst case, it would take 63 iterations.
> > > 
> > > Instead of linear walk through the set bits, we can do a binary search
> > > by using hweight(). This would work even better on platforms supporting
> > > hardware-assisted hweight() - pretty much every modern arch.
> > > 
> > Chin-Chun once proposed a method similar to binary search combined with
> > hamming weight and discussed it privately with me and Jim. However,
> > Chin-Chun found that binary search would actually impair performance
> > when n is small. Since we are unsure about the typical range of n in
> > our actual workload, we have not yet proposed any relevant patches. If
> > considering only the overall benchmark results, this patch looks good
> > to me.
> 
> fns() is used only as a helper to find_nth_bit(). 
> 
> In the kernel the find_nth_bit() is used in
>  - bitmap_bitremap((),
>  - bitmap_remap(), and
>  - cpumask_local_spread() via sched_numa_find_nth_cpu()
> 
> with the bit to search calculated as n = n % cpumask_weigth(). This
> virtually implies random uniformly distributed n and word, just like
> in the test_fns().
> 
> In rebalance_wq_table() in drivers/crypto/intel/iaa/iaa_crypto_main.c
> it's used like:
>         
>          for (cpu = 0; cpu < nr_cpus_per_node; cpu++) {
>                    int node_cpu = cpumask_nth(cpu, node_cpus);
>                    ...
>          }
> 
> This is an API abuse, and should be rewritten with for_each_cpu()
> 
> In cpumask_any_housekeeping() at arch/x86/kernel/cpu/resctrl/internal.h
> it's used like:
> 
>  90         hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
>  91         if (hk_cpu == exclude_cpu)
>  92                 hk_cpu = cpumask_nth_andnot(1, mask, tick_nohz_full_mask);
>  93 
>  94         if (hk_cpu < nr_cpu_ids)
>  95                 cpu = hk_cpu;
> 
> And this is another example of the API abuse. We need to introduce a new
> helper cpumask_andnot_any_but() and use it like:
> 
>         hk_cpu = cpumask_andnot_any_but(exclude_cpu, mask, tick_nohz_full_mask).
>         if (hk_cpu < nr_cpu_ids)
>                  cpu = hk_cpu;
> 
> So, where the use of find_nth_bit() is legitimate, the parameters are
> distributed like in the test, and I would expect the real-life
> performance impact to be similar to the test.
> 
> Optimizing the helper for non-legitimate cases doesn't worth the
> effort.
>
Got it, thank you for your detailed explanation :)

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei


