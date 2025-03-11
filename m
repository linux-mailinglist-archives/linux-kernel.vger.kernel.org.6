Return-Path: <linux-kernel+bounces-556524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B146A5CB18
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3FF3B0664
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B45325F987;
	Tue, 11 Mar 2025 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XPjj7huh"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14F825BAAD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741711680; cv=none; b=RBO7/v7x1d0ZwjhxWKGjtVLYXEii3SOmdEbV5vVwhMz9/L/fYlp2Ab1JjrliyZH1q/nSHXQsVvViW9cB89rqlJ+Kraw3QLodsIttms+rbMFmlv5uBOPrQMdTjY2TxT9LoZsBt2u5sCDwL4KU+rWvvwo/slbTqqgxd3i1RBu7qnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741711680; c=relaxed/simple;
	bh=ltNZnId99TBG9+FOkJZg7yKI5tAEjGEUIIVmvk4BJ3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUJjHhxY94MpgmOoNBb932kUdKmUYi9M5V0QdQXemISl0kq9EYNmv2w5DQQzJEU64Ddv/hbhJG76n4ZrQBbCXAIQaKQ5wSMQ7FkMCYUUYaYUVN8CXS+lAyCZc+84UlpHJSiS4+Xdm3zxvZL6gpk9rUJmIEiCnMFsePSAtZpf5+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XPjj7huh; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso23089595ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741711678; x=1742316478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eIelccZHQZk2+ndDXbKBajYZKbjgA8vG2Sfh/B1954k=;
        b=XPjj7huh0UWY8rBTAPtUrrk5XGDnbNtWe/3/Sc0NJQMMON4I0ifrOBcBsBnSTTt0vd
         JED+mmJHNTsACoXCJD764houPlEs/lUi7UUMdJ4DFWFFhSS209GbibSTGuO5JIIMaWgL
         jd56XhOPhuwCfcSbDj9Xx7AnmA6NpUHXfgOZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741711678; x=1742316478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIelccZHQZk2+ndDXbKBajYZKbjgA8vG2Sfh/B1954k=;
        b=aNzsKlO7Okw5Q77wd6ssxfdqOP4hhNgVHq1Y6fKXqmzb2qbv5mUk+39JHe09Xw3k7H
         kiM94KgeQrFtEoaZmwLelYoOtxCpmr0Rxq0zxPAq74jOaHt568URze1b2njm7N+vcvn1
         BGcXRyDkaE34WGKgVRFEaWYH5ZLAptY9r01niNWixZiDGyEfxSsYBkuYbKvbpZV37Tfo
         hNwo2jrtcEDqL2zwrpl5aAskZSgcgOwdwuR8YyPGWV3yV9zlx5D2xMtLOrL1z89jU43l
         /Y3avfE5c232u8ibbE/qzeLOowC/GWhZh4HTPYLRYdcov+W3nBbf1GHKFmaImw2nNxCZ
         uXew==
X-Forwarded-Encrypted: i=1; AJvYcCW+oDPejFXD4GatC4m7M1RjQHdmJUoWEtK2ijmyI4qu95Gd5zUJ8wiAlSRQEujMAw+mcSdlrUpnU7BIN3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxjh/kolqMiCenD9rZu/1kIs3csIE/9TX5co74qkcWuFJefyHO
	yO8cSRD5zErZY9/Bwl/cJFxg2L/J8w7nebFBQ38AHV1u4o315unqL6uLh3M1xbU=
X-Gm-Gg: ASbGncv4+2R8N5piEPBb8EJ9iKBRSspYV3fVRB3WpeFcQbLXTPfICN5BDozJB2gWCb1
	MQBFXKii8hWyGD0YMDu6wZ+7uWfmCAe1eh5la9yeZxEtqikSSYH41xaRgBtHfPfqbeFjyVVvuv1
	dKhozVr66eVcxogvgp0MnPc4547Mf/N6Cvu+7zd0Eq+qRUJwPoCH9XzsHTGzHybR+/hN+6m1f1L
	LR9jogfoJREG98XHYidvNKBZLDJ7PK6OEzOle/zulNkr+H9VJZKHjpLJwg++9euAgzVTuqHD+go
	cAnUVdG4wUq5bue5e7EwAxVROsDwYPWJIU7a+1fbayFtGeBcaNFWj0D0AAjwpi5SzQ==
X-Google-Smtp-Source: AGHT+IFDdRp0z25FQZ/a/6jHqnCfBwxjRuZ+/4KP0GXCpPYNTXRmWcdeY+uBSojv6boITzpPUPC1iw==
X-Received: by 2002:a05:6e02:2142:b0:3cf:c7d3:e4b with SMTP id e9e14a558f8ab-3d441a12ceemr239262975ab.21.1741711677772;
        Tue, 11 Mar 2025 09:47:57 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d43fd73234sm24748195ab.0.2025.03.11.09.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 09:47:57 -0700 (PDT)
Message-ID: <fde3d71f-a152-40f1-905d-1aadef6175a9@linuxfoundation.org>
Date: Tue, 11 Mar 2025 10:47:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/620] 5.15.179-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/25 10:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.179 release.
> There are 620 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.179-rc1.gz
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

