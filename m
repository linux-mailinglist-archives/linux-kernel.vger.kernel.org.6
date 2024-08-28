Return-Path: <linux-kernel+bounces-304547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF1A9621A0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFE51C23FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6011915AAB1;
	Wed, 28 Aug 2024 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2zz3nOna"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7AD1552EB
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831066; cv=none; b=shdkpjfeSJwZITEeBMcqroAmPe94nMTaEk+k2s6ecZ5HaDi1am6+ynfo2JHrAR0NyupEead7kcqw5unI3txThfnYAvu8zMjhjALtryXrRduuBquuCVWUHq51o8zLBuU/KRdEBu0IV6F31P57rSrw89kJwGe0tKkSSWsi3s9hVUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831066; c=relaxed/simple;
	bh=P1SGtxe3LJWnrEFmfRwmJX3rq26Smm/57691EhDFOtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3zNd9TVdZVC7PKkIYTquJA9N3u2BghV5sNQWIkiOivYYAm5vcWt6TVm6Sg4hWWoRHjRSe51ozmi1pn/W52HJLFxTS75T30PmMxHIy/osdoTnVD5Zy+HCowPQdQ8XBeK46qMs9jb574AZmfxKSe6xiT+jJ1LFuSdcwstqt32FPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2zz3nOna; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bed0a2ae0fso7963990a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 00:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724831063; x=1725435863; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P1SGtxe3LJWnrEFmfRwmJX3rq26Smm/57691EhDFOtw=;
        b=2zz3nOna0Ky89ti6sxKBzYby4taYXB4tFdOUbBqRDO55IW6izSGfIJQ642VZTHNHZT
         h3Pd/XcCW/JU79+LbwOSEq0rhQ3ihOelF0eLCSqcRCNuh38Ifj2cxIYYRrXaYOTnfp3o
         28ZOmdQ5iETkBMSX2wV6OitsffyOAvfcjEeLSg7wxP77H6wjNCW/Emxv5AQBnjx1bWmE
         bGobRH6bG6BDGdVhqEnAgzfHqpo6jJX3mkNwZBYMNE/ZLSQn5oF8GDFOi7O6LDXXK2q5
         x/0qtPZ7hP1KAHKWFXXwmwZkwdTscoYtFmdmFlhHAjBQl0dxvpijsTil+RD59JVRFvXR
         oCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724831063; x=1725435863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1SGtxe3LJWnrEFmfRwmJX3rq26Smm/57691EhDFOtw=;
        b=tnWUPflfMKC0fs4fyFY/DAjPwhFmZVbYdIlFb1eLOxZlB96URFVDtZQAtR+wnHJJuO
         ruyssd2tGx3jTIqkbQ5l32dVNzCvnTXG/rGFfk3OZ6CNxnTcOhiYGg/oiemg7OrLmg6z
         U4BESo7331yEAn196oBxYTSBlIncl7rhxew3delRpxYHR4r28wACE4vTiJ+pmeSH639R
         LpugviHHaWmSWv5cNrcNkbnawPXWL8SNNXaUohGjFFs0LSQ0ApGtGUl8DNrNM5GaQyXw
         SFsLN/hRm9RJaeGc6s/CXgScUxh7c3uO0QX2D4ym5Jw2JMriN3Y+WgTgwZuVnkSrIu5h
         mQ4w==
X-Forwarded-Encrypted: i=1; AJvYcCW3lz526pIV1PMYk9y6AgqwwQElQV6XHfAOz9twI+c4iEJk88gcouPvtwMibO2sjbisgY3n9+1aPe+/qQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww20gPYXrhTZxF1xsM+nXNP+60N1Jkzl0BZVipRsLjzcPTyF8y
	FMXyr1PKOk5KO1JfdxLo2tlzHNamU/GVRObl0RU/rlhWwyjcTuq3/qoE62qvednCit9/1w4z2G0
	H/yRvofzZiGroBwE+gvabb/ArS8wtJdq5QzF5/hGnWGm4VIQoBw==
X-Google-Smtp-Source: AGHT+IEt3auLBz+8ctUX4K+GsmZnMbeCZLriBqlM/+qFiYssZzYH6PGYYK8mpK4GN058/6bgrZuqGw3a8/d3MyhfMCA=
X-Received: by 2002:a17:907:86a4:b0:a86:9fc2:8395 with SMTP id
 a640c23a62f3a-a86a518b2ebmr1217425466b.11.1724831062592; Wed, 28 Aug 2024
 00:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
 <CAKEwX=OO6frFa+S3xjtoabB2dY1Y5RN5qjMsVUsgKDK_QuOFzg@mail.gmail.com>
 <SJ0PR11MB5678288EE890E8CB882839CDC98E2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <SJ0PR11MB567801EE747E2810EF183C73C9892@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=PYv4Cn_a7WSnbUyhwSBO61xoDPSexXxS0uwwxu5P6XLw@mail.gmail.com>
 <SJ0PR11MB5678E44062CADBE8BAB546F3C9942@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=ORuJabxQSehU5E0QNG=Gx6QkyTCb1vek3AOcQuvF54Xg@mail.gmail.com>
 <DM8PR11MB5671D72CED6850CDBB62B95FC9942@DM8PR11MB5671.namprd11.prod.outlook.com>
 <SJ0PR11MB567807116A760D785F9822EBC9952@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB567807116A760D785F9822EBC9952@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 28 Aug 2024 00:43:45 -0700
Message-ID: <CAJD7tkb0Lnq+mrFtpba80ck76BF2Hnc9Rn8OVs_7dqmE2Hww2w@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Nhat Pham <nphamcs@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai" <nanhai.zou@intel.com>, 
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"

[..]
>
> This shows that in all cases, reclaim_high() is called only from the return
> path to user mode after handling a page-fault.

I am sorry I haven't been keeping up with this thread, I don't have a
lot of capacity right now.

If my understanding is correct, the summary of the problem we are
observing here is that with high concurrency (70 processes), we
observe worse system time, worse throughput, and higher memory_high
events with zswap than SSD swap. This is true (with varying degrees)
for 4K or mTHP, and with or without charging zswap compressed memory.

Did I get that right?

I saw you also mentioned that reclaim latency is directly correlated
to higher memory_high events.

Is it possible that with SSD swap, because we wait for IO during
reclaim, this gives a chance for other processes to allocate and free
the memory they need. While with zswap because everything is
synchronous, all processes are trying to allocate their memory at the
same time resulting in higher reclaim rates?

IOW, maybe with zswap all the processes try to allocate their memory
at the same time, so the total amount of memory needed at any given
instance is much higher than memory.high, so we keep producing
memory_high events and reclaiming. If 70 processes all require 1G at
the same time, then we need 70G of memory at once, we will keep
thrashing pages in/out of zswap.

While with SSD swap, due to the waits imposed by IO, the allocations
are more spread out and more serialized, and the amount of memory
needed at any given instance is lower; resulting in less reclaim
activity and ultimately faster overall execution?

Could you please describe what the processes are doing? Are they
allocating memory and holding on to it, or immediately freeing it?

Do you have visibility into when each process allocates and frees memory?

