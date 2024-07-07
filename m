Return-Path: <linux-kernel+bounces-243461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE78929667
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 05:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF94CB213A0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 03:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094275227;
	Sun,  7 Jul 2024 03:07:46 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4F729B0
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 03:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720321665; cv=none; b=CtngVS6dEPs3u/gF89K87OdxFN1jIJe0ewAswnxzRSAqVU+8ZTxVGI8KfmbKYQUxOPNZdZAFRb8jTokU3eFJHntql2mLCy1kkaelsEWFHzTHOdheMMF9EXWyhWnYQ4VES/WDb0+h0o1mbd8Qqt0CMPFj/d18CjJDggaY2ArHXyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720321665; c=relaxed/simple;
	bh=Od9960aKch9lqmxoAz92nVMItoCL8B1mT9WY5A7etbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VEdoVCzGUH290mLoOXi7KqOZpQbStsBLfHsfjvWXTZuskJMmQbqgC1m7g7QFFB8yvlMsPTrLg0x+eFL+wNRIwZl0xIwh1q/pOmyckJeAmL/4GCjj0OpauqrTZ5inrPQzgCyGWhwXP/R7tfTE/Y9Chs2hc7RjMvv8nW0RfWAvBE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WGsZw4KYvzdgJ7;
	Sun,  7 Jul 2024 11:06:00 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 78D3418007C;
	Sun,  7 Jul 2024 11:07:39 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 7 Jul 2024 11:07:38 +0800
Message-ID: <55610a6f-dd13-4636-b13c-2d9269782687@huawei.com>
Date: Sun, 7 Jul 2024 11:07:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix] mm: fix crashes from deferred split racing folio
 migration
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>
CC: Baolin Wang <baolin.wang@linux.alibaba.com>, Nhat Pham
	<nphamcs@gmail.com>, Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
	Barry Song <baohua@kernel.org>, David Hildenbrand <david@redhat.com>, Matthew
 Wilcox <willy@infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <29c83d1a-11ca-b6c9-f92e-6ccb322af510@google.com>
 <20240703193536.78bce768a9330da3a361ca8a@linux-foundation.org>
 <825653a7-a4d4-89f2-278f-4b18f8f8da5d@google.com>
 <7b7f2eb7-953a-4aa0-acb0-1ab32c7cc1bf@huawei.com>
 <68feee73-050e-8e98-7a3a-abf78738d92c@google.com>
 <20240706191122.134c5ae35e86c68d52bf11a9@linux-foundation.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240706191122.134c5ae35e86c68d52bf11a9@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/7/7 10:11, Andrew Morton wrote:
> On Sat, 6 Jul 2024 14:29:00 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
> 
>>
>> What you show above is exactly what I had when I was originally testing
>> over the top of mm-everything (well, not quite exactly, I don't think I
>> bothered with the data_race()). But I grew to feel that probably everyone
>> else would be happier with less of those internals _deferred_list and
>> __folio_undo_large_rmappable() spread about.

Maybe some helper to check whether or not we should unqueue the
defferred_list, but it out of scope in this patch, and maybe not worth it

>>
>> There are many ways to play it. I had also considered doing it Zi Yan's
>> way, freezing always in the !mapping case as well as in the mapping case:
>> what overhead it adds would probably get lost amidst all the other overhead
>> of page migration. It will not be surprising if changes come later requiring
>> us always to freeze in the anon !swapcache case too, it always seemed a bit
>> surprising not to need freezing there. But for now I decided it's best to
>> keep the freezing to the case where it's known to be needed (but without
>> getting into __s).
>>
>> Many ways to play it, and I've no objection if someone then changes it
>> around later; but we've no need to depart from what Andrew already has.
>>
>> Except, he did ask one of us to send along the -fix removing the unnecessary
>> checks before its second folio_undo_large_rmappable() once your refactor
>> patch goes in: here it is below.

OK, let's keep it simple, thank your for pushing it out.
> 
> Grabbed, thanks.
> 
>> [I guess this is the wrong place to say so, but folio_undo_large_rmappable()
>> is a dreadful name: it completely obscures what the function actually does,
>> and gives the false impression that the folio would be !large_rmappable
>> afterwards. I hope that one day the name gets changed to something like
>> folio_unqueue_deferred_split() or folio_cancel_deferred_split().]
> 
> Naming is important, but so also is commentary.
> folio_undo_large_rmappable() lacks any.
> 
>> [PATCH] mm: refactor folio_undo_large_rmappable() fix
>>
>> Now that folio_undo_large_rmappable() is an inline function checking
>> order and large_rmappable for itself (and __folio_undo_large_rmappable()
>> is now declared even when CONFIG_TRANASPARENT_HUGEPAGE is off) there is
>> no need for folio_migrate_mapping() to check large and large_rmappable
>> first (in the mapping case when it has had to freeze anyway).
>>
>> ...
>>
>> For folding in to mm-unstable's "mm: refactor folio_undo_large_rmappable()",
>> unless I'm too late and it's already mm-stable (no problem, just a cleanup).
> 
> Missed the mm-stable mergification by >that much<.  I'll queue it
> separately, thanks.

