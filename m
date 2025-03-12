Return-Path: <linux-kernel+bounces-558628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9A4A5E8C7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009D6189E5CD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138561F37BC;
	Wed, 12 Mar 2025 23:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TkQOqOnR"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B521F30CC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823501; cv=none; b=g7aVL6njn+VReaYAdfUihfJQCZXmhG2hlKLN1+9mrBkjqb2IJTnopo5e0kzHfqnU/zE3gXiR0BSBPIoPKv/oIIl5vZN8DnaN9isRT/n8vFFvyB52s6zbBchPVpUBknU80SG02C7Yeh/iRZwwWKkcPDm0AnMh6GX9cjGb1wjapic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823501; c=relaxed/simple;
	bh=kz2scAfyGV/3NhQ9g5PL4QN9dT/vGyGmFmkva1NA/GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UKzJ0my81ReGR3nvC6+6At6mK3WI4fDhZpFKkyYxVQQO4I81qvGznX4i/jCrFS0bqf/1i1WikZjjcSZsjsJAEB39iCRnfIPckBB96VdmBiz/5/ZQEZ0nA2cbPj7C3RK3FzqMCvaelZdXMCWvTqO5NIxNScgWmMi0sEIks87oMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TkQOqOnR; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85b58d26336so32723339f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741823497; x=1742428297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMdILqUTCbGjpyl5slWgWBb49xQQ6Sv5T+7HBXXgjuc=;
        b=TkQOqOnRTXfKMeObLJ5hh/4W04FFXLXgXIppuDQiy51DCJAXnV3DrsKM9kdspdK8ri
         maqwPOJhPWLccR0y1WwFtehQPLsRtZwIbKh5c/uym+EfVnk3Z76l1LtYg7gmc+kwJQAE
         bEwO34OkyOP7+3WYwDTFrfHdwg3vzMjNl+bKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741823497; x=1742428297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMdILqUTCbGjpyl5slWgWBb49xQQ6Sv5T+7HBXXgjuc=;
        b=LxuFf808Qgb9PDycXHPOr6tp9Fotwx/ZlM23zmvd4bOv2ogGM/FzVpYxIUxW7h+3h5
         BLuWsXk7Pgyl4wwwLgK55JsNk6M1cg3lGfEp03Jq6jDuumRNE1/pqkAqPIBJ+oWOFBbr
         I6QlTngqNLmSDpEpQzch5tq7xteE/8Nmn+8S+npRwSQZG5b2nFM4qu4D2NYHUYPrlHeD
         ERbdYWTzchWTFo9vNKuSCwzPhwo7HFAEgqBCWiG39J8HaeNbHinnGNhIFqS+XOQiKas/
         YsaR6kgSNKlM4iIGqdHVIaBE+Qrsj8rlYa71mpSvA17xsxsXmgq69pUxlW4939jETYJF
         CP2w==
X-Forwarded-Encrypted: i=1; AJvYcCVIpGxwwJ4CufMkoIvlXwtgC0BoQOkvn09ew5kFdfi/cO+uDj8DdQJU4VngtrBRAZdcCn60i3gJYdtMsLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz64auuQrmbXyiM5IbFbI4MFKMaDLWAErxA9esrJX7QVYTuU29+
	YNhiJOpSf2Tvm51cxNmPlwJGs4sW8gVdzIFxiVCiANRzxodDLpZfyOZLYhWiOnY=
X-Gm-Gg: ASbGncs2gPjbvv0fiKHrb23BpOI4rqWegvLPMPn7XnaXKNEIo8hBZ4ITD7kvjX64Tdj
	OhyXmaEj6MGWvolPRa5l4AtuzgzVCXsuOqvbbFTIgAit1v91qdldjBfn7SYTs4aRnItqS8fQ90Y
	AlId+fJ4syUA9RCNohZvrmQBrRgFIJkKnrFIX6PRN/lLl7RamRP4s60haUtkDyALvDTp9BQDtzY
	K+2HNRYK50VHqNQiMJyf0TjWRwoOURaKdViVFPwidXaPm9TQIrq4d0U0XEgBg7ols9kPIEDx0Ih
	erYz2BK78KacNDOFthPa1Z+s0EVw9wjKpoyYIAfzB62As+rKPBOpzss=
X-Google-Smtp-Source: AGHT+IFJdEKouFDEl/CM11osjyRxzNZkSqQ0gWaQpK9UWqB6/Ss9dyGEFkXyoaOnnVpo99ZsIG4xbA==
X-Received: by 2002:a05:6e02:198e:b0:3d4:36da:19a1 with SMTP id e9e14a558f8ab-3d44193ed4fmr301815755ab.21.1741823497495;
        Wed, 12 Mar 2025 16:51:37 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a72ce54sm356225ab.51.2025.03.12.16.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 16:51:36 -0700 (PDT)
Message-ID: <5a1e11fb-4213-45f6-a5ef-636de5e175d8@linuxfoundation.org>
Date: Wed, 12 Mar 2025 17:51:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Error during --arch x86_64 kunit test run
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <0842477c-6063-40f8-8e8e-b9ce98711f80@linuxfoundation.org>
 <CABVgOSk+xztNcNJ5fQiRSGC3DKHS2H3kN1wHwAO4gCfG7cWY1Q@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSk+xztNcNJ5fQiRSGC3DKHS2H3kN1wHwAO4gCfG7cWY1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/25 16:52, David Gow wrote:
> Hi Shuah,
> 
> On Thu, 13 Mar 2025 at 05:14, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> David, Brendan, Rae,
>>
>> I am seeing the following error when I run
>>
>> ./tools/testing/kunit/kunit.py run --arch x86_64
>>
>> ERROR:root:ld:arch/x86/realmode/rm/realmode.lds:236: undefined symbol `sev_es_trampoline_start' referenced in expression
>>
>> I isolated it to dependency on CONFIG_AMD_MEM_ENCRYPT
>>
> 
> That's interesting. I recall seeing this issue briefly about a year
> ago on an internal branch, and we worked around it there by enabling
> CONFIG_AMD_MEM_ENCRYPT (which worked).
> 
> But I've been totally unable to reproduce it this morning: are you
> seeing this on any particular branch / config / environment?

linux_next - I did allmodconfig build prior to running the tests.
That means I had to run make ARCH=x86_64 mrproper before running

./tools/testing/kunit/kunit.py run --arch x86_64

I tried something different checking out a fresh
linux_next repo and running ./tools/testing/kunit/kunit.py run --arch x86_64

No errors on

./tools/testing/kunit/kunit.py run --arch x86_64

I will try this again and let you know. Can you try this as well.

- Clean linux_next and run tests
- Run tests after buidling allmodconfig and mrproper

thanks,
-- Shuah

