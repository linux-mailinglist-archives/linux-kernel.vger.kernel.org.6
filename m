Return-Path: <linux-kernel+bounces-366022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F7999EFC5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7F41F22E17
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCEE1C4A03;
	Tue, 15 Oct 2024 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rmp3ae6i"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C7B155A4D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003178; cv=none; b=bvM0FRRDBOqhGIjHPQr2XefnATJ7rg8amjHXWEj6pGJSPiPE8oIVJ0OAos2KLUVgiHMoanbsB7JrH3C1+3srtpctSllH+n+jE9bxj2ZrA5lSj4Q3pULHjvSUwGbY0LJ6FT9+V9NHvpD2N1teSxfwJS+XovHeD4WP7UIBgRqcP6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003178; c=relaxed/simple;
	bh=+FET4V+Go0PVk0KPckgbUBF2yItjsFHqmEQsxlFShNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMyDSVbFv/Ai1e5Nlo7SUk7bd4RzxuWENWHAkn6S+78ikMJtoftkuX//XslbO05Gc2fTFIPJFwj8JEcmswLxuNMNswxpP6f0pohFF/uzZyXCTxaWa/QPRby+2iv/FaRi0XK01GH85oCdIIzG63KppSdrjg+iFLHrIEwdY0maZo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rmp3ae6i; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-835496c8d6fso318154739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729003176; x=1729607976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aYV3QcxC45dpKB8impDWnSd6jizz1LlWcNLXatvfVSQ=;
        b=Rmp3ae6i5/3vhMzAcBSTJDy4tlUvpnrDUKJXl9oFbVQ+E3TEc6BlJ/PNLzuG/MpWwf
         zjFTwoatzObxB1hI40YfLwTBn0PdoZqhcefRNfAA6o4OBwGh94UPnSz0KchScIEoDZ6h
         P5RQZMKgwQA86OXURrcFkh213jCC02zy8DsaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003176; x=1729607976;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aYV3QcxC45dpKB8impDWnSd6jizz1LlWcNLXatvfVSQ=;
        b=KPndNKz42Ga0X7v1X5iGCE/64aeLdpJdRJytokLWj+TKjhT9R+0XPcLQ+Y1eXwpNM3
         tQhcNv0DETnN0I2kq5/5iaOypvvKRiMAwIVamYqYmmHF/b9BuVxtmTfgWAB7CvY0PSpq
         MJq4FSlLbMQbm7VMSmAPSLe2nlChVbFInkj5cixMl4IagVPP56QDadBZM2K91sA7O6AJ
         e3PBuDrKmS1fNkLe0Te+0+z7CZj8p6KzeWIuKDJCmj0fbpzqE2ZgBuxd5zw8Xxp0DQPv
         l2JK1ob77tn3POfXUbGoeeLcH2M6jMek2Rc4HrslwGY0xYm++OSAgpyajrhofWAd8kpb
         W+Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXe5/ZLHKLW37qURXUefQp66lnaZmNGI4rcf5plKFeauvMMDPX6WmDfwQyM05YhLL7Rh9mJaUoX0ms34rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqtD2YR28LC/TIKrOw4X5L6r8owCVWNLN4d6d2rezwaUxtyScW
	Otmf58fL8yFlYGuXJGXz1uWZRjpA2AyD3AC4nE1QW7Zyw2ziF71SEyM0I3F6ESw=
X-Google-Smtp-Source: AGHT+IED5yavwawNcgQC8TkzJld/CVTX7L8NciyUzcWybTw6y0vv+1spOMbUSvc9mmZZ2bo2GmR3dQ==
X-Received: by 2002:a05:6602:164e:b0:82d:38d:1362 with SMTP id ca18e2360f4ac-83a64bf39b8mr1160104639f.0.1729003176231;
        Tue, 15 Oct 2024 07:39:36 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbec9b24c2sm338146173.58.2024.10.15.07.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 07:39:35 -0700 (PDT)
Message-ID: <6b913fd4-ae85-4388-8f41-7378fbf3d137@linuxfoundation.org>
Date: Tue, 15 Oct 2024 08:39:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 000/214] 6.11.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241014141044.974962104@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241014141044.974962104@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/24 08:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.4 release.
> There are 214 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 16 Oct 2024 14:09:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
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


