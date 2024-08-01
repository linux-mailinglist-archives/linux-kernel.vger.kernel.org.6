Return-Path: <linux-kernel+bounces-271803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55383945361
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D04C1B22618
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D9C14A4F1;
	Thu,  1 Aug 2024 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BctJWv/G"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF90B149C68
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722540439; cv=none; b=t8bV0DoZpcN5/EimO083eW3tr5DYgIqsFL43scLP6x62fHnG8SC1kOZxhodcP9VAk03m/b+XFA3qTTYa2aXU4yVw3yuA7GsscIAuic7kNXDbctecOEA3U56YrtobTr1u6eF7ez1PMEo1WkwOigRd6Fae5+mM5ZC233vRpcBV4zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722540439; c=relaxed/simple;
	bh=tywakX45M1InnvuZ/1MtoJOyWN5YWGbgUz3ZqaFBEcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDkM3pJAVXG1P96QMK6RbJNVx/Qu/hqYgsK1zWoCaD8WVWjmCf5ov4ufsV4QiPeZf2F9w88zknkVqCDcgamvoNBeJjffA4gfHhzjswKjXX72EjYYmkj+YPIb3isrj8OYCnJn8dJY5yxo0Q4MsAsx3nuB9QbRvprejq2A+vuHklY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BctJWv/G; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-81f902e94e6so33482239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 12:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722540437; x=1723145237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t8iCP5X47UzqYC6qlEo1ldBtwUGspd9bUTugmBKJccM=;
        b=BctJWv/Gtywp29aDAKzJq/uKSG4kqNuzP/k0kuZc0eoJBhyFn+s+cKuJ8YwO/pVRRs
         SSFrBasnyUFYIJ9PSftK4Vua+zN5ey+EHzkdYuGDM3kNaN+YN3xitgR2x4fDiB6Jyy8g
         byleyLjhj41zPugFM+HOGJdTze/LhUDdSP5fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722540437; x=1723145237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8iCP5X47UzqYC6qlEo1ldBtwUGspd9bUTugmBKJccM=;
        b=QeqNfWS5bxPx7ShVeSrgtpeNmfDwOlhHNtcFXiKtCcunFkpWdhQ8O1pQKroR34Dlfy
         y21sU6uePqUzpdi8VVMJtOp1TiugyLDXJh3guBvZBjgwRtr0Wc9deDHYTj/uP+1reM0M
         68bicsqhvaOFsqQGgLjqIlHYNKIMiFAycZ99EK4hHbkxAQ+ZxkAHtmRynsVOvkL9p+4a
         +3Bf7WsXkCQT625kCkQAOZGsVY1zpnCNitaIFV5T5W0RWxoZKwXLcyPkgkQRmhcBsY/O
         VpdeFqqS8Kz9tqK0LgC9GPMyVqtIWWkbq3uBQUe9WMRkoufqm1GgS7HG0EbbTHEEcmXk
         agwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFW6JmWlxs7YSW7znnEJKvkajbOuCzm1TQoQKSaqE0+4PxgJssjbY+kKLmAYjysW5UVnCRa+y8E76wxxFKRw9Er7kChjWl+6e2SEAa
X-Gm-Message-State: AOJu0YzTaoAV1HIDq1qyM0uKjvklIa5XdEg/DcBFLwqwv4PwrokKD9dF
	2fKxMY+yKrggR9AayvdPatk2vwI3007/HnxeTRogxIUgQNZw6JmvRvT08wu4Fac=
X-Google-Smtp-Source: AGHT+IG+QhYotam1Zq0uZwDDVTTlIRWPmDDMs/QX6rzhcqHTGs2NgsqWN4Uu2eTVDnnUaXffRnlmYA==
X-Received: by 2002:a5e:da04:0:b0:81f:9748:7376 with SMTP id ca18e2360f4ac-81fd42b73admr90684839f.0.1722540436687;
        Thu, 01 Aug 2024 12:27:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6987e98sm78792173.29.2024.08.01.12.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 12:27:16 -0700 (PDT)
Message-ID: <a32a8cdf-b488-4b6f-a0d9-d709b9beb769@linuxfoundation.org>
Date: Thu, 1 Aug 2024 13:27:15 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add selftests/x86 entry
To: Peter Zijlstra <peterz@infradead.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel@collabora.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240610052810.1488793-1-usama.anjum@collabora.com>
 <83d0c57a-dd87-42eb-935a-e4104c17a5ed@collabora.com>
 <3518e3ef-3444-419d-94ce-331f4e7fb391@collabora.com>
 <257c9106-c33a-46c1-9761-111505309176@linuxfoundation.org>
 <20240731212325.GY40213@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240731212325.GY40213@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 15:23, Peter Zijlstra wrote:
> On Wed, Jul 31, 2024 at 12:14:16PM -0600, Shuah Khan wrote:
>> On 7/31/24 07:42, Muhammad Usama Anjum wrote:
>>> Kind reminder
>>>
>>> On 7/2/24 3:17 PM, Muhammad Usama Anjum wrote:
>>>> Kind reminder
>>
>> Top post ???
>>
>>>>
>>>> On 6/10/24 10:28 AM, Muhammad Usama Anjum wrote:
>>>>> There are no maintainers specified for tools/testing/selftests/x86.
>>>>> Shuah has mentioned [1] that the patches should go through x86 tree or
>>>>> in special cases directly to Shuah's tree after getting ack-ed from x86
>>>>> maintainers. Different people have been confused when sending patches as
>>>>> correct maintainers aren't found by get_maintainer.pl script. Fix
>>>>> this by adding entry to MAINTAINERS file.
>>>>>
>>>>> [1] https://lore.kernel.org/all/90dc0dfc-4c67-4ea1-b705-0585d6e2ec47@linuxfoundation.org
>>>>>
>>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>>> ---
>>>>>    MAINTAINERS | 1 +
>>>>>    1 file changed, 1 insertion(+)
>>>>>
>>
>> Applied to linux-kselftest next for Linux 6.12-rc1.
> 
> You are applying things for the x86 entry, without an x86 ack, srsly?

People are having problems with s86 selftests not making it to x86 lists.
I figured it will make it easier for the x86 team.

I don't have issues dropping this patch.

thanks,
-- Shuah


