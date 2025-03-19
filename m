Return-Path: <linux-kernel+bounces-568413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7ECA6950E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843E41897ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F9B1DED44;
	Wed, 19 Mar 2025 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A6A/67I7"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C82C1DE881
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402016; cv=none; b=Ik8/KKTWzU8eJx5mekfEt7V0YrV22CtmQPy3e3Jn8uwRR/bOiIZnrlbCfQd0ph//Et7eBSC7F/i4hid4Ak6/73gH+LRVS5PcUJpt3dOCM4vAGwN4WhH9tAi3eNstQ/ebl06JBBVPph0zwY55nLXmj0FcyY56cO2XaVURs6KYB38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402016; c=relaxed/simple;
	bh=b5JoerGjzoODytPs4/JCCgsORTIkD1OWdTmBFC8AjPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmvMbHoY/C5BBLGlu2zTAmWXbkJO4BXTQ+15i5v5N+Lc4IMykbhE6/TtX00tMgVjkydDhIYzFodqheTnwZQ0HJuNzMkAnpGDHkqwZEQ0ULuLX8XZ7Hajej2DUR9SDcuqghwRfy41OqUNfl8sQXixZyMH2B8IYnB6dUJHWDAzfHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A6A/67I7; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5259327a937so164453e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742402013; x=1743006813; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OVuqKpUv1pEU4LzOHuIA6EH8XUgNHnH2M2llTP84R4g=;
        b=A6A/67I7CkMWwUadriYwzJU/lkazyWM2kNKMUtyaTwie3iaKbuhInQoWY5vYbCLqBC
         gRSzPna9jvRlZ8PzRcSshfJlpC8uTumAng6LmkJbI59MQjb9B9uvh+8bFDv3GxmfF5JY
         q1GLtFM5x9O41LvK3MycD5eqhpE4JaWi+45b24GkpjKVRHaAqIWUIIZdsUqBbAsZwqwh
         v9gAfOoX49+wuqyKEiSmq88hYsdGL5thq8CXV8o5oqHX/cM6HbKV34xAh4QMmTlxQwes
         vQLY9FL+q3P0FksMdJ9SnoygTIIHxhjwG8JOXO3/51tBu362ll4uSFD2gZdrP2sCpS0S
         VM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742402013; x=1743006813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OVuqKpUv1pEU4LzOHuIA6EH8XUgNHnH2M2llTP84R4g=;
        b=EbBQ6ilNT30jeq1l8F4IevPjKoPhiGT0qBNqM+pttV6dGCVLih8XoA3WCAtIAIv2Hw
         XnHAwgl6+qp3tvcynub/3WMgGSdYXOI5phvh3FuGi6PHSB3jYSRx3nwxbhk7d3bo+UoQ
         edTiocfJvtxrD3TMWm7637H4Ci9L3PeH7WJgW+jYIugi4ljI2MFhtTVaRBBY3toXRdFt
         XYMGN4Fsl64o+UsS+4KXqFbL/6s36tjRXuRAGTUdKQMf1hAZNnb3pjAAV+XaEAkJ/l/H
         SqU+0GnoA/EkPs/Yx++8AG5N2sORknf/D3slPeV6zmmaTJb3U8Vhc9X1Ws4fs5m+ldeY
         zUXg==
X-Forwarded-Encrypted: i=1; AJvYcCUjESitF/AXbM8Iabs+RaoOkLP5mIJpMj28DO06e3R3TMGZRg754Mfg/kPmnBUBW58jzQzz1CSDxgrRuxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO76HhuGmjNZ3gEUkLetFu7tPkdDrU3ZIILAzZn8O3KO4YKSxs
	2cMvrshycQ0qDG6st7ueOr2oyv1g6MJlFzbSZVg/CeaFeoFX8zbY6qDK3zwureEl4JGkD+EMi7u
	KPIRD2+mSbd/WoGVFbKUcuZVn6woeKKQopmbElaVz425++iICNXs=
