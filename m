Return-Path: <linux-kernel+bounces-246790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B56E92C6B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5A91C21F23
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA90189F40;
	Tue,  9 Jul 2024 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DGa7kQWO"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B330618562C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 23:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568398; cv=none; b=sx9FUtG3N6l7Xf35wItQyqB4rsiIZnzBhH7Qo73GXCP7Qh/o4rNmzfti2rLmLYl5xZQQvDcHuymYQaKbtYYkWdbwKK7Sn4Z0uinI+S2vo5kM5/0tgUJlf8TF1FhP657jRU3y34sq/+61iw8YRWikiP7eHhFwsaG1JvS2LW/7u4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568398; c=relaxed/simple;
	bh=xoYWGcz96RHvOP5RMCIKUt/z0q5VtjNbJQcwewVakP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMIM0DfyyyqZL/QowDG4qy40Cf5q0ImKZ07UFJ1DSxSufqHG/AE1nQAFMjEEeSGdPu8UTKIe+w+3dfz95/OVLrYF/ge5nGNRYHexzrZwSuVKwMZNx9jeaHBbAxcj4wzXXo4lZN07Lajs9OfoGFpceuBVmU3g8Pe8AQqeYgsEEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DGa7kQWO; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7f94c2178e5so13509739f.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 16:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720568396; x=1721173196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7wZJcxOUMzqnMjEFIAKREA8lwePmg9X2G0N/hJmIdK4=;
        b=DGa7kQWO46elYeTVvToRXV1Fg/seMbDlLy2mC5XTyAgpiaY4RKlGxmzy3sO0VNGpr4
         9JmsoQKLIsZSRjsHpfBd6YdCSEBAkNpIcWayhcq/my7kq2kJ0Qb1UsUTzMhvQlSt5hqz
         SDTOiDxkfXRDdBBgxbcVF8EzLKh30Udo11Muo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720568396; x=1721173196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wZJcxOUMzqnMjEFIAKREA8lwePmg9X2G0N/hJmIdK4=;
        b=kPDwE6AbBvHXvaodHtpYsT7prYES7KVuzYfNj9KZmjnDky/kz7Q1RPLHeQeroWSnJS
         HV0MzGrSJTx/1LTKKGyy219EhTXxhlSKnQHSI4Y3aSvCfYbtuvpDFcD/1ZAcsycXu0jH
         BhLhercd6m8POuGQIFX0vkO9Tz0KTlX5AIvIvE6ZvqLTPrRBC/TdfDb6C4FPEafVaLBN
         YNtHKYCkkBg+jNBHyPiekNYCJN2BFXsuhcMu6PngSS/PxZ1tPmZ5XwVq+QHU+n22UjZT
         r15hMnO1yDyru/s5GyaF1J31+Jq6YAN5r/10GuPAWH+Jzg5xQsMhIFzLomxA8Ye2gKjj
         ePog==
X-Forwarded-Encrypted: i=1; AJvYcCVyaRvHOy1We2wStL5YKrbPr14WHwDr3manIEdXbRdQdk8S72jHxso+FQG4Iao1nGehLgYAcIHepF0svbwDGgiMSUZL7Z9QfcR0k+a4
X-Gm-Message-State: AOJu0YzfXM4Lwumx12aO/6zGh1dvBzJwrUtdJGVibM7FEuzXn3USawzc
	/pa8f6vQcZjISBydh3Bzqxe0QJvIqToIezhjY0zH6n/1yrR/BtiE3kQg9env2ic=
X-Google-Smtp-Source: AGHT+IEuCuhYJkAvAQQcqS5jynk6i+qDZXnB+nhM8B70PkkseKAaNX6qU33nF7oZrixRnw8aPfQ1ng==
X-Received: by 2002:a05:6602:160f:b0:7f9:444e:4918 with SMTP id ca18e2360f4ac-80003120d96mr488234339f.2.1720568395838;
        Tue, 09 Jul 2024 16:39:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1af8229sm767555173.7.2024.07.09.16.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 16:39:55 -0700 (PDT)
Message-ID: <fb305513-580a-4bac-a078-fe0170a6ffa2@linuxfoundation.org>
Date: Tue, 9 Jul 2024 17:39:54 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] selftest: x86: conform tests to TAP format output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240414131807.2253344-1-usama.anjum@collabora.com>
 <dd277b6b-b28e-4860-b285-e89fd5fd3d41@collabora.com>
 <90dc0dfc-4c67-4ea1-b705-0585d6e2ec47@linuxfoundation.org>
 <386da8e3-1559-4ec2-9a66-f5f3f6405a2b@collabora.com>
 <23db41bb-1f3b-4b7b-95ac-960b8775a062@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <23db41bb-1f3b-4b7b-95ac-960b8775a062@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 04:17, Muhammad Usama Anjum wrote:
> On 6/10/24 10:19 AM, Muhammad Usama Anjum wrote:
>> Adding Borislav, Dave and x86 mailing list:
>> 	Please review the series.
> Kind reminder
> 

Usama,

As I mentioned another TAP conversion patch from you  patch if the
following command gives you TAP, there is  no need to convert.

make -C tools/testing/tmp2 run_tests
make kselftest TARGETS=tmp2

kselftest framework lib.mk and runtests wrappers take care for
TAP. The reason to take care of this at framework level is to
avoid changes to individual tests. The wrapper keys off of
KSFT_* codes returned from tests.

Please don't send TAP conversion patches like this one. The output
from the commands will have duplicate messages. The reason tests
return

make -C tools/testing/tmp2 run_tests
make kselftest TARGETS=tmp2

thanks,
-- Shuah

