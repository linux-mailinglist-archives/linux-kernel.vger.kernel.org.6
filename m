Return-Path: <linux-kernel+bounces-564079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAE2A64D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841EF3AC0F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE89F2376F9;
	Mon, 17 Mar 2025 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GAFuxf8k"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B98027701
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212583; cv=none; b=JZCcD0U4bHFew0cjKBoBY7XmDEWQD9fImMtLMugW33Tk3bidFb2/oUyE/va2cU8hxOBRFtjgpjSKctRXlVDaAtQ4OddredEc8hCt63MWHGFCuHopSrdxsWf/Z6RCxFsCF/XH0yJ887y52kIHgbpLnIqTaM+2OMCbzf30cDW8mDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212583; c=relaxed/simple;
	bh=Rkw4yJGSe21TTCcFB1UVx47FOz4c7u0YapVBfQVN8JI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cnv1wRmuOkSjzFYCJpQRxKBUPG1n4puBwy464d7UqBzy2EoicWCAipLIZxGC1q9/gSXafKfFXobIFCE/4Z3evhp2AFf3WnUlxtjmtGXvdLVAFg1+/r/IsnjpgGzqt29x4Onc32ZNi0Vl0ai9fLMQ+a5F3MgZ+1P5H6fwRVXbHC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GAFuxf8k; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abec8b750ebso795727166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 04:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742212579; x=1742817379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nvSmeQlqS0PVSiztlrJp1EnapLR9YnzwoX8WjGMczkU=;
        b=GAFuxf8khfL58+1sCmYA3BoL1lWWLoKhdWuiDa3WwW7NW3SV+BlG/saX2l5oetXEhr
         I4isjl10fRfSx8Ni3V86LVKeJTk8HxxraFgZ9L0YZK4TlJjBCpoFIPla6Dy0r1u8mLB9
         Pb/hyl7VVeXuApQWh3CPqAcHh0UDvRAIG42a6E/QLP1qnqTaht4/O20rG7iITz+kkO4x
         bLnXnZVqhKuVkKZq3BABxJJ6TZi2rUzC/YY2x1ghiIYxB4I3/L0eahbVXDOY4Zq7IT5f
         B0umlTWey96yaU43HTYn/tbC86F5ISC0G9B602CmYEny8O+kNq0+Y7SadwYaZJdyDTtv
         oI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742212579; x=1742817379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nvSmeQlqS0PVSiztlrJp1EnapLR9YnzwoX8WjGMczkU=;
        b=m0F0CHzud3HSw3m8yBmL3svzLXlczf2Mr3STe/nbArVdcj75elP+EpW+X/C+oeBp9D
         vBrN22NG/Rt96raoOG1GE0SdWGj/5sQ3oIfg+R8UybN3VIJT13JbTQH/78357/6OtbJa
         tK7PgrPAeXeBmwKAa32+fcTI0y8SCKWOtSsOReZOsIlSzEpCuxqBIdEWTLirY6u//eqF
         mK9CsSvv7Hak+L/7ADfKMvBBFVu3Mb889EjfCt888gMh6DFfYbc2cot4iDuh4TM/17zJ
         Y9T3w+Iogof5WrubNKUyLdUorecfCQLs3yAekNCiJMdKd1VsXnP9dJhLZ1ps5tzl3J77
         CCrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBtzcVDjuQZ0CvjrBdpIbLb410rjbdr7KHPOjbMCIYOIo3MtQ3+vdoE1YVs5gmu3CwhOBw5ur3OLkJvL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMb+YegNCbqACCQuBORCzN8jQsRIz4ASJf5jNQ7zVvBvph1GjE
	/XzVLqpjOleMdfmu2webWJt1XKsO9II/GF9F+oeJGUeO+HhC6iWkC18Xce9GPB8=
