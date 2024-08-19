Return-Path: <linux-kernel+bounces-291363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF96956138
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87026281D30
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F373282FE;
	Mon, 19 Aug 2024 02:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JO6N5WTz"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7FF1BDC8
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724035544; cv=none; b=dhKdqk814JF84rV8ny+RV+hN707wKsyunwRAq2fUpdNBIsmfxX+Z96OyqwpXEVgRFFm78eKISuAg07a13NgFf5KWQDuDiOcO7WRN43+mvNSJNbxaw5Bzmhm1HVip938C/t/MQU9UOARLkFK1feRivYLj2RGjqFP7F2hCF4+4UEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724035544; c=relaxed/simple;
	bh=akJoPI9U64K1E0R5G7jzhyWDm4jIoQR60eAdmZv+ppY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVjDXXRvOjVkfY12WtSydzzlqi9pYVbMOVVUmddtUmVJ0KPklXxAwG5SZ82LfWY72IJXUmRO77AlS8Xq3VjyBRSXKdDJbYXdatAOywV+MawBUeUzZsktOBcHsb+WcFOAc5bJ7hSmocIPMhvhxaz5zqRi/HMgyu7/KBro28s86JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JO6N5WTz; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-371afae614aso1006675f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 19:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724035541; x=1724640341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=inu/J/3Qo4IukYlFwWeDitf2wpsmrLoXhBufGTN9jVA=;
        b=JO6N5WTzpfMJMKdWMIevQTV7l67/GWMdBzj/BVBjCJKZsOfm5lHlkTj4ruYBD6rADG
         X0RllaA4M/FuoJcfpmUMIhdHy0DWbsbBRiTPBFEdFKCZDuHlRDdB0VhG+mTLGL5+sUKf
         9oGmakUIxoiGMmQU+iOLB7QNDimPGrjvnE0WvnJjOXNbNWc0EvKd7mfI+e0uno+OkpW5
         pFV+46aUdQfSt86qps++0bx8JXFHkotXu6f8iRHWz0jps+WoX+8/E8uzQXw21cyafpFf
         dtO6G6z3B9AAf8PrzC+7fQNTYm6DHskVx9lRo+5mMVOTBMk1pmMvFFnsBbLJ4XOzCD7x
         eaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724035541; x=1724640341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=inu/J/3Qo4IukYlFwWeDitf2wpsmrLoXhBufGTN9jVA=;
        b=C5qpEkxEMSd00MCuL0ATSCNLR9RMSldlaE2ha4Pwke/c2pi7prgYFAd70a03T6W2CM
         9enx/+5i187TJ9vbKLkpleGLLoMgWFv+MBXDeZ4ONOTtzsMWWoM43ZGhJLzqZbIhTvKm
         Sd1LkUHgCmFSCLf/7BHBERmK8uvkiS22joETTcKHq98q3PTWZiWFTR2UNQDw3I7+GR0u
         lqQFQ5dz3SrtI11WNnwS6tyG5h1mg8AC4ucH3SHkd9bnqSyv09wJwsIpxxXX/nX4SmRM
         eYVuEyyRs9KUfSAC2/WVmqp9Vkdew57P8w1nDh7Mm15Nmhphy6RNnLbRB/0ZV8PYhW3T
         n3jg==
X-Forwarded-Encrypted: i=1; AJvYcCX2BD2UV8I6BWH8eTs5pT77Td8cotqyMUBi2EAka9cmBJgcUV2wSTtzt3Ms2IuFqItEk6sxVdfxudyML+OyeOoNAXBEZ0WWIuIfHSHz
X-Gm-Message-State: AOJu0YwYUQbPkzfhB5uXJFUxVy3YT2BV5DgrU8pDjilYoy5b1TlCaFBH
	VxhkR1fVABkELEh7TqZa2JNuvIxYx1Qk3bJqIZRlSCL9YapM5Hfp1OEZVBn2N50=
