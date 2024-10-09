Return-Path: <linux-kernel+bounces-356213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 975C8995DF4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 04:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6AE1C22C52
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603EF13D8A0;
	Wed,  9 Oct 2024 02:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dCWM/Vmm"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F8629429
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 02:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728442615; cv=none; b=Sb67mhNMUCCyRsv02qg0uX4Js19Ht05G/gQLjBIF6Se7qqqGsyfDkSvIyHtiMx+a9JGr2l4shjg8vqg2vJiQyW1WdlKhySC6+lki4Jhgq6+YErgF7azovjeTezEGDnXrAhiALWJ9z1IE5EP+wXBLr+2ETyUsGPsfaEuWNpIPmeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728442615; c=relaxed/simple;
	bh=0qmjYmFdw06suCzh6+fW8H+eXBogu4jcAAX3pH9bpgI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IjO9x/ix/qVXocsqcs0xL7o5Uuf9nl1MfkW964hXszxwLM7jCaeg9g3AxioXN5lKw85Dw9bBaG6Tnfzx2pzv0nM3Nj5ErFl3wXTHHeMXXdL1WVFjLmJkDI5cuIwALIL+mZ4vYX4+wxS/HE4hPou+sTRVFIc0KrSVQyZiLIgMZGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dCWM/Vmm; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d37e85271so39484f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 19:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728442612; x=1729047412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t0JQsXj4oUziRHhhCExh9PYqaUr4xY38iih3vfZfZ0Y=;
        b=dCWM/VmmZSNCYl0l81K8hbZN2x63FQa+ulhH+0tlya3OoAnx5aBNnZi/a0k0K6rZTY
         NwPQ3rmXyF4USemP7s8AetejDapp9X8C+SLLPQcdeqrOaoQDEat+O6Lv5QNQw6JNaKX9
         QVPXHq0XaUEkFG03Y9MFbn6LwzeOIWz+RjJjA4fieHWkjNBhGMriTJpGm230SVFRP0og
         BdelXKCtbT8rNDwcaLLubF+dfrobtMFO7DJIXAEnSj9VVk+XIofk2P937qCDsNXF0864
         pZidp6T7kbtx5mYjQJaMAHm1osjBo4J28uQn5eLAxQIZ4W+wUaDaFE2x6duhTsQ6KGH7
         G7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728442612; x=1729047412;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t0JQsXj4oUziRHhhCExh9PYqaUr4xY38iih3vfZfZ0Y=;
        b=NY/3T2ZhYsOyNyrLksRDqR9a5AQiYS8SWK6v9L5mJrlQsO57LUXInL2lVCTXbUcfQA
         1fV8FdDwzL1J0TXRgvx3qN4hH0H3HxiZetTryVmW4h7Cul9H8kTERKFP9undJ+f289FK
         AYgSrmAY20ygglgoVtBJDZdA+lIBg7JXH8Pbkb06dvLrtGI/9nz+zpi2pFy9e9hB/ZzU
         rE/9mqyyh/A9ja8ozN20qyLvdGpWmlyHlq1uYT4xtB88JDegNGv0cRlZwreieERu882d
         JYPZyIZ4e3ng0k3IZerX3L7OpTK5ualKZBygbcl6TY20MjwFjYqtAo1rj7xjlgHsJqAS
         gS4A==
X-Forwarded-Encrypted: i=1; AJvYcCWZ0PTxxjS0gYxcU7Os3Xs7ypsMjdf9D39FhLaU5GRLTPwidot8lLNVzOqfBIq4wTfgnnV7yJlITOP/Zos=@vger.kernel.org
X-Gm-Message-State: AOJu0YykhVyxfo09e6SLamE2+zSQBKg/AnU/ymOupYkCpMasOw7QIp7v
	og0O6Bg4+83sap9x8HKsSuQtihIN6OY3XKdGsRNda89F+rJPo0jQsdeQmjwG2Dw=
