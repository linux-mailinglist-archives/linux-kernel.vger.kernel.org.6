Return-Path: <linux-kernel+bounces-323973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87AC97464F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149281C24C84
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6511ABEDB;
	Tue, 10 Sep 2024 23:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I9C5SE9g"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA581AAE0D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726010457; cv=none; b=BFHDdt50y+QjOyFQldi17S44WXz26Ca5Z5sR6fP/6EZxYf5E+lJX9RpmlcBLgvS6s+dvdPJ7wzx6vuHRY9ZBCvTXZ3OO+b4vlaKwZRfO5XclmclEiVXLuL4UyWt0w0FhzTd2NdoTSrK64I7cQy30VHwnbaBms8UHlzu4gtJzxWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726010457; c=relaxed/simple;
	bh=U4EAbY9M58DyLBeT3V4uWlg+wEurSR1JCXjx/kPTLJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKXGGDKG7v8RoBuMs/auDEyqJl9i0kaQnKs35NDJHw76N4iYzg1RcrQ9RKCqrDHOiYVwXZf+VMoc+824ruxpigKptaU1u2PkDJpJezhbiJltLTlQL7TQPnzAVRme58LzyZXyIBh1QuT7meSI4kBXbYQJcaM5+uTalLWHjWAKAqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I9C5SE9g; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-82aac438539so182370639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726010455; x=1726615255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nP+F6KQXB41yOMLPUcFAdK1CUArMESt6YLkIllFzb3s=;
        b=I9C5SE9gsGlmT50I6mPMlObeq+7asPc0Yh2uwjB3lzDPoi2EBzX/aj3kqTzaBxxka+
         ftN/saHeT+Bo9y4bWKUxEEA3tfnI4W5paPFgOc/lkALV+nG+EclhMdrFQVz+R3abjRA9
         QoetKqSMEpuEY3n0EInGTlmtdOzyyEKo0Ugv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726010455; x=1726615255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nP+F6KQXB41yOMLPUcFAdK1CUArMESt6YLkIllFzb3s=;
        b=W4RmC08/78V7V5ypZzgtYeviWj5vFhvcvwlIzAkr/uHzgWiOkMuBPp80885pFnuLSl
         vYMrl+eMUV+9ABwWf3tueSfgnvp455nkjYH6o84F0u/aGGK4ZXWi6XBNrTchQFSpn6v2
         XMTYPtokEzJo8/SmpqqR8OEDi7ITcNknyREJKnNgFSYJqYBm+JpPPR8fJfdVZt0wB4Fw
         33uhxvMELSIDmH5C1B8Q9QSwBnC49mS00jT5yD8lFMBAEuggrXKLcuutjgErt1TohS72
         kxntavbHbB7OLjnMcg3x1H4ffeSyIkppZJjytEdWWyriyp+zbg58y4vpeIbzDrvuKBw4
         V/vA==
X-Forwarded-Encrypted: i=1; AJvYcCXjostvvMkhHatHtTdPVAoZJZd0avWLpBLO2+XID2bMIKhhX2f1MvLAMdtyWrmtpUlvoSqF6JeBntJQ9+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb1miGKtkIIXoo1CYZrg4Qg6qGodEEbXOHxp/emhgiLQzHaxQK
	o4yAUVhlZbSf+1Ji55h6yANjAQ5X+PCaJ4I+5jy59Rg1EbyaMqj7tnymqWdI8kg=
X-Google-Smtp-Source: AGHT+IGc1C+Rskz8tPoGBdLeCU3gP07CCcQMmJVw6yyFBK3nzwjbHotz3iB3nLtNKvPCfRADwwHUfA==
X-Received: by 2002:a92:ca4c:0:b0:39b:2133:8ed4 with SMTP id e9e14a558f8ab-3a04f0aa8e8mr189561925ab.14.1726010455190;
        Tue, 10 Sep 2024 16:20:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a058fe55d8sm22621145ab.45.2024.09.10.16.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 16:20:54 -0700 (PDT)
Message-ID: <48690583-7fe9-4edf-860f-7372983924b8@linuxfoundation.org>
Date: Tue, 10 Sep 2024 17:20:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/269] 6.6.51-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 03:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.51 release.
> There are 269 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.51-rc1.gz
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

