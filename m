Return-Path: <linux-kernel+bounces-399248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE449BFC82
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824771C21CE9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7175829406;
	Thu,  7 Nov 2024 02:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WoYTIBDk"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C04D268
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 02:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730946406; cv=none; b=YhS+8sn2VovSlgzORcfQLDRIQ23SKUOUtR2IFvQBUIk7pAKQgKQcYq+WPq65A1UK0wDqdqc9vyWQ84pjhJB4vgtTdbqCGdLH2wAR7gVFOzrfoB2JOupPR3PcbJfOan/fQfXFCFQr7pmv7ocgGr8/jUefovMIZLwcEVz/sJT0+OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730946406; c=relaxed/simple;
	bh=cJpKnGUFX+C25uYwW5TZdZx0NvQknnN0YhJKq8SGgUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqLapJfTkzCU6nWMlsRG8KjJRAuVqJdiUEuQZ0/qWrTgyr/3ClqCnItInH46/hlHo+vvpcUAfUplLgQALq6u5uxt+OvkvBUR9eX5HvabezVq/UfZeaubA9lOw0hlSH/4PD0IWuwuvwHOInAe+AWYE5Fyu+XZLKBCuo7eYirwfyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WoYTIBDk; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-83abc039b25so18678139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 18:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730946404; x=1731551204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fsadpb/yTYe5Ho6eI38Uu8IKjOHgtGbPDaakrnLV2qs=;
        b=WoYTIBDkBFKz/9mnyDz2CNAB8ytQUV+xfx7jDLsNAHz+NqM31qtuK+PXikkligrX51
         yxzTmiHcibh1zg0xyZtTHd1+pizGiOAIcKJRNCwvHcXB0Ow2BdFVrNHbxhPeFWeDA9cd
         J9AffcBD2AY29JuQdbz9SVY7HF+/4iZoQBT5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730946404; x=1731551204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fsadpb/yTYe5Ho6eI38Uu8IKjOHgtGbPDaakrnLV2qs=;
        b=uPipOthNXNteVheQR+JTXhxFbeQ53EJur0/3KNQRCPyWdwEdEJ1zrDt56iQiSAt86i
         dvU2Xe/ZM2Q3Bdi50bIYAHGIPvqLjvWnBUf9NP3uzwG76KprHQobGfyMapybal14SHCi
         gVD+IcDNV7r5jUFeXN57xZuXulCs/6w4ApfQFE4D5JEjsnf9l4jxN1T3R6AJqTLlWPkY
         f5lp1jZJPDXm38a4bTpLraiaRxhWt5+Rut/MP5TapO43IoZpCBZJP2Eqhowa94ya1zq6
         gYBIYkkn5+dL+78GYakV4uGE4dp6IyNZBdm4Fw55oinCy56gfdUOEcktPDSq2IJ49zFF
         cfkA==
X-Forwarded-Encrypted: i=1; AJvYcCUP//Wo1UztpMEbGXUIw0cSqAzCUAkVIL1UyuV/X/KUbKaDC31xYz0GhfgLyNBe8NeogwdFX6sDgCTX2Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzu4k/o5szzfGJ7LK2wnv9TFv+6wyOnL0OKCLJdgyBzyB5RSxX
	ODycjrxfcYXRsQP3EnPI/FRSu/fMLrCAMz+n+yeggkH18Cxcr2sXtEM8wgwS78o=
X-Google-Smtp-Source: AGHT+IHNpB4MmvcSraJtYl8rbwJori6zmReEqGUf6w1IcSKoGYmZTjaRiv9WOGWUPCv7aothCGkPhQ==
X-Received: by 2002:a05:6e02:17cb:b0:3a6:ae3d:920e with SMTP id e9e14a558f8ab-3a6b02cf8famr249558485ab.13.1730946404158;
        Wed, 06 Nov 2024 18:26:44 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6eacbed1bsm697315ab.35.2024.11.06.18.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 18:26:43 -0800 (PST)
Message-ID: <26da61ff-524e-40c7-80ef-49c6323c629b@linuxfoundation.org>
Date: Wed, 6 Nov 2024 19:26:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 000/245] 6.11.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241106120319.234238499@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241106120319.234238499@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 05:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.7 release.
> There are 245 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
>

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