X-Google-Smtp-Source: AGHT+IHrOgkUvvtJmTGv90SYQQ9U0Q47x8k9I8nejDjWBpLZFkuRnbwwjkQUj96SRwiFiv6q99ifLg==
X-Received: by 2002:a05:6000:1449:b0:37c:cccc:2981 with SMTP id ffacd0b85a97d-37d3aafbba3mr208570f8f.14.1728442611670;
        Tue, 08 Oct 2024 19:56:51 -0700 (PDT)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d47a4dsm6819793b3a.118.2024.10.08.19.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 19:56:50 -0700 (PDT)
Message-ID: <7c8e2f25-6263-441d-b299-cc81109875b9@suse.com>
Date: Wed, 9 Oct 2024 10:56:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heming Zhao <heming.zhao@suse.com>
Subject: Re: [PATCH v3 1/3] ocfs2: give ocfs2 the ability to reclaim suballoc
 free bg
To: Joseph Qi <joseph.qi@linux.alibaba.com>, glass.su@suse.com
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240908140705.19169-1-heming.zhao@suse.com>
 <20240908140705.19169-2-heming.zhao@suse.com>
 <c87729aa-79ca-47ca-97b5-4af7c3829e12@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <c87729aa-79ca-47ca-97b5-4af7c3829e12@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 15:16, Joseph Qi wrote:
