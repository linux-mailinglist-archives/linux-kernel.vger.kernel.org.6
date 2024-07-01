Return-Path: <linux-kernel+bounces-236007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0DA91DC41
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA480B21CA1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE30713212B;
	Mon,  1 Jul 2024 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HnAM7ysf"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9908F12C486
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829166; cv=none; b=JN4KUkgpPh2F1o/0StLv3P1jAfdK0Zs7VRfgztLa9UZUh4bwKZRgh9m2CZYoQzzyLmJ446EDGNwoHU7CMuA4aN1zMzMI8T+2To9uz6+TPpjzIvjWZF0KK1B/Yq31EkzOwncJbGzmeNo2ez25aMWajLV0MM0oefyv7dHH0/bEtcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829166; c=relaxed/simple;
	bh=stQCQxg3iYHa7ZaMB1TA68tGpQvchZy636OSaRuUH/c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mmJFxcpe1htg8pruBHDQH5rWaTusaLuwKzNUqCeNR8m8+U5a9K04Ldsbr0guOyl6LXG7/LC6cp19nZHMQhOLjCnuwsH4hQmGKwHW8Je2A5Estn4Snu1F7rVyKpZgsXWKAUBv0UHFi/U1cC14u48vCJ3SyNFTTIR1DjWN90RF4O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HnAM7ysf; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-48f3e704576so1051678137.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 03:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719829163; x=1720433963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=loIUXWsvnq2yo7+EGoHAffb6gdvh8EF6LMqQfzim+RU=;
        b=HnAM7ysfFE7Dn+x6pm89LicAVB0msRBhtDvh3eKJI1zzw+Qjl4j12xYUJSQ99a9ATI
         aOaprwc2DxLgAON8jnSCYRUqga82jj9WLs32a9qlKOTeuo1Dt16yZDCLEshDShlvadw/
         2H27w+akRyOr28PFHJbs3Ifq3UP9kd1na1FIBDlkQyvqENKotmHzG78jtydYI3e6pefg
         OaazMcftJKk0+8IBSsKR/dSkDW0rhKztNUAWMcQEPQ0mTEmegio3okxNVT3n/UB9jgGp
         W8YsVLNqEeZ8r5X8QcZLkL+PXi4PSeHy2jSOtKunLF9aC04KvXMfcYEZzv9hwEanVT80
         R2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719829163; x=1720433963;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=loIUXWsvnq2yo7+EGoHAffb6gdvh8EF6LMqQfzim+RU=;
        b=eamzIG8Mqv+LqMFrZL0eNVH3HwFDze7HjRMdRJEfsyRwcTJrctMDzhG2pJV86V6Bep
         o1IvZQwF213Rzoq1JVGuSP7UDFy9ccZlB5zUMirf66B+vkEpUyn5ITo8/l0Abbxnu4uf
         hM4RYJVVBNm8JFStJLWN6nL82kUhbSGtUcALWG1Snb/f9NEI7lMKvDihTe71AeyZ7Iam
         DhBba4hh6Rj13LwIXweIu2k1Dc6ZFag1prqGzVmV4RFhJKSyA96InCvODE6bTyFw9GOC
         /rZyNPYrfb+Sw1v/Ox5NgFVkZuIv6WfljZw5jVyGkDAHH5aiWq06TEf9+ZIHYHYCtAX9
         VTBg==
X-Gm-Message-State: AOJu0Yw10E194mybFwbH6USx7bn27Eq4+d6vWymT+gTLfCYQAg6yc+6d
	2NrmW3WVfXqN21D9tGYSTdy37Sjo6TyIphIxGAEBtCcEj31ShmcgvxJzgzAOYet/VgJn1YYnzDD
	Wn8eOB14zXhrUpObCgod9BNDPCotuuZoj8WxsE4i01auCHgiuvYb9Ww==
X-Google-Smtp-Source: AGHT+IHsCQzeHxHwgdBEVzHHr4zQVqrsCo7FWNtGkFgflR7Q+Sy7JIhUtzqPEJeINk1wTXKgxnHKA65it2kLKRVvFfE=
X-Received: by 2002:a05:6102:3a13:b0:48f:2afe:88f1 with SMTP id
 ada2fe7eead31-48faf0cf479mr7159638137.16.1719829163172; Mon, 01 Jul 2024
 03:19:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 1 Jul 2024 15:49:12 +0530
Message-ID: <CA+G9fYsk85UOsa0ijXcYRvvZLXEMQKe4phWhND+0qSNP36N5Tw@mail.gmail.com>
Subject: fs/proc/task_mmu.c:598:48: error: cast to pointer from integer of
 different size
To: open list <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	lkft-triage@lists.linaro.org
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

The i386 build failures are noticed on Linux next-20240627 and next-20240628
tag. But the clang-18 builds pass.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on i386:

 - gcc-8-i386_defconfig
 - gcc-13-defconfig

Build log:
-------
fs/proc/task_mmu.c: In function 'do_procmap_query':
fs/proc/task_mmu.c:598:48: error: cast to pointer from integer of
different size [-Werror=int-to-pointer-cast]
  598 |         if (karg.vma_name_size && copy_to_user((void __user
*)karg.vma_name_addr,
      |                                                ^
fs/proc/task_mmu.c:605:48: error: cast to pointer from integer of
different size [-Werror=int-to-pointer-cast]
  605 |         if (karg.build_id_size && copy_to_user((void __user
*)karg.build_id_addr,
      |                                                ^
cc1: all warnings being treated as errors

Steps to reproduce:
-------
# tuxmake --runtime podman --target-arch i386 --toolchain gcc-13
--kconfig defconfig

metadata:
----
 git_describe: next-20240628
 git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
 git_short_log: 1eb586a9782c ("Add linux-next specific files for 20240628")
 arch: i386
 toolchain: gcc-13

Links:
---
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2iWYcW0sQJ6j62u46MNgQ3FagUd/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240628/testrun/24464887/suite/build/test/gcc-13-cell_defconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240628/testrun/24464887/suite/build/test/gcc-13-cell_defconfig/log

--
Linaro LKFT
https://lkft.linaro.org

