Return-Path: <linux-kernel+bounces-248076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1815A92D823
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496A51C21264
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE11195F28;
	Wed, 10 Jul 2024 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZHiFDq33"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2B11922E3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720635316; cv=none; b=U1zVj/qN5W2eT20uv2BNdsFNUiA+TFSfloUnQPgiFEUk39s1Q8ed/7urhFFM4iqWGUrLpeKNkN6o5blV5vJ0xZCN03TwCsh9pCMRBxSmhYl7jXTZIqoMI6O++j/b4MAeElh9O5+dGZs5Dgrsva337180wIOm8OcemWypye5CKV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720635316; c=relaxed/simple;
	bh=fi0BW+/k8VQydo/kennAewSTGcXiLJiRcnEfWWAowLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gihOBZ+svEP67JGXlzxgS5bxZy57L/gRTnGYxaXvgwkH1b1prpEYZr45NQ7EpaqWB2jIH2vU7b2iR25NIkl1hSpFJW8GYjuonyPGJ7cWr2bPP5HxmlvuzChwYVXXkrGbOG4IN8sLFDMfPoOtMIcwNk2Z5hh3o3zLYK8ZYs/we+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZHiFDq33; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3734052ffd9so23285ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720635314; x=1721240114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fi0BW+/k8VQydo/kennAewSTGcXiLJiRcnEfWWAowLQ=;
        b=ZHiFDq33pmdMcxOcOWPt0u7b8VF/mv3Js/7+nzeRqfsiTQAOHhdapUST31w/EfQkZ/
         eMOL6DVO7amjwB+aDtLWuKDX0t+Fv4r11wNBOtm8RMuDCQe64FEZCi15d9PZ5xljA9GW
         ML/YGxcFYm7BAFBsYXYp+af4ArvRE1RbzhCRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720635314; x=1721240114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fi0BW+/k8VQydo/kennAewSTGcXiLJiRcnEfWWAowLQ=;
        b=lncIL1uSmVRt9GUmBhmRid7Ji1/L1aAX3hcLH6K2flmiNVZ5BzhMKDXTPh8RJLW15+
         IXaYtfJchcviusaIlCvFpanCE/bpbxuLxkNFyUi0iPiL1oESTC+lCXj6HtzDtYQIDJqc
         T41FLUvIhZkWrS2iuXwR3q+4D6e0X9fsx+vF0RnRi6XMozJDiEHTde1GH/xzKRepW+gM
         hJAaqowuN4lujSi1DxtE9+5Y85CGoIX5z7yT29z1fBw9jQt9UuITW7j6NsrElSSaALta
         1F521eUzr31XxnALq2HHflSzt2muNegwp0JH9NkesXEDS/XWZsmQUgK7WPowMv+/eW/a
         w2XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXNcnacn1yXxosd1KqaRM80c1GCta2ASCx32nEqYr3V6IZYPSkl1mocyO0vme8Vc7vPG6yR30SeewkhLmmGIfwOuQrGBgtnblOd+nY
X-Gm-Message-State: AOJu0Yw9W2GuG7Zi4mN9UNuYZjXMPwAcuzP48Hb1LhoU0zgou/Ectat8
	XSJdFXJSNySrQ7b9bgRMFWmzJPlA0SR1kZeBQXv1OE0fNI5Zg/HfMqQ4O6YZPrNh1O7AtWf+XhS
	D
X-Google-Smtp-Source: AGHT+IEzdvyoCYqDNqyo/iN7U0xS3TaWnI9DWR7yzrDPdcmXeGnd4nNRI+1ytQfug5kfdYbTFC9Bxg==
X-Received: by 2002:a5e:da41:0:b0:803:f97f:59e1 with SMTP id ca18e2360f4ac-806d91a2a7emr38799939f.0.1720635313687;
        Wed, 10 Jul 2024 11:15:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ffed680f8esm133773339f.49.2024.07.10.11.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 11:15:13 -0700 (PDT)
Message-ID: <415baa3e-1bbe-4da0-8f69-d4e818f45925@linuxfoundation.org>
Date: Wed, 10 Jul 2024 12:15:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/thermel/intel: conform the test to TAP
 output
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240522170655.2879712-1-usama.anjum@collabora.com>
 <175ac98f-481f-46e2-a3f7-206b64d8b0e9@collabora.com>
 <7e3b3870a68f4e98f2e33d748a2740d3d430bad1.camel@linux.intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <7e3b3870a68f4e98f2e33d748a2740d3d430bad1.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/24 03:38, srinivas pandruvada wrote:
> On Mon, 2024-07-01 at 13:36 +0500, Muhammad Usama Anjum wrote:
>> Soft reminder
>>
>> On 5/22/24 10:06 PM, Muhammad Usama Anjum wrote:
>>> Conform the layout, informational and status messages to TAP. No
>>> functional change is intended other than the layout of output
>>> messages.
>>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---


Okay. I think I responded to your other patches that are adding TAP
to individual tests when kselftest wrapped does it for you based on
return values.

The reason I don't want to take this patch is if you run the test
using the recommended method:

make -C tools/testing/selftests/vDSO/ run_tests you will get the
TAP output because lib.mk runtests framework takes care of this.

or

make kselftest TARGETS=vDSO will do the same.

Please don't send TAP conversions for individual runs. You will
start seeing duplicate TAP output which will make it unreadable.

Run the test using make -C or make kselftest TARGETS before
investing time to concert to TAP. I am not going to take TAP
conversions patches if make -C or make kselftest TARGETS
shows TAP.

thanks,
-- Shuah

