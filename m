Return-Path: <linux-kernel+bounces-287501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DF4952882
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 06:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615B11F22D89
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 04:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E463B182;
	Thu, 15 Aug 2024 04:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="grDsG/ms"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C68118D658
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 04:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723696049; cv=none; b=awenD2mndhiP+7apuFW2PwJRuB4bu6oRcdzcMSLlD0P76SJj/8k0kJOP4I+da9SjSK2x+23YNaRWMpTyZxU14N/XSY2w5SjznHxiO/wGDlecuHDIzPUv8HT1uVjYhWrvM0w9wEnUiYc+RHyQoleIusSRfLYNFUK4+n+DmtcsXv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723696049; c=relaxed/simple;
	bh=tYZD9A0HM/95pmAJ7AMl+OiU5oNA6Fme+4d9c8qPZgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgYZGAC/vtthDswWYjhrV24pzQH1sJL7D1wb7SVaZXaaDybI5AggkWWgEEp3y45splgkBwISZg7thBgIjwzxLTfpJ/mxjngWbJ8Bs1jn417c7FyKZWrrlUBBEbpYJVuDGYkKZC7lP+GZ9rFObPsgETXUSbzkpDHJesmGavBXOxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=grDsG/ms; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-26b5173e861so353350fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723696047; x=1724300847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8/Id/EUvYIikfHBhIlRdALTTVRPkkouWiJiIcJo9Xao=;
        b=grDsG/msYI2mNChCPqtBB8aEf857BHR9DL5CRMvnGgKrRlKO2jsBACHb+kMKOT+kcw
         IrF1KVzKpeLyFR++e+8EpaLwOCixB6Melv3BmyUfF/AHex5KgXpRe+OQqvwogL5XiZUv
         0xp9O/jtiMR5h313m5tMHl93bNv4IWZ2a95hgy5gCA5Z/QyB8NPxOscGSkOt4mCZbbuR
         mLKqzNYAzQmUKP1PexhFgwuwKbt5exy8dH2W4JLPZZIZgQgIx8zNbrGWk2kgP/tbpMMi
         IWtT5BSzAb4ilF4Elfw++2b2Re96V5dJ5mYH/L2eiupRAt1Y2pyOjFw4Ri7LwPJj2PPi
         AWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723696047; x=1724300847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/Id/EUvYIikfHBhIlRdALTTVRPkkouWiJiIcJo9Xao=;
        b=foAo2hzx4Bctn7rw6Xp/l+pWy/8qk3hptBMQ2w1awQ8y0oOeIR4CrIKIfGazyqVgem
         fKAzF5gaZ54cjRGDHKUgcxXUs7OpiJ7++/AHn75Hjpk9JxyrvBghf2nzSJEaHARuMHQh
         eqiuTY+7BcCVy7mwGnvOHMXONqZ8FBIwktiqbro19MOTSxTDKRT5CVmeD/1/uVHYXvip
         QFBRxnHSi6huoCKg/FXhw7ZH1xNouIktUGX2xXHJhED03QrV+AxLSfSzJL73s4D+vo6+
         VF3E05X+Gqj7Ob3AtPqD1MIDAZMYDP4Enu9lJ01jrF/qv/df+BR572HJg5v5GtIhJIRi
         +MtA==
X-Forwarded-Encrypted: i=1; AJvYcCW02PK8nZ61OejcLqywLYYJ5RLVNlnaAIzle9veWjVfbxNogMCWwi2+ML0cDDnMalUUsxTIj0vd/ClUuXcQTQ6vBj+ukAv1YSJEPgFS
X-Gm-Message-State: AOJu0YxrDPnS2LiQsZbzJ36e8u9MbESWzLLLpBZobPygQXo4bjnPKjoz
	odQSY1CM0ed+2NxoD5/V+IiUI3SHqY4QcvNYP6ksz8A2s1gMqEIBvz48QJIRkw==
X-Google-Smtp-Source: AGHT+IH0h5U/bPhlnmk5b3zsDLMzE0JExVtm3z2RlvIlWYuEUmFRoqWT5giXLb5xuE/BSS7SI0OmAg==
X-Received: by 2002:a05:6870:724c:b0:25d:f984:640 with SMTP id 586e51a60fabf-26fe5aa6c06mr5970143fac.24.1723696046951;
        Wed, 14 Aug 2024 21:27:26 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e14:7:cca1:216f:2796:1b10? ([2a00:79e0:2e14:7:cca1:216f:2796:1b10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af1be5asm356858b3a.176.2024.08.14.21.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 21:27:26 -0700 (PDT)
Message-ID: <d95fce97-61f5-4a0d-a3c9-52df50bfa820@google.com>
Date: Wed, 14 Aug 2024 21:27:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] usb: roles: add lockdep class key to struct
 usb_role_switch
To: Greg KH <gregkh@linuxfoundation.org>
Cc: heikki.krogerus@linux.intel.com, badhri@google.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, kyletso@google.com,
 rdbabiera@google.com
References: <20240813224216.132619-1-amitsd@google.com>
 <2024081450-triage-glorious-cba5@gregkh>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <2024081450-triage-glorious-cba5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/13/24 9:49 PM, Greg KH wrote:
> On Tue, Aug 13, 2024 at 03:42:11PM -0700, Amit Sunil Dhamne wrote:
>> There can be multiple role switch devices running on a platform. Given
>> that lockdep is not capable of differentiating between locks of
>> different instances, false positive warnings for circular locking are
>> reported. To prevent this, register unique lockdep key for each of the
>> individual instances.
>>
>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>> ---
>>   drivers/usb/roles/class.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
>> index d7aa913ceb8a..807a8f18ec20 100644
>> --- a/drivers/usb/roles/class.c
>> +++ b/drivers/usb/roles/class.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/usb/role.h>
>>   #include <linux/property.h>
>>   #include <linux/device.h>
>> +#include <linux/lockdep.h>
>>   #include <linux/module.h>
>>   #include <linux/mutex.h>
>>   #include <linux/slab.h>
>> @@ -33,6 +34,10 @@ struct usb_role_switch {
>>   	usb_role_switch_set_t set;
>>   	usb_role_switch_get_t get;
>>   	bool allow_userspace_control;
>> +
>> +#ifdef CONFIG_LOCKDEP
>> +	struct lock_class_key key;
>> +#endif
> Please do not put #ifdef lines in .c files, they are not needed for this
> change to work properly, right?
That's right. I will correct it in the next revision.
>
> checkpatch should have complained about this...

Unfortunately it didn't complain.

Thanks,

Amit

>
> thanks,
>
> greg k-h

