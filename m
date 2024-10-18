Return-Path: <linux-kernel+bounces-371151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7999A3718
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08731F2353D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3125E18A6C1;
	Fri, 18 Oct 2024 07:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6tYRWfV"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C933188901
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729236376; cv=none; b=AgvPfsNksqEndRIuPH1fsF9nBHduz4nATd3rMfufFaOPh+7HBuH8yGGfm2MKmq6Kygew5E992i5QJNPCnyUu7Mg8c6zN+/m46UGFjDdboO9RiGuaswAce5JXgMkfhsGIuJcC0NfZXIhVh8xROg2vvn/NsRSWlJiBBFUx3p0QoQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729236376; c=relaxed/simple;
	bh=+ThqRqTmtPY/PQjy0QZGOVcGlJssgbmHUwKG+5/KdP4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fDHa9B+x+rny9ySnuZOi/q0501XOYGzu2aB9UH2aye0Xh9G0ctHLgC+8YCK9rtqnydMfxopU/c0kLo3PcjYm0Y90gfek4kEo44AW+RrA06YGvSi8SZFGYcl0frP4DNJGo8KtLfRL9PGTl88TfMEXFeLbXjiXD/rX4CCEpYuFd6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a6tYRWfV; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-84fc0209e87so615065241.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729236373; x=1729841173; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=piiFALoQ7z5HAKzAwidaLMXt4WFJputVxFgFqSQ8Dsw=;
        b=a6tYRWfVb+5AzIiKUE6F7Mx2ZBnqQftkRZpsgfgvOwrU63IP4lVOWd6c+5li4Ycy+l
         PA5IQ3udqBSDPiFwuJY0EVA6j6CJcu8XF+aoP5xktYcOtcbw6yPZge/MKICxzdFYmsqI
         jEpBPUJaNK5StSHXiKn819FQwH7dfFSUM33Br3oKknQGsfQlq2kbbuYTp2uQoPxX1iiy
         5bpOzVDLY1VhZMRAPRlH3a54kJrrpy/mqbR/Z8xzAPnsF/q8nmj6b4a+L05X6iFyGxXp
         JKm5vT4KD62qC28cCd373dJHbyrmLNMqW1BaOT6TbacLisLR5GRBegB36LxeV2gQrlty
         wn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729236373; x=1729841173;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=piiFALoQ7z5HAKzAwidaLMXt4WFJputVxFgFqSQ8Dsw=;
        b=E8G9v/WR0QG6LDrFcb9JuFJWQNodwDc8H34dAkDElJjyrnfqV3brV+gMS1J8NOV/0m
         vrFOYTTBQTaZZH8mFxwtGGMupFcB5U3BagSXWujB8pMLSAsCMs2ndk0QeEbM6sC3dvSz
         QW54lr2AebCe0vA+m1wY21W99u1xuppMmRoklWFUeUsi9BTuW1/uuzGDGaVP1zpmU5DH
         1SqNwKLXV1D+aEl+1omdOUa3m4IJw8VcFu54PKYxY/ZDvu90Y8RRMjMLzDqtBRF21Wol
         hjFUymp2b20gHaxfrdvaOUuU9979a9lV7C3SrviVDsdoiQKw271ZyXwVTGbGCDx/lYde
         dJ1A==
X-Gm-Message-State: AOJu0YwJs4oGwbLYdWIFlhghS/JQXvubh+VuiCVbtqtPpTjEeqogVBTp
	0J7/To1h1bqDhrTrtY44lUOygTgYENb9sTwRhGtEupEFQKjjexeart1MFZyJUhfBjVKQTr4Khrx
	K1KSjheBkKB39TaftcyTUMYL8BAg8LxHF8mEqH5IJgwDJZ+Xw7bM=
