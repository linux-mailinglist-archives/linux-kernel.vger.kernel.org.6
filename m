Return-Path: <linux-kernel+bounces-378142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5089ACBEF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC82C1F223DE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275721BC9F6;
	Wed, 23 Oct 2024 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="niEG2ho6"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCC01BB6BA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692568; cv=none; b=B6K3+MYZTiLTIgexyPwlTtNNngUPm52jaTdoxt9MFp2vvwUunj0z37q4/+vMEMYjAmN+ylJhzDSDX4X0yNZ45sTBxCj50uavXCIBmmWq8qcPjzweQluxVzr2m0BbJVf1vU5fLL4X6jIXGWbY6OknwDBJ+ayh5kXj1yr6nwzGCMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692568; c=relaxed/simple;
	bh=6AOKjYCCdpV7w43HWjOXv1p+7JwFslskOOtol4WHSk8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bJgE/wlimYdziE7/XBiwDfRHqgoYJc3KjWg4MjmQaIvUAGr/QEUtyclPEDydEN36DAzJbbKNUPTUCbIgqgJbEts3eVH2XpgwmpzYbPzbD83KL7HzB/b4La82rxMvs8itJvcaHJw+Y5AflUzc8ESv7yZSAQK05wwtLrLsSWKN2Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=niEG2ho6; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-84fc0209e87so2210175241.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729692565; x=1730297365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rXlFApdQ/yxNEtQHJ/FByPIiwHHbdQVp4Wj+r/wBYws=;
        b=niEG2ho6FLRxk9NM5y26BIA20kTs5S8Dzr+AYInuHJg0NxQtfTc3PnTRZHtu960v9J
         lILMV6R+6VqljL3eYMzAXO/r0Z0huix2keGSUsiVYBrAQUyiCCb4AvaJ9HORSEBEKx0X
         tOjvnwkuIHaut9sKIZwngkvpnLj9DrWma+Nw/RnFJ+RfPux30f9E0EULPTx66T96Aj0P
         Tz9Wn7wenm/7H0eKj5cR/FnxvTh9RZeIHL0hnbUE6tec7cErW/1qJlbqm0tw6YDeSpL6
         xZ1iVS0J89vXEEFUPYXSkcuU18fAW3snwR1Q21Rbe5zlWQvJhCE1p8S+I3hObQLvQE7A
         wXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729692565; x=1730297365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXlFApdQ/yxNEtQHJ/FByPIiwHHbdQVp4Wj+r/wBYws=;
        b=clApXa9lcuTOX5FyztOhChqSxT0dMlbsRXa33LgUOdE1N4UCMXcwOuUhVDCuKZMVZB
         vAqfAx3yCokYgYVq9wYPeVWkUTfatR3sgwwOVx7lCxnoswNANoB7h6+SWEMFsHn7DkZL
         gsuI+fPWABb2gUnXIwaHy6MMQm1hwVfEXMxMODGUjjYzSbZ/owb2IgwaW2CO+7DSE34R
         YtqugliX0yBWM7x2u+i9BjRmdlcDtJjMEfu8ANttsL2FIlefn+qSbEOcVJSRcSHNbVXD
         WhUpFP4Ew8qdaa5sYFiyEuem5JhP1KixwEueZSwz974Zc6Of7zAhRmlaz0x7Hrxm4ySB
         Cy7w==
X-Forwarded-Encrypted: i=1; AJvYcCX/LjKr9L77LYpHCn1RkVbq8HYXpyCLL+kkXI0axYWPKHs35YJhIf02P5ubkzdGxuWPuqOeFT8l5Iuf2hE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8VqYCXl+RbJHd71H5jQaUceZHKD/jeaINycnCdyqmY66np0hb
	Nc34u+ZbvSyOcySOQrZva/+CCWM2JGvyxuHS3voKNveZltuYEIujz5pMrnhw1WZzH0GiDER/uuQ
	GcMTz5j2I/O6JKhJTtc9/TQlCdgjPnyaaeg1qqg==
X-Google-Smtp-Source: AGHT+IFmh33RgaiUOP+HVY4VUrT5C3eUPjEyz6YTWVUUNNttulktEFsUofYMpaZ2+7uhkX9mpbDW6JcWTu41epLTQ/k=
X-Received: by 2002:a05:6122:32cc:b0:50d:5e21:ef39 with SMTP id
 71dfb90a1353d-50fd01be5bamr3352330e0c.1.1729692565154; Wed, 23 Oct 2024
 07:09:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 23 Oct 2024 19:39:13 +0530
Message-ID: <CA+G9fYuVefYJx9JsVx1Wz5pV1jKCp9eCPtwZD+FVhdk841q1Zw@mail.gmail.com>
Subject: drivers/acpi/prmt.c:156:29: error: passing 1-byte aligned argument to
 4-byte aligned parameter 1 of 'efi_pa_va_lookup' may result in an unaligned
 pointer access [-Werror,-Walign-mismatch]
To: clang-built-linux <llvm@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Anders Roxell <anders.roxell@linaro.org>, kobak@nvidia.com, 
	"rafael.j.wysocki" <rafael.j.wysocki@intel.com>, Ard Biesheuvel <ardb@kernel.org>, rui.zhang@intel.com, 
	mochs@nvidia.com, Dan Carpenter <dan.carpenter@linaro.org>, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The following build regressions are noticed on x86 due to following
Warnings and errors with clang-19 and clang-nightly,
The builds with gcc-13 do PASS.

Started happening on next-20241023.
Good:  next-20241022
Bad:    next-20241023

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
=E2=80=94-------
drivers/acpi/prmt.c:156:29: error: passing 1-byte aligned argument to
4-byte aligned parameter 1 of 'efi_pa_va_lookup' may result in an
unaligned pointer access [-Werror,-Walign-mismatch]
  156 |                         (void *)efi_pa_va_lookup(&th->guid,
handler_info->handler_address);
      |                                                  ^
drivers/acpi/prmt.c:159:21: error: passing 1-byte aligned argument to
4-byte aligned parameter 1 of 'efi_pa_va_lookup' may result in an
unaligned pointer access [-Werror,-Walign-mismatch]
  159 |                         efi_pa_va_lookup(&th->guid,
handler_info->static_data_buffer_address);
      |                                          ^
drivers/acpi/prmt.c:162:21: error: passing 1-byte aligned argument to
4-byte aligned parameter 1 of 'efi_pa_va_lookup' may result in an
unaligned pointer access [-Werror,-Walign-mismatch]
  162 |                         efi_pa_va_lookup(&th->guid,
handler_info->acpi_param_buffer_address);
      |                                          ^
3 errors generated.

Suspecting commit:
  ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM handler and context
    Commit id: 088984c8d54c0053fc4ae606981291d741c5924b

Build Links:
=E2=80=94---
build error link:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2npIm4ZOkWenPJ71UOZG=
57R0jXE/

Metadata:
=E2=80=94----
Git_describe: next-20241023
Git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.g=
it
Git_sha: ceab669fdf7b7510b4e4997b33d6f66e433a96db
Build_name: clang-nightly-lkftconfig
Compiler: clang-nightly
Config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2npIm4ZOkWen=
PJ71UOZG57R0jXE/config
Download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2npIm4ZOkWenPJ71UOZG=
57R0jXE/

--
Linaro LKFT
https://lkft.linaro.org

