Return-Path: <linux-kernel+bounces-306537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6CA96403A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6821C24742
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5111018D622;
	Thu, 29 Aug 2024 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9AZTnIK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01612219E0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924049; cv=none; b=WlkDT1S+SDxBUvP0ODykn8cjM8lheXpLUPNMpmTsyi8ZmjdzHBH71I7RDmfRdVl+pLFEVFLf9Vx33kq1cOwv1ZXu0pBNT6Gc56bDY/QRXlSDr0Fispl7Pvs4lC5Y6S6SHPH+wndOCHjy/UTcc1HhJ0uyvb4/gIrmLNlT9FY1g40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924049; c=relaxed/simple;
	bh=JysCSfHgK24yWzdWo/5Cx73f7aPyPjUA4tMgZAwRv3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAsHqrqhUtchK1fXgK0G/it/6AhZ2CCfzlW/ucYZJ0m6+WUSZREyrnDcKE3rsVNlAsW/ysiUujMZs3WFm4B5NbUM/va4lie3MQbX9js43jgwYFT/0+kFCWuoNL4BGhYuh1c/DbFQU0/hQZWg5iJSv3F7xPgaA65/qpzgAwEXXOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K9AZTnIK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724924046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRhf0ft13sdsULrJq6iL+gwjruDGQCG9graD1/4XUWs=;
	b=K9AZTnIKMyJdt1Snx6CdhaR1xfHr/rcmysDvFUJLdu5BFmwM7rX22pd/MFNKyCdtUxx1dc
	mRs7N5TrCmlInAaRp5SrBns7UhjmwwtGZ/vEr7iY87wFufUQCJO5r/ULgje8K1GX4hJEFm
	eYB2X6gLdF76rOiSdOv2th/wqN3XPt8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-0XR2RRfVMVCCfPM21d54uQ-1; Thu, 29 Aug 2024 05:34:03 -0400
X-MC-Unique: 0XR2RRfVMVCCfPM21d54uQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42816096cb8so5627345e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724924042; x=1725528842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IRhf0ft13sdsULrJq6iL+gwjruDGQCG9graD1/4XUWs=;
        b=tvKX2hHA/dOcAzXPaTo1mcjKSOUvlox9lvNtASu117l85iXDYPE4ep1SMl+NdjHuc5
         9MR1glJe9VFU/h1pq7h8aKeJS/yxOUkdatbTlovp6wMy0yTLgECVaFesHQafhI7B7iKU
         Fge4zrrwEThYbDVD8/khdONwy+rOpsiz6mUg19wJl69NaMO02tNl+5qViMVZvinmUJ6j
         HmM4EHJ9/tN/LcYhCikO3y/ycEE5SoNi7IC9q3U/RuX3wYTQlnEuOfXxsbmOLU1t4Bh1
         MhXcwMZDkk0CDblojjlWwqr9yy6l+exVJemhSopaW1Uc38huefKfpMrs3GJ9OU7mtYXj
         OYMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN+jQIRSqylMv11voYcdEM/Dgajb+sWcAaukJJtdQBdS1H/97rdxzG47bBNwqrxf7eITFgP4DBhQkigx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFwFYLp+DQsAPfumy0sxcnFZzNC8AkMKLy2vglYCADOH9RNuMe
	E/vIsapKnuwgMewNwSPQIatPHE8fHhK+6nIywBC4cKX5x6cz5avcO9hMNwPW5RR6hJoVPyIsdf8
	+ZFhftj99Dn2452tfkmEZ80rHApl1ctFTu9oSIk10+Eye9ubcu7SIVId+QVqkng==
X-Received: by 2002:a05:600c:4ece:b0:42a:a6aa:4118 with SMTP id 5b1f17b1804b1-42bb01c1b92mr23828075e9.18.1724924042420;
        Thu, 29 Aug 2024 02:34:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp3x3sJmbQoDYIBd/6sKnodDuko7n08nPVFtSHanDsq4XaBJ2ce0s2y16TQdY5AiDJ9Js95g==
X-Received: by 2002:a05:600c:4ece:b0:42a:a6aa:4118 with SMTP id 5b1f17b1804b1-42bb01c1b92mr23827825e9.18.1724924041875;
        Thu, 29 Aug 2024 02:34:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b50:3f10:2f04:34dd:5974:1d13? ([2a0d:3344:1b50:3f10:2f04:34dd:5974:1d13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e273bcsm11348575e9.31.2024.08.29.02.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 02:34:01 -0700 (PDT)
Message-ID: <a337ae5e-1333-443d-8374-67420823a590@redhat.com>
Date: Thu, 29 Aug 2024 11:34:00 +0200
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


