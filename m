Return-Path: <linux-kernel+bounces-323131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50465973852
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66E91F25C07
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBB0191F9F;
	Tue, 10 Sep 2024 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M+Rt/5Ob"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E93524B4
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973913; cv=none; b=uwmlAmFG3eDSAaTBhM2ntyh9VI8CsAB96xezv8+On1Vivcc8zJVAWOAf6t9he4Y0n4GAbgmjOUkOuUty9volyPUQdn0i6EavchKK0latfWuBlBF2jcdQYb8TebGKwDARRWcE1q87q5JD/XT/U3EFSeFOeof5LDicXJCrIEiWnEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973913; c=relaxed/simple;
	bh=gM3Hwgf+iyc/opcq9ZURQiJqwlto3na+R6r0teon/aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNplV9d2gs36W6yEpEHEBNe5+uKyTP3m5EvJk/7kUTUQufoC7XjSHAPQmtcG1EWh1syZFp81ZhmTQAHXs6gWf/B4wCH6RkGLCMd4X2ZTk7FoxgUmJGIhyhIpF0iHvrEf2WIsBZUlZ2l46DMgEn+ZS6CoSSnjXC4Y2ROfb0du2ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M+Rt/5Ob; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso415927866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 06:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725973910; x=1726578710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NYLGuUqLXvNFmO9RMwkBqcY2ifrPq2xUkW3RgIhyR1Y=;
        b=M+Rt/5ObxXvKy3ox4P4KPn6IPbSJYX0KZCRkEJozfCmDQKIS2MxRXEnw33qiLNEM6Q
         3caiDI0FvidsIGRGnzogEAMvyDAxeujtxpgXB5hA0vQWcQh8bRgi09N2TIJUnKxwcIDY
         noSoMRnmdzkqUdnMu1tSkunbouU3gOSy2dUzTbPbw3b3ZhKSjBNzH8aBXCt5yZ3teag5
         NldkTVCCQoVYPAxMe5OTouZwik3ZCdNUn/wE2ZroWwPKGxQAvIjaIiaYAkC2MrdndY79
         /S/I0DHjvED46HTX6acHBAQR7Cbb3klufu3T1JPu5V+iyg9KSOwE6hrDuPoIJRRk5VdO
         O/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725973910; x=1726578710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYLGuUqLXvNFmO9RMwkBqcY2ifrPq2xUkW3RgIhyR1Y=;
        b=muYMkw9VePDpIWNz6nBjOA6Z833BOIQxoQoGUWQ9tkdKSutavCHRnh1WoFdw5y0SS3
         xo+jP6zUlZ/qHPdE9n8NDUq/4gPz+DLZvFo+0ZqRKtimIlwM1Na0nnB3M2IFAq1hGHik
         gyLfERgsRjf/+SAHEAT33rQt/e7Vovxa8+5a4lAbsBiZwQGeZ2hSzfiLfTu4n4EW0/bR
         DXnzta4ZFcf2SFPy7vKJ8PRoICFtaSB7pOsvWxwVfV0twP40Kqu/zcz6OXYweUfmyN67
         Tt/jil5B9rm1uD3g4aJg/LCpZsuAFjMjdzQuU91dJyq12f9KTeZ+cBBIhrW2jTstSK0j
         Yzug==
X-Forwarded-Encrypted: i=1; AJvYcCXSS9NLzS9e8NSMScPEcjK/rjMRcKuQD+S0lqz9HLxxroTxuypXF4HXV4bLeS8AUfR7SHrDfA2EdTP6pGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+luNFneJgp0jr2x5TjM8Nw52sEWY/1cup+KzHi9/HRP0e71N/
	8IyEpFDEJhASHvRIw3i4F0yRVYhEEaRClb1lTUpWXMN/8/g3APxyjMd5Y8kO+uyK+FDi7c0okGY
	u
X-Google-Smtp-Source: AGHT+IFXrATdAT88+l4QzvkyDDT/6nttmbp4hM1rL8MS4dFDMtEjL9ycfhrxDuZvI3NhDDygil5Rfg==
X-Received: by 2002:a17:907:2681:b0:a86:b46b:860a with SMTP id a640c23a62f3a-a8ffae1e8e5mr73428166b.54.1725973909737;
        Tue, 10 Sep 2024 06:11:49 -0700 (PDT)
Received: from localhost (109-81-83-158.rct.o2.cz. [109.81.83.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cea395sm484818766b.144.2024.09.10.06.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 06:11:49 -0700 (PDT)
Date: Tue, 10 Sep 2024 15:11:48 +0200
From: Michal Hocko <mhocko@suse.com>
To: mawupeng <mawupeng1@huawei.com>
Cc: ying.huang@intel.com, akpm@linux-foundation.org,
	mgorman@techsingularity.net, dmaluka@chromium.org,
	liushixin2@huawei.com, wangkefeng.wang@huawei.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, proc: collect percpu free pages into the free pages
Message-ID: <ZuBFlMgyqfXEph2g@tiehlicka>
References: <20240830014453.3070909-1-mawupeng1@huawei.com>
 <87a5guh2fb.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <2ee7cb17-9003-482c-9741-f1f51f61ab4b@huawei.com>
 <871q22hmga.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <193da117-30b8-425a-b095-6fd8aca1c987@huawei.com>
 <ZtbERGm8CJsOwx73@tiehlicka>
 <ed533d8b-40b7-447f-8453-e03b291340fa@huawei.com>
 <ZtgMHFQ4NwdvL7_e@tiehlicka>
 <26e53efe-7a54-499a-8d3f-345d29d90348@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26e53efe-7a54-499a-8d3f-345d29d90348@huawei.com>

On Tue 10-09-24 20:11:36, mawupeng wrote:
> 
> 
> On 2024/9/4 15:28, Michal Hocko wrote:
> > On Wed 04-09-24 14:49:20, mawupeng wrote:
[...]
> >> Current the problem is amount the pcp, which can increase to 4.6%(24644M)
> >> of the total 512G memory.
> > 
> > Why is that a problem? 
> 
> MemAvailable
>               An estimate of how much memory is available for starting new
>               applications, without swapping. Calculated from MemFree,
>               SReclaimable, the size of the file LRU lists, and the low
>               watermarks in each zone.
> 
> The PCP memory is essentially available memory and will be reclaimed before OOM.
> In essence, it is not fundamentally different from reclaiming file pages, as both
> are reclaimed within __alloc_pages_direct_reclaim.

It is not _fundamentally_ different but the reclaim trigger bar is
different (much higher). You might get into swapping while still keeping
pcp cache available for example.

MemAvailable has been an estimate. Time has proven not a great one as
it is hard to set expectations around that. You are focusing on pcp
caches but there others that might are not covered (e.g. networking
stack can do a lot of caching on its own). MemAvailable will never be
perfect and if you are hitting limits of its usefulness I would
recommend finding a different way to achieve your goals (which are still
not really clear to me TBH). 
-- 
Michal Hocko
SUSE Labs

