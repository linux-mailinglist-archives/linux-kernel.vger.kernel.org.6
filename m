Return-Path: <linux-kernel+bounces-445271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFEC9F1393
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89671888C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C9C1E47CE;
	Fri, 13 Dec 2024 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TjyDZR4w"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5F51E3DC6
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110845; cv=none; b=DDYFa6VGL6SC5rdJrr8sCDccnRn67nTangmE5GrbsgnNdfIGElSLwO8zPxzc8nl0pesm7xubugDvv7DfWIaU5C1jtJ7iVzSAP7Katrgjx0DPSluib2n6/5jxQ3OEjSjCDBQ48ah6GrmV8/a43VRawCp1G5iTUhrQFpO/eOPygP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110845; c=relaxed/simple;
	bh=MwpY+eaTHW6ZPilONEG0CjNGfxYk7BcIdF5jRQfjrkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KjlpuzIQmKrQx87LSW+HKDQ1TrJG6egYgenKRbYnJyYceOiIi7qBMLeqMIiDo7vGICOf2SoJmitsMEqj8ooxQCcr1DaDuq49qFcWQ9Zt84ewcXVGL2c2utdm3A+3s7xgE1R1fX9iDQJxiYOxZWRMQSe6jHUTxBh/Vwbb6gSm2Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TjyDZR4w; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a9cee9d741so15902425ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734110843; x=1734715643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZ873rr8z0y8ShQd+LncMxaWKOoC4jcirXRjLJy1nJI=;
        b=TjyDZR4wWIcZ+Nc6kQEcrFqPmfjUfvzNiPp20fP7f1AqHg3jbXXKUuTbwqjglfaGZC
         sxM8zU17B4w7n8mee0UhZNkt3kuWetBnhY5k6MD8eaDoZlS3MdXGM4tQ9pO9ORSgAbv3
         MjVHZ4crOlG4nNrWjNsUNuUWIkcOeS9INoaTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734110843; x=1734715643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZ873rr8z0y8ShQd+LncMxaWKOoC4jcirXRjLJy1nJI=;
        b=G2ucnlaxC01CcqX3n8xurZjC3JsO7cCYiB5LmVNs4+EkDEun1Dg/M996k9kXPkh6e5
         QTuRvg73Ylp2O9kJ2rUXeSlkzb4wuJMv+KC/TaT+Vt7w0REIAw6A+GudXKcCO7DPSr2d
         lieyXLaLjO79cysFKnuGn0tN+GXFfetD0uvQ+Vtpoh1+FvbT+8Dq9yUF+Okp3t8/vInF
         CdO0seWD3gOATgDEr/KKz0hW2uQ8LSXWZmoa+00aG7ZHX1DrjC1U3/jFXBO555eqowYy
         HyJ0crMTt9IyNh7HWeW1Mssf5emHrV7HBWAeSH8oQ7qSJ2iFmXsH1j2Jannrsi99OlMd
         v17w==
X-Forwarded-Encrypted: i=1; AJvYcCWfnX4SQ8qiSBa2Eh95fZfwFhXRYkprzmgr8CNvxc5XnPW8pFPtX3tmVoMoM5oy2B8y54gxwAo1CwN0Kc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi0+7H9+qTuuGqRr1yxFWTX9uRmHHlCCnr4yAAsfUUA7PfRKfq
	z8wlO3I+RGeM2TkIXaIdC/NHgMSn/kOK08ScGJgSywWJZ93dPIQ/q7XY//Rxqcw=
X-Gm-Gg: ASbGncsEaOh3Fh3uLtfEZyRkOtup3HEU7oxOOPC54gsJEaTmsmZ1FjBbxAPBwkQfVL7
	HIvzlEX2ayrrwwuz2tN8ZuxXjXc1/pLBOATgJiNRI/eM0P+rzYi+XXviZl3evKSiaqjXRvcTn7n
	yRjbeAY8dvMovsHlhFJpcoBVkKD94IgH0c60Za9KF+e/3O5dIm3OqRhhzMdJQzq0ymg42xvHbC0
	0QUwq89r7eA4r67ZZsTyotgsEQG83426oWD1F8Uh5jHJfAUftDwQU2lDsm/E1SFezA/
X-Google-Smtp-Source: AGHT+IEMEr3uAWKMVxI9slphjbVdYchSxXggpcr5ca9kl39X9OR4taB2Resxa0Fh4jOpJvOjJQ1o1w==
X-Received: by 2002:a05:6e02:1ca8:b0:3a7:4674:d637 with SMTP id e9e14a558f8ab-3afeda2ebadmr41301295ab.3.1734110842854;
        Fri, 13 Dec 2024 09:27:22 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b24d8dc980sm84075ab.67.2024.12.13.09.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 09:27:22 -0800 (PST)
Message-ID: <e31df167-1a15-4015-a6bb-85ce29ada6fd@linuxfoundation.org>
Date: Fri, 13 Dec 2024 10:27:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/316] 5.4.287-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241213145847.112340475@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241213145847.112340475@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/13/24 08:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.287 release.
> There are 316 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Dec 2024 14:57:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.287-rc2.gz
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

