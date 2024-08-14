Return-Path: <linux-kernel+bounces-287303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD54952625
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 01:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8AA31C21B55
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56E114AD2C;
	Wed, 14 Aug 2024 23:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PteqQVt5"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E1B1494D9
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 23:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723677619; cv=none; b=XOJFMJY9cX5DLQ3Bsa/Mm4ayO5a/MTst4MBqoTw2dyYYYWoA9HSD3Rq+OS8mMFljd6YFOTa9UhCJUFbYlgtyxGh2iG7ceUFp3eePvudiWcMzFHPQaNeet39qHeMWMRRe0goPTZeVVpkcCSJmRoV9gafIgPFfHvX4lxdj9mqK1wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723677619; c=relaxed/simple;
	bh=PZLN4N17zBIpHYBXZkwihX7EPgZeSLBMItw/slpELCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhPSuRxuvZjJvtfLAzVK9Hl2+29VivwN+t2hl47eKBYX3Bo5sZEZPnasTg2sdyRITd9kInIS44WroluVRb2tRa3FH4u9TlXe+jfXuNn8pVG5OSpzlyZMQ/cnfjMwdGlMn9lnNi40PQh6l5cSNJJHmhurb68bV3SAZl7RYZwZxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PteqQVt5; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f015ea784so62711e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723677616; x=1724282416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9+duQA/mHkN4x/u1uIv4BDkW5OCTH29gngwXk4SCuCA=;
        b=PteqQVt5Fd/xpVdsZVuaYrdHAHmYQprPnPmPGAfJjSvk/447Jjkx+Kk1T4uE+0BmP3
         ezj8lqVvPFV+4A5MOBxFfLY+gQ0LwKVsxakSMMezlGq5ginBPDmmJUgZz/Y+UbWFnvpn
         LiOTS6md8CR0Akd6b+Qlj3mC2/pVF9BFE8J9FkDoWOfQPXTvVNJUcfZ1hz5dFwOlxCdm
         Eq0WFW/5bXV6cqH4vMbTdAmiyt+Y7gbpMLiQLnIUhG5YGMzviqQ6NBDZlG1GTHl3kjlH
         YUXVMHFedtQiP2y9Jb262C4Ghbrq2sylYQt4gsOsp4zM5cjW5T7Tdh9cE+HqQjlfsyuC
         qnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723677616; x=1724282416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+duQA/mHkN4x/u1uIv4BDkW5OCTH29gngwXk4SCuCA=;
        b=PUONRvcROfZu9YMqJ2qGNUsPd81noIEczAe8iqNf5M1Sp5DlKI3LkhChfnAc4w+0g/
         juNGWoCleTC8C5fWFMF2I9a0Hbgus1Do3sHlfQ4WL493FuKKCfqevuCA2h+YzdfcGE2v
         JBaiDKLV62GXcwlTEBwg7gVhspE0VFBSTtl4skHi8P2gB0j4+sBeV6ZXOh5jlInvLcQp
         DGZCGQXhtS9+0ZS2AF084MNwdLISPUJ+uctaRRBYzjK2SCfQvCAA++F+LkcD2Ks86vZC
         6gklXdcapjPwUNNUwqsSTjpal/fDW+7MFycA4BjhZdy3vjF5owunu3lYoeKWmSjsQ0PK
         j4PA==
X-Forwarded-Encrypted: i=1; AJvYcCV99pHSdpB5hImHivHUPisdX81Dl+NYe5aWw75zPyvQKtgVSiMyCuR2HQUcl0pKFxg7oZiEZz7+qluNr81WjZodpbTMU44Jo+LlzW0k
X-Gm-Message-State: AOJu0YwiuNvi9jjuP/oN72iETK/4eS4OmtedCqNR0EA11Y7uWJKmJu7q
	PcjkAhj3kWaVSV6+QF4KmlnXNwVnTWDSnToD3TkgZL2Ca4tkObUgjzMyXVMabbg=
