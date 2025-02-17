Return-Path: <linux-kernel+bounces-517133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1939A37C88
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7541889860
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D13192D76;
	Mon, 17 Feb 2025 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXlyb1PD"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF97718DB25
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739778626; cv=none; b=YTmZX0tdj2+nbHIr6MnOZmI0OVizJ1qT8ZIbAXGFlXJvTjkHM2kc4h4jaAvF0M2mtZ6lLMPzyrH6uPCOhSY9zgIMD70YpmNd1OcAdBVWXjl72U95JllkdZCRaQm+LAKO1bEeA2q576Hr2QuKkSzdXGr6Z5yvoaNWJBejVlI96QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739778626; c=relaxed/simple;
	bh=vp4a6t9+gatjenBKfvBoMVmONzCQscQ264+pgS+okNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7xgy47mkTHmzjjYM29K5QfbWbqJcdiy6ioWG84+ZN9vcKOYScAQMtU+BwmLTRAUGW+hzmISUUZr+23TPSYq8Q1s7r0arIwSNrZ3KgSc2RMYs8H+c5YKUkXQXXu497pWPth/J066hDPzxD0oNwwAYx6eIRtbXrlO0IqaoeTEYU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fXlyb1PD; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86715793b1fso1149906241.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 23:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739778623; x=1740383423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sb9TESano3F0qRs1VfUsEveKaGPiE/3bY+CecfKRiUY=;
        b=fXlyb1PDXWud7cxIGkOmCUS8P3tBJ4ZFec3DUTumsUjWN+NTYJSgaTHiPUeNChjCEk
         p/cuMRQxxleCMQM/Bwt7blntKwHuP/aUvWmxLGpT7WSttoL+y3Id8S6CcoTkvynWm7yA
         UXjSCPGhoPcPIx/svpMpTrA8ceYEa6UsWN0W3RpI5Wp2A8LkPKPIjeU8skVrfvxXDS/N
         DvvLihOtj5DX+KD+hFmaKGB8AFUrg6NQSbxnNm+OEKB6cGTz3ZkkPY4VrPne/S4F7FKA
         rJkOLHh2HRDTOg1cyA7Gkhc0qWhItGDktu+y3N8YY9bKBeKqSdv0oIgA705vPwQBdm9J
         nreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739778623; x=1740383423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sb9TESano3F0qRs1VfUsEveKaGPiE/3bY+CecfKRiUY=;
        b=R2jazC9ix+o6d2WlER0pZSzYEqRG2wOIY0CfYFRmyTCFbYaSgcbMbCqsgCVO96MYYn
         vJbV668vKesFTpy32DnSy/vnnnVvzy7e3yRvplR6N9rZjnzanygL38F6m0q6Q9cRfdgO
         v7/dHW/uIzFxsm84fykI/E33FSmWsbsj6m5la12ZYsFXOpH7BFFxqPs3tNedRPQtvrRE
         m7NznBoecv+Rhb21hPoEuPDwIEe94g0TyL2gpXELXQtbY5KBQtoJm2qDbBDGcy6gi3PY
         kdyz3jyBSh6rn1KzBAFa0KT3KoxDfEIq6WGyTWeMK2zFWAe7oNCMbINdnA/7apY/ZDNo
         GjhA==
X-Forwarded-Encrypted: i=1; AJvYcCUGKTYj1u0tB4LONYD0rnZF7OyP8q13A6rzyDvnooECCn7L0PzNm9LiaAANxS8vby9lhoHS4eLA0kf2LFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb7lTi9N0QxNKrk+WZydqMc+g60oVafz22sGyzketqa/LBwF1K
	L4mSXwyq+8EP6CsYpiXVBDs7Zrn4vSNyNyW/0xKwVc5LyEv8AxUFo0CEW166zUoQ/c8/fF4geT2
	O7JTnT280zuvFwNnMD8Ql+cop8ZVY/dDNbatbGw==
X-Gm-Gg: ASbGncuBygf1ERE3sQQQ80cJPrJF+u/BqTTzQF8KruNEA7+9h78gCAPKvd1EAY1YOb7
	zFp7wQtSqdSoBnSx2WC4kCA13UkEh7+wXGJJMsWCoOCvl8C9YJ298IL7ppEFxMlXSN+GwqRkUCp
	g=
X-Google-Smtp-Source: AGHT+IH7AA8lTvvKySDGMR/9+4pfIcZZ0oEGwwCKuY/vSrQj1o5zY23MVYJNqtGjpMCyHJPVzvbKMkBJGAYr8N5YT3E=
X-Received: by 2002:a05:6102:150f:b0:4bb:e36f:6a30 with SMTP id
 ada2fe7eead31-4bd3fd24266mr4376412137.15.1739778623321; Sun, 16 Feb 2025
 23:50:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250215075925.888236411@linuxfoundation.org>
In-Reply-To: <20250215075925.888236411@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 17 Feb 2025 13:20:12 +0530
X-Gm-Features: AWEUYZk9MdnW6iQDFedg0wdqGA5Evc7ByipVWqb3l0MawRNhfY2MpewuEd52Crw
Message-ID: <CA+G9fYv8VcR6Zj1PmqJ-zxUuCvJthO08BWuZo4uWdUbVvcT30Q@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/442] 6.13.3-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 15 Feb 2025 at 13:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.3 release.
> There are 442 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 17 Feb 2025 07:57:54 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.3-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Regression on qemu-arm64, qemu-armv7 and qemu-x86-64 on 6.13.3-rc1,
6.13.3-rc2 and 6.13.3-rc3.

We will investigate this and get back to you.

Test regression: arm64, arm, x86 selftests: memfd: run_fuse_test.sh

* fvp-aemva, kselftest-memfd
  - memfd_run_fuse_test_sh
* qemu-armv7, kselftest-memfd
  - memfd_run_fuse_test_sh
* qemu-arm64, kselftest-memfd
  - memfd_run_fuse_test_sh
* qemu-x86_64, kselftest-memfd
  - memfd_run_fuse_test_sh

# Test log
selftests: memfd: run_fuse_test.sh
./fuse_mnt: error while loading shared libraries: libfuse.so.2: cannot
open shared object file: No such file or directory
not ok 2 selftests: memfd: run_fuse_test.sh  exit=127

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Source
* Kernel version: 6.13.3-rc3
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha:  f10c3f62c5fd43a4dea41a460937f2c1a6a412bf
* Git describe: v6.13.2-443-gf10c3f62c5fd
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.2-443-gf10c3f62c5fd/

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.2-443-gf10c3f62c5fd/testrun/27311246/suite/kselftest-memfd/test/memfd_run_fuse_test_sh/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.2-443-gf10c3f62c5fd/testrun/27311246/suite/kselftest-memfd/test/memfd_run_fuse_test_sh/history/
* Test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.2-443-gf10c3f62c5fd/testrun/27311246/suite/kselftest-memfd/test/memfd_run_fuse_test_sh/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2t4N3DOlWsCre7mv2YlTKUyEFri/config
* Architecures: arm64, arm, x86_64
* Toolchain version: gcc-13

--
Linaro LKFT
https://lkft.linaro.org

