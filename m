Return-Path: <linux-kernel+bounces-366027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9343599EFDA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69AB1C22A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FEC1C4A2F;
	Tue, 15 Oct 2024 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yl1xxQy0"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9241D516C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003244; cv=none; b=E8wPIAwMqIY0tA8jgsxvfjOnEleliKSkSkN62jkyK+gQtZbn4GK9XrBs9mLRJXcDZUxNZCFTkZtESehSFxeoqfo6CIiVgVlZWVPlrJ7e4rJ6R1IOZDklXyMkQqy2xe9Iqf1H7jUFVUw+hSuiBc9rA81VuNDlAf2NdFVhbeTDe2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003244; c=relaxed/simple;
	bh=9j/iM9ZFOnXJ8Pq4EAuSjpyDlhqwQ5ndLD3SAv/tylQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=suhPYt8Y6Omkmta95BsylPr4SNWZwL8unZRnYSttKPdHgLCKgEL9MS+O9B4v0SHD5f22GySxopjyDZypIFjkXOETkudCGJMO+4/33fy1/UpPHkD0TkL3FjB+7N7tldWfPCdvdXHseRwbO57EDg++4wGz1jSdjB1UwQoICa0ilJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yl1xxQy0; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a3a309154aso19160845ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729003242; x=1729608042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dt0BlX7ghZTRqrFsNZjMr0j0wMiPy8jkYnWp/1A16kg=;
        b=Yl1xxQy0jFESj8oH6O3sPxlpCyPv1Ax4uy1984qU/WcuKbUWHwVC/XdXIyqjxllAZ3
         DOgi6JNu+IY+7w37SbEAij/qUiaxLxGlB4qoEa59NXT2H1Xs7gTPdZQhiWk5Ex62Qm9k
         VfqkcdHzbyKEZz+PCB96mVMH0CWKgW5+JC2sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003242; x=1729608042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dt0BlX7ghZTRqrFsNZjMr0j0wMiPy8jkYnWp/1A16kg=;
        b=BUpQd1WwhrFL3fjhRGB1H/zdhrnJcD6OXMP4Kv7LnKlweOpOI4cuarsHO5yKbu7Nhx
         hjO2+gkOIBNeFZOngdILR1hrPE3v5/3cH/LHSRxuixCYkXTpBxWZTrdEpII5Au6lxGEI
         on0wD+7x8MaIY7aKMNJkjOucpQLFv4/siiesIYZIbJM99wj+5Hulv5/557nLIi0OGfE3
         lSiFdYDyAJrRITPpq20YidBi6ecZMGUmnVz9c5FPnQ6vDscECur5qgV1IVd6TqJ4PqHq
         PCBJEvhGwN/N4Hy/QtYh+/fDY9UhZ+hdxB/Uacda6sZAHaX4dYWD73bwWpCCJWFgEBop
         3Mlw==
X-Forwarded-Encrypted: i=1; AJvYcCUepCGBM+Xct8cuPnqWcFNebIY3bRDnttqDD2r8ct+8bonRDCZ9XuuhYkNJkmFSBz6ITxoOim6Y62LZo5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHuYO/3EooOlLImffp0TK0laypPNolwoblZu+K6oXnGhJKXXNY
	EE7IyOaHroIzZ4v5POw8ZiVv+FEeIIsTR/t301S8SbMaA4VywzmONwVWX5IosjU=
X-Google-Smtp-Source: AGHT+IE8j3afbFFAJaUzf/DFsIbH2c/+ncqZt9lRW/uO0WSLuyNF5qt3dAKoftbomXfEkEynRLRBBg==
X-Received: by 2002:a92:cda4:0:b0:3a0:98cd:3754 with SMTP id e9e14a558f8ab-3a3b5f237d3mr136176475ab.4.1729003242255;
        Tue, 15 Oct 2024 07:40:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3d70cd07csm3412505ab.37.2024.10.15.07.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 07:40:41 -0700 (PDT)
Message-ID: <1a173476-ccdc-4007-adbf-812229520b3d@linuxfoundation.org>
Date: Tue, 15 Oct 2024 08:40:40 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/798] 6.1.113-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/24 08:09, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.113 release.
> There are 798 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 16 Oct 2024 14:09:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.113-rc1.gz
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

