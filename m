Return-Path: <linux-kernel+bounces-248131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4ED92D8B1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553741F24C93
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB07B19754D;
	Wed, 10 Jul 2024 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAy4C7Fw"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD2519596F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720638160; cv=none; b=jRH25GadGjEbJ8BBuOeY059wZbiHHQJq+RUGj0LHC6jYDIEvkJp8Do9oe35+lNooCPwzEsRr7UlcjFGZ7efMfC0CePu74SQ8JVyzdG9DMqqpy3j3KiZ2wFratT16SfFDCPIIk/cuL+iKAkfhGkBpjFpUxWHOVYx1OVcmQuTkvcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720638160; c=relaxed/simple;
	bh=PswQct0HzHiKHP29eqvg8c9/qemV3myFQvNJF13f+H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+4EvSKmGPs2vqk/9awPXi/hP2YVSQJZftYg93NDGWjGHrZkV/1pMkkhYOgytNckoBFfa+wqAgAYBHu4l9iE1He/KkkXm7iFSy2UO0UQmUcg6kOcR492SYFI4zn+AnljhvBwyn1HJ69BMvMZaR6bxOrk49vX6DeYTpa/IlnQyG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAy4C7Fw; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ee920b0781so786961fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720638157; x=1721242957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mPZ60RuL6ih0QLl/o8/14hY+krd4EK1oz7htgw57d1A=;
        b=lAy4C7Fw2cwqL/V/QCRVp+eszZzgwF7wxCuSO1yLQGVrwESMeVkSB4Y3F/aDCimWNM
         pUypWkAk1Ofgk5hLeQgREdzxBGN30iTJIffsAhn8Ti2HGpDOr5ApFKkUcjAzbl2YAMxf
         2FKuq+eS/wzysXbC3F8VHAYNMhAnNUXec54ubYiJQOpGmJXcxkifPcAIcvqIJv6/5ou+
         AqVh6/5CIRemfLX7U4BnTOtbsZ7gu+j+7kDfEaheIgRDvbin2A2P+GixAhTkLNwab8lg
         nk2BT3hXcY24PBt0Bjdd8dsChL1qGaIV29826M5i9l4YxJSS5IiHvVjIw8EdHlJncJEU
         FjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720638157; x=1721242957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPZ60RuL6ih0QLl/o8/14hY+krd4EK1oz7htgw57d1A=;
        b=mARizZh2RlBappASe9izXB6HqA9/lJ1qynuhf/4oAkHGXvSmitgFoL1iQ5jjjbI58k
         m2AW9C73KeTBHXmN1X+jQKbXtZYod9byFNNLsSW6/3P4o/57mG3vHzPRzZ2EvYODkkuW
         5z/KjnoxhLdJ5167FuK7uJX5zTwJTzrzsrlZZgmn2fKrUH24XhcrLkuliPzYbBmZJ4Kc
         7CsvW3U99PdTPY06dDfHPJu+YEyeAGzdn2KpMMg64jZ7nFy4Bbuo2u9tb/4cB0rBpV/4
         uYKCwHkx8jyc+6Ln0y4JcrEs2jU2xBjLRLrzBwILQONkPETzxJI9wGvD1DKk/knpLKjP
         0dUg==
X-Forwarded-Encrypted: i=1; AJvYcCVjbMDbfxDuUS8O+tj+neUEEw4wqLQFR6fvZtnJ04vW8DMhKNtFpDqyebBC4QmMBzzDp/4o7HwbSTHpPb1wSxEsJvGzdfbA6aRQFFnC
X-Gm-Message-State: AOJu0Yyo3GQOMq1OuuzanUyBIfzjd4Lsp8079Pexf7bUwICpogqPbIMx
	O3eHkmW8bPAlKPODz1227hOMo54inOETZrohZ5gP+kid4hjq2syS
X-Google-Smtp-Source: AGHT+IG1L8BlhXFrRo5w/hZ2v8OTkzJw0dc162nd8YCUmtKMgy4icMkIxWKQCufiuhXBIwUNvFBW+Q==
X-Received: by 2002:a2e:80cd:0:b0:2ee:974c:596f with SMTP id 38308e7fff4ca-2eeb30feba0mr38435041fa.28.1720638156546;
        Wed, 10 Jul 2024 12:02:36 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:b211:ad00:1490:6cc2:4d06:940f? ([2a01:4b00:b211:ad00:1490:6cc2:4d06:940f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-426615876bbsm178014455e9.6.2024.07.10.12.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 12:02:36 -0700 (PDT)
Message-ID: <2fe63ea9-613a-4904-8b68-134442c43261@gmail.com>
Date: Wed, 10 Jul 2024 20:02:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [mm] 47325a5c88:
 WARNING:at_mm/slub.c:#free_large_kmalloc
To: Hugh Dickins <hughd@google.com>
Cc: kernel test robot <oliver.sang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, oe-lkp@lists.linux.dev, lkp@intel.com,
 Linux Memory Management List <linux-mm@kvack.org>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 ltp@lists.linux.it
References: <202407101031.c6c3c651-lkp@intel.com>
 <dd08adbb-6df5-4556-9fc4-cf37b6234aa1@gmail.com>
 <053bd429-ae19-4beb-a733-a7a838b1e010@gmail.com>
 <4bc6400e-6199-4147-9399-4a54c94613fd@gmail.com>
 <612af749-0a59-f91d-693a-43d6217ffebb@google.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <612af749-0a59-f91d-693a-43d6217ffebb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/07/2024 21:49, Hugh Dickins wrote:
> It's a long time since I was active hereabouts, but the bot report
> and your flurry of updates make me think that you should step back,
> slow down, and look more carefully at the precedents here.
> 
> IIRC, the main problem is that parts of the swap_info_struct can
> still be in use from before while you're wanting to set up new values.
> Observe how alloc_swap_info() may return a fresh or an old allocation.
> Observe how enable_swap_info() is called after getting swapon_mutex
> late in swapon(), once past all possiblities of error.
> 
> I expect that your new zeromap needs to be taking the same care as is
> taken with swap_map and cluster_info: to be safe, follow their example
> in both swapon() and swapoff().
> 
> Hugh

Thanks, yeah sent too many in quick succession :). Will be more careful next time.

Both the 2nd and 3rd version are careful to solve the problem of using old allocation
which you described.

The 2nd one takes care of it in the same way as swap_map.

But I believe its unnecessary to do all that change in the 2nd version, when you can just
set it to NULL after kvfree, which is a much smaller change and takes care of reusing old
allocation equally well.

