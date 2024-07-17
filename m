Return-Path: <linux-kernel+bounces-255384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2339934014
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BD90B21EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E92718133B;
	Wed, 17 Jul 2024 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JMKb9+E4"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC0D17F393
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231879; cv=none; b=DKl6LMYARuK88Nsm2ojlt3Slj+ONRtuoVNs3l/laoWnGMJKxb6cuo61tUGNG9mIDS3LTpgowiY1eQt0hc0UVRtkjg70BJ74A8jevYheggxKAetQ0aBzgvwop/xvcn4tzrYgCsUlYKJyXCuFgSL0V58slkluhZ2oQYO3PtbAvchI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231879; c=relaxed/simple;
	bh=yEDShaU33yVXfWVbkz3WINqO2ujZDBlOOhoSKKzNAfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXWNIXFpc+P/8ij8GWE54EreiLTIM4UnoVpipSoUsuCs2vFzXU/DfqGflEVSt5CqCLtvJexDu3I7RST1uTNVXNEawAO4/ShIBGrCHVeB/Dh5UwZhMMq0JdmymkkHpcNAvxIh2zkAkzW/vwPvaDryGHc+/lK8vCJtkz3fWgBoZX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JMKb9+E4; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-389dca7bcacso610715ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721231875; x=1721836675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hUZhzpQoP/EpenvVywEbKuumx0D3/HwN7bh1DfuNzEQ=;
        b=JMKb9+E4+jdp6+aAfYFPivNAL+mawodPwr1qEXwPi0OXX7aELQUqFtEcItOChqwkNz
         FTTu+ZjERe6kJP02vhx2V6YbNEh4A4q6NmZXEmt8i0VWzWuj76P52t04ii9+4VNLluVj
         uV45xsBSbIv7TzZEdDKzoWVEysyvVPzH4c3gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721231875; x=1721836675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUZhzpQoP/EpenvVywEbKuumx0D3/HwN7bh1DfuNzEQ=;
        b=PRTaUSauaERXMHq6XkkH+LmpgnN6IzGcIKcPhDjmz6Ob26zp0RuvoKdt3gReJkQxX6
         HG85wMcxLzNTVpW3hoD3xutgXmv0xg7A/UkHktloq/fQwWDcKokZsV97FeduRNwCGP/r
         KnILIU6btshr8ZtUNQt90xxrUSAO6g0YIpU9hMYxXIhuGsRAlfnuN8kVHQzAoLfQUWU8
         grYlHfbwGI/kvwtkl6nx3faCZS0yU6iZwrbaZtM91F2HUtdN1yRH8ompVM+5hPiKr6Di
         s78GbWrpb+nPBF7Qy+z93qpTySGHL8k1N+vbtiEF2Y84Lk6pW5a3ninR96RVHMw+0qtv
         deJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDe1Dok0kO+pfeGFULSFiA8WOyrkJOCJ3AyQlV/6miVFikzQwnFtW3gU2RESFoobzmiP1w3XDCuphN2MxkKt+iJyN6m2fxqS7+T+Ad
X-Gm-Message-State: AOJu0YzRVI8fzXSVrDYv7RinwPyQa8riXSDdnqZOyQ6ugkd3Fgu6G9Gv
	tLjOSLAELPI2oP86b+YJpLthM2tZqKszIiDtEPQIJVdi2vvLQ1Gs9LySSgWxc9A=
X-Google-Smtp-Source: AGHT+IGfKcUu7NqZz/2YIoRFXDETVLn01TPyAgMyhSeV+4aYuxcyraE1hyGbvp3rovCi+c5AXMIfcw==
X-Received: by 2002:a6b:6302:0:b0:7f9:3fd9:cbb with SMTP id ca18e2360f4ac-8171022db8fmr142626739f.1.1721231875485;
        Wed, 17 Jul 2024 08:57:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c210c2db85sm766984173.38.2024.07.17.08.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 08:57:54 -0700 (PDT)
Message-ID: <67db8d9c-c7a6-46ba-996f-5fc06888fd05@linuxfoundation.org>
Date: Wed, 17 Jul 2024 09:57:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/66] 4.19.318-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240716152738.161055634@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240716152738.161055634@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 09:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.318 release.
> There are 66 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.318-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

