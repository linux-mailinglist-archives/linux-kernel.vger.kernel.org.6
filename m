Return-Path: <linux-kernel+bounces-188208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 791618CDF33
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B888282B76
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 01:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2485BF9CB;
	Fri, 24 May 2024 01:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1DgJ7D+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5F12C9A
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 01:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716514488; cv=none; b=TbiXMCZJOan38PTKYWAQRxvKRqHu25LUkClI21gJcDEFxXCIhQJh9OrtrN6hW1UBmmmrg/UqKayR42aYwgLPGDwFZB4HwLO52Jw5xV6qiMNQGLkhDMAslu3DYXiCgULbvMGYnXPtXtxhYAHtqmO+Pk2l8SNRzXbQlWKW7EyFrL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716514488; c=relaxed/simple;
	bh=6eqPKy9djQ44kxy9/4ekHNwI380SgUbokve8MKOW5nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F5UVyQmJWYU0SwCyzKrGilh+zAAnRaGdnoWicU7M7cQf1ve2co/wEu8LaD0OVnFqOh+FXVjzCOzkK2EqOo0Vjs9vpojwx49i7qwg6yW7N0euBcqcpui7GEfED0NW4IFX5I1kFFkWL/MrL6TqnGHvmF1AmvMkw1QdeAu0WUVWhIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C1DgJ7D+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716514485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u7zyDSjhpyorp5nAJxno7CoO9uDDRfWCi8vAJwbr4pI=;
	b=C1DgJ7D+EF28NlN15v5CE/Jc5hrbtD0GiVB4hxyLtviMoyJ2nzVNNlmQDly4VNEKkU/FGQ
	xwL8SylDSc47eeQa1eZmSf+o/mYuZyODm+m3iLNhHAJX7suum9KUr/stEayq5SiOleUUws
	GtT77HpHjNc1mtLEoAfnkTnksp6/iu4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-ZIX_0hKeM9ap0z4eUk3t9A-1; Thu, 23 May 2024 21:34:43 -0400
X-MC-Unique: ZIX_0hKeM9ap0z4eUk3t9A-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-794aaf57a38so39433885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 18:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716514483; x=1717119283;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7zyDSjhpyorp5nAJxno7CoO9uDDRfWCi8vAJwbr4pI=;
        b=BN36NqcX3cvfZeMhJJorWABbjmLO7AcpN+SzSb18Gd7XE29E1VEkgf7u14+R+bLKBX
         0JRzhu2Ss8wjZz3gqrkezQg3eMkasi4qoc7gjUzpcOMCtuEtRNrlQZa/9JfmYSw5t2Hb
         wMWAZG4xhvzkjOytv2BprrqE/I5PAZ56GtR6AgebRRNzKl8x00neDLcHHpYxnWtAxPZm
         Mp/MIf12pUyfqdQQ2XwSGpPKGlQ7bNjnZgh2+pzulX8TTI9R07X1bMd5IJTH2XlV7Y7z
         3sdkisiEZdr1Uf13zqc9SIXHR9OcpeHlH5vcE3QCTz1DNI24NZSs2Yk641KThYE0aZA2
         HrQw==
X-Forwarded-Encrypted: i=1; AJvYcCU/LMVAtlCYZXT7CMV7mSOqz35KKv/LzmX79F3SZJ7+RoA94gFc3Vbs8Wtzaw3iyfCoctHwfBw7R3/pZZ4NzOTedEJ3AExRxDjrmpu2
X-Gm-Message-State: AOJu0YxF1LemL1Uw+pygAWyHJ9upNVC3FP/LJVeUh4SNtDdLz7HVW/Fl
	Q+HU9rmEaRSbmXc9lyXsINe2MG4FxSa9V5wmQ6X28wF2I7X+IY8Yri/0oQFQKl/9XnNGniWhKd4
	rJOstKjOpxcrWCKpvBC7LpM1v7MyAviMd/kdCfBLAJuJDuhZTXzuz7wjt7/udRA==
X-Received: by 2002:a05:6214:5c07:b0:6a0:8559:d137 with SMTP id 6a1803df08f44-6abcdaa8559mr9297986d6.61.1716514482821;
        Thu, 23 May 2024 18:34:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdkDT3EyxEf+gntyix61idG5hT7+VI8hQowuVB9g+Y0LHc/PAp4h7v2266c9W7+jo6cv+TeA==
X-Received: by 2002:a05:6214:5c07:b0:6a0:8559:d137 with SMTP id 6a1803df08f44-6abcdaa8559mr9297736d6.61.1716514482293;
        Thu, 23 May 2024 18:34:42 -0700 (PDT)
Received: from [192.168.1.175] ([70.22.187.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac070dc638sm2357546d6.35.2024.05.23.18.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 18:34:41 -0700 (PDT)
Message-ID: <cc86b717-e060-2d73-88a6-1625285c47c5@redhat.com>
Date: Thu, 23 May 2024 21:34:41 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dm vdo: remove unused struct 'uds_attribute'
Content-Language: en-US
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>
References: <20240523210716.309324-1-linux@treblig.org>
 <5c063045-4bce-14e4-9930-77cc0ed2edad@redhat.com>
 <Zk_ozpHryOiMLx_Q@gallifrey>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <Zk_ozpHryOiMLx_Q@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 21:09, Dr. David Alan Gilbert wrote:
> * Matthew Sakai (msakai@redhat.com) wrote:
>> On 5/23/24 17:07, linux@treblig.org wrote:
>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>>
>>> 'uds_attribute' is unused since
>>> commit a9da0fb6d8c6 ("dm vdo: remove all sysfs interfaces").
>>>
>>> Remove it.
>>>
>>> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>>
>> Yes, this was clearly an oversight on our part. Feel free to add:
>> Reviewed-by: Matthew Sakai <msakai@redhat.com>
> 
> Thanks for the quick review.
> Is this something you'll send a pull for, or do I need to
> ask someone else to include it?

No need to do anything else, I think. Mike (or Mikulas), can you
include this with the next set of device mapper patches?

> Dave
> 
>>> ---
>>>    drivers/md/dm-vdo/dedupe.c | 5 -----
>>>    1 file changed, 5 deletions(-)
>>>
>>> diff --git a/drivers/md/dm-vdo/dedupe.c b/drivers/md/dm-vdo/dedupe.c
>>> index 117266e1b3ae..39ac68614419 100644
>>> --- a/drivers/md/dm-vdo/dedupe.c
>>> +++ b/drivers/md/dm-vdo/dedupe.c
>>> @@ -148,11 +148,6 @@
>>>    #include "vdo.h"
>>>    #include "wait-queue.h"
>>> -struct uds_attribute {
>>> -	struct attribute attr;
>>> -	const char *(*show_string)(struct hash_zones *hash_zones);
>>> -};
>>> -
>>>    #define DEDUPE_QUERY_TIMER_IDLE 0
>>>    #define DEDUPE_QUERY_TIMER_RUNNING 1
>>>    #define DEDUPE_QUERY_TIMER_FIRED 2
>>
>>


