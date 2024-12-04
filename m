Return-Path: <linux-kernel+bounces-430961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0CF9E3794
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42242164164
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA621E009D;
	Wed,  4 Dec 2024 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kaFXz3tY"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152FC1DB527
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308285; cv=none; b=HOXChvrcNmaxdtX6iTXgUzwHn2wEAtbzT2wgTgz8tS+Wkbrd0yDlano2bW1LPAGji5cRW/rPG9Mc6VBEQHtub/zE1ja5AvJY+JsXfVe9VtudnR6oBGRsvLPIUgBZYWHJdtqxsptysjF9dv1jsR6wsQVpoVOxPqvZRdt+SQYeLzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308285; c=relaxed/simple;
	bh=vAsH6MnaEk9q60JG7f9rI5ko+v1PT6qYTJsjyeNqYbI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZMfpPpMPvmzPL370VgSW/aKFIGkiIK5pkK8aHaW6UbDFynTdbGOl1QXYSSXXy5ENzPPR1xDBUO5ewJQ75kP7c29xvk6GANiigSw9cjVWlqyExk00Xfn/4IWcq37cgUihuT2t7evI4p5cyImslmWNsdqafnLk8ZT6qe0U2nVLpPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kaFXz3tY; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-515c7971553so406427e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733308282; x=1733913082; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MHZqGoUWlClziZon67vL+ZIDd0uUbSc5vRlqScvdhAg=;
        b=kaFXz3tY0GIbrT1g86GIl81ycSxWM5x/AYiH1t7zEmCioFYr3RPsV0/V7/JF3cYCzE
         Z0b/7d0FWEHLBD8QMTmMDV55NOqy7WIyRnO6ZWa5ZLQ4G5i+vlPE19nlIZLTKe4w+8du
         Oyw2oqRkwc5R9NFRZEkXmb64szvafHkK9RmwBbXTR9aY2WzCve8y69lAOCyk9KWtFUA2
         AE9WEnzm/9C1QGOgZ4BS9F4XZCQxsdruZt4tnPcdRszREbAgo2dJq9lc0ZNLxNIZoi9B
         cWVRjFhyH3Mw3d2iOwVsZwVx08mKPBzfBehuHzCkOAruWN90WcbvfijtNHynBNO/ontZ
         Nsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733308282; x=1733913082;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MHZqGoUWlClziZon67vL+ZIDd0uUbSc5vRlqScvdhAg=;
        b=jJbpe+dyDbXtqmOhr//ephggUIX0KId6bYFjbKA1KWRAdKl8Wc9yX5xxm6nAanNi2e
         nYR8OlsHpvEWG+LwhQL5o+PBxfv1tpYg5Tarq/6991QsOXPSGKHvIJ4zrC7kmTHHu4qh
         YqO+hJ9mwPlQsVPWIjdIhDqM0iURYXHuqHZM/p29KlhF4uNqi8pckVgTOrYWxKu0vpF4
         yyZGypvbZccmtq9o8RrWbC6NBTTpW2G+RCJwWijKK8urzU6Sh+JlC4Ichqlmmz/bs33/
         9lvy9QU0gK3fHx8nE18m8Mz6iP8Xy4mtGhu53XFuLWsBw0Ov08rXVayoFhhIDBqKhjWd
         kbxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7LXtkqSJULxVpn3z8xtjNfGwQI6C6UouxQQG2zEDuC3ZGl6p6MBQZEgXZs9wXZMmUb4iIYQ/wJmdewJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzHBlKq4xw4sT2Zykfz/28pLMlWjBdmaVzLgdGuJD7plIOd5r6
	iXDPpXdQQzPxnndK5eaov9HyWX5v5eGQzx5J25SE+Y/tVQ/Dck6v/t1mGA9dd7oQM6kSYSPTfOK
	aKGsOLq12Htx0X0ZAjme7NrtoCZbGC4wEwAF7+g==
X-Gm-Gg: ASbGncsGMQG5kyKuLdlHPwqKVPhPtSunrgTxgTFYdI3aHLz0N/+aJCiqrBP9tEvRFLj
	2ALbIKYbQcXFi5raBpfR7RXnS/OtkyqMj
