Return-Path: <linux-kernel+bounces-291691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0435595659D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284881C21566
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFC415ADBB;
	Mon, 19 Aug 2024 08:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VSkthF6a"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80FD15B57D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724056143; cv=none; b=KHEsuvt/qa7Ppzd9jaME6/Ca4cSl11wct9nUOAFwJcTNnCc/yy79w5vzc9xPCE+KuFgu3wLtkmY1oLJlsNc0e47EV/WJjRZ5mpXOafkqaVValJ5TqcFkvn7cehlNDEHxexwmkCxrpv6BkLB1WrLDb8MPAON599FQ5iv5/gYGDJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724056143; c=relaxed/simple;
	bh=FVAVj1LvGkF/qSjcgZvVxOe72okf4eq3mAz9Bqo5X84=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=b6gTHBD+K6IKaPrl5HvTw9nswP1SxZrxMf16nE2N+NLHsRrdWFSh2ek9PwDXiWmrWbkZwJbKwbMsOZNCDM10/+jrdK4Uh+zJh5flSA4wq9e6fsbL4lA3OtS9UO/PTQ+0+6knXbDw3n2ZgJ5Kf3a7WguaqlQZZpdaLV5nNFIuGvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VSkthF6a; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4928fb6fdceso1216320137.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724056140; x=1724660940; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UpX4LsrqwRDqFBD8C2IBSkZVW31sWUBwFvypF0QOuuo=;
        b=VSkthF6asCwSTPAKFX1t68N7Vh8pc8g46pjvs5To9KyUAni9d9G0Tt0nrbRXnQPH8j
         WAU2VIDjQA74RKCR4KaUnvAkq3QVP+JzOSFMI6f0eHDBP3VaT0MAv+ViDfiridmQk7NX
         K1k5q3uHtlHPCMk9qvkmHxh8gKBGB1LnJYUf6pQAShGCPjS75dcZ/fWN5I0VAjAcozBP
         Oc1hin6i9eCUbo6NfozIgXZeboXYJ+r9lO/+qpC7jEbNUjNNMlWj7fGeM7Zd8NCGtCvJ
         8FWVz709Og3sWnMmqZD8OcBpzpb1LflsBfyquVqZ5QkE+usMIAH6+GGGTBQathoSOPCC
         Kr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724056140; x=1724660940;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UpX4LsrqwRDqFBD8C2IBSkZVW31sWUBwFvypF0QOuuo=;
        b=Ywh54G6y6kN2Yr+OlbYW+htBTAxqCO9XVcMxKTeJCT2yLGYYEjcxrIFfgTGcZMUMFL
         woB5NIBgc0qdosvtXan+u2MknaJ2iwNrl2q67rGUp9tm+p9roJMeE3ye0qUqxwkuAg6V
         spf5meC80pWQ3EavOnQc9w38Vvepqx2BjQcKDLdXUlI1y7Xu1fG7vbOt5gkf3JjAizbH
         IgVmboXFaDOer23a0ooCvs8Hghhbr9uX//h2ZIGKoL6PPZ8HhjISiHhMQGpYeW/L6k7r
         Ny1Jd7DZnCrqUSF9pSiyoqLjcC/Sacqza0X+CjoYN6bWOwJd7JFb6jBASJH4Ylz0NwSd
         eHCg==
X-Forwarded-Encrypted: i=1; AJvYcCUaiCnYmgEg41l7H8UOgH7iQzsq9cALGbtFdf3JH82Y9jEDCc3BTK6938bkmEwyiH7iFf0TPzrIZKw4UY7mUglYeNJcE65QqGSXkv9t
X-Gm-Message-State: AOJu0YyUugNIoISEODZ+m6HQ9t6+BsKaq6NuCr8hPrCz96/s2HJG/w20
	rlm5ZTzPvibfBU7alRZvLpU1fW3tk4k59JUB7tny+Lk6zuyqmn+rCj3iPEEfOxgdRaqnFlJ838G
	XptrrKxo6iwb9Q/onXd9GTjXZSaukZxwJCx1pxw==
