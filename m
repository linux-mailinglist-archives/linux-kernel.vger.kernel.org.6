Return-Path: <linux-kernel+bounces-310898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D80796829D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D25F2849BC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A752187843;
	Mon,  2 Sep 2024 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zu8xWofJ"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290F2187571
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267672; cv=none; b=bk03dsL+CbSBDeyl4gytvlsolVScHD/u5SVoewi52gZV30X1JXgNGjlulxKfPmNLnZmbD4ui+GsCQZjhsuUGr++Y+ZaUtRtQr6zKAnYNCSDHfkefNtC2ZxrZjl/PDh6QDarNLUPMO493rp8gIUz044X0vI0b8forA6z0Lcrjhrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267672; c=relaxed/simple;
	bh=UF/oNZ5SbgpZ4WIfaXfqh3OBB6cIqxui1RRnAIkH+PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMsH8W+qyGNUnIKeszGB0LKAOZyJtHqH1AYUHnjgdmzzHpRSr6aS0kbkrVjS9qqy8QL1/4xaMbvP3Qt/TtLqH+/UKFYY+Tz/Tuqdop8zeqEmu0l5+pEW+WvaGNzCjWWT4M+UEmrit1aH1G4rdEICgDLHnXlBy91AhJrg3Ve6n2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zu8xWofJ; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-498cfbc0b05so1487442137.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 02:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725267669; x=1725872469; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qqSh94kF96VerY0m3+ny14R8sqauQwh7BBb3bguK3jo=;
        b=Zu8xWofJASIFEOZC0HRN6C21QBC3rDmPK3KiMfJquClm31PtTEMPhooMXdzc2TwgZd
         i1TfR3FqMD9ZW4Ld15TA030GCXOK7hf6Uj0sv4PKHypTpsO+LcUpA16MQoF7k5njO2v3
         h7Bkr24+F0XxOOVPSW1mR/ck/DDkl3rUyqfRx9cRsQssq2X9Du/VKfn+52am+8TtDE8i
         3EAam1K9rqeopLSAQyKFKV6NnFndhRkrc6QAiYmNTmMsIDiFSub4z6orvBFG6dVGScm1
         SD/YtHA+lcNE3sQeoEqqZhJpIMxspPKxWCio6q1aK5r90/PhaqTlObYn6PkUsL5Zy9GW
         Uugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725267669; x=1725872469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qqSh94kF96VerY0m3+ny14R8sqauQwh7BBb3bguK3jo=;
        b=YfaSGs+gK82+NBxVDBUs4VCpsNLua72vOJ55FpHZpU7asXVHoRtMm0s/17ZmO6vOtk
         tBae6Qu8jx8D03yGcNxCs1TDqVc6e/an8inca+TA6L8PK6dtNi2BznWQYXh2bk6JP6mW
         KkR1SPO7z9njbYvcPRSKUts9LFO52A7jjQBqs9o+3Bm+jx2Gu2s85lS2f9p2leHxKFF7
         X/b04rrGUfm2oIs4AUeMjG8P9fucaBjk9s2dObA2BhlpwBUZ6OmM7B8pmMZSRcE3McE6
         RR22v+5qfd2s0Uwp8idcJZ2zu7R78i1r28TNwggnuHnJMXBuoJ6UnwAU7d2MI2lURnFl
         y1Eg==
X-Forwarded-Encrypted: i=1; AJvYcCU1CjIWSzo/lmJgkLDx/JrHqOPM1jhekpC+lFw49A+kfjZmHtJl3j9cXEkOsbsNRPTdBY1tZezlxN+3bW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVmEgLTlqnOBzif00u/+bW7B3SDV+NhFtYp+kCVJuDbEXLHmSM
	ClgPJcRjfTWYeoFcSzrFrZ0sVPPSYs7c7kqzucukhQo/A6sE5FUYhYlFqs0KwjEw6vBZfm8R5I5
	VKoB7R56JIzbDHBuifj15NSzfOrhAMKlRsg/+lQ==
X-Google-Smtp-Source: AGHT+IEvo6sNwVTRnSmRm3IVSdi1vc5y1sUmNJLRLJrwsKN7lJkndFUCHSw+iSloG1P66HIall33Bpam1LCeHWDoX0M=
X-Received: by 2002:a05:6102:a53:b0:498:e25c:738f with SMTP id
 ada2fe7eead31-49a5ae82463mr15833583137.18.1725267669045; Mon, 02 Sep 2024
 02:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901160803.673617007@linuxfoundation.org>
In-Reply-To: <20240901160803.673617007@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 2 Sep 2024 14:30:57 +0530
Message-ID: <CA+G9fYscUiPT0Eo9yo4UhJq2jjYtvLhOofQKhAMEOiVueR-Vaw@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/98] 4.19.321-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>, aleksander.lobakin@intel.com, 
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Sept 2024 at 21:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.321 release.
> There are 98 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 03 Sep 2024 16:07:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.321-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Apart from Powerpc build regressions we have noticed s390 build regression.
The S390 defconfig builds failed on Linux stable-rc 4.19.321-rc1 due to
following build warnings / errors with clang-18 and gcc-12.

This is a same problem on current stable-rc review on
   - 4.19.321-rc1 review

In the case of stable-rc linux-4.19.y

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Following two commits have been added on 4.19.321-rc1.
-------
  s390/cio: rename bitmap_size() -> idset_bitmap_size()
  commit c1023f5634b9bfcbfff0dc200245309e3cde9b54 upstream.

  bitmap: introduce generic optimized bitmap_size()
  commit a37fbe666c016fd89e4460d0ebfcea05baba46dc upstream.


build log:
--------
drivers/s390/cio/idset.c: In function 'idset_bitmap_size':
drivers/s390/cio/idset.c:21:28: error: implicit declaration of
function 'size_mul' [-Werror=implicit-function-declaration]
   21 |         return bitmap_size(size_mul(num_ssid, num_id));
      |                            ^~~~~~~~
include/uapi/linux/const.h:32:44: note: in definition of macro
'__ALIGN_KERNEL_MASK'
   32 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
      |                                            ^
include/linux/kernel.h:58:33: note: in expansion of macro '__ALIGN_KERNEL'
   58 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
      |                                 ^~~~~~~~~~~~~~
include/linux/bitmap.h:215:34: note: in expansion of macro 'ALIGN'
  215 | #define bitmap_size(nbits)      (ALIGN(nbits, BITS_PER_LONG) /
BITS_PER_BYTE)
      |                                  ^~~~~
drivers/s390/cio/idset.c:21:16: note: in expansion of macro 'bitmap_size'
   21 |         return bitmap_size(size_mul(num_ssid, num_id));
      |                ^~~~~~~~~~~
cc1: some warnings being treated as errors

Build Log links,
--------
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.320-99-g0cc44dd838a6/testrun/24994013/suite/build/test/gcc-12-defconfig/log


metadata:
----
  git describe: v4.19.320-99-g0cc44dd838a6
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: 0cc44dd838a6e3fee60d7af3ca412c4d1b824562
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2lTf8qakoJKDjTgS3TvH3naApk1/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2lTf8qakoJKDjTgS3TvH3naApk1/
  toolchain: clang-18 and gcc-12
  config: defconfig
  arch: S390

Steps to reproduce:
---------
- tuxmake --runtime podman --target-arch s390 --toolchain gcc-12
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org

