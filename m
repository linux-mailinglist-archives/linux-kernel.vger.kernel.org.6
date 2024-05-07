Return-Path: <linux-kernel+bounces-171214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE8C8BE149
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD491C21DB2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992F0152DF5;
	Tue,  7 May 2024 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXHPgk64"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F79D156F32
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082207; cv=none; b=KHcBRWZT1kB8bigZ4Qd4yFbQjbagRglrev46vd/yEpw75aci4VhCGsSaOZQops/iRUpJcMyhaPjBHbwTTm/5D4QDNCKVNwV3k9EQRMWtYOqqEEgXuGk57XTPoZNPgYMAkE8vu2MIjHWEX0M7z1T+jF9XG3V3YS1TxmFb9Hl5Jrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082207; c=relaxed/simple;
	bh=YZX31/xdWUMw6K7qdZmLpVzOCZHdmp8lTi6MLLjYx9Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tHWv0FNIL1iNvR6SoEKJvquJWeMgCCVWZDvq+cAQ8iTwMWdGe86zk69pHHw5U1sxsYC1HpvqbUVrhrzKSXzQfKP6QLv8+6szdiXzKb3hsVmc4VBQgXxI/8JNEkyUH8Nj03Wr0xws5SZRwsfnr09VNLiksN19zBvJZgxvx1CcUv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OXHPgk64; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7f4276765d9so2634837241.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 04:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715082205; x=1715687005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jezw8zTsKRwlkPt3DmIU972qZVlDPnjvDD93eRca2nI=;
        b=OXHPgk64lmu0NPZPlZ1nbEqIFNlO+PAVtkTPQhrTRC7gnJZEEKe0Du82rFpQ9x5eSS
         I9DbF7q16evJsJYyyGmUBSLSGNXvlS2Ys04DqSp7Sj2E9ZH9whF+XCbGpoP0bN+uqjkI
         0SlfqdcikG3ZSBiegAMBEE9j57eXGiueetXVWLlaQSmvQITcIf1+PeVM+CC12c/o45zs
         2lBmYPhWCuBJQyVvX3qZ174tej318OuCztHE2Uwae7Pq+nfZHPza4WjueRtuV7c5wnH5
         edcCfukPUSNAcKQu85d35oJkV76d3ervEMYMlC9WXHX1dkHeEu89dYKeyLmkxxSwuEbo
         OGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715082205; x=1715687005;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jezw8zTsKRwlkPt3DmIU972qZVlDPnjvDD93eRca2nI=;
        b=hzaXkcoRcP9L3b7mnpkcSGCvEzzmgdxwvw0c60R3tuqOnth/6FaBzRcwThnkPng1un
         QbbB/QK3xlGrr61c5H9Br+HPG0C/ZhW2ZMBCTySs/hMvc37TaOLFadjRsrLVIqL12wEq
         Dh7GgF8tk68juyft6DTrvSwOmDff1AO3b1NYKuPqDMwTJ46paBvapq9rkLFB4n/m4FHz
         Cnm6Sq8tW9zK31V4GC3CMlprQ1BkwlHuq76zHt4pJC/G6BQhN9uaWWyJu1yvX68J7dLj
         yELOSWQ2k/GYxQ4u3QGifoijt8nuCjgP8b3Reo77Ygn2p984Wuen6q7tB/6SfszclbcO
         SVmQ==
X-Gm-Message-State: AOJu0Yw/bDqDBsCe9k/ho0MmnrikUB5sikOhpH9/iNKZvOdMd0xHc1Ii
	6YAycB0eo1oKGrtsUriooGjhfx0E0e05eK8hwjewboL0J2t/THHpXxdw8ygkhf18s706GmxJODC
	X6TayjAeyPPnw7FiKqWI8zz+2Wz7V6uXJ24yqT2Fc7nkCfzuUYLQ=
X-Google-Smtp-Source: AGHT+IEtGQE+pyFkMzL/qa3sUhz3FvaWcp/TP4GRf97r8j8Uo+tD/7DXDc4rKnywy5BIBSVabAYnwOeZ79pm59KoxNs=
X-Received: by 2002:a05:6102:26c6:b0:47c:296c:5fe3 with SMTP id
 m6-20020a05610226c600b0047c296c5fe3mr2188630vss.9.1715082204799; Tue, 07 May
 2024 04:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 7 May 2024 17:13:13 +0530
Message-ID: <CA+G9fYs1ZN2K=UHOjrwRR2JNE-M0nf9iW_Q-YPzVgmW+9daU4Q@mail.gmail.com>
Subject: arm64: defconfig: gcc-8: failed: AttributeError: module 'argparse'
 has no attribute 'BooleanOptionalAction'
To: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The arm and arm64 with gcc-8 builds failed on Linux next-20240507 tag
with gcc-8 due to following warnings / errors.

arm64 and arm:
  defconfig - gcc-8 - failed

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5-display.dtsi:113.6-121.3:
Warning (graph_port): /fragment@4/__overlay__: graph port node name
should be 'port'
Traceback (most recent call last):
  File "drivers/gpu/drm/msm/registers/gen_header.py", line 970, in <module>
    main()
  File "drivers/gpu/drm/msm/registers/gen_header.py", line 951, in main
    parser.add_argument('--validate', action=argparse.BooleanOptionalAction)
AttributeError: module 'argparse' has no attribute 'BooleanOptionalAction'

metadata:
-----
  git_describe: next-20240507
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 93a39e4766083050ca0ecd6a3548093a3b9eb60c
  git_short_log: 93a39e476608 ("Add linux-next specific files for 20240507")


Links:
---
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240507/testrun/23817782/suite/build/tests/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240507/testrun/23818260/suite/build/test/gcc-8-defconfig/details/

--
Linaro LKFT
https://lkft.linaro.org

