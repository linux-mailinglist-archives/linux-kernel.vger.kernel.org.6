Return-Path: <linux-kernel+bounces-275030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6CA947FCA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976141F217D7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C921015DBBA;
	Mon,  5 Aug 2024 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Kx8OYBrv"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9530915B57B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877183; cv=none; b=jAUUWgX1Ony0ndC2BiPUdTbhh9UzxbfGPYUHoisj6LiRAb1AmTAa/0J3JwWf89DZJGlxfg2BwRHyn5mx6h8mAFfbRJEtAbn6apf2rtoyyfXEKLQ5wXJw2qTHdTyUS3B1lcJnTm3lVsXJOZMS0JYeEFa3KE0bh4kjizSSfqOeEiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877183; c=relaxed/simple;
	bh=jzSHPWgtcFGK0Tt/clWdJLEFG4a0MsPE8k3d/lXoqFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBt1td91hATIb/GDqmJby2OPCHNWHdIRv6p04QfYHNTuj9liEHKzQ4CRqWlN3RnQYb8mhOtoU4bROsrluMsJvPj8+VzUPasiNcue8mg3joqwD4eNX1oMCKDTWibF8A1texlnfyzb2YJ6IWXheNt+v+cWq0LodJyMcF4NS8NqfPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Kx8OYBrv; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-70949118d26so7472514a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 09:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1722877178; x=1723481978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4sY3wVahkeTjr7y3XzuhW2Q3UgOPrPRQ13FjqmX75pg=;
        b=Kx8OYBrvBRcbBGJmfITCv0zwdFpgbtXOKn6ebMB/QEIIU2c7XZ8bXjN8lDwqkZTZsa
         15sJAavygR0IE0T+h/ge7QOtTElAizY9W7w/KtVm7Axw3YyAxUjVQtJUu2neME2nsrrN
         JVIGfOLeLnyPYBSjWCnBEGK9vNyqY10RmPlxiUlNiDGKVZu+PUxIb8F5k2HgeMNqwK6A
         kdBgfkqQ19WldppM7rvPgdJQU/YiVrYoy0tgsi5rmnnSd92HIXj82KyJnpYKGEoUUMfz
         1a8fKoWs1rpno1EzMXSQY11O8p2G/iPm7KlDOliCDewGPUVCUoLhNxg5SuMH4Cb/Iwph
         F+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722877178; x=1723481978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sY3wVahkeTjr7y3XzuhW2Q3UgOPrPRQ13FjqmX75pg=;
        b=r/GXM5BNvjNxQSy7HJeW8p/AmyYRDyCLOMq12AyTAlcdOa0/esVnbh1FhzPnicXjjj
         5kC3p1NMJqthCh8XcgWwQXRJuLHeIB3U4zvnaQDmQoBvWWYrQeqIXRqzgDnOU+Tz5jU0
         5QWorJHtuihU/K5+406Gqsl9vzNPDDetVKkhflKB5Rat9OCX2nfpSbE3Cr7V6pjXhnl9
         m8H1uQYm4w5NHFVfoABPbJzwV96aARr2vWTftMzam9Ryk/zIXeM8U3jXlgYNcE6z1+rZ
         VDktlV6S/kWT1WoVdEYa9ZT1FALb0oSfBt+qs67vIyh027tfnWfN4qJZdWwg9HpHddXu
         smzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzC2Y+mG7H6WZ5C4Th5ZNtNSmjPQJ7mxlsuPWzJ8fQ8QP2mgtOvUWhGql4L4pXP5tjx6rXIQW55daKJ0K2h253+N0n0J1olvHNljYD
X-Gm-Message-State: AOJu0Yw/IaU3dvhXH2LKoHNExkIBvck/0cIjMcWKskAXOjcPlP4FGoa9
	zV9T9KVZfrKOA3An/X5J8/BX3DVXDns3TSFQnDzUoU7hgzyX1qrlgwHarV6qzBQ=
X-Google-Smtp-Source: AGHT+IFMxRsrpmwDYJ+JtzAr+Cs0xEeI2ll7tUvkgy3WI1DpJ38nhDEPZEy+gLiEAOohp95KGIz6Gg==
X-Received: by 2002:a05:6830:b85:b0:709:4c6a:b98a with SMTP id 46e09a7af769-709b996d713mr14582748a34.30.1722877178571;
        Mon, 05 Aug 2024 09:59:38 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f78b7a5sm368699085a.122.2024.08.05.09.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 09:59:38 -0700 (PDT)
Date: Mon, 5 Aug 2024 12:59:37 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH] memcg: protect concurrent access to mem_cgroup_idr
Message-ID: <20240805165937.GA322282@cmpxchg.org>
References: <20240802235822.1830976-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802235822.1830976-1-shakeel.butt@linux.dev>

On Fri, Aug 02, 2024 at 04:58:22PM -0700, Shakeel Butt wrote:
> The commit 73f576c04b94 ("mm: memcontrol: fix cgroup creation failure
> after many small jobs") decoupled the memcg IDs from the CSS ID space to
> fix the cgroup creation failures. It introduced IDR to maintain the
> memcg ID space. The IDR depends on external synchronization mechanisms
> for modifications. For the mem_cgroup_idr, the idr_alloc() and
> idr_replace() happen within css callback and thus are protected through
> cgroup_mutex from concurrent modifications. However idr_remove() for
> mem_cgroup_idr was not protected against concurrency and can be run
> concurrently for different memcgs when they hit their refcnt to zero.
> Fix that.
> 
> We have been seeing list_lru based kernel crashes at a low frequency in
> our fleet for a long time. These crashes were in different part of
> list_lru code including list_lru_add(), list_lru_del() and reparenting
> code. Upon further inspection, it looked like for a given object (dentry
> and inode), the super_block's list_lru didn't have list_lru_one for the
> memcg of that object. The initial suspicions were either the object is
> not allocated through kmem_cache_alloc_lru() or somehow
> memcg_list_lru_alloc() failed to allocate list_lru_one() for a memcg but
> returned success. No evidence were found for these cases.
> 
> Looking more deeper, we started seeing situations where valid memcg's id
> is not present in mem_cgroup_idr and in some cases multiple valid memcgs
> have same id and mem_cgroup_idr is pointing to one of them. So, the most
> reasonable explanation is that these situations can happen due to race
> between multiple idr_remove() calls or race between
> idr_alloc()/idr_replace() and idr_remove(). These races are causing
> multiple memcgs to acquire the same ID and then offlining of one of them
> would cleanup list_lrus on the system for all of them. Later access from
> other memcgs to the list_lru cause crashes due to missing list_lru_one.
> 
> Fixes: 73f576c04b94 ("mm: memcontrol: fix cgroup creation failure after many small jobs")
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Great catch. This has been busted for ages, but the race is so
unlikely that it stayed low profile.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

It probably should be Cc: stable as well.

