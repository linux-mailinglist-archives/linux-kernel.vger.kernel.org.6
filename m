Return-Path: <linux-kernel+bounces-195351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 980878D4B69
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48DAF284F3B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63541C9EC4;
	Thu, 30 May 2024 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xLeVl6UO"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AF81C6892
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717071667; cv=none; b=o5peGqrxj6somDIjfCFiiUQ4V1WBWI6R5Mo+wHN1uRCZ4SJR6LiJmUfGzjGTIwctGne9wHVJhCSykieb614SMHt/CvGLZgWHjafBcRxNX5SRHvbxqdbpKGxZK/wb8iFlEprqP9pwQNtjWl6NdTmIvESU/y243ZBfBZb5A0Gkr9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717071667; c=relaxed/simple;
	bh=8HQgs2bIZJeSzUXXR37T/KQj003N1PicGc6R84rQ6b4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=teebO1v65ibllnM32BumcZGifFJoToTR+vJd+3rQdyGYmX4W5u7OMBARlZ8VlYw4to3yv7sPzQZw1TkR4xHjtgAl2KKw2xuoc7/SKGmYjRDcRp4SppzqlY02k06QNJcn3sWqucXCchp63uLXjwy6Vs509HVDXVgAi/uEZPvWWj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xLeVl6UO; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4e4effccfccso250892e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 05:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717071664; x=1717676464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v1Y4EC+Vl3y/mxPDgl8+ARcytlJRa8bN9srCkIlilYA=;
        b=xLeVl6UOpgZyms91NDPZhq2WJixK7ulxAx46PSmUt08zV4WeF0ekxPu6GYj/qpfon/
         CzjP8Iu8RNgH3x/7tTjZJOB9p3d/mOyIpiEdvlMWwgRJSKKMFeW1geSSampTVKdMLZtv
         VcBfvah7+3V4RNjlCYP6Uolw4e0XxNdq7cLLetaFuw/OC+fzsPkSqTMBHvAiAxRObA9d
         VizgUOusIgD6mPyyhWAHdVhw5I5wNgSvR/Jcu1seSLlrsRrCrcC65oW//k94xQkSrhgP
         qHcs5+yHvIE+NrwelHvmVQWlU73rMD67H5tWLirGYwS/3DSvfb5U1Qf8qr89tbKXaOAo
         eCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717071664; x=1717676464;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1Y4EC+Vl3y/mxPDgl8+ARcytlJRa8bN9srCkIlilYA=;
        b=SBNtrXhM6bcB9JKhCs94tA8q0Y+memuZRjaB0ZupX1MDx1/Rf1bdbiOhGUulS2dASe
         XrSCsWVkvAEIh8aWVxqEFb0GSPnzEJ7p6Uc58KrfUBDBPh2DV2gBXRZ3o7Q6aeQ3QYBl
         NhEBZopGYTBarAj49B94tZTLPiRviEaLkBkAH40tZdyFQa62eLi6zxiujpdgDGATFhWb
         Cbt70q2VyQFhDF6H4FC6O1mfnOVkERxmQ1Oovpp8qjNUSx+Fhrrp6R74mqMxPxYbBu32
         TpX/QcDlh6X08RSGhC2UUo0f1nho7eHa0bEXHN+aEFMLUwA8IfRhLtRmI8Luhm1h+n+g
         jLZA==
X-Gm-Message-State: AOJu0YwEv/bLAhxu0jXfGoMdxRIJpep1FyAdkByYRo+seAP+XnG+c7Zm
	sYv66V+KD05ours0f22bi+hDqyShFt9yi0NdJy9C2iESA0h1Bx4eQRxaIDzRg4N1NWTzGREp6Zi
	52jbwgX0hfNKwVe0ZNWSP85jo33NRhQ/2GWARzuRq9de+HL0086o=
X-Google-Smtp-Source: AGHT+IF8N1bqnuXOjZNpSTjG4359awFqoPkPrI5tsAypoZsac9kT1nKvP1mjv7Cjntk3JR1XaZe3bUmc9hbvrM4pRhE=
X-Received: by 2002:a05:6122:319c:b0:4e4:ecd0:fcba with SMTP id
 71dfb90a1353d-4eaf21a9480mr2299111e0c.7.1717071663960; Thu, 30 May 2024
 05:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 30 May 2024 17:50:52 +0530
Message-ID: <CA+G9fYuZ+pf6p8AXMZWtdFtX-gbG8HMaBKp=XbxcdzA_QeLkxQ@mail.gmail.com>
Subject: arm-linux-gnueabihf-ld: kernel/rcu/update.o:update.c:(.text+0x1cc4):
 more undefined references to `__bad_cmpxchg' follow
To: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, rcu <rcu@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, eeraj.upadhyay@kernel.org, 
	John Ogness <john.ogness@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

The arm builds failed on Linux next with gcc-13 and clang-18.

Config: arm imx_v6_v7_defconfig - failed

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
-----
arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function
`rcu_trc_cmpxchg_need_qs':
update.c:(.text+0x348): undefined reference to `__bad_cmpxchg'
arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function
`rcu_read_unlock_trace_special':
update.c:(.text+0x41c): undefined reference to `__bad_cmpxchg'
arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function
`trc_read_check_handler':
update.c:(.text+0x4b0): undefined reference to `__bad_cmpxchg'
arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function `trc_inspect_reader':
update.c:(.text+0x1518): undefined reference to `__bad_cmpxchg'
arm-linux-gnueabihf-ld: update.c:(.text+0x1548): undefined reference
to `__bad_cmpxchg'
arm-linux-gnueabihf-ld: kernel/rcu/update.o:update.c:(.text+0x1cc4):
more undefined references to `__bad_cmpxchg' follow
make[3]: *** [/builds/linux/scripts/Makefile.vmlinux:34: vmlinux] Error 1

metadata:
  git_describe: next-20240529
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_short_log: 9d99040b1bc8 ("Add linux-next specific files for 20240529")
  job_url: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/2h944W0LTbtfMPlDNiOq17hXpQ8

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240529/testrun/24129266/suite/build/test/gcc-13-imx_v6_v7_defconfig/history/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240529/testrun/24129266/suite/build/test/gcc-13-imx_v6_v7_defconfig/log


--
Linaro LKFT
https://lkft.linaro.org

