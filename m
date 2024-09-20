Return-Path: <linux-kernel+bounces-334695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B132997DAC0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 01:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E20D1F223DC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 23:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8AA187328;
	Fri, 20 Sep 2024 23:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sauHYC4q"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A639C1531E1
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 23:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726874172; cv=none; b=kSsoexEyjbkPyPIjoS1Zyh1pM44xdPa2LcvKvUbwzxJkgQsCBga0IS8lSHiq9uKXejtJihEWr00lRUTRVGTcdAqJrole0VqT2uMxMnMiO20QIWJz1aZHvrAyBDBkHFvP4/i59lN5ILReCPR9mcHJshZGyoEt28t7G0heGT6HBDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726874172; c=relaxed/simple;
	bh=9X6O+MA8rmqD/bydBHU6Nbhq5c+A5SGw08blteJZLRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAeTDPTntQsLTSt0KBT/wi3fRmBpgY7fFlFWbCJ+C8f0TyVxNoA3pkWMJw+X4hNjI4BiG9eRdLVZa4MRxoZ1IPamh8qjFiTGWEzXnE3PzJ67tKmFIzHE/k50WzzQgCDCR+DY4HoGmdeIs3wjYOb0+dlhoNMTZ/1Px3MlfWbbtaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sauHYC4q; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d13b83511so285709266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 16:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726874169; x=1727478969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9X6O+MA8rmqD/bydBHU6Nbhq5c+A5SGw08blteJZLRc=;
        b=sauHYC4q0yEhGHau7TLccaFZSCqRiL8zYzb3hm/itw9TOFRiCsfMtONghyTLYDvnDG
         vrLvAFKYsTLB6xy5yfa9XPVC2+eU7QvAMEy1vEjf5hioB+o0LctB/rxtpyGOwLzochib
         vwa7y0yYEI/v+SIGZKqEUFZamwgBjmQOjPYAbrjPl41guD07TDTmp4Q7bqjF9hXv8TET
         aod2TTwy8l1Uy3eJkUwiR45Vzr63Qc+P5WcPpEQyJ7HTIIq6oxtXPtuQ8PfhV8bZH7Lg
         8zEsyx5dTt3vGa60kVQckWyC0uuogfnfGPnDFQ/qUVqjXiTRn5jAzi5jkC02vnICxtyo
         cp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726874169; x=1727478969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9X6O+MA8rmqD/bydBHU6Nbhq5c+A5SGw08blteJZLRc=;
        b=Z9cYSGKN+d8XhT7hhMxU8XhRjKmhchuTkBPdWo1pXIu1tnUh0sMl8Obyrgq/F8v4p0
         86cNtjYx0XL1F34TK1NiUd3ALw/ItyZxT6XEm4/XoI9cMuJU3JJa/B+UnYkoLtLeeBMV
         aXj4YeGR2ShVtqG1V3vMyFL0OtHNf0/mPrgB3HUn3plEdSPjQWlDjVZNJDscgq6tMfdR
         jvRSeId3jvoVraRFSCdfuP4gJEA9/zrPnKrTMI9Q4Z6xso4C0NVhJkUDawnMRkWBMGSU
         D8zbSMXAfmRr5qFBfpmGKFI+AnCMfzNpTa8uGcMo5/C5rY7QSFOsXmXUJLQGIVfKWoVc
         cOuA==
X-Gm-Message-State: AOJu0YweH21kSnKCZgXiR/XCT9e/WBnvedgJxvdvfHq9NHlleTg16729
	l1Ne9XYy5yWXda65w6RMYgmxQsOINROmTHQIFtgzcyN8QILAM3NCsaE1ldX7m0H5oblZAfZ1ZtP
	SUdbWtfD373sigobSL8AGm5ZGDEW0L9mHdE8V9Lu44dJS7lrQ3JC4
X-Google-Smtp-Source: AGHT+IHK4RG0Mf32g3RyJVsw84+iTVFIYCW5DLewI9I78LGN1eHejMhnR1NEKq4LWWsTiMklCpJht5wcvq9N6YOvyjw=
X-Received: by 2002:a17:907:25c2:b0:a8a:780f:4faf with SMTP id
 a640c23a62f3a-a90d5925392mr292207366b.47.1726874168746; Fri, 20 Sep 2024
 16:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkaqp_3YbK_qsq+v2=Q0r4xwTG9PbbPYjQdpTBu_Z7K5_A@mail.gmail.com> <SJ0PR11MB567893E61CB522991ED1379EC96C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB567893E61CB522991ED1379EC96C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 20 Sep 2024 16:15:32 -0700
Message-ID: <CAJD7tkbPcrHYGxCTTj7=YgXFcT6W4iek49cP_yHXWi2ce3jXTw@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai" <nanhai.zou@intel.com>, 
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"

[..]
> > If we really want to compare CONFIG_THP_SWAP on before and after, it
> > should be with SSD because that's a more conventional setup. In this
> > case the users that have CONFIG_THP_SWAP=y only experience the
> > benefits of zswap with this series. You mentioned experimenting with
> > usemem to keep the memory allocated longer so that you're able to have
> > a fair test with the small SSD swap setup. Did that work?
>
> Thanks, these are good points. I ran this experiment with mm-unstable 9-17-2024,
> commit 248ba8004e76eb335d7e6079724c3ee89a011389.
>
> Data is based on average of 3 runs of the vm-scalability "usemem" test.

Thanks for the results, this makes much more sense. I see you also ran
the tests with a larger swap size, which is good. In the next
iteration, I would honestly drop the results with --sleep 0 because
it's not a fair comparison imo.

I see that in most cases we are observing higher sys time with zswap,
and sometimes even higher elapsed time, which is concerning. If the
sys time is higher when comparing zswap to SSD, but elapsed time is
not higher, this can be normal due to compression on the CPU vs.
asynchronous disk writes.

However, if the sys time increases when comparing CONFIG_THP_SWAP=n
before this series and CONFIG_THP_SWAP=y with this series (i.e.
comparing zswap with 4K vs. zswap with mTHP), then that's a problem.

Also, if the total elapsed time increases, it is also a problem.

My main concern is that synchronous compression of an mTHP may be too
expensive of an operation to do in one shot. I am wondering if we need
to implement asynchronous swapout for zswap, so that it behaves more
like swapping to disk from a reclaim perspective.

Anyway, there are too many test results now. For the next version, I
would suggest only having two different test cases:
1. Comparing zswap 4K vs zswap mTHP. This would be done by comparing
CONFIG_THP_SWAP=n to CONFIG_THP_SWAP=y as you did before.

2. Comparing SSD swap mTHP vs zswap mTHP.

In both cases, I think we want to use a sufficiently large swapfile
and make the usemem processes sleep for a while to maintain the memory
allocations. Since we already confirmed the theory about the
restricted swapfile results being due to processes immediately
exiting, I don't see value in running tests anymore with a restricted
swapfile or without sleeping.

Thanks!

