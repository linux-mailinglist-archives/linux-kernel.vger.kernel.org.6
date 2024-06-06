Return-Path: <linux-kernel+bounces-205134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152178FF7E7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF952857AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7BA13DB92;
	Thu,  6 Jun 2024 23:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FEYCJFF1"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C09535C8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 23:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715000; cv=none; b=V++lM9uGgJioix1iFdfn/d+sY2qgRq079NHH0UstSy7oEcbwy711TAagZKC7a4iORM4AzVP3P5wEeGZJGz5Yj65UZ7610Zlk/De8qg/koFAeifos2KYXggRweLbNd8JT+8ef2iuBfSftrNOvFWmHjRsZf2gHz66rIJRD6Tc49zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715000; c=relaxed/simple;
	bh=kMnjXiY2TH6WLrxS7NvxTkG8S8yaLFy0Tv2TpuX/WyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pCaHmsTaTdqfC/2osYIXFPX+cVD6BYZje2CR1mDotzSFAjbfNnFnTYbZs/H/fZSMViCeBxb87HMTl0166Bl6cH+A0P8K0LXHNmw1Y86bsA4sJs4Zf9MrYwLJml53aD/pbnKPAN/0BwdmUeyDj0+Wi9aX9Czk+2/cGM92EuyXNYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FEYCJFF1; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3748bc93e87so889115ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 16:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717714998; x=1718319798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WSwzpZYUu1xmHPg1f7bkp3xG7EtMyrFFSdaCiRvwBnA=;
        b=FEYCJFF1Fw0h18o15laGnlcYA4mWT1Nh2oB1L5HahzLVsNTdY1hYUVXDx6v/QYd3Kb
         ssnr7bYHzJ5SSNSrVPWEAb0Sq1efFesv5uKQxitG+s83DILk43uCo2RX14pWgod3x8wn
         60dr6R5xQ45ekiU+P3A0Hk6g6iqoHPs1vosUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717714998; x=1718319798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSwzpZYUu1xmHPg1f7bkp3xG7EtMyrFFSdaCiRvwBnA=;
        b=ae7Tm9DeX/MQZlNdc6wqrneTuCBFmg8C55OziP8lWH0GHLC1NncsbH7xvtFvADSlku
         nbR7tYIlueDyZ2oZnzwak1S8MhpLL5H13No1H7Xp+N4RWupwz+4e4OyL6Ww/GrKxk4hz
         FN/FWRqtfoZurl0HFZzzX4WOAELc5ekWr5OEeiwUawCnvBXWcN/K/Fl6T4MSPS9ROiLN
         nd/SU8IbYBjSpdLnrNZZ/XqxkDOCcvNXEMyYz/upKdQZH5SM4lurX37RsTK6kV70HN8u
         bBCD74gj49Q7JtCiRAq1Kntwy+VqVsk94Z2NMbmnkeOgO7jWfDwp0DIVmmV4I3rdQdsT
         omCg==
X-Forwarded-Encrypted: i=1; AJvYcCVmwMVe3SjxDE+T3onlrgSh/4UocG4+6Ciq4wo934pEAdZspAims9BGwnXFRAyNcMmlj7tZCZMdJRxfs1pj2p9CTVVTRR6Cyt75BBZg
X-Gm-Message-State: AOJu0Yyiz5Ki3PnBcm/SI8pF7bY7yKfsNU0sLTKV4Bk/hZJPCeUplQN0
	xG/hTJyj/cqyJv+SmbtnRqasIgwICQFAF5wt6EHtF8YFjZIe6iedaJC+sthoULQ=
X-Google-Smtp-Source: AGHT+IErb8QhrMrD58+3GtGxtleq3phws95UT1YHdUEMAgr/NObxJzRLHoP0lgBpi9J8bzt6cgRtIw==
X-Received: by 2002:a05:6e02:1a8d:b0:374:9cfb:ee13 with SMTP id e9e14a558f8ab-37580236023mr9811845ab.0.1717714998019;
        Thu, 06 Jun 2024 16:03:18 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-374bc15d9d9sm5105765ab.37.2024.06.06.16.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 16:03:17 -0700 (PDT)
Message-ID: <646f0597-240a-4251-b45e-e45f504734a9@linuxfoundation.org>
Date: Thu, 6 Jun 2024 17:03:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Modify the watchdog selftest for execution with
To: Laura Nao <laura.nao@collabora.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org
References: <20240506111359.224579-1-laura.nao@collabora.com>
 <20240606095714.397658-1-laura.nao@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240606095714.397658-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/6/24 03:57, Laura Nao wrote:
> Hi Shuah,
> 
> On 5/6/24 13:13, Laura Nao wrote:
>> The watchdog selftest script supports various parameters for testing
>> different IOCTLs. The watchdog ping functionality is validated by
>> starting
>> a loop where the watchdog device is periodically pet, which can only
>> be
>> stopped by the user interrupting the script.
>>
>> This results in a timeout when running this test using the kselftest
>> runner
>> with no non-oneshot parameters (or no parameters at all):


Sorry for the delay on this.

This test isn't include in the default kselftest run? How are you
running this?

>>
>>    TAP version 13
>>    1..1
>>    # timeout set to 45
>>    # selftests: watchdog: watchdog-test
>>    # Watchdog Ticking Away!
>>    # .............................................#
>>    not ok 1 selftests: watchdog: watchdog-test # TIMEOUT 45 seconds
>>
>> To address this issue, the first patch in this series limits the loop
>> to 5
>> iterations by default and adds support for a new '-c' option to
>> customize
>> the number of pings as required.
>>
>> The second patch conforms the test output to the KTAP format.
>>
> 
> Gentle ping - any thoughts on this series? It would simplify running the
> watchdog kselftest in CI environments by leveraging the runner.
> 

This test isn't intended to be included in the default run. It requires
loading a watchdog driver first. Do you load the driver from the runner?

thanks,
-- Shuah


