Return-Path: <linux-kernel+bounces-349524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A0798F7D7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E011F22A9F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547D3126F2A;
	Thu,  3 Oct 2024 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/TySWiI"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F0517BA3
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727985897; cv=none; b=M6dS8QGLIKWqtifI02ADRCm63sxpEQgSaVVBxcGhy4p1DDV7w/m7UPwlRhZqT/lmPo0iBxdJ36NvEMyyWAGnQokZTIKuIGppAK+gBRIMIfY6Xko4E+TDmco3zyy33tVwyTUszh8xL3AxdN8gXZtTQ/vDAVkKOPcxXRJ763tHX+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727985897; c=relaxed/simple;
	bh=tghiK1eJdE3uybzMSWW+W1NQ3jmlVfo1mjQ4aMKCjuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bOiLZYkTYX2/Z5QgR6Iqt0KCW0ToTzZAnK1GXVfcMOxLWXXvObtB1exFbJzGox/wI0JJvggtQ5MVpJhsunxHvarqc3nEcZkWc1Aj5nYp6sx3Mdd1hSooEQgoF8J//t2KhbJPt7EQCPIWC724KJuc14tpimzFePbJW7Qfrb9uBZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/TySWiI; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8a897bd4f1so170899466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 13:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727985894; x=1728590694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kvv2os+/3WLX9+lBVj/Tlj+AHgFu0pj1uZHYnfDNz9w=;
        b=d/TySWiIvidOsbu7cLdJ2qiHG9oseO1KBJGu0U2dnIwkLdJaJaCHrvnk1GCYjk8YEP
         Hpkln87tqP191AwLsGZwR2QEVPV+6+9aKFl86VTbM1LTutYFSkOI8fVBWwNs/FWoA0xG
         zP95H39yRMVjovMcccU1TCUZWAH9hy+l/4IaKG95OGhGqjxMI7BYm9kGT3QjwUeuCU46
         t6138SsIrriuT0Ey99+Td7LLRXwSnOnCkbN5cIP8Fnxtem2QSsEQogtKNVC+FoCue6IT
         /CSUJ/uMSbpPTqOHoJuuXM4RqB+i0Ik5GDxsLopjxgQk/wzJyQif+79ADCjwXdJdpoIL
         8s7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727985894; x=1728590694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kvv2os+/3WLX9+lBVj/Tlj+AHgFu0pj1uZHYnfDNz9w=;
        b=C1FhgXCQDIf22u9ycDhXKJrqgJdFddp+K4GS3WsJwvu2M004nK3IKLNA1ilVtt3Gkn
         pvLwijfqL4f54P99kiwzDfHxVMk/COBmt71QJxJQ3Sxh1vHpSdvbQGoiNiv7IaL9ENhS
         XCebPuV1eyle6WfTNWvsxZO6iuOTdz9Nq5Yq2WrZr7kKo2sGtvasn+1pYhKQZ0hu/jKh
         bythQ1NlUQSMHkMiDjlDIsFCeAovs+RkMst2IYr5e3SlbxrOkvIuNPENaMfyc0v7b47s
         hc22NRIIlDySgLS4mGdLLJlsRTeJCcRmpkI3bW+RdYA9W0IwvJDSQ4h2rMVjFygMe21a
         NVCg==
X-Forwarded-Encrypted: i=1; AJvYcCUoohrRXwdPMy5ln+pKBO+8w9GpTfWwQJPY9qdYRnPZ/tanZpPFYseQ/m6n3o1VRsOBWUeq9+HmYTMEXSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzufCqhlejqH/XC6OE/CPItVu+IS/Povh7stZEPSd/dLb6NtIyf
	+/+tru5EERnWbLHj/FGiLJxTP/N7M2TXbZILBOTHkI2OIk09XCd/
X-Google-Smtp-Source: AGHT+IGWr6KCh6B2QqVOdpykldYKFUOJq2hVUUStKdL5pJc3qB1FqnVHBGaxMS881fyQ1DJx43hbXw==
X-Received: by 2002:a17:907:1c1b:b0:a7a:9f0f:ab18 with SMTP id a640c23a62f3a-a991bd4906bmr42887266b.20.1727985894195;
        Thu, 03 Oct 2024 13:04:54 -0700 (PDT)
Received: from ?IPV6:2a01:e11:5400:7400:5ca1:a818:6304:8388? ([2a01:e11:5400:7400:5ca1:a818:6304:8388])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99104c3f24sm125036166b.196.2024.10.03.13.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 13:04:53 -0700 (PDT)
Message-ID: <7d795190-339c-4ef7-a1e0-4202a99622f1@gmail.com>
Date: Thu, 3 Oct 2024 22:04:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] udf: fix uninit-value use in udf_get_fileshortad
To: Jan Kara <jack@suse.cz>
Cc: jack@suse.com, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20240925071355.t4w3thcfvfpou7gu@quack3>
 <20240925074613.8475-3-gianf.trad@gmail.com>
 <20241002122909.ak4itmqzg4b2icsx@quack3>
Content-Language: en-US, it
From: Gianfranco Trad <gianf.trad@gmail.com>
In-Reply-To: <20241002122909.ak4itmqzg4b2icsx@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/10/24 14:29, Jan Kara wrote:
> On Wed 25-09-24 09:46:15, Gianfranco Trad wrote:
>> Check for overflow when computing alen in udf_current_aext to mitigate
>> later uninit-value use in udf_get_fileshortad KMSAN bug[1].
>> After applying the patch reproducer did not trigger any issue[2].
>>
>> [1] https://syzkaller.appspot.com/bug?extid=8901c4560b7ab5c2f9df
>> [2] https://syzkaller.appspot.com/x/log.txt?x=10242227980000
>>
>> Reported-by: syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=8901c4560b7ab5c2f9df
>> Tested-by: syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com
>> Suggested-by: Jan Kara <jack@suse.com>
>> Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
> 
> Thanks. I've added the patch to my tree.
> 
> 								Honza
> 

Thanks Jan. This was one of my first patches to the kernel. I will 
definitely remember it. Wish you a nice day :)

-- Gian

>> ---
>>
>> Notes:
>> 	changes in v2:
>> 		- use check_add_overflow helper to check for overflow.
>> 	
>> 	link to v1: https://lore.kernel.org/all/20240919195227.412583-1-gianf.trad@gmail.com/T/
>>
>>   fs/udf/inode.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
>> index 4726a4d014b6..811a035b600f 100644
>> --- a/fs/udf/inode.c
>> +++ b/fs/udf/inode.c
>> @@ -2215,9 +2215,10 @@ int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
>>   		if (!epos->offset)
>>   			epos->offset = sizeof(struct allocExtDesc);
>>   		ptr = epos->bh->b_data + epos->offset;
>> -		alen = sizeof(struct allocExtDesc) +
>> -			le32_to_cpu(((struct allocExtDesc *)epos->bh->b_data)->
>> -							lengthAllocDescs);
>> +		if (check_add_overflow(sizeof(struct allocExtDesc),
>> +					le32_to_cpu(((struct allocExtDesc *)epos->bh->b_data)
>> +						->lengthAllocDescs), &alen))
>> +			return -1;
>>   	}
>>   
>>   	switch (iinfo->i_alloc_type) {
>> -- 
>> 2.43.0
>>