X-Google-Smtp-Source: AGHT+IHKVi6WKmdyAQ6QyA73ge60UMveA7EfNgA9AWldj2xZheTdlekHgzFhLgWv7yt/BTmNdTQkVOzDSqv76IZiO/8=
X-Received: by 2002:a05:6102:5487:b0:495:6aeb:a0e9 with SMTP id
 ada2fe7eead31-49779881408mr11886459137.4.1724056140489; Mon, 19 Aug 2024
 01:29:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 19 Aug 2024 13:58:49 +0530
Message-ID: <CA+G9fYuFDon59=Nw6WCdgp0FanZ1oE3dCkoq71EK0Bxe6Jhe_g@mail.gmail.com>
Subject: gcc-8: mm/swapfile.c:863:40: error: array subscript 1 is above array
 bounds of 'struct list_head[1]' [-Werror=array-bounds]
To: linux-mm <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Kairui Song <kasong@tencent.com>, Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The x86 builds failed with gcc-8 due to following build warnings / errors on
Linux next-20240802 to next-20240819.

x86_64 defconfig gcc-8 build failed
x86_64 defconfig gcc-13 build pass

First seen on the next-20240802 tag.

  GOOD: next-20240730
  BAD:  next-20240802

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build errors:
--------
mm/swapfile.c: In function 'scan_swap_map_slots.constprop':
mm/swapfile.c:863:40: error: array subscript 1 is above array bounds
of 'struct list_head[1]' [-Werror=array-bounds]
   while (!list_empty(&si->frag_clusters[o])) {
                       ~~~~~~~~~~~~~~~~~^~~
mm/swapfile.c:872:43: error: array subscript 1 is above array bounds
of 'struct list_head[1]' [-Werror=array-bounds]
   while (!list_empty(&si->nonfull_clusters[o])) {
                       ~~~~~~~~~~~~~~~~~~~~^~~
In file included from include/linux/list.h:5,
                 from include/linux/wait.h:7,
                 from include/linux/wait_bit.h:8,
                 from include/linux/fs.h:6,
                 from include/linux/highmem.h:5,
                 from include/linux/bvec.h:10,
                 from include/linux/blk_types.h:10,
                 from include/linux/blkdev.h:9,
                 from mm/swapfile.c:9:
include/linux/list.h:612:18: error: array subscript 1 is above array
bounds of 'struct list_head[1]' [-Werror=array-bounds]
  list_entry((ptr)->next, type, member)
                  ^~
include/linux/container_of.h:19:26: note: in definition of macro 'container_of'
  void *__mptr = (void *)(ptr);     \
                          ^~~
include/linux/list.h:612:2: note: in expansion of macro 'list_entry'
  list_entry((ptr)->next, type, member)
  ^~~~~~~~~~
mm/swapfile.c:873:9: note: in expansion of macro 'list_first_entry'
    ci = list_first_entry(&si->nonfull_clusters[o],
         ^~~~~~~~~~~~~~~~
include/linux/list.h:612:18: error: array subscript 1 is above array
bounds of 'struct list_head[1]' [-Werror=array-bounds]
  list_entry((ptr)->next, type, member)
                  ^~
include/linux/container_of.h:19:26: note: in definition of macro 'container_of'
  void *__mptr = (void *)(ptr);     \
                          ^~~
include/linux/list.h:612:2: note: in expansion of macro 'list_entry'
  list_entry((ptr)->next, type, member)
  ^~~~~~~~~~
mm/swapfile.c:864:9: note: in expansion of macro 'list_first_entry'
    ci = list_first_entry(&si->frag_clusters[o],
         ^~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Steps to reproduce:
-------
# tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-8
--kconfig x86_64_defconfig

Build log link,
------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240819/testrun/24918869/suite/build/test/gcc-8-x86_64_defconfig/log

metadata:
-----
  git describe: next-20240802
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git short_log: f524a5e4dfb7 ("Add linux-next specific files for 20240802")
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2k6wLr4UFODrd3snUDTPPevXpPY/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2k6wLr4UFODrd3snUDTPPevXpPY/
  toolchain: gcc-8
  arch: x86_64

--
Linaro LKFT
https://lkft.linaro.org

