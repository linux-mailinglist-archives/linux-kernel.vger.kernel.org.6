Return-Path: <linux-kernel+bounces-373337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E929A5565
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D5D282930
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 17:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88DB1957E4;
	Sun, 20 Oct 2024 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DTQFAvqs"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E0C195FEA
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729446013; cv=none; b=hcPS9w9ES4w4mtpsihyANqkVt5Es5NYT0zaOXHJHeV2hFBWhoNP+SJB2V/eNcD7iEX11agf2qbnlMSgQBN+scNgDc5JUMsMmqDRRbV9EawQhpoVr8rCxUy54CBYBqxwFEfbQVctFiID8Y9q//idWmT5i19e//QHFkd8zEhx9XiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729446013; c=relaxed/simple;
	bh=/MZUMPHP1MmyAsHFI3p+nistd/d0UbV6Cq7ocTvO5bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/39b5QaXcskgDr1rhOd6N+GsiHP37VUyOgE+GJIo6HQwW/ZZjXpe05pksMdT0lcpMvEHCvis3gv2Ku649lLP6tqx2JrPpH034CMCjgVv9oDaDtfOSxhAi90sTw0Ji5dtwKge55Yg7vYjM0SmiuauiZUY3m02ZzybpDEJ4kLgOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DTQFAvqs; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-84fc1a5e65bso1091984241.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 10:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729446009; x=1730050809; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5dQElZmdOpFlm9UG88kAU1LTaBVdJQXUvWqA3Tf+jXw=;
        b=DTQFAvqs4s4TN76QccpoLbJs8XZvaHMkG64oh1IGRr9IJqVADM+MBZhH4hFlF2NREm
         X7VlsTFhrK0/eRNywhZPoxQgEWD5L7l1MIzEhmRbZbucO6EVHfkJ/j4K2O6c4tlwlFNX
         7k1o8o3FOoyUGLrqHDmRyWiCrkrmRgpLuWSbRqzep7o6XVcIGN2aMTzE0y8FO0RT6XNW
         /MnyWnR/EvSWrXL437nyDPk3JniR8ATmATkJILUyZh9CyZtzq6n2DziWEz3AbF05oLo5
         QVRS4zNXIrJrq5nQytKO1abVOkZCKy8bmiUoOygjY5VI7hQVNphfA6GYm1HzKNqg+r+t
         9sHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729446009; x=1730050809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5dQElZmdOpFlm9UG88kAU1LTaBVdJQXUvWqA3Tf+jXw=;
        b=Cf6AZ3FGLTDaGxEs9USUdfygNQ6o4jJAHIwzd/LDpp3FgapcoMMMslYv1v/0gWdoZn
         E2yagKYtfe3lMWRhmpRc0iYe0JZYdfqT6DSyBf4tSH+Bj4lqEWcqKrOa/JXLUm3jYgOb
         t61xSp+P7FsnS3DWHPCFpwcVfSOXbo7P4Yev2eMF8fDPu41kkdqIGRwcNM+ebR4ZDQ6s
         0IOudX496ZKUUnb1ZOiO9BSiqcrWVk3PRxcNJRr5H95Yn8BBwOoAY/+zc28hN4afEsDQ
         sEgmUu4TcO9t0LhbeFlf4Os3ltfyitzHgOUVEZ0O5Wts5Drt/OdnArVnQhLxpgNvs2c3
         BQZw==
X-Gm-Message-State: AOJu0Yw9tCp404syvUmgUE3exsmkriVn1axHEDQEIgZsUBCOJUnkBHei
	rAgrLHg10ZiQTfK4wRsXSkP33asIOqtelkuktn91MICMm8nWjY+5oivJ3NDuHnvIqPLXXxjfisP
	jcQLX4HoQERY/aVh9QquqP0dcWOkmtPjO8RMEnUNpShN+w0df4nk=
X-Google-Smtp-Source: AGHT+IG4vi/NuEfb80CzvtYT1ihWDnjiE86tCBRUI0Pm+Ge1Bb280g9GXaYQ34p3oxV9/F2MPuI42yWtHFMEmMGjwcQ=
X-Received: by 2002:a05:6102:3a0d:b0:49e:94e8:acd5 with SMTP id
 ada2fe7eead31-4a5d6b746e3mr8432271137.22.1729446009509; Sun, 20 Oct 2024
 10:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYt86bUAu_v5dXPWnDUwQNVipj+Wq3Djir1KUSKdr9QLNg@mail.gmail.com>
