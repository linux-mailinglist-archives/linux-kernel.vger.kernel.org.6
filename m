Return-Path: <linux-kernel+bounces-405017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 531B99C4BEC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3BB1F21CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE96619DF45;
	Tue, 12 Nov 2024 01:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xnb1/+RW"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12609171A7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 01:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731375413; cv=none; b=ObJMR80VzHT1LyPEIzchzC6kZ98TdpF2XNSgg8sLVl0wdPKDK7hzKn7pNCsyVHqQOExW5kfRhJu9CS0LSQQk3LIzSVFvzusiTV36bOl+utGssX9Fzx82y/KcekC7xpKgtDcj5XP81SCPpurJM4H39rYlXRlXPLWpQ+XO7+YIFrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731375413; c=relaxed/simple;
	bh=//amqcuL0aXQ3iDwZjzWgCMlLNStgCf1REgBivqBcik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9n/oAPOnPAXLjPgZtx4G6FFca6b780YlU2nnUFCS/2o9ybjHqE0shUfBTLI9t5jiLZx5nYR86+3j+kmLI+9I399r6EU+dWdcBVZFSbQChLaJUxiOhbpprPOveBtjqqMMDUhkW1Umt+sOseDPne3U5r/98izhq9a1YlukapC0JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xnb1/+RW; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731375408; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=R5QxhmAMwppwlQ+vZ04VhcEBN/cXpTBAqvhGBGhgXZw=;
	b=xnb1/+RWkK5lHphRiHzstmIg98KLZAkiSR0UbI4wUt7MOLgCNCRZ6Do3Pzao95PaT06s7lQYCy8u+hdmFS/fmXVK09huAzjHM9wO2C6e+09F3VC0JQ8dU3dXLg0uzRJ4t5WdgUXHJwzGnZMNJNok5QwvIDUJr5neJdrhLBFBZTg=
Received: from 30.74.144.120(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WJF5sWN_1731375405 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 09:36:46 +0800
Message-ID: <9633a282-dfd6-4327-bb05-4d03bb88718c@linux.alibaba.com>
Date: Tue, 12 Nov 2024 09:36:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix] mm/thp: fix deferred split queue not
 partially_mapped: fix
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <ziy@nvidia.com>, Usama Arif <usamaarif642@gmail.com>,
 Yang Shi <shy828301@gmail.com>, Wei Yang <richard.weiyang@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Barry Song <baohua@kernel.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Nhat Pham <nphamcs@gmail.com>,
 Chris Li <chrisl@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <81e34a8b-113a-0701-740e-2135c97eb1d7@google.com>
 <C4ECCA8C-FBF6-41AA-9877-4376EC94E021@nvidia.com>
 <6fcaaa72-4ef6-ebda-cf37-b6f49874d966@google.com>
 <3c995a30-31ce-0998-1b9f-3a2cb9354c91@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <3c995a30-31ce-0998-1b9f-3a2cb9354c91@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/11 05:11, Hugh Dickins wrote:
> Though even more elusive than before, list_del corruption has still been
> seen on THP's deferred split queue.
> 
> The idea in commit e66f3185fa04 was right, but its implementation wrong.
> The context omitted an important comment just before the critical test:
> "split_folio() removes folio from list on success."  In ignoring that
> comment, when a THP split succeeded, the code went on to release the
> preceding safe folio, preserving instead an irrelevant (formerly head)
> folio: which gives no safety because it's not on the list. Fix the logic.
> 
> Fixes: e66f3185fa04 ("mm/thp: fix deferred split queue not partially_mapped")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/huge_memory.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 03fd4bc39ea1..5734d5d5060f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3790,7 +3790,9 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>   		 * in the case it was underused, then consider it used and
>   		 * don't add it back to split_queue.
>   		 */
> -		if (!did_split && !folio_test_partially_mapped(folio)) {
> +		if (did_split) {
> +			; /* folio already removed from list */
> +		} else if (!folio_test_partially_mapped(folio)) {
>   			list_del_init(&folio->_deferred_list);
>   			removed++;
>   		} else {

