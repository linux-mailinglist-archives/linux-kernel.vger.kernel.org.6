Return-Path: <linux-kernel+bounces-250368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCE192F6FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FDF6B22099
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6CB14264C;
	Fri, 12 Jul 2024 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kJOIIWU6"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5144413D504
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720773264; cv=none; b=q2D8qCgDReF3AFiY/ysBgDyjMliKuzybWewM9MjQkyHg3bsI0CR067B/dMJSRk5aNaxYlVAYyNmvXexpfbPI255L610EajOhmMn7naAH7QJnpr0YLXXysi5nTQ5ynb/Kj4z11SLYTwPmfk+pIjVb7mnp9giNnBoFhXGpnDbmuQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720773264; c=relaxed/simple;
	bh=hEEcy46RO7V68UI4b8DWMk/Sw0GV6jX3upU1MX1NCNY=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b9Z9eR4xwv6JcDevHDNnj1YaKzX6xbI4JlEkun45WYmTmxUeHXsLtKp4twOzdBppNajgX+sFCMMjlcCNmT5d5Xb5WWv9xnl3M8Ai4YwtCTxEOO4+MUxnHlFAPyIMN7AnRfjj30exwSnrAg/LYBAHQq60cu1b/aPX/9ip+Lik9bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kJOIIWU6; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so23970281fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 01:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720773260; x=1721378060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vNDrI3O2vapYfHdlJEtPCv7zDNFd4Jc3cF7Xop8DfQM=;
        b=kJOIIWU6iYbb3e/kDqehvju41Udhwh9d3UcaqV8cjRFKS1w/PELrXZTcx2jucP9r9I
         aHcTTTO/LElfzYC4YbE1CvrsntLwNJq8e3PsHPTRXPKZMvltvFLooWSokGo/4tx8iiVH
         ytFe/bCtTlDqwyQKuNj4YkbsPNKgsGUymtgfXTl5tOHkswvgijLVAtkiRO8rCmgBQPYY
         PsRj4airLoQ3/4FtUsrVAH94iCTLK/Z2//H9hj/pl0y3vmUm3LIUo8ONRFdvhXDdxMkI
         eZnSRCmEm8DZX9YDcKGXGGPJWiLSBhI4wv/6oJLRfzEEP0neMf60euvDgsBUohyWJyq+
         oHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720773260; x=1721378060;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vNDrI3O2vapYfHdlJEtPCv7zDNFd4Jc3cF7Xop8DfQM=;
        b=UagF3b7W8VKW3XqIKjMTa/iAhry4WvJkunxaWPjcwvLD8md0OKnEowTjZIPVrQm07I
         HxPYG1d36mYSSC8vTp+PpvzsKCE3MWWNg+WbMvJzVuDqlxa0bzld4Zl8ZQYomqYOMX3t
         WlhAJPxhrYxxcYyJfthLuTsrD60Gat1iSwoXM7gzmw6fvPG5l/Rv1H0RmWtUYpFYf2pg
         hdrWVAnZG6mso+h/YAIuofNH5tBAC0wrjaLuvxh+YqhwuampDOxpX5DYVNn+BPGLxSrZ
         DzjglFWPlPJIMPMrrMCzEd5Q3vsWh5BwQNwvX15AVqSw/h3EPFcJc494aBZoEfxeJNf7
         OSHA==
X-Gm-Message-State: AOJu0YwRD5hi3vx83Sr53vzO1/qnEMHyCHxK4sdCctYh5kFbXQeHE34d
	R5dZMrPzwA5pNqQI2Sno4ZU3SEcRrC0dRXYlA/IACR052uNgPj9YNedjHnj4Sdrh49hRey714aO
	+85nZ9aZgCZYEDPQ9UMGMrKgcG5Ii62BYvVoNNQ==
X-Google-Smtp-Source: AGHT+IHVj+wjXgDktMpG8zdUN+g+WLxyO6cDA/LdfvRtCl8Ry37DhiQDAsTV3vRrqH09CAlUDxv6WEACdtb0FfVZuYA=
X-Received: by 2002:a2e:9204:0:b0:2e1:2169:a5cc with SMTP id
 38308e7fff4ca-2eeb30dafd7mr69368611fa.15.1720773260158; Fri, 12 Jul 2024
 01:34:20 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 12 Jul 2024 03:34:19 -0500
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <CA+G9fYuCp7Q71_o74yo9ge_5-G=Ho9bC3kJdX_JvtoqWOQujkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuCp7Q71_o74yo9ge_5-G=Ho9bC3kJdX_JvtoqWOQujkA@mail.gmail.com>
Date: Fri, 12 Jul 2024 03:34:19 -0500
Message-ID: <CAMRc=Md5zmFxXXM89LQs6dspC0xnp_6=z=+a2SQypWjwpiRgow@mail.gmail.com>
Subject: Re: next: arm64: defconfig: gcc-8: drivers/bluetooth/hci_qca.c:2501:2:
 error: label at end of compound statement
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 16:34:35 +0200, Naresh Kamboju
<naresh.kamboju@linaro.org> said:
> The arm64 defconfig gcc-8 build failed [1] due to these warnings / errors on the
> Linux next-20230711 tag. But the gcc-13 builds pass.
>
> LKFT is testing older toolchain support till gcc-8.
>
> The following recent changes cause this failure.
> a887c8dede8e1 Bluetooth: hci_qca: schedule a devm action for disabling the clock
>
> Build errors with gcc-8:
> -----------
> drivers/bluetooth/hci_qca.c: In function 'qca_serdev_remove':
> drivers/bluetooth/hci_qca.c:2501:2: error: label at end of compound statement
>   default:
>   ^~~~~~~
> make[5]: *** [scripts/Makefile.build:244: drivers/bluetooth/hci_qca.o]
> Error 1a887c8dede8e1 Bluetooth: hci_qca: schedule a devm action for
> disabling the clock
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Build data:
> ------
>   * Build name: gcc-8-defconfig
>   * git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   * git_sha: f477dd6eede3ecedc8963478571d99ec3bf3f762
>   * git_short_log: f477dd6eede3 ("Add linux-next specific files for 20240711")
>   * Config: defconfig
>   * arch: arm64
>   * toolchain: gcc-8
>
> Steps to reproduce:
> -------
> # tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8
> --kconfig defconfig
>
> Build log links,
> ---------------
>  [1] https://storage.tuxsuite.com/public/linaro/lkft/builds/2j5nr85T4iLl99RjcJ9oy9O3eo2/
>
> --
> Linaro LKFT
> https://lkft.linaro.org
>
>

The actual code looks like this now:

	case QCA_WCN7850:
		if (power->vregs_on)
			qca_power_shutdown(&qcadev->serdev_hu);
		break;
	default:

What can be done to silence this warning? Or should we just ignore it because
it's gcc 8?

Bartosz