In-Reply-To: <CA+G9fYt86bUAu_v5dXPWnDUwQNVipj+Wq3Djir1KUSKdr9QLNg@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 20 Oct 2024 23:09:57 +0530
Message-ID: <CA+G9fYsMg0fA-jraEvC==0a-22J97o-uBmbLJt16_ZKBpOT8EQ@mail.gmail.com>
Subject: Re: Qemu v9.0.2: Boot failed qemu-arm with Linux next-20241017 tag.
To: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, qemu-devel@nongnu.org
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Aishwarya TCV <Aishwarya.TCV@arm.com>, 
	Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Oct 2024 at 12:35, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The QEMU-ARMv7 boot has failed with the Linux next-20241017 tag.
> The boot log is incomplete, and no kernel crash was detected.
> However, the system did not proceed far enough to reach the login prompt.
>
> Please find the incomplete boot log links below for your reference.
> The Qemu version is 9.0.2.
> The arm devices TI beaglebone x15 boot pass.
>
> This is always reproducible.
> First seen on Linux next-20241017 tag.
>   Good: next-20241016
>   Bad: next-20241017
>
> qemu-armv7:
>   boot:
>     * clang-19-lkftconfig
>     * gcc-13-lkftconfig
>     * clang-nightly-lkftconfig

Anders bisected this boot regressions and found,
# first bad commit:
  [efe8419ae78d65e83edc31aad74b605c12e7d60c]
    vdso: Introduce vdso/page.h

We are investigating the reason for boot failure due to this commit.

Anyone have noticed a similar qemu-arm boot regressions with
the Linux next-20241017 and  next-20241018 tags ?


> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Boot log:
> -------
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 6.12.0-rc3-next-20241017
> (tuxmake@tuxmake) (arm-linux-gnueabihf-gcc (Debian 13.3.0-5) 13.3.0,
> GNU ld (GNU Binutils for Debian) 2.43.1) #1 SMP @1729156545
> [    0.000000] CPU: ARMv7 Processor [414fc0f0] revision 0 (ARMv7), cr=10c5387d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
> [    0.000000] OF: fdt: Machine model: linux,dummy-virt
> [    0.000000] random: crng init done
> [    0.000000] earlycon: pl11 at MMIO 0x09000000 (options '')
> [    0.000000] printk: legacy bootconsole [pl11] enabled
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] efi: UEFI not found.
> [    0.000000] cma: Size (0x04000000) of region at 0x00000000 exceeds
> limit (0x00000000)
> [    0.000000] cma: Failed to reserve 64 MiB on node -1
>
> <nothing after this>
>
> Boot log link,
> -----
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241017/testrun/25476340/suite/boot/test/clang-19-lkftconfig/log
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241017/testrun/25476340/suite/boot/test/clang-19-lkftconfig/details/
>
> Build images:
> ------
>  - https://storage.tuxsuite.com/public/linaro/lkft/tests/2nYi2nidfMq35VigDlxJblZzokr/
>
> Steps to reproduce via qemu:
> ----------------
> /usr/bin/qemu-system-arm -cpu cortex-a15 \
>           -machine virt,gic-version=3 \
>           -nographic -nic none -m 4G -monitor \
>           none -no-reboot -smp 2 \
>           -kernel zImage \
>           -append \"console=ttyAMA0,115200 rootwait root=/dev/vda
> debug verbose console_msg_format=syslog systemd.log_level=warning rw
> earlycon\"
>           -drive
> file=debian_trixie_armhf_rootfs.ext4,if=none,format=raw,id=hd0 \
>           -device virtio-blk-device,drive=hd0
>
> Steps to reproduce with tuxrun reproducer:
> ---------------
> - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2nYi2nidfMq35VigDlxJblZzokr/reproducer
>
> Boot history compare link:
> ------------------------
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241017/testrun/25476340/suite/boot/test/clang-19-lkftconfig/history/
>
> metadata:
> ----
>   git describe: next-20241017
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   git sha: 7df1e7189cecb6965ce672e820a5ec6cf499b65b
>   kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/tests/2nYi2nidfMq35VigDlxJblZzokr/config
>   build url: https://storage.tuxsuite.com/public/linaro/lkft/tests/2nYi2nidfMq35VigDlxJblZzokr/
>   toolchain: clang-19, gcc-13 and clang-nightly
>   config: lkftconfig
>   arch: arm
>
> --
> Linaro LKFT
> https://lkft.linaro.org

- Naresh

