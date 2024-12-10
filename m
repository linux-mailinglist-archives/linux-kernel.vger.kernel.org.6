Return-Path: <linux-kernel+bounces-440007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5049EB771
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99DF02823F6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93537233D81;
	Tue, 10 Dec 2024 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fbNc3w+K"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E392343DD
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850535; cv=none; b=qIKG4ZW9MJkIWRmcclEn8Fs+/A27bUHcnZ62p32KCuBTlM3sGJ5tYKBtL4FJx4j6GldN83jk5wh8W7+fUQ0iZP9Oup0Tw3CvdUZwTheCr4gBo2reNoYVYIcyYxCorjqQWrGmh64/Ock6gdHBp8tL/wO2kxmtZdhIusXqtZAxbTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850535; c=relaxed/simple;
	bh=vqnBy2TUzl5VEh6Ll+x+Xk8e1C2DbaIVDVhMQuQ/vzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnIehm5sRRHPHMorTzOCxGOg92UqGJphnr2giowLEL+WuesxEUQp9UbtEzU2BDVKiWDyZLUw63qnOQMRqW5DhubQhATzXvKkM/QUJn2ZXEfvHHvKcMfz7aYnR0FGrIKjGWcu6guEfb7eBSxxGh0JyeHAquZZh5qsvLX03/tZjdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fbNc3w+K; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a9cee9d741so18341455ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733850532; x=1734455332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B5PJ17q8lD7k4hVY6ctGVVWNwOwWO51bb5PDCcKGo6o=;
        b=fbNc3w+Km/yqjUHcR4q0Yw23p971vs1gYm7T0EeLW8sDF0dExjAKQqp4P7N6RbF01X
         XdNolJsaUKonfeSuqix2Vl9Ffb8nBSyISOmNcIQp0lggxp/U+YnhJXLhOacxHg8yxMX1
         kikdLbqsPLEbWlgxEapR2IW52icNC9GE1/oUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850532; x=1734455332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5PJ17q8lD7k4hVY6ctGVVWNwOwWO51bb5PDCcKGo6o=;
        b=kklIfofS86VS0vmhbeQ8ynl61yEebm04LqArSlAd0l74klojGa+LtCBsgLft3r8yKy
         hWTmWBte/V6QaUpq9ywir+7Q4sxvb01M4IGT7N0zAPserZw/Ir7m+asKnBJd69BV4UXR
         t8BIli14pUAFupuKUcmJJZ9Ay86ENc/r/ywQlkn9SzFM1Zqozly/wzKEEw4zSK+80C9Y
         Ta3ocmcCip2S6L1nuk/NwaGq1DbYhOxb9WOpXUlvsfsM8bJuYu/AFhixnFIbj3h7Vytf
         3sIC54w0kSCzdOo81HOdAqGphwZIYrtQ2dzp7L6BDeLlgrQI3EU5NK/BYcuzOH+8vaao
         qSbA==
X-Forwarded-Encrypted: i=1; AJvYcCUk1wUAfc/16SgNBRARqZwfK47v/r/kGl78VYFUxU/g6pB7PsGD21aLxQ891Zhrl7v9qeVw+KeN5GcQqPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1A3vsJvH7aI2BYVPNdhJOZupr/+cTmUjvamfAQ1Gwfa/lj2M4
	nepEaHJjNjcMSWn6MtNxQXG9545wODRZwn5rSRMMvuR+rUu03nY5zFdH1Ky07FY=
X-Gm-Gg: ASbGncvOo6A8d8DoFg/XdwCLSsjRFWu5EjPt1OTBTMaAgLPrKkxwz/nlReLE7b4b/l9
	iaDHaKnJxz5tsWatnlZGAEKUy8mTNJsRvwM/WSFzMOT9BNDRtNTxgyJYTNzV3lbG7VKXVflG7uN
	JEYSUDsfkuwPS68gg4gI4RwG5yI23DT52rYig7TWBKfRPKak8S2QY6zC/7AddzpCzTRmlOGvxiO
	wxVCj3XHwJIUVL1J4eAbJX0ISk04itha/4WF08l2iN45mfba5mlADGVdQf110txdQ==
X-Google-Smtp-Source: AGHT+IG/gkZmbkJxGMdHnI+Js79ydu8p5QIVfUBfMDkz2ZNcb9kT6//CIdURU7BGEZClLOWq6Kg11w==
X-Received: by 2002:a05:6e02:1c8f:b0:3a7:dfe4:bd33 with SMTP id e9e14a558f8ab-3a811d98e10mr213572065ab.6.1733850532088;
        Tue, 10 Dec 2024 09:08:52 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2ca310cfbsm701831173.152.2024.12.10.09.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 09:08:51 -0800 (PST)
Message-ID: <1e61303f-69b7-47e1-863f-1d52ac6c3ec7@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:08:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3] selftests/cpufreq: gitignore output files and
 clean them in make clean
To: Viresh Kumar <viresh.kumar@linaro.org>, Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241122074757.1583002-1-lizhijian@fujitsu.com>
 <20241122081304.j2zbjvmgd2nnfca3@vireshk-i7>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241122081304.j2zbjvmgd2nnfca3@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/24 01:13, Viresh Kumar wrote:
> On 22-11-24, 15:47, Li Zhijian wrote:
>> After `make run_tests`, the git status complains:
>> Untracked files:
>>      (use "git add <file>..." to include in what will be committed)
>>          cpufreq/cpufreq_selftest.dmesg_cpufreq.txt
>>          cpufreq/cpufreq_selftest.dmesg_full.txt
>>          cpufreq/cpufreq_selftest.txt
>>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Applied to

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower
for next pull request to Rafael.

thanks,
-- Shuah

