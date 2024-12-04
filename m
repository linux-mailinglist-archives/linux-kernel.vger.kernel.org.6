Return-Path: <linux-kernel+bounces-431105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E637B9E38F9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CBC28644A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56791C1AB6;
	Wed,  4 Dec 2024 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZxiU6kC7"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614D51BAEFD
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312095; cv=none; b=N84b1XsCBCAfwl7AkmV0cS4F5QiM+LCrvYtDmT1MSNYuebnd6v4HViBYaol3Xk/wjLlLHAaFNKNWgHNwshh/oreHro59c7mFs3rlNkSPp5d5EeYkloeqmhZoeJVTQMpXCbz3E8obLivEyaClhqbykkY44BIa1+/TbE2M+973jgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312095; c=relaxed/simple;
	bh=Vi2bKt6/rwvZXF2mPJwiHd0rqmSWEQ/lysen1wR0FJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vFi9Y9ylSRvyAb49q6fauUz7NBioejPwyhJY9oOLCMa9xcrl5HNv+GVysWYMg/68JL0qfqGhRBRgC96tUTukc3/ndx8kPrfTa1cbHtZEgpc4tb1vdEbi2s2ts0XrsuH6xoPRY17Tb+pbNL4DOBWQfi7+q/er91MJupuRCOEsg6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZxiU6kC7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4348f65e373so7884205e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733312090; x=1733916890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PgJLSQXktaGb+dG/FduPphoyaegpnGmLFV8pWNrBnh8=;
        b=ZxiU6kC7pCo17YZaHyxpt66j1d7BnnhSB+0Nb/xXTG4NUrnhMXdJvvIsvkOj/A8ByS
         4eUOTaUUF/hRPIH65Gf6sAOd/mYpAV1/kjTdtzz7d6bIFJWvO8ZJSiJKM3TuThEuHXrQ
         ywS2wHQH5lsurEfxVPzjQwFYO8NJDjxhZYHifkAho3xnD2b99o6Xh7uZxE1FNJQiJGVB
         BSE1jFCiRufLmHiYpkXeMRA+xC+vu05QC3My+dGfsfBj6agiiDBdM2dFJvf5VIf4HahR
         u1xNGEasSJ0RqIFYqNyLUBPFgoiVEc5UM+dl84ovasWyiVmhBiwdT2JZ3qjJ7eMGftwn
         CQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733312090; x=1733916890;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PgJLSQXktaGb+dG/FduPphoyaegpnGmLFV8pWNrBnh8=;
        b=Lcqd3mOwGjl2MOEPHlXqprrXWfwWCJe+oPV7/6zU7s6vz36L5uaMW7NDrPt3RGTQKO
         KAdryNMvE2nNHc80P+2Ea3vXc2bBUq2jbwzAj0q0GSoQMiREF/SzJIuT/CXfWynuSMHc
         CVNi0bdCiv49MKBNAKYRx7mujQMBDZZWxDNgNN3imiehFy0aMvPQmM8wUbaO2sTUmwbd
         Z7Jdx0H+1gPq1xamjl7bekaJTYndDlLwdSYwhKPNbhPsl7wGlVA+D+9GCaLVBN84chZ3
         VwRSPZp+AbNr4oTUfKGwYeTxuQ147F2oP8RR57Y+3E+7Ve6mpU5eyXmdQAiSXRZdFm6i
         /rIg==
X-Gm-Message-State: AOJu0YwcFAMv5BAflyLZ+J9C7Y5J+RCk2g+m6zgj8UUBVR8fY0xOyqvw
	k9zSaW4DTXUAi5lI2uUfxv1FRg3pg+M8AQh04/dDcU9zjbrKC5/fpbdrdlkze5G0v6Db75vduxL
	mdYHtsw==
X-Gm-Gg: ASbGnctCnRx4BzHkp7v5dkGk9ZS23FJG46Q060QvRuujsE7XLc4Zeee3OWIi+DP9byx
	e6IG82J+TIUHQzbW9UfkhqHWapfHSriXJYatw2LjIPRSCjsPCdIOrZgUfar36novOBhQjgAxC5G
	M3DZDM0hreLJBXai695X4Im/wTgmpCMrfECZughOncwQVvx77SyOfjTdePJLt/sWi+6Hbmn+JJB
	4taD0mVGQ7H/OMNW0hVf417ZxZqb2lnI1LzrPMxIqFB2MYiIjorXw==
X-Google-Smtp-Source: AGHT+IEZ3WECZOCeCaAdxC7d9oRWYnvYRZ+58FiYREc9X1QL+93oiqtvRyOJmgmoLRMAJxFijDNEsQ==
X-Received: by 2002:a05:6000:2cf:b0:385:f092:e10 with SMTP id ffacd0b85a97d-385fd3c3087mr2116720f8f.3.1733312089500;
        Wed, 04 Dec 2024 03:34:49 -0800 (PST)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176150dsm12511554b3a.23.2024.12.04.03.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 03:34:48 -0800 (PST)
Message-ID: <47fe189d-eadc-495d-984e-705fab58acad@suse.com>
Date: Wed, 4 Dec 2024 19:34:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ocfs2: Revert "ocfs2: fix the la space leak when
 unmounting an ocfs2 volume"
To: Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 gregkh@linuxfoundation.org, stable@vger.kernel.org
References: <20241204033243.8273-1-heming.zhao@suse.com>
 <20241204033243.8273-2-heming.zhao@suse.com>
 <6c3e1f5a-916c-4959-a505-d3d3917e5c9c@linux.alibaba.com>
 <79b86b7b-8a65-49b8-aa33-bb73de47ad37@suse.com>
 <58618b80-f1ab-4b22-a3fc-9d29969615a0@linux.alibaba.com>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <58618b80-f1ab-4b22-a3fc-9d29969615a0@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/4/24 17:28, Joseph Qi wrote:
