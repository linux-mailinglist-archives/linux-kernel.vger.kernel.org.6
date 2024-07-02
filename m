Return-Path: <linux-kernel+bounces-238577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF34E924C47
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 01:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339641F2348C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E1417DA03;
	Tue,  2 Jul 2024 23:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EIHyJU9E"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3110F17A5B4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 23:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719963860; cv=none; b=Kzo0/t1YqfP68yr8Ag9ElzYF20xQgMIZOCekR5/QPUObMYlUM8LYHk7Up+oWr59QRoVYwkmonOvUle0A7APpscX7g7/tXY2h4pE5US2r1DZvH9srILiv8ig+Zn5gdbckw+9jUitm13hcyn1kIy+JLVYvOJiZDJLBq5dEkEagwYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719963860; c=relaxed/simple;
	bh=nugYxFvqkZ3GdtJPIrAFiDsnYPiIlN3gx7rBB0rx1kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhuOgY5TfpsgrZcQq+zJXv2Vty59+N2rvl0uREy7MnrGj9bRaw5vQGUAjhBv0/lZ082wJ0SL5RA/F4iwHvbP/ICKfzMxl6/xcbxOpqqa64/LiOXXbM9fkPN8bCmBB/m8w0bz/WfCaf/8tOi5cn9Xf0JxWsn0pQVQVhPdGzyx0Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EIHyJU9E; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-24c5ec50da1so693248fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 16:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719963858; x=1720568658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pm45MIjIaeWm4BhjkbsfpReUNUivy1UEQs0ZvejH8fQ=;
        b=EIHyJU9E3/Pdp81jNZe92O+49Aa5NDKbQnumuZX5YPtPgDV7fttXYCit+82ogGha9P
         gHzUqfnki9u8kbujp6EMYwsX10XFjm7W4c7DYY2MKMfynf8hM5R3DQorqJuBEB4pJJXf
         aborWGugO5u6mSh30kgvqeCq7HRyI/p7xsfGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719963858; x=1720568658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pm45MIjIaeWm4BhjkbsfpReUNUivy1UEQs0ZvejH8fQ=;
        b=JrsRod+SJtG3OxpyIthgVLzuQrDgmhDxQufzA+p7Jp9v57m3X9rgH+wc99UtpinMEt
         1n1P92gjhUos/RbsMBC58GXpNu6qf3iuddKf28GL7FCzh81QZzLDJcuaDZjnP7tUmcUb
         A6a8PZvRRHURcnCFpmaP+keofkASll/bB4SwnjShPc5+bPaSLj+KaV/wj32g0abbMwPD
         PeK9xyBbmgXGtWi6Y8Gl3HnjTX30GzjQ9l1FrlMzy7D/4usCEAwnwU8Lh39BGBvFeOnh
         3UUtuP6s0XkA2/YdWDI/VgPnkCscZURqQiw30hAzag7ragz1k4PEP52WZJoaKcmXID7W
         IE3w==
X-Forwarded-Encrypted: i=1; AJvYcCWxCFXraJkTsckD+2crLrCuIV+drYWQQrnyEQBm+UXPfK1ensR7MfelQ3DEvCs7/ZCPRhiKku7QzvgoTpI5xhqZZ0vh7+kC67ZuBWur
X-Gm-Message-State: AOJu0YwrzQX4296hkAliz90o/EXuYp5r6jrRqv/vm6SZIujWb6JPDu8p
	6/lasfufCUBmDk6TaF40UG4bhCbj4510ENr0W5dqigtYa7h5ot2DQ1fVWh/0ie4=
X-Google-Smtp-Source: AGHT+IGmqmuHlWuvkaXE07Rh5CKoFmBmZoQmtyD6UtHJqCbjW06Ub0MNM9EHQlJGbJkxvCbgPsH50g==
X-Received: by 2002:a05:6871:24d2:b0:25e:180:9183 with SMTP id 586e51a60fabf-25e0180af8amr2263497fac.4.1719963858211;
        Tue, 02 Jul 2024 16:44:18 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25df77cef10sm434167fac.19.2024.07.02.16.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 16:44:17 -0700 (PDT)
Message-ID: <bb8f0689-0989-4c18-bc75-f73ce6743c22@linuxfoundation.org>
Date: Tue, 2 Jul 2024 17:44:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/128] 6.1.97-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240702170226.231899085@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240702170226.231899085@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 11:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.97 release.
> There are 128 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.97-rc1.gz
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

