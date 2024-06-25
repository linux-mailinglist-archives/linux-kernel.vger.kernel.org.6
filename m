Return-Path: <linux-kernel+bounces-229733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDF391735C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968702816C4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D51E14A084;
	Tue, 25 Jun 2024 21:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oj6T9aaG"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26239148848
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719350715; cv=none; b=L+HC+T6nl0jJIseBTzYlT2PRcVjC3YIaMTBdd9CnagNQlwQfRaJMa/5cR1XU9irxMQnSnmmjYA/vA0U+BR/Ax4gd+c7ZE91U1ZJXi52dtGzFts1Dhwb7ySOcFBHsQuEmOtzd0ODiKDJPhPNaZ5HV7BUGIO67RHE716WZbQTQuOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719350715; c=relaxed/simple;
	bh=pjCnSJI5wkLaPsKKzobjyBouBvkTV06ZYTrm2KLodxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsRaKvCv2wEEWq8C+WL0IoxJ8yix8Ug7lqvbLd8hBT1fvCXBDQXiWydNibhC2F44AT7b/eTpsF05OCF/Zpqp+7uTeTFpC6+QkvyvCi1cR3DZ6NF+yeVMuDQ1JPhG0a9UdEjBuJ66hvT7RVzxxMgQvyxM7D1k4cy0lt5E6LF29hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oj6T9aaG; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7eb41831704so17144339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719350712; x=1719955512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EylReHJRTyvw4qnns4SQL1C+bNXZftNvK2Yg8YJEAeI=;
        b=Oj6T9aaGb5QEepBxo+wjFFnY60Eu972uy4+3AdKfY9BYk8dNocUIqKlBssGwYpIX+b
         sHz7Mqq7g3YzzvK3IXw3RgBfGHWgOrvQ9hxEsIaCrHvB9zEa5nqTsZTUeOoF5OtD+Euy
         M8aN2tQIPaP+K/8mcx7sJgWCXQWNZfkY1xLYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719350712; x=1719955512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EylReHJRTyvw4qnns4SQL1C+bNXZftNvK2Yg8YJEAeI=;
        b=v50rM7OG2owVrqwOujQHuwEp3RkLIgYKl7CL5abkOEOxvUjArLHAnDg6F+c8CrXl8s
         MOZn0Zk+ER8RtETluaywcGZY45Igj9Z7Kb24ax0Jyt+d8dI77N89QRJQcUbH+xRl3Vad
         ZpMOAdueXb1tbALkdnZsxTy3HWW6SNUvl1aPPR99tVYLFySOx2YkNoSMNH1d6oj/sS0n
         lqJbXaumSO/XpgifI6E9IDvTAFpBPtE0wsw0it1jm3z3a/FIfusKG9wa0yDeJVQpcAT6
         L6OzVA9AdS+B5Ffthjqc8TVBgFpPBZlcq/BrFLI1EURrS3d2DUNsP1kbDn28fPP24d/S
         h9Og==
X-Forwarded-Encrypted: i=1; AJvYcCWtN3480mXqHtljltlhs4ri06JlXJJ5myh2f3QTRFVLlmJG/J2kOqNgq4k82xBY7lbpc/97ZrS/Z0AAfpfPdjlzW8Z8PIFrIrOtv4Lh
X-Gm-Message-State: AOJu0YxtMfCbjGitkSbU5aDsQf6MN5zG8dndFg4v+5H4/HPE9C/hdfbd
	O7NcXyS+jHNvJIUEH00xgevvLD72fkzUv3qFRZHFkAokCbFGQCNYxWk3uIfYrnduS71iuAPhOZF
	V
X-Google-Smtp-Source: AGHT+IH14wzfXEp103dUuJgZp/zY+2GhxllN2ig5sbIdAStPyKNV6CKDnd3ffI59yJ1MhhKGpGDD5Q==
X-Received: by 2002:a6b:4f0b:0:b0:7f3:cd61:32f5 with SMTP id ca18e2360f4ac-7f3cd613354mr35131239f.2.1719350712248;
        Tue, 25 Jun 2024 14:25:12 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ba0069879dsm1182080173.71.2024.06.25.14.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 14:25:11 -0700 (PDT)
Message-ID: <f65e8a9c-1674-4769-a11d-9a76076478d4@linuxfoundation.org>
Date: Tue, 25 Jun 2024 15:25:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/192] 6.6.36-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240625085537.150087723@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/24 03:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.36 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jun 2024 08:54:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.36-rc1.gz
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

