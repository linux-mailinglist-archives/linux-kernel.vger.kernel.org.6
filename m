Return-Path: <linux-kernel+bounces-539145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA92A4A185
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFC5A7A4F33
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714F42755E3;
	Fri, 28 Feb 2025 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="qN41fWc7"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3CC1C07D5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767291; cv=none; b=WpEAEtSsteYKE7xfTZMF/cMIrbyGECO7/f5oSQPhLoMYp0QHpJVDvMn+0JJDlQvqOtOyvxnAMm6f6n5ARR4d7BvbUpRquNUZtxf/EHacGvjRsEk7wx9OeWrO0oSerOUX8ehnnVeQuOC6bI+9inkBNA+oo6sSqNFmxsRy00ZxCMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767291; c=relaxed/simple;
	bh=RfYd5Dgh4U3T5nzqDGGI2aUFj1w3UMgwy0swiuP8Yy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIqED7lIJ0IqOawm+azX+a9uaHdsDojpjO+ebddtZU4VG3kWVpHyz0RMEm9rXyCO74/Rw92PGTYZSSLZivX1PO82Q9WOp2yL1YKr+bzR1U5EGgCNSjPlQDihYxVBTOpFLEe3uEMm0ZPy9GsNGa4JerKY0t8kQlSsVWxw87Y9cbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=qN41fWc7; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e88f3159e3so19938646d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1740767286; x=1741372086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D1HeI5Hj5FdgZC1kQ9hnOVpQk/bjqVhL1cfDe9mBVxU=;
        b=qN41fWc7fO8hiVgpkx7PhmvA1dfrdBIqVpQFo69ulXf2zp1hNun/fda4j7jC9k9xy3
         ZuWuzJ98kNkpQs2+8Ey8HhTAr1N1/H0HQ7E44pfjddF8QeKy4lLLw4fCrERyw7kisyMy
         +vIHO0StbHubA2jC2e8mHOJNJr3p7OmDhMzqvyjTgj9RCu3a/lNqOuQrRm8N0y2ljtJE
         Bvvj5rsQQqXUaN9m9eIZlDz7KlG3jXu4TDJAHRjevNU4TvPid9JHXKPZdk3KY9DSQcyN
         KRBWZrBbGC1Zs91WE8UHGUgDPS7x0HXXcikdREu+fdsifKsdLmb1kw6NKPp02Au8lJGu
         q+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767286; x=1741372086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1HeI5Hj5FdgZC1kQ9hnOVpQk/bjqVhL1cfDe9mBVxU=;
        b=qFrHlmRKIGpmYhIAk5iw5JImgupf8SvbQaJeXjquNu3OWvXRzxmzkmsjraxFdOqOdt
         /EoW3AW2vQunJf0IyAC/68kCjrfE+h75aPIf4KGkThQcDBfHj9m6tMmRdamyjSuxqHlk
         ketEAJNmiYAMfXCGqvhxCakd86K0MheMwB0JvyxrXReCuuUK4b/jRcyDBZksLIKuodIZ
         ep0Ei/n3JFt9kF1HfElbiGF68CPH6A1BYzuCX79qCXGbOn5TwOsqcRZHPaCYIRBL1LTd
         6K1HrGyLoNoiir9Lyq60EiXFGt1lC395f+LPkF8Sz7P/dXllanYMGR3ED5SFyhR1kMNR
         JQcw==
X-Forwarded-Encrypted: i=1; AJvYcCWO6svLgB+egBi0zcKmn9MFzZ4wbknwfhXzL7UYTau9zJ2Ontreuh4NQCwIy7htK0FiDnfMsQI+vTO32jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzYj1MUOI/+h5B6dngM+vDWCmlzo+hK2lnXPExW6tOHl7BLimc
	/jbKVhLkrmWZ8Kwbh2TiX78GLyrnPPJVOrcncBFLAGmvlvmlojEj0BBeQwkcVSk=
X-Gm-Gg: ASbGncsXWmMswHJ8k6FbR3EiKhr1b/I3oflb/tt6f6NXLstZaZxdYirfGrrrW19k0jM
	cPj+jT45Wq02tt040EoD96B8STKk+qAjbp9PvoEprKAg/kwhkRhhYNH9ZjvdTL+6/N/bd3fEhqw
	Eckj9SNRAONgacLBVY/xWevUewBsI7Qnm5aRM04ZuKhRK8qf/+mDDhKLpeWfxxUsZc9W7CUCMHZ
	wF26p/cHLlCkmAHxjCBQJBogl0WQH3l3T+VL6wb38tHZYx6793Wl48pJ0Hr709ulhBqpRkxpuc/
	dXsDR6MNqihUY0q5zRMosEam
X-Google-Smtp-Source: AGHT+IGs6srUxnr6AWXxdYbrfmwZOp03iNYHFv1+6TtdPkGxEDbRLb7+2Svam+kAW+1eMjMaYvZVrA==
X-Received: by 2002:ad4:5ba3:0:b0:6e6:684f:7f6f with SMTP id 6a1803df08f44-6e8a0cd3ed4mr73143116d6.7.1740767286445;
        Fri, 28 Feb 2025 10:28:06 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e8976ccbacsm24682146d6.93.2025.02.28.10.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 10:28:05 -0800 (PST)
Date: Fri, 28 Feb 2025 13:28:04 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: kernel test robot <lkp@intel.com>
Cc: Brendan Jackman <jackmanb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Add lockdep assertion for pageblock type
 change
Message-ID: <20250228182804.GB120597@cmpxchg.org>
References: <20250227-pageblock-lockdep-v1-1-3701efb331bb@google.com>
 <202503010129.rJvGqZN1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503010129.rJvGqZN1-lkp@intel.com>

On Sat, Mar 01, 2025 at 01:31:30AM +0800, kernel test robot wrote:
> Hi Brendan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on d58172d128acbafa2295aa17cc96e28260da9a86]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Brendan-Jackman/mm-page_alloc-Add-lockdep-assertion-for-pageblock-type-change/20250228-002107
> base:   d58172d128acbafa2295aa17cc96e28260da9a86
> patch link:    https://lore.kernel.org/r/20250227-pageblock-lockdep-v1-1-3701efb331bb%40google.com
> patch subject: [PATCH] mm/page_alloc: Add lockdep assertion for pageblock type change
> config: x86_64-buildonly-randconfig-002-20250228 (https://download.01.org/0day-ci/archive/20250301/202503010129.rJvGqZN1-lkp@intel.com/config)
> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250301/202503010129.rJvGqZN1-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503010129.rJvGqZN1-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from mm/page_alloc.c:19:
>    In file included from include/linux/mm.h:2302:
>    include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>      518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>          |                               ~~~~~~~~~~~ ^ ~~~
>    In file included from mm/page_alloc.c:44:
>    include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>       47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
>          |                                    ~~~~~~~~~~~ ^ ~~~
>    include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>       49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
>          |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
> >> mm/page_alloc.c:421:3: error: call to undeclared function 'in_mem_hotplug'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      421 |                 in_mem_hotplug() ||

The patch is missing a dummy in_mem_hotplug() in the
!CONFIG_MEMORY_HOTPLUG section of <linux/memory_hotplug.h>.

