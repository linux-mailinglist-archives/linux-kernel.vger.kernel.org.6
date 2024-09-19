Return-Path: <linux-kernel+bounces-333877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B334A97CF4F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 00:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA403B228BB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 22:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4951B2EE8;
	Thu, 19 Sep 2024 22:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dFBX17cB"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9501119ABAF
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 22:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726786210; cv=none; b=SWDWWTG0akhzbcACJGeffQHpG5ZnXyl/09NLcVSozScdjNROBZHPL/rBeuACSywWr8OJesH6cwID7BMCddBWmBfiJyomJhesQcxmILF2s6rhimrgvSKCiDkJpq5V/1FhYfxUzSiKTyUilqgawFa++MmHZdNMWG8s3C65qzLVMbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726786210; c=relaxed/simple;
	bh=jcdO1Ws/371xc2rjJWhRW7rSMSnWdXQGzGvNQUoQN3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxk75TcxY6HBe+qrsyUDIH+pXUVo9d5ka0RPG2nDJxEh2T1bBVEsuiv5hPXWKkk1U1gYfyGZ8h+VM+XG4oFF8Qpm3nkCq+vb4l9wzVaHe9Fxk1siq4VKJYh/x9ISPLb0ugrR2yPOHiULW1L/JatRDSlWbNzjp/rdyFWW1UNEX5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dFBX17cB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2059204f448so13625145ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 15:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726786208; x=1727391008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5wz5lXmuEfJrsdnRfJzjlfMUt5hIQmRZ+lBgO7w7oV4=;
        b=dFBX17cBk36OABk6LPvevHRygX5mSAabB7hlLMKBWh9m6Uvc25nNT10iuz/6HH+pZr
         y//iJ2Zs1NeuCTvWeSVKovFgFMGXyHz3SJxWk12+GAwzcKVUKixbmuhqTduYNeGFC3Su
         4f7+CmkTnT2cm4/ISay4RlfWBL9UxNweaD1qTFSd04CoYTfGNmY/ownx6KkpXsvmwEGe
         X+flQ68CZm3uxpRMXhIZ5xgVBT2aY2QjLhfe4oCIWSnb86fPxfKkqr/Ln4/o3DZ4JT8A
         AB60fXrmmNqKpGW7CNqZvkWazjkncjUo7HMvQA3E9miP7IfKKfSrGiF83MpwI5YUMs+f
         YW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726786208; x=1727391008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wz5lXmuEfJrsdnRfJzjlfMUt5hIQmRZ+lBgO7w7oV4=;
        b=BHR2UCKyDk/g0tZ8NKj7wkqvefwT02omGXiUy2wWnorD9Pq2Xmsm1+GzjI0+WUh3jJ
         subTvIyntyMsGhtJW1oeucGVlcT/T0HynfTp7REg8TwyJAHJXb6R6cX/+qqM4B1iF63n
         gU7Rd/9DqkGSSqGX6IcqEu2fdawwSYgSzzreaGAkHyqI+mZaY+hacBq92uFeplapPss6
         YftyYLHIKYv3bbyDZ/8SV6twKLqiK9rdV8hmemzrWDPGEDjVXrIdq8k3yEQbx/zNrItw
         ghPOSDoNf3hfktxcBnlnCZYg0Qw6pt2rjHjyMBQDRYg9ss7GkhxKP1XnB2iSlgT0wwPX
         4VIA==
X-Forwarded-Encrypted: i=1; AJvYcCWeUiaMfmNBdrKhN38ifTIu/dzNqCxDgc7usEf55IXF1dVEPH7gvVeK44dkFzyG2NWehXbx2+s1Drl4Pns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR4KoTohcXgXjvzZ0UCbyynfRYP2hB/1z06tTzqGknAnIH3FcB
	MsM1ZgubVGJk9f3hCJc7AP3OOQL5TBkPvLjpDWOWhT+d3x/FNCGH4CFJJrPN5A==
X-Google-Smtp-Source: AGHT+IEFTOdkTTfdrN+O9bFF4XZIaLF1A6VxLZ7fwhnPT6zj9SxeESvTNX2h3OI6/0yS5WhmbqNNQA==
X-Received: by 2002:a17:902:d511:b0:205:7574:3b87 with SMTP id d9443c01a7336-208d980bb34mr4901005ad.15.1726786207484;
        Thu, 19 Sep 2024 15:50:07 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e14:7:f9c5:155b:ca02:2b70? ([2a00:79e0:2e14:7:f9c5:155b:ca02:2b70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946fb724sm84806845ad.200.2024.09.19.15.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 15:50:07 -0700 (PDT)
Message-ID: <ad1e9554-ebec-483f-90e0-d0c63fc07b86@google.com>
Date: Thu, 19 Sep 2024 15:50:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] usb: typec: Fix arg check for
 usb_power_delivery_unregister_capabilities
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: heikki.krogerus@linux.intel.com, badhri@google.com, kyletso@google.com,
 rdbabiera@google.com, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, stable@vger.kernel.org
References: <20240919075815.332017-1-amitsd@google.com>
 <2024091956-premiere-given-c496@gregkh>
 <gkyzytmvcaefbfvu6ryss7zq5cm3t3mcjgtugsryhxl7aglpkk@gi2fgjnyidgi>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <gkyzytmvcaefbfvu6ryss7zq5cm3t3mcjgtugsryhxl7aglpkk@gi2fgjnyidgi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg, Dmitry,

Thanks for the review!

On 9/19/24 3:03 AM, Dmitry Baryshkov wrote:
> On Thu, Sep 19, 2024 at 10:11:37AM GMT, Greg KH wrote:
>> On Thu, Sep 19, 2024 at 12:58:12AM -0700, Amit Sunil Dhamne wrote:
>>> usb_power_delivery_register_capabilities() returns ERR_PTR in case of
>>> failure. usb_power_delivery_unregister_capabilities() we only check
>>> argument ("cap") for NULL. A more robust check would be checking for
>>> ERR_PTR as well.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 662a60102c12 ("usb: typec: Separate USB Power Delivery from USB Type-C")
>>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>>> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
>>> ---
>>>   drivers/usb/typec/pd.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/typec/pd.c b/drivers/usb/typec/pd.c
>>> index d78c04a421bc..761fe4dddf1b 100644
>>> --- a/drivers/usb/typec/pd.c
>>> +++ b/drivers/usb/typec/pd.c
>>> @@ -519,7 +519,7 @@ EXPORT_SYMBOL_GPL(usb_power_delivery_register_capabilities);
>>>    */
>>>   void usb_power_delivery_unregister_capabilities(struct usb_power_delivery_capabilities *cap)
>>>   {
>>> -	if (!cap)
>>> +	if (IS_ERR_OR_NULL(cap))
>> This feels like there's a wrong caller, why would this be called with an
>> error value in the first place?  Why not fix that?  And why would this
>> be called with NULL as well in the first place?
> I think passing NULL matches the rest of the kernel, it removes
> unnecessary if(!NULL) statements from the caller side.
>
The reason for this patch was just to be a little more defensive in case 
things slip through cracks and be
consistent with the rest of the PD class. For example 
usb_power_delivery_unregister() &
usb_power_delivery_unlink_device() has similar arg checks.


Regards,

Amit


