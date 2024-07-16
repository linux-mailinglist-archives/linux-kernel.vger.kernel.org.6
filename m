Return-Path: <linux-kernel+bounces-253265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFD2931ECF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EECFB2186A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1347779E0;
	Tue, 16 Jul 2024 02:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NTAusPSc"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09547AD24
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721096923; cv=none; b=bdBjNS6K/DfU/dQjjrFGX1yLZwvi8+7kvGpywl5SdsGHU3JN5AeljMgGZaDtqL0CqMJUF8sG926uO8G0Ap1PG5F1QrG667T2uZe5Hpu9eyGWkIGskNJVecagSxvrykeFyV0kfkRAXZV//n7/mPnrPhi+wxygfz2eZPBUO38vXnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721096923; c=relaxed/simple;
	bh=zGyyVLQsZBlUDTSxT3K8gfH3oa1CjyI1ZTiGP21b5sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5l5VWWAANtnnUv2jjLNfL3EbgxUH20L6D0YYDyrBm0ukhW97zY8zDMoMTQ7pFUqVxfZiK/pD2/to+1mfquS/NMef57hMWlzGgE/JzFQ3oVYZfMt4zL70jGjbS9HSJ6MSDOudqQkN9AZnLh/OXIYyIyEnru3/B7YoS42Z1f0K7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NTAusPSc; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: kent.overstreet@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721096919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O1mujR3vP2Iz9uVp53noz/jO9KfAisyw45Xfjm48+HU=;
	b=NTAusPScl9gsv4KjVF0LzveVhAUYesQc7ZaWNzuqzJnO7NLdBRCIcXIwRIMKwoqL2LVipO
	OMrFXf3TnqgNBgEab1VPfPPtyUVzdWxgHEmm9TD4Og7rqtYjWq8ZbHT1rFAH3v1u0CN9jV
	wgqw+dnphKMegVJew+Tb/aywoHQdKvQ=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: tangyouling@kylinos.cn
X-Envelope-To: zhengqi.arch@bytedance.com
Message-ID: <7db60e36-9c96-4938-a28d-a9745e287386@linux.dev>
Date: Tue, 16 Jul 2024 10:28:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: list_lru: Fix NULL pointer dereference in
 list_lru_add()
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <20240712032554.444823-1-youling.tang@linux.dev>
 <sd32qchit33aafht27utinrz5dizw62qbtwdmwbtugqrlglmtx@6aitsotgqnpi>
 <8ce42a2e-783f-4244-8e75-21dcd578adf5@linux.dev>
 <oxzh24oit3ulkl5at66c4g3bsyo7z6jd54757yrkgqbeftfgjz@qlzktn3nrkpl>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <oxzh24oit3ulkl5at66c4g3bsyo7z6jd54757yrkgqbeftfgjz@qlzktn3nrkpl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi, Kent

On 12/07/2024 23:49, Kent Overstreet wrote:
> On Fri, Jul 12, 2024 at 12:28:57PM GMT, Youling Tang wrote:
>> Hi, Kent
>>
>> On 12/07/2024 12:07, Kent Overstreet wrote:
>>> On Fri, Jul 12, 2024 at 11:25:54AM GMT, Youling Tang wrote:
>>>> From: Youling Tang <tangyouling@kylinos.cn>
>>>>
>>>> Note that list_lru_from_memcg_idx() may return NULL, so it is necessary
>>>> to error handle the return value to avoid triggering NULL pointer
>>>> dereference BUG.
>>>>
>>>> The issue was triggered for discussion [1],
>>>> Link [1]: https://lore.kernel.org/linux-bcachefs/84de6cb1-57bd-42f7-8029-4203820ef0b4@linux.dev/T/#m901bb26cdb1d9d4bacebf0d034f0a5a712cc93a6
>>> I see no explanation for why this is the correct fix, and I doubt it is.
>>> What's the real reason for the NULL lru_list_one, and why doesn't this
>>> come up on other filesystems?
>> We can break it down into two questions (independent of each other):
>> 1) Error handling is necessary when l (lru_list_one) is NULL here.
> No, you're just hiding the actual bug - since I wasn't clear, I'm naking
> this patch.
We should use kmem_cache_alloc_lru() instead of kmem_cache_alloc(),
similar to the [1] modification.

Apply the following patch to fix the problem:

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index f9c9a95d7d4c..79a580dfb5e1 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -227,7 +227,8 @@ static struct inode *bch2_alloc_inode(struct 
super_block *sb)

  static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c)
  {
-       struct bch_inode_info *inode = 
kmem_cache_alloc(bch2_inode_cache, GFP_NOFS);
+       struct bch_inode_info *inode = alloc_inode_sb(c->vfs_sb, 
bch2_inode_cache, GFP_NOFS);
         if (!inode)
                 return NULL;

Link [1]: 
https://lwn.net/ml/linux-kernel/20220228122126.37293-5-songmuchun@bytedance.com/

Thanks,
Youling.

