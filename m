Return-Path: <linux-kernel+bounces-371098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F20F9A3670
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 506B3B22E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5791A17C7A3;
	Fri, 18 Oct 2024 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hvTN4Szf"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE1520E33D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235129; cv=none; b=jEC/E5Q70tjS1Ukh3nDcIvPayAQH6tKYeFJ85wHUJEpXp0HTJANqr9WMb/jkbabIZNZExqC5P/C8rqrzrj6vyxwLK72GzV6PHkFuniA4VX1ybSGrYqVOeGvMbr5lJ2DkVo9sM115y/De1tHI9r+YfVPPpnWcQ3AFbmevk5C9NoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235129; c=relaxed/simple;
	bh=UD1X7+y4g7xOHbFbP2xrOZwrUf3MVbc6tglEQbeFGag=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=o5VyUFTKL9BeZvJoytdX0hhm8W48pX+Mit3czMiAXAf/QrnGOwA8IK+2htFpFu7fQoNsPbakR7128b4uF0EkqLmrk5bF/OFUGCNeYQzWP/DvPYTc6Nw7A8rqC1S9rYEL5rylazXoXBSajYiulQ6SDztejIpHdRrh0pHLscGWNeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hvTN4Szf; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4a5ad828a0fso529893137.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729235125; x=1729839925; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3EsDn71iKRJbsLqCH6cdyCF8oxK7HkDcTIVHp+N4J44=;
        b=hvTN4SzfeDHnbtNMxnLMn/kHSIav7tEoR4etNilFHbL+beRU6K1Wjf1EmGK8UrtUaI
         ycWgvXJ59sSJnopOdvGJKaQdJmDsCTXSDCcJcsMc5UEJ7UChcWI0A87rAiOpuZCRnGf2
         QaNw/6FYIVFRDOicyyl0hFc9UuuKKoBKMblU6TuM+FeeR1LQhhb1X3+mPb0yGRPoIqto
         ul2aclJ+tRlpcQsIpq5unZ0mg0lpDwROlRNLH0699Hwj7X5F2YXc/suLN3pxAFH6vVog
         HalubfVVK1RIjkw+9AW6riwEOXoQAc3FEt34yJXu20YTC/7FQTIB7Qm+/wiV2NypG7xV
         5Vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729235125; x=1729839925;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3EsDn71iKRJbsLqCH6cdyCF8oxK7HkDcTIVHp+N4J44=;
        b=S2WyPZjOtQ01In8IfuTg//MKAASAgtHP4n8nwluhXgQC4JWHE0X9D+DnN/cgYtaTs0
         SzPgx4nMVwKGs2cj80b1uuhl7RJFWoO/GGsMmM4g8pUqw28puD192wXQDbmGq3uQT0Dv
         Q7+VfHygllgS3uqlWanHp9NIAM50AVXtTmq7srPMSrRWevgHXxi4lo49+xY8h67gy0cz
         8y3dDSJOFggmAOXf/RP06Gq7GXvpfwwuAvZ/lxGHS63XEHj5XXolqzfg4ymc/fo/a+Cr
         V5AliElHUwYQstNBmEoc1MNhSZ//G8E2LOsPd1GQMMHb7SXjOkxMXUY8Dt4+gZGW9jkk
         5wfw==
X-Gm-Message-State: AOJu0Yz1qQgMbx0gST2gIYBcxQZ9kLHjRzpWq34BFo3ncP0LzxOzeFx6
	O1HdUPtnOzLcZtFXD5qqZdT0u0UvD2PPRmHMDINpnDAlbeCwZZ3PawHx2PBRIfMeiCkH+P5nHOB
	PdcqxrE/PvZXcTEJP4hQBVNOYqz0/JeJoyPocc+waSix1qdLptNs=
