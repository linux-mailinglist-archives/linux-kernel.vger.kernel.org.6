Return-Path: <linux-kernel+bounces-569502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E988A6A3D0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93821897834
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016C621B9E3;
	Thu, 20 Mar 2025 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tf1ma4cZ"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965B8214A98
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466930; cv=none; b=Q1CO/XHvEtCe/a/7Hi5NW7lCMzh+iJSVdBidLj3RtRsqm0usu4+aNyIS4c72oJN842oJoKFzAuNpEM6hOeDo/VbNM7/9RjZpRHTmngwApYlBxel4qabORaapxwj9LFyUzbTo1G2gVSUveEziZeHvk4pygLnc67pq00Gl5o3cpMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466930; c=relaxed/simple;
	bh=M8mW4s6BuNVC0zyYzObEj84z39LsA78lVPS2iSnewdM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=M7RMnTR6oSUzS+ek7utCacsqE10T36vH9b9SpSLsBfGq3/SUMyhctRkjPIuEi65wHucyTncHAWvrNhqS9XzwHyqY8NYoliQvjpZJrcB/JD1uibnj24TblWyPrVqrRKdnC/uVYkPkAkmarzJBoYR4XhznDauoLf5OtBS7Pz5Lij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tf1ma4cZ; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-867129fdb0aso556677241.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742466927; x=1743071727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ocw3fLNrrR6m3zSnxHaViU7nn/Q0W3Q5BAYr9jcJ8fw=;
        b=tf1ma4cZD0xtuEX7rTlbEH6CzsxD+OQeOiimwsHHN0lxT0E3JtCzhHSLy3r6aCXPJX
         fmfKuc/CFoxXThjJxjSGGfbUHaS1yWWdGZuWB0lnub/bTCLDok7XFnx7VBC4GHLlDdey
         hvICmJ8PSCwm/v7bn5ovsvb2xMfYtSLbdFnD5TMKVhQvXILCczN9/TYN4wonM3VfpNzH
         SRVnXCqFOSnIZMpjVM8aeIbPmylsdUGLnSXX7HZ2Hsjh0/p7uIdJuOOuH2O/CrjZK+ut
         Cb93ckVnx53+j3to9Jt9ejZfCXNiNvhI9gm5qsYdEVkomZsieFo87LQcEw7ZaWNsbPOI
         wsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742466927; x=1743071727;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ocw3fLNrrR6m3zSnxHaViU7nn/Q0W3Q5BAYr9jcJ8fw=;
        b=joxnfG6Td3/nu68kpi+5G4A8x6IlrdV0qL0LFS1bECGkAoidW7hmbx2yInmCbX+YjK
         WGaZYIoG2eTGUJ+2Q/Pe5rYklkXSzXPWOkc4hVr5j6Z5zr4SxRm0RZiBV6qPzTzP1J4S
         8cMxitSdfvVk/yT4cunzBiOh3hCdm2naDSNy9Wut6fCsbs8AYprJbT1qYpcdoAeCEufC
         6+01qpYUtqgJq92hT4+xZo1rM6IhZdR+jsH2j+9dIqki9jl1O4AGBzZsap6VyKnENJr+
         kHiwOhxbQn8LfstGrnbIAx5NXImhw5vCnie+Td/ji5+tLlHmjXOKy2pISb9J1TSuSCP6
         WBxA==
X-Gm-Message-State: AOJu0Yy6EWZhMxroSBVKRlNWpd5xAJu/6z/wiPYGpH62rj9D2QgPKBEY
	x/6ZirjKKFQ+9Ye7C1i9FXBpTqtiZObsRrFX3/QKZW3Gt/uUZxI13Gjo/Z8yewRwAKxdK7UoizX
	GoszhbiDK1uXPtjIcWUys3C+/G2MVGv4PW78GxyrrxPOi7VZK
X-Gm-Gg: ASbGnctaHeVJfTyPHs1wKEfClj8ERNELLFT/MoSbKn2FjtU6Q8rQDJl7ODY8pSEFGzS
	SnaVX7ghMSakEr4RspGwOiMVpTgpEF0Gs09T4velgm2zurcDqRGGuXb8ISKQea3IA9/3CV5I2+K
	HWHUkkRwyCfNnYtD/MHWnLfmaxfemWKKCOK+uWsfTNtNDp4KmPH0fUt68=
X-Google-Smtp-Source: AGHT+IHIeZliyhb9LyS7D2WsjQ6zbb6VPBN1WoAf3qf5XM+D1B5bbRyzduTdvwhUu6cWsbXVY+l4bLVoqYBV0hktqrw=
X-Received: by 2002:a05:6102:3f11:b0:4bb:e36f:6a35 with SMTP id
 ada2fe7eead31-4c4ec691efcmr4815712137.14.1742466927194; Thu, 20 Mar 2025
 03:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 20 Mar 2025 16:05:14 +0530
