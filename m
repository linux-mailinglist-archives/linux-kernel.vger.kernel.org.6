Return-Path: <linux-kernel+bounces-433467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5AF9E58C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D228D16C48A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A85221A44A;
	Thu,  5 Dec 2024 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cC284P4K"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298A2218AA3
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733409927; cv=none; b=LRoZAYoe07ao1Ome1ApTgKy9q13W0+PCyq6Osq6WWTc/TQ0PJm5NZRSWFCtWofLAUw0hpNkAIaLykM46+CYg7KVkKF6UpQl0IngZPIJJ+IAr7oL1kbPfp0FZ2Ur184AwZx6h/xZLcykVYTknHUCu9rlrdBjOHfUIxDu4pw9+3nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733409927; c=relaxed/simple;
	bh=pbEz5c98jHDR4/DFEeITucEm+AUIz6sv1d8BE2tw6rI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KqOMIB3SL4z3bx2pU1JdwEQfTGqFz4pg2FO8/1K4EMnwVf0CcnZzKRthc+p1BjGFhla/O2UUT2nctMy1kLMOpcanYrDeJNnrmJlB4DLoGehkFrYW5BVA7bgfbK91QATmVGdjxORRinmycyNRa8xYXyKW7xhQICyxo9NcQWnXv2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cC284P4K; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-85c15e283bfso277054241.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 06:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733409925; x=1734014725; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fgrv+GN2LBEaeVJ/FTM/TTU+8nfkJLCFn3FWcldv84Y=;
        b=cC284P4K1+jI8wOSxidxBini7PllRxfoJD7Cp0Im6qe9v9nmlN+b5Woeeu+DQGuHpQ
         a/5xYKarnp6YAGrLHM6zTSD7Pip4xxAnS3kUWdfYGWoNNYcS1yKOa7RdHXjfnWZlK9sL
         3CLtEprXd5ltdKR8dooNvo5Dg2BDDudRpO9eVkx38SIfxmx7D0kybYqx0uEXNqzBSLd2
         S7oVwnnLSZw3k1tL/aoRtFavHlwV2MBC2ybawdcroYg7903DEZzHDqIRYPkGruHCoBz5
         Eb/u9wcyeb2OZq6eb84Xp/sErjyYadjjWlXzlkaSy+gChX0jMzwLuoi+n3LgCZd5vacF
         q7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733409925; x=1734014725;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fgrv+GN2LBEaeVJ/FTM/TTU+8nfkJLCFn3FWcldv84Y=;
        b=nWaVN6GoMMsdNA3tVIvrPKh1iCir1Vg2k3IK26GlG+wOzJsVT+ko8A2nrBxnVMeI+4
         CC9SR919LhQuQGjOKNuKw7uBzvz6aej4rmkxF0v91sTq4WFE6ZtWa9Yg7T0UmO9J5W31
         VEGzZko5KY6GOmrJX46NwLtbtaMzUuFP/UMxdxBL2FMPJF4PTM68PKBiJhqJdB2dLcvS
         GCV0mF53oMK7JbTwiWh2ONnlMm+QazJA12f4CMWquYPOzNYAQSPH2AXxXoz9tDAqgqob
         oDFWDu3SN5nwmhCukc+J2hKKu00qT8UWDwyN+lMbKiBdX4hVAeBH5/HRnaKtj4blBKCF
         CciA==
X-Gm-Message-State: AOJu0YxH2YzVthsOI7RMgz8Do0lioOI6VuVMdpBomnekEN7N8ry+gkKx
	iBzqvwMBPkC0HNygpLwwBcmTPuLrld8+Kj98MyuSrtQdD0ttTJi4Qv6mDxVsf+8KxBIvR3bS8+9
	ZdFuFqynacKjo9rl5x11ghwhLWC/K/YEJrkA9/80uvaGaw7vY7ww=
X-Gm-Gg: ASbGncuvahKdpS4uuYCisWrfd01hVL/5JI9a9XgnhIGm66j926nQl7LYZ08M9Mi7MNr
	WMAESs/97qosncSiI0WoJMxIwfVIGstcD
X-Google-Smtp-Source: AGHT+IFOiMg1tiV2s1ALxvVSXDETAQk3njW8DcCcpMAV58xChVISoFfkqq0962KUxkCR0Kys6OBR8oG4VmY9Ee3TIiA=
X-Received: by 2002:a05:6122:2a4a:b0:515:f27f:fd6a with SMTP id
 71dfb90a1353d-515f27fff47mr1440208e0c.8.1733409924732; Thu, 05 Dec 2024
 06:45:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 5 Dec 2024 20:15:13 +0530
Message-ID: <CA+G9fYsT34UkGFKxus63H6UVpYi5GRZkezT9MRLfAbM3f6ke0g@mail.gmail.com>
Subject: arm64: include/linux/compiler_types.h:542:38: error: call to
 '__compiletime_assert_1050' declared with attribute error: clamp() low limit
 min greater than high limit max_avail
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, netfilter-devel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Johannes Berg <johannes.berg@intel.com>, toke@kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, kernel@jfarr.cc, kees@kernel.org
Content-Type: text/plain; charset="UTF-8"

The arm64 build started failing from Linux next-20241203 tag with gcc-8
due to following build warnings / errors.

First seen on Linux next-20241203 tag
GOOD: Linux next-20241128 tag
BAD: Linux next-20241203 tag and next-20241205 tag

* arm64, build
  - gcc-8-defconfig
  - gcc-8-defconfig-40bc7ee5

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
===========
net/netfilter/ipvs/ip_vs_conn.c: In function 'ip_vs_conn_init':
include/linux/compiler_types.h:542:38: error: call to
'__compiletime_assert_1050' declared with attribute error: clamp() low
limit min greater than high limit max_avail
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                      ^
include/linux/compiler_types.h:523:4: note: in definition of macro
'__compiletime_assert'
    prefix ## suffix();    \
    ^~~~~~
include/linux/compiler_types.h:542:2: note: in expansion of macro
'_compiletime_assert'
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
  ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro
'compiletime_assert'
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
include/linux/minmax.h:188:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
  BUILD_BUG_ON_MSG(statically_true(ulo > uhi),    \
  ^~~~~~~~~~~~~~~~
include/linux/minmax.h:195:2: note: in expansion of macro '__clamp_once'
  __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_),
__UNIQUE_ID(h_))
  ^~~~~~~~~~~~
include/linux/minmax.h:206:28: note: in expansion of macro '__careful_clamp'
 #define clamp(val, lo, hi) __careful_clamp(__auto_type, val, lo, hi)
                            ^~~~~~~~~~~~~~~
net/netfilter/ipvs/ip_vs_conn.c:1498:8: note: in expansion of macro 'clamp'
  max = clamp(max, min, max_avail);
        ^~~~~

Links:
---
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOE9K3Dz9gRywrldKTyaXQoT/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26189105/suite/build/test/gcc-8-defconfig/log
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26189105/suite/build/test/gcc-8-defconfig/details/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26189105/suite/build/test/gcc-8-defconfig/history/

Steps to reproduce:
------------
# tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8
--kconfig defconfig

metadata:
----
  git describe: next-20241203
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git sha: c245a7a79602ccbee780c004c1e4abcda66aec32
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOE9K3Dz9gRywrldKTyaXQoT/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOE9K3Dz9gRywrldKTyaXQoT/
  toolchain: gcc-8
  config: gcc-8-defconfig
  arch: arm64

--
Linaro LKFT
https://lkft.linaro.org

