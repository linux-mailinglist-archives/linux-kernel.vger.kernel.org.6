Return-Path: <linux-kernel+bounces-314414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5575296B2E3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87EEA1C232EB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5D2147C9B;
	Wed,  4 Sep 2024 07:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AmpVouVk"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97554145A05
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434914; cv=none; b=iIZU10133n2JyGnX3mPNhvZDCjNMTfHA9EKSsxoVknkdjwBksHd96liNSrs45g1Ig0RkOhErZ3GqbtBl2p5M4WbOuRoBhip+5475Lsnhqx9fhBAEy+TGj2s+ElR9KyQ0nWHuDQ07i1J/dswHvAVcT+6EOJMl6LJpUUEMDVLLdLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434914; c=relaxed/simple;
	bh=ik7bvDZXtU0gy9wiWjMbYfa7dtDTehFAFn2AFaMaktU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrxM5TRKGL8yPBkjnE0IuA2jOXQioXBWHfgVI/Qeh2sXmcX2sdh1O+Zg65J3GRymiJSsLwjB5ZfhvvzoSPQ8lZDN1r8Sit2FuCg1QGI+/gKfJawQvWUp1g2KNC45upipEw+R9GttMZKSOexfP6SPOAI83yJLno1b4yIWGmZJPT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AmpVouVk; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a86b46c4831so711658466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 00:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725434910; x=1726039710; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J6qdMBsqF4Z+FiZII39Epw8MqLI1PNaBWTLLXYuV8FY=;
        b=AmpVouVkOobXyO7egmSuUUvBXTlK8vvFDTxRd7x+ymz/euw5XKD2ADX/bVX/Q6AQbW
         awFI5g5nA9V2JhdKJd24QSdRn0QeZ5iRlpJSewQKQnVmkMMNF4yJDpqejK6RqqYoC5Xt
         ZRBLJbWxizxRJb78BJ62ICi7w2pBW3IqcA5bL149GbND9XrbjJO7OKIBm8T2lQmKB9HI
         TpfFp9K+KW8AgQBtkIplgpMiVHxfwF0QLKFr1I5RslhpRv6V+2nLgLTye+aV00ExZj8P
         I/3ZZ0PmsouRacI79MeTewCv/gFOjvwmcHyYTcf0WzhqYjjY0UvjDi/ednyvwlyfQAOd
         BNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725434910; x=1726039710;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6qdMBsqF4Z+FiZII39Epw8MqLI1PNaBWTLLXYuV8FY=;
        b=KUZILujxDVIYfKloweiCoLPZuuYxgqjLsAonGOWZ84b9K8rw3Lt3fvw0YiQII+kk3u
         Q3vEkFcjaCMf8eDU0JJtcdsuLNmOObpWazAXNmwVZmGHRgRDdsvPo8r3IUyaXDLxG180
         6uSV4ad00yaXHw4LZWgkb1gpTwlfDGXAwPN4tZWv+/nCljhvJbJ01e7yoVDM2Yld5FHp
         JJKnX1/09hT5Vr3zK2VpXara8PCv8h1vEFG717wgO7mlriq8oDj1NZv/0IGBww0r7FE4
         LuHtSNR1e2wMaoCJFMY001qnqBRh2U+rewAFYuqOCfG9xh5k+BG8QOw29ULg+fOMeQAp
         tP9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1YO63AOh0j9WA5tW4AaLwAMGZkCvWJ/ZN9HxCsylj0KAXFOx+jOa4n+4Iw5lDjKERIF/Wp5rPsxxYNdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVNjt8J/nCFLtogIg+IMF8lcNjPuXuX9BWD0htFcCpLYJ23pur
	EO5dEiRMX+hVrWVnvhhcyb5Q1KbPTqshL00uMKVr2vknb2u8ydzFv18mio17P7w=
X-Google-Smtp-Source: AGHT+IHqeINE8uL24sTo67uUEfLYKO9mI3n/C4gNUn9/4dRLwQmTRkmQWzcLQ1+t8l//y7Hv3+m0tw==
X-Received: by 2002:a17:907:970f:b0:a86:7199:af37 with SMTP id a640c23a62f3a-a89d8ab4ac9mr838783566b.58.1725434909818;
        Wed, 04 Sep 2024 00:28:29 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a21d209d6sm196962766b.180.2024.09.04.00.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 00:28:29 -0700 (PDT)
Date: Wed, 4 Sep 2024 09:28:28 +0200
From: Michal Hocko <mhocko@suse.com>
To: mawupeng <mawupeng1@huawei.com>
Cc: ying.huang@intel.com, akpm@linux-foundation.org,
	mgorman@techsingularity.net, dmaluka@chromium.org,
	liushixin2@huawei.com, wangkefeng.wang@huawei.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, proc: collect percpu free pages into the free pages
Message-ID: <ZtgMHFQ4NwdvL7_e@tiehlicka>
References: <20240830014453.3070909-1-mawupeng1@huawei.com>
 <87a5guh2fb.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <2ee7cb17-9003-482c-9741-f1f51f61ab4b@huawei.com>
 <871q22hmga.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <193da117-30b8-425a-b095-6fd8aca1c987@huawei.com>
 <ZtbERGm8CJsOwx73@tiehlicka>
 <ed533d8b-40b7-447f-8453-e03b291340fa@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed533d8b-40b7-447f-8453-e03b291340fa@huawei.com>

On Wed 04-09-24 14:49:20, mawupeng wrote:
> 
> 
> On 2024/9/3 16:09, Michal Hocko wrote:
> > On Tue 03-09-24 09:50:48, mawupeng wrote:
> >>> Drain remote PCP may be not that expensive now after commit 4b23a68f9536
> >>> ("mm/page_alloc: protect PCP lists with a spinlock").  No IPI is needed
> >>> to drain the remote PCP.
> >>
> >> This looks really great, we can think a way to drop pcp before goto slowpath
> >> before swap.
> > 
> > We currently drain after first unsuccessful direct reclaim run. Is that
> > insufficient? 
> 
> The reason i said the drain of pcp is insufficient or expensive is based
> on you comment[1] :-）. Since IPIs is not requiered since commit 4b23a68f9536
> ("mm/page_alloc: protect PCP lists with a spinlock"). This could be much
> better.
> 
> [1]: https://lore.kernel.org/linux-mm/ZWRYZmulV0B-Jv3k@tiehlicka/

there are other reasons I have mentioned in that reply which play role
as well.

> > Should we do a less aggressive draining sooner? Ideally
> > restricted to cpus on the same NUMA node maybe? Do you have any specific
> > workloads that would benefit from this?
> 
> Current the problem is amount the pcp, which can increase to 4.6%(24644M)
> of the total 512G memory.

Why is that a problem? Just because some tools are miscalculating memory
pressure because they are based on MemAvailable? Or does this lead to
performance regressions on the kernel side? In other words would the
same workload behaved better if the amount of pcp-cache was reduced
without any userspace intervention?
-- 
Michal Hocko
SUSE Labs

