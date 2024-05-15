Return-Path: <linux-kernel+bounces-179367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1328C5F54
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 05:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42331F2222F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 03:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351C537703;
	Wed, 15 May 2024 03:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R+aydqCr"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3990381AA
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 03:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715742644; cv=none; b=HtcIbi0kmDZ7e6oo2/ji8xJuGb/p7pPZfwMHkIm2rEJDwhnRXw9FVpSTO7GqgD2xUPu/EDASEJz6/40tn2K+7lFAHQKDj9tC5rRROLgxAnxYITubq3Py6ToNMpbR2RsEMc0vJkeCGe4MkgxivWuHR7yoynPIKD4Yxv2FQQR4ZFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715742644; c=relaxed/simple;
	bh=Ugc/5ryD8iJ6YmLDn4he7k2/Y6l2NsxOP4STVxtlRcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxFRXc+KesEE6RkUXK7WFVMYM9ihHAKgWfgfJkHz81cIyKU+115V4vW2k8cpE0J0hipX7lBskqEbwMEbTL+EToariu8AWt59vlcQGUkCPsBK9Z+S57TDHggQmOjim9HXnmFrrzHJAu84AK9x0sPeZOygWumrr63I69fqMHhXhus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R+aydqCr; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <150ccdc2-48c7-40ac-b027-e8f92e2a0500@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715742639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eV2DcCFvjQwjt5xtoWQWY0rPJ2R7dBNba4dqmpplCv4=;
	b=R+aydqCrMxtqn5feQlFGxwHN8aVQ7zW44AuJnCgpm8cMEnp4udyWYt/akmKLjP0X1US8ED
	tefClwsErzA+irR5AJPtCdW36VXaV00G77i+Q2hRq2xWwz8lywubTC38z2EAPCflXiufPm
	qKykHM1XJAMu/FMJmbmlB0m/XhavcmQ=
Date: Wed, 15 May 2024 11:10:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/ksm: fix possible UAF of stable_node
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Stefan Roesch <shr@devkernel.io>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20240513-b4-ksm-stable-node-uaf-v1-1-f687de76f452@linux.dev>
 <74a72eeb-122f-453e-baa7-63504e7c4bd8@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <74a72eeb-122f-453e-baa7-63504e7c4bd8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/5/15 04:46, David Hildenbrand wrote:
> On 13.05.24 05:07, Chengming Zhou wrote:
>> The commit 2c653d0ee2ae ("ksm: introduce ksm_max_page_sharing per page
>> deduplication limit") introduced a possible failure case in the
>> stable_tree_insert(), where we may free the new allocated stable_node_dup
>> if we fail to prepare the missing chain node.
>>
>> Then that kfolio return and unlock with a freed stable_node set... And
>> any MM activities can come in to access kfolio->mapping, so UAF.
>>
>> Fix it by moving folio_set_stable_node() to the end after stable_node
>> is inserted successfully.
>>
>> Fixes: 2c653d0ee2ae ("ksm: introduce ksm_max_page_sharing per page deduplication limit")
>> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
>> ---
>>   mm/ksm.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index e1034bf1c937..a8b76af5cf64 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -2153,7 +2153,6 @@ static struct ksm_stable_node *stable_tree_insert(struct folio *kfolio)
>>         INIT_HLIST_HEAD(&stable_node_dup->hlist);
>>       stable_node_dup->kpfn = kpfn;
>> -    folio_set_stable_node(kfolio, stable_node_dup);
>>       stable_node_dup->rmap_hlist_len = 0;
>>       DO_NUMA(stable_node_dup->nid = nid);
>>       if (!need_chain) {
>> @@ -2172,6 +2171,8 @@ static struct ksm_stable_node *stable_tree_insert(struct folio *kfolio)
>>           stable_node_chain_add_dup(stable_node_dup, stable_node);
>>       }
>>   +    folio_set_stable_node(kfolio, stable_node_dup);
>> +
>>       return stable_node_dup;
> 
> Looks correct to me.
> 
> We might now link the node before the folio->mapping is set up. Do we care? Don't think so.

Yeah, it shouldn't be a problem, although it doesn't look very nice.

Another way to fix maybe "folio_set_stable_node(folio, NULL)" in the failure case,
which is safe since we have held the folio lock.

> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

Thanks.

