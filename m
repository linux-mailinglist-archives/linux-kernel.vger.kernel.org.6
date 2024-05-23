Return-Path: <linux-kernel+bounces-186885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043F88CCA61
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 03:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99E12825A5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F4F1C36;
	Thu, 23 May 2024 01:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gX6ogx6C"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57086FA8
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716428282; cv=none; b=FJjhKsA1Zh65ltYklnWkXbF1mFeZBddidbuYkdP7LuuIsbhH1LJ84Fs32ZVvGUXrmKjstnW+f0UDoRznxAOvPRF/tiGuNUkpItGpdVYHYEOyl8rfl33xBkCXa9pVoy4Bl41yx7vjGZXIf2Su/RKz4YlyQ519slJz8GdEZelyRog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716428282; c=relaxed/simple;
	bh=IaaBnmqrE5GrOWnChjQosi39vJwLyOpYDRlQ6Ayg2YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iz7wFVS3T3VjhKHO7lLEJSSugxrXtZi2JBBYZEwzkwvDaVXd0FcxhKAV3jntLElN5eQUOUn6lnstHsnX547Guel+GwJFQc05a2hfP4lLkl36bvMk4lHph0wuYBjOoSw5kBy3+9Tk8GRl3DsaVKVSuvZXVgs9PIxulkLlM99zfFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gX6ogx6C; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716428277; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=09MSV1/3zxYWr14W2ElPhQ9LPPVHhGubVkw27PQ/8ls=;
	b=gX6ogx6C/lr631cFo7uLCYrD4qrNwPeVYjMjri4TWdnDnVDoxWuwZeEwZHE9BJnSfZtBNwjy08uwDfi09CrTi7y7jRYaoPZ4fNVK/bxLjTRwgslusLCK2T4ajhvWHTSTxLeFcSUlBGQo48Mfpj21hmkLg4pHnR6AlPf1JovOPgs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W70hHJ9_1716428275;
Received: from 30.97.56.57(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W70hHJ9_1716428275)
          by smtp.aliyun-inc.com;
          Thu, 23 May 2024 09:37:56 +0800
Message-ID: <18aa865a-6d4a-4dcf-99ce-bcfbc0c92f19@linux.alibaba.com>
Date: Thu, 23 May 2024 09:37:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: drop the 'anon_' prefix for swap-out mTHP counters
To: "Huang, Ying" <ying.huang@intel.com>, Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 willy@infradead.org, ryan.roberts@arm.com, ziy@nvidia.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <0e2a6f232e7579a2e4407ecf075531980d97f286.1716367360.git.baolin.wang@linux.alibaba.com>
 <22ac01a3-ddbb-4114-88cd-ad1a31982dad@redhat.com>
 <51ba1fc1-fd77-4601-8d27-459162fd008c@linux.alibaba.com>
 <CAGsJ_4zSuOTPi+zkS_kvS5T0MsdMBR+2gpXukJt0aMPrEnCDZg@mail.gmail.com>
 <875xv5ba8t.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <875xv5ba8t.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/5/23 09:14, Huang, Ying wrote:
> Barry Song <21cnbao@gmail.com> writes:
> 
>> On Wed, May 22, 2024 at 9:38 PM Baolin Wang
>> <baolin.wang@linux.alibaba.com> wrote:
>>>
>>>
>>>
>>> On 2024/5/22 16:58, David Hildenbrand wrote:
>>>> On 22.05.24 10:51, Baolin Wang wrote:
>>>>> The mTHP swap related counters: 'anon_swpout' and
>>>>> 'anon_swpout_fallback' are
>>>>> confusing with an 'anon_' prefix, since the shmem can swap out
>>>>> non-anonymous
>>>>> pages. So drop the 'anon_' prefix to keep consistent with the old swap
>>>>> counter
>>>>> names.
>>>>>
>>>>> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>> ---
>>>>
>>>> Am I daydreaming or did we add the anon_ for a reason and discussed the
>>>> interaction with shmem? At least I remember some discussion around that.
>>>
>>> Do you mean the shmem mTHP allocation counters in previous
>>> discussion[1]? But for 'anon_swpout' and 'anon_swpout_fallback', I can
>>> not find previous discussions that provided a reason for adding the
>>> ‘anon_’ prefix. Barry, any comments? Thanks.
>>
>> HI Baolin,
>> We had tons of emails discussing about namin and I found this email,
>>
>> https://lore.kernel.org/all/bca6d142-15fd-4af5-9f71-821f891e8305@redhat.com/
>>
>> David had this comment,
>> "I'm wondering if these should be ANON specific for now. We might want to
>> add others (shmem, file) in the future."
>>
>> This is likely how the 'anon_' prefix started being added, although it
>> wasn't specifically
>> targeting swapout.
>>
>> I sense your patch slightly alters the behavior of thp_swpout_fallback
>> in /proc/vmstat.
>> Previously, we didn't classify them as THP_SWPOUT_FALLBACK, even though we
>> always split them.
> 
> IIUC, "fallback" means you try to do something, but fail, so try
> something else as fallback.  If so, then we don't need to count
> splitting shmem large folio as fallback.

Agree. In additon, IIUC we have never counted splitting shmem large 
folio as THP_SWPOUT_FALLBACK before or after this patch.

> For example, before commit 5ed890ce5147 ("mm: vmscan: avoid split during
> shrink_folio_list()"), if folio_entire_mapcount() == 0, we will split
> the THP.  But we will not count it as "fallback" because we haven't
> tried to swap it out as a whole.

