Return-Path: <linux-kernel+bounces-223556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E919114C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966761C21E79
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B357185642;
	Thu, 20 Jun 2024 21:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="La2UHS6A"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B3284D14
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718919545; cv=none; b=RV9Rq6jRs+FJ+kbwFOF6BNuOb2T/b1u2i5qMWajh1B3d+P4sdDoZKnCK1DRVYTIPJHTqUbAzo1LZnfoNyRp3zVfHGXaPhbuGoBe62uRaK+Di/s7ZRDWlVDVaXixPB0lNxCdTL5OcAFCoN7LA4t0MteMCsKe3W8OAGwoirF6SqSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718919545; c=relaxed/simple;
	bh=4eUDbUYwi0pZS4XXlB9XJEj7hUZz/ZHaKyzWK04Nkvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9+ippe7g1Y6kG1XGv/2mDSjx5kbaOwyans95OmLk+TPSmqiGYMgMwzkcNWX6g2nXaFNoIU4+LwynrYKJlcC2jsTaNwCmYc10gvU0mXtOR71BS9ilxpp7/ANoR/q3XKpAaTNIa/nRx/DVMjQmM/me8RIxzCct0w1GXODuZvPHOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=La2UHS6A; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7eb41831704so5828539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718919543; x=1719524343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqHqvsSXJkneKAj++iJItugXBOlFHRP56AEPjUJ8ns4=;
        b=La2UHS6Apu6Nnrh+vAhMZ02gMsxAqwc6jYyCN/pAlKHBnoAveFW/GnK/H/pRR/FkvG
         wH67zFAxf9RIRmSQZxhbwxTMzZYO6INAPuvWYWuS3nN2pi8bLa7ij+MiM87LJC5pmY7X
         7MRCz9ZW5hU2E5XfVCtvnVmG75PYW353iBVso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718919543; x=1719524343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqHqvsSXJkneKAj++iJItugXBOlFHRP56AEPjUJ8ns4=;
        b=lwW+TKkWW6gIPPhDcANClZNHOmFoiReT9bWjtU7ZAmrvl8yUPOjXNJIvbnH/zXMEZI
         LpwzImXYn9fFzQfdTJCLxGhQtKOgaMxX18ohwGPle6RC35NLLgXrXWy+giHPDEXBTkaB
         ZCs/unM5VceDIkBXtW7SiPQteFW2k8F3m2P6+BlurBTBgUl07tVHKOgrHX6iqY1wSN/5
         dBkZS4Hu+XUvO7ryRqluYXzhfQGoVi/niq92nXhKnp67BNHX92sYmMYa3SFz8t1aYXTJ
         +0avWaXuRaEdSoojLBkE7CXbduLC92kCAyOFpwtQSI6yCdOeVOQTndAME4mTVoCj7AkY
         laew==
X-Forwarded-Encrypted: i=1; AJvYcCVAaQtytyYKekxHo4xsXkrOd5o8wTH7x+nT6w3gZmO+zv1VN2+p83TqWPS08QBSkHpezYubkHbT+YYSqlFIsXkC1ye0IKD8FX79iJFS
X-Gm-Message-State: AOJu0YzP7XrFJycm8MQcAhIBk3f9TFg9WeXvV+Fwr+nYKmuoYFLWt6g+
	bHV5ok7U3/2CMgX4lOZS9oJwPjG0q4VZR/zQcgdqwskblqgnG1wW0yhAVPDx67o=
X-Google-Smtp-Source: AGHT+IG/MKrOHHu7bE0kz3/5P963pbzGNqZC6AtUsEQh8fvGhgnXsQm99vnIjQE3jJmQk8fO52HZGw==
X-Received: by 2002:a05:6602:3b84:b0:7eb:73f1:1357 with SMTP id ca18e2360f4ac-7f13eb9a591mr706580139f.0.1718919542734;
        Thu, 20 Jun 2024 14:39:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7f391ff194dsm3069739f.23.2024.06.20.14.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 14:39:02 -0700 (PDT)
Message-ID: <7475d8c8-318a-4f8c-b4a7-c2a0be59d304@linuxfoundation.org>
Date: Thu, 20 Jun 2024 15:39:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/217] 6.1.95-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240619125556.491243678@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/24 06:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.95 release.
> There are 217 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.95-rc1.gz
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

