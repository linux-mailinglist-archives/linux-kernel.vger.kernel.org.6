Return-Path: <linux-kernel+bounces-380171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CC89AE9C3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FDF1F21AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B4D1EBFE6;
	Thu, 24 Oct 2024 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m7zpUr+s"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2303454738
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782326; cv=none; b=BIuF8YOJAgMHi53Jo+TEFOygbjKF/cuhPksxCBgdigPIonpQCGmsNiSFjWMt4p5sKCiMQiQo8WKHc9iGJzz49kARfX890yUPZWkdk5umWwmYwIiEjsnLsoNPNNaU+i9yMHYi6WK4Lb9rtrMu/b7YJFxsZEKophzlwohTOBXpJuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782326; c=relaxed/simple;
	bh=aqeeharMk17ixLZGkNgDLOJVAmDR4MwZ3UKW8XU+Tjw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JSHc/5vlxU8UG3w4Rkqi6dPCsl6vYTCkFt8Viw/PphCPYCXlu+IcIYA3AN72A2I6Q+Fe7ZcYA7A2nPMPfndwcXMmKvpCARA7sKGK+9+bZziS666Mpej4rhJt/xOsXf2cRAoRxuhz3hjkxQ1qQPwj56XNZpYBaT5iUzxI0QGVuxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m7zpUr+s; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ebab72da05so460904eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729782323; x=1730387123; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jyarlQ6i7toXdr4KNns6qkdDvM4HB4Mkf28BveorRBE=;
        b=m7zpUr+szfBKBluKBdylGN8Dq3Ky4ykLvUxa3TWyr4CECO+1BKF/cbJPVkccZE6I49
         v4gzE714F+cNEHuFUfQO5F+BGjDO7koeNfC/IIeUKny56K2LCS5eslF5SEcOzmoTIWBy
         8zceCTOBzRj+AA3ibQp40xhfIzzowwzBJu57f0ur7NHxCXJ75FUKo7xJUqMaLXQiu4VG
         cOAOQG34BysVzdw4hDHHhkWdBnhdMB9VWugIU1t4wdYVFUnmuRj7opMBbCZnmR2UUHW/
         nKkrz3ekAXit3EctSxmwOCULqJ0DwD/f8R/LJaxjb8aQG02pOk41jETF88QDNVOSqtrk
         K3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729782323; x=1730387123;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jyarlQ6i7toXdr4KNns6qkdDvM4HB4Mkf28BveorRBE=;
        b=Mmbg/2FbMizh+Ynq7ES05zjUxpQdQ0NTQt3xZOueS2UjZVAvRTFGUlRyj4Gyqww+Du
         l0Flkf3YpkOaAAi+hba4EvpwF9yHjthOhUg9bXroX2nsEdbHHdPUCSrymRppO4llfmrv
         eGGFMAWVa51ULqcoiuuJqh3aFriKxUhvfX/Y7K4dMXBrMLWbCkmUrmjAG8D4MYedCDSY
         NoBCPjhEnYtmWUYlyXt7s8eYmur8sV+qN5qoDxVMZai//XZ43Oz7VHn+txkzCKIm4PU3
         /5DOF9a7cQHm6CYFKrTZQgDxVFVnrprzHJVzP5l1P/gA8JUO7PlHtvO6JK07L4frADLQ
         9WVw==
X-Forwarded-Encrypted: i=1; AJvYcCXRh+J53qxgNOLnOzNnmEHwxvW+lzVTsNAKafGDvdTu2cpnIoJLrLB7mmBy3n2e/WnLCBnM6JIQ68HaQSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYlW9ML+vbDj8uKx320xP2MD0VKLyRGIOx7gzj+DobWIBTf3mn
	u8fhk7HxbfF3XNSgtBMGY7EmWqBdUmPN2KNBbo6Z9dkQFPLeuf55W+IkyZribL1sMjtBEDelGOQ
	hDClCNCPbPfASgdOU+N/xXFgL55tfEaCCOaUlrIcejUhDTvNYEXU=
X-Google-Smtp-Source: AGHT+IEnz1GyTZlftdGpHX3jgxo2wK87KPVx/FAo2DYee8GCdaaTRp24nxaWxYg0SRPKd77LClU0CJyCAJ3uZe9macc=
X-Received: by 2002:a05:6808:180b:b0:3e6:769:b042 with SMTP id
 5614622812f47-3e62cbe6ef9mr2185584b6e.29.1729782323029; Thu, 24 Oct 2024
 08:05:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 24 Oct 2024 20:35:11 +0530
Message-ID: <CA+G9fYs2G_4jyv-V7f85oE53rw5rX0Tnf2V8RQ=O9CuPcbfb2A@mail.gmail.com>
Subject: powerpc: clang-nightly: fatal error: error in backend: Trying to
 obtain a reserved register "r2".
To: clang-built-linux <llvm@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The powerpc clang-nightly version 20.0.0 build warnings / errors noticed on
the Today's Linux next-20241024 tag.

powerpc:
  build:
    * clang-nightly-maple_defconfig
    * clang-nightly-tinyconfig
    * clang-nightly-tqm8xx_defconfig
    * clang-nightly-mpc83xx_defconfig
    * clang-nightly-defconfig
    * clang-nightly-cell_defconfig
    * clang-nightly-ppc64e_defconfig
    * clang-nightly-allnoconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build errors:
----------
fatal error: error in backend: Trying to obtain a reserved register "r2".
clang: error: clang frontend command failed with exit code 70 (use -v
to see invocation)
Debian clang version 20.0.0
(++20241023112211+699ce16b6284-1~exp1~20241023112229.1038)
Target: powerpc-unknown-linux-gnu

metadata:
----------
kernel: 6.12.0-rc4
git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git_sha: fd21fa4a912ebbf8a6a341c31d8456f61e7d4170
git_describe: next-20241024
Test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241024
config:  https://storage.tuxsuite.com/public/linaro/lkft/builds/2ns7sv9TltSifV46KaGs3BxlB85/config
download_url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2ns7sv9TltSifV46KaGs3BxlB85/
arch: powerpc
toolchain: Clang-nightly (version 20.0.0)

build log link:
------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241024/testrun/25530243/suite/build/test/clang-nightly-defconfig/log
  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2ns7sv9TltSifV46KaGs3BxlB85/

steps to reproduce:
------
# tuxmake --runtime podman --target-arch powerpc --toolchain
clang-nightly --kconfig defconfig LLVM=1 LLVM_IAS=0
LD=powerpc64le-linux-gnu-ld


--
Linaro LKFT
https://lkft.linaro.org

