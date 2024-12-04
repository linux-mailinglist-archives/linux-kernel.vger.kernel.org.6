Return-Path: <linux-kernel+bounces-430876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D879E36C5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B3C16937D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141401A256C;
	Wed,  4 Dec 2024 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SkNjvfy2"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3035169AE6
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733305134; cv=none; b=Cx8a0Xm4L1cj3OclEjGExwA96AaYi7ofGFFKglPHhGx9PqJhY/a5dsUImguWlqvCA+cTJngFdvhDwI3Lmak9zSuJLsr5G27ZzilXGXGZj6RFM228g3+fXYmCGZ+oKhvQNaliwl6dYvoZJZfv2/2qFJgw+oqzYn+/b643fQIhUzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733305134; c=relaxed/simple;
	bh=cVgZS49s0jK7LoEEPdTFlt626ZfF0wPZnTB0sTR630c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=l5iIW+flTQfKIipbsRi+nPsPOSdV5aE/kC932IZYLmzS6VXInHfTac0ysn8eJtyYXJtSHHvWISTTzdNm1eqaR4NlzC3ksOkjPHviUdHh+/I0idtyw/5fgU5ne1RkLziTQvm6sS6UQtb0/LiQ8NHyo7vDhEHBQ9wIetyGhOuf8pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SkNjvfy2; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4af6031095bso345816137.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 01:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733305131; x=1733909931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cWUJzDJGc7Svmrjo2Yx287BIq8DOoijbqXVcFkV/Th8=;
        b=SkNjvfy2ziZ/5x5oObfKrjAYIxk/noOamNDYeqlNbIHcWLR+iC9lTvMsRYW4h9SHFj
         d9RD9ACdjfZZ/leuNB1g/RbP1YLQG4u538gBwp97p862x6r+4Pkqqrt5Vj4Lydipa9kG
         b/HOz1DULYXynK7SOTtqy9od9e7aQ0+RO8RGsyrssXFQVr90M8X/r2STyW3VKPfyq1Ps
         j2J/X6NWFWoHmQH7QTJF4Pdbeu6PaFFWji1f976/Dz5zvZmIV4Ih8T+2H6nvPvV+fE52
         qoxreLY04Z+YRPoL0igHkJj2fbtjlnUT+0WjMDLN/h3q2YSY9vsHGHc5/Xll6eBzV8XO
         PqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733305131; x=1733909931;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cWUJzDJGc7Svmrjo2Yx287BIq8DOoijbqXVcFkV/Th8=;
        b=lLHB5RKBITY6I6IuJSgk3dAkj80xPGDZtszyhkUSSgTVvbUbULk+GMuVEaMK8t6E2q
         rJjzp+z/mXd+D44otK0FGRBRatyQR37QtgMyBRtKVpJOEOICq6gno+C3Uhejp2UWc5vn
         dT2eTGunQ2uiOf53loiohHY6rjhCrBmXL2Lb8ldWO83HG0sJEwzmV7rF88zbqDw1F/8W
         1a4dJj8lI+EDOInUhA6Y8XlEQnj8Z/m+jqAh7+h1yMc5SpyZ8NDfd2LhWWns6qjdPZt3
         TF0hsvuhYDRfShSZJ3BhDmuxmu9yQEd5DNFRkPi5ZPzpQGNqxszq5Iz09eQQVaUwlf6P
         9Bxg==
X-Gm-Message-State: AOJu0YyvSX7FfXD7Yg+s+vu4BsqLN+e5zKnbjKyl9SYvyUvVMYoV5Nnc
	U5phxYxkSievAXajLjCZARIPMJ6seTKEwPGI0wL44j2UspibH8UtSQvdr0Lvd/Bw2/Ys1aSVtIt
	gH9ASZh+VQR8n0e63Gypa4Sh1FVeUF9xW4GfsqQ2znXCy3jVfuVo=
X-Gm-Gg: ASbGncuW8DnZmuXfvRbcQTAD1fqKGGyoG07uIlnEfdXUtLzxKqbYd677N4Fh+vrDzv1
	OfELiKh2k9T/x/lR7TeFXsAjQZgP6N9KN
X-Google-Smtp-Source: AGHT+IHa2s2KZFVXgBuDE21MW01ekjk63BnpZQJJFVpTdT6Md53yNFIsgwBWlwO6BnTMW3wblvbpS4cjY/IyxSO907Y=
X-Received: by 2002:a05:6102:945:b0:4af:1614:858f with SMTP id
 ada2fe7eead31-4af98869826mr5567377137.12.1733305131087; Wed, 04 Dec 2024
 01:38:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 4 Dec 2024 15:08:40 +0530
