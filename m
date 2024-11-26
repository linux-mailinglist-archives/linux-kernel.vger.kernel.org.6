Return-Path: <linux-kernel+bounces-422011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D2B9D933A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728EB282E60
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C891A3042;
	Tue, 26 Nov 2024 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgF1XF4i"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E970518FC8F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732609527; cv=none; b=Fnti50+LMkl7jkGiD7jSYzs+XJnkeAygTzb1N1mrWiDWEaTyOlUv6tyEgS5dsQlkbxaBwruF7Nw/3xyEqma6ICwwwTtFwJSoQxBXqNOqw5idIQlxMeSxpGDYK48x7QaQn84DNe6NdOpIX7Nxe7kgfXoEqLp5ULUHWBJmbXhIeFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732609527; c=relaxed/simple;
	bh=sI7tNk5+zKeQtAWcs3AksLYA8Nbczy7AgLIX6hl0R9k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=prXFq+5yP3Kr90RgNGiIJDaXLXdlFt5zB1kTP7JZKWOa3yo2K7xMaMlbXWpV3e+dbn7kH/nni7Rm22xLWw3YIa7p9gQjjj6RP/+n5ffUU4vrvQLwoHWQhBPyXVJhmh3tRWCqPmJPUMoGZo5tAaLfuqximAbyKpQJ/Cvz8JJ0Ltc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dgF1XF4i; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-856e51bf038so1721199241.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 00:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732609524; x=1733214324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r6PXQfbArbgQ9QlkA0GcTxdQSqKG1+4ODD/01KNTBS8=;
        b=dgF1XF4iN/up/cq8XLwsH2CqHxROUELox6VSDdKqBRgM6z6zSwYwWYXQ90b4Qqs671
         bCzKngtMD/Ev7qBp9h1N0+zdphVdzQuNpqcnyJSh4BJGUkCS2Y//BI7bCy8SeaQdwzSo
         HlPbqifyBBAhq6BtyP0mjrjOoovops37Ts2tLzcFIxYk5+Ua/NZK0R7Ljxhck7bNgOWh
         wxMsBHbq4jP+roBgftY+az3cwDqR/jjrWuwHmPOcm44vv26acwJUxcMUepQI6k/69Fro
         +vbsLpOr2cEw6sFWUnPZejrthaDS4Q6rTgco3NXpXocEAg5sstw/YZkhJwS6LGCliqzN
         UFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732609524; x=1733214324;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6PXQfbArbgQ9QlkA0GcTxdQSqKG1+4ODD/01KNTBS8=;
        b=ZTgcdHDi+4VaLkm/uj/zQz2qP6j8iBh5naNo6uDQSMRjqG5aF94Y29R81AGyieojwU
         C+Qj9WBAzOt3pwRjsurcqp185EXSX1zotoFEMeA1VTIWQVn7UezKmV0SSIvkluXnYCOb
         bR07UMUgHFAXpJMOGpQt3aUlHg87oTsT6ziuezrAio5HGGtNCwzzaEX/+qgQkBhwzeCG
         x9G8/R8uM0I7tglYXZ0XrIeJo2SWHW3mBErRjOL4pc/YkkvYEoPXEgaEov8N9z2BIRcM
         uy2S1Q90jkYrf/LJrfoQG0Es6NTav74aUmIKMzlccaMxKRNb0z/MgVPQlyfzmt3cry7K
         IahQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ3THgOBalVacF5VxwiGBptdnKk+1nWOcOHhKQU17lYuRblXbt8vADAx1kVTZEBTlJRYyAYhg6P+GtbSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI+nqNrYvUoIFGpb9LBs7/G2hBbx53yy63Yr6GHh+UjmGT/Jf6
	lmIYymmXJbQoeG562+X19AMUy1FrgcxezZnWxCGP44+a2syakyAkBGtH3QvPK7XHupW6SbtvnBh
	dnwY5SiNiFoSSoZIquWCoPFXEFM4+YOT97EoKvQ==
