Return-Path: <linux-kernel+bounces-270613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFD0944219
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FFC7B215E0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170F913D889;
	Thu,  1 Aug 2024 03:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="MGrGm2pF"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040DB13D60B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 03:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722484628; cv=none; b=qjnaF78Cu8VwhbQACm9vNpvp8kb3Mceia372FTOu8dAr3XCRbOBNp5573FeyYzYCz+zGRVFNlUCLuKwdpsHf7f5kQ2wpTPhK9/j39AdYi0T8ORMhg6w7dXsL9lzY9cI41brdsZPpFrL3Vi+GtwrTXBYFNH5DiJ3l9tFJZ1deB4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722484628; c=relaxed/simple;
	bh=9z+DUe19MXcVwhPiCcg1jBIb6j+CrevqhI1KdsX/zG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7JHPe1UhrUlFIkHv39IrDZPGqKEDt+MIfr57lvcJdrlRxmdlhWBtGW3x5o/hczRgy8ZItjSOAvJ3zjGFuwXRZ6nTbrMfQAA/bS3Is7xApIijOtGt29BqxMIYNbCq6jdrdcJpeP2d71yvSK9MvI9ZIvr7MZsVMLCTqPjdd8MyPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=MGrGm2pF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70b703eda27so4148633b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1722484625; x=1723089425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E3c0jDeg9jATLBjz8MH1N0Oj6qwqnRYEeVc2HEf4DB4=;
        b=MGrGm2pFRyQjizS4KN/++6GMaqvkhvmwFREh86hWbwtUsKAcOI0ypVIpeJqwAVxPek
         mvBNIPEiuiUSEaxVAVWT9QLwgVG3Zm4hamN2O3/kHtS0g0rvERyzEUCKGr99aqqktBNK
         04DzQxxcE0UDwKOwQ3j3KsmqzC407zcvwhDSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722484625; x=1723089425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3c0jDeg9jATLBjz8MH1N0Oj6qwqnRYEeVc2HEf4DB4=;
        b=HbEDD6Rla2IJf3zFtZcb46Cxkumn2El5IuSOI8rl/AiXa+QTW3Ycs/AifgE5VOtVlk
         tModE//IicJ9vY46xq6Vcbos3ws0PAOTlnKw9TJ34QgC9eItgIVYSxkbmNDFLPq0nkin
         /2mJn20GwFFNpGlLW7UeCDT4qShXdzuzIbK0n6LGKOnZYEDHENEetyIiYRopCREcgLmE
         Nyj8kMQ6B7Bf8BozKXoIJERq+npMuCBR/g8ZDo7aUS0ixIZqNu47ETGkck9IiuXTZ7nw
         NrWNdSutgaORuWE07rln8lEZpJNHLfUi5Gyb7xfyQRNnjuGiTCV3G/vK3Oi9D8g1mAZe
         36tw==
X-Forwarded-Encrypted: i=1; AJvYcCUq/kSe+zpJyxwVH1icuGXpQm+SXa46lrRyw2p0tZ6RmGKKQMeZe0pHHMeo7pn7uKCMVqm+8cSfbdgVLZ7gO1a6Q7+bF3TQ6AKC2Xjt
X-Gm-Message-State: AOJu0Yz7s8XgLRTLDvhh4AA6pICXDyMrmB12jqRKuer3BjzjfZKnhLJO
	rA0pQAP1zAobXd/cPy2qKr0pgkrko6UnX3raEjnz0iyrEdoeKFeagnyc0AxVaA==
X-Google-Smtp-Source: AGHT+IEFdP76UW/IZ+sC2v4ImHKOP3FcwGDmZrqokrJHVTrqdDNiXNJhqK0SPMMBLeC7lZGGATEBbA==
X-Received: by 2002:a05:6a20:9f86:b0:1c1:61a9:de4a with SMTP id adf61e73a8af0-1c68cf22b8amr1895142637.24.1722484625007;
        Wed, 31 Jul 2024 20:57:05 -0700 (PDT)
Received: from [172.16.102.95] (c-98-45-34-39.hsd1.ca.comcast.net. [98.45.34.39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc430fa2sm2150004a91.13.2024.07.31.20.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 20:57:04 -0700 (PDT)
Message-ID: <721b286c-7143-40c7-84cf-c77986009895@penguintechs.org>
Date: Wed, 31 Jul 2024 20:57:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Bluetooth: hci_qca: fix post merge window regressions
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
 <CABBYNZ+dvLGos9oLi6euFkmiU9OReJ5F3qsA6WrhW29yeZ-jWQ@mail.gmail.com>
Content-Language: en-US
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CABBYNZ+dvLGos9oLi6euFkmiU9OReJ5F3qsA6WrhW29yeZ-jWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Luiz and Bartosz,

On 7/31/24 9:32 AM, Luiz Augusto von Dentz wrote:
> Hi Wren,
> 
> On Wed, Jul 31, 2024 at 11:21 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> Here are the fixes for regressions reported by Wren and Dmitry. I could
>> reproduce the crash on db820c and so I was able to test it but patch 2/3
>> could use a Tested-by from Wren on QCA6390.
> 
> Can you give this set a try and report back?

I'll give it a shot tonight or tomorrow and report back.

Bartosz, thanks for looking into this.

>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> ---
>> Bartosz Golaszewski (3):
>>        Bluetooth: hci_qca: don't call pwrseq_power_off() twice for QCA6390
>>        Bluetooth: hci_qca: fix QCA6390 support on non-DT platforms
>>        Bluetooth: hci_qca: fix a NULL-pointer derefence at shutdown
>>
>>   drivers/bluetooth/hci_qca.c | 19 +++++++++----------
>>   1 file changed, 9 insertions(+), 10 deletions(-)
>> ---
>> base-commit: cd19ac2f903276b820f5d0d89de0c896c27036ed
>> change-id: 20240731-hci_qca_fixes-8e7a8ed3ad83
>>
>> Best regards,
>> --
>> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
> 
> 

-- 
You're more amazing than you think!


