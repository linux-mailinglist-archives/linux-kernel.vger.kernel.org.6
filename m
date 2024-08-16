Return-Path: <linux-kernel+bounces-290139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA1E954FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 19:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B47B26892
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219921C0DF4;
	Fri, 16 Aug 2024 17:20:10 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F362BB0D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828809; cv=none; b=tnCkR/I+ZspdXtD/MFDLkjPZZFEBp4UQ2nk76psyMJnYyV3ewMhkt/lQiGBDmjA1JzdcOZyExbY4tsVHJU4USAGj+LSATMPV+kyQpRwxZE5eXWXKKIM9waF7v07lcQZM3rMPYpatfpH1W6nvqyYHemiiYp8OhFN2aS4gyJ415d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828809; c=relaxed/simple;
	bh=e3phVXKELaSTBXuaKA2GlivK10kzLcGBdVJ6hbsKPQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLjcPEfuxjTkM37VyeWVJqIMqsYqbRwS8krnLmX/qoepW4dcuhy1SFPxxQHfbJohQrEYBbZ3zvWJSaHesnt4Q3CUpVoesLvJvCsxY3uiljEmFYN9CDOXAb8Z0Wox4r7VkMzkhaD2A6Q9Xuc9f2H0lDzDtWaRSVYSXqjVwAwkGo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff443so700528a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723828806; x=1724433606;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2B98Nonj1jzFfjj1Awg4MNY0m0jU2jq1yoh+TEZjSn4=;
        b=OO0triDNsWUYSzyPi9lwtgJNIYSa/T+v0nnLEAA8SBoMTH7JqqzBQX73B9HxGCY2pQ
         NQ9lVAeGr9OYvE8V8NQMz8mDcDVmfGFaizN0wV+vXhNGMDdTYGNoezlP4pGJ3cNO2aZC
         1PNf8jk8taEZ16GYVy3Q4+CvJIVoWtt+vmAvNJLykdqfmSVugIatulDquhVdejiTeoC9
         xKIbEZHFdL49VpSRmeLKEJynXihuC9IqMKN2J/kvu7YqJr7+PsSOqPNPo8S99jmLmPQN
         vo5t6n7sKytQrpSdE/dwo5ulD/jkDIno4ZLMVS2quqEd+Cqnb8uHsLQDlZpL8hA1jSoQ
         XH0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXE0EGktto4F317rqgjXTWli8T/QPLthos5YKwSmznarMq8B3oZH7FaqAKOId5+O+rqPx+pCxuLCCGOaPydxEWYOeoGjGldMxcvtAt0
X-Gm-Message-State: AOJu0Yylco9OJVtmUwX6F8k+qmqfvwP73G6VRi7aPSa1JadY4BYdQWNm
	zsmS5+tsg2lvrhnfZLqawdWc/sqdsJPTpOujOFWpJI7x5akcPoGw
X-Google-Smtp-Source: AGHT+IErgx2mGn2Su3AsLtqSwk2+dy99ojrmcMNI4BLm5EPybbzQuGKcdYQ795uIs0b+OUtDnOdthQ==
X-Received: by 2002:a05:6402:27d0:b0:5be:b3fd:a1be with SMTP id 4fb4d7f45d1cf-5beca5032ddmr2585349a12.3.1723828806044;
        Fri, 16 Aug 2024 10:20:06 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-113.fbsv.net. [2a03:2880:30ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbdfb87esm2503638a12.50.2024.08.16.10.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 10:20:05 -0700 (PDT)
Date: Fri, 16 Aug 2024 10:20:03 -0700
From: Breno Leitao <leitao@debian.org>
To: =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Minchan Kim <minchan@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Zhaoyang Huang <huangzhaoyang@gmail.com>,
	=?utf-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>,
	"riel@surriel.com" <riel@surriel.com>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>
Subject: Re: reply: [PATCHv5] mm: skip CMA pages when they are not available
Message-ID: <Zr+KQ4/iiIqmkUSk@gmail.com>
References: <a74760bd1d81467db2a03b77d3aef7d3@BJMBX01.spreadtrum.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a74760bd1d81467db2a03b77d3aef7d3@BJMBX01.spreadtrum.com>

Hello Zhaoyang,

On Tue, Aug 13, 2024 at 09:58:32AM +0000, 黄朝阳 (Zhaoyang Huang) wrote:

> >I've been discussing this with colleagues and we're speculating that the high
> >contention might be linked to the fact that CMA regions are now being skipped.
> >This could potentially extend the duration of the
> >isolate_lru_folios() 'while' loop, resulting in increased pressure on the lock.

> >However, I want to emphasize that I'm not an expert in this area and I am
> >simply sharing the data I collected.

> Could you please try below patch which could be helpful
> 
> https://lore.kernel.org/linux-mm/CAOUHufa7OBtNHKMhfu8wOOE4f0w3b0_2KzzV7-hrc9rVL8e=iw@mail.gmail.com/

Yes, my colleague Usama have tried it, and it solved the problem. Thanks
for the heads-up, it was very useful.

--breno

