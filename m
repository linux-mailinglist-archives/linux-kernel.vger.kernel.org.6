Return-Path: <linux-kernel+bounces-232329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3423091A6E4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6598B1C2150D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACA517994F;
	Thu, 27 Jun 2024 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bPXB2iCJ"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306FA178CF5
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492577; cv=none; b=kUwjfSK0N/lPOlecVa0kP86Np8Vrtj1m+ytc6TRe8PW3W7w3fNkbdcOO+POR1X/LTNY5VJprqAfm/wH/ex8m9/IRRFTMEGNSOB7DVVbGM0ctM/eDcOv9jO4zuVxo0SrZ4CzUdNBvmA1FsyDWZO8v7ftB3Qov6xZm2v0av5Nr+yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492577; c=relaxed/simple;
	bh=Cu5bT6sPCCfDQjQRjkhShbiDXjp7BjV1vPvAfCQyeCg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ohd4fhaYiH+6rlmU3EQkk5baBT+/cfCvi+fpDSqWEMj8Q+yrDIhrKlTizQ2bXUkpMlKusqCDtN1zbBd1XzcL3Taw+OsAq7doRL/eJi3aqsZxkpMhYTUG36cwzZF+GAK2bTO2erqHnl3gJ2nNlxnqzyqpFNL9oC3lh/1h09R9ACM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bPXB2iCJ; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4ef7fc70bdeso1534491e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719492575; x=1720097375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+7Qni7r/WgAD7DkgtwtmtiwAZVFbDMDzC460DmWWyAc=;
        b=bPXB2iCJJYWOqJqk5/CjKxWEp18LMeco28Q99Kb4U9kTv9M6a1cFYrR8o00VWAfJIi
         U8hJq1AOHRJtOvFbMwzUH4M5n9ix1/KnRCB6TEWo5L040BM/TjL8HP/uFQjWmGQ0d2HO
         pHTI3EQ6XDN4QAA/n6oFmPDUVg8/QCVUlc9BKmABzCmuxkgkMKgvk0p0Jxj/1oQrPaI0
         rFBR1whsr4oiH0VcAyMla7GnMxkTPn6VOdclEGVZb0Fh5GBtzI9kIi3W359OzXGufYAb
         VQ/TEzTUd0r33Jsrlz2pMa1pKBur36YqRi93lNREDTVYq6kz3HOzdRVnWUyzHPyoHWv5
         HAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719492575; x=1720097375;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+7Qni7r/WgAD7DkgtwtmtiwAZVFbDMDzC460DmWWyAc=;
        b=IQl5M4+uLIKhTz539XK/vVlJFRI4NIVrJhTC6oMC72z6L21wl6NyjW+LcEEDo8kjjf
         DWnr3ikiIhTeG3zON6zW0CGMVFF78p6A3CmGa/UgwqdjC1C5r6Bi3yvQYOh+ALAHTUmX
         SV1XwkONFBH431UeJ6RKL/p+l5sTy/7OMaCXqsOIjpOz1wX9iL8X+qn4zFTt6GW0DhNA
         QhXv/bfc++8cL2sIrtg+xS8VnBLy+ORkdoQgePIW2boHl9FIVNvzJZ+RchEN58rb8Avq
         ANrkpFwel02RlMIBHIIfhf7EOcqwMD1fyxWoS+dTOH5DDRJ+f/McAMVEC0TkSArh+b2e
         MmYQ==
X-Gm-Message-State: AOJu0YwxbOxj0Twj1M4nj9+8z9H47TvFkmsjEWqO42h2dN/fJAMlPql4
	KdrwuITuLOYAboZJ71LX6FPgmWcTMn6k0MfeCuiobMum2vwsLh6I7pfQqY0ywpHAN7YxNW8fBdV
	lJDO98FAhLGHZ3XIny4uyqj5ApJ1bt1XI9O55kMhoBGMCIhmTkeSIFQ==
