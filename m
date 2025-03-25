Return-Path: <linux-kernel+bounces-575622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8264A704EA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7256C1673DF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BCA25C6E2;
	Tue, 25 Mar 2025 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t9fFNFkt"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081D025A336
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916173; cv=none; b=k4es7Q9RFYQxO8i9jWRJ/ctXnVV4yv2PkVZJjYELqvzdr2Ue/mqj0FfSAirpZ29x7UxSS9EUYoEmaLQxGBnFEZQcXr3NQ65PTHXe19ZAGKwG6jSWRWSD39rMGKr/Cb5mDmm0aNUKkWGQl4KuI2hdVXig1TBZVDlijvXJzn9n2eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916173; c=relaxed/simple;
	bh=vs+t2NdfqiK4z8GbA1CIrnlz9zIFlKWM1eLzsT7vTkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dciKh9gtlSBDpdn36iSvWDErpQ3AgmvWEC+ewgdq2riGCZN9gC/tk6x4uTKCSxWwfFV66gS6fnD213SIXMxAJxr09Tx1IZvELqJkiVhCF/ZjJUZqDJBJ0Te/daVeqveTwGc/8xZ4WQ7tpIrKKuFttKueGHwob0VSMW9jxWMIqy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t9fFNFkt; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-524038ba657so5550756e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742916171; x=1743520971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FR1psq8rYb0jVgAPAumoNgxnKTwTi/S55HLEy0wx1vw=;
        b=t9fFNFktJsSi83AKlQTzXkk6PGNEFn+kAhEkyuCV0/HkEsw2osEztVG9ByM7A3JmVM
         DioQoImuLuEnZhXYQ8cRljQmzFR6zHTLut1tzx92K0In0O/ORlw6+Gncu/Wd0F/iSgVp
         W8tI8nzGw0TdOnYnZdxJN2XcLGKkNddZna654lJQjbc89a0Fck/6mh4Pe6QS4GJkHwVn
         jz07/BC0sdw/lmTODEFAGq5czvkxHops52zgioLxUEkXFiCuSKDn+yV7DO9E8/C4Bd5V
         vXylB5RvjTF1bXoe80EKzxM9GG98ltQnvIYlOPTsskvbt6lxkWBgmvr37wqP+6w5xk9B
         J3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742916171; x=1743520971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FR1psq8rYb0jVgAPAumoNgxnKTwTi/S55HLEy0wx1vw=;
        b=OTZm8Rz0Qit8CqQWKa7gjLoO9EKqO15xTQwtnRYX1kCcSZX+TS8a0pXAMStzuMt2yH
         ID0cZe8jFM/+lRwW+DyeUz3qwh+fU+RmN7dhALurD72lvweZEI/bPGNkwF54FbNuVXK6
         vQsM/IS8VzJXCHgZGgM0+/ZeGqRZD3xXw2dzgKDNFIbcENTKP4aoJeJ5NkvpvRxc6cQE
         pq6vGzZoeSaYIj89m/FmcCyNc/iEMkFeaMS0FqiPquWfNJD0R9VfNklO9XOtgrIZgcRC
         ZvgOHqkt+M5+eX/R0txFXhNd4h7EitaWzjuz8pxTWBZ71AtoCuU1a53cTAakyX9fMvbU
         CehQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUTAYFd+EFuNi02usbr6dV6Z778I9zefuH7eMmFVoLT3tqJgGMg3OmmNTH7Kr66jemmwQhVdoGYD8mX0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ZkT0BGgxBiOkjxSHji9BJDHYY7X2OfploF2FFA4UPeicecvD
	nYvSJnLVAe13VD5pc0S68wTIDU8HBawCMAsp89PqVq/arlT7nRcDB8BJEwEq8EXcexoOmZkyV6o
	7IYsvZVoDnGSRkA6uhDLE+gkxyRboezMw3pw7rg==
X-Gm-Gg: ASbGncsl2AKhfNTMaEcTnMR40TKd56kmhqUL7sb1Pz2pfMH6snCkWT1CBa5KW46u+dU
	wwLNCIcD9CrQg5Vqi5BBhlcl3xQfaQSY3OJ7/zPEwzRM3/Fb6UNuBAEn+oWGcon2Cv0SUoTbfr1
	i336a/PEVsQrhXiprRzn8msVJrQyxxodA55Eg5z/hBud7ekuWgHLh04i6yEjWx4xdjEByK7w==
X-Google-Smtp-Source: AGHT+IFPyQveoVq2SQJDsUBSx33+PpHB6pNXsSERn8w+t52W+nsQCR7YrtRu8eLNlWuhbuil8gCmDMnrysGjzJPJ4tM=
X-Received: by 2002:a05:6122:a24:b0:51f:a02b:45d4 with SMTP id
 71dfb90a1353d-525f0acd8a5mr202640e0c.1.1742916170612; Tue, 25 Mar 2025
 08:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325122156.633329074@linuxfoundation.org>
In-Reply-To: <20250325122156.633329074@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 25 Mar 2025 20:52:39 +0530
X-Gm-Features: AQ5f1Jpu_5veFnVwrvzd6ONxa6kMdH0QnKmtM7yQuJWdcSN64QgsvR2p84j7Rx0
Message-ID: <CA+G9fYss7RcH=ocag66EM4z26O-6o-gaq+Jo+GOUr2W773vQOw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/198] 6.1.132-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dragan Simic <dsimic@manjaro.org>, Heiko Stuebner <heiko@sntech.de>, jorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 17:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.132 release.
> There are 198 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Mar 2025 12:21:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.132-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on arm64 rk3399 dtb builds failed with gcc-13 the
stable-rc 6.1.132-rc1

First seen on the v6.1.131-199-gc8f0cb669e59
 Good: v6.1.131
 Bad: 6.1.132-rc1

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

## Source
* Kernel version: 6.1.132-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: c8f0cb669e590c6c73c274b9fc56270ec33fa06b
* Git describe: v6.1.131-199-gc8f0cb669e59
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.131-199-gc8f0cb669e59/

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.131-199-gc8f0cb669e59/testrun/27755718/suite/build/test/gcc-13-lkftconfig-devicetree/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.131-199-gc8f0cb669e59/testrun/27755718/suite/build/test/gcc-13-lkftconfig-devicetree/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.131-199-gc8f0cb669e59/testrun/27755718/suite/build/test/gcc-13-lkftconfig-devicetree/details/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2uoE2WrLPnhBvFm7ejgwd6QJxk8/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2uoE2WrLPnhBvFm7ejgwd6QJxk8/config

## Steps to reproduce
 - # tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org

