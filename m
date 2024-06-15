Return-Path: <linux-kernel+bounces-215654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A40E909589
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 04:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C4F1F2259C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 02:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F167D749A;
	Sat, 15 Jun 2024 02:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RJ8nk3dv"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC785256
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718417355; cv=none; b=hD1eQT27mFVgURDwWoKMaItive8uwssZKvZqheAZca3G4iIBFO8JAQPre8ugJi3JGTDx6cZKkXjyVuUjhmXWY39P/28QgNp8IVuWL9j1AHsx/8BLZMAh/tv/yDcsR5unKYGoCqpy3E5GrMTb7AE9pg6DITigy5LqnigMNDhS2iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718417355; c=relaxed/simple;
	bh=Bl1NUlVeOWuUMu6QmHn8l+0I/dzadz8WMKIVI1FfzTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YbzyuCyHCrvFnfY/8BeiRVeojCuCTdnkHXTlZw63mW42zOUnDOsEu9956ZkjzGgBLhpel0uJ3b2wydEgURapGxXsOUNIBOxlU8YX5ncKGj2D7EmUeF0AHft/DPxW7/ANdTo50raKal4dUsqSDNkFoQsdNF+vFF3nFWBoFgzqmzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RJ8nk3dv; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7ead7e95c91so10585839f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 19:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718417353; x=1719022153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/AVLkF2MndaOt4rbGUZ4MbY0St7TEQ+T/k21n+LVP4g=;
        b=RJ8nk3dvvKYGuTZaHfVJmeZbsJ9QX1E6NHSvqjIlP5av/3fWQ/7Ztvt5IwU2kdI5VZ
         rO1CETJlb+NohGf32o9rrCWMkE3bZeRJKmVJ03knC4L6KY5dcbbZmnxMDFasQD2J6by8
         vVa0TOEJW5EIPhgbjYsibcW4QeVJdVt+ExH9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718417353; x=1719022153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/AVLkF2MndaOt4rbGUZ4MbY0St7TEQ+T/k21n+LVP4g=;
        b=afa0hDcDMDTW98FumVKsrP733q68lRwKQOAxWQyMQ4I8ycbkY5cR27+g0SxdMUMtT0
         UtUzTc+rqno9zItCLxgU4A4h+wxOPdvDBxiLPSsBf2RGT1ZoHGADYvMq/d+/2RZ7Hnhm
         E8FhGJohEtVDLCgPMd8ZhCLj+I78SB5vKzwdNqtxK2Esr1mC9Jy5quu9flOZsLxByGbI
         o0X+pE16+/leFIch9E+XYO5glTD6aa/qcw1W5C3W3hLVvuImN7ADUC05XTewq60ygJ5w
         dYo2KXyyQC9TCYPbwd4X9z8RPRszKUuqh+zQ7ZrZ1cCH1RMl+/PbL0zJDPImjnIewvPz
         ssiw==
X-Forwarded-Encrypted: i=1; AJvYcCX6Jpfdl+ZAkdZhr4FcM4zgFVRGHoON/PNqG7luIYLt0bnFStffEj9oV8Mm+KcyR0fDCVtR0EDaYB8xQXGHATwaA6MxX5jFzxPwPWmG
X-Gm-Message-State: AOJu0YxgZ7R7l1UTMwBjGZTAdsvDZA0OUWqRMGfArjtZQrbW3kLgo8+B
	YwgdRdbAOOJ+aGZOuIwSVMx/ygy97ezPTnU9C/iuvV/8momErIOzqs5D0DUIWeM=
X-Google-Smtp-Source: AGHT+IGtnUSCyRuHRSzlM8/24/qqOYSZbzK+R5CzvfHQKmF0Tmr39UIsf3EFxCjz4DcL+Iw1thc44A==
X-Received: by 2002:a5e:dc48:0:b0:7eb:6a6e:c830 with SMTP id ca18e2360f4ac-7ebeb627c7cmr445203339f.2.1718417352683;
        Fri, 14 Jun 2024 19:09:12 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b956926b25sm1211310173.57.2024.06.14.19.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 19:09:12 -0700 (PDT)
Message-ID: <9af06914-b5a4-4667-9e9e-b2ad8319977d@linuxfoundation.org>
Date: Fri, 14 Jun 2024 20:09:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 000/157] 6.9.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240613113227.389465891@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240613113227.389465891@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 05:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.5 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
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

