Return-Path: <linux-kernel+bounces-450040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBC39F59E8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 23:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300061893403
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BC61F9415;
	Tue, 17 Dec 2024 22:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XGyr2pMH"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AC41E009D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476319; cv=none; b=eslY/u/jtjVvwI8e/SPlFzYHCnlzO66IhG7t1jyGp4zKNuZrPKm+HNx91qNEqEO1gAe1PXrtmiqJkhLaRJlEVQkjcByVPqRYFnJFGBjWXd4g7zkVLKoZ/irAr++TD1djp6lJWiUTgArjxSFasc2/hKyPq58TeN/Ef5pACPFcOpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476319; c=relaxed/simple;
	bh=ezNdIKG5fex1vz/PMbs67WqFA9e2zxQBEQ/jnlZRIWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXRyByQr5LnRS9Y8f8B+tjn0Bdb4osfwaraeplYREXal44QciuI6/T4enQ4Cre9kbLW7qwFh1uedTYQW0cH8JscoC4WDwmszBoo2WEgJv/av5zIbJFekBco1xiKYkXhl272+UygB0elYFYPCSp0WFFCdREyyDcpqu3M0wkAnpj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XGyr2pMH; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-844e61f3902so436322839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734476315; x=1735081115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VHLDHmFEFp8u1VKVXZNoakOoMfbmaJWuqMVHMF4IENY=;
        b=XGyr2pMHKA0mJOIgd30/xpcuFIvOsYc4NOJMRebP2r5EvldfTVkkApbpM/1AajNxaz
         w3LKvGr+ttrd3xp9422YK1WA40nnILBVF8vpfIEr3BoVSvJy6CEqfgOdAg2BcDiGtQtq
         9DXT7sEOV1D804K3Kn8iYQSgwPwLRTNooOvgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734476315; x=1735081115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHLDHmFEFp8u1VKVXZNoakOoMfbmaJWuqMVHMF4IENY=;
        b=cva05gfr0TP0Om215wcWZc57znQ0E+xE0F/IQTXiaOXeTF8nWAd0U6EX9b01rasNYc
         d5c8rBuLTX2MZ+/fENbJ9C8kCKrspvmpnh+bzyZxZwxgxaLASrX2itUTKcaTw/fRNlrV
         ZYUQT5orJWP1f9d5U1QPRhAVweevvEtwC0bQ1clBTyzzcOeRpONlgLIkQBm7X62Msjg8
         LujyaoziJugY4P+tSQ8GbqnAGgEtTKKop6zqSKe8US3FQPSOiU8tTJlrRsqd0PhZwOMy
         m3iJ8Md0hnxx2ndebI/l0Wc6JOUsmG90SF3OT2RJeBiEQZKdideSYP9fh9mPiZwaI1AA
         BE8A==
X-Forwarded-Encrypted: i=1; AJvYcCVwaHlEGVpxfrQihQghHtIMtZmlEJODR7r92emyAN6QWCGhTfGxEAPAfWXJV4o/EkCbV1Wfn6Jn3AZxUN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjBpDqA3UimG1BezR3BdAPOG8dyOn/QxV1nlQyCCCqMfbRKyAb
	OKWDWBQaz9F7zcSd9UNJg5AW3DMYFNcCg5SzitqK4SEDpiPLBDtoGBGEPTRDoUI=
X-Gm-Gg: ASbGncul4FcppgPcZSLStKoX6a3ddnsprAnV0ECUAZAa9EFLHaW+NmcCE724+5o4l4M
	o63X5tRxBeGj+G7zEfKxdOXs7jHcAE7vxNwlE0bgFnu8wEHWdc3pfXarmPb5wxB6VQqNPtOkij1
	cEib4L5fQkoo9T8gj4UEwpRLJzPaoiMUOvJh8WHb17SQIwx3ca1/Zj8CnQRr9rmrdUpkjULp4RE
	mIrWKDJH921fNXgIsYlPLL4nV1GAl7rPzuLOMXMiyVggRSMpxMZRouGvinSo3gcWmC1
X-Google-Smtp-Source: AGHT+IFv77BQQLGIXsZCeXEiuFTtdJydsCE5cUHiEZjwmk1jeQkDKOeTOJE9aoC1yqn4HWLR4XEXrg==
X-Received: by 2002:a05:6602:6c0a:b0:83d:e526:fde7 with SMTP id ca18e2360f4ac-847585086demr65850939f.6.1734476315338;
        Tue, 17 Dec 2024 14:58:35 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844f626ad4asm198570939f.16.2024.12.17.14.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 14:58:34 -0800 (PST)
Message-ID: <02fc080e-467c-4f4f-b52e-b20ef722dbe6@linuxfoundation.org>
Date: Tue, 17 Dec 2024 15:58:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/172] 6.12.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241217170546.209657098@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241217170546.209657098@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 10:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.6 release.
> There are 172 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Dec 2024 17:05:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.6-rc1.gz
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

