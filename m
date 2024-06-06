Return-Path: <linux-kernel+bounces-205100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66148FF70D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B545B1C21841
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4981B6D1B9;
	Thu,  6 Jun 2024 21:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MfXW3Keo"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75C84AEDF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 21:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717710733; cv=none; b=Uw3SiUv9GiNymIcPKtwpnRdGfxTE54RuEMl/Re7EjMPMuYpVRxez57c4+1QvmP9Q8/y5PF7KKV33ivxtFXH0xr6yVjnP+ax6GKAMUvVVDXLzGjJyKGjiV3dgqFKhJqeCOvdnNdNxGTZGyhvIiaDrRUpPV6p1qy1webFXoqHJynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717710733; c=relaxed/simple;
	bh=1wzuCCFG6zJQG4/yIoPNBCKWEOwr1cjoHnLTYAP3xpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amfoveAdZPqAzP4yV66v6Q/4XfqMi2sEo81XPfMqrlJ0QBVZ3QtYBmJjw1U8mPmWrM6VgtEfdZoidZFtGDzHZJGBuAMrU4aiw+kEHl/Q5dufX9c9JSnhAGJbwtgiYlUSByofTiH0k2pldInsRshiV2IxQ8E9JxCI6vgsc9GPMRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MfXW3Keo; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-37489a3651eso950395ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 14:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717710730; x=1718315530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1KDsYqliGZduGqwNg2P/Pec7wrzaXiUOB9FmAhmIDXY=;
        b=MfXW3Keo4CEV8PGH8krrPFdZaRx8Btrb0YtOhnHYlREpfwOwxUkSCf5jxFapqU/I5j
         5kltEWD0/rDnBF6pn2W+f4I+1NL8bBzsfiK4JYCX/54jCtVdb0FmBT0QNCbvj2iMQRri
         oefBrURikHeGOhLYHQgZZYM5wSeELnUnuIh2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717710730; x=1718315530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1KDsYqliGZduGqwNg2P/Pec7wrzaXiUOB9FmAhmIDXY=;
        b=dwJniI30YVdu3+8B+Iw8ThfEA9NtwlryV0jEDQV+ZutpLL6jcbwcEH9DeJNyQf8X75
         /FMVWUOTsis9kZGE79d80c8Wk+g4ydzkRnDfXUKBbY+Er6i7rdPeG1Qo3+z7WC5khsdM
         4gfwBEpUk9xFjjEyR6C7nvj66Ik34rovox3iUdyNB6T6k/HIVyUnZJdXwPXffg0JAtJn
         5OVNMk/V1RJnRCNdwlN12Rl5F22f/L3ZQj9pu/TcBjTzq+vnq1UmbIWZM6CQcJ54rbDt
         ATtouj6STzaf5ORiOM25CxVsEaUhBU+hDUvK1VU65rQb4XDCJORoEAknPHtG572iz79z
         m/fA==
X-Forwarded-Encrypted: i=1; AJvYcCUsyVdm6Rz6fqFYC0wiWjenEw9eyD5O8KY3f3liP3Fs4gkrjTXmdKkVerFZDTNWjaQSFVqlp/uEB34rTxQ7kGrKxw+9wlmTtC6TYJfw
X-Gm-Message-State: AOJu0YxcBXaQSc5QEOW0asGXqbHiktqZ8kAfUItvw5L0A9AlstkdicZ5
	IAIV8Xq5xi/kAdcp7kEgGjsSAwmiZlph76lP6xIqdBbGvWOLtSh3/xc0ZC4jhFA=
X-Google-Smtp-Source: AGHT+IHFAu/m5GExcl5dKYmmFZVcJ+UraGl6QR4X2bxMouTEWbj98AEA6rlHA2Jcl97lTwB90wbSoA==
X-Received: by 2002:a05:6e02:20c5:b0:374:a102:2948 with SMTP id e9e14a558f8ab-37580391276mr10011895ab.3.1717710729892;
        Thu, 06 Jun 2024 14:52:09 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-374bc15dc9asm4891715ab.45.2024.06.06.14.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 14:52:09 -0700 (PDT)
Message-ID: <cffcd021-7a8c-4a33-b07d-f0ab21af3983@linuxfoundation.org>
Date: Thu, 6 Jun 2024 15:52:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 000/374] 6.9.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/6/24 07:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.4 release.
> There are 374 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 08 Jun 2024 13:15:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
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

