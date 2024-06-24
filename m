Return-Path: <linux-kernel+bounces-227246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC819914DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081611C22748
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D1F13D624;
	Mon, 24 Jun 2024 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDhJrm8u"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2F113D526
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234369; cv=none; b=eJjUKYj0mgpQzVsNmCGp1IGCt6TLkM+BbU5e/Iv4wZ6kQuFxPp2Yt828h7kaFrUY74Dp5o5i63PnvYOghIjp1nCXnTAn0tzqf6Wh+7MSU4jIM1oyPOsOAABIBh2ajFSsHLGsE7OjFgHbtvSAGZISoD4oMB2Hxh4lZaLN4Apqhvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234369; c=relaxed/simple;
	bh=bsFpJ2LlKDUDMCg2nIHUAdPiP7EOnEZdOcqaM4cYPL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/gXRFUvzf7Cd0pPuEz2MHRucGXB8f19xTTdK36WU/h7TTHtxliej/AWn2ZTfO8/p3Ip2DuTn8CrJ1tPxwoOWpODp+cRYq6xfluuH/+QHi91kO0dkk8ABGe+wVLDmji/Ae94afuZ1bz52MjfiF11LwP82GuJaZHcm8nINVv6esk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDhJrm8u; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-364c9ec17d1so2737341f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719234366; x=1719839166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vjbtUbH0/r3ewxHlL2R0EHYshkh/JTAG0D1DEhiQckM=;
        b=FDhJrm8uRgMAvXphW8nQgysmyqHNoab7JPTpVAtQTIyjgWkMHXUt6Ut2AnsEPhIR8H
         jNU4OAUH0rjr4quFvd8UkPrebqS6kHBMNW24qhT5InCw92fy1mMCxcW7bvtS02GZmTpZ
         sKt4SVFq7dFy29cxq2S0lk24E7NMRrwcFI1zOZ+2/gDBaY7SwMJhvDqmq8OZE9VSDHWL
         SP1EOmQRPIZLCv6gN1v6BwC8BucNkvwzn9ZwSNqD0fNwy++wVNTjBslClLOueIgou/zT
         KqbDBDoqS1P/QKGWy/WWH7Pe4Mq9lWXQHciIVnuapH9aTJqDoKyXgB/CWNC1qQjDdgA1
         g3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719234366; x=1719839166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vjbtUbH0/r3ewxHlL2R0EHYshkh/JTAG0D1DEhiQckM=;
        b=JhPuhTzoFTDPPBGCivV8Fg47pdpLSyTTcGI6YBP1Lcp+e9qfqOIaJFdf1sCL0hqosf
         1y1ou2XfcTBQANqgDSMoCM0dqBA1XsSemhXDeRBTfl2PwU7U4Qj+hcrkqkze+mqFplJ6
         dLO/fbrveBPZ443oSn0IBSqdqC1LgDOMiSOZenjywDjcBMU+aTYO+bYN9QKiEXKJ1Ldr
         sP4K/izdSjacQJSc/SPhSlEs1+XqlI1y6bUaM7xJpjAs4ChABtbRp8dvrTUJzQUZp3xF
         RNynFuV+KQGRcgb381AtFQZX6mHfAHZLg/iTCaUOI6Ad3QcoW6fI48WNyPLGFL5eS30G
         yGxA==
X-Forwarded-Encrypted: i=1; AJvYcCUR1/29CkrlrHwEB3PhMN1WsAIQ8Nry6IsF4XKjg2+Fwv/dOsfy7My3UVhlwaVERKWa5N31mK4hLbe76LDfVKULM8lVD+AtAeLYUlvb
X-Gm-Message-State: AOJu0YyTRg5EVhMcGIs3mZsbrDSP/CjtQwryTaAGSo2VQpt8+v1/0EZr
	1IuqWT1vQKmwG6RDvoiBQudNDNkEDc7rdfrq2R9x9gKZmZslmYYs
X-Google-Smtp-Source: AGHT+IE4FlgLAOGpHUN4Wucv93B2eDrXC3YiiP6yeuDXARAnrn5UUyqDVlY4M0LXfHpTkpcZ0nyEuw==
X-Received: by 2002:a05:6000:1816:b0:366:f6bd:a549 with SMTP id ffacd0b85a97d-366f6bda769mr1544909f8f.11.1719234365512;
        Mon, 24 Jun 2024 06:06:05 -0700 (PDT)
Received: from ?IPV6:2001:16a2:df66:b900:46d:aa3:6645:bcd8? ([2001:16a2:df66:b900:46d:aa3:6645:bcd8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f6355sm9968296f8f.17.2024.06.24.06.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 06:06:05 -0700 (PDT)
Message-ID: <12fb19d1-3e57-4880-be59-0e83cdc4b7f1@gmail.com>
Date: Mon, 24 Jun 2024 16:06:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [mm] 0fa2857d23:
 WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof
To: Yosry Ahmed <yosryahmed@google.com>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Linux Memory Management List <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Chengming Zhou <chengming.zhou@linux.dev>, Nhat Pham <nphamcs@gmail.com>,
 David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>,
 Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
References: <202406241651.963e3e78-oliver.sang@intel.com>
 <CAJD7tkbqHyNUzQg_Qh+-ZryrKtMzdf5RE-ndT+4iURTqEo3o6A@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJD7tkbqHyNUzQg_Qh+-ZryrKtMzdf5RE-ndT+4iURTqEo3o6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 24/06/2024 15:05, Yosry Ahmed wrote:
> On Mon, Jun 24, 2024 at 1:49 AM kernel test robot <oliver.sang@intel.com> wrote:
>>
>>
>> Hello,
>>
>> kernel test robot noticed "WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof" on:
>>
>> commit: 0fa2857d23aa170e5e28d13c467b303b0065aad8 ("mm: store zero pages to be swapped out in a bitmap")
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> This is coming from WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp), and
> is triggered by the new bitmap_zalloc() call in the swapon path. For a
> sufficiently large swapfile, bitmap_zalloc() (which uses kmalloc()
> under the hood) cannot be used to allocate the bitmap.
>
> Usama, I think we want to use a variant of kvmalloc() here.

Yes, just testing with below diff now. The patch is not in mm-stable 
yet, so will just send another revision with below diff included. Thanks!


diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0b8270359bcf..2263f71baa31 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2643,7 +2643,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, 
specialfile)
         free_percpu(p->cluster_next_cpu);
         p->cluster_next_cpu = NULL;
         vfree(swap_map);
-       bitmap_free(p->zeromap);
+       kvfree(p->zeromap);
         kvfree(cluster_info);
         /* Destroy swap account information */
         swap_cgroup_swapoff(p->type);
@@ -3170,7 +3170,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, 
specialfile, int, swap_flags)
                 goto bad_swap_unlock_inode;
         }

-       p->zeromap = bitmap_zalloc(maxpages, GFP_KERNEL);
+       p->zeromap = kvzalloc(DIV_ROUND_UP(maxpages, 8), GFP_KERNEL);
         if (!p->zeromap) {
                 error = -ENOMEM;
                 goto bad_swap_unlock_inode;


