Return-Path: <linux-kernel+bounces-384192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B16B89B26FE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E02EB20D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 06:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA26518E77D;
	Mon, 28 Oct 2024 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JKS2suAu"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DF818E354
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097864; cv=none; b=sI3E69uojI3AGIgb2iEB/6wZXXBok47TH0NKJ+noxGxH6wJWsiQM0o0yvraTX5WH135Y6AYdqMl+U9sDnpJl+9RxcQHKIku8tz71OpfIxt/Uiv1OEhhvYDke4XQ0NWMe4U2kszCSyQsEu3O8Uleh1BqXFyKSMDNQ52AF0XU1CAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097864; c=relaxed/simple;
	bh=szX7EU9aLNv0+EZxN5RBKGnFWigvoANkwKvQRhGlAJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHQEniaZQo/BpfQI5wzHjbb6EWeSVo+Vz8txJvJBdyKH3TXO/wyszwsvFrL9AruszlcfAwRXusR2R04tHj4Lpmmuvp07sUP/1Q8lsJ6IZMBv1w9n7A8RWoTc8SrjKwbF/Y4wLgOP2fFIaMNitYs9QZvYc4U/f+Msv3Vc7uYLLbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JKS2suAu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cd76c513cso34357895ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 23:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730097861; x=1730702661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QfXQP1VNw9IcFrz8YyJuW87NPkl2MSBeUqUwC/i+Qyg=;
        b=JKS2suAuUUX5pgKIgzT0NMNCudhSShpBYnKm7M6+vJ+zam2H3ibvw44XdtPjIxvIQG
         Yp6LND8bWYFXZ/0H604Y4O55TV4YrvxGBKwFrCDnhvRBnldQ9Byy7hUUth4kRvT1TM9X
         5VaKOjS7c0gzWLoOQbLuQLrwmyRQPfBYUnDhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730097861; x=1730702661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QfXQP1VNw9IcFrz8YyJuW87NPkl2MSBeUqUwC/i+Qyg=;
        b=ajlPwb0Ts4UocpdXIqAsUCDDWrvZklrnCsNV15ySs8XmCz6SJcEP2w937ZOJclg/sO
         mWWyNc2kF04fE3xNPbJ77CbZo1ExfHPuj3+H3sGVE5B22bFDXqUm8Q74e9wz8leB2k+5
         2kdPsJG/5k9DYmnbVFpgvvGvgCijrnDHAQeixSX/uNymGqx7ZVgkl7TPv5RXuvzop3AO
         dbc6hvQy9IsYwB3BC61FN8z6nRKjV1PFlcWLZUbWbSGVybrBfKFMuwVOzlRjRBFFfk1d
         /wC9+ZWmQJ3bZOrSYma4Vf4+mHapAfEdv0EsK6DBriMhtL5yMKjSeRuacPAoNUKumtjE
         aMmg==
X-Forwarded-Encrypted: i=1; AJvYcCVo87MNmrCKCf/8lWFxP3Lbgp8YbGCRYQgPJep3oML9/s+ZiIEgdpSv0kPa865okrgBOZc4QTcDzdRMhac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAk6Pe6z+zFGktNtCbyrbA4lHKzfRV/LK4c1rdxSmdSMIx1IDf
	uUc/MEPuDjMJtbQuXzskATytYcksMSc4Wg9SXYIHIlvR8ftZPm0zUpVDGBa3kN4=
X-Google-Smtp-Source: AGHT+IEVJPDfA5kV7131t/dI+va2tNzRfws46JA7Ih+iIvIxiw5uodkABFsq1KQRtPHKUx1dFSpYyg==
X-Received: by 2002:a17:903:2449:b0:20c:d578:d712 with SMTP id d9443c01a7336-210c6ce56acmr117599405ad.59.1730097861348;
        Sun, 27 Oct 2024 23:44:21 -0700 (PDT)
Received: from [10.200.3.216] (fs96f9c361.tkyc007.ap.nuro.jp. [150.249.195.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc012fc1sm44792595ad.161.2024.10.27.23.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 23:44:21 -0700 (PDT)
Message-ID: <e0bf1824-c476-490c-b63c-0789dabd788b@linuxfoundation.org>
Date: Mon, 28 Oct 2024 00:44:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 1/3] selftests/watchdog: add count parameter for
 watchdog-test
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Cc: "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241025013933.6516-1-lizhijian@fujitsu.com>
 <c2cae7a7-1a0d-48ef-9b8f-8d2436532ea7@linuxfoundation.org>
 <0861d73d-4fd9-4118-91c8-5a619c7d7ca0@fujitsu.com>
 <e907e67d-9116-4dd2-9b61-f93191737de6@linuxfoundation.org>
 <b7b3deec-47fd-43e4-a9b5-7099e3c00623@fujitsu.com>
 <54cbf018-eba1-4227-b464-78bfa41fa4ae@linuxfoundation.org>
 <3ee0d14a-7f6b-4ef4-9349-d6b0f14ba9e8@fujitsu.com>
 <f10e8a78-3b50-4212-9b5d-ba99a3421379@linuxfoundation.org>
 <6862e399-b169-4ffb-b9c6-904f99d96e56@fujitsu.com>
 <19579b1c-0a9b-4c72-be00-44871dd37b9a@linuxfoundation.org>
 <a6a5d13b-c550-4a99-9a84-b28e8314ccd1@fujitsu.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <a6a5d13b-c550-4a99-9a84-b28e8314ccd1@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/24 00:32, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 28/10/2024 14:25, Shuah Khan wrote:
>> On 10/28/24 00:06, Zhijian Li (Fujitsu) wrote:
>>> linux/tools/testing/selftests/watchdog# make run_tests
>>> TAP version 13
>>> 1..1
>>> # timeout set to 45
>>> # selftests: watchdog: watchdog-test
>>> # Watchdog Ticking Away!
>>> # .............................................#
>>> not ok 1 selftests: watchdog: watchdog-test # TIMEOUT 45 seconds
>>>
>>>
>>> And i got warning in dmesg
>>>
>>> [ 1953.229511] watchdog: watchdog0: watchdog did not stop!
>>>
>>>
>>>
>>>
>>
>> Run "make run_tests" under strace and send me the output.
> 
> 
> Could you share the exact command, how to 'Run "make run_tests" under strace'
> 

strace make run_tests > strace.out 2>&1

Send me strace.out

thanks.
-- Shuah