X-Google-Smtp-Source: AGHT+IFsKhoZ35QdvsnjvD0i2NnHDY7YLthIIMfIOT7A8puql65l58mwI3p4/bAaJuVfOvd+ojagaA==
X-Received: by 2002:a05:6000:104:b0:371:8db9:939e with SMTP id ffacd0b85a97d-371946bf734mr6372770f8f.51.1724035540625;
        Sun, 18 Aug 2024 19:45:40 -0700 (PDT)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03197fasm55609055ad.85.2024.08.18.19.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2024 19:45:40 -0700 (PDT)
Message-ID: <add0cd89-184e-46be-bc55-9b1843aad050@suse.com>
Date: Mon, 19 Aug 2024 10:45:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: Remove custom swap functions in favor of built-in
 sort swap
Content-Language: en-US
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, akpm <akpm@linux-foundation.org>
Cc: jserv@ccns.ncku.edu.tw, ocfs2-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>
References: <20240810195316.186504-1-visitorckw@gmail.com>
 <a4b3ab50-02af-42f2-b937-dcbb92b4f0d2@suse.com>
 <27b7f0e6-b668-407b-abf8-30613fcf732c@linux.alibaba.com>
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <27b7f0e6-b668-407b-abf8-30613fcf732c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/19/24 10:41, Joseph Qi wrote:
> 
> On 8/18/24 7:36 PM, Heming Zhao wrote:
>> On 8/11/24 03:53, Kuan-Wei Chiu wrote:
>>> The custom swap functions used in ocfs2 do not perform any special
>>> operations and can be replaced with the built-in swap function of sort.
>>> This change not only reduces code size but also improves efficiency,
>>> especially in scenarios where CONFIG_RETPOLINE is enabled, as it makes
>>> indirect function calls more expensive.
>>>
>>> By using the built-in swap, we avoid these costly indirect function
>>> calls, leading to better performance.
>>>
>>> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>>
>> Looks good to me
>> Signed-off-by: Heming Zhao <heming.zhao@suse.com>

Sorry for my mistake, above tag should be:
Reviewed-by: Heming Zhao <heming.zhao@suse.com>

