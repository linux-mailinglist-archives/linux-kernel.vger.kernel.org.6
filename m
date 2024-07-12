Return-Path: <linux-kernel+bounces-251020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4397692FFE2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24841F22BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6653E176AD7;
	Fri, 12 Jul 2024 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmFiD8uY"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72308176AA1;
	Fri, 12 Jul 2024 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720805935; cv=none; b=Dy4Vms4V54RtAAh7sLNFCEbn6Xou8GlyTlR86djt8H2JbNojpDmdeGtg5sOMjH8zeDlSAw7dNvihJYxgCpdvSXzIPHB/gWDnihfQ01P2ZrEkHbHVuiwGnQrJhMWl0wSU0U66TC8sC2J2ERXvQh7fZNJ47Z33XJh6M0pUXfk1NaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720805935; c=relaxed/simple;
	bh=1V/ENdQTei7MNCNaneHTy5T1yttqICLHC3xv6bU0BGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgiYZH1JZNz6r2ffuUzn4+W42qZ5HSNQ438blrewWtCDKlMRytY/h5+BjXrCTvGNOcV9yiMwVVnMx0RomqRsEeTJfE4sdN9tMPAsn88mPCQhMt5Vlqq6J/3bRLLy2HEP3agP6zaf9+KNNgv/Ch/mMSopPvZB+ihr7UKnqHLoVJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmFiD8uY; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-78c84837564so299028a12.3;
        Fri, 12 Jul 2024 10:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720805934; x=1721410734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L9FqVr/rhZyzwfnucHeAewr1d8dwEYOh9P/Sief1hgk=;
        b=LmFiD8uYVfKLWOe9V9TvP0LPCszsCBpMG933NgkfOcV/Xc5sSw+QhdkOQ2HvBkPmTb
         1QiRR/YKcH6M2coP84jcFwCu5BqRqX4Fzq413PCtAUURADbzkCb/EIbXmExijIPnF/nA
         V6YUvsvyCc61zTcltLhuyCmyqcBSuOTGBrl2aTk+Eg6Vedr1VMhJGQ/4XNaz+7EUMD/l
         X48O8hAJbhHVgnsiGvvCsnjfmwE4FNby3nGQPuicO6QQ9o7jAM4iWZ3HvKGlPJijpuGY
         qTMalG/9c8O/GQ6hDIhMkP3e1eW24+SiL21HrtsezW0fgWTXClWE+sdpmswPmVLvrnoV
         F6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720805934; x=1721410734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9FqVr/rhZyzwfnucHeAewr1d8dwEYOh9P/Sief1hgk=;
        b=fUOckZpY0FOIt8bQZg1m4at/5elK9yXb88LxjuuHSkvWWCwDixB0ZMhuOFlheRP3Yt
         Fg22AfQUppOgQ58LUFFZKoAOmEVHO/3gGe5Vx+e6kjhIpmKKfdtH694lAfgsik4QTq+q
         MhkjInesLWDm5410bLpmoo5I2+sqzcdRh4DG6DnWKzhXRDmI3WW2MzfuNJZzrlcCzC69
         aCZV4sYRjvHHR4njaDYmww5cnzFvom6F+o0eWHUgu+3O0uLPta4cM4sJzlwQbbx3hrOY
         ov745uBEHk2UY1LCRi8M9y+0/wfvUaA9f0GK9Fyv1dvAuJfcW8F4ubi+dmragfonQUBe
         h3xg==
X-Forwarded-Encrypted: i=1; AJvYcCWjc6ejoPrt1I2RTQsU0yYc/jnalOv1iyt4pU9ml11gCshQ94c4ZiP7yuUiN/Hy8jrH61QP8W4rlCAKz5kyS8lOcvs13NZpbpXeb92nybwF9Qq8IKX+ei0V5pGHf2prYdYG16rs
X-Gm-Message-State: AOJu0YzIN9bNOV4W3EGYfzLa9GVQqqNnjhJNCoRHHqnCw4cYbB+rVPmJ
	W1NpB9L75pXEkZ6p32fQQxMK8cxIk+g9Rz3bv+3j8tQDQqb1+hUK
X-Google-Smtp-Source: AGHT+IHdX+ao63nA1fTMZfLSJG7Xybt0fUskH7EuIH0b1VguS4qarFsUTpYI3p+dG3HrORxzZF31lg==
X-Received: by 2002:a05:6a21:3394:b0:1be:dd1c:a6e3 with SMTP id adf61e73a8af0-1c2984e11d9mr13338042637.54.1720805933399;
        Fri, 12 Jul 2024 10:38:53 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fbb6a3ca56sm69551665ad.118.2024.07.12.10.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 10:38:51 -0700 (PDT)
Message-ID: <191d8761-0784-44f6-9b8e-5d3c1c15c5ad@gmail.com>
Date: Fri, 12 Jul 2024 10:38:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 000/197] 6.9.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240709110708.903245467@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240709110708.903245467@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 04:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.9 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Jul 2024 11:06:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