> 
> 
> On 12/4/24 2:46 PM, Heming Zhao wrote:
>> On 12/4/24 11:47, Joseph Qi wrote:
>>>
>>>
>>> On 12/4/24 11:32 AM, Heming Zhao wrote:
>>>> This reverts commit dfe6c5692fb5 ("ocfs2: fix the la space leak when
>>>> unmounting an ocfs2 volume").
>>>>
>>>> In commit dfe6c5692fb5, the commit log stating "This bug has existed
>>>> since the initial OCFS2 code." is incorrect. The correct introduction
>>>> commit is 30dd3478c3cd ("ocfs2: correctly use ocfs2_find_next_zero_bit()").
>>>>
>>>
>>> Could you please elaborate more how it happens?
>>> And it seems no difference with the new version. So we may submit a
>>> standalone revert patch to those backported stable kernels (< 6.10).
>>
>> commit log from patch [2/2] should be revised.
>> change: This bug has existed since the initial OCFS2 code.
>> to    : This bug was introduced by commit 30dd3478c3cd ("ocfs2: correctly use ocfs2_find_next_zero_bit()")
>>
>> ----
>> See below for the details of patch [1/2].
>>
>> following is "the code before commit 30dd3478c3cd7" + "commit dfe6c5692fb525e".
>>
>>     static int ocfs2_sync_local_to_main()
>>     {
>>         ... ...
>>   1      while ((bit_off = ocfs2_find_next_zero_bit(bitmap, left, start))
>>   2             != -1) {
>>   3          if ((bit_off < left) && (bit_off == start)) {
>>   4              count++;
>>   5              start++;
>>   6              continue;
>>   7          }
>>   8          if (count) {
>>   9              blkno = la_start_blk +
>> 10                   ocfs2_clusters_to_blocks(osb->sb,
>> 11                                start - count);
>> 12
>> 13               trace_ocfs2_sync_local_to_main_free();
>> 14
>> 15               status = ocfs2_release_clusters(handle,
>> 16                               main_bm_inode,
>> 17                               main_bm_bh, blkno,
>> 18                               count);
>> 19               if (status < 0) {
>> 20                   mlog_errno(status);
>> 21                   goto bail;
>> 22               }
>> 23           }
>> 24           if (bit_off >= left)
>> 25               break;
>> 26           count = 1;
>> 27           start = bit_off + 1;
>> 28       }
>> 29
>> 30     /* clear the contiguous bits until the end boundary */
>> 31     if (count) {
>> 32         blkno = la_start_blk +
>> 33             ocfs2_clusters_to_blocks(osb->sb,
>> 34                     start - count);
>> 35
>> 36         trace_ocfs2_sync_local_to_main_free();
>> 37
>> 38         status = ocfs2_release_clusters(handle,
>> 39                 main_bm_inode,
>> 40                 main_bm_bh, blkno,
>> 41                 count);
>> 42         if (status < 0)
>> 43             mlog_errno(status);
>> 44      }
>>         ... ...
>>     }
>>
>> bug flow:
>> 1. the left:10000, start:0, bit_off:9000, and there are zeros from 9000 to the end of bitmap.
>> 2. when 'start' is 9999, code runs to line 3, where bit_off is 10000 (the 'left' value), it doesn't trigger line 3.
>> 3. code runs to line 8 (where 'count' is 9999), this area releases 9999 bytes of space to main_bm.
>> 4. code runs to line 24, triggering "bit_off == left" and 'break' the loop. at this time, the 'count' still retains its old value 9999.
>> 5. code runs to line 31, this area code releases space to main_bm for the same gd again.
>>
>> kernel will report the following likely error:
>> OCFS2: ERROR (device dm-0): ocfs2_block_group_clear_bits: Group descriptor # 349184 has bit count 15872 but claims 19871 are freed. num_bits 7878
>>
> 
> Okay, IIUC, it seems we have to:
> 1. revert commit dfe6c5692fb5 (so does stable kernel).
> 2. fix 30dd3478c3cd in following way:
> 
> diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
> index 5df34561c551..f0feadac2ef1 100644
> --- a/fs/ocfs2/localalloc.c
> +++ b/fs/ocfs2/localalloc.c
> @@ -971,9 +971,9 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
>   	start = count = 0;
>   	left = le32_to_cpu(alloc->id1.bitmap1.i_total);
>   
> -	while ((bit_off = ocfs2_find_next_zero_bit(bitmap, left, start)) <
> +	while ((bit_off = ocfs2_find_next_zero_bit(bitmap, left, start)) <=
>   	       left) {

The ocfs2_find_next_zero_bit() always returns a value within the range [0, left],
do you like the following code?

-	while ((bit_off = ocfs2_find_next_zero_bit(bitmap, left, start)) <
-		left) {
+	for(;;) {
+		bit_off = ocfs2_find_next_zero_bit(bitmap, left, start);


-Heming

> -		if (bit_off == start) {
> +		if ((bit_off < left) && (bit_off == start)) {
>   			count++;
>   			start++;
>   			continue;
> @@ -997,7 +997,8 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
>   				goto bail;
>   			}
>   		}
> -
> +		if (bit_off >= left)
> +			break;
>   		count = 1;
>   		start = bit_off + 1;
>   	}
> 
> Thanks,
> Joseph
> 
> 


