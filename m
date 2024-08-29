Return-Path: <linux-kernel+bounces-306536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD390964038
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F6128004B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5360818DF7D;
	Thu, 29 Aug 2024 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TA/oYyFJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCB518CBE5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924022; cv=none; b=uNwWlF4y0KSabQ5VvZujL3zIVRx/M0W/7lFcIEp86+BIJONomk27hhkC0osiQYv6A0vK0JaYpSaRYyZwY1biqmcBDQGqqbp6oH2P7T4a2gmzAWp6C3QND1LCzTxauS0aovMEeBCcYGmWeH5+GmMVYB8N/oJdf9cITgX+GiDTU4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924022; c=relaxed/simple;
	bh=JysCSfHgK24yWzdWo/5Cx73f7aPyPjUA4tMgZAwRv3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddZczk0KtbpGf0ZiFJTnfbFFdc+SVwf7CVJq0YNXuwoVKAOI8mrxonwH6NhemZTCME72uo1ntOckqB7TCekRdt1H7LWqtnM+IDlxfHqu32b5Ml+FfClhOpJhvKk+il1wB2y7qzFm8Rfv1ZuQtP4md+bTqhTF8NXylNMxnKSFt4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TA/oYyFJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724924019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRhf0ft13sdsULrJq6iL+gwjruDGQCG9graD1/4XUWs=;
	b=TA/oYyFJvshAkIOwRyl5u2JN1JxBn6JTkD1XF2+9GaN0St486xavAPH7+CIbhrcffUGZdh
	8CPME3qElJ3mDiFYm1Tdwy9mSMFY8DiPRbL0HCYQNy7vMHWlWTSDTYGwSjjhc5f0czmjub
	GAuMjH2KVdpoz4uuh1X6RkK+PZxDwVQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-r8a1-qyROGKkQjMIp7gftA-1; Thu, 29 Aug 2024 05:33:37 -0400
X-MC-Unique: r8a1-qyROGKkQjMIp7gftA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42bb6f0f35cso4687545e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724924016; x=1725528816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IRhf0ft13sdsULrJq6iL+gwjruDGQCG9graD1/4XUWs=;
        b=frCPNrgdMW0Ouy7haQPdBzsH4sI9zGRpuz4AQudr40BnHklQ2ZXLUOA23HPYWM7lA+
         zA54suKPrTAUI7caxUtp+Ejp9Pa8dAwQvAVNWkUhVcxF76YWiB7cbnwM/Ybn7D12l1yF
         cAkx8QbzPkoRf2wLiNNp8O34Mm4f0T2suFhuR6qzm/WNQANQnpHmj/DO9kNVXhNhK43p
         KnMMoS1qICwZIWbntlj9NoWUUMIPs7EniXA8ySPJQcUksl8dbrXOKXpejHnrQnxXdcnk
         LCe1Oio02gZ9zYCLiIy0KfFurcwqPwl4WWbYaj2YfD6/l4Kg4ewgAypr0StzYVzBLQul
         HfrA==
X-Forwarded-Encrypted: i=1; AJvYcCWeunynlRqGKHskCSgFOVns0uNs97WSDtWimWl2xiWZmtnG+ArBrl43FBpwchWBQjgrNcbaUDzLA+WpJvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQv+9o7OhSeQZE/ZxQn7iEpYwg4my+Z3qKGWnRprTp3JjlFom3
	T93YlG/on3mk1j6y20eOfrqDizgTaHse0yfM3WKR/ochL7PJF6ZJ8WzY5o5IVMzBpB8LGrdwIxI
	iMMGJVsj77LiH08HVljwdaC9yWfgbfYHB0ejxb2Q3AvueSD3CJyEKYCIhgnfGwg==
X-Received: by 2002:a05:600c:46d4:b0:42b:8a35:1acf with SMTP id 5b1f17b1804b1-42bb01e5ef4mr16502705e9.25.1724924016398;
        Thu, 29 Aug 2024 02:33:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2+Er1pf1oTykru6p0aRr/6rL2Gd7SvquO1i4gu1DFePq2eQeeTxri+3UL0unRxkD9a7oAbw==
X-Received: by 2002:a05:600c:46d4:b0:42b:8a35:1acf with SMTP id 5b1f17b1804b1-42bb01e5ef4mr16502565e9.25.1724924015809;
        Thu, 29 Aug 2024 02:33:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b50:3f10:2f04:34dd:5974:1d13? ([2a0d:3344:1b50:3f10:2f04:34dd:5974:1d13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42b9e7bda63sm49426805e9.1.2024.08.29.02.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 02:33:34 -0700 (PDT)
Message-ID: <95ae7576-fa52-4ef0-91f7-14aa0bb91208@redhat.com>
Date: Thu, 29 Aug 2024 11:33:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfc: pn533: Add poll mod list filling check
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Aleksandr Mishin <amishin@t-argos.ru>, Samuel Ortiz <sameo@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240827084822.18785-1-amishin@t-argos.ru>
 <26d3f7cf-1fd8-48b6-97be-ba6819a2ff85@redhat.com>
 <b1088e86-a88e-4e20-9923-940dfba5dea8@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <b1088e86-a88e-4e20-9923-940dfba5dea8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 11:06, Krzysztof Kozlowski wrote:
> On 29/08/2024 10:26, Paolo Abeni wrote:
>>
>>
>> On 8/27/24 10:48, Aleksandr Mishin wrote:
>>> In case of im_protocols value is 1 and tm_protocols value is 0 this
>>> combination successfully passes the check
>>> 'if (!im_protocols && !tm_protocols)' in the nfc_start_poll().
>>> But then after pn533_poll_create_mod_list() call in pn533_start_poll()
>>> poll mod list will remain empty and dev->poll_mod_count will remain 0
>>> which lead to division by zero.
>>>
>>> Normally no im protocol has value 1 in the mask, so this combination is
>>> not expected by driver. But these protocol values actually come from
>>> userspace via Netlink interface (NFC_CMD_START_POLL operation). So a
>>> broken or malicious program may pass a message containing a "bad"
>>> combination of protocol parameter values so that dev->poll_mod_count
>>> is not incremented inside pn533_poll_create_mod_list(), thus leading
>>> to division by zero.
>>> Call trace looks like:
>>> nfc_genl_start_poll()
>>>     nfc_start_poll()
>>>       ->start_poll()
>>>       pn533_start_poll()
>>>
>>> Add poll mod list filling check.
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>
>>> Fixes: dfccd0f58044 ("NFC: pn533: Add some polling entropy")
>>> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
>>
>> The issue looks real to me and the proposed fix the correct one, but
>> waiting a little more for Krzysztof feedback, as he expressed concerns
>> on v1.
> 
> There was one month delay between my reply and clarifications from
> Fedor, so original patch is neither in my mailbox nor in my brain.
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> However different problem is: shouldn't as well or instead
> nfc_genl_start_poll() validate the attributes received by netlink?
> 
> We just pass them directly to the drivers and several other drivers
> might not expect random stuff there.

FTR, I had a similar thought and skimmed over other nfc drivers. I did 
not see similar issues there.

Additionally I fear that existing user-space could feed to the kernel 
such random stuff and work happily because the kernel is currently 
ignoring it - on other drivers. Such cases will suddenly stop working.

I think we could/should merge the patch as-is, please LMK your thought.

Thanks,

Paolo


