Return-Path: <linux-kernel+bounces-336916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E43C984286
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8EA9B23906
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA3115533F;
	Tue, 24 Sep 2024 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FmqfPFhl"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A145980BFC
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171184; cv=none; b=p9DHyCK+yD2BJ6b7L35OmGcCGOYxLD4nHm9tQvj75vWEmspG/8/SyvLjT8EAsAHMJ2SQXAUibqzYviXXgSMJrqvDJMjeP5hDrti1+2F3ZlivXGZJiL4FOXM8hourdjCmsZkRXChPc7O92cv2uAIDNqdIx2Y/cW3xm694r5TKabI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171184; c=relaxed/simple;
	bh=r/cYGzTaZv2USLTVwgqk4IAIb1u/nQBmzN2GtzAOk/0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FxWXoMWJruTxfRgyM8ByH+W9DYr8jKVSf7h8NEHDPdlSeRF5OrYMqu6y/WvVb3YRKvM/gKYx+zNZ9Sp4V97TJIHIR/7Up63zP5m3r5hc5oFpf9DuXBIMFfqLLkQilzu3eBEDUNYcT9T6MFxNGHWhtoxHeoX/zzeQyC/HPL2Fdgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FmqfPFhl; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-846bdc20098so1115470241.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727171180; x=1727775980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VymbO4VKGrRhQ842pFUZ7n7JL91F7DEIZa8VhwbzAVc=;
        b=FmqfPFhlFTKW8Ndv8c7LqlRnJ0zHH28PsIDLe5rDZfeqB9KrDWgNb3Y76Z5mWc7J1b
         elH2MOo65cD7AyGFni540stpvJLXyA64QodHyUADNm7kapmXxDMqKud3njAonN5QROoE
         jMSnSZuFazUtQH4slm61/I5FJd8pNnYE1bPzrTm0pFsD6CSgCij+XN4EYh6YoJo5TnhP
         7LwKDX5NNU8UoMgQ9UbntzWYdokVtd3MPrqBNru/Gf0e5aUL5YJOl4C1/3nBO7NQDREF
         A/CrcctpY1EoCTzlP7A3Il5lQLiZ5SnJc42gfeUgMErXvfv9aOkIlLHPJNoQZBjQI4JX
         P1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727171180; x=1727775980;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VymbO4VKGrRhQ842pFUZ7n7JL91F7DEIZa8VhwbzAVc=;
        b=Q8YCHYWkFMapkeUHRdmXjKsBK1SksvLU8QYsZNeb4ZHARVgYPvjr/RDWqkXCIi2PVs
         a+//4Lr8gH6U+tkIVRTM98tjQWfj9BDOEltWLtRkRfEYxXI88Js/6MJpkesnzWExpDuy
         0IiLMDwb4SbMIZSTEGJxppP6klq2cjOHmDkeF2IT+nsb7svKG55A0jmj5qDk/2fKoVMS
         yilH9y68QS2OZjMrZDaMiKgE9qWYY3jDTbMwo+/fLOKYa1LCT1A2INeTc/YFd1QYX1H7
         zcidOcHRd4FuzjizcZLj4bPkB1XnB+AnEzyQYI14ngj/XZZvDwz9gUQ+MbnUmqrvMpyD
         NGyg==
X-Forwarded-Encrypted: i=1; AJvYcCXy+mqa7HXhdV9mx3E9V2kzK0wsIaZbgoG1Sv4vmSKrn0dlbgCEBxJtroymBOA+5Vy+I9vmsp3mE5FbQPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt6hWQzl/OCvGMNA/j4DLvY9snFTeatrDM0OCWLkHLe3bOGrWW
	kBZEPvMBHsok6rTvNq6KrF+72sISh8hGJyV22kO1sDl072F8N71QGw2Gb2zTko0+tUfZAKKafic
	/19hNSdK4lJQT7aV8xvFeI9K/QUsD/Hj2OgMZkg==
X-Google-Smtp-Source: AGHT+IFW1lIEtdf54Ebt8HeFgkLUtAyOLGjTHkrA/Ct+9IgwP9rEU75K4d5gEKcpJrw2YljzTeCMRMcQ7LF26fCkpEw=
X-Received: by 2002:a05:6122:2914:b0:503:1bba:58df with SMTP id
 71dfb90a1353d-503e0422dbcmr8271763e0c.7.1727171180414; Tue, 24 Sep 2024
 02:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 24 Sep 2024 15:16:09 +0530
Message-ID: <CA+G9fYtu-h_pp_hNfmx1pBg48oGeRiEDnEc4b-r3AiC_QfWiKg@mail.gmail.com>
Subject: af_alg01.c:36: TFAIL: instantiated nested hmac algorithm ('hmac(hmac(md5))')!
To: LTP List <ltp@lists.linux.it>, open list <linux-kernel@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc: "David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, chrubis <chrubis@suse.cz>
Content-Type: text/plain; charset="UTF-8"

The following LTP crypto tests failed on Linus mainline master branch.

LTP
  ltp-crypto:
    * af_alg03
    * af_alg01

First seen on e8fc317dfca9 (v6.11-2185-ge8fc317dfca9)
  Good: v6.11-rc7
  BAD:  e8fc317dfca9 (v6.11-2185-ge8fc317dfca9) and (v6.11)

Devices and qemu's:
  - dragonboard-410c
  - dragonboard-845c
  - e850-96
  - juno-r2
  - arm64
  - qemu-arm64
  - qemu-armv7
  - qemu-riscv64
  - qemu-x86_64
  - rk3399-rock-pi-4b
  - x15
  - x86_64

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Warning log:
----------
tst_test.c:1617: TINFO: Timeout per run is 0h 02m 30s
af_alg01.c:36: TFAIL: instantiated nested hmac algorithm ('hmac(hmac(md5))')!
tst_af_alg.c:46: TBROK: unexpected error binding AF_ALG socket to hash
algorithm 'hmac(hmac(md5))': EINVAL (22)

HINT: You _MAY_ be missing kernel fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af3ff8045bbf

HINT: You _MAY_ be vulnerable to CVE(s):

https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-17806

HINT: You _MAY_ be missing kernel fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af3ff8045bbf

HINT: You _MAY_ be vulnerable to CVE(s):

https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-17806

...
tst_test.c:1617: TINFO: Timeout per run is 0h 02m 30s
af_alg03.c:22: TFAIL: instantiated rfc7539 template with wrong digest size

HINT: You _MAY_ be missing kernel fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e57121d08c38


boot Log links,
--------
 - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.11-8836-gf8eb5bd9a818/testrun/25191971/suite/ltp-crypto/test/af_alg03/log
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2m983y1hatxwkXBtrAYvCPw6pK2

Test results history:
----------
- https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.11-8836-gf8eb5bd9a818/testrun/25191971/suite/ltp-crypto/test/af_alg01/history/
- https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.11-8836-gf8eb5bd9a818/testrun/25191971/suite/ltp-crypto/test/af_alg01/history/

metadata:
----
  git describe:  v6.11-2185-ge8fc317dfca9 .. v6.11-5002-g200289db261f
  git repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git sha:  abf2050f51fdca0fd146388f83cddd95a57a008d  (v6.11)
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2m980TaGzPk0qjtFUPnMNoDj7Sw/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2m980TaGzPk0qjtFUPnMNoDj7Sw/
  toolchain: gcc-13

Steps to reproduce:
---------
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2m983y1hatxwkXBtrAYvCPw6pK2/reproducer
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2m983y1hatxwkXBtrAYvCPw6pK2/tux_plan

--
Linaro LKFT
https://lkft.linaro.org

