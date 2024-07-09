Return-Path: <linux-kernel+bounces-246593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC8B92C403
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19091C223D0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E46182A69;
	Tue,  9 Jul 2024 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JY91wHzI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1622117B022
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720554292; cv=none; b=bNAobxoJTCYpW9wZoyM2hEUkjfHkfgj0QicxDWP0Lea9GfVbic1hjlPXIz51CFScbFrrxEHCVSysQ8FSSeXmDfQDS7l9Z1kojnzjFtkghCm1GiGVipCPcHQPxFCWxXS01bnuJb3Hj6FTN5JLQmpOyH7lSD14pGfE/oIfAwaJpB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720554292; c=relaxed/simple;
	bh=2nkBlcGJqP8aQ/nT6DXjTCGvRZwrTG/Yjb2X557Golc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n15+4liCeH47IFMmlm9N2ZXP+3kqTkejy7tS63gq2dK084MaJU39VIzZ7/KwyZpSkYkEwL0MKoHyIby7vBFsQkJKv/+XuhKKt7fC6g6vkrMO2xSz+5m2d/EUaeV2Vr5TjlfX0mVU+D+TeRtgMlmHANAwAkzLnGFrrlw3MN8tXH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JY91wHzI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720554290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pXci+blh8PkiQtprZqDs2hDj0sD+bUxrPmPIC5bsg+Y=;
	b=JY91wHzIddoIiHbTcjdnqvr29BW+6fFa0xe7HCQZ/X7vMU0EdZmNGMRz33uUCAB/Nb0CW2
	05Ufi1/uWpxID/EDr9kek5VVwRsgc0+6ZqYVf7cH6d21Xu+V7rY3bTdn4GY2Ms19Ik1c0q
	LgYKq/v7fopQkbEwl1Tohe3DJkzeao4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-99pdEClyPgKs-wLr8L3h6g-1; Tue, 09 Jul 2024 15:44:48 -0400
X-MC-Unique: 99pdEClyPgKs-wLr8L3h6g-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-44aeacbf2baso142481cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 12:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720554288; x=1721159088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXci+blh8PkiQtprZqDs2hDj0sD+bUxrPmPIC5bsg+Y=;
        b=J4Bb7sn/AghC3Xt9xpCoN4+5UZCYDaJOGqlljjPZnxvjF1FQWz2dSuhvCSqG4LROs4
         T4wKGgjOmBQqiGYhuusuJv1VS3TWnecF1+tfefPy36LGK7lenycEQguAOX+F9LAOFN/y
         FKiK9oX1Vr9Hki2a+KX7/R9LHa05m7Uvue+HPhh+xL9vAJb8SAg1Gk8XfEDWUKbU3LV4
         0EXj20Twjg8pJoJxC8pIw8QjRYDUEw8hjUKrgsjUFZH0hIaInmikB3WtaoKnqeqNxAb6
         AKWUeiC8gpcPskuvhzZUI4JC1DUxa+4U9sVKnzdhLP6dXnoFpWIO0oIWjahyFGpQ2GJr
         2S6A==
X-Gm-Message-State: AOJu0YysKqXdYdwPOcXQhg5NIxcm6pYUB8hXSBmXXemOSUzP41JVmZc0
	5eaHgrPfQZVVwsKiOH4NSsBMsncTbUqQA9EeBjxAmgnzmV0cNoNHhu73e8Fc9kt3OsggAYt2FDp
	s74q6HU8RXAZWqrsJxoUQZM0T53qoDluezico3DjOjAzcy0hl5Lmo3BWVBQZYUg==
X-Received: by 2002:a0c:ec85:0:b0:6b0:8202:5c4e with SMTP id 6a1803df08f44-6b61c214838mr37183796d6.5.1720554287689;
        Tue, 09 Jul 2024 12:44:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT3nxt9dEv/1jdMBOaRXRJgsCkAMxzEcLl92fDe742ry87qRXqAQQYG1bMf32HDc67VfqpLg==
X-Received: by 2002:a0c:ec85:0:b0:6b0:8202:5c4e with SMTP id 6a1803df08f44-6b61c214838mr37183666d6.5.1720554287366;
        Tue, 09 Jul 2024 12:44:47 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba8c087sm11474646d6.121.2024.07.09.12.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 12:44:46 -0700 (PDT)
Date: Tue, 9 Jul 2024 15:44:43 -0400
From: Peter Xu <peterx@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	oe-kbuild-all@lists.linux.dev, Matthew Wilcox <willy@infradead.org>,
	Mel Gorman <mgorman@suse.de>, Dave Jiang <dave.jiang@intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Dan Williams <dan.j.williams@intel.com>,
	Borislav Petkov <bp@alien8.de>, Hugh Dickins <hughd@google.com>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v2 7/8] mm/x86: Add missing pud helpers
Message-ID: <Zo2TKzvv2rkKjfTg@x1n>
References: <20240703212918.2417843-8-peterx@redhat.com>
 <202407061716.WH5NMiL2-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202407061716.WH5NMiL2-lkp@intel.com>

On Sat, Jul 06, 2024 at 05:16:15PM +0800, kernel test robot wrote:
> Hi Peter,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Xu/mm-dax-Dump-start-address-in-fault-handler/20240705-013812
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20240703212918.2417843-8-peterx%40redhat.com
> patch subject: [PATCH v2 7/8] mm/x86: Add missing pud helpers
> config: i386-randconfig-011-20240706 (https://download.01.org/0day-ci/archive/20240706/202407061716.WH5NMiL2-lkp@intel.com/config)
> compiler: gcc-11 (Ubuntu 11.4.0-4ubuntu1) 11.4.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240706/202407061716.WH5NMiL2-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407061716.WH5NMiL2-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/x86/include/asm/atomic.h:8,
>                     from include/linux/atomic.h:7,
>                     from include/linux/jump_label.h:256,
>                     from include/linux/static_key.h:1,
>                     from arch/x86/include/asm/nospec-branch.h:6,
>                     from arch/x86/include/asm/irqflags.h:9,
>                     from include/linux/irqflags.h:18,
>                     from include/linux/spinlock.h:59,
>                     from include/linux/mmzone.h:8,
>                     from include/linux/gfp.h:7,
>                     from include/linux/mm.h:7,
>                     from arch/x86/mm/pgtable.c:2:
>    In function 'pudp_establish',
>        inlined from 'pudp_invalidate' at arch/x86/mm/pgtable.c:649:14:
> >> arch/x86/include/asm/cmpxchg.h:67:25: error: call to '__xchg_wrong_size' declared with attribute error: Bad argument size for xchg
>       67 |                         __ ## op ## _wrong_size();                      \
>          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/x86/include/asm/cmpxchg.h:78:33: note: in expansion of macro '__xchg_op'
>       78 | #define arch_xchg(ptr, v)       __xchg_op((ptr), (v), xchg, "")
>          |                                 ^~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:12:18: note: in expansion of macro 'arch_xchg'
>       12 | #define raw_xchg arch_xchg
>          |                  ^~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h:4758:9: note: in expansion of macro 'raw_xchg'
>     4758 |         raw_xchg(__ai_ptr, __VA_ARGS__); \
>          |         ^~~~~~~~
>    arch/x86/include/asm/pgtable.h:1415:24: note: in expansion of macro 'xchg'
>     1415 |                 return xchg(pudp, pud);
>          |                        ^~~~

So this is the PAE paging on i386 which indeed didn't get covered in my
testsuite.. where it only covered allno/alldef which were always 2lvls.

I'll fix it when I repost, I'll add PAE into my harness too.

-- 
Peter Xu