X-Google-Smtp-Source: AGHT+IEDuknEZ7zRw7JqileQVNCYUrrUoiK9et5lckka/21EGUZiz4WBPeJonXMswilj/CNUKIzQ6VeF2HZtz3KX07Y=
X-Received: by 2002:a05:6102:956:b0:4a4:97d1:aea0 with SMTP id
 ada2fe7eead31-4a5d6a92561mr1705997137.11.1729236372962; Fri, 18 Oct 2024
 00:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 18 Oct 2024 12:56:01 +0530
Message-ID: <CA+G9fYvx05D7TfRjvdPtKM9iWS6i7b-EHuBAbHEQghvMEg221g@mail.gmail.com>
Subject: Qemu v9.0.2: Boot failed qemu-arm64 with Linux next-20241017 tag
To: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, qemu-devel@nongnu.org, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Peter Maydell <peter.maydell@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Aishwarya TCV <aishwarya.tcv@arm.com>
Content-Type: text/plain; charset="UTF-8"

The QEMU-arm64 boot has failed with the Linux next-20241017 tag.
The boot log is incomplete, and no kernel crash was detected.
However, the system did not proceed far enough to reach the login prompt.

Please find the incomplete boot log links below for your reference.
The Qemu version is 9.0.2.
The arm64 devices boot pass.

This is always reproducible.
First seen on Linux next-20241017 tag.
  Good: next-20241016
  Bad: next-20241017

qemu-arm64-protected:
  boot:
    * clang-19-lkftconfig
    * gcc-13-lkftconfig
    * clang-nightly-lkftconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Boot log:
---------
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
[    0.000000] Linux version 6.12.0-rc3-next-20241017
(tuxmake@tuxmake) (Debian clang version 19.1.2
(++20241001023520+d5498c39fe6a-1~exp1~20241001143639.51), Debian LLD
19.1.2) #1 SMP PREEMPT @1729156545
[    0.000000] KASLR enabled
[    0.000000] random: crng init done
[    0.000000] Machine model: linux,dummy-virt
[    0.000000] efi: UEFI not found.
[    0.000000] Capping linear region to 51 bits for KVM in nVHE mode
on LVA capable hardware.
...
[    0.000000] Kernel command line: console=ttyAMA0,115200 rootwait
root=/dev/vda debug verbose console_msg_format=syslog
systemd.log_level=warning rw kvm-arm.mode=protected earlycon
...
<6>[    0.305549] SME: maximum available vector length 256 bytes per vector
<6>[    0.306214] SME: default vector length 32 bytes per vector
**
ERROR:target/arm/internals.h:923:regime_is_user: code should not be reached
Bail out! ERROR:target/arm/internals.h:923:regime_is_user: code should
not be reached
<nothing after this>


Boot failed log links,
-------------
 dmesg log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241017/testrun/25475692/suite/boot/test/clang-19-lkftconfig/log
 test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241017/testrun/25475692/suite/boot/test/clang-19-lkftconfig/details/

Build image:
-----------
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2nYi294C2rkwmj8hWZ0XnFcTd7F/

Steps to reproduce:
------------
   /usr/bin/qemu-system-aarch64 -cpu max,pauth-impdef=on \
   -machine virt,virtualization=on,gic-version=3,mte=on \
   -nographic -nic none -m 4G -monitor none -no-reboot -smp 2 \
   -kernel Image -append \"console=ttyAMA0,115200 rootwait
root=/dev/vda debug verbose console_msg_format=syslog
systemd.log_level=warning rw kvm-arm.mode=protected earlycon\" \
   -drive file=arm64_rootfs.ext4,if=none,format=raw,id=hd0 -device
virtio-blk-device,drive=hd0

metadata:
----
  git describe: next-20241017
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git sha: 7df1e7189cecb6965ce672e820a5ec6cf499b65b
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2nYi294C2rkwmj8hWZ0XnFcTd7F/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2nYi294C2rkwmj8hWZ0XnFcTd7F/
  toolchain: clang-19, gcc-13 and clang-nightly
  config: defconfig
  arch: arm64

--
Linaro LKFT
https://lkft.linaro.org

