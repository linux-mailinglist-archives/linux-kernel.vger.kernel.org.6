Return-Path: <linux-kernel+bounces-556522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3D3A5CB0E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824793B8E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D48F25CC65;
	Tue, 11 Mar 2025 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="djfMfHx2"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B862940F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741711544; cv=none; b=gkDcjMY/arLMY9P4W+dmAd8zFnvRYxb1a1ywj5vzn2z4qtCsvLPA1D+YPXYGQ4bTART8OMZJI+rruM/Be3VF+QgPgREFZgqHhUM/XVJgk0R1mj7cqSqOD3+cy6RIovPS7iQKCZQW1VpCNWrpidmdtDYeIFAvF6YSWZxQn3mIDfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741711544; c=relaxed/simple;
	bh=dMfpeTf/NllZv9N3DyfOl2z5YpwpaZ2Szk9XzslUpQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ak25Bp2wS0KfQ+NKH7VSHQUGk4nE8pXGthmUTzNSllQIChCurv9t+UWyC72K9b1f60rQtkFfVCJrUF2OjPmrRNu9Opb8hFjNLuMUS+jiPF75g/8YpDNLOD/0ZL4v9nAuk4Kp4NsOmpru/QH/yVZ9vaoM86txPksgpBE76Vk8Ht0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=djfMfHx2; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d04932a36cso53826045ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741711541; x=1742316341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vLx2WoIhJiBG3bqAkGfbCh91LVddIJWiQd12L4pfcIA=;
        b=djfMfHx2fzZn2YHtjhqj/SWCS/0kJ4pGiYqYPVEXA5lhWkbref2BdRVQHBWs9pfCFf
         ORFXnYiODlBAA7OkFpzvdDZrCJg/SPw+BoNZ+FVTqJu11rJBy95bep0SiNJrDXeLGaGX
         njYC2x60z7EGqX/WNfWRPV8zIac8TphLTNdCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741711541; x=1742316341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLx2WoIhJiBG3bqAkGfbCh91LVddIJWiQd12L4pfcIA=;
        b=qOy23yY8eB3/1IN8r+/wQc3VkZM8CySB++/MYzx9YYqj/06ENv8RWyGHYb09nG5km/
         6/sp1HgzFZbSYWoKorhS6kBroh5Y+LpVeqxDwYhmQL19I1iVxLBcn/RdBgEq0EGGYjNU
         jQPa3jOsyGXPC4zovp14q4K1oOU/jneZ16VUgDgxpmYc1UN8jphwbQQEIoTrU4pbjzNG
         U3mk0wtoRCMFehY7Boox97yagafr9kG9HuBJ1UF3a5NPOGW6KgTGAbdpihWH983VyQx6
         PwEDgmfT7Bs5wL6Bukx9OTcl0sQvFspNG+VGL8HG4bg7IN/tPHHhFOCNEurlaA2ThkaJ
         BGRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVvexsUBxxINoQlHKDet+8qJv0mNuUiNSJfDrM2fU9ydmubbO5v+KqZ46fHbV8o1TtMZLBe4DB7X0slp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP7+A8gcQ85t1vaCJVh/fUpIzQfNWITqR1RIkVoNStjsxLVTXD
	e7vMKjE2TbmNB7QP/Qja+g5lYRTetCo+bQjnpaIiq41Y9zhEUPonR4dcLzb2ZQg=
X-Gm-Gg: ASbGncsggduCRiHO3169ijOzoegOPv29bXdQ5d+uJuYWTqZt03WNgmnmpm/uB9s7N0e
	u9F6aL/wuVBsKlcZb74YGsMNpaSYTn0iwnO+AavcZzH7cbqie59KbmcYqqCbQXnpQOvmuFEunrW
	OOU3It3yNW0eln4jzXgkBfKAYk1XjpkRODufko+h9QEvV4vDBdCu9l2RM/I49ocYoi2Efebk4rO
	vauyWnM5CAAGe06Bd6ZWR7d+ksT9e0LGmduqwOR9dQ+anQZg6qTv9PdZp+z1HxU92zFSOWKj1gK
	JB85sY8QwNBLVEJjv7Yw780VHgr/jMsTdQi1/hbInW2YYjTiYueVt5g=
X-Google-Smtp-Source: AGHT+IFNRcfQzm6xuksYf/8LPcPtWo+WVv5uKFa9PKonyffFvWpr2Pt03YoFcJoQfra+HQB8yRxDJQ==
X-Received: by 2002:a92:cdaf:0:b0:3d4:341a:441d with SMTP id e9e14a558f8ab-3d4418d0cdfmr201635105ab.10.1741711541121;
        Tue, 11 Mar 2025 09:45:41 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f22fa56259sm1456209173.2.2025.03.11.09.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 09:45:40 -0700 (PDT)
Message-ID: <e1be13e3-dd14-4e11-8fd5-6d1e2316aa34@linuxfoundation.org>
Date: Tue, 11 Mar 2025 10:45:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/269] 6.12.19-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250310170457.700086763@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/25 11:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.19 release.
> There are 269 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.19-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

