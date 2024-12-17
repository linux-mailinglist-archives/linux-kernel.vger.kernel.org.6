Return-Path: <linux-kernel+bounces-450045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 413A19F5A0F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2024 00:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3491891517
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 23:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7991F8ACD;
	Tue, 17 Dec 2024 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Chz1vVX7"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CE113B792
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 23:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476616; cv=none; b=Dknd/fcStdOV6TsFOeLtLw7H0xAEuxyKZDyjkCGmM4F8Omr8ZRnaImXhmpQdYYXBGYziz7JPQj3ywMXRZVXdobjJhIbiSEKw5gRex17hLPh8gm/hVAVpJ3oln9Amw5UnnO7dN/xXyXqQJ518n8THQWvpiDUT1P2axQAUhleBodg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476616; c=relaxed/simple;
	bh=LsZ1ZAGFzhLCkUumArMICoun06GecZ1j6+dij9s2dZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3iSpODqHLP0FQULphnpZ4amBXL4iyaIG9SRoDSSPpNLxlaCGW+hxR9P1+99Zxxi5YuaRWJCJNW2Q0ZWWKFM2NR52R+5RcK4Pb3QvbX0uWZAvlz3DWF5bnXFJG4GQHvasJK/fKtnED19Q+CwTw7oku8lWQhDCiQjOBG5I7Gd/Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Chz1vVX7; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-844dfe4b136so185752239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 15:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734476613; x=1735081413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0mtT107iSHWzSANuPu2CjAzaWYVw9mVugeiQeIiH7w=;
        b=Chz1vVX7Ev0fXBi51fHdB4aso1bHcXO234bdGkNioccXoe8siMSGpQGUgIFlmsgiuE
         vAE9R89i5gvTSAbW9Lan8btF3g6SlTvGYUw6MhdvJQign3oGnTcevembfBg9w+8eLyYk
         zWlBtwtVmZguraCkz98R5qkIaIfdEYP/UN8lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734476613; x=1735081413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0mtT107iSHWzSANuPu2CjAzaWYVw9mVugeiQeIiH7w=;
        b=WtOZ/NRZfXrIWzTAjJcjP/IwrewlAssNLd1f2x//1MxOaN7kHYdZjUCZ948A3APTaE
         zZpaH6DXuYhcgw2Tbm6ZxQiCt0ZeiuCV4cNCduwq3/t5W60GziJ7vwBhKrICngHxcCvu
         8snxLM7suw4o7z4eOOFws4D6E9n995ode9BmJvn+isNIXKAKZ6O0LqBOp5BJSQ2qaMMA
         KrkAz1CZA4hw4qAL9JtSr+hZEknrSIwPpzzI3hZacbX6khaxej65pcIfyiwNdHeT/i4n
         Uv4Ql+lGSZuUb1y08UWVcpI00A27dMXCpjWGNH4V6WmSuxSNGB9y++27pV580vfsDOV3
         3VpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWG65EDV4GpYkNVZF0cA8QLJrDsOCSseJvo++WPCjH1ClmxXlbY0oAhe0EfDFEh22Hpl0o205hkSkpPiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhi3SFBqv1O5tfeWN6rnNP8eGNZEcg93QlgNsM8M8yroxq4y/j
	7EIahDlI97mQqHB0eJo+6ZZzwxw+QRPJOrLQXeiUsheJlQS/+Eo/uaXkbZPl6P8=
X-Gm-Gg: ASbGncuk4K5Gw2ZMkOaoDNFlkQocbHRTLmyYjI3O25kdOmC2LdguEB+hucsLKbtrIzk
	lX0plZk2+G8QbsCu0o+VR4RZL84Tl+enO2iNOcL4SpHNduJlugMwIcKf+kYM344wbJYGKFFC4o0
	OEQBb9S1J9Jg06/z5lUaHESpWWJDpJRYB9wjmqWlhMrp5+jnisFTKxUAwziApT+U+wMyTLk87Vu
	AkngaZcfKoYv2DEKiPj+pOji5EjxvsFtp+gUW/SHjiiWReWqOVw2q+9cohLxkyLP43F
X-Google-Smtp-Source: AGHT+IFbiQG2jydmVYuqIJ9wUCpDmlOF6LOcO1cH5JFWnd6a/BVjSfS+sjBumA2syMJeOaIemZj88Q==
X-Received: by 2002:a05:6602:15cd:b0:844:bd90:d45c with SMTP id ca18e2360f4ac-847586073dbmr57522239f.13.1734476613537;
        Tue, 17 Dec 2024 15:03:33 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e378242asm1909129173.128.2024.12.17.15.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 15:03:33 -0800 (PST)
Message-ID: <607d68ea-7af8-4350-b3d4-d4ef1341dfe4@linuxfoundation.org>
Date: Tue, 17 Dec 2024 16:03:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/76] 6.1.121-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241217170526.232803729@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241217170526.232803729@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 10:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.121 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Dec 2024 17:05:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.121-rc1.gz
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

