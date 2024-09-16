Return-Path: <linux-kernel+bounces-331047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7197397A7B0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C151C24D96
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAEE15B551;
	Mon, 16 Sep 2024 19:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cu8E3QFg"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD405258
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726514257; cv=none; b=tYIKQ1eSsYqawZoKIiPXRxkjFL7Lg+dGkkxOOdcY/qUjIE/a0+PXJvLKYwQqW1iIVW/nm9PTS9soxI22PT16Mdx3MpGoNKholwDWpzy0/dXktUBtT32LIjcsC6E2EumQNqYeNmqrAKk5B+9153IFHET+0DHWQG8K/2guqpanf3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726514257; c=relaxed/simple;
	bh=e0ST16hFS8BD4t8TE1aEuiovt67c4WgIofkhonJHDoY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GgUf38VV/LfKbLCvdOl44q1wimKBaTs3lj3Yqsy2JJQ4aXoiABoluFKZbNN+xiYFv9zJDDy1KQEpKTFMqiItRmna0HGTMxG/HgvIBToJ5mLc80k1IBMuDrVlfHMQA04A1/Z9vVqO3zzzkntNGhslOpmYW0HwITydLeL/P+gfEHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cu8E3QFg; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-846d536254fso1229909241.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726514249; x=1727119049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vqx3usVPpKT0iyvBpApWWwNta7RIraSs6wvkWJ44Agc=;
        b=cu8E3QFgjarVLCsTJS+Su0+l3NIcNuNMDVmy1Kj6YQthEV7OmV/4kE7W3fYjnBEGEa
         YvuF4ej5QOUN9oEGah5oK2MqnxyYhr1j5NX4/d+GMSQhDVD3ajYSOKTysfeMD+Hzojzn
         4y1f/so7MvdbreLZq/Q6nCt1iJPkyh3OmAORRgkoWAFVj43ZXxcaG7vFCVhOI8GDFyzX
         uYKikj0Z8SOpcbvK0YyKreI/WpZY6acG3jXFMRYhkzH7ZBCyzf09Ly5Y1b1ZR03y4oSA
         2z+WjuP1EEdW2+f1wYVUkf0YKjx26hG2QeEQgC4oyjN4A1S7qzTQwGkIe4sr3ZRpkL4s
         hw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726514249; x=1727119049;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vqx3usVPpKT0iyvBpApWWwNta7RIraSs6wvkWJ44Agc=;
        b=k56voN922zxTAc6r3PSitSKnPNF2eUlAB+YOYfg+WdkePgbBapBCjQZOXxyPZK21or
         wBBYtQQxX03USlI1WoXRi1x+s3bn2KXYSBznOG2rOBRNYgEeb1UsMpRhkTqIrATarKRc
         R/cpekNsP6mALOUGxCD/UZpEa1mFkiBY2iR+qUIDwNthAgZNam/zhIms/q3nxRjfmRAu
         WO0yRqtg0Asw2HsxkCQWaib6M5jZpl1A0uPiyK6hLlMx4AKquU1r9RTU7akcdm+vRBfF
         D/dwOJStYS6+LBsbYfpTsiISzUeAbgRdj38J90pD0KZVTogeZBNuNraC0L63v4Ng05bD
         CpFw==
X-Forwarded-Encrypted: i=1; AJvYcCVviPwEi1L91x3lPygnuD1aMPqJi7Rr3qD0appFQ/E9oGBr2uWN+b1C/OpjbKKc4XlbvIBXb3Axs0mbmk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDG5guek7KpkpxdqZlNzLS4CK5oliI4NUiApk7hpIkNbNE7M7n
	DIk+WTx0Z4OZ9sLcVj0vFA3AfzUyuzasZDTMfU2CXE0WhGT1Ml0i5/PAd/WvA+T3115YHbqpLPy
	HlXfaJ16nRdQIi1N+Ba8FEXwIPNIcglE16rl/8Q==
X-Google-Smtp-Source: AGHT+IFS9//ZCamdnpFlaBqZvxOqDw7qKjCs+is9WBT+P2HGRgdKr849Izo3HFvk8azXHKlcu7vS45+Ic9quvSm42II=
X-Received: by 2002:a67:f41a:0:b0:49d:43d0:9913 with SMTP id
 ada2fe7eead31-49d43d09d07mr9444822137.19.1726514248829; Mon, 16 Sep 2024
 12:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 17 Sep 2024 00:47:17 +0530
Message-ID: <CA+G9fYuaDUCxseqCW8BO0KhLKn6F0VHYaAhu-T9v-MJHzJebcQ@mail.gmail.com>
Subject: rustgcc-kselftest: error: unknown unstable option: `patchable-function-entry`
To: rust-for-linux@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, aliceryhl@google.com, Shuah Khan <shuah@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The x86 rust gcc builds failed on the Linux next-20240917 due to following build
warnings / errors with rustgcc for selftests rust builds.

First seen on next-20240917
  Good: next-20240913
  BAD:  next-20240917

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

build log:
--------
error: unknown unstable option: `patchable-function-entry`

make[3]: *** [rust/Makefile:392: rust/core.o] Error 1

Build Log links,
--------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240916/testrun/25144919/suite/build/test/rustgcc-lkftconfig-kselftest/log

Build failed comparison:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240916/testrun/25144919/suite/build/test/rustgcc-lkftconfig-kselftest/history/

metadata:
----
  git describe: next-20240917
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git sha: 7083504315d64199a329de322fce989e1e10f4f7
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2m9CHpK6gWVXL2Rjt0R5TdMRwKg/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2m9CHpK6gWVXL2Rjt0R5TdMRwKg/
  toolchain: rustgcc
  config-name: rustgcc-lkftconfig-kselftest
  arch: x86

Steps to reproduce:
---------
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2m9CHpK6gWVXL2Rjt0R5TdMRwKg/tuxmake_reproducer.sh
 - tuxmake --runtime podman \
           --target-arch x86_64 \
           --toolchain rustgcc \
           --kconfig
https://storage.tuxsuite.com/public/linaro/lkft/builds/2m9CHpK6gWVXL2Rjt0R5TdMRwKg/config
\
           TARGETS=rust debugkernel cpupower headers kernel kselftest modules

--
Linaro LKFT
https://lkft.linaro.org

