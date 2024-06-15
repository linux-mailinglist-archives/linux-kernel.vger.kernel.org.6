Return-Path: <linux-kernel+bounces-215655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB1F90958B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 04:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A311F23090
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 02:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D16B8BE5;
	Sat, 15 Jun 2024 02:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Is5W2UuX"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F97E79F0
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 02:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718417377; cv=none; b=uJkHrEM6CgkpFG7l9Ib3ap4yvqy17M3dhl3V5hCaRPVPfDaFG6QAnq/fR4+6tVY/J5tdbAcj5jzzZP+gQobOBYeuLyFq+wmyk3IporOBHsti8ijEOgTv2LW84kA1jQN99v5T9xqOOqUzZAxykM32mk50UFEFNehcyPxjkmPgopM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718417377; c=relaxed/simple;
	bh=2rJq94MZ2ecqUa9DEBquCVlM0N4B3BQ+yYzW964DKfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYh9JiarS2tRY/I4RL36uAaTo2715t0rN97bv8m72ZmHdsUSzupYXVNv6w91JSEGm7ukTmdeLb7iaGObvvmuVFRhaa/VWNNvC470UA9rw3hNUeu5kTt+GN29o4NL7N1apreDlj/qvoewMBPbGhwMoX1YoEh2oJUPw+l+RlMBf6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Is5W2UuX; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7eb7b214cb6so6370839f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 19:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718417375; x=1719022175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PWgXBk6Yxc1BKmHVd7Vm+RJCPaj9sFMDtkNeQIjJSiI=;
        b=Is5W2UuXmk42Z1QyWSmG2x5sYm65eDuBUtwJgA3ZYiM426wZx6yV+ZJuPCc2CODjPU
         iZhNNfk3fN6TBxq5p6/HqLS7b03bHxE6gMQCOKTYCM1bGg7VbH9Vx/0z/8cxA0wRuELH
         VKPvs1FAxdZl9osbDObWNEo9NmRHH1T2h2/OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718417375; x=1719022175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWgXBk6Yxc1BKmHVd7Vm+RJCPaj9sFMDtkNeQIjJSiI=;
        b=TNp/1zl3uxJ7LgH/UiKNkRk5xcHkCKY3SwmsJVN3U5/5HcJSBPFtwjrINkeTOYLxq8
         OUnaS3M+Ze0+h5REkEdf4Fd1z6BULKncOdWftNiByGH+8p4RHvP6soptjPEyWiL6JX5G
         BDSWdj5DhaZD6Ac7V+7veGwzFMtE7qOgPHjibZyg0xU9umbY9KRnqqBdi5FO71hgZmR6
         XgSOJid4B+ztQHZuzPAYE0YzUrYGedxvN4k7eiuB2UXVW18ExuDsohncG1kFQ+9GJ3Qs
         z9Jn3uM7qf6AiyMZlcBd4RpsB9X1TWYtfWSr9A+9VWjWwQM0chkHOCJcJFfaxEsbmdsv
         9M/g==
X-Forwarded-Encrypted: i=1; AJvYcCVjsXm946Y5POd0XMHMq8m+OC2uC0BWz1pQdQJoBHtavnh+1r+kqGz5YSTAFH8zJZnvKd/7cKL5L7vtlG2DDVeb01YxdNpJYfOTvtWq
X-Gm-Message-State: AOJu0YxymaD+RfNK9lpKYcR8ziG7rKkqbhtVDOqr78dAoAQrNzG5aOc3
	eWoBR/G7NDhH0Jez6KKrDuowxkL4cP9z+zlJ6Pws9YdaYyTCdDdP7BzjyCguBDw=
X-Google-Smtp-Source: AGHT+IGk00SCYmx4ZxhqB38uGdMi+LqnfHffbXmkoJHJ4EMoATX0OF+G4W1HnEZMnhcHq5plpyP1Dg==
X-Received: by 2002:a5e:dc48:0:b0:7eb:ea26:3471 with SMTP id ca18e2360f4ac-7ebeb51e56dmr431851339f.2.1718417375580;
        Fri, 14 Jun 2024 19:09:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b956a1f4f8sm1243193173.121.2024.06.14.19.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 19:09:35 -0700 (PDT)
Message-ID: <61781c7a-841a-48cf-9f62-e1d38488e87f@linuxfoundation.org>
Date: Fri, 14 Jun 2024 20:09:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/137] 6.6.34-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240613113223.281378087@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240613113223.281378087@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 05:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.34 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.34-rc1.gz
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

