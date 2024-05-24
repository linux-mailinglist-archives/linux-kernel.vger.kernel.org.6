Return-Path: <linux-kernel+bounces-188806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8368CE732
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0941C2230F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32FF86AE3;
	Fri, 24 May 2024 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cy18rnxD"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D9F84D30
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716561427; cv=none; b=S96oe86McspYbjd4VzQNEnzbddGlVJkqbYlek+hFTueCIPizswHtefUFbT67X7pfkOOrJTm1nzrHkUbszwn05Q9cElxl09FBgluFZwM2yp8gwNjV3a243fEw+WMiooEguxQINtDP538/wSgqvI9MvCO0GE71YWbWh6NBmXwmfc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716561427; c=relaxed/simple;
	bh=zYiUOM/cgz5FKbnxjvOvtgTxQKTjT8kGJGa40kErl3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sS+nwXam78gbkbiL2Figj7aJHb/iCIHyXulUPAk/2fScZTGxt3Edrg4eEvxvuIwnLcUhHYhETucxioecnDXAeiWF/K65pkdFG/knE7vwp7h/21qjcOIbPirTHPrhyskwmY6qCw76E5TCwCbvi2ObLaSnl79R16EFprC4HbGN17c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cy18rnxD; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7e24aa659abso28668639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716561425; x=1717166225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eJBA7xup2TeLFqY6dNBteGIN45rczWvZo72CMZBUlOA=;
        b=cy18rnxD9yMlCjCQZ9HHmzXD4rYVrN4pryNWMmSk9as4lqp6WCCj5oCSd2vnr1vgGG
         vj/J7/PSynIFZtZDyD3ysFtOFOaWPaxdeUCRlJi8PgCxmjkn0z+YWnvowDQKvDIzbc1D
         HhFTpogLh00YXoNlIa1v4cxHgdNq343HTUGHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716561425; x=1717166225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJBA7xup2TeLFqY6dNBteGIN45rczWvZo72CMZBUlOA=;
        b=BcOCh5Ay61MWstKG6mmffJhu0PcW3AhAzpr5xBukUanVWD5y48h7chxOKCPePHgzF5
         frjgKw1DOO1VvrH04P1OlDakDLvNnV/OOENiZZBHJ7Tc3itylAQIcjK92bXaxqStfY1x
         8Nfvwue4Kut0B9yc2AHK2iCQy8rVSluzqyQdluCGh2WewPeA2GnbO1CbHdo+mj0yb/ZF
         Ywt1cdxq4r/fuPdJ1zl4Xi3MpwwKSUqW9ss6ekIdFNKr1qGJTzAX8Bzxybe0tIAnhySO
         qrVpSyWuJji0Qf9arwH6NiUEaLkkSv0X7CXtdAX5IGd1dHQ1FFzqPulmFXAunbK7GEd8
         L2jw==
X-Forwarded-Encrypted: i=1; AJvYcCWMxd5oWvsaNRicwtJVXvgMAJ1ZCJYhCLN4W6T453LXMLAEpT8sMX8f+u5rinacYF00mAaPuHIG7BOrxR5Un6jERuyYWv2ftigLLn8k
X-Gm-Message-State: AOJu0YyQWpSkvDPy3767jVHeYyj5229B7yWLoLazPROnXxTkeERzPVPS
	4gxIhpCX/eNZshogOQr468u8y1w5fJOvLRWlpzW/RLGW2SjIvqD/6z/Z7uIUiDo=
X-Google-Smtp-Source: AGHT+IEg9xi37KAXDcTtnCl9w6vL7Y3TJQ4mxp40+rGGP5JKoURGQTp+uGB9FOOKyJqiHmPqX+Y+qg==
X-Received: by 2002:a6b:7003:0:b0:7de:b279:fb3e with SMTP id ca18e2360f4ac-7e8c6172dd8mr253938039f.1.1716561424952;
        Fri, 24 May 2024 07:37:04 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b03e8282bdsm399007173.14.2024.05.24.07.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 07:37:04 -0700 (PDT)
Message-ID: <9138a7c1-a561-4f12-a529-45e3ff2c7caa@linuxfoundation.org>
Date: Fri, 24 May 2024 08:37:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/45] 6.1.92-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240523130332.496202557@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240523130332.496202557@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 07:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.92 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.92-rc1.gz
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

