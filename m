Return-Path: <linux-kernel+bounces-416414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B799D446A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D33BBB2202E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEBD1C4A2F;
	Wed, 20 Nov 2024 23:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PZwQXqpw"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7E71925AC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732144845; cv=none; b=dH1Q16+NMlNSPVQBVjeez6rkHsgYGCtCXYFWf6iZfyXHK67DO1383K/5HupjRlEK5IOdJH+hd7XHyds53A6IRNHDxAAOZhj/1Gmy/XfZVnjjmXNnSgOrUmAAIBv9YOTDnmIVreKs5tug1mn54cdMRpv9lBGDA/cozbL3sRVyDWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732144845; c=relaxed/simple;
	bh=eupxP0WAfuiBRZTPQdKjbDaBL40xdQ9r/lQfnUunKPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IeRljK03Mwp3y0n+piNH79wFcCSUD8ow/aWiwNYyEjcWiCKUjy5c+NyoCAFjqP1azpzU6374V45ROQKSUK3+1Wcfc7vbxwtCn2h2OeGGThpEkvLYugoY9LMDF9m/5VlPEtn2ctrSpMIozd+LphnvDacDKaG70MR8ceZNxgkOhBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PZwQXqpw; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-83aba237c03so10709939f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732144842; x=1732749642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kI8LjRbHnrIYCWVFuTZVSrxkVpMakjiw/cyxut4YKfI=;
        b=PZwQXqpwR62MZrA+7oubRf492DnC+H+wDoWMS5g0f+hToW8jTlC1MBs5Zbm8qtJrUy
         oACXnMWF4GU4JMlW04tjWKAkNpuL1nTRhSOuh1CVa+URI7qamFy+U2RjUzK57jee0iRc
         EFohr1R/oiymvJeCqfz9zvmbtakvIdH3H0sWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732144842; x=1732749642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kI8LjRbHnrIYCWVFuTZVSrxkVpMakjiw/cyxut4YKfI=;
        b=cUjDRCDBWQGtimlT6h2iP1JP5EUuQkCtSa12rwxseaASi35iLD5YitmtUfPzaG5Vup
         B8OFbBqhv2O9t0tfotvMGJ/VzhwQvf1q1KAwMFyOTw/IHOugFZtaISZXr239to79BJ66
         aW/lVT+IW4BxyWwoArnOOuUFslXZIelbbPfZNfAzaQ9gD7c4xpzPstgA3IpVu85qMT3F
         9C9fyQs/evUT6t1IUJUsVp2sLm94akLf+7XXCI2Ookjqj0Pa4ErZLeCBdk0q9CTZwIHR
         xUSZMFP8oe8CqlTisxB8DSZb/K2ojZ5A5yexCXtFkFZZwt+YaYnMnc4xLYd/jvVJ8BLM
         Cq3A==
X-Forwarded-Encrypted: i=1; AJvYcCXL10ABs0ZjDt9JE8J7EM9H4wFXgIFcEGqXsvmzzmCozITQ6nHaARIcXnV4JrzpI0SccGLCup9NGL//92k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfpEopqOYfQEXW6cMHUTvYE4ZYQksrHMnh5cq7eSdhJ1TT1mYU
	kJ+oIElKHNesMHZU5EfyQSqOVIeDaFQTWGYrWFnZuJURpA8b78zEg1euoz5LSeE=
X-Google-Smtp-Source: AGHT+IEEiuGathMJnfCVnOnRROnN/kddhLVKZ8maKJ87UcKzpikjw9GywFlkWjEQ98DV5mVGfqUK2w==
X-Received: by 2002:a05:6602:2c03:b0:83a:ab63:20b with SMTP id ca18e2360f4ac-83eb5f88fd2mr584939039f.4.1732144842233;
        Wed, 20 Nov 2024 15:20:42 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e06d6ebe55sm3349642173.6.2024.11.20.15.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 15:20:41 -0800 (PST)
Message-ID: <3b2a3cfc-861b-48c2-834b-408532a230e3@linuxfoundation.org>
Date: Wed, 20 Nov 2024 16:20:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/82] 6.6.63-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241120125629.623666563@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241120125629.623666563@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/24 05:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.63 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Nov 2024 12:56:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.63-rc1.gz
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


