Return-Path: <linux-kernel+bounces-266701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D8B940591
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEDB51F21FC9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC5142047;
	Tue, 30 Jul 2024 03:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bRjvF600"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5E38BE8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722308414; cv=none; b=bQotS8KoShB4agRWuD8Pg7yVJK3ULgueyoa1Q9/ckyFzoOyjkrUVh8rWxJUllLacj3g2B4KvbPtU68AkQDAxafQWrKrDNuT/L/Cv7lG8Ti1+n3X5XsnXtJA0vWrMlQ6Ea1m3we4Kr2NE0OE7cazYpwNTt73Zutlk8dYAofC13mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722308414; c=relaxed/simple;
	bh=SyQTVsJ8zw+iyhHrww7rgDqvdXo1huZkJcBHLWIvHcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ba/8ugRGO06YPESGj07E1LQiPvhI6N5n0vryASUs7e4QnSgMtpYUovXg4XO3Lf554rkQopCdLrVITdmVirb8tLZXg5/F1gL2FooSSCOIxpBf+drGOZ/UTNiiYExFri/tDyKANc5Lv/WdjnuHvjgOxc8FaTtbUtpn2EcORUzj3sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bRjvF600; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722308409; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MeDQ5q2eLqwizDxL98AFdYvON15VUTTwlbfkkWpDVdo=;
	b=bRjvF600x1QHP0x+Dp0rFGHxtK3W0W6pbGphekcy3kf3yKllG1HqGlk3ztcTsCHXTidHccRGDBbDZPFT0Iw/+2Y4/oxR25St3vZipJoqAcizztpkdAY4X9TSUFqNdOB6Rtf2b9gcj8AA5RwcMyt7CPk0DxOSihlEHpbXIIwqofI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0WBe0bBR_1722308407;
Received: from 30.97.56.73(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WBe0bBR_1722308407)
          by smtp.aliyun-inc.com;
          Tue, 30 Jul 2024 11:00:07 +0800
Message-ID: <c2122229-3710-4e16-8932-303da0644a6a@linux.alibaba.com>
Date: Tue, 30 Jul 2024 11:00:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] mm: swap: introduce swapcache_prepare_nr and
 swapcache_clear_nr for large folios swap-in
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: ying.huang@intel.com, chrisl@kernel.org, david@redhat.com,
 hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com,
 minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com,
 senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com,
 surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org,
 xiang@kernel.org, yosryahmed@google.com
References: <20240726094618.401593-1-21cnbao@gmail.com>
 <20240726094618.401593-2-21cnbao@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240726094618.401593-2-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Barry,

On 2024/7/26 17:46, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache") supports
> one entry only, to support large folio swap-in, we need to handle multiple
> swap entries.
> 
> To optimize stack usage, we iterate twice in __swap_duplicate_nr(): the
> first time to verify that all entries are valid, and the second time to
> apply the modifications to the entries.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

LGTM. Feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

By the way, my shmem swap patchset[1] also relies on this patch, so I 
wonder if it's possible to merge this patch into the mm-unstable branch 
first (if other patches still need discussion), to make it easier for me 
to rebase and resend my patch set? Thanks.

[1] 
https://lore.kernel.org/all/cover.1720079976.git.baolin.wang@linux.alibaba.com/

