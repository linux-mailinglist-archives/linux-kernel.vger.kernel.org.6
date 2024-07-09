Return-Path: <linux-kernel+bounces-246779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E7A92C692
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D7E283C7B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55187189F24;
	Tue,  9 Jul 2024 23:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C5TJEY3x"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A973187541
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 23:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720567669; cv=none; b=T78Bn8peA8c2FwVeLZRYhi8lZRF+EeidncowP4KjFhlE06d9IW4qAGA22uFBD+bmJ0QfR9ROuXRzlMStnbaFTvOFVL6+2eVYFcEymedonwpHaI1p1sl4liXCUlTjwjowEUezxdX3ih5VKsfIeBS0hnXXKPXWyabk2O+ZTk9W4ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720567669; c=relaxed/simple;
	bh=bN308Ak1eVxN7liymrO8Kbq04EbBFuYqeAxmu4CZUMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p85IbUgGj+Md4CSj57JFLsSBQOxE8EFqvQuBwzH3/9iLcRhNlUeEJCBjKIehA0JBqNGVBiVcbgJh9Eqs3dD6LyQMJa1XhS/THoRXERRWVb02ZnK37EBu+rqojBfKjM90h5NA12YFJ4rcp2EV2XBJI8/noA3Q1D87mNfJbJrxgis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C5TJEY3x; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8045e14c32bso1066839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 16:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720567667; x=1721172467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hN+zGtG+lpLqh3rj/LWNJow6My9CNxUakZsm7WJINo0=;
        b=C5TJEY3xCprMBb04qZGB/wjQKGOaeA32uEa/k8xIbqRRbqHy7cVOHNemgE/O28xq3I
         rGhzkloQibEOXkawJMiYwiWI6BjZ5OAGEIEogBN/K76palmewZZQ5hhbsCdfl0IGu+wq
         V3XtEE0yicXzhM0MTrryo1bT9zrc4VcFlsDrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720567667; x=1721172467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hN+zGtG+lpLqh3rj/LWNJow6My9CNxUakZsm7WJINo0=;
        b=V4yCXsPc9iw5peIydKqCTY4Mv+YLtdGY1SCUEbXFYrnV2nUTb5plv+QLo+T1CQzGQW
         7TwnH3BhdvjpLWxtlVH60nhzshkPF+4b5gDEJg9DVHmX4TazcI1JoaFf9Vd1U6qKATkc
         MLT05buFCkR3L97/uVMKao6sHwl7FvKeGabOFvxko38JEDutS/q0EIqZ3MAARZo2Xfhe
         GU0i2fJBdasjIvpURcqp4NncX+M9RkJhVkeJHfted5gwCDc/qYg2ZRdh65SoqrCzGfWk
         iFcKzl1jiEoRtm3hEXC4vG3qE9QsShcBDXG4HNlJYIUX+t6HCWOymjUbVV5wMIOiBLB3
         22cg==
X-Forwarded-Encrypted: i=1; AJvYcCXRMYDlzgjdqaUg0dMWdzokMolWdrEemMIbjMm9DDMrCQBGv83i+b9HvATcmoRIWa3dYAdkOK2oESTJaQ3RiFmB13+nrV0lz8IadNtl
X-Gm-Message-State: AOJu0Yy7l76T9h6ftKarJZafoPd77WgOx3mUUiNm0Xq1K+P32rKWwDvK
	vuT8E0drueKqN/6ASGQ0A9JoLhgqwhpyuIEyYwIaYGu8Q0keIVRk1fNZt/0Q6OE=
X-Google-Smtp-Source: AGHT+IHN7zvMXlKF0MCYNFxz8pUQtRkWZuf5jDM2utPMsy5yxujxjODTSAh6OLbkAjkKw5pW4HhEaA==
X-Received: by 2002:a05:6602:3413:b0:7f9:90c5:4107 with SMTP id ca18e2360f4ac-800023b5fdcmr526987939f.1.1720567667085;
        Tue, 09 Jul 2024 16:27:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1bf80d7sm742754173.117.2024.07.09.16.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 16:27:46 -0700 (PDT)
Message-ID: <152abde6-1c03-44e9-b793-5a1275361287@linuxfoundation.org>
Date: Tue, 9 Jul 2024 17:27:45 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/102] 6.1.98-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240709110651.353707001@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240709110651.353707001@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 05:09, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.98 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Jul 2024 11:06:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.98-rc1.gz
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

