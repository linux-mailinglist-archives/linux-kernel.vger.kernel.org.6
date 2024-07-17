Return-Path: <linux-kernel+bounces-255380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EABC93400A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219911F23DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21C21802A5;
	Wed, 17 Jul 2024 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eMcV0Fg7"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3920A1E526
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231634; cv=none; b=gdWSOD8Lx8HdGp7eksc6bJaVrl8D3UstLXJerfMmCmSFrR1ZfvOiCXvg6qZClHPZJj8mNI06I61cfxzjgvb0p4DMBh9yy0K0/d3rivQVA3MezesMN3mivrOtM5wdfvJjaezfvuDjbnwAN6O87LGLsRX5CEBTEhcaF+Xi1exeGB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231634; c=relaxed/simple;
	bh=MBMtHLJ+DVr4ag594rJE0YlnuRz+2AXsrDuPKfiYZqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbCtwCewCoN74itEjh/1joIp9pXfMmh63wzbbBl3KepUridkwcgaWaBLFAmiHsRJ+ThWhnEqd/JbGKGT3r57uF1/qmOKILyzImD932xzdxdAhFB4uRF8FJ/8LEcA6/A3xsQCRbyPuI1m0xOHoeCNH/IWDNVOQw/E8FlSwb5To64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eMcV0Fg7; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-804bc63afe2so4355239f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721231630; x=1721836430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obXgQINbVfqbboodSk/JMK7xhpmmi58PT/EBrAmmKbI=;
        b=eMcV0Fg7PkMfMvQ+D/4sNQMIasI4k+6DvkoUTL8zCaRvhJ7sy6Fc40HWgic78csol6
         gCB5lNKqONCrlG3hSU/DaLRoa3amyXAhrkB+1Ohh2DF0y8lBg8pjTQN3niP018xSHG7E
         yAPAn3Z6KaDnPcq1REcOVaP0MSkEuHOKbK570=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721231630; x=1721836430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obXgQINbVfqbboodSk/JMK7xhpmmi58PT/EBrAmmKbI=;
        b=Axu0K66PwFyJPPUeuHh01v3jg3vpNgvuzMOu24BMIuVbCPJbaqXCekDgCzaikOPVMD
         vPiMHXi2DnKm3xm2TyVb+6Iwjx99wRgeb7J1KCX37nuq2jrT5aUKCiTKoeE+gNGhIC6J
         dMIQVioQ1Le9jOM4rUt2zAc/6FSrjQPt7/2//sqdFaFMAJl4JiZZ6vqjkWDqKeG02RoB
         8pFoms4X0iy0m+fbhCQ7gHn1esWBopX52cQio2O34lKah0WMfzW1kpSkLNWqK1P61lM6
         LxVCTt6CXe1XgNBZ4OiOgAxNjJ6qU1yQuOGuEpCE8d+gdv8oqu3xF1UW1vLZfjjBQdJx
         pV/w==
X-Forwarded-Encrypted: i=1; AJvYcCWyBaRs/JYXDGSqWGIvChYZtWuGp26h1QpU3nnw6/JCDFa+HaCLEM2F+XiWwXbZWaZKfkSflW28UbkHyhqjBH242UXhRz8IY0AWklcC
X-Gm-Message-State: AOJu0Ywt19U22hBvnhQvqOTQHqg7J3abO/7x5Fy/mQWAS0yyw3ryTBiS
	cQvVR85BbHuLdXEQjU0RttKD1aZ4w65D++rlkPVjuGvworB73wPIYMcadrZPx58=
X-Google-Smtp-Source: AGHT+IEFW7pms3EBMhQHP3lyWtsxOEdybprANsdD9ByPmbsmX7K4OKOQoHB3AaTr7G3d46U0Wi+Ngg==
X-Received: by 2002:a6b:ed13:0:b0:7f6:85d1:f81a with SMTP id ca18e2360f4ac-81711e195e9mr150596739f.2.1721231630317;
        Wed, 17 Jul 2024 08:53:50 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c210f21da3sm736469173.113.2024.07.17.08.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 08:53:49 -0700 (PDT)
Message-ID: <ebbfa660-149d-45e0-a39e-a267095bae39@linuxfoundation.org>
Date: Wed, 17 Jul 2024 09:53:49 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/144] 5.15.163-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240716152752.524497140@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240716152752.524497140@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 09:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.163 release.
> There are 144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.163-rc1.gz
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