X-Gm-Features: AQ5f1JrfSwLIxsvWRpKUwQXjWhqD0LlnNy1w9lDb63teXByQKV_Jsn0_BBUeIPc
Message-ID: <CA+G9fYtucEt8Hp6RsV0o+OWSz1E=hXBvhHa-P9C-bPnb7cyGaQ@mail.gmail.com>
Subject: stable-rc: Fast model boot fail Internal error Oops BTI - kernfs_iop_permission
To: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org
Cc: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Content-Type: text/plain; charset="UTF-8"

Regressions on arm64 Fast model (FVP-aemva) boot failed with stable-rc 6.13.

First seen on the stable-rc 6.13.8-rc1
 Good: v6.13.8
 Bad:  6.13.8-rc1 (v6.13.7-242-g14de9a7d510f)

Regressions found on FVP:
 - boot

Regression Analysis:
 - New regression? Yes
 - Reproducible? Yes

Boot regression: Fast model boot fail Internal error Oops BTI
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
  LKFT is currently running FVP Fast Models version 11.24.
  Planned upgrade to the Fast Models version 11.28 in this sprint.

## Boot log
[   12.812790] Internal error: Oops - BTI: 0000000036000002 [#1] PREEMPT SMP
[   12.812886] Modules linked in: drm fuse backlight ip_tables x_tables
[   12.813120] CPU: 6 UID: 0 PID: 136 Comm: udevadm Not tainted 6.13.8-rc1 #1
[   12.813245] Hardware name: FVP Base RevC (DT)
[   12.813317] pstate: 163402809 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=-c)
[   12.813450] pc : kernfs_iop_permission+0x4/0xe4
[   12.813585] lr : inode_permission+0xb8/0x174
[   12.813728] sp : ffff800080d63bb0
[   12.813796] x29: ffff800080d63bc0 x28: 0000000000002e2e x27: 00000000fffffff6
[   12.813978] x26: 0000000000000030 x25: 2f2f2f2f2f2f2f2f x24: 61c8864680b583eb
[   12.814161] x23: 0000000000000000 x22: fefefefefefefeff x21: ffffa991682c84b8
[   12.814344] x20: ffff0008006704d0 x19: 0000000000000001 x18: 00000000fffffffb
[   12.814525] x17: ffff000801bf8021 x16: e0acaabd2f000000 x15: ffffffffff000000
[   12.814711] x14: 0000000000000002 x13: ffffffffffffffff x12: 0000002e00000000
[   12.814893] x11: 0000002d00000000 x10: 0000002d00000000 x9 : ffff0008006704d0
[   12.815076] x8 : ffffa991665f0ff8 x7 : 0000000000000000 x6 : 0000000000000000
[   12.815253] x5 : 0000000000000000 x4 : 0000000000004050 x3 : 2f7375622f737973
[   12.815432] x2 : 0000000000000001 x1 : ffff0008006704d0 x0 : ffffa991682c84b8
[   12.815613] Call trace:
[   12.815670]  kernfs_iop_permission+0x4/0xe4 (P)
[   12.815830]  link_path_walk+0x2b8/0x388
[   12.815962]  path_lookupat+0x68/0x120
[   12.816073]  filename_lookup+0xe0/0x1e0
[   12.816196]  do_readlinkat+0x6c/0x1d8
[   12.816337]  __arm64_sys_readlinkat+0x20/0x30
[   12.816481]  invoke_syscall+0x40/0xf8
[   12.816623]  el0_svc_common+0xa8/0xd8
[   12.816765]  do_el0_svc+0x1c/0x28
[   12.816904]  el0_svc+0x38/0x68
[   12.817050]  el0t_64_sync_handler+0x78/0x108
[   12.817203]  el0t_64_sync+0x198/0x19c
[   12.817359] Code: a8c27bfd d50323bf d65f03c0 d503245f (373806c2)
[   12.817444] ---[ end trace 0000000000000000 ]---


## Source
* Kernel version: 6.13.8-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: 14de9a7d510fcfb3bd35e275eda09724bda4d440
* Git describe: v6.13.7-242-g14de9a7d510f
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.7-242-g14de9a7d510f/

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.7-242-g14de9a7d510f/testrun/27684866/suite/boot/test/clang-20-lkftconfig-no-kselftest-frag/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.7-242-g14de9a7d510f/testrun/27684866/suite/boot/test/clang-20-lkftconfig-no-kselftest-frag/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.7-242-g14de9a7d510f/testrun/27684866/suite/boot/test/clang-20-lkftconfig-no-kselftest-frag/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2uXZoz8Lc7Ue3i4mVWAM8Y800oz/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2uXZoz8Lc7Ue3i4mVWAM8Y800oz/config


--
Linaro LKFT
https://lkft.linaro.org

