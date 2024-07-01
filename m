Return-Path: <linux-kernel+bounces-236186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8E691DE88
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098F81F22718
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E932414A0AD;
	Mon,  1 Jul 2024 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXaTrbAk"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC2B14D2AC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835124; cv=none; b=dlwNmkwZxYBrB6Sxc6BrlQw4F6byMDE2OnDyNEg1K1l14jHHVDukDN26zxcsdcMNklDI7P8yBiIUJlndnFie8EKqxSNBtEcULY48D7KFtWUp4/ATB4MwBf5gXDmpsIKluivdAwJMZlcwQSZZwlt45fFELbiszkSHPKiawqLByw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835124; c=relaxed/simple;
	bh=gEOE+ocBdbt+fDzHf37CbGhJxzEUg6Nqi3RW68DDFgk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BSWqasreo3sX+Yb1wb6mJfpib7BuY4DlsFfNO/5b3zSZmpN0miQcwO/IuTvNn73STCXJnFnOIsH//hFkt9bu3UnWDVhIk+cqEUoX9fAoHzlL/OW8ilhuc+pbvmzUuIId9A+WI0Lne70WwbJ00chdwav2A1M8A2spS0u4hhUEE+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qXaTrbAk; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-48f59584cbbso1008560137.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 04:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719835120; x=1720439920; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FiDSz9VE0AFUeXEbzLB0AhJfOiLVcxxxs1VWcvfxXRY=;
        b=qXaTrbAk52rnM1E7t5z75cKZtO4O7MwVgJQIySDlOOuqaFu0300pY/zsY9KKUFRVn3
         WflPoapXzwE1tfr4avT9BerwpN4dxGnZ6tZJiQ6eDw7A0U7v4IRi4d8jajSIydYIux3+
         C1iCpkVZwFW6IBh21pQpi4PhDmB3ET8P71cNpSN/m2ES8z+YuxR9f5I9YWjnTDAYcHtE
         jI6xu8MH+Iwe0VYJxVcP2g+nQBx4Fz+qUtKzPtDiNl8rCu+cmjStu+mf48AL1xbxfK82
         pZmOamYimxxiyRnf9Gb7b4RK68xa2TP6E+J1MDAqi7IGAubCUBOxpHzzsDu5ofE0QA9n
         HP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719835120; x=1720439920;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FiDSz9VE0AFUeXEbzLB0AhJfOiLVcxxxs1VWcvfxXRY=;
        b=Ollbq1e7gFoX7rTeS5v9F08QVHhg4nDT7ptsMBqbvek/IurLKV2biAZZ7DuVeaN6SW
         mHyfgMyGvrwRMU0PqEsvW0MzJe0cZgpPUQ2LyVu566I6RwgWl4uamqKEgV6X93k2/DAZ
         XA7LNBCHoC1iIwZ3JoVDjXcxl4jCwlF9gEKXYJvSlKcbJtHgFxH0l6TBKHjOTfvlSOb2
         bwz4pnhheOghSEJxgtfEg+uctXlhoCj83h+mDypiwOgIfJ3CXdxbSy98GsbsqWV5kSUG
         81Sdh3dlk6hV92CU7ieYYEr1XiDg6M+9yFZc5A4+QpZAjTMiMew5zcbdNeMbz9KIObgM
         oVzg==
X-Forwarded-Encrypted: i=1; AJvYcCVZV01N/LsJSi5ctdKC25KzHal/KeZEfZFjwKk4naCdeub82Hn82rYRPg01BhTqDUakZVrhgHBfJPEXdH8Tfsl6fJNZ/Tvh2V+k4pJK
X-Gm-Message-State: AOJu0YymSFkgAgCgKDdJKA3c0KH4Ddr2mxIA1+F5nIkhtMmpd0fgQzT+
	z0/57ce7Yb8/VIebKEVZrbMod4g2FGnhXleWR6oAUcRuRmz1NPPSeZtpVTohs0nmHku34lYKebI
	ksvWJ749hbgnsA/ygJ/nLZCoa7M+h4dtMmbRPfQ==
X-Google-Smtp-Source: AGHT+IHXyYi+vErcz2WdDS+6TqDK+01dX2IbGbbnCkxLEnQrj1qDcp5NDG5b+X0fZ+YTkKJiTZEaWoLMJRjDqFi0TsE=
X-Received: by 2002:a67:f343:0:b0:48f:5abc:8b93 with SMTP id
 ada2fe7eead31-48faf132dc7mr5756721137.27.1719835120661; Mon, 01 Jul 2024
 04:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 1 Jul 2024 17:28:29 +0530
Message-ID: <CA+G9fYsXsbHp+0cWoTjEhkpANOav=GLSjPx5ghtUY-FjMPyoSQ@mail.gmail.com>
Subject: Mainline: v6.10-rc6 boot failed across all arm64 devices
To: Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Aishwarya TCV <Aishwarya.TCV@arm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The mainline kernel v6.10-rc6 boot failed across all arm64 devices and
qemu-arm64 and no crash log found (earlycon) did not help.

But the defconfig builds boot PASS.

The boot problem is with defconfig + Extra Kconfigs and builds links
provided in the bottom of this email.

The boot test history shows that,
  GOOD: v6.10-rc5
  BAD:  v6.10-rc6

We are bisecting this issue and get back to you with git bisect results.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Following is the list of build combinations that boot failed.
Regressions found on qemu-arm64, Juno-r2, db410c, db845c, e850-96 and Rock-pi-4.
 - boot/gcc-13-lkftconfig-64k_page_size
 - boot/gcc-13-lkftconfig-kunit
 - boot/gcc-13-lkftconfig-rcutorture
 - boot/gcc-13-lkftconfig-16k_page_size
 - boot/gcc-13-lkftconfig-libgpiod
 - boot/gcc-13-lkftconfig-devicetree
 - boot/gcc-13-lkftconfig-debug-kmemleak
 - boot/gcc-13-lkftconfig-debug
 - boot/gcc-13-lkftconfig


Steps to reproduce boot failure on qemu-arm64:
----------
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2idWuAb51mcz7lO1BAj8Aw0BrNY/reproducer

metadata:
----
  git_describe: v6.10-rc6
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git_sha: 22a40d14b572deb80c0648557f4bd502d7e83826
  git_short_log: 22a40d14b572 ("Linux 6.10-rc6")
  arch: arm64

Links:
-----
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2idWrbdtwMqpD9wx7IPRGJ7Dsx3/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2idWrYDposdlRsS4jwF916a0qGE/
 - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.10-rc6/testrun/24473346/suite/boot/test/gcc-13-lkftconfig-libgpiod/history/
 - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.10-rc6/testrun/24473903/suite/boot/test/gcc-13-lkftconfig-rcutorture/history/


--
Linaro LKFT
https://lkft.linaro.org

