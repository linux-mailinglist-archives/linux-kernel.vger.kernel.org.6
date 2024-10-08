Return-Path: <linux-kernel+bounces-355951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168A49959C2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 00:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 625EDB22E5C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34370215033;
	Tue,  8 Oct 2024 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FvTdkP+M"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9D4213EE2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728424992; cv=none; b=SEIn/huJhzPdVeEbshacPJNiGODvoNL457UtzXBTvK6Gka36cnVHnRaUr5/iN1iHx11NgPofJ6cMWbPGSSjt1Dt0urmuT16kaGXuK6EIPyh5C7bs+ZNc7kVUZ//sfgRgxak7mvkQkxZwTT4RZnoVSmVIjRuj9h1Ljxp+3M2CUfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728424992; c=relaxed/simple;
	bh=BXAmuJ7ILq+rT+k8LO3lE0/nVu01ECozpjquJa006AM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CVReZ5DTXyxmqgFWx3FXBSkAyYfGeAYKM6A8ijuD9OTRx2VTw6NkrfcjzlGfpkUHOAr+QHZZlx0SemGWNTWPilHVzAkk00CianmyrBPqyEqploD+gpklkjhv1utkp0FDs44v6FBjLoPP9JCkRaOQgXUC2pm+by240WDl93BSSE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FvTdkP+M; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-82cdb749598so260415039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 15:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728424990; x=1729029790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8k/h1zc1if6v/PtO4/Z0OMrVugcpBclAQ9weFD2DFTs=;
        b=FvTdkP+MnPJQYu87Gkf3KG7l+uMDDNd3Xz/q1cunLFadjCr5ckCZrAeCoTA9l+d1bs
         p93dn09mo1Bpf9xB+pwBWoR/7helGIDcHFoq9/VrbbR3S7uC6hkEnyqogV2qvjYCKBft
         3/G1VAEIVC1lDCQe8zMKr08TVAB64NULVpDFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728424990; x=1729029790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8k/h1zc1if6v/PtO4/Z0OMrVugcpBclAQ9weFD2DFTs=;
        b=ql3iQS5f/KsRHzTP6XEqQKGGdfAO8Mvh27xLZKW7Iwu/fEGlkYOEQWbtJY0DtTQshT
         bL6OT1FotsGkJJm3TrfvGiplyU+YRcpGYl4AGBeqcZmFaaL1w7uyCCgGXHMPc0QcCyJa
         CQh2qidGnWZhhBdvI1z7qeYpstWn6Ot0OkVKWBaRwPXD1XiGpGLd+bWMywQLNMRjVhlK
         c3TcDYWRCVSWr0FFNloU+91b1DvVHZq7daIT4ZOlB26XDgPx7N1Kl6xnmK5rVPB7A86k
         Wc793RDXMaceSIbVFmVRrDsnBFeZydLbIPP4+NzS5O/QHUOLKYYhIkyZjY+/Qkcs5ysC
         /fOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCV9YlGZBN4qK74oovaX2Qrf2sF3l1nwAvmLngFVz03MN6N70UPb4h5RjRQWHOTmfgwYYbdasmOifsjKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmkDDH0dtqzzBnanL70bBRuLRbw9lIYGd1luE3q8Bt8uFvBqhm
	9+Ma4Tszf1eBMj4g81HBRWKz5wU83gjO6ROF1QJe9YH3JsW3MhTeO36BchORL4ffWBxaUPgLgPL
	Z
X-Google-Smtp-Source: AGHT+IEbwfQqS1rnCN/fqKqbgzAthDXhnK25PIZwnEuU6F500jfrAspi+MkyW7GIBwdWt2QIv/P83g==
X-Received: by 2002:a05:6e02:1a2c:b0:3a0:9a32:dedc with SMTP id e9e14a558f8ab-3a397cf78e6mr4402395ab.6.1728424990268;
        Tue, 08 Oct 2024 15:03:10 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db7db303besm1461620173.107.2024.10.08.15.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 15:03:09 -0700 (PDT)
Message-ID: <b1659a9a-66a4-4a07-a76a-31222bf8cfc5@linuxfoundation.org>
Date: Tue, 8 Oct 2024 16:03:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/482] 6.10.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 06:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.14 release.
> There are 482 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
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

