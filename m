Return-Path: <linux-kernel+bounces-391922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B409B8D63
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B85C1C21799
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 09:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E662C157A46;
	Fri,  1 Nov 2024 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SBSi1bVc"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2101A3FF1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730451693; cv=none; b=gcy9Ho21GIFROy559nd9GZm0TnXfdGscrkkqNtqpkFYPhMB8ZbibQmqW4O0EZoe7jMI257kRry4c2BO+4D3h0SFS8h26NI8nDl1Ie31f8SzPOlkY4wLQgHLru0knYXsV4VvyW70ASk9u8e0Ab3iXTF6bGGyR72Nv/wXIrtfIFsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730451693; c=relaxed/simple;
	bh=NwXYkU476LZtGluB4lV1HIV7sAeNYigHhuApbCJpgyI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=k/IISFhYGsNo665y17VtNYdhBtGBc7+/wvOz0RYsUtrwQXAyJleq4i8yOyfS6Zpw26A62OtWo7YaS/ZVfhrE7ZbaZCHkFHLea//y1ZLp44WuRLCzjOsU+K5rTU+YJQH3I3W4ud0JQE2Vmcky3lTqzoCpDtKwbXASzAmgIMIQrpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SBSi1bVc; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e607556c83so1005192b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 02:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730451689; x=1731056489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7hAIS5ePVJ+LyF/EPZq+6vW+8bpoW4OU+Q4L+IGQdhM=;
        b=SBSi1bVc7QryXZs8t2G/sARAbbQ9L2vsLBD+N1vb+57eOcMGtMbgSrq36ElfUkm/xB
         XZIpHWU4XmSb2jKAK8gqUOqlKnPEwaWiDLaYlf+xgdiuZYja1TziugX9OFxVKw13N4HN
         gD4xsGgEw36iPvg8yd68jwC8PtzKE8Bm3J3Z08seOvMcj3kKSi+Ge7zWgP+alFHaprRM
         rV+eCUW2ChffBkZCF7wxIkIa0/nBN9dYrYUMx2OueBxGc1yBYoBqyWEplkUJcXNig5OT
         A3osPpKVdgDWF92rZqO6UqqgjsINPAXLNszwKGjLf7RzqpLclfq1NoSI7Vu4qWBt9NGj
         TQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730451689; x=1731056489;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hAIS5ePVJ+LyF/EPZq+6vW+8bpoW4OU+Q4L+IGQdhM=;
        b=Z4GuZMjy4SrHywCRnv/EudsP3eXeyVTdEWiCEaWUxhWaTKWwTFGDIBGWx6DfpLfLwG
         oZ1c9v7swIE6G3Y5vgAtfvWpnYTWFFK3D9Jyu2y8IloW5hTMlnG4g79CcskHbbMzTe3t
         XtHZf3v7i5rcLbqfo01DJNvC4YcudzRgAa0+qjqZABvPgDEq60bYe+VZUDkJJ66SM0Dl
         y712qA6sOLl/jArOQZZu5T2f6SPI80cSBaO2vTBPnboP7CVrHEqGZV07JHvTHu29lqoQ
         yDIlR20VGPLiFOiSFOUoGq7pal7MDmRVKc3ljy0yR22W/t41k1UiOKYQOJ0uCZQKudPM
         rJDg==
X-Gm-Message-State: AOJu0Yx4K8Gx6MaF9Pp41iZ+2YxtvlIS6IZkKiw03Fwi5MUbwuh65h7B
	7sCzI8IxN2SlTjwBu8XDM/dtafHn2FTRvRdRKUzHO9FFFQKSWPrUXdLnfRte2KPTYRO2M/s5cYg
	W4PJIBCaHIQBsCutx7lE8KZIKUPjQdNbIbsNxDSbzlUenCv29cbw=
X-Google-Smtp-Source: AGHT+IGaH57iqzcu6+LLy0GxLcoHNVWRsTAHclSdPzMpgspZ7/pcrULQzVzWxa4HnMZnY5zXwOjo7nllXmEuskDaKpw=
X-Received: by 2002:a05:6808:338b:b0:3e6:3867:b630 with SMTP id
 5614622812f47-3e63867b653mr18725783b6e.6.1730451689515; Fri, 01 Nov 2024
 02:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 1 Nov 2024 14:31:18 +0530
Message-ID: <CA+G9fYv_Y2tzs+uYhMGtfUK9dSYV2mFr6WyKEzJazDsdk9o5zw@mail.gmail.com>
Subject: next-20241101: rust/kernel/security.rs - error[E0061]: this function
 takes 2 arguments but 3 arguments were supplied
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	rust-for-linux@vger.kernel.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, aliceryhl@google.com, Miguel Ojeda <ojeda@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, kees@kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The rustclang-lkftconfig-kselftest builds failed with rust clang on the
Linux next-20241101 tag.