X-Gm-Gg: ASbGncszqFZpkVHnHUwNkoTVOJcZae6nu5pG2tXEqhxcsJYCzs+9+OvsqTDP9CIW+3a
	q/QHuYZPPK19VETz37SLSQFQ/LSprzqi1ZQILOfAU8v4U1rRWItlizgr3Y3vq0CO+
X-Google-Smtp-Source: AGHT+IHfmlOUT07xsGM81ccGUL8gokcmILu2aWCHpE5lTRyBqDIA2QVqqjf2o72oJuOxTAI/oybzlUneyIUgqtnDACo=
X-Received: by 2002:a05:6102:9d0:b0:4af:476:f3ca with SMTP id
 ada2fe7eead31-4af0476f4e3mr9401237137.12.1732609523827; Tue, 26 Nov 2024
 00:25:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 26 Nov 2024 13:55:11 +0530
Message-ID: <CA+G9fYuLXDh8GDmgdhmA1NAhsma3=FoH1n93gmkHAGGFKbNGeQ@mail.gmail.com>
Subject: fs/netfs/read_retry.c:235:20: error: variable 'subreq' is
 uninitialized when used here [-Werror,-Wuninitialized]
To: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc: Jeff Layton <jlayton@kernel.org>, David Howells <dhowells@redhat.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

The x86_64 builds failed with clang-19 and clang-nightly on the Linux
next-20241125 tag.
Same build pass with gcc-13.

First seen on Linux next-20241125 tag.
  Good: next-20241122
  Bad:  next-20241125 and next-20241126

x86_64:
  build:
    * clang-19-lkftconfig
    * clang-nightly-lkftconfig-lto-full
    * clang-nightly-lkftconfig
    * clang-19-lkftconfig-kcsan
    * korg-clang-19-lkftconfig-lto-full
    * clang-nightly-lkftconfig-lto-thing
    * clang-nightly-lkftconfig-kselftest
    * clang-19-x86_64_defconfig
    * rustclang-nightly-lkftconfig-kselftest
    * clang-19-lkftconfig-no-kselftest-frag
    * korg-clang-19-lkftconfig-hardening
    * korg-clang-19-lkftconfig-lto-thing
    * clang-19-lkftconfig-compat
    * clang-nightly-lkftconfig-hardening
    * clang-nightly-x86_64_defconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
---------
fs/netfs/read_retry.c:235:20: error: variable 'subreq' is
uninitialized when used here [-Werror,-Wuninitialized]
  235 |         if (list_is_last(&subreq->rreq_link, &stream->subrequests))
      |                           ^~~~~~
fs/netfs/read_retry.c:28:36: note: initialize the variable 'subreq' to
silence this warning
   28 |         struct netfs_io_subrequest *subreq;
      |                                           ^
      |                                            = NULL
1 error generated.
make[5]: *** [scripts/Makefile.build:194: fs/netfs/read_retry.o] Error 1

Build image:
-----------
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241126/testrun/26060810/suite/build/test/clang-19-lkftconfig/log
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241126/testrun/26060810/suite/build/test/clang-19-lkftconfig/details/
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2pNKzjvChfT6aOWplZaZeQzbYCX/

Steps to reproduce:
------------
- tuxmake --runtime podman --target-arch x86_64 --toolchain clang-19
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2pNKzjvChfT6aOWplZaZeQzbYCX/config
LLVM=1 LLVM_IAS=1

The git log shows
$ git log --oneline  next-20241122..next-20241125 -- fs/netfs/read_retry.c
1bd9011ee163e netfs: Change the read result collector to only use one work item
5c962f9982cd9 netfs: Don't use bh spinlock
3c8a83f74e0ea netfs: Drop the was_async arg from netfs_read_subreq_terminated()
2029a747a14d2 netfs: Abstract out a rolling folio buffer implementation

metadata:
----
  git describe: next-20241125 and next-20241126
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git sha: ed9a4ad6e5bd3a443e81446476718abebee47e82
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2pNKzjvChfT6aOWplZaZeQzbYCX/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2pNKzjvChfT6aOWplZaZeQzbYCX/
  toolchain: clang-19 and clang-nightly
  config: defconfig, lkftconfig etc
  arch: x86_64

--
Linaro LKFT
https://lkft.linaro.org

