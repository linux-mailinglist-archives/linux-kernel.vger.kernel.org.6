Return-Path: <linux-kernel+bounces-315607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 347FD96C4E1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C622827C1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524D91E0B71;
	Wed,  4 Sep 2024 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dPKk23HU"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE5943152
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469536; cv=none; b=peiqmEZysxDGNgNH+vr33gHBlus3wqacQjHg4lwatxRZKEwKbS9Tvp9vVpibm+2hFowbP3USyaotPUQYZQ1wBDYXkp5fIQhS87JvtXt2y7IrcsIN7Km1oWOpl3h3Rn8wblp9jaybHyECT3fceQiPsHYwfO+V03W8UG1IYKjSe/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469536; c=relaxed/simple;
	bh=QAKe+7qt4mYybNsDf3FXxu1TCIJtWSy5iMh3f5PEwF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIf8ENK4butIKjR6oTMGNW6279AXAJcEMIqp054TRKY5+ljoDDsZmZUVi/gM0jeRagbPMBonP/jx4QBo8iIDO2EyF5GgX6JZsEUPrmDzXVdL2X+N3+5nH4jjax06XUyz+uv1L1BDK7Qrn5yvsQbr0vNBmdPXn9VNnMmeMNgPEkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dPKk23HU; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82a1af43502so350123539f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 10:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725469534; x=1726074334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bceotne1uLvsRqZIf8rPHT94hKmpjtLhokSoAP3cifc=;
        b=dPKk23HUCDl4Yw1x47WpdVEYSwRohggIg4tETWRVt/36d0aVPbWCoc0l6wy9Msj4PT
         86Ps3qrpCHeVTgmQSz3f4eARD73PbfVN22XbHaDN5QthWQs7zsx4rbpBsIhO1u6NubnR
         x90EryKQUhjelsYGN8ErDRBZodHBja2oftH0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725469534; x=1726074334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bceotne1uLvsRqZIf8rPHT94hKmpjtLhokSoAP3cifc=;
        b=FfwUvYHOeitM1cv9K33XLParvsZbFMD/yuU7McbMaIHXOWXN0VHw1BZBGyTF7ohWYL
         yg01pTWr2m4S1dgzR3BqPKBzorCMVm+GkxV3NhXlEKk6ac6bM/3Kb0fks+FyKnt554Dm
         EjfkcGpGh+RlzVC5tiDNbaT+seb/ck5u+TuI0j8A+EiHox0nov51pIpyLHAjxF+ZE9J4
         CCbt+GEOIVlKgOcuuZQkDK/kBU25OAWap8+4dQWQ3d66tcyp1ZyPE7RFFpAWqfTr9V/N
         GtSmRRx6F1R41kJT7tAffPNSYIB+2aybQRdGe2Nrx69negK/rvnvgzuHvZVpk7mgd4+c
         1Vzw==
X-Forwarded-Encrypted: i=1; AJvYcCUGHSiflDF1jlpJOwOq6d6F1WCVlquTVUU36pTTtnjyEqXGleJY3/MhEa0A0e6H6yoiHJDVOsWh2dI2IvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtSwUkXjMmKizPifte4iuWgNxHUzCL/qBbE9LNhztFJEJBSOlr
	VwUBqgnFY1n0Q0L8zkwNzux9bIqNxF7P8oyY8aSKZq1DbifK9zDlEmsSgZdWNDQ=
X-Google-Smtp-Source: AGHT+IFBlDWLBVcwPm5MI31E0GkeMW12h43ncRsPKNsLkCzlT4FwR8kl3r0sfRkJAS6HpWQw5BPW3Q==
X-Received: by 2002:a05:6602:140f:b0:82a:492c:9bef with SMTP id ca18e2360f4ac-82a492c9daamr1404409539f.8.1725469533726;
        Wed, 04 Sep 2024 10:05:33 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2dcddb4sm3256864173.24.2024.09.04.10.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 10:05:33 -0700 (PDT)
