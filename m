Return-Path: <linux-kernel+bounces-575731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C273A7068E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7025A3BDCC4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1132525A333;
	Tue, 25 Mar 2025 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eCsEbvxq"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CCD19D891
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919272; cv=none; b=SQuSy5PYofbRy7q+LJOibfTz5nJXHcIxAxP0ZsKUPFMzbz3kuxekxIwjcTxSR2XgNgTkrFmwKJaoielWKe6ThbqA3dA5+HdDPYd71Cz37iZ4xaxiaGjy4V+RT4dNPGMxpLl4pUlhmptdQMQCbE1WPT19bwLgWp3ctsIo3hSJfMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919272; c=relaxed/simple;
	bh=xXcB18cHItpKdRkh30guopUU49ZVJxSa+x01vlmZgrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8bQnQnUYZK8yCtXAxaUpr1WaM8EwLO1PMdxOIZTqsj0QalnLdPtoMFYtaCKWwnIcy8yStvVU41VUcG7VWDWUZS1HBGR1W0ZNYN35tazzW/mS9VUKYkkc6JaoEZcQOo9NtNLxZuJpLDIHj0AryaDeF2PHi0brT+SMExtG6DjKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eCsEbvxq; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5240b014f47so2432097e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742919268; x=1743524068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BaohcKTCwY8+VpwM3aapzTE/kg503pUIVGtaPhgwj1s=;
        b=eCsEbvxqlhDDAgcVZq8+D8jZNXQZH/slgMZHzpTQWIRH2cGIQfiLxpwW06MPnzAl8W
         23JuswjcTY8MksexwvkdDUjuj1EEj1CZyeT2+HigSbuRH12d9BOT/dYpQBtUFKH+croY
         d2QSXiPjRuHxzY445513xh+cBzpkN+2+bC22cs9HFuZjPK0uWfkDoH6n5NBwF4CKUcEG
         zl68ecYQG9qk4q0Ex0SmgOl2+lZ0echEoGClhNIeHq1wHYZN8ds2KYkkYjT8V9Wl2jeY
         DoqGBjz5ZEfw1ebwcbpW/dywclVBXzswnXzH8PlfN3GfZi8G5cI898puEPC8+3WXilD0
         0ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742919268; x=1743524068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BaohcKTCwY8+VpwM3aapzTE/kg503pUIVGtaPhgwj1s=;
        b=k6HfePZ4Eh1MxcTBEwtW9s0nyE1GsU0kQyBG1+EiUxjllSonrbrayAm+U1pxuACLZr
         tl8/UYZAnnWH4NYhrX5Mbj+yhPwNsx3cn2bR0rNdu7D2FcPGHOfi3V6rMmaGW2nI38XD
         8Fx4sLvR7Wdy/HzKY/mI8K0dCUSKvE2Sb2NZ2Y51syt+ivYrz8YgmFMq5dSsjlOo01j1
         HYRXVlduwvxBaAvlvMYW3t4c3U3iQ+id8pfvoVGVo/+xGG/worXQkxd60UeuzAZqhoC/
         SSexpcRNhi3vmeaAPcCAuUVBGshHEsQ8NLxYhFXWHoTew4N1+gI/Y+KG8BVxfz3RxrQY
         xeyw==
X-Forwarded-Encrypted: i=1; AJvYcCXoYdx7ysqxnTFLrB40f07LPkMxlCgGvxnQAx31ljMX0Of0p0Z5iwQfbdZwmozgre68dVCO+DeAqJgYgfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG6RNqOKNqsN6QOTEk1FTnogo8RC6BDdczh3dJzIcKp4Mxvsb+
	76LGHcGERg/GWOziebI3BVr60bw/qK2CeIXSqorzg1MDGoHgNLryZZeUEOsrG3pROrHzEK0/myW
	pOTCVgAUEXmk6xyAmfvm6AV1R/JPWjdgLsWyexA==
X-Gm-Gg: ASbGnctfjDEvFjswgWmI2oyGcOmix3rpFzc76EeGp4bFNkloj/pg86ImKUd2CMzG+pd
	BKEJDWkAZqc+L4syhKBpcMardbO8tyrLSH7NIEZ8youl/XAXP1ItGx/CED/qxE4JJDc9x5NBwrX
	qS7A2vGGaXH35cqacOYHsduim13k2uVGvZ3dU/IFpHmSYMA6m2mw2zJo1hkmJK3lKbah+yHA==
X-Google-Smtp-Source: AGHT+IEPYTodFqcqF8Efn8cEBRGiITyGd0BPRmWJhgYjQS7JJvpdV/lixW5XnmBOn5f5Fk8rQGTqZ+ByuVXZYVxL/bQ=
X-Received: by 2002:a05:6122:6184:b0:525:aeb7:f22e with SMTP id
 71dfb90a1353d-525aeb7f2afmr7300952e0c.7.1742919268062; Tue, 25 Mar 2025
 09:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325122149.207086105@linuxfoundation.org>
In-Reply-To: <20250325122149.207086105@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 25 Mar 2025 21:44:15 +0530
X-Gm-Features: AQ5f1JqspNdi-6TlUeHbfzfXwOqeSMIOZd9HQXTwahnt1Erb3i0Fy8v8uY2WGpM
Message-ID: <CA+G9fYvaziw0a60idsSbDdSQLL2L+W7VnVv9VJHc-2M5p5qRfQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/116] 6.12.21-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Helgaas <helgaas@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 18:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.21 release.
> There are 116 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Mar 2025 12:21:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.21-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Regressions on arm64 rk3399 dtb builds failed with gcc-13 the
stable-rc 6.12.21-rc1

First seen on the v6.12.19-349-g8c2b29e24438
 Good: v6.12.20
 Bad: 6.12.21-rc1

* arm64, build
  - gcc-13-defconfig

Regression Analysis:
 - New regression? yes
 - Reproducibility? Yes

Build regression: arm64 dtb rockchip non-existent node or label "vcca_0v9"
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
arch/arm64/boot/dts/rockchip/rk3399.dtsi:221.23-266.4: ERROR
(phandle_references):
  /pcie@f8000000: Reference to non-existent node or label "vcca_0v9"

  also defined at arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi:665.8-675.3

Anders bisected this to,
# first bad commit:
  [b3d8759e5e8530302831e24232cb360388a2d62e]
  arm64: dts: rockchip: Add missing PCIe supplies to RockPro64 board dtsi

## Source
* Kernel version: 6.12.21-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: 8c2b29e24438f0439af527927ea2989df3a41c6f
* Git describe: v6.12.19-349-g8c2b29e24438
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.19-349-g8c2b29e24438/

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.19-349-g8c2b29e24438/testrun/27759652/suite/build/test/gcc-13-lkftconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.19-349-g8c2b29e24438/testrun/27759652/suite/build/test/gcc-13-lkftconfig/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.19-349-g8c2b29e24438/testrun/27759652/suite/build/test/gcc-13-lkftconfig/details/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2uoHnrrOWLw0FMCQJDU4Si0cD9n/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2uoHnrrOWLw0FMCQJDU4Si0cD9n/config

## Steps to reproduce
 - # tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org