X-Gm-Gg: ASbGnctjZr21IXpVuSLAi1AJZj7Q+n1gqCeXcZ4z4h/oJv5/OUh2KKJhvXRiHTzuSLH
	jlDzRenT58/h8I15m+9ZlxxHLctGPlN81UlhtbVH31avj/JNDoXDCzkiQ35xoQnLU8UPdQAPDZs
	1Upy5EnHXfgrtgX64OmntBkcfiMrrY5oiwkN50DWFWFnaB85o1AHZnuD0l/9VjI7K+p6uDcEEG7
	lYDJTvsq9+uS8Ap3cnVxx+fBF6sxqfVg5ZmbT/LM+F85Wp8Mwsd96hdIuJ/JTg2lZK0KJluCvjc
	vpy8kpmXVbn0QSWZlxEOpqefqHmAMYRf60T+J6lEAplGgTTgW/saxA==
X-Google-Smtp-Source: AGHT+IElqC4N7WBdN/UwREha3sJL0AOI9i9gOEBfGevhPlzqhMr3fPOn8XBHjesPAtYa3nhFewNk9Q==
X-Received: by 2002:a17:907:a089:b0:ac1:ea39:9b9f with SMTP id a640c23a62f3a-ac330461ce4mr1164128466b.54.1742212579456;
        Mon, 17 Mar 2025 04:56:19 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a3e0e4sm657815566b.136.2025.03.17.04.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 04:56:19 -0700 (PDT)
Message-ID: <a4bce4f5-88c3-4755-9ac5-3ce6fb78dfbf@linaro.org>
Date: Mon, 17 Mar 2025 11:56:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] coresight: Add claim tag warnings and debug messages
To: Leo Yan <leo.yan@arm.com>
Cc: lcherian@marvell.com, coresight@lists.linaro.org,
 Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250211103945.967495-1-james.clark@linaro.org>
 <20250211103945.967495-5-james.clark@linaro.org>
 <20250313144005.GQ9682@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250313144005.GQ9682@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/03/2025 2:40 pm, Leo Yan wrote:
> On Tue, Feb 11, 2025 at 10:39:40AM +0000, James Clark wrote:
>>
>> Add a dev_dbg() message so that external debugger conflicts are more
>> visible. There are multiple reasons for -EBUSY so a message for this
>> particular one could be helpful. Add errors for and enumerate all the
>> other cases that are impossible.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/hwtracing/coresight/coresight-core.c | 48 ++++++++++++--------
>>   drivers/hwtracing/coresight/coresight-priv.h |  5 +-
>>   2 files changed, 34 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
>> index 7b53165c93af..7fe5d5d432c4 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -133,16 +133,6 @@ static inline u32 coresight_read_claim_tags(struct csdev_access *csa)
>>                           csdev_access_relaxed_read32(csa, CORESIGHT_CLAIMCLR));
>>   }
>>
>> -static inline bool coresight_is_claimed_self_hosted(struct csdev_access *csa)
>> -{
>> -       return coresight_read_claim_tags(csa) == CORESIGHT_CLAIM_SELF_HOSTED;
>> -}
>> -
>> -static inline bool coresight_is_claimed_any(struct coresight_device *csdev)
>> -{
>> -       return coresight_read_claim_tags(&csdev->access) != 0;
>> -}
>> -
>>   static inline void coresight_set_self_claim_tag(struct csdev_access *csa)
>>   {
>>          csdev_access_relaxed_write32(csa, CORESIGHT_CLAIM_SELF_HOSTED,
>> @@ -169,18 +159,40 @@ static inline void coresight_clear_self_claim_tag(struct csdev_access *csa)
>>    */
>>   int coresight_claim_device_unlocked(struct coresight_device *csdev)
>>   {
>> +       int tag;
>> +       struct csdev_access *csa;
>> +
>>          if (WARN_ON(!csdev))
>>                  return -EINVAL;
>>
>> -       if (coresight_is_claimed_any(csdev))
>> +       csa = &csdev->access;
>> +       tag = coresight_read_claim_tags(csa);
>> +
>> +       switch (tag) {
>> +       case CORESIGHT_CLAIM_FREE:
>> +               coresight_set_self_claim_tag(csa);
>> +               if (coresight_read_claim_tags(csa) == CORESIGHT_CLAIM_SELF_HOSTED)
>> +                       return 0;
>> +
> 
> It would be a rare case if a failure happens here.  Seems to me, it
> would be valuable to print a log for this edge case.
> 
> Otherwise, looks good to me.
> 

Yeah I can add dev_dbg("Busy: Couldn't set self claim tag"). Just to 
distinguish this race case from the other busy case.