Message-ID: <d5dc1bd9-4473-405f-99fc-192691f41c4f@linuxfoundation.org>
Date: Wed, 4 Sep 2024 11:05:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] selftests: Rename sigaltstack to generic signal
To: Dev Jain <dev.jain@arm.com>, shuah@kernel.org, oleg@redhat.com
Cc: mingo@kernel.org, tglx@linutronix.de, mark.rutland@arm.com,
 ryan.roberts@arm.com, broonie@kernel.org, suzuki.poulose@arm.com,
 Anshuman.Khandual@arm.com, DeepakKumar.Mishra@arm.com,
 aneesh.kumar@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, sj@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240822121415.3589190-1-dev.jain@arm.com>
 <20240822121415.3589190-2-dev.jain@arm.com>
 <714f8eb4-b226-48f6-ab0d-75bdfbf83364@linuxfoundation.org>
 <42d0fa4b-eb67-42fd-a8e1-05d159d0d52f@arm.com>
 <806e4be0-4b1f-4818-806f-a844d952d54e@arm.com>
 <fff2b685-a7a5-4260-a293-f2abf55d9ce4@linuxfoundation.org>
 <514713eb-235c-40ee-8c25-f1f3e1ca7f7a@arm.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <514713eb-235c-40ee-8c25-f1f3e1ca7f7a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 22:52, Dev Jain wrote:
> 
> On 9/4/24 03:14, Shuah Khan wrote:
>> On 8/30/24 10:29, Dev Jain wrote:
>>>
>>> On 8/27/24 17:16, Dev Jain wrote:
>>>>
>>>> On 8/27/24 17:14, Shuah Khan wrote:
>>>>> On 8/22/24 06:14, Dev Jain wrote:
>>>>>> Rename sigaltstack to generic signal directory, to allow adding more
>>>>>> signal tests in the future.
>>>>>
>>>>> Sorry - I think I mentioned I don't like this test renamed. Why are you sending
>>>>> this rename still included in the patch series?
>>>>
>>>> I am not renaming the test, just the directory. The directory name
>>>> is changed to signal, and I have retained the name of the test -
>>>> sas.c.
>>>
>>> Gentle ping: I guess there was a misunderstanding; in v5, I was
>>> also changing the name of the test, to which you objected, and
>>> I agreed. But, we need to change the name of the directory since
>>> the new test has no relation to the current directory name,
>>> "sigaltstack". The patch description explains that the directory
>>> should be generically named.
>>>
>>
>> Right. You are no longer changing the test name. You are still
>> changing the directory name. The problem I mentioned stays the
>> same. Any fixes to the existing tests in this directory can no
>> longer auto applied to stables releases.
> 
> I understand your point, but commit baa489fabd01 (selftests/vm: rename
> selftests/vm to selftests/mm) is also present. That was a lot bigger change;
> sigaltstack contains just one test currently, whose fixes possibly would have
> to be backported, so I guess it should not be that much of a big problem?
> 
>>

So who does the backports whenevenr something changes? You are adding
work where as the automated process would just work without this
change. It doesn't matter if there is another test that changed
the name.

>> Other than the desire to rename the directory to generic, what
>> other value does this change bring?
> 
> Do you have an alternative suggestion as to where I should put my new test then;
> I do not see what is the value of creating another directory to just include
> my test. This will unnecessarily clutter the selftests/ directory with
> directories containing single tests. And, putting this in "sigaltstack" is just
> wrong since this test has no relation with sigaltstack.
> 

If this new test has no relation to sigaltstack, then why are you changing
and renaming the sigaltstack directory? Adding a new directory is much better
than going down a path that is more confusing and adding backport overhead.

Two options:
-- Add a new directory or add a note and keep it under sigaltstack
-- Do you foresee this new growing?

thanks,
-- Shuah



