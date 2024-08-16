Return-Path: <linux-kernel+bounces-288883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2F9953FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06095285BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F7855898;
	Fri, 16 Aug 2024 03:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JZ22vipS"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317F14F20E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723778088; cv=none; b=a+QqRThb8aLi0tkXty3nXWNXkPaPFVsVgnXp20rWnqy1KCRPXunUgog6xUci91xvzNiqSonOwQbderLYZK0Js1+uHM3p+cmZOSoFjzeMGxyNk4mnrJJ+rbAvUWvWB914Ot9blxkz4I3tWNy5z8U2D1a1rqnKLOUZYWmH8UZFoG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723778088; c=relaxed/simple;
	bh=cvVP25e+Rq4y+RdzbIJKDjmY0YmJ/tAmTsyQAdl1VFQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jMX4vgi6HKgbkqLtrJSqaqGH6kQ8Ht5dOBpYCbkOX6pdwJdZhS9DeXb+mOEMChPEjInAGa/GB3IbbsJrIltXAklW5vylV6B3AZw7TiPzVKX3uQcTfOLcu7jn0+cjWkxWSqVxx8ZimQSoJIKsFL23ovQxD2EmmKv+bpxgR1vOeOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JZ22vipS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-202018541afso35595ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 20:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723778086; x=1724382886; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mncEnTrGLhr0XZSwehPQoXmibCtIqyrKNXwcgQ7YQTo=;
        b=JZ22vipSU3OVCzwuK2vDAmc2Qs6Zmk6BN2tDcCLENgT+19BseWlOu7125AQU1cIS6N
         hWBgjNQPc9GStHoWc/bRdJRxtprFA90siaN4+H93elZumZnaJSO+C3r5JeGFhyt1NY0w
         at2S38nz1UNYDe7PM1ApeA267TmWBnCM0oWdIMMaID6xWUc2HH0+fLzNdWraB6AKORYg
         HjQFDDQnLfF4Z60amCC4c8iw2B1SR7HOnBhcYmxRfKQOQs9SBSeMMmwcAdxEXpSeHL3q
         OoNMSwbssxjjWk9jF28UVpCH8w7L9sXsQlfIoBN3bXtEZTvcDJR+ARfvO8MyRAefHh2T
         qxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723778086; x=1724382886;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mncEnTrGLhr0XZSwehPQoXmibCtIqyrKNXwcgQ7YQTo=;
        b=b5QCDLJDKEz+exi0yr80mgdo5pRV1QvhWWTlLzAzggzQhIBseokHW99app64eP9wBM
         vnO9cEqZHmBPL1KoTUTH+jkEBPaJe6dWrZ+QWrMYfb5oorQMp5ynDqg0xb04jjZpN0Y1
         C00aW5JumQvw6gCKC+jkDjxUN+qvEq0cV8dOkMU/2CusGORV4qV7xUaFupudyAXC1FE+
         OKaFLpDRX7s3yukbaDcbqDZDtJ2LeQ0uKWRj9/LZ4ZfbkPYrdKnotFjcjeinWj1j2aok
         M6stZjbYizFgUqslHmoL/Wijz77aRb8vBDXPdB28Ylrnfiw0ktYkmNkp+iTjlyzw8hcX
         tABw==
X-Forwarded-Encrypted: i=1; AJvYcCVZpWL24XvFNL4DqEwjgR3p8dfj8QOQTrep4aUeKoiETxVw0G3FSAE3R48UeetKQ4O/tLmGfO4OWeUGCIH6B5SBe+Lq7BgCYVfpULZJ
X-Gm-Message-State: AOJu0YzwEosbOlAONTbMmEigHuMPh9BWaWl+2KGjTi2fw7FG6lk7kZLE
	kzmuBqooGcOSz+Xqeimqscxash4Omk9k5KTlIzdGj8JcSbchIR54lQMbl/iCrQ==
