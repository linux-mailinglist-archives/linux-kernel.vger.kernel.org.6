Return-Path: <linux-kernel+bounces-261165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D219693B380
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA481F22493
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAE615B54C;
	Wed, 24 Jul 2024 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dG3GE7Ql"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF97383AB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834422; cv=none; b=tSWP5fy6vmQLY10gdkFKdLavAWNnza4kHMJ0b1MWWxnWTwRw9TUORxh/p4+AsHaNCItKjIPa/YVjmfC6Lfq4WFUDh+5iYlPc60wmRZB5ijXc8bOq3G62ckT5iSZEWd6TFYu4gHblSDRrI9Yf4rWbSEHL7zkr3ZRYA5Vme+xxv4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834422; c=relaxed/simple;
	bh=hOiV8755ngc0sIs6g41+2/lS4DWadZVscPT7P0F62i0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4d/iBQSWfs42l2zZQFozwjRem6wfxDNH+avUv4bhQAbwls/hRu0U080jqGm+A7AJaObqRf3D44qXU25mr+JnnQ01r9MDc/Cthl58lmR3i1MLz9RiMtd6xAVeRUkYBDbt4UZZaZK+SP8C5GA0d3kVzPPkSL2BVXJ3gIR28bSpzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dG3GE7Ql; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7fb3529622dso38973539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721834420; x=1722439220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82dy9mZKo2zcgFYmuz7GnMY2lJ2OItmiPUYNnGgMWCU=;
        b=dG3GE7QlVuEd5GiRPfZdKcRZfX5MpSRk11Ze7azF6aCpiuMITFktuKSDcTgT9yVad4
         uQqSb4p6nZaV2rryJ2ec5gUhivfiKc/Q4ayKvmj+oCTSF4Uv351LcbhS9zM63LBQTa0t
         iSFNxq/8sTFg+B4t747PCB6kq/TSIqfzp/WDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721834420; x=1722439220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82dy9mZKo2zcgFYmuz7GnMY2lJ2OItmiPUYNnGgMWCU=;
        b=k75leJh8efPQ13CIa/BLRtf0lF+nLxD0LRY5j1X0BIGxOkFH0G3ljqLUWFQ1Sqt9hK
         IExwLSC29BJ6Xw40pcoMJV15AexAoYmIDivKBUO/m6EmB74GJxphlzon/noIaSOZiq0p
         cTtkpF/Tc5g+NyO/PpENbfqtlaa0fmkiAHsQP6f2j4nqPtVnDdME/vHbW9QBn2wf0Oz1
         vsXuZHAO+OrN7U7MG+1Y4NK0RpUEzkMuUviHGB+8+W0eaBtvYX99CYvXrRJnzEwwkJnd
         U+gmhuzqaoMqafd1fOrIBTBzXtb/KxxmG36BmnIB6TDYR6R0XuRkU3qcgBjXofLX4/In
         cCXg==
X-Forwarded-Encrypted: i=1; AJvYcCVEn0jgED7KMmB654YxLCgGEntZzyJjyh9AnMW5Z/wLB1LJpq+FiE65SefbWTF1cTzN4J5jKPT1rl6eTeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTscUrLBfnUAEChNtvMbk8YZuj9AmbKoI26t+spMTGs7z9o8jm
	Dt5zyg/fWXpQW4VijSveQlVEMC7tSfffc4CvYHtSALZgChqaCRDYOHB0ICDXygg=
X-Google-Smtp-Source: AGHT+IFlqZ25PE52Kwlz1STx1vDkygQoeHCGfiy+yguaY9+XTj2Eb/g0CwlJmwsN+B8v0pn4jmldEg==
X-Received: by 2002:a5d:9396:0:b0:7f9:444e:4918 with SMTP id ca18e2360f4ac-81f7be6a8f2mr11152539f.2.1721834419757;
        Wed, 24 Jul 2024 08:20:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81f715eeb73sm53776039f.38.2024.07.24.08.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 08:20:19 -0700 (PDT)
Message-ID: <35b1fe1b-d062-4fce-9b9f-a74c84466f00@linuxfoundation.org>
Date: Wed, 24 Jul 2024 09:20:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/129] 6.6.42-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240723180404.759900207@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240723180404.759900207@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/24 12:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.42 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jul 2024 18:03:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.42-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

