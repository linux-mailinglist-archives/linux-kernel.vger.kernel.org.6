Return-Path: <linux-kernel+bounces-557109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D60A5D3C8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 177867AA3BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A1C80034;
	Wed, 12 Mar 2025 01:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aSsXgzvX"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430638BEE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 01:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741741281; cv=none; b=owqLrz+f3yeB39y3qCEe077xJlel5OX4V9FbsNryVtWnitPYhn1rK35jnYAr/BHfO9WugysTXFuEFxqcoeY5eKFKmooMQ+gTsGYbrYBMA+BKNfUnfCKHyL2DyHn2gajNXCbnDeMhritIuJpCPDoQryXgNbABVDlFWp2oBSd78rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741741281; c=relaxed/simple;
	bh=pqTs6PSez0/L6cWDvEZMc3ndJbwA7vVw//pZkJYuDZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4JUtzvCLBaKt1sOfWRSX41LgwzJNC5kL3mf2hdT08TloTzPrsH5qufo6VWn2337dkkKD0s1jp4ETOrMHqJOyaQkCjnh4848LjCjgr3Dq/xnpqCMhZLVbhQqfX0SbpAX38LYQjrT7iqBcPdjwWAhtVB/69Gr406W+v1K60aVnZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aSsXgzvX; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d43c972616so1447605ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741741278; x=1742346078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JkhqhD/I8qtsdXa25766C/WcZA5mOA1TQObYPvGOQ1U=;
        b=aSsXgzvXL0ao9yvhi6fc7zaEcaxiRT/gBCCSvJPFqExOXK/THL0q/hj/s6ENGHJOW4
         A1vDMOyAcIqDXizr/iIo9/uW3Xom+Cr6rT4xOcVPtd/spqnOL3qB+t4uQ/tyo/T5vLZo
         pNDRt2OhHrkHY5rbB4VRCdm+8wzXaC94DQhXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741741278; x=1742346078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JkhqhD/I8qtsdXa25766C/WcZA5mOA1TQObYPvGOQ1U=;
        b=DPcPFkCV59E9tkzysRNEMcYMzb8mP2OHw+7icaTJ1DcMLrJ8+uDMYzFstprBZeGuhU
         jjOO3VijI/YvyVuaoiREgwMZvY6Sea6G7cMBOOxgy2POtIulVgpcTVLSccKdjrXPBh5W
         NI4DoFE636it+IXCUWwhKYA/jtfPsuF0+eYHb7O+7xvogSCrwXIoPAaPcO9CEscC9seL
         eiuL2Rd+/BoFXlikpofBvlGqH76VrZAVzEs18ttfIOj0wg/FsJP6qR6gvz3k+rtstrNf
         sWK6fPDb92WJ7ANMuB4DsT/sZ5/zX4kO+ecUE6245a8HbXm3iC8nhYf9IXYTWh4eyo3N
         ZxhA==
X-Forwarded-Encrypted: i=1; AJvYcCXVMvt5jlmYrHMIIpW0x2bdex0I6mNRBZhue0xEmglf0/oBncEtZ1+/kekD9I2bLJs1UyL4B7jKnk3KEVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfqqqsBUHwC1ePQDF2OBvd8iJRLj2PLNwNQaSu2lK8iDmycNsJ
	wLXodRvfjtVJ2iTIlSGsyJG3n1OG3mEcdqLStHOzj+es4TFcPlEI0hsbN7VE16k=
X-Gm-Gg: ASbGncveYFJ8ioF4iQ0n8neNDL0+U53AKINY3VTfxSmnfjiGa+QIkSEn8gdRziWdcvX
	gMcGYbgFnXsTYblzXThM0r8rhedg8eDm6SkbyCdKW0kwk5V1o+yLE5GVDju6HYgnIWfN6GQYyvB
	+rvKY2OmHlZsAheFkheWs3Ez25jL653FH4bYqq940OVlCsyPho7nxLrFY0uaUkwz/rimMxwY7/F
	8LzXFehGHvxfXQL2XIMd6de0B0oFXIYoxVEP/qeK7olaZEvJFGShdeSxRell+BNCqml65PSd2SE
	XXjNnDMZx8dDbpgsWYhIUPMuPKLvO9ITnzmya/TVjnUVvGCvNvEWW9G++2sCXt5JCg==
X-Google-Smtp-Source: AGHT+IFwl/yS9RjSTW02QbwqxgrQUdpwIRAbglibdgwGcM7oscbPj55DnQ4Alu/un3yCdOV/hEuAjg==
X-Received: by 2002:a05:6e02:3683:b0:3d1:84ad:165e with SMTP id e9e14a558f8ab-3d4691c7983mr57874765ab.7.1741741278248;
        Tue, 11 Mar 2025 18:01:18 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f209df4c5fsm3045120173.1.2025.03.11.18.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 18:01:17 -0700 (PDT)
Message-ID: <bd63889b-7b7a-40f2-9236-3dc974221723@linuxfoundation.org>
Date: Tue, 11 Mar 2025 19:01:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/328] 5.4.291-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250311145714.865727435@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250311145714.865727435@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/25 08:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.291 release.
> There are 328 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Mar 2025 14:56:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.291-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