Message-ID: <CA+G9fYv4tUvUj1+rv5AU98QT9P8-RYVTkLAc-fCbLvy3wLtpJw@mail.gmail.com>
Subject: next-20241203: LTP syscalls: name_to_handle_at01 and
 open_by_handle_at01 failed
To: open list <linux-kernel@vger.kernel.org>, LTP List <ltp@lists.linux.it>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Benjamin Copeland <benjamin.copeland@linaro.org>, chrubis <chrubis@suse.cz>
Content-Type: text/plain; charset="UTF-8"

The following LTP syscalls name_to_handle_at01 and open_by_handle_at01
/ 02 tests
failed on the Linux next-20241203 tag.

First seen on Linux next-20241204 tag
GOOD: Linux next-20241128 tag
BAD: Linux next-20241203 tag

List of device :
  - juno-r2 - arm64
  - juno-r2-compat
  - qemu-arm64
  - qemu-arm64-compat
  - qemu-armv7
  - qemu-riscv64
  - qemu-x86_64
  - qemu-x86_64-compat
  - x15 - arm
  - x86_64
  - x86-compat

ltp-syscalls:
    * open_by_handle_at01
    * open_by_handle_at02
    * name_to_handle_at01

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test failed log:
=================
tst_buffers.c:57: TINFO: Test is using guarded buffers
name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (0)
name_to_handle_at01.c:98: TBROK: fstat(1,0x7fffda449ce0) failed: EBADF (9)

Summary:
passed   1
failed   0
broken   1

tst_tmpdir.c:316: TINFO: Using /scratch/ltp-B0Mf6pVtaR/LTP_opehXJa6X
as tmpdir (ext2/ext3/ext4 filesystem)
tst_test.c:1860: TINFO: LTP version: 20240930
tst_test.c:1864: TINFO: Tested kernel: 6.13.0-rc1-next-20241203 #1 SMP
PREEMPT_DYNAMIC @1733269464 x86_64
tst_test.c:1703: TINFO: Timeout per run is 0h 02m 30s
tst_buffers.c:57: TINFO: Test is using guarded buffers
open_by_handle_at01.c:101: TPASS: open_by_handle_at() passed (0)
open_by_handle_at01.c:97: TBROK: fstat(1,0x7fff409f94e0) failed: EBADF (9)

Summary:
passed   1
failed   0
broken   1
skipped  0
warnings 0
tst_tmpdir.c:316: TINFO: Using /scratch/ltp-B0Mf6pVtaR/LTP_opeN4blFw
as tmpdir (ext2/ext3/ext4 filesystem)
tst_test.c:1860: TINFO: LTP version: 20240930
tst_test.c:1864: TINFO: Tested kernel: 6.13.0-rc1-next-20241203 #1 SMP
PREEMPT_DYNAMIC @1733269464 x86_64
tst_test.c:1703: TINFO: Timeout per run is 0h 02m 30s
tst_buffers.c:57: TINFO: Test is using guarded buffers
open_by_handle_at02.c:98: TPASS: invalid-dfd: open_by_handle_at()
failed as expected: EBADF (9)
open_by_handle_at02.c:86: TFAIL: stale-dfd: open_by_handle_at() passed
unexpectedly
open_by_handle_at02.c:85: TBROK: close(1) failed: EBADF (9)

Summary:
passed   1
failed   1

Links:
---
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOWmHmfmcNEt4XL6h7GdVCZf/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26192368/suite/ltp-syscalls/tests/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26192368/suite/ltp-syscalls/test/name_to_handle_at01/log
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26192368/suite/ltp-syscalls/test/name_to_handle_at01/details/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26188858/suite/ltp-syscalls/test/open_by_handle_at02/history/

Steps to reproduce:
------------
- tuxmake \
        --runtime podman \
        --target-arch arm64 \
        --toolchain gcc-13 \
        --kconfig
https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOWmHmfmcNEt4XL6h7GdVCZf/config

metadata:
----
  git describe: 6.13.0-rc1-next-20241203
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git sha: c245a7a79602ccbee780c004c1e4abcda66aec32
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOWmHmfmcNEt4XL6h7GdVCZf/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOWmHmfmcNEt4XL6h7GdVCZf/
  toolchain: gcc-13
  config: gcc-13-defconfig-lkftconfig
  arch: arm64

--
Linaro LKFT
https://lkft.linaro.org