> 
> 
> On 9/8/24 10:07 PM, Heming Zhao wrote:
>> The current ocfs2 code can't reclaim suballocator block group space.
>> This cause ocfs2 to hold onto a lot of space in some cases. for example,
>> when creating lots of small files, the space is held/managed by
>> '//inode_alloc'. After the user deletes all the small files, the space
>> never returns to '//global_bitmap'. This issue prevents ocfs2 from
>> providing the needed space even when there is enough free space in a
>> small ocfs2 volume.
>> This patch gives ocfs2 the ability to reclaim suballoc free space when
>> the block group is freed. For performance reasons, this patch keeps
>> the first suballocator block group.
>>
>> Signed-off-by: Heming Zhao <heming.zhao@suse.com>
>> Reviewed-by: Su Yue <glass.su@suse.com>
>> ---
>>   fs/ocfs2/suballoc.c | 302 ++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 292 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
>> index f7b483f0de2a..d62010166c34 100644
>> --- a/fs/ocfs2/suballoc.c
>> +++ b/fs/ocfs2/suballoc.c
>> @@ -294,6 +294,68 @@ static int ocfs2_validate_group_descriptor(struct super_block *sb,
>>   	return ocfs2_validate_gd_self(sb, bh, 0);
>>   }
>>   
>> +/*
>> + * hint gd may already be released in _ocfs2_free_suballoc_bits(),
>> + * we first check gd descriptor signature, then do the
>> + * ocfs2_read_group_descriptor() jobs.
>> + *
>> + * When the group descriptor is invalid, we return 'rc=0' and
>> + * '*released=1'. The caller should handle this case. Otherwise,
>> + * we return the real error code.
>> + */
>> +static int ocfs2_read_hint_group_descriptor(struct inode *inode,
>> +			struct ocfs2_dinode *di, u64 gd_blkno,
>> +			struct buffer_head **bh, int *released)
>> +{
>> +	int rc;
>> +	struct buffer_head *tmp = *bh;
>> +	struct ocfs2_group_desc *gd;
>> +
>> +	*released = 0;
> 
> I'd like the caller is responsible for the initialization.

OK.

> 
>> +
>> +	rc = ocfs2_read_block(INODE_CACHE(inode), gd_blkno, &tmp, NULL);
>> +	if (rc)
>> +		goto out;
>> +
>> +	gd = (struct ocfs2_group_desc *) tmp->b_data;
>> +	if (!OCFS2_IS_VALID_GROUP_DESC(gd)) {
> 
> How to distinguish the release case or a bug?

Good question.

Before this patch, OCFS2 never releases suballocator space.
The ocfs2_read_group_descriptor() doesn't need to handle the
case of reading a bad 'struct ocfs2_group_desc'.

After this patch, there is a gap between
_ocfs2_free_suballoc_bits() and ocfs2_read_hint_group_descriptor().


      thread A                          thread B
-------------------------------------------------------------
ocfs2_claim_suballoc_bits
  hint is not zero
   ocfs2_search_one_group
    + ocfs2_read_hint_group_descriptor
    | + OCFS2_IS_VALID_GROUP_DESC(gd)
    |    returns true
    |                                _ocfs2_free_suballoc_bits
    + ...                             + free the last bit of gd
    |                                    + release gd
    + ocfs2_block_group_set_bits
       uses released gd, data corruption
--------------------------------------------------------------

I plan to introduce a new cache_info flag 'OCFS2_CACHE_CLEAN_GD' to protect this case.
e.g. (just demo, not tested)


      thread A                          thread B
-------------------------------------------------------------
ocfs2_read_hint_group_descriptor()
   ocfs2_read_block()

   //protect code begin
   ci = INODE_CACHE(inode);
   ocfs2_metadata_cache_io_lock(ci);
   if (ci->ci_flags & OCFS2_CACHE_CLEAN_GD)
       goto free_bh;
   ocfs2_metadata_cache_io_unlock(ci);
   //protect code end

   gd = (struct ocfs2_group_desc *) tmp->b_data;
   if (!OCFS2_IS_VALID_GROUP_DESC(gd)) {
      ... ...
   }

                               _ocfs2_free_suballoc_bits()
                                 ... ...
                                 if (ocfs2_is_cluster_bitmap(alloc_inode) ||
                                     (le32_to_cpu(rec->c_free) != (le32_to_cpu(rec->c_total) - 1)) ||
                                     (le16_to_cpu(cl->cl_next_free_rec) == 1)) {
                                         goto bail;
                                 }

                                 //protect code begin
                                 ci = INODE_CACHE(alloc_inode);
                                 ocfs2_metadata_cache_io_lock(ci);
                                 if (ci->ci_num_cached > 1) {
                                         goto bail;
                                 }
                                 ci->ci_flags |= OCFS2_CACHE_CLEAN_GD;
                                 ocfs2_metadata_cache_io_unlock(ci);
                                 //protect code end

                                 _ocfs2_reclaim_suballoc_to_main(handle, alloc_inode, alloc_bh, group_bh);
--------------------------------------------------------------

> 
>> +		/*
>> +		 * Invalid gd cache was set in ocfs2_read_block(),
>> ... ...
>>   
>> +/*
>> + * Reclaim the suballocator managed space to main bitmap.
>> + * This function first works on the suballocator then switch to the
>> + * main bitmap.
>> + *
>> + * handle: The transaction handle
>> + * alloc_inode: The suballoc inode
>> + * alloc_bh: The buffer_head of suballoc inode
>> + * group_bh: The group descriptor buffer_head of suballocator managed.
>> + *           Caller should release the input group_bh.
>> + */
>> +static int _reclaim_to_main_bm(handle_t *handle,
> 
> Better to rename it to _ocfs2_reclaim_suballoc_to_main().

OK.
> 
>> +			struct inode *alloc_inode,
>> +			struct buffer_head *alloc_bh,
>> +			struct buffer_head *group_bh)
>> +{
>> +	int idx, status = 0;
>> +	int i, next_free_rec, len = 0;
>> +	__le16 old_bg_contig_free_bits = 0;
>> ... ...
>> +	le32_add_cpu(&rec->c_free, count);
>>   	tmp_used = le32_to_cpu(fe->id1.bitmap1.i_used);
>>   	fe->id1.bitmap1.i_used = cpu_to_le32(tmp_used - count);
>>   	ocfs2_journal_dirty(handle, alloc_bh);
>>   
>> +	/*
>> +	 * Reclaim suballocator free space.
>> +	 * Bypass: global_bitmap, not empty rec, first rec in cl_recs[]
> 
> s/not empty rec/non empty rec

OK.

/Heming

