Return-Path: <linux-kernel+bounces-445242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 809809F132F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FBD284453
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE41C1E491B;
	Fri, 13 Dec 2024 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fs7XgN7M"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B151E3DE8
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109597; cv=none; b=KL3mUN9fyRJ0aGr17S2v8jRrwmg8YD++EYzbKqzXfOXuAOrY1EAtB+5tsGucGsdbddbcPaLz2SIKW/zD1eldLuzYD1QEjQOoNoUaVc6X6YhddrlrFZ1tTgYPMuaRkPRDtl6c0XVGkZ1MKSjU0xjH1vbqCZ3/YTgwiSmrHJ7Oy08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109597; c=relaxed/simple;
	bh=AoRSgPzS88JecR+l1uq6Q0y3fbBaioBqex9uux9/veE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBwH2bIruTxO8wpW5oB6jOHV9KRPDTsrV5cToDaM3i6Pv6HRgqAKc6wTHI0QC6Ukjri+J/1s9Wqit+O2ApMfMUONF0mG+zAVNID5JHOGIXnxNSjTZzr8VVAagP5o/rslgzn76Qo9JK+81XD+3FeEQJZID2h2Pt/D5fk2BCxfRhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fs7XgN7M; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-844ee43460aso39363039f.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734109593; x=1734714393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5b0l10Xxg5NNZ17JwEtHgXQTuzkIvYO2hORgPq2G1Ww=;
        b=fs7XgN7MisCP6MV1KmlPZoFCAD84I9esYIFp3iiWXyK6PjwQkjeEU1So6690KVH2bd
         6RKrbIxDWprr9rvlU4zrflr46LCYCAOV7VNnI0j+PkpIdhEQJoi0+kY48wLan4kVibdg
         ap0fOxrTHRoTXp9AZ/XP1jA2Lu00TdQQ6Cefs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734109593; x=1734714393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5b0l10Xxg5NNZ17JwEtHgXQTuzkIvYO2hORgPq2G1Ww=;
        b=JybXxrXbbUoSXvtQ+8nxSYBpBN+7cQv1/xpFLV6MKKd1ZfGI0gez18sI0QHrHTcP+j
         7ieanZ/EtIvtFjj8xoRw14toHtQucWoVo8zrF5JBnrB0Ul5KS9q88xTE5yghdHQuIQQ1
         wzIPi+y7Kb89NjVcMVN5IydxNrqnPfhcslw27EiBtUa3VPoIbRX+eYUS2tOOD9ciUQ/d
         4qgBsoTurJEyXzObB88ff/7xpwcH9ScihgPUR8BdY3brPLVP6K1rKKB+Fw7ZwVQtTc3C
         zcjT/kKoxrp2Thhr7KQ3DxEJ509AyO7J7kakPvyugwl25YUpAF1Bf5UHdTxckCN3fZvG
         a8tg==
X-Forwarded-Encrypted: i=1; AJvYcCXPYXoaEy+84nmPk+v5biZdfNg2dt2PGREvD/88zGdSctxL8MOWGSlgSIt9nEBG11DEJDUio5u04FpvaYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTZ1jwdRxLRibvDpgTWh2Gd49NYD7VxrfPB1SZUeZd3kBWkB3o
	5aMFty7R8OTWTV8vnPqT8Gdx14S92qAPV4f28n7zAZuHGdfOL6b7KCuQ8kZgmsI=
X-Gm-Gg: ASbGncuQvvUxh0pPtvUoiIy1Y7o2ca8u9adjnsEXRCoy4aBXmU2iFmPxEt3SL1V8EXW
	luoWY3NxfgkePSlUrGJqo8DobRYkkClA5QcQdL6Ln46L37cLYJztuoI9UQ4V5UExfFFZCtrR67N
	+Z9b2SE1hLAyD4TlfHr92xXefRVdXbG78RFBhcV9V7WIHecdT396IGtDr+ZUQ0ac+eUwiC7knIp
	j63sX3OAMhoGwdnlipC8/eVMjzqB9NTK3XJOS9Crb9wf119Z4PYkKJQD8X1yCCgy72N
X-Google-Smtp-Source: AGHT+IHTYnff3TXKfRrpX7mWJMSvmgfa6oVTcS7rebuH2nCEbPNkW26SkILtniouEw0a8sW8t+/LWg==
X-Received: by 2002:a05:6e02:2169:b0:3a7:7d26:4ce4 with SMTP id e9e14a558f8ab-3afee2d0367mr38502285ab.9.1734109593520;
        Fri, 13 Dec 2024 09:06:33 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2e08d5cb1sm1227854173.6.2024.12.13.09.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 09:06:33 -0800 (PST)
Message-ID: <f52512b4-f50d-496c-a831-cce2d2644615@linuxfoundation.org>
Date: Fri, 13 Dec 2024 10:06:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/772] 6.1.120-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/24 07:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.120 release.
> There are 772 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.120-rc1.gz
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

