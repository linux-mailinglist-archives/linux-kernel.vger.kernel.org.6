Return-Path: <linux-kernel+bounces-549484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A3CA55318
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130D1174912
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0455525C6F3;
	Thu,  6 Mar 2025 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vzDzs/cR"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076D325BACB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741282191; cv=none; b=e8sYlu+zKK0H/2t++fD6sHkgrkxDi0Qeri55kIQ2DiDsg5y5ZKue6JBrZRMAGlgV3PgWFSjbyNHigA/Hxs3B7LIVyonF7uX1VF9SsJrXb17qikiX0oDFd/U9v9QdJ3MywMd6krWNP9s0DGuK1zq6kYQPTxAWEKOo5HDEUJo8C0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741282191; c=relaxed/simple;
	bh=JiXBBKulzpm1G4toJd+w3rK2oa2JI2KBaqVst92x83g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFHMqiR45tzQSd74+5Gx2qHxDfm+vipHkEFLUDeaXJ9tn+qjlG+iCD4O3J0MMxgjiK9LqapY8tO4LO8c3QQjon+PC1F6KZeEJFaflFXqIEnCG791wz7y6gmws5jSBX0O2rwDTTCeQmEJc0he3XCl6VkTsVmYf4ZYPV8GnXNc//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vzDzs/cR; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-8670d630d2dso369474241.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 09:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741282188; x=1741886988; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pXtLFB7rHzBBDM/TAUEEN+9FpT67VqyHhiDM0Anig2k=;
        b=vzDzs/cRCiQItFRB2GbLTmEsO6b2pDtyv0Q1X3irPGjRoy8lOBya/Jq88zvqJLPs6z
         2LEENMMT4hyKFG+WsiWqjE2kxrZvjeQOMJMuKkgI+uZlErK0yk6lxzRnZzNIjfJ4twvZ
         XAAO9UmT5VoyxMN1/dtTvE95mZtQ84F9K1S8Aw/eNojGlqlTFnrf0ig9wqLdn5baRzwP
         t9eIYPxhKZ1bA8H5JxQx29mqL7LovKvi/eQLsEORFZ2LjTGL+/GKYAc4ejJNMtpiVQF/
         8JgGf7XMajisqhho1xG8MxHX2hWoCRtHTfGqzOtOGbzxtX3hBPEGosGQ/LMPcXN80ie2
         EAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741282188; x=1741886988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXtLFB7rHzBBDM/TAUEEN+9FpT67VqyHhiDM0Anig2k=;
        b=L3zX6f0wENscHxPl+ayZ2Poh5NwBRYqHvc7tKU0JLkiw3apHYGIj2RvNf/M4LTCDAj
         xVn/jTa/hUc3s99JyjPUg2AcqAjHx2LNfS8uWRxbz1EOLwSpBbhnUFbSWpQqwVHVLMqK
         GU27BURmbnmo7y+vgPAjFZRO81/ynrKqSDU7x/jJS83LSi2byoRTlK/6W4ohnhc2b7ba
         xj2D9tsevB3QqOuJSFOz/h4Re8sPX3CyU5F4rlvpXeVfBNL99NpM7QprqtABjt5gpn02
         7cLTO7YdngApW8S28dnO6XZROeSHk6oKeyKpl91wGAIfvhmlOSprYcVUhdK0dV5jpp/B
         bPJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkSg59r4CwOoQKfU7mQQN1FRVpEI8P9XfrcYKusLme51QH1rRVIBQM5kiLFayw126dsEh8eat7G6+k14o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfep1XqwJ6GzGEHNtKqo2TxpiPDZNVSgv3/GkEeDnLu4h1v6WY
	IyTiQIq/LYrpVFuLmN1nCZfkR0YoVjF+sI71+HEpdF/qsCK4StyitNx7pItpr3S0/Dpr8yVqs3u
	8qHdh5M9Evg5V29CTXwP+ydMFNURbFxAoNBRODQ==
X-Gm-Gg: ASbGnctAdlYLJA4tNeRFwSQFfXAcUO48LvEJfVk4YazgBf+Kzyx+Bbj3xpzulRjKwce
	2vaxbBIEfScje1ErL1ScDXf1xtDA2a/zSr2qaTL1Nl4FUX3hL9JJWPiSbHw1gHr3wiLsdVSddJR
	obEk+mDNMoW9Q7m+vDFaEzohYofpX8xX2u4tgatq5ffaNjU8dINuYgK1myjb0=
X-Google-Smtp-Source: AGHT+IFNXCtuHq8zvVxiVQYiR8dorrj9uyzpsQMGx5pTaYKW3Lqu3uOnXFHmE6jvJxArEtny4FPQcKgSRyM9FNa8LGA=
X-Received: by 2002:a05:6102:3594:b0:4c1:90ee:ab2 with SMTP id
 ada2fe7eead31-4c2e2815489mr5712797137.14.1741282187745; Thu, 06 Mar 2025
 09:29:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306151412.957725234@linuxfoundation.org>
In-Reply-To: <20250306151412.957725234@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 6 Mar 2025 22:59:35 +0530
X-Gm-Features: AQ5f1Jo2c_NWeRxraJqOe3rUK2VTQXZDSVRCocH07muKH4PVHGeh0vesJBzv5Ho
Message-ID: <CA+G9fYtfmMThUC+erk6jVk8BN0jWJCw=FnKh68ypwhgv65OZ+w@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/147] 6.6.81-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, 
	nik.borisov@suse.com, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 20:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.81 release.
> There are 147 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Mar 2025 15:13:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.81-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Regressions on i386 the defconfig builds failed with clang-20
and gcc-13 the stable-rc 6.6.81-rc2.

First seen on the
 Good: v6.6.78
 Bad: v6.6.78-442-g8f0527d547fe

* i386 build
  - clang-20-defconfig
  - clang-nightly-defconfig
  - gcc-13-defconfig
  - gcc-8-defconfig

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Build regression: i386 microcode core.c use of undeclared identifier
'initrd_start_early'
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
arch/x86/kernel/cpu/microcode/core.c:198:11: error: use of undeclared
identifier 'initrd_start_early'; did you mean 'initrd_start'?
  198 |                 start = initrd_start_early;
      |                         ^~~~~~~~~~~~~~~~~~
      |                         initrd_start
include/linux/initrd.h:18:22: note: 'initrd_start' declared here
   18 | extern unsigned long initrd_start, initrd_end;
      |                      ^
1 error generated.

## Source
* Kernel version: 6.6.81-rc2
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: 8f0527d547fe50fe08bab12d39c9a2cfb4f6ef3f
* Git describe: v6.6.78-442-g8f0527d547fe
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.78-437-g9f243f9dd268

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.78-442-g8f0527d547fe/testrun/27525967/suite/build/test/clang-20-lkftconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.78-442-g8f0527d547fe/testrun/27526163/suite/build/test/clang-20-lkftconfig/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.78-442-g8f0527d547fe/testrun/27526163/suite/build/test/clang-20-lkftconfig/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2twuoLsehi5aV5tpYyqa6pqU9cZ/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2twuoLsehi5aV5tpYyqa6pqU9cZ/config

## Steps to reproduce
- tuxmake --runtime podman --target-arch i386 --toolchain clang-20
--kconfig defconfig LLVM=1 LLVM_IAS=1


--
Linaro LKFT
https://lkft.linaro.org

