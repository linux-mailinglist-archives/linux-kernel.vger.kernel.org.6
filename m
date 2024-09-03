Return-Path: <linux-kernel+bounces-311997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD8C9690B8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 02:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959DF1F23700
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 00:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26454685;
	Tue,  3 Sep 2024 00:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D8vJ/OZE"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74560A32
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725324205; cv=none; b=EoazSG4BpmenGgR30T79mqwhrwufrZny5I9ge01W8RuKT/pfMRCbsnR1jQyLmfpVMw8T4aqVaZfEw3s01UfC3o38gWsuJpWBh+N9XazssyaI+ciO+RLeS3yK2waGbMXFSFNXiFmY42e8d7h+w0CToJNCKuboE8t5laamZ70YFGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725324205; c=relaxed/simple;
	bh=45FjlJ8yMsJVgq0v6WbNq2PtIVLhkgJ4IkacyoVAD8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SRv51x+koZnl4IboFCPgVKE708HmgCHhGB9phVtb5s7n9cpYJBUT1+7mX4DnEyHgBWuh15rzsdVj64YQTlvZ6fPGSkQntjZlKyKaPsQlFKmJz3rjSYT9jgrYR8thyd/iX7dlqXkEY4u98dBRaYSgIfIu6/9Ph6jhti06Xw2Zkug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D8vJ/OZE; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-374d1dd1e75so9153f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 17:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725324201; x=1725929001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8cX+4KKBr+xtIqA76SSMWx5F0CeAr18wSG0C/PuZrgk=;
        b=D8vJ/OZECqyrGkovKdIXRsZ45J8WFpJ9Q62/dWLT+rfBZ28VSjc0xuRNaGjFdyBDXG
         ZTlb3KLkEUiNITguwrPfnfplFKCzy+r1c+WghxZuB/IE2a86ROJZOiWtzOmrIh/vkUhf
         7205RKt1gd7YHJ8pPiF3aYKwGJ3yAdVPVQtKUjWACZ9eO7Th0vVDa7wtqNihfdomBVIZ
         UBQwC+n56o6dSqCUwuKnY+LI+uBaY9ckEPWiCfw9WUGy5KayFsRqbawCI0HyTNrU1Lzb
         AIxRnaBM1qOOSy8WyitRsZOpuAZwNcUsNBQBa7K4Ar0z6n+gSONvSiM3bP9GzthSzI7p
         Yz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725324201; x=1725929001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cX+4KKBr+xtIqA76SSMWx5F0CeAr18wSG0C/PuZrgk=;
        b=IaPdbRmC+6VYyduIVaJavwEvfFrcxZUcDvCMZwQyJK0qvFyvfWcFriyXeI5XRFCNtY
         RRDt48gZ8rHmjqoTg0ToRFzeBNEZODbJ/kVktNhfLfLfW2YgPGmcv5HTiYhnnhsAW3WL
         PHBPy5I845nfU7EEfQoeC/HxP4IhGOwA4IWL04C2RgrNWPurWGXX76i7MWcu9zm+g7I4
         avtivV/46VoJpIZ6ZHUToIr/CDEft18Srcp+++J+ge7NYsmJYmzm2gpJGdgNjrhcKhRM
         Hx3lobdj+O3b9rFQ6JM0EZPoiNurTNcjvFMct64aWKHSHg5JkePVziAH8o15nyWnTyQM
         bHNg==
X-Forwarded-Encrypted: i=1; AJvYcCWEiAb/fYsk5ztWx71/0+MKsQNPoFBSEqzrhUCzcQSB2gQKUIJWq5H3g4UZ2bRWl0Fmbl11y22QSPDYr1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPrLkob7ix9/dPEDGBwMt6jlUT9iA7tylaEdu8RTTaK3txMNga
	RJoQEwfpElR81O4rK0LhENBbmOAw3CjdvDcnm4ZaRBlWV7MKMIAfStuxcNPAEpQ=
