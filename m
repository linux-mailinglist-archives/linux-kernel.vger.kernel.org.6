Return-Path: <linux-kernel+bounces-380065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4389AE866
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3920B1C22DD7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E9B1F4FBC;
	Thu, 24 Oct 2024 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VBbRUG4B"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2687C1EF955
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779426; cv=none; b=dxBExJM3VFbuSL0Rw8PeG1Fugdo6lfuBqbMYPQC5p9HUv5aVJWqLKDyLq9UYP4D1WRKDL60a5pKkWvlJPCvWuYh5IvAoOCmGDwWdKFyLUkhHEU98Y1SenxL9ggSbcOpQzo5oDHVo/yjXWyl5PwwqKM98XE5RWYYqTFmq/P4iXY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779426; c=relaxed/simple;
	bh=ZHLpxCaABJIHGEakW/HkEnnmvVY3qa2023G4Rw5DXYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABjKMdWgd/ZfvTNKIIOxvgmFv8ajI5E6Rj1xLGnTPeYDEXgNuqE3Vi4LxGC6uHmjt4aIcVbpgIuJ07tV91Q+IBr5Idmi1udARucvjwYIT9mAhZ4l7sBhloaRqVquLLiPzv810Y8hYkjMZiyayEoUzDv/BnwIkhaxqGUfmoeKYxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VBbRUG4B; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-83aac75fcceso36980039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729779423; x=1730384223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b64qypICVOVPLQ4AT6WFJut9ohzO7ijv8p58Gwp22hw=;
        b=VBbRUG4Bvo1DmnzjypQFjM2b01McsUrTxuz3qJ23To/DYh2X+2426I+gaKTnh0lSTK
         oMoxXAjdohz0qro0tqFwyMd8XJWA8szSBJ21KNvT6FI97/Cbw+9KiE1O7QWT6bh1yYal
         uPKbYxVoOasNuohZSOqFxbyCv8fo5pwZHUdlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729779423; x=1730384223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b64qypICVOVPLQ4AT6WFJut9ohzO7ijv8p58Gwp22hw=;
        b=PHnJRp++WRV3HMMlCH1JJOjFI1bZhH2BwZAYKJg+gfPM76WCxAFWMsgGQ9PesvTGg8
         mCXde8Ab1CzTvTm8oI/ra7hE/tSKkH2sFUE5Xx2qqWEQ7WnhSOoNc9Tcaaf3CyGp0tev
         iAcTSGKh/5sNpYoD89lNgQUKnfN5ngmhenh7XrI+w5cz+1YRo3o39Q5aK8p0qBmb8VjL
         7hmC1ML7VTiXcYETZXU9wVY6cqAPufZMStsnVzXWQ7nSzdNdSBb1wthea6m2W0YD/uxd
         tKl19UEcBf7fiaPumzzZt85C/YfHz81TIqQngdQ5Imw1dhqEsqCDScsWYDuRIT1BzYcg
         CH3A==
X-Forwarded-Encrypted: i=1; AJvYcCWyC7MBuUfAi8qA4e1nEFT8IcGmoAzQWBfDKHpW1anEQ55gzvlbsvG5VEEVU96N+44lun5RGdahcwz1DeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRYZCNgwMnFKke2oARpYoL4UPha+ceOVJBzcqGgbgQ8fnt1hyw
	/XG49UY81fimtqG8BBHsJSVmLY5G3EMOLJmI5NojC53yzXyavVQzdVHw+K6/VMMpH6fwgWfn+cD
	P
X-Google-Smtp-Source: AGHT+IG3V+qH2hGCoVjFpiCSG8OO5Klo/NaqFQGsT0YDjdqVv5Wth0Ol89M3HnkpPrHKa/QvmQmlpg==
X-Received: by 2002:a05:6602:2cc4:b0:82d:18d:bab with SMTP id ca18e2360f4ac-83af63f9e29mr745899339f.15.1729779423028;
        Thu, 24 Oct 2024 07:17:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83ad1dfb919sm271119439f.53.2024.10.24.07.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 07:17:02 -0700 (PDT)
Message-ID: <6b3bc049-4cc3-4d7d-a9b2-17d4132ebc50@linuxfoundation.org>
Date: Thu, 24 Oct 2024 08:17:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usbip: tools: Fix detach_port() invalid port error
 path
To: Zongmin Zhou <min_halo@163.com>
Cc: i@zenithal.me, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 shuah@kernel.org, valentina.manea.m@gmail.com,
 Zongmin Zhou <zhouzongmin@kylinos.cn>, stable@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <8d1a298c-78e4-4dfd-a5fb-5dd96fb22e81@linuxfoundation.org>
 <20241024022700.1236660-1-min_halo@163.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241024022700.1236660-1-min_halo@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/24 20:27, Zongmin Zhou wrote:
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
> 
> The detach_port() doesn't return error
> when detach is attempted on an invalid port.
> 
> Fixes: 40ecdeb1a187 ("usbip: usbip_detach: fix to check for invalid ports")
> Cc: stable@vger.kernel.org
> Reviewed-by: Hongren Zheng <i@zenithal.me>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
> ---
>   tools/usb/usbip/src/usbip_detach.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/usb/usbip/src/usbip_detach.c b/tools/usb/usbip/src/usbip_detach.c
> index b29101986b5a..6b78d4a81e95 100644
> --- a/tools/usb/usbip/src/usbip_detach.c
> +++ b/tools/usb/usbip/src/usbip_detach.c
> @@ -68,6 +68,7 @@ static int detach_port(char *port)
>   	}
>   
>   	if (!found) {
> +		ret = -1;
>   		err("Invalid port %s > maxports %d",
>   			port, vhci_driver->nports);
>   		goto call_driver_close;

Thank you.

Greg, Please pick this up.

thanks,
-- Shuah

