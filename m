Return-Path: <linux-kernel+bounces-249379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BE892EAD8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CB5284927
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BE6167DB8;
	Thu, 11 Jul 2024 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="egmESOME"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA53167D98
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720708491; cv=none; b=haBKduU0Gb2/3e/uymjOEL5FjGNTYJ1KQr9744ciO/cI8n0tdi0eY9v2T1uaI1SY/rb7R+S0wskrI/JR8ksd2uRvQWed88W5PMyhbkreetgpTUtDyGnnNul1b+a+mpcvDmXMc6kvFSbj7FPwO3LHp1wF31WnSuarTdwQGCFxF7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720708491; c=relaxed/simple;
	bh=OtD5w4O17pfucl+CttlNKi56rcMH+DmgjTajFT8Nxt8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=th7PN0Xl5FozaH1Jl8i9AiKnrdVZqTjd9wyhQiMqMFoTG2TIdf8pks8109MMR74CR0/WJ62c8mxGRZIKi4fzKxS7HUcRi1iERqQl1z2hOU/ftp6z6U3CzJXOIduL/wVw86Slkukvf2Xs+TEiCt3NX1OoxfIuYp+rNMtLC+xSBLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=egmESOME; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-48c2d353b01so320289137.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720708488; x=1721313288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ia5VWAmVE202W09H7T09ZTGBTXMKlnDirEHWYCjYaBI=;
        b=egmESOMENIPvDOX6aEbrA+yEGlCxZu3THFfqPWS7HYRF1dUhCXgH7WAfvCMU6jDgIE
         QVDE8k7DVMBYdp6gBLx49sMw/ZiCSpu7cGSFGwiYx4nzTYfcf/LcBdp3YagqEkCq4KXw
         oBz54KtJ1A/4VbcFUu8T7wg604bajltIns/OM13Zo264+aJBcx5cQcarcqxq2v/j9pb8
         BbV0kCz9DhNiwQmqZRbvLB2lH3ioDIwV1ALfe7uy2a/A4PTX0hfoCsMwCuCzzBJxSu9L
         Mo4kjtUvRl2QJ0Qq/Qb+W7TE2j2gEcedJkb/dzRV8tn6KGzhojVyG6dUxYmHkOZGhqxn
         0pzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720708488; x=1721313288;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ia5VWAmVE202W09H7T09ZTGBTXMKlnDirEHWYCjYaBI=;
        b=vDwYCgkSBCv2DqWCAg2/ly8LYMbRP0E8ENHtyY5mDCpgg40z4cSxwT38CUo1qiZ4/m
         /HmQFqdNFVcxGuDa1L5Vv1lDB8eJuGVHNNOojW6I0h3iZs4XFdDAUeyliYovLTAraoH3
         WP9FCXBZKntQ0jyVzB2rkmy1BYbK1HZ/IYEUlNxZTceTTzGUspw+ZiAhVtYP4t910ciE
         RtZ6bSMBWmxx8G+bn/IctvQcnT+x/+B2y3jXWcDXaILF3wQPFTeiP31blBFJdGVrO8dI
         Mua+gUw5AqYqn33b3MBTCnPtnYp9GFz/r/x+48XHtaHMhnhG0RB7AjolOvTsSu4M2U4b
         am8A==
X-Gm-Message-State: AOJu0YyInVDlK7JXJbMndcQXGnuSu4Uk9DQNpr8l36ZrJCqc5vCQITrp
	LUWEuXK3eRdmmOTgTKhF6utZFOZVFMKTCni0vVIWSKtcnmLf95dgtBVGIgzlyatzgmjBI1U+0VS
	Rv2rWXZ8mtD3HLZAoWNdrjK4RQB6PQskJqU27Kar52OWfBiwwQvodlA==
X-Google-Smtp-Source: AGHT+IGCovsJEmu4vcWA6S0y5OBnGLGLrTJ/HdK6Mh5oMR1bLky3o6bI6znsvDSf0rf/E6g7mqNlBRzXFhPOel2+Uto=
X-Received: by 2002:a05:6102:3713:b0:48f:dec0:b6bf with SMTP id
 ada2fe7eead31-490320f7414mr11258733137.4.1720708487053; Thu, 11 Jul 2024
 07:34:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 11 Jul 2024 20:04:35 +0530
Message-ID: <CA+G9fYuCp7Q71_o74yo9ge_5-G=Ho9bC3kJdX_JvtoqWOQujkA@mail.gmail.com>
Subject: next: arm64: defconfig: gcc-8: drivers/bluetooth/hci_qca.c:2501:2:
 error: label at end of compound statement
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"

The arm64 defconfig gcc-8 build failed [1] due to these warnings / errors on the
Linux next-20230711 tag. But the gcc-13 builds pass.

LKFT is testing older toolchain support till gcc-8.

The following recent changes cause this failure.
a887c8dede8e1 Bluetooth: hci_qca: schedule a devm action for disabling the clock

Build errors with gcc-8:
-----------
drivers/bluetooth/hci_qca.c: In function 'qca_serdev_remove':
drivers/bluetooth/hci_qca.c:2501:2: error: label at end of compound statement
  default:
  ^~~~~~~
make[5]: *** [scripts/Makefile.build:244: drivers/bluetooth/hci_qca.o]
Error 1a887c8dede8e1 Bluetooth: hci_qca: schedule a devm action for
disabling the clock

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build data:
------
  * Build name: gcc-8-defconfig
  * git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  * git_sha: f477dd6eede3ecedc8963478571d99ec3bf3f762
  * git_short_log: f477dd6eede3 ("Add linux-next specific files for 20240711")
  * Config: defconfig
  * arch: arm64
  * toolchain: gcc-8

Steps to reproduce:
-------
# tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8
--kconfig defconfig

Build log links,
---------------
 [1] https://storage.tuxsuite.com/public/linaro/lkft/builds/2j5nr85T4iLl99RjcJ9oy9O3eo2/

--
Linaro LKFT
https://lkft.linaro.org

