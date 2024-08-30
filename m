Return-Path: <linux-kernel+bounces-308140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5259657C7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972FC1F24171
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA1F1531D9;
	Fri, 30 Aug 2024 06:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="onULnD5D"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F033F9
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725000324; cv=none; b=jeyjnyuBs52tPin08/WNGFgANuJYOYSHhqGNoVLSHR+fKgKeAaFwDW97/SkwwhbWOTr98Ah2jvRQ1NXE3xPMaNlbtMhVzbizQcF0x9Cci8H2WmmFaADYIOmwWRYDowF1zR0lUkqFySKKRhxnz74tky7BKFp8wQ8NVE9ytWsEfAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725000324; c=relaxed/simple;
	bh=z2tMGYCX6QIF8USqnak/joMuhfj1TNUKUkBSSXPLdCM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hhu3obWsCgQV88E1ZmiqEjyinDgI8mEkS7UZd227OOvXKjSDTwsj0TQPeUg4Bh89qJETPixbmzJ895AuxfKqx8KQ4bAqELW75bX0/IoGXlkRhb0n9GTefaLS95GxUlM8C7pSdo/F5OZTP5ARvyayzLOv5vgfeGXeKmImJKPRNW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=onULnD5D; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-498c4f251ffso537357137.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 23:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725000322; x=1725605122; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rbpFfZAAGy+MvWzUwDXlPYpxkRy+IDxVTjCRFwW+Hxg=;
        b=onULnD5DYFXABHGCMnKSyHk14Xi4dryTbgdudbvQ7KFyHG49TPBLHFRPo00GcwxnR7
         1TzXAGo18BXREU+eLc2xl5Mc/pfyoBqiN6WgJtPP8AeAj6lRnFE+f2WlO93O9Aa9lFNI
         vZM8ATraLidDJOp4A9xBr5OioJsiYoJJyp143jbmT3i0moeD6U/DviT7wTIWYy6lWK9X
         nwjPyhwZkeTsAHkWLXIQemKG8JeEpxTPb5XenkB/p+ae0YzR3fsJmzeH/ZflaQPbdzAD
         9++ozQdjOPv4qi44Tu7RmA9NBQsfDEqM0yhnTcHGC9Hpnx2/KpA+PiicU8D3K+lmMOrd
         qs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725000322; x=1725605122;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rbpFfZAAGy+MvWzUwDXlPYpxkRy+IDxVTjCRFwW+Hxg=;
        b=AGzqzEPBHPnr1iErH3p9KJpKc+h2MuL+dKXJMAMB+QKFUyGva7suwrR69Hc23o9T3L
         VBMMzSIBKrAilqJfGEuQZYvakFTpRqc+b3exnTZ1Q5zrCWGsL3BMikmKs7OmuB1Vp4Om
         gpkYHtXnjaKKlikwSUMcY0ma/0uep0KcAMfvMhqovtw7GqMfc4mLIyzfa/MEs8YfgNXv
         z0vWDIJysibT0zOUGwIg+vMWRMl1Iadx6c4/HbZq01I+fnngAlSBrAfgIUzwa2lhbSdq
         5YoeMIwa5Ni70FMV1nRGu69Ry2Xse6n8EEbOW4ERDBPf/+7mJ/Caicn/MlLQhu4Q9HxQ
         mVtw==
X-Forwarded-Encrypted: i=1; AJvYcCUxN0rrFDMhTiUiqy2vF4IEzom1pqxeOTZC9vxxsO1DCHOcHfv0OvcEJlQDWdaG1EkBlo2cGl3WSZPfFFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjUO8B3KHl6txDGToIwtpqlwiqoi9ZDeKmFXELV4nOxRy3IurU
	ApvFpyBh4djyMq3lTXtcf0bBgOQFOV9ZUGi+qYWg59VcMyVJVhvva1Zwoxcu5dj6QkqELn1s8SD
	D79cS3Kbofn8bds7WVjaOBguidEC3vIgzP2K7yA==
X-Google-Smtp-Source: AGHT+IGjtT+iRsWBRGw877rPBsoWnB7aehlawvTFpCsFP81H03YlByPMlEYvHuWNIHaoPnc0CqKmfajXR5onhPoZMMU=
X-Received: by 2002:a05:6102:3754:b0:498:ccd9:5b1e with SMTP id
 ada2fe7eead31-49a5b017424mr6994044137.4.1725000321654; Thu, 29 Aug 2024
 23:45:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 30 Aug 2024 12:15:10 +0530
Message-ID: <CA+G9fYtemFfuhc7=eNyP3TezM9Euc8sFtHe4GDR4Z9XdHzXSJA@mail.gmail.com>
Subject: net/xfrm/xfrm_policy.c:1286:8: error: variable 'dir' is uninitialized
 when used here [-Werror,-Wuninitialized]
To: clang-built-linux <llvm@lists.linux.dev>, Netdev <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"

The x86_64 defconfig builds failed on today's Linux next-20240829
due to following build warnings / errors.

Regressions:
* i386, build
  - clang-18-defconfig
  - clang-nightly-defconfig

* x86_64, build
  - clang-18-lkftconfig
  - clang-18-lkftconfig-compat
  - clang-18-lkftconfig-kcsan
  - clang-18-lkftconfig-no-kselftest-frag
  - clang-18-x86_64_defconfig
  - clang-nightly-lkftconfig
  - clang-nightly-lkftconfig-kselftest
  - clang-nightly-x86_64_defconfig
  - rustclang-nightly-lkftconfig-kselftest

first seen on next-20240829.
  Good: next-20240828
  BAD:  next-20240829

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

build log:
--------
net/xfrm/xfrm_policy.c:1286:8: error: variable 'dir' is uninitialized
when used here [-Werror,-Wuninitialized]
 1286 |                 if ((dir & XFRM_POLICY_MASK) == XFRM_POLICY_OUT) {
      |                      ^~~
net/xfrm/xfrm_policy.c:1257:9: note: initialize the variable 'dir' to
silence this warning
 1257 |         int dir;
      |                ^
      |                 = 0
1 error generated.

Build Log links,
--------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240829/testrun/24977652/suite/build/test/clang-18-lkftconfig/log

Build failed comparison:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240829/testrun/24977652/suite/build/test/clang-18-lkftconfig/history/

metadata:
----
  git describe: next-20240829
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git sha: b18bbfc14a38b5234e09c2adcf713e38063a7e6e
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2lKF49FRX1FB3IVv46cfZc30s9y/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2lKF49FRX1FB3IVv46cfZc30s9y/
  toolchain: clang-18 and clang-nightly
  config: defconfig

Steps to reproduce:
---------
 - tuxmake --runtime podman --target-arch x86_64 --toolchain clang-18
--kconfig defconfig LLVM=1 LLVM_IAS=1

--
Linaro LKFT
https://lkft.linaro.org