X-Google-Smtp-Source: AGHT+IEMKaiswjTQniXEOdUFmx1XXP3WE2nVkQ6nLj/7XG+PW7CpRN/Fzi2UzGnsKtcggkXYx1K6vFJBvNS/bVGOk1s=
X-Received: by 2002:a05:6102:e0d:b0:493:bcbd:4633 with SMTP id
 ada2fe7eead31-4a5d6a8c469mr1644327137.3.1729235124950; Fri, 18 Oct 2024
 00:05:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 18 Oct 2024 12:35:13 +0530
Message-ID: <CA+G9fYt86bUAu_v5dXPWnDUwQNVipj+Wq3Djir1KUSKdr9QLNg@mail.gmail.com>
Subject: Qemu v9.0.2: Boot failed qemu-arm with Linux next-20241017 tag.
To: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, qemu-devel@nongnu.org
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Aishwarya TCV <Aishwarya.TCV@arm.com>, 
	Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The QEMU-ARMv7 boot has failed with the Linux next-20241017 tag.
The boot log is incomplete, and no kernel crash was detected.
However, the system did not proceed far enough to reach the login prompt.

Please find the incomplete boot log links below for your reference.
The Qemu version is 9.0.2.
The arm devices TI beaglebone x15 boot pass.

This is always reproducible.
First seen on Linux next-20241017 tag.
  Good: next-20241016
  Bad: next-20241017

qemu-armv7:
  boot:
    * clang-19-lkftconfig
    * gcc-13-lkftconfig
    * clang-nightly-lkftconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Boot log:
-------
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 6.12.0-rc3-next-20241017
(tuxmake@tuxmake) (arm-linux-gnueabihf-gcc (Debian 13.3.0-5) 13.3.0,
GNU ld (GNU Binutils for Debian) 2.43.1) #1 SMP @1729156545
[    0.000000] CPU: ARMv7 Processor [414fc0f0] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] OF: fdt: Machine model: linux,dummy-virt
[    0.000000] random: crng init done
[    0.000000] earlycon: pl11 at MMIO 0x09000000 (options '')
[    0.000000] printk: legacy bootconsole [pl11] enabled
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] efi: UEFI not found.
[    0.000000] cma: Size (0x04000000) of region at 0x00000000 exceeds
limit (0x00000000)
[    0.000000] cma: Failed to reserve 64 MiB on node -1

<nothing after this>

Boot log link,
-----
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241017/testrun/25476340/suite/boot/test/clang-19-lkftconfig/log
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241017/testrun/25476340/suite/boot/test/clang-19-lkftconfig/details/

Build images:
------
 - https://storage.tuxsuite.com/public/linaro/lkft/tests/2nYi2nidfMq35VigDlxJblZzokr/

Steps to reproduce via qemu:
----------------
/usr/bin/qemu-system-arm -cpu cortex-a15 \
          -machine virt,gic-version=3 \
          -nographic -nic none -m 4G -monitor \
          none -no-reboot -smp 2 \
          -kernel zImage \
          -append \"console=ttyAMA0,115200 rootwait root=/dev/vda
debug verbose console_msg_format=syslog systemd.log_level=warning rw
earlycon\"
          -drive
file=debian_trixie_armhf_rootfs.ext4,if=none,format=raw,id=hd0 \
          -device virtio-blk-device,drive=hd0

Steps to reproduce with tuxrun reproducer:
---------------
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2nYi2nidfMq35VigDlxJblZzokr/reproducer

Boot history compare link:
------------------------
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241017/testrun/25476340/suite/boot/test/clang-19-lkftconfig/history/

metadata:
----
  git describe: next-20241017
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git sha: 7df1e7189cecb6965ce672e820a5ec6cf499b65b
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/tests/2nYi2nidfMq35VigDlxJblZzokr/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/tests/2nYi2nidfMq35VigDlxJblZzokr/
  toolchain: clang-19, gcc-13 and clang-nightly
  config: lkftconfig
  arch: arm

--
Linaro LKFT
https://lkft.linaro.org