X-Gm-Gg: ASbGncup1ezgRsXnnMwLz8jZefr2R9RwVZlsyXmlJxDwUhI+0T0iwazlVd1CqjAvOG7
	hMZH0mbhZAQwl8/Nu6lq2Gp1Lg4retXG/ZS4xvtrvRM8yDyqv1Cwm3XTmkblfYCQzZierumtIs1
	bscJT0TSL+ptMDJqLpU4jJMxR/YVyatypKSrEm/duBaw0sdiRGZWTftYs=
X-Google-Smtp-Source: AGHT+IHWmBTfBeI+pX6l/d4K6vWO07nXM028XzAozff8NwOIYDbLIFEeoObpskDnFhKhHnfnKlb6wiHJoN9ZGxWxSfQ=
X-Received: by 2002:a05:6122:8890:b0:525:9440:243c with SMTP id
 71dfb90a1353d-525944025e4mr695738e0c.11.1742402012994; Wed, 19 Mar 2025
 09:33:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319143019.983527953@linuxfoundation.org>
In-Reply-To: <20250319143019.983527953@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 19 Mar 2025 22:03:20 +0530
X-Gm-Features: AQ5f1JqIqR8G0jdBi-EqCaYlr4_sxu0nohARN-WaSCDfLRpd0KihGkC9ntbmtXw
Message-ID: <CA+G9fYvM_riojtryOUb3UrYbtw6yUZTTnbP+_X96nJLCcWYwBA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/166] 6.6.84-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Mar 2025 at 20:09, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.84 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Mar 2025 14:29:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.84-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on mips the rt305x_defconfig builds failed with gcc-12
the stable-rc v6.6.83-167-gd16a828e7b09

First seen on the v6.6.83-167-gd16a828e7b09
 Good: v6.6.83
 Bad: v6.6.83-167-gd16a828e7b09

* mips, build
  - gcc-12-rt305x_defconfig

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Build regression: mips implicit declaration of function 'vunmap'
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
io_uring/io_uring.c: In function 'io_pages_unmap':
io_uring/io_uring.c:2708:17: error: implicit declaration of function
'vunmap'; did you mean 'kunmap'?
[-Werror=implicit-function-declaration]
 2708 |                 vunmap(ptr);
      |                 ^~~~~~
      |                 kunmap
io_uring/io_uring.c: In function '__io_uaddr_map':
io_uring/io_uring.c:2784:21: error: implicit declaration of function
'vmap'; did you mean 'kmap'? [-Werror=implicit-function-declaration]
 2784 |         page_addr = vmap(page_array, nr_pages, VM_MAP, PAGE_KERNEL);
      |                     ^~~~
      |                     kmap
io_uring/io_uring.c:2784:48: error: 'VM_MAP' undeclared (first use in
this function); did you mean 'VM_MTE'?
 2784 |         page_addr = vmap(page_array, nr_pages, VM_MAP, PAGE_KERNEL);
      |                                                ^~~~~~
      |                                                VM_MTE

## Source
* Kernel version: 6.6.84-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: d16a828e7b0965ca37245ebea19052ad7b4b2f9b
* Git describe: v6.6.83-167-gd16a828e7b09
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.83-167-gd16a828e7b09/

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.83-167-gd16a828e7b09/testrun/27677634/suite/build/test/gcc-12-rt305x_defconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.83-167-gd16a828e7b09/testrun/27677634/suite/build/test/gcc-12-rt305x_defconfig/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.83-167-gd16a828e7b09/testrun/27677634/suite/build/test/gcc-12-rt305x_defconfig/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2uXZlKzVxja3mOQfRLlPRxHzd5L/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2uXZlKzVxja3mOQfRLlPRxHzd5L/config

## Steps to reproduce
 - tuxmake --runtime podman --target-arch mips --toolchain gcc-12
--kconfig rt305x_defconfig


--
Linaro LKFT
https://lkft.linaro.org

