Return-Path: <linux-kernel+bounces-321997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9F397228E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4432A1F2404A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A90189F3B;
	Mon,  9 Sep 2024 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="McQhAUrL"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5C418A933
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 19:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725909962; cv=none; b=diXXaep4hfSbwaayh1H3CawZMyxAX7H9m/EBjmyK59o76M2qZJX5tlN+lm6wTTm7oC227FlJb4K/pXosHsXXr8TdAbF6uFeMr2Avlz5R2WtaeDr69a7//f4AMOU32n2r7eMDy3Bal96pZO6D9prWbjOsIuBwKXBd7iV8MaMfIqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725909962; c=relaxed/simple;
	bh=S4Ygl1q4oE/nlsw28pJGGexRStDbpMtSh4YiL/SHCPU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QFeT22jdUbv+ZNh16xBPPUVdK/WMUYz8hJCaJ220U3jIR5Qdyv/xhRUVHidZwkdg7CMBsL1TEXuWRpC/kQfLjqaCGpDcmZ667bxmYaFhYwAEX4RBS2HYTCiAAR8KptS2kMiXuQd2UqSIqEo4GtZ57HRF3IAEHpxqxOkPz5iFI98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=McQhAUrL; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5011af33774so1494707e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 12:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725909960; x=1726514760; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pBpee4AHaJe65pM2kNypO8RGjnF5LmfGxGgPOtmOqKo=;
        b=McQhAUrLy5EV8sXr9hL6eT+fZ09dPKL/D50ns4PyCyTo4NpTB3NrOH36xLYaZ4T+xq
         SANa/cJ7nzMEJbIIq+Nf3scBQK1dWyAKW/rq+gZ2t8IWS8qwpoPRsj2Q5o8SEtScdIzX
         J8gL5QgZ0Gdn0A+aNrxU3MjJrg96+CwTIP49B54OkvRx928dR6/ATII3RFcayUYNRtDC
         zTrsALgZsJQZwzYIVKFhS/aCTdXLfAGp2i1l6uEA2qr3DMuTm42L/8sXA83mGMuAbion
         /G1TsDiW7erKtPcRRQnfomCJxAw9m1Vdd972+ER61hZzXWji5e8FVzsAYsyK6NclNHF/
         Heag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725909960; x=1726514760;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pBpee4AHaJe65pM2kNypO8RGjnF5LmfGxGgPOtmOqKo=;
        b=CQ3dkdiLzoWQDhLDXkNJM2O4aiWUTA2KfDdGCPecT+vFpbIi8wbdeAx+Lzf+F4YvOh
         SyrcKuEqMrrVRSoiVqudiKK+NUf5f5Xdhf9PfbSgqPDB2/IQ/zjLtDmxFS7TUlWkuGL5
         neVR339VwlPyPn0NXnWZLN0bobP8cQsoP3c50L9UYyaPRefPwW9fRzsqv74mSZpPBIEl
         exvwORn9gTl+9xyPCqW9KLU34WEhNysNQhH2Fg+VKamndCDEjVRAdm7IYlqwMYHSAj1E
         dlVdA5XtUWFgy2B4aELizwwIRWtAxBzOl92eMy9gQrNYVLt+KlAs4vdIWFJibDqXNOtX
         OmWw==
X-Gm-Message-State: AOJu0Yxbh8Zd7Axc+Y6gN2fmqvW9qNmpyf/s2Obqt4Gsc019+NDhuH3L
	L8XUUa3CKX3w+tViCK4kevYgwkKHhCnAMuI9tb/RbqVM1EcNQYF60+YOPFx/KDMPsja4btTp+cY
	DlQZR/QyEJu8F4eQ6riutMHK4EhIg/FLTsU6AXlBBUXP5+c1fO9A=
X-Google-Smtp-Source: AGHT+IEuduoGf6I4eJ+GJljoEMZ5wo3n99jpHThb2kz/K2C5nP569Myd6UaP/RNPBRmaqTmAcfa+nDK0fFyCJafEFIg=
X-Received: by 2002:a05:6122:168d:b0:4ed:145:348f with SMTP id
 71dfb90a1353d-50220c7bb1emr14141759e0c.12.1725909959674; Mon, 09 Sep 2024
 12:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 10 Sep 2024 00:55:48 +0530
Message-ID: <CA+G9fYvG3Tv-Gk6f6oSTuY4=sJWMcF5oRc9Qe1otFvetysm4zw@mail.gmail.com>
Subject: No rule to make target 'arch/powerpc/boot/dtbImage.ps3', needed by 'arch/powerpc/boot/zImage'.
To: open list <linux-kernel@vger.kernel.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>, naveen@kernel.org
Content-Type: text/plain; charset="UTF-8"

The Powerpc cell_defconfig and mpc83xx_defconfig builds failed on the
Linux next-20240909 due to following build warnings / errors with gcc-13 and
clang-19.

First seen on next-20240909
  Good: next-20240906
  BAD:  next-20240909

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

build log:
--------
make[3]: *** No rule to make target 'arch/powerpc/boot/dtbImage.ps3',
needed by 'arch/powerpc/boot/zImage'.
make[3]: Target 'arch/powerpc/boot/zImage' not remade because of errors.


Build Log links,
--------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240909/testrun/25078675/suite/build/test/clang-19-cell_defconfig/log

Build failed comparison:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240909/testrun/25078675/suite/build/test/clang-19-cell_defconfig/history/

metadata:
----
  git describe: next-20240909
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git sha: 100cc857359b5d731407d1038f7e76cd0e871d94
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2lpXzh3wwbuC6nYpMV2nPNA0IpF/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2lpXzh3wwbuC6nYpMV2nPNA0IpF/
  toolchain: gcc-13, clang-19 and clang-nightly
  config: cell_defconfig and mpc83xx_defconfig

Steps to reproduce:
---------
 - # tuxmake --runtime podman --target-arch powerpc --toolchain
clang-19 --kconfig cell_defconfig LLVM_IAS=0
 - # tuxmake --runtime podman --target-arch powerpc --toolchain gcc-13
--kconfig mpc83xx_defconfig


--
Linaro LKFT
https://lkft.linaro.org

