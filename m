Return-Path: <linux-kernel+bounces-558587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA885A5E832
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164FD179CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42BB1F1515;
	Wed, 12 Mar 2025 23:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="gbfPdCVt"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F241F12F8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741821426; cv=none; b=VJhH79loVNUMEVov2uHgUjvmViBq0Om0Zr+fM/Ld5gnMTMAgNC6MXxPX5lRDO7rM98c7StX8y1HPWgKoti7tHTPA1peswOenSePF2Jfx3pH+C65i6Q4ik00bfSP0pbtxcRgR5xEVD0JKxNF2bvU51hdj//dCkPKZfiznARRBG50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741821426; c=relaxed/simple;
	bh=FZ1ugHb4fdvNjyvvwcChzdpAnvobgQjfPwOpqcpZLYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGNy4povQ7DhzKUz2qkUAGdFlYTay0w/kCv5KrtF1Y20w1Fg/P317rH3TbhK2Py2oWgWGC/hM5agymDENucSLAT/2CyDmhOE/VVA8FMAP5YtZqn0+bq37999HagP/vWDTolOYmN9CbpdNyYmn5dXm6f8oovMKpCn9pPh5llZ7MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=gbfPdCVt; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c2303a56d6so34175585a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741821422; x=1742426222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b0m0501pokvAdKI76mDPAcdtgGT7lXQgkQXJ23hE5nI=;
        b=gbfPdCVtbN1ZFpeYki24kssf0GJUQdq2bDqjhSVjCcfVWKd/tPVeoB47KcNI63jY7j
         DsTmV+ojaERegxwazNJ+mwsCdAv/ooqQTkGJWJm12NQwf79zXlJ8Dqhctph4DhLZWH/V
         zoQ+94ExJQpKZJz26qIUNMCzefMKT7YuMkrFb1rwWLDIbJgn/2njFvh2UC0qBRS2XO60
         TaeqcujNedKJ7pPnw8GmRmk35nOcnmgYT72Jy4Ayz6rdrY7fX0kVLshexrb4gRztZFKq
         gCibriflpgFwjMt1zjIWrfIVV/FVh3wleAZtTjXVrXOn5FdENl2v4A7y78SW8X1FdMZI
         sN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741821422; x=1742426222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0m0501pokvAdKI76mDPAcdtgGT7lXQgkQXJ23hE5nI=;
        b=THmC9ulvoi1ZR59xOd8vG7VQVt21QHmTVV2KJgqP1mQVj5HXrmeaibpBkSyf7UFW+A
         527n8DWgnRbDzSA6qPvHwj6fACGfAbwAJetB5BKPu3/fmiQyl51zTStQCJ9SVBF9PZfC
         1bHSN6UhkkJqcXgslw9QYfbvnMOE0hXbE/vGiBMazndEwGiO+wIXYF13T9hYVk74SKaZ
         uDzO1pJBlLIkvs/y/xr8CLFnLWbqWfIgpJYJTZt7xGQJf/XKysPJX0hv2RMKIbI4Z5pE
         BgSdknoy7sF55fn6fOPgbYnviiJP3jpAj1OAgh+7OUdWqCfmuk2RD4qmU6Jvrsxn+xhG
         66Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUens6eEPnq5QFJ3LiQqX7JNTG2rHVsd4Qk3sLWA7czzv4avhmt7ekKsvQD2qLo3F+7nQBl2gBvr8jU49E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSP5avaaQzEtOySXnUGxfFBKZLFaoUMMeH2Tz8bmVWpcUXg/yF
	rvT/Qd54dCkG5XkHcxa/hCz8LShrStrq7Np9byPHOe8oPcdzoAwcHrxu2fB33qM=
X-Gm-Gg: ASbGncvGxhLIpN/s8lZikk6WqNUpLMNMwWJBEnxridhlA0faGhVXVns84qyUQUJMaPw
	dwLh/Iy9hzt+dYyb3ohQxABcIeVYCb6gkDyDQ5lyMhQa77VyLTDZb6F+bzzZH8lN3hrDVodvjLM
	VmDt7AxETeJgp6gPgBepv+MQItjeTlhobvHOUkulapjsVPZYBt2ygDS87SboglzjgLgGJoK6nbk
	cs9S3ZgtGjy/EGt+ggq8v34CEeIkixutq8QUDnTwEpWXtZNIMXoYynWKLKv8fE4UoN1gNiBknSx
	aWuKQNvzUf4JjMcPZA6fybkQHjepOzQUlcZ/1jdVUyA=
X-Google-Smtp-Source: AGHT+IGtp153ZWR+MbU3stE6h8mUZoXbyIW4Eqg0BhbB1QDMSodZjMC1EJSVujqK42nfMeGZ5sRL2Q==
X-Received: by 2002:a05:620a:2b89:b0:7c5:467d:ca82 with SMTP id af79cd13be357-7c5467dcb3fmr2710837885a.45.1741821421669;
        Wed, 12 Mar 2025 16:17:01 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c714cbsm14629085a.30.2025.03.12.16.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:17:00 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:16:56 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, muchun.song@linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: skip the file folios in proactive reclaim if
 swappiness is MAX
Message-ID: <20250312231656.GB1247787@cmpxchg.org>
References: <20250312094337.2296278-1-hezhongkun.hzk@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312094337.2296278-1-hezhongkun.hzk@bytedance.com>

On Wed, Mar 12, 2025 at 05:43:37PM +0800, Zhongkun He wrote:
> With this patch 'commit <68cd9050d871> ("mm: add swappiness= arg to
> memory.reclaim")', we can submit an additional swappiness=<val> argument
> to memory.reclaim. It is very useful because we can dynamically adjust
> the reclamation ratio based on the anonymous folios and file folios of
> each cgroup. For example,when swappiness is set to 0, we only reclaim
> from file pages.
> 
> However,we have also encountered a new issue: when swappiness is set to
> the MAX_SWAPPINESS, it may still only reclaim file folios. This is due
> to the knob of cache_trim_mode, which depends solely on the ratio of
> inactive folios, regardless of whether there are a large number of cold
> folios in anonymous folio list.
> 
> So, we hope to add a new control logic where proactive memory reclaim only
> reclaims from anonymous folios when swappiness is set to MAX_SWAPPINESS.
> For example, something like this:
> 
> echo "2M swappiness=200" > /sys/fs/cgroup/memory.reclaim
> 
> will perform reclaim on the rootcg with a swappiness setting of 200 (max
> swappiness) regardless of the file folios. Users have a more comprehensive
> view of the application's memory distribution because there are many
> metrics available.

I'm not opposed but can you be a bit more specific on your usecase?

Presumably this is with zram/zswap, where the IO tradeoff that
cache_trim_mode is making doesn't hold - file refaults will cause IO,
whereas anon decompression will not.

> With this patch, the swappiness argument of memory.reclaim has a more
> precise semantics: 0 means reclaiming only from file pages, while 200
> means reclaiming just from anonymous pages.
> 
> Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>

Makes sense to me. With the doc update Andrew had asked for,

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