X-Google-Smtp-Source: AGHT+IGiITpyURlNbsXp5GME0V7s81ygGcIa99Yj2pi1rna6IbK6cbK7/bfy993EzWRjVk+838aCUMLn0wBd+QXyZjY=
X-Received: by 2002:a05:6122:921:b0:4ec:f758:e514 with SMTP id
 71dfb90a1353d-4ef6d8ad6e8mr11872712e0c.11.1719492574631; Thu, 27 Jun 2024
 05:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 27 Jun 2024 18:19:23 +0530
Message-ID: <CA+G9fYtiWKuQzwoBVaBA6zp304uCw5SsHKf3484CY-kuuOgnFA@mail.gmail.com>
Subject: powerpc: nvram_64.c:75:13: error: 'oops_to_nvram' used but never
 defined [-Werror]
To: open list <linux-kernel@vger.kernel.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-mm <linux-mm@kvack.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

The powerpc builds failed on Linux next-20240626 tag due to following warnings
and errors with gcc-13, gcc-8 and clang-18.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on powerpc:

  - clang-nightly-ppc64e_defconfig
  - clang-18-maple_defconfig
  - clang-nightly-defconfig
  - clang-18-defconfig
  - gcc-13-maple_defconfig
  - gcc-8-cell_defconfig
  - gcc-8-maple_defconfig
  - clang-18-ppc64e_defconfig
  - clang-nightly-cell_defconfig
  - clang-nightly-maple_defconfig
  - gcc-8-ppc64e_defconfig
  - gcc-13-cell_defconfig
  - gcc-13-defconfig
  - gcc-13-ppc64e_defconfig
  - clang-18-cell_defconfig
  - gcc-8-defconfig

Build errors:
----
arch/powerpc/kernel/nvram_64.c:79:17: error: initialization of 'void
(*)(struct kmsg_dumper *, enum kmsg_dump_reason,  const char *)' from
incompatible pointer type 'void (*)(struct kmsg_dumper *, enum
kmsg_dump_reason)' [-Werror=incompatible-pointer-types]
   79 |         .dump = oops_to_nvram
      |                 ^~~~~~~~~~~~~
arch/powerpc/kernel/nvram_64.c:79:17: note: (near initialization for
'nvram_kmsg_dumper.dump')
arch/powerpc/kernel/nvram_64.c:645:13: error: conflicting types for
'oops_to_nvram'; have 'void(struct kmsg_dumper *, enum
kmsg_dump_reason,  const char *)'
  645 | static void oops_to_nvram(struct kmsg_dumper *dumper,
      |             ^~~~~~~~~~~~~
arch/powerpc/kernel/nvram_64.c:75:13: note: previous declaration of
'oops_to_nvram' with type 'void(struct kmsg_dumper *, enum
kmsg_dump_reason)'
   75 | static void oops_to_nvram(struct kmsg_dumper *dumper,
      |             ^~~~~~~~~~~~~
arch/powerpc/kernel/nvram_64.c:75:13: error: 'oops_to_nvram' used but
never defined [-Werror]
arch/powerpc/kernel/nvram_64.c:645:13: error: 'oops_to_nvram' defined
but not used [-Werror=unused-function]
  645 | static void oops_to_nvram(struct kmsg_dumper *dumper,
      |             ^~~~~~~~~~~~~
cc1: all warnings being treated as errors

metadata:
--
  git_describe: next-20240626
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_short_log: df9574a57d02 ("Add linux-next specific files for 20240626")
  arch: powerpc
  toolchain: gcc-13, gcc-8 and clang-18

Steps to reproduce:
---------

# tuxmake --runtime podman --target-arch powerpc --toolchain gcc-13
--kconfig ppc64e_defconfig


Links:
--
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2iQqkMfvFPihkYnvWC7UxrVhb1X/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240626/testrun/24453163/suite/build/test/gcc-13-ppc64e_defconfig/details/
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2iQqkMfvFPihkYnvWC7UxrVhb1X/config

--
Linaro LKFT
https://lkft.linaro.org

