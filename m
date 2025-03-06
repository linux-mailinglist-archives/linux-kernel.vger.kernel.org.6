Return-Path: <linux-kernel+bounces-549255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77098A54FB3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13263A4746
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF76A20F071;
	Thu,  6 Mar 2025 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FAQtqUfX"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918AF1FDE37
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276473; cv=none; b=j8p3WWXy18op5s19dO8adU9sPQwt59o6v5YBNsNZt/AAxeK1dwtYxiYyHicE+agyv9xj5n2G667vlBWwd6v77z1eBqwXoKoN01Fvo7+vC3mnS8x6a716lnPt52/QCAp8+rEvNwkIE6CuVwhyFgGLraqQ/3WfQQey6g+Q8f7PGuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276473; c=relaxed/simple;
	bh=Y8K5cESscjaF6rF5kbITcV9M+zFFDeiGbZwejQ8hVoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnjupB3OGDBQbSmoI+CtZNR1p+m44s/nxjKmjDTOLn6jnU+WEBi1IcPZ8HQ0C4Ik6j0sIPqQlbg+lIxG60fYC29Zu0/JGT3Y+Fys2KYpC/LAXfltUA43Kj3yxyzXNiNSIb8l+m2NvQJim4JdKEndpj501G/OcxBXF0an9fNiVOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FAQtqUfX; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85afcb0c18fso25361339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 07:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741276471; x=1741881271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UvOdZWrfaIf7exFCH9L/y4MUUS5qf5A06Ts9Vfm5eLw=;
        b=FAQtqUfX90XrY3tB3vnruqTPFNgMJDFtuN3F5CSktNqdryJVXPkosyLy5cuI+t0mus
         3MLFlZnRsp17dfjhrogQUCRCdobkuKPkaLbaoqlSt6cYK0Xs6eznZlJ0cg1GabkZVcDt
         cwDDpAsfe9BTDkBtj2pmziO31+oUV4c1q4apk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741276471; x=1741881271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvOdZWrfaIf7exFCH9L/y4MUUS5qf5A06Ts9Vfm5eLw=;
        b=wsRx96322iEuKD+wwXfVIyvuXJlWkHxv8Aen43TjMFU3b4jZP/GjYcSIjjY1be0YVJ
         hXZr3Ssf5Ld08amRxBIQMz3RyYvZHf6e9mN3UoK5/+O5NpQoKYg1q/o2oiuvL2Af+Kjp
         R296vO+IilC3vdYgHYMdSOy0qgisMpmXKefc+QLymLa8vLdIKHCR+HYkAez3OE8b192z
         F2EUzK+FFF7ORt9Zbl8m9Ar/7EX2HfTBRlWa5UCrQ4aCf/L1hVCxz9B2fU6pQk0j4kZn
         fjxl3CWtDKtUIkoBbavwdEtGbJ+KEizWWq5iGIc17njxx3g1Q1A8WxtITAIyrgqVDFTS
         oe1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUa9pv+ShFCYldC81B8T5oRjb/M0oDZvdzNI47aZCdc2v0l1uRY3Dvjk+qRXYED8UbV/3uuA3I8Pif8VqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjdGRBz3GuABCovNhg9BpzwtK5TlreKIVAUs3KMr+r9AHeDGfz
	raUx3CUcpC4MyM3lW47hpB1Umpvyd6TOphmLmaP9Rb/dgGLAguiJNehz+nqSbak=
X-Gm-Gg: ASbGncu/c8xcLqeI6TtthbrfkAeBfRucmo15IWmjY6aMAZn0GNS0lrIuKVIP3TCbM8S
	Y3G8MMd7CVucM4EtV5C4HxlNBOkttJM7vnvnPpbpY1I2m0PSyx2Ua2abCaFHULbgJ+HUvcqJq/O
	svTxA6nmJyiVBp1HlJYSM9zZUxE1SNl7T4LBEF3aoHnETP868qSbb7ChO5dc40Il9DfnTFOeplg
	tPCLIgeJ6h2HsfO0L3NSPnr9nJmvGkWXajUL9ftcLo+8seEF1ZRb6/JlzcSxor5VtI5wiEo/sI+
	0CCron5XRwZ608gl7lM8qi15HqTSn1viCQkdkhxjGFVgApSukny+0ik=
X-Google-Smtp-Source: AGHT+IHLDBt53t7ndm1iVGlgIfmFiG3NsTwS5qxb6ssEp7txk9g51NwIcfyHhH9X4AvTQef18vir2w==
X-Received: by 2002:a05:6e02:144a:b0:3d1:79a1:5b85 with SMTP id e9e14a558f8ab-3d42b9a3c18mr86895115ab.21.1741276470750;
        Thu, 06 Mar 2025 07:54:30 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f209e15550sm398211173.39.2025.03.06.07.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 07:54:30 -0800 (PST)
Message-ID: <11011f63-e614-4a23-8d9e-7aa1387ec65b@linuxfoundation.org>
Date: Thu, 6 Mar 2025 08:54:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/150] 6.12.18-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250305174503.801402104@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250305174503.801402104@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/25 10:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.18 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 07 Mar 2025 17:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.18-rc1.gz
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

