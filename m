Return-Path: <linux-kernel+bounces-366837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F339099FB47
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DA52846B2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2F41B85CD;
	Tue, 15 Oct 2024 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HGiKNp2o"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68FB21E3A7
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030894; cv=none; b=DlUaRtSGfJryvu/dcWrDRDBkP1ZxDoYJ3MHbixlCMFHZ8t1mZYdztl+djyRc+W2/eX+zBK66e7Hwn1TXBkn62iFEf9iSqjDAymSqN4HqpaG+d4lLGLpuKwAieN/pssnuzIRbR+wfSMgb3K68RCnTn/6+9aEcrEFFOjHBfNGfHbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030894; c=relaxed/simple;
	bh=ltQMRIsXUfjEPweA4ruMh+CIceGsnMVBfbTkfwieJUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTSKVbtY9TldKmjET8KSAaaKL/lVrpnY9ilfu5tiLkcjwrdUIBGCphx/jWQOnd5h+77CJsGmGGFVbZxCkQZRDHJGorrHpuCKSpATMtEYxB74UPVTQylSD1leTi2kP3pmdliaJLvDnTMZgLJLhyPxYTxRncztkm85cdt//xTk8EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HGiKNp2o; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a39cabb9faso19365455ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729030892; x=1729635692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TNv6EpUkF46yC8CnPi4D029NeIjdWSFiLY/SEWTCkiU=;
        b=HGiKNp2o+rby+Hm8z3jD15uctQQodadtMMSQlSflqWhEq0u1w/bs/t2cgAD3CHYlMZ
         T1HCo6Jj0oRwQnZDWrGtrpkpJbmBtSUmgMAj/TzMgt4EWpjmFlobJ6Ku+XDfWksobvD7
         jxMJmG175NNFYXhVhhG6bkBEnI0c12dyGLdt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729030892; x=1729635692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNv6EpUkF46yC8CnPi4D029NeIjdWSFiLY/SEWTCkiU=;
        b=rmj16o9PvC6AEiGuPTw6e84u3TPA92uJbN2XF9vqzJNvjrgv2glneWcs+9+l1bNXaS
         tZgpvqtoSKYBRwEzBv5ffHmAc7zzGoqMWeowEd2aLZPl55ryt7Ul+qOinaQsyq9CqRxP
         EgIq97PQjXZWM5r4WQ7i/Ec5iIuuy+i/hAaLjXUjd1vwj9bCWBqsKfkeMefSIeeBu66H
         EE6cbKCTTFbegrWeJ0CJoRMgXiRgIsmKxtNFQmkS66/bY/iItThzhRN/riq3z7FdesBN
         5xHoGWXKb+1lA4860IY7SiNqfv0+CLRarNSAa4VUtWGuBglgmhMNlYgaeWnAmN1UeSqX
         gwsg==
X-Forwarded-Encrypted: i=1; AJvYcCXFdpmN1TnegcxwcUyeZWJp5uYJm+fi5OGmVJTBCXpxlcLn32USRKH/eGAQyRNDOa69guUdpPBX166osBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMkO/jXkY0a4K9VpCAt+9jTQWEhCa7UKLVnBCzH0pT+C9ttaPr
	ny4H7v1NqhWPLhkRbnH3tIFa9/fkS9hoj2gGhnqN3JVYwrRAmmuFhxr4WqPYdyEaq5MLGl++DUR
	a
X-Google-Smtp-Source: AGHT+IEaclnUl4KoFETjKApAJu24dk+GljHsnn/vZz/hzAdpQuBIfKEIAYOFjZjg6nfn/buMaj3f4Q==
X-Received: by 2002:a05:6e02:194d:b0:3a2:4cc4:cfd with SMTP id e9e14a558f8ab-3a3b5faab6amr157980805ab.14.1729030891827;
        Tue, 15 Oct 2024 15:21:31 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbecc6a612sm521449173.162.2024.10.15.15.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 15:21:31 -0700 (PDT)
Message-ID: <cb1a9ce8-c84d-41d4-8fc1-ef7d181af1e2@linuxfoundation.org>
Date: Tue, 15 Oct 2024 16:21:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/691] 5.15.168-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 05:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.168 release.
> There are 691 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Oct 2024 11:22:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.168-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

