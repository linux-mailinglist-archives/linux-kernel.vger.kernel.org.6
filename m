Return-Path: <linux-kernel+bounces-291022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7304D955C4A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 13:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E451F213EA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 11:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7478C13;
	Sun, 18 Aug 2024 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YsZx4gtS"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8F317BA9
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723980996; cv=none; b=FtXAOZ/vNgMn0HZxT5KHCEVPUpGTIZPAtHlbedyYmJoYWjn38aijydy6B6bjAYYGl2OnbknEVL98ca2rgdDVhYf42/Z0Qb73PEkbV00T1Qisrrdf782fV5Ffpe2Ng2ORrTy+CJh+TSWnV75KX3BKydNUCZXT1gnvKrL3W9CL0AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723980996; c=relaxed/simple;
	bh=emaXNsgdl5NHORKtBOppdVEU2slprfD8AHSZqpBCNw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OosfigmRhRcPOB4kBQpbaDIneK8N33nJlWwdbbsIQdqTQ+PUdGRjYcc/7BT6gWtDKwJKKKg/vmsi3ry1EFBjdorevXHZKinPOUz7/W2V/heiF4NYKzviTZa6x/U8Zqstrxmjnr1GSm96Doi2SIe6J2vVtBdDZdiDTpCoVlNPouw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YsZx4gtS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37189d8e637so2000771f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 04:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723980993; x=1724585793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PAJdMQKZiX+9jCnggas981zW+KUWWZZDTKHFUqV7VHM=;
        b=YsZx4gtSCY2OQjSo43TS2TS5kOZHpi/kblxQk9hJ0lWoMfmOKo8MUHDi2PZ8n7OBCQ
         ExEQpKnljWUHNWjBciILZnQ4Vqi1cvYRB7FB1gtJ93vUo/YVJ7G5Q48izvOWvRK2Zq/Q
         1WTTvXjtWtipl2DoN2y2JDFIiU0pfaDQT/T8k7tUmQ9shV9fWgSk601sPLQgxbTfkkgt
         JjYY+S9mNUG5+c5hBkO8nN81fO2Uy2Ese/NqVrX0SBPh3XGuxbOIKJ6MxKSByhH2WDIs
         QG29C3oWGkCDBR00Qpvk8ifcpKHx4+ep4/JJOJzsiCMTAQQzX2R80sGWZI+HMBBDTytk
         Cb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723980993; x=1724585793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PAJdMQKZiX+9jCnggas981zW+KUWWZZDTKHFUqV7VHM=;
        b=kpdY8lpPkmhs9AO/CrQklfVQaOH97cPD4PMIvH94NLQN9bcBcOc3stjMv5608wQKUu
         KC10fCq73GoHv++2CxfFuQK6ooNtBIK9h0u58xZIJl3xG6G2Tu4g87MDFucMsBSFis+5
         Rffl7z7LFbMpWYRpR+Q/7oMZTpVwnU1+X3tyaf43eZ1Ohpda7tDHAHg+IsouG/VzsnaA
         jk46CTrAujNfdBO/cvkHxSJM4YLfsnppZWI4EB6Fp1yGnyyWiDNRIvJAeHAEbYGu2QyJ
         TWgbnLJcFGb1AqJApr0o17tho8HyRX8lQ7QBjU+0ufq6gXmYqjpkEM2iON39CHUNZvmD
         aa7g==
X-Forwarded-Encrypted: i=1; AJvYcCX5lFJaRvqSy73uXr8j+djfxuaJGWj+dXfbjdmG6d/WuPUaK4FbVB9itCe2gYg/RnLzvexdLARNJEJ7df+ijTpJ4bvW2bU1XULH2Z2i
X-Gm-Message-State: AOJu0Yw2C0mCYIIvpGDFQnNP0VeH5AzaHJ9hDQIAwwhGuQljcImmWq0n
	LE6p/kAzdg/dWetDg0YqexOk9axJGQZ3CHfK7x1l1EWhWvnhFqa8CNP1z8IEmG1ZEnZ8u+j3CZS
	g