X-Google-Smtp-Source: AGHT+IH+zpAbnWR0RFbKIop47GHGSsAo7482OTcO2tWlZY85pxwGVPWS8HuSvZWuImCttl0DLTw/TQ==
X-Received: by 2002:a2e:be90:0:b0:2ef:315c:67e1 with SMTP id 38308e7fff4ca-2f3b4a43cbdmr2763291fa.4.1723677615658;
        Wed, 14 Aug 2024 16:20:15 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f3b7703a18sm160771fa.81.2024.08.14.16.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 16:20:15 -0700 (PDT)
Message-ID: <b0787142-0f85-4616-9895-72e33f21c2da@linaro.org>
Date: Thu, 15 Aug 2024 02:20:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] media: qcom: camss: Add support for VFE hardware
 version Titan 780
Content-Language: en-US
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, bryan.odonoghue@linaro.org, mchehab@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@quicinc.com, Yongsheng Li <quic_yon@quicinc.com>
References: <20240812144131.369378-1-quic_depengs@quicinc.com>
 <20240812144131.369378-14-quic_depengs@quicinc.com>
 <4b745c1a-33d9-472a-97af-153a2a7c8721@linaro.org>
 <2de0b7a8-b879-49e9-9656-ec86f29ce559@quicinc.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <2de0b7a8-b879-49e9-9656-ec86f29ce559@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Depeng,

On 8/14/24 16:10, Depeng Shao wrote:
> Hi Vladimir,
> 
> On 8/14/2024 7:13 PM, Vladimir Zapolskiy wrote:
>> Hi Depeng,
>>
>> please find a few review comments, all asked changes are non-functional.
>>
> 
>>> +void camss_reg_update(struct camss *camss, int hw_id, int port_id,
>>> bool is_clear)
>>
>> Please let it be just a declarative 'clear' instead of questioning
>> 'is_clear'.
>>
>>> +{
>>> +    struct csid_device *csid;
>>> +
>>> +    if (hw_id < camss->res->csid_num) {
>>> +        csid = &(camss->csid[hw_id]);
>>> +
>>> +        csid->res->hw_ops->reg_update(csid, port_id, is_clear);
>>> +    }
>>> +}
>>> +
>>
>> Please add the new exported function camss_reg_update() in a separate
>> preceding commit.
>>
>>>    void camss_buf_done(struct camss *camss, int hw_id, int port_id)
>>>    {
>>>        struct vfe_device *vfe;
> 
> Thanks for your comments, I will address them in new series.
> 
> But I have some concern about above comment, you want to add a separate
> commit for camss_reg_update, maybe camss_buf_done also need to do this,
> but I guess I will get new comments from Krzysztof if I make a separate
> change, Krzysztof posted few comments in v3 series, he asked, "must
> organize your patches in logical junks" and the code must have a user.
> 
> Please check below comments.
> 
> https://lore.kernel.org/all/e1b298df-05da-4881-a628-149a8a625544@kernel.org/
> 
> https://lore.kernel.org/all/d0f8b72d-4355-43cd-a5f9-c44aab8147e5@kernel.org/

Krzysztof is absolutely right in his two comments.

 From what I see there is a difference between his concerns and mine ones
though, Krzysztof points to unused data, which should raise a build time
warning, and I asked to make a separate commit for a non-static function,
I believe it'll be removed by the linker silently...

The potential runtime logic change introduced by camss_reg_update() in the
generic code is not trivial, which opens an option to update/fix it lately
referencing a commit from generic domain rather than platform specific one.

If someone for whatever reasons wants to merge a new generic and shared
camss_reg_update() function within a the platform specific code/commit,
I won't strongly object, let it be merged together then.

> 
> Or I don't add reg update and buf done functionality in
> camss-csid-gen3.c and camss-vfe-780.c firstly, then add them in a later
> commit.
> 
> Could you please comment on whether this is acceptable? Please also help
> to common on if one commit to add them or need two separate commits, one
> is for reg update and the other one is for buf done.
> 

I would prefer to see two more separate commits within non-platform specific
code, however as I stated above if it causes anyone's concerns, including
your own, let it be kept as it is done today. Eventually we do discuss
a non-functional change.

--
Best wishes,
Vladimir