X-Google-Smtp-Source: AGHT+IFkMI2RQ+dV/zqGKwCGQNSnORZnm91mCder9ExHmxN0iIRaokp29nlhb3NlU0WjhxLfSdsqYg==
X-Received: by 2002:a17:902:ce90:b0:1fb:563:3c25 with SMTP id d9443c01a7336-20206100d86mr759675ad.18.1723778086021;
        Thu, 15 Aug 2024 20:14:46 -0700 (PDT)
Received: from [2620:0:1008:15:4d4d:6efc:cb52:8b8e] ([2620:0:1008:15:4d4d:6efc:cb52:8b8e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2e6b3ccsm633416a91.20.2024.08.15.20.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 20:14:45 -0700 (PDT)
Date: Thu, 15 Aug 2024 20:14:44 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Yuanchu Xie <yuanchu@google.com>, David Hildenbrand <david@redhat.com>, 
    "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
    Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
    Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
    Gregory Price <gregory.price@memverge.com>, 
    Huang Ying <ying.huang@intel.com>, Lance Yang <ioworker0@gmail.com>, 
    Randy Dunlap <rdunlap@infradead.org>, 
    Muhammad Usama Anjum <usama.anjum@collabora.com>, 
    Kalesh Singh <kaleshsingh@google.com>, Wei Xu <weixugc@google.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Muchun Song <muchun.song@linux.dev>, Shuah Khan <shuah@kernel.org>, 
    Yosry Ahmed <yosryahmed@google.com>, Matthew Wilcox <willy@infradead.org>, 
    Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>, 
    Kairui Song <kasong@tencent.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
    Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
    Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
    Abel Wu <wuyun.abel@bytedance.com>, 
    "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
    Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, cgroups@vger.kernel.org, 
    linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/7] mm: workingset reporting
In-Reply-To: <20240813113313.1af3a5d7db7134a354a4cda3@linux-foundation.org>
Message-ID: <54a4d626-faed-ad86-f3c4-5e725986bd29@google.com>
References: <20240813165619.748102-1-yuanchu@google.com> <20240813113313.1af3a5d7db7134a354a4cda3@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 13 Aug 2024, Andrew Morton wrote:

> On Tue, 13 Aug 2024 09:56:11 -0700 Yuanchu Xie <yuanchu@google.com> wrote:
> 
> > This patch series provides workingset reporting of user pages in
> > lruvecs, of which coldness can be tracked by accessed bits and fd
> > references.
> 
> Very little reviewer interest.  I wonder why.  Will Google be the only
> organization which finds this useful?
> 

Although also from Google, I'm optimistic that others will find this very 
useful.  It's implemented in a way that is intended to be generally useful 
for multiple use cases, including user defined policy for proactive 
reclaim.  The cited sample userspace implementation is intended to 
demonstrate how this insight can be put into practice.

Insight into the working set of applications, particularly on multi-tenant 
systems, has derived significant memory savings for Google over the past 
decade.  The introduction of MGLRU into the upstream kernel has allowed 
this information to be derived in a much more efficient manner, presented 
here, that should make upstreaming of this insight much more palatable.

This insight into working set will only become more critical going forward 
with memory tiered systems.

Nothing here is specific to Google; in fact, we apply the insight into 
working set in very different ways across our fleets.

> > Benchmarks
> > ==========
> > Ghait Ouled Amar Ben Cheikh has implemented a simple "reclaim everything
> > colder than 10 seconds every 40 seconds" policy and ran Linux compile
> > and redis from the phoronix test suite. The results are in his repo:
> > https://github.com/miloudi98/WMO
> 
> I'd suggest at least summarizing these results here in the [0/N].  The
> Linux kernel will probably outlive that URL!
> 

Fully agreed that this would be useful for including in the cover letter.  

The results showing the impact of proactive reclaim using insight into 
working set is impressive for multi-tenant systems.  Having very 
comparable performance for kernbench with a fraction of the memory usage 
shows the potential for proactive reclaim and without the dependency on 
direct reclaim or throttling of the application itself.

This is one of several benchmarks that we are running and we'll be 
expanding upon this with cotenancy, user defined latency senstivity per 
job, extensions for insight into memory re-access, and in-guest use cases.