First seen on Linux next-20241101 tag.
  Good: next-20241031
  Bad:  next-20241101

arm64:
  build:
    * rustclang-lkftconfig-kselftest

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
error[E0061]: this function takes 2 arguments but 3 arguments were supplied
     --> rust/kernel/security.rs:32:28
      |
32    |         to_result(unsafe {
bindings::security_secid_to_secctx(secid, &mut secdata, &mut seclen)
})?;
      |                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                    ----------- unexpected argument #3 of type `&mut
u32`
      |
note: expected `*mut lsm_context`, found `&mut *mut _`
     --> rust/kernel/security.rs:32:70
      |
32    |         to_result(unsafe {
bindings::security_secid_to_secctx(secid, &mut secdata, &mut seclen)
})?;
      |
      ^^^^^^^^^^^^
      = note:    expected raw pointer `*mut bindings::lsm_context`
              found mutable reference `&mut *mut _`
note: function defined here
     --> /home/tuxbuild/.cache/tuxmake/builds/1/build/rust/bindings/bindings_generated.rs:76185:12
      |
76185 |     pub fn security_secid_to_secctx(secid: u32_, cp: *mut
lsm_context) -> core::ffi::c_int;
      |            ^^^^^^^^^^^^^^^^^^^^^^^^
help: consider removing the borrow
      |
32    -         to_result(unsafe {
bindings::security_secid_to_secctx(secid, &mut secdata, &mut seclen)
})?;
32    +         to_result(unsafe {
bindings::security_secid_to_secctx(secid, secdata, &mut seclen) })?;
      |
help: remove the extra argument
      |
32    -         to_result(unsafe {
bindings::security_secid_to_secctx(secid, &mut secdata, &mut seclen)
})?;
32    +         to_result(unsafe {
bindings::security_secid_to_secctx(secid, /* *mut
bindings::lsm_context */) })?;
      |

error[E0061]: this function takes 1 argument but 2 arguments were supplied
     --> rust/kernel/security.rs:72:18
      |
72    |         unsafe {
bindings::security_release_secctx(self.secdata, self.seclen as u32) };
      |                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ------------------ unexpected argument #2 of type `u32`
      |
note: expected `*mut lsm_context`, found `*mut i8`
     --> rust/kernel/security.rs:72:52
      |
72    |         unsafe {
bindings::security_release_secctx(self.secdata, self.seclen as u32) };
      |                                                    ^^^^^^^^^^^^
      = note: expected raw pointer `*mut bindings::lsm_context`
                 found raw pointer `*mut i8`
note: function defined here
     --> /home/tuxbuild/.cache/tuxmake/builds/1/build/rust/bindings/bindings_generated.rs:76201:12
      |
76201 |     pub fn security_release_secctx(cp: *mut lsm_context);
      |            ^^^^^^^^^^^^^^^^^^^^^^^
help: remove the extra argument
      |
72    -         unsafe {
bindings::security_release_secctx(self.secdata, self.seclen as u32) };
72    +         unsafe { bindings::security_release_secctx(/* *mut
bindings::lsm_context */) };
      |

error: aborting due to 2 previous errors

For more information about this error, try `rustc --explain E0061`.
make[3]: *** [rust/Makefile:405: rust/kernel.o] Error 1

Build image:
-----------
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2oEm06IqsdrtzGl1UIGSDghznWx/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241101/testrun/25629042/suite/build/test/rustclang-lkftconfig-kselftest/log

Steps to reproduce:
------------
 - # tuxmake --runtime podman --target-arch arm64 --toolchain rustclang \
             --kconfig defconfig \
             --kconfig-add
https://gitlab.com/Linaro/lkft/kernel-fragments/-/raw/main/systemd.config
\
             --kconfig-add tools/testing/selftests/rust/config \
             LLVM=1 LLVM_IAS=1 TARGETS=rust \
             debugkernel dtbs dtbs-legacy headers kernel kselftest modules
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2oEm06IqsdrtzGl1UIGSDghznWx/tuxmake_reproducer.sh

metadata:
----
  git describe: next-20241101
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git sha: c88416ba074a8913cf6d61b789dd834bbca6681c
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2oEm06IqsdrtzGl1UIGSDghznWx/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2oEm06IqsdrtzGl1UIGSDghznWx/
  toolchain: rustclang
  config: defconfig
  arch: arm64

--
Linaro LKFT
https://lkft.linaro.org

