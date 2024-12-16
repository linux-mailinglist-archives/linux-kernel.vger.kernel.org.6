Return-Path: <linux-kernel+bounces-447701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC039F362A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3151629B4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4951A204C3C;
	Mon, 16 Dec 2024 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zfvVBaRJ"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034401B4124
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366860; cv=none; b=qZ5M8cBV+fyDHCTj8kBRK2oQMu4xKrzgxQl1A9sDL9da+WfI7hhgK6zdqgwwvQvXeOYXlROokV0n679aHgmBtwAMkA4IBou0knHIO00uMDqS3uJiPefdXJGvYuosenw9SlBf+0A7BhhTFmkvBu4wz7UhXOqKzJFq5JKpcLjeST0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366860; c=relaxed/simple;
	bh=J4P8Yn+HmBStOiyf7871d8RgqIDPsmAX5U/1I64nh6s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=n4CBQ/+8mUPc5CsIKFzRf8Uqe3GRAjXobJ1+xf7TFrZmpwR7j6M68BbI4F0hIvIOFzemT/8NBKdV4FcmTN5MZtkjGGM5r0J9ooe+HNlx45vnpCagG4+1dxxdpA4Zkj09my2JGuUvnEbgvA1FeVm9WWrg95Q2bVOinA3QgZEItzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zfvVBaRJ; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4afeb79b52fso1169703137.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734366856; x=1734971656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=voYB97BSoIttk6TNFpCBTpCkCub3HvTPki1P0fPd0XM=;
        b=zfvVBaRJstSDeEl6+GGDGWKT7hTJEbATEo/tkaPmkiCLuPcOzAbSbwcOOQzU1uzDiD
         LfM1dOCRdZqxTEarx4oY6QcHoy0uEjaehokOpQ3zKkftBAZqbEWPF+DB0VGyzq1q/gQi
         ym+sONUkGeV3dg2LmeAdjHRwcJ0WKg5IeO4NhL6JsbVvD8CBPLAwI1QMFazzcUHHdCnh
         BnUF5L1SLxlRuUhM8n+LcVS5yrjBhmNRUYgdsd+1RRFj5I/FcGFgesLwZHbCxaxa+HzD
         Ykp3r5eqQBs0BQ6sYqRe6Mc3QCXN3D81WsPVp3cMztd1ysLBbxz1KN4qifypofSFEOx4
         Uzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734366856; x=1734971656;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=voYB97BSoIttk6TNFpCBTpCkCub3HvTPki1P0fPd0XM=;
        b=WGyu6Ik31LP5Q71O4IDunOPrImwA+L3iaDGOvY3vF83k35zgdwzzEVWD1ZZEkm6xAO
         kA9DU55euF3YHyFHBVX+qswO+mwLmB9K/bkEKHK7fWxOXUpThfs+tCw19s4bGJTFAFp9
         UjD3J1HPi+9kPKiE4GAJwJ+SxUTDW8NiaZDbHrnfuBx0D0x3Yo7MpXae1eMGc0s4kC8x
         7cRefR26Uei80VlmZlbiqZ6U6Lt/1+q28/sCa6RbA+BMLLkaAOJqXeNtrtgRAbDqzC5H
         UhDqDg4Rath7AkZExIBrwZsH0sJn9rEy7v78mhNk3DEEHYGExbQqQgcbbTGlJzB5shbQ
         B6SA==
X-Gm-Message-State: AOJu0YyPWifHrbSKePI4RLISvn4wpUHMb8mdqv3Z34TGG1LERXw6H31T
	F5xyEHo6hwfNTFQG0lQrWvvK+UR84RnqgVFTeJYRgpaP+4dFf8HuJEpM11LupMNDBxwb8hoyDmL
	9o2E0A2fBoBdp1JU3qziF6hCvx9S7skQpfxFcNFLQ69IE8dsvLpc=
X-Gm-Gg: ASbGncvWDS04XcS2hQxV5+RqarwWahIaLY/Tb8tOhRqQINimHwXbrbor3AwqovTD8kM
	7h9ahl2xV0Ga8NdYH58dlEkm9TCXMPuUW7pPa8XvvfxPYzrB+1CMvJMIpbZZ/VF2ZDEJCZ2E=
X-Google-Smtp-Source: AGHT+IHwcIqoyILkP+1sx25KZjFSaAGwKZBXcw1KXTOsA6DOwlBCczCOTJUK1dfVqLl4hiOpY/+Ngz4hZael7fpPyHY=
X-Received: by 2002:a05:6122:1e01:b0:516:18cd:c1fc with SMTP id
 71dfb90a1353d-518ca30617amr12733009e0c.8.1734366856629; Mon, 16 Dec 2024
 08:34:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 16 Dec 2024 22:04:05 +0530
Message-ID: <CA+G9fYtpAwXa5mUQ5O7vDLK2xN4t-kJoxgUe1ZFRT=AGqmLSRA@mail.gmail.com>
Subject: next-20241216: drivers/crypto/qce/sha.c:365:3: error: cannot jump
 from this goto statement to its label
To: open list <linux-kernel@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, clang-built-linux <llvm@lists.linux.dev>
Cc: thara gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

The arm and arm64 builds failed on Linux next-20241216 due to following
build warnings / errors with clang-19 and clang-nightly toolchain.
Whereas the gcc-13 builds pass.

arm, arm64:
  * build/clang-19-defconfig
  * build/clang-nightly-defconfig

First seen on Linux next-20241216.
  Good: next-20241216
  Bad:  next-20241213

Build log:
-----------
fs/netfs/read_retry.c:235:20: warning: variable 'subreq' is
uninitialized when used here [-Wuninitialized]
  235 |         if (list_is_last(&subreq->rreq_link, &stream->subrequests))
      |                           ^~~~~~
fs/netfs/read_retry.c:28:36: note: initialize the variable 'subreq' to
silence this warning
   28 |         struct netfs_io_subrequest *subreq;
      |                                           ^
      |                                            = NULL
1 warning generated.
drivers/crypto/qce/sha.c:365:3: error: cannot jump from this goto
statement to its label
  365 |                 goto err_free_ahash;
      |                 ^
drivers/crypto/qce/sha.c:373:6: note: jump bypasses initialization of
variable with __attribute__((cleanup))
  373 |         u8 *buf __free(kfree) = kzalloc(keylen + QCE_MAX_ALIGN_SIZE,
      |             ^
1 error generated.

Links:
-------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241216/testrun/26350650/suite/build/test/clang-19-defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241216/testrun/26350650/suite/build/test/clang-19-defconfig/history/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241216/testrun/26351207/suite/build/test/clang-19-defconfig/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2qHsa6j5c1HY3GRZFGrxu2ELo3f/

Steps to reproduce:
------------
# tuxmake --runtime podman --target-arch arm64 --toolchain clang-19
--kconfig defconfig LLVM=1 LLVM_IAS=1

metadata:
----
  git describe: next-20241216
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git sha: e25c8d66f6786300b680866c0e0139981273feba
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2qHsa8wFmfrlj0VdDqAG408o3l2/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2qHsa8wFmfrlj0VdDqAG408o3l2/
  toolchain: clang-19
  config: clang-19-defconfig
  arch: arm64, arm

 --
Linaro LKFT
https://lkft.linaro.org

