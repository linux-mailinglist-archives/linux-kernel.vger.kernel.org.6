Return-Path: <linux-kernel+bounces-342591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210D69890AF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517A41C210EC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9FF14375A;
	Sat, 28 Sep 2024 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GHSAICwu"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B352940F
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727543627; cv=none; b=FU/7/atzI7P/5JhTZJqpbRHDszAb9D61BZtdkVweWRoAN9b6IzZMQNVLH5jPGTS1NwB6xG+YQUCk0GIPMNeZRKtuFdWjt0b5QgmudktlIB7Bc4i70PkK/pfwolJt5nnxDkPdDCpchn6Rr+71zTtWR9N828JU112ZQ7iUqNFWEO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727543627; c=relaxed/simple;
	bh=WIQH7YpKqbnkP4VdBnh61v4Wxod55IsldJm9tOtb6cA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPDya1O6qVafKYHmZ0vkBPn3E5annlz7RJmkjkFpdy8BjBGfBbbB/QoDP/wKxmevMukXyWyLotiTDsWxJFGLK80/wNzdNU/LxHdwhtmjKh/fMTLhZTFOx0BgyXPPby9iHt+ZlQLZGx/QSI+iuFx+LlYKoqe4LcAKRQ6zbA4VDU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GHSAICwu; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82aac438539so157342239f.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 10:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727543625; x=1728148425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5iMutNFUHSQThjfKn15tCVspMXY8vAnhYmH8RW2rYcs=;
        b=GHSAICwu6W8knigSqUQEsc+ji7tsr4rsZgXob7oOpJxu0xbwntH2XU/r6ehDUhI0ir
         K/FMBhtS6kpS7d5U7N7LJ1J7/3OQMKecjw/StYdrePU4Xby2TqP41FCXu7r5WXmQYrCe
         UKnCGeLtXuL0l+rMD4uVdHY2eFuO+l9U6hAkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727543625; x=1728148425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5iMutNFUHSQThjfKn15tCVspMXY8vAnhYmH8RW2rYcs=;
        b=O75RvYn2hLQ07VAkCCX5788GTbxK1pz7b1KxboZzG6XdWWJ0rXCoN50ZPvmiT3pser
         Gq7fLjyDWWr9iPdUJzRWbdSKGLXRQnsp64OTfp8afmALbajVW2TLJbP6kw/p4Gc4UDJ5
         624IxBrsqqe8gYFEdBxDj+tkZ16yZxHH0ZB6koP8iE8DUUI71Q7Qoc8ZIgfEuo1BClvX
         +g/lEUrx6P6FpZVzkFfVWR6HcoIoV65RgWvyuzYgEtbbjtWxUVaUWxoqEhqmcwDWtHsy
         +/yEnTouT/4wjvLFJQIQKFd2KN0QuVjvgy1nXLuOzshnlaYfjwlRbJsnf5hzGNCOcYuH
         hsPA==
X-Forwarded-Encrypted: i=1; AJvYcCUREbbVh98F+L9312eLHFJnHWV7IKOqzCTWrsXC+R2ARI1HGARwixwtuWVo3zCnIFnQq7KrUFVkDe9CRSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAL0WZHEY3CupMY94JnjBI9ZUphGit1ubazmIKS/nQmJs3bNOd
	eUDQ1QUMtOF/TruII6QS4HwE2UMcvt68o/LTZR93P9MTz9VDjc/lILM4jzXO0AM=
X-Google-Smtp-Source: AGHT+IF3yhF7j9IwDBNWhxbVESzMplB1z5HLILKgeANdKoD+YzXDfSJbOVY2WnSlkPZguF2UPU2Rmg==
X-Received: by 2002:a05:6602:6087:b0:82c:f30d:fc72 with SMTP id ca18e2360f4ac-834931b0142mr528932839f.2.1727543625268;
        Sat, 28 Sep 2024 10:13:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-834936b4e97sm126980139f.6.2024.09.28.10.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2024 10:13:44 -0700 (PDT)
Message-ID: <b13b2120-bde8-41df-8299-37fbaa9bbba3@linuxfoundation.org>
Date: Sat, 28 Sep 2024 11:13:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/73] 6.1.112-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240927121719.897851549@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240927121719.897851549@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/24 06:23, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.112 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.112-rc1.gz
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