X-Google-Smtp-Source: AGHT+IFzBHXv9/w0iRDS4AcSUkJDBHxQa194bTyJD7dRAKg6cwL4kmUfwhABd6WEcQOinr9c2dZgRw==
X-Received: by 2002:a5d:6908:0:b0:371:83ac:fec1 with SMTP id ffacd0b85a97d-37194314afemr4592193f8f.1.1723980992674;
        Sun, 18 Aug 2024 04:36:32 -0700 (PDT)
Received: from [127.0.0.1] ([192.177.92.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f039e258sm49307155ad.245.2024.08.18.04.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2024 04:36:32 -0700 (PDT)
Message-ID: <a4b3ab50-02af-42f2-b937-dcbb92b4f0d2@suse.com>
Date: Sun, 18 Aug 2024 19:36:18 +0800
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
To: Kuan-Wei Chiu <visitorckw@gmail.com>, mark@fasheh.com,
 jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc: jserv@ccns.ncku.edu.tw, ocfs2-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240810195316.186504-1-visitorckw@gmail.com>
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <20240810195316.186504-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/24 03:53, Kuan-Wei Chiu wrote:
> The custom swap functions used in ocfs2 do not perform any special
> operations and can be replaced with the built-in swap function of sort.
> This change not only reduces code size but also improves efficiency,
> especially in scenarios where CONFIG_RETPOLINE is enabled, as it makes
> indirect function calls more expensive.
> 
> By using the built-in swap, we avoid these costly indirect function
> calls, leading to better performance.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Looks good to me
Signed-off-by: Heming Zhao <heming.zhao@suse.com>

> ---
> Note: Build test only.
> 
>   fs/ocfs2/dir.c          | 12 +-----------
>   fs/ocfs2/refcounttree.c | 13 +++----------
>   fs/ocfs2/xattr.c        | 15 +++------------
>   3 files changed, 7 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
> index f0beb173dbba..fa5d0819a997 100644
> --- a/fs/ocfs2/dir.c
> +++ b/fs/ocfs2/dir.c
> @@ -3511,16 +3511,6 @@ static int dx_leaf_sort_cmp(const void *a, const void *b)
>   	return 0;
>   }
>   
> -static void dx_leaf_sort_swap(void *a, void *b, int size)
> -{
> -	struct ocfs2_dx_entry *entry1 = a;
> -	struct ocfs2_dx_entry *entry2 = b;
> -
> -	BUG_ON(size != sizeof(*entry1));
> -
> -	swap(*entry1, *entry2);
> -}
> -
>   static int ocfs2_dx_leaf_same_major(struct ocfs2_dx_leaf *dx_leaf)
>   {
>   	struct ocfs2_dx_entry_list *dl_list = &dx_leaf->dl_list;
> @@ -3781,7 +3771,7 @@ static int ocfs2_dx_dir_rebalance(struct ocfs2_super *osb, struct inode *dir,
>   	 */
>   	sort(dx_leaf->dl_list.de_entries, num_used,
>   	     sizeof(struct ocfs2_dx_entry), dx_leaf_sort_cmp,
> -	     dx_leaf_sort_swap);
> +	     NULL);
>   
>   	ocfs2_journal_dirty(handle, dx_leaf_bh);
>   
> diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
> index 1f303b1adf1a..4f85508538fc 100644
> --- a/fs/ocfs2/refcounttree.c
> +++ b/fs/ocfs2/refcounttree.c
> @@ -1392,13 +1392,6 @@ static int cmp_refcount_rec_by_cpos(const void *a, const void *b)
>   	return 0;
>   }
>   
> -static void swap_refcount_rec(void *a, void *b, int size)
> -{
> -	struct ocfs2_refcount_rec *l = a, *r = b;
> -
> -	swap(*l, *r);
> -}
> -
>   /*
>    * The refcount cpos are ordered by their 64bit cpos,
>    * But we will use the low 32 bit to be the e_cpos in the b-tree.
> @@ -1474,7 +1467,7 @@ static int ocfs2_divide_leaf_refcount_block(struct buffer_head *ref_leaf_bh,
>   	 */
>   	sort(&rl->rl_recs, le16_to_cpu(rl->rl_used),
>   	     sizeof(struct ocfs2_refcount_rec),
> -	     cmp_refcount_rec_by_low_cpos, swap_refcount_rec);
> +	     cmp_refcount_rec_by_low_cpos, NULL);
>   
>   	ret = ocfs2_find_refcount_split_pos(rl, &cpos, &split_index);
>   	if (ret) {
> @@ -1499,11 +1492,11 @@ static int ocfs2_divide_leaf_refcount_block(struct buffer_head *ref_leaf_bh,
>   
>   	sort(&rl->rl_recs, le16_to_cpu(rl->rl_used),
>   	     sizeof(struct ocfs2_refcount_rec),
> -	     cmp_refcount_rec_by_cpos, swap_refcount_rec);
> +	     cmp_refcount_rec_by_cpos, NULL);
>   
>   	sort(&new_rl->rl_recs, le16_to_cpu(new_rl->rl_used),
>   	     sizeof(struct ocfs2_refcount_rec),
> -	     cmp_refcount_rec_by_cpos, swap_refcount_rec);
> +	     cmp_refcount_rec_by_cpos, NULL);
>   
>   	*split_cpos = cpos;
>   	return 0;
> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> index 35c0cc2a51af..0e58a5ce539e 100644
> --- a/fs/ocfs2/xattr.c
> +++ b/fs/ocfs2/xattr.c
> @@ -4167,15 +4167,6 @@ static int cmp_xe(const void *a, const void *b)
>   	return 0;
>   }
>   
> -static void swap_xe(void *a, void *b, int size)
> -{
> -	struct ocfs2_xattr_entry *l = a, *r = b, tmp;
> -
> -	tmp = *l;
> -	memcpy(l, r, sizeof(struct ocfs2_xattr_entry));
> -	memcpy(r, &tmp, sizeof(struct ocfs2_xattr_entry));
> -}
> -
>   /*
>    * When the ocfs2_xattr_block is filled up, new bucket will be created
>    * and all the xattr entries will be moved to the new bucket.
> @@ -4241,7 +4232,7 @@ static void ocfs2_cp_xattr_block_to_bucket(struct inode *inode,
>   	trace_ocfs2_cp_xattr_block_to_bucket_end(offset, size, off_change);
>   
>   	sort(target + offset, count, sizeof(struct ocfs2_xattr_entry),
> -	     cmp_xe, swap_xe);
> +	     cmp_xe, NULL);
>   }
>   
>   /*
> @@ -4436,7 +4427,7 @@ static int ocfs2_defrag_xattr_bucket(struct inode *inode,
>   	 */
>   	sort(entries, le16_to_cpu(xh->xh_count),
>   	     sizeof(struct ocfs2_xattr_entry),
> -	     cmp_xe_offset, swap_xe);
> +	     cmp_xe_offset, NULL);
>   
>   	/* Move all name/values to the end of the bucket. */
>   	xe = xh->xh_entries;
> @@ -4478,7 +4469,7 @@ static int ocfs2_defrag_xattr_bucket(struct inode *inode,
>   	/* sort the entries by their name_hash. */
>   	sort(entries, le16_to_cpu(xh->xh_count),
>   	     sizeof(struct ocfs2_xattr_entry),
> -	     cmp_xe, swap_xe);
> +	     cmp_xe, NULL);
>   
>   	buf = bucket_buf;
>   	for (i = 0; i < bucket->bu_blocks; i++, buf += blocksize)