X-Google-Smtp-Source: AGHT+IGzmWUJVmPN1eOgu9kN8rAcGofAl+lpuZp+XiCWblexF4Qy5RN+9yN7Hxl4Y5rZ7gNdO/a89AZ+ZMppZu2Bfcc=
X-Received: by 2002:a05:6102:26d5:b0:4af:3fc1:e02 with SMTP id
 ada2fe7eead31-4af973825d7mr6798788137.27.1733308281831; Wed, 04 Dec 2024
 02:31:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 4 Dec 2024 16:01:09 +0530
Message-ID: <CA+G9fYsD7mw13wredcZn0L-KBA3yeoVSTuxnss-AEWMN3ha0cA@mail.gmail.com>
Subject: s390: block/blk-iocost.c:1101:11: error: call to '__compiletime_assert_557'
 declared with 'error' attribute: clamp() low limit 1 greater than high limit active
To: linux-s390@vger.kernel.org, clang-built-linux <llvm@lists.linux.dev>, 
	linux-block <linux-block@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

The s390 builds failed with clang-19 with defconfig on the
Linux next-20241203 tag due to following build warnings / errors.
Build pass with gcc-13 defconfig for s390.

First seen on Linux next-20241203 tag
GOOD: Linux next-20241128 tag
BAD: Linux next-20241203 tag

List of arch and toolchains :
  s390 defconfig with clang-19

s390:
  build:
    * clang-19-defconfig
    * korg-clang-19-lkftconfig-lto-full
    * korg-clang-19-lkftconfig-hardening
    * korg-clang-19-lkftconfig-lto-thing

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
===========
block/blk-iocost.c:1101:11: error: call to '__compiletime_assert_557'
declared with 'error' attribute: clamp() low limit 1 greater than high
limit active
 1101 |                 inuse = clamp_t(u32, inuse, 1, active);
      |                         ^
include/linux/minmax.h:218:36: note: expanded from macro 'clamp_t'
  218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
      |                                    ^
include/linux/minmax.h:195:2: note: expanded from macro '__careful_clamp'
  195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_),
__UNIQUE_ID(l_), __UNIQUE_ID(h_))
      |         ^
include/linux/minmax.h:188:2: note: expanded from macro '__clamp_once'
  188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),
                 \
      |         ^
note: (skipping 2 expansions in backtrace; use
-fmacro-backtrace-limit=0 to see all)
include/linux/compiler_types.h:530:2: note: expanded from macro
'_compiletime_assert'
  530 |         __compiletime_assert(condition, msg, prefix, suffix)
      |         ^
include/linux/compiler_types.h:523:4: note: expanded from macro
'__compiletime_assert'
  523 |                         prefix ## suffix();
         \
      |                         ^
<scratch space>:38:1: note: expanded from here
   38 | __compiletime_assert_557
      | ^
block/blk-iocost.c:1101:11: error: call to '__compiletime_assert_557'
declared with 'error' attribute: clamp() low limit 1 greater than high
limit active
include/linux/minmax.h:218:36: note: expanded from macro 'clamp_t'
  218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
      |                                    ^
include/linux/minmax.h:195:2: note: expanded from macro '__careful_clamp'
  195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_),
__UNIQUE_ID(l_), __UNIQUE_ID(h_))
      |         ^
include/linux/minmax.h:188:2: note: expanded from macro '__clamp_once'
  188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),
                 \
      |         ^
note: (skipping 2 expansions in backtrace; use
-fmacro-backtrace-limit=0 to see all)
include/linux/compiler_types.h:530:2: note: expanded from macro
'_compiletime_assert'
  530 |         __compiletime_assert(condition, msg, prefix, suffix)
      |         ^
include/linux/compiler_types.h:523:4: note: expanded from macro
'__compiletime_assert'
  523 |                         prefix ## suffix();
         \
      |                         ^
<scratch space>:38:1: note: expanded from here
   38 | __compiletime_assert_557
      | ^
2 errors generated.

Links:
---
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26188938/suite/build/test/clang-19-defconfig/log
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26188938/suite/build/test/clang-19-defconfig/history/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26188938/suite/build/test/clang-19-defconfig/details/

Steps to reproduce:
------------
# tuxmake --runtime podman --target-arch s390 --toolchain clang-19
--kconfig defconfig LLVM_IAS=1

metadata:
----
  git describe: next-20241203
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git sha: c245a7a79602ccbee780c004c1e4abcda66aec32
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAPS9UrJkbAKFHktQei7eqW4Y/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAPS9UrJkbAKFHktQei7eqW4Y/
  toolchain: clang-19
  config: clang-19-defconfig
  arch: s390

--
Linaro LKFT
https://lkft.linaro.org

