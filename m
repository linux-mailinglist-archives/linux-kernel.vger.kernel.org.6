Return-Path: <linux-kernel+bounces-384041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C4E9B2389
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 04:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA472820C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 03:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C64188CC6;
	Mon, 28 Oct 2024 03:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FVbn+X9w"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCB8187FE0
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730086164; cv=none; b=r3NuprSV8mieX57+Np3RhQk1FK8YLjMeRqUXO0LdT1TBm6uXxPSW+pxlZwJltRHoropX9GOQ+LN0KZdDGhtLX4yGKqdwBzsxy2c/DbdZJY21Zw2NwN59wrDj4Li7bHFDJPJ+dqKtUvZL9u3J/BNKLlhVF1wON3oATd5QRon2utQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730086164; c=relaxed/simple;
	bh=ZUgn5auMAqHVPGMBEicG+OSOIN+nAWJczwe8jhTNqCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pfIGZCnxCSV1+82gelFbuOZf2wEz6MZChPOgwsxRfq2wPp/mm4lWqDwePam75qJIJbXw09g/nafefa3sai47mdIC/PhaYi3rc/KDmae+/Ftd9LxjnPWCU5gxfdt2//1Hp/UiRIzu/0FroRxAxfL/ES70Pos7jO0ogc7oc+fw3Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FVbn+X9w; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c8b557f91so33879905ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730086162; x=1730690962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2JNX2llXAHJCeRvWQ/Q2ie2XQ3BEH+ykwHa6OOhEWog=;
        b=FVbn+X9wlamLIIxX11oPr60+jzDDFbTea/imgJMhqL1ypa386NiJ8LQxSOYcCnPR6G
         bjoGzVqkK+4o7lre2YR5FtNZ6Yqyqe8UeqVWUHVhllfWVXpB7fpSYO4AzOFVWuMz/R3a
         XWotbs5oB+EFQBfK0SOshziI9mMO2Ol0cghvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730086162; x=1730690962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JNX2llXAHJCeRvWQ/Q2ie2XQ3BEH+ykwHa6OOhEWog=;
        b=O+lH+jjU/KmdTyE5xxZ5qZIeAmNa8GX1BkMvkymD8JlQE8FgtRkWxMKkb/DZWtXVIU
         mnDdgTXJHgB3ZxHWmtjSzaQPTy0K5wkElxlzL2TLctNAUXc/bRgFPQeqYsHxZ6pCKwmb
         kaVduiyPMcePgSHByKHDHB6Ip/Mb5q7HxmAUREMLU99ddMRx5GSPS9yxh8OnYm+kwFBS
         QRBHD7yIF/Mb1wT9BAC+SfPtbWrMTeoq2PsTEaOSYQCA8ofOiaCVhAxI7kyXtoDDT+8Z
         yqeXRtp/g73haKJ90bLAOyiQ90zBxc75Z6vHfmuuPtTZEzOrEekhEHiM3+ypwvmNCmYq
         kFgg==
X-Forwarded-Encrypted: i=1; AJvYcCVi8REL4/hacOODbWO7PIK0+GI8telIojTOH0mJ4IZeoGmeVVCW9NfHjLHgoy6t6Kin+dkxXTah5PMwwe0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Pg1yazZiKhjZxXLBdhvQ58Kvg7l6DmCCYz4UNBIHwwwulG14
	bl1+FtdUWHRwSEAnekjiACjlSpD0BUEF38374D2IXm34Rac9zxGvBGjkcqlRwus=
X-Google-Smtp-Source: AGHT+IHIYevKtlUJ14/kpJ+BcCcgfP6lKOhNeT5/W5EOcUEYMJiTWOpFdRq9nDEZG5FNDfJJSXun9w==
X-Received: by 2002:a17:902:d50a:b0:20b:57f0:b38b with SMTP id d9443c01a7336-210c68d748amr92451575ad.19.1730086161664;
        Sun, 27 Oct 2024 20:29:21 -0700 (PDT)
Received: from [10.200.3.216] (fs96f9c361.tkyc007.ap.nuro.jp. [150.249.195.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc016911sm41526035ad.155.2024.10.27.20.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 20:29:21 -0700 (PDT)
Message-ID: <e907e67d-9116-4dd2-9b61-f93191737de6@linuxfoundation.org>
Date: Sun, 27 Oct 2024 21:29:18 -0600
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
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <0861d73d-4fd9-4118-91c8-5a619c7d7ca0@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/27/24 18:50, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 27/10/2024 08:28, Shuah Khan wrote:
>> On 10/24/24 19:39, Li Zhijian wrote:
>>> Currently, watchdog-test keep running until it gets a SIGINT. However,
>>> when watchdog-test is executed from the kselftests framework, where it
>>> launches test via timeout which will send SIGTERM in time up. This could
>>> lead to
>>> 1. watchdog haven't stop, a watchdog reset is triggered to reboot the OS
>>>      in silent.
>>> 2. kselftests gets an timeout exit code, and judge watchdog-test as
>>>     'not ok'
>>>
>> This test isn't really supposed to be run from kselftest framework.
>> This is the reason why it isn't included in the default run.
> 
> May I know what's the default run, is it different from `make run_tests` ?

No it isn't. "make kselftest" runs only the targets mentioned in the
selftests Makefile. That is considered the kselftest default run.

There is a reason why watchdog isn't included in the default run.
It isn't intended to be run by users by default as this is test is
just for testing watchdog api

> 
> 
>>
>>> This patch is prepare to fix above 2 issues
>>
>> This series needs a separate cover letter explaining how this problem is
>> being fixed.
> 
> Cover letter is in this patch, see below:
> In addition, we can get the 'How' by reading the simple change in each change.

That isn't enough to understand why this change is needed.
Send patch series with a cover letter explaining what you are
doing.

> 
> 
>>
>>>
>>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>>> ---
>>> Hey,
>>> Cover letter is here.
>>>
>>> It's notice that a OS reboot was triggerred after ran the watchdog-test
>>> in kselftests framwork 'make run_tests', that's because watchdog-test
>>> didn't stop feeding the watchdog after enable it.
>>>
>>> In addition, current watchdog-test didn't adapt to the kselftests
>>> framework which launchs the test with /usr/bin/timeout and no timeout
>>> is expected.
>>> ---

thanks,
-- Shuah