>>
> 
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> 
>>> ---
>>> Note: Build test only.
>>>
>>>    fs/ocfs2/dir.c          | 12 +-----------
>>>    fs/ocfs2/refcounttree.c | 13 +++----------
>>>    fs/ocfs2/xattr.c        | 15 +++------------
>>>    3 files changed, 7 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
>>> index f0beb173dbba..fa5d0819a997 100644
>>> --- a/fs/ocfs2/dir.c
>>> +++ b/fs/ocfs2/dir.c
>>> @@ -3511,16 +3511,6 @@ static int dx_leaf_sort_cmp(const void *a, const void *b)
>>>        return 0;
>>>    }
>>>    -static void dx_leaf_sort_swap(void *a, void *b, int size)
>>> -{
>>> -    struct ocfs2_dx_entry *entry1 = a;
>>> -    struct ocfs2_dx_entry *entry2 = b;
>>> -
>>> -    BUG_ON(size != sizeof(*entry1));
>>> -
>>> -    swap(*entry1, *entry2);
>>> -}
>>> -
>>>    static int ocfs2_dx_leaf_same_major(struct ocfs2_dx_leaf *dx_leaf)
>>>    {
>>>        struct ocfs2_dx_entry_list *dl_list = &dx_leaf->dl_list;
>>> @@ -3781,7 +3771,7 @@ static int ocfs2_dx_dir_rebalance(struct ocfs2_super *osb, struct inode *dir,
>>>         */
>>>        sort(dx_leaf->dl_list.de_entries, num_used,
>>>             sizeof(struct ocfs2_dx_entry), dx_leaf_sort_cmp,
>>> -         dx_leaf_sort_swap);
>>> +         NULL);
>>>          ocfs2_journal_dirty(handle, dx_leaf_bh);
>>>    diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
>>> index 1f303b1adf1a..4f85508538fc 100644
>>> --- a/fs/ocfs2/refcounttree.c
>>> +++ b/fs/ocfs2/refcounttree.c
>>> @@ -1392,13 +1392,6 @@ static int cmp_refcount_rec_by_cpos(const void *a, const void *b)
>>>        return 0;
>>>    }
>>>    -static void swap_refcount_rec(void *a, void *b, int size)
>>> -{
>>> -    struct ocfs2_refcount_rec *l = a, *r = b;
>>> -
>>> -    swap(*l, *r);
>>> -}
>>> -
>>>    /*
>>>     * The refcount cpos are ordered by their 64bit cpos,
>>>     * But we will use the low 32 bit to be the e_cpos in the b-tree.
>>> @@ -1474,7 +1467,7 @@ static int ocfs2_divide_leaf_refcount_block(struct buffer_head *ref_leaf_bh,
>>>         */
>>>        sort(&rl->rl_recs, le16_to_cpu(rl->rl_used),
>>>             sizeof(struct ocfs2_refcount_rec),
>>> -         cmp_refcount_rec_by_low_cpos, swap_refcount_rec);
>>> +         cmp_refcount_rec_by_low_cpos, NULL);
>>>          ret = ocfs2_find_refcount_split_pos(rl, &cpos, &split_index);
>>>        if (ret) {
>>> @@ -1499,11 +1492,11 @@ static int ocfs2_divide_leaf_refcount_block(struct buffer_head *ref_leaf_bh,
>>>          sort(&rl->rl_recs, le16_to_cpu(rl->rl_used),
>>>             sizeof(struct ocfs2_refcount_rec),
>>> -         cmp_refcount_rec_by_cpos, swap_refcount_rec);
>>> +         cmp_refcount_rec_by_cpos, NULL);
>>>          sort(&new_rl->rl_recs, le16_to_cpu(new_rl->rl_used),
>>>             sizeof(struct ocfs2_refcount_rec),
>>> -         cmp_refcount_rec_by_cpos, swap_refcount_rec);
>>> +         cmp_refcount_rec_by_cpos, NULL);
>>>          *split_cpos = cpos;
>>>        return 0;
>>> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
>>> index 35c0cc2a51af..0e58a5ce539e 100644
>>> --- a/fs/ocfs2/xattr.c
>>> +++ b/fs/ocfs2/xattr.c
>>> @@ -4167,15 +4167,6 @@ static int cmp_xe(const void *a, const void *b)
>>>        return 0;
>>>    }
>>>    -static void swap_xe(void *a, void *b, int size)
>>> -{
>>> -    struct ocfs2_xattr_entry *l = a, *r = b, tmp;
>>> -
>>> -    tmp = *l;
>>> -    memcpy(l, r, sizeof(struct ocfs2_xattr_entry));
>>> -    memcpy(r, &tmp, sizeof(struct ocfs2_xattr_entry));
>>> -}
>>> -
>>>    /*
>>>     * When the ocfs2_xattr_block is filled up, new bucket will be created
>>>     * and all the xattr entries will be moved to the new bucket.
>>> @@ -4241,7 +4232,7 @@ static void ocfs2_cp_xattr_block_to_bucket(struct inode *inode,
>>>        trace_ocfs2_cp_xattr_block_to_bucket_end(offset, size, off_change);
>>>          sort(target + offset, count, sizeof(struct ocfs2_xattr_entry),
>>> -         cmp_xe, swap_xe);
>>> +         cmp_xe, NULL);
>>>    }
>>>      /*
>>> @@ -4436,7 +4427,7 @@ static int ocfs2_defrag_xattr_bucket(struct inode *inode,
>>>         */
>>>        sort(entries, le16_to_cpu(xh->xh_count),
>>>             sizeof(struct ocfs2_xattr_entry),
>>> -         cmp_xe_offset, swap_xe);
>>> +         cmp_xe_offset, NULL);
>>>          /* Move all name/values to the end of the bucket. */
>>>        xe = xh->xh_entries;
>>> @@ -4478,7 +4469,7 @@ static int ocfs2_defrag_xattr_bucket(struct inode *inode,
>>>        /* sort the entries by their name_hash. */
>>>        sort(entries, le16_to_cpu(xh->xh_count),
>>>             sizeof(struct ocfs2_xattr_entry),
>>> -         cmp_xe, swap_xe);
>>> +         cmp_xe, NULL);
>>>          buf = bucket_buf;
>>>        for (i = 0; i < bucket->bu_blocks; i++, buf += blocksize)


