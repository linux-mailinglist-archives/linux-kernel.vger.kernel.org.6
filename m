Return-Path: <linux-kernel+bounces-399254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B279BFC9D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0582E282A7C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8C638382;
	Thu,  7 Nov 2024 02:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hDFvCfwJ"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A67C2E62B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730947241; cv=none; b=ENnGzd7zXSgd3N5bWLKQDIOOWZCUl+QMxVi010Rc31xB13ZWcPorf8vUxneBBkAAT6DGvAijAXetT9UPd+QmKaO2XjpUe8WBDvJJ8mqJs8+Jo7qP8h0RCK2tnF0rZtSQ9J12pX9FUXiwQCf7jHp9vCCwVWMnt1AtFOqOrmnmmlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730947241; c=relaxed/simple;
	bh=kcK7aHsP78LdSs6pNTwsnISUp0fBE7OUksiNXAiKvy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tv3/L+trrWjIPr3qfYfp31PGvKrJ0NtkQhF6o9kg0X5EMOLWWOmXQHzMRD/T1wG0zn0hhokM+cbze1c0juf6FviTAiJRFhOAPsf2O/tQpMvONzTfPdE10QLKb258R2x+6t4+1yFaFXjLDuhFesv2BiOywOrMVOFE5P6YdUXJCtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hDFvCfwJ; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-83ab21c26f1so18422239f.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 18:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730947238; x=1731552038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jVII3fPsxOIMCI+j60vE9UfnhsNmai0dOhdTYQx2JDM=;
        b=hDFvCfwJRX3OuoZP6/lzo8XiVsMuQ7Q4WM1NQ/r2GgKN7L/SIPlpJY1ecTClYhQxom
         V/7w4xPdjMfzYG/BXnyD4vAuJG5OTPgO5dOOkAp3zwAfAPSgDpYvbUbjnBkCpluAqQ+0
         L2pdwgTvayubuRxTuq7GWYiFxbV/B3g4mWt6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730947238; x=1731552038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jVII3fPsxOIMCI+j60vE9UfnhsNmai0dOhdTYQx2JDM=;
        b=OGm00YgvI1j/BVzZhg7mD8cRP9QWuY0Ln6Dr/9DGStS96TbGi/Cb/PYAbWUG6GAUSC
         ICKGyOKheZjFOmMsTWsq6HHxn8z45QfeTCf1q1KFu7uRDQaWiXe6+AJmrj/EYf9mM9lx
         vbH0iKRyswRtJOwu08e1n/PGzMbcPVsnGJUrIR38y7ANpjMqrtHf28A/J0iW1D8ZAj0/
         CANb2YTa75bZndTBgZPTqyVJA90WM7OlT6VMDK523UhDBRnuvjvGYZNy8n1/pirtJ8aZ
         jKI15nV8ThBwVww9IKv0JOxNkUkN6JbmSATVlJ0jM+tcR0HRbrW910CJGtkiIXq1LjgS
         dohg==
X-Forwarded-Encrypted: i=1; AJvYcCX92zODSofM8tXK9xX0iqpbNhTmzoGQZm5kZWRj5oQA9BbUavTP9qW5f6Uod781IOvZUFM8o/17LVbMaQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHY9Ebd74BLTg5HfLVJi41dbmv+IBbjCB2GNdCIYWmlQifhq/x
	23rmTtG5HD1ou8c52zkwokcfqbeQ+Dq6Cs4aKhKVVrRgr1PAz9CIKKxKBgsVrwU=
X-Google-Smtp-Source: AGHT+IHGZ27/oZkKkcigXB4g1bcfKe8ACte6HVgTPQgFpjO28C3gZ2EVTg6rGHjcnOSRHLoyT/kmyQ==
X-Received: by 2002:a05:6e02:1546:b0:3a6:b3bd:e92d with SMTP id e9e14a558f8ab-3a6eb1287fbmr3501735ab.12.1730947238633;
        Wed, 06 Nov 2024 18:40:38 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6eaca8c29sm776035ab.18.2024.11.06.18.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 18:40:38 -0800 (PST)
Message-ID: <390c9e9a-0f07-4153-bd35-9155a74b7d8c@linuxfoundation.org>
Date: Wed, 6 Nov 2024 19:40:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/126] 6.1.116-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241106120306.038154857@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241106120306.038154857@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 05:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.116 release.
> There are 126 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.116-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

