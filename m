Return-Path: <linux-kernel+bounces-322031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 982CD972312
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2086B2311E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4020717C9B8;
	Mon,  9 Sep 2024 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v2jVB5ST"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C165638DD4
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 20:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725912021; cv=none; b=aGWKyK2hA+/RB9sN8QclH2cfwnG1HiQX8SEcuI/rJWJ+SVXCzjDaifhPLhMa3NAEamsVGoOGUOo9f69db/cbYCxCKtb093X62rJKpKcbqA5DOuY4C378T+aDrkLqk6y9CpxntoXll8Xxz0vYbIR6wJBJzKTfJS3+FCfBrKVyQqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725912021; c=relaxed/simple;
	bh=8/TvT9oqjC1ec3RS1uICF4xbEfMJ/Z619X5P9ftS19k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=noyPOOPqhIkI1kMJrbg2T5BOl9LKclAFyvlbi6yVPenwE3ixCD9X5dWWcY1fErK2cLTYkzVsjZHmAHsO2GG9TSMv97++eFF3rf93vlM74jTwFBn4g7lvlhA7Ybm8tifAlXZlrJBIs//qmtERqp+PRnfKNpjYY9H/Pdkd+5L67+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v2jVB5ST; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-49bddfd1edeso1179707137.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 13:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725912018; x=1726516818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X1fic4sP1/AOMVZz4qd8YT8V8vbZenqvKDIWb9R8kEY=;
        b=v2jVB5STqSLbWNQxHRk5aA3zatCkC8OeozAC1jIYg+tgIGgcB8JbQ6uXQyKq9fAzGM
         8Ts4iKF8AoXZ7+jkR6qYy5EP83em7fK7iDDwoDNze+fhYBxB6UeRnfOQhL4b4leWAgkn
         v2dRwxkqqc2JMlZUNE29DO/rwXs9tmgKq1UHizZumRM+LCQcxCVckYbCwY7BRHXPe1BG
         NkCUoCqKvnYGEFvcz9P/B+ipW+lSeWQZnaDWDS6FuDnuFJFCL1nM98GyHCblbr/S0n0y
         R69DRTRqwyWrWqOpDmTftXH66pbF/oP/VWTQRrsrKZtYu/Mdzz5Gvw+E4bbwzkLPPmbW
         V8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725912018; x=1726516818;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X1fic4sP1/AOMVZz4qd8YT8V8vbZenqvKDIWb9R8kEY=;
        b=R88hW8QB90V0WI2P1iJOHUWQckaGz/k9jcPEcXgaUrft95IPPtZgMIc8TRon2D+lHp
         Q1Qb/BqzJDolFcbj6qSr/n3vU+Kl9FFH1ewsJIroXUWZ4zM/MfwJ9VzALEIZXv6Br86d
         CDPrzsQTgGpawwIr9BaWOOdCegGvC5ZPA62YJ94SPgjJkZARs9MKyd93ZrYl2hUHKUdE
         /e5kDbVJPgH05pfk3hDIlebsvn/cTY483uLS5b0kgOeTYBLuKZeo6fSwZeiouNXWcVoG
         dn3K2cTAkj+06d5qax0Ro8VB3zwetkldhF37A0CWtBvCGMVeN/foHZeithh4/NCe/+iy
         HLvw==
X-Forwarded-Encrypted: i=1; AJvYcCU/iGYcFF3/tlrO1HaaG+5f0WBBS0OJs1HdZAcddrQGNwDimWkgQYN4SaHJPlbdpot0V44wiF6oD1Be+ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxvzj4Mg/5ySY9J9TmoiZCZZ83qWNH4IhCSlTC0ov+18wqq4vN
	2f1+eVH96zqSF+erLk6PG0/d9hdmImB85u9TJgDossjSopCJs+H4I9lS6paE0Idv2A1vzOUMke0
	rIEc5VxFsHKA1iv9t7zcL67/g+pUba85KKjEW6w==
X-Google-Smtp-Source: AGHT+IGP43RBA5eyKycvnHSNqXqrTDpLKjI3rv0f/8HsS7OeZmw2PbOwMp8W8C6mPmFZWI5uAiLsegmx8AF+4IR+fT4=
X-Received: by 2002:a05:6102:c50:b0:49b:ccfc:6b5 with SMTP id
 ada2fe7eead31-49bde178c60mr14776967137.9.1725912018466; Mon, 09 Sep 2024
 13:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 10 Sep 2024 01:30:07 +0530
Message-ID: <CA+G9fYtNY+S0Ls2f3atJS_Y9Nh3V01EKO5jbPtVYbgch0TYsFA@mail.gmail.com>
Subject: Kunit: kernel/resource.c: In function 'gfr_start':
 include/linux/mm.h:101:35: error: 'MAX_PHYSMEM_BITS' undeclared (first use in
 this function)
To: kunit-dev@googlegroups.com, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"

The arm kunit builds failed on the Linux next-20240909 due to following
build warnings / errors with gcc-13 and clang-19 with extra Kconfigs

  CONFIG_OF_KUNIT_TEST=y
  CONFIG_KASAN=y
  CONFIG_KUNIT=y
  CONFIG_KUNIT_ALL_TESTS=y

First seen on next-20240909
  Good: next-20240906
  BAD:  next-20240909

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

build log:
--------
In file included from  include/linux/ioport.h:15,
                 from  kernel/resource.c:15:
kernel/resource.c: In function 'gfr_start':
include/linux/mm.h:101:35: error: 'MAX_PHYSMEM_BITS' undeclared (first
use in this function)
  101 | # define PHYSMEM_END    ((1ULL << MAX_PHYSMEM_BITS) - 1)
      |                                   ^~~~~~~~~~~~~~~~

Build Log links,
--------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240909/testrun/25079447/suite/build/test/gcc-13-lkftconfig-kunit/log

Build failed comparison:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240909/testrun/25079447/suite/build/test/gcc-13-lkftconfig-kunit/history/

metadata:
----
  git describe: next-20240909
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git sha: 100cc857359b5d731407d1038f7e76cd0e871d94
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2lpXzTGrlTRMzsi0ZQdQUUn8rKy/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2lpXzTGrlTRMzsi0ZQdQUUn8rKy/
  toolchain: gcc-13, clang-19 and clang-nightly
  config: multi_v5_defconfig + kunit
  arch: arm

Steps to reproduce:
---------
 - # tuxmake --runtime podman --target-arch arm --toolchain gcc-13
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2lpXzTGrlTRMzsi0ZQdQUUn8rKy/config
 - # tuxmake --runtime podman --target-arch arm --toolchain gcc-13
--kconfig multi_v5_defconfig --kconfig-add CONFIG_KUNIT=y
--kconfig-add CONFIG_KUNIT_ALL_TESTS=y

--
Linaro LKFT
https://lkft.linaro.org