X-Google-Smtp-Source: AGHT+IEGbXACHMkI8eLg3lwKLSvQUANk/WkR/scN9Jd9fiWFeiq2ZukMbC0koALhcyIM6LjlYxEd3Q==
X-Received: by 2002:a05:6000:1567:b0:374:cc10:bb42 with SMTP id ffacd0b85a97d-374cc10bd56mr1634056f8f.2.1725324200196;
        Mon, 02 Sep 2024 17:43:20 -0700 (PDT)
Received: from [10.202.0.23] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515556172sm71272865ad.280.2024.09.02.17.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 17:43:19 -0700 (PDT)
Message-ID: <19557432-ce04-4a92-9a3c-83539ab73648@suse.com>
Date: Tue, 3 Sep 2024 08:43:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ocfs2: give ocfs2 the ability to reclaim suballoc
 free bg
To: Joseph Qi <joseph.qi@linux.alibaba.com>, glass.su@suse.com
Cc: ocfs2-devel@lists.linux.dev,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240729080454.12771-1-heming.zhao@suse.com>
 <20240729080454.12771-2-heming.zhao@suse.com>
 <88c9e6fd-db43-4c58-81f1-caa38369e732@linux.alibaba.com>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <88c9e6fd-db43-4c58-81f1-caa38369e732@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/24 19:25, Joseph Qi wrote:
> 
> 
> On 7/29/24 4:04 PM, Heming Zhao wrote:
>> The current ocfs2 code can't reclaim suballocator block group space.
>> This cause ocfs2 to hold onto a lot of space in some cases. for example,
>> when creating lots of small files, the space is held/managed by
>> '//inode_alloc'. After the user deletes all the small files, the space
>> never returns to '//global_bitmap'. This issue prevents ocfs2 from
>> providing the needed space even when there is enough free space in a
>> small ocfs2 volume.
>> This patch gives ocfs2 the ability to reclaim suballoc free space when
>> the block group is free. For performance reasons, ocfs2 doesn't release
>> the first suballocator block group.
>>
>> Signed-off-by: Heming Zhao <heming.zhao@suse.com>
>> ---
>>   fs/ocfs2/suballoc.c | 211 ++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 206 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
>> index f7b483f0de2a..1b64f4c87607 100644
>> --- a/fs/ocfs2/suballoc.c
>> +++ b/fs/ocfs2/suballoc.c
>> @@ -294,6 +294,60 @@ static int ocfs2_validate_group_descriptor(struct super_block *sb,
>>   	return ocfs2_validate_gd_self(sb, bh, 0);
>>   }
>>   
>> +/*
>> + * hint gd may already be released in _ocfs2_free_suballoc_bits(),
>> ... ...
>> +	alloc_bh = main_bm_bh;
>> +	fe = (struct ocfs2_dinode *) alloc_bh->b_data;
>> +	cl = &fe->id2.i_chain;
>> +	old_bg_contig_free_bits = 0;
>> +	brelse(group_bh);
>> +	group_bh = NULL;
>> +	start_bit = bg_start_bit;
>> +	undo_fn = _ocfs2_clear_bit;
>> +
>> +	/* reclaim clusters to global_bitmap */
>> +	goto reclaim;
>> +
>>   bail:
>> +	if (free_main_bm_bh) {
>> +		ocfs2_inode_unlock(main_bm_inode, 1);
>> +		brelse(main_bm_bh);
>> +	}
>> +	if (free_main_bm_inode) {
>> +		inode_unlock(main_bm_inode);
>> +		iput(main_bm_inode);
>> +	}
> 
> You've add too much logic into _ocfs2_free_suballoc_bits() and make it
> hard to review.
> Could you please factor out a new function and describe it clearly?
> e.g. why we need this function and how to achieve it.
> BTW, it seems that it contains a big loop, so please explictly specify
> the end condition.
> 
> Cc lkml as well.
> 
> Thanks,
> Joseph

Give me some time to do the factor out job.

- Heming

> 
>>   	brelse(group_bh);
>>   	return status;
>>   }
> 
> 


