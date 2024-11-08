Return-Path: <linux-kernel+bounces-401341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611989C190B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D301C219C6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A631E0E0F;
	Fri,  8 Nov 2024 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FgYh+mWB"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0327D1E0DE0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731057744; cv=none; b=WiqmoHIuL3BO7gObJzS/wv1tQfwljDEvsaR/bP1F4viCF+4s5YQGHjcw9RcMnE3PxtgyBRBTGe/LjystJy7mJpGWPFDBBOXKCEXbWPMW614qXVMkRpJTNS6t5BlofUR2avSI6MBpyv98qSnH/X9LrCariK++YUbmtZmHg089C4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731057744; c=relaxed/simple;
	bh=mToIfgerRVyMr4NQEYxCA3VbBeobwYg494v9mWCYPwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IoVcIIX0zm5A/0T5RxapyeWBDrjakVIJOcjzWxyBp2jowNQ8R6WmtU+DO/QJUD1ioiOO23nHm1qgYUYoyCOUGZXv28QbfjMXyy833flG2FVl/AsQjPt/bsyYFq1cxBxkiAWeOwZqb0UMKjMhoaM+OcHuZVPq17uqXZvXSg4zX/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FgYh+mWB; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-84fcb49691fso807855241.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 01:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731057742; x=1731662542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tC21RYuyoliwxkob9Q53u4Vn3W7koImw4VYvvt4XkW0=;
        b=FgYh+mWByVHbJY48icieCCd5KZfhMjdLF8Qzn3Hs/akWwNJtvyEihYnTGzkK3ZzOda
         KKEThVIKB7qk1yBhjArAmyXcEVFcDuecfhnS2/7SUvNPw4a6x2taBDMpCYdj+8kHWChf
         g/V/9zy4fJcbTJtuTJfoFxtl1K/Cl/FdkCP1Hue+0WWWdtXOtreR1EaZpNsxyfdStBUx
         scVDEuUuCtH1fmYz3vgJ4PPmiO75yhhZxzi79AumfLt8HTdaZX+x2RUY6/OZQzTj6Fb5
         8KfPXcAOJ98dRSACJ+HbAr8S3C3mI+kqcRIlfe+pfeUPrrmljvqXMdMPvDmrxHaSkjY7
         u78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731057742; x=1731662542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tC21RYuyoliwxkob9Q53u4Vn3W7koImw4VYvvt4XkW0=;
        b=QRcJNPVZ3tA58xMrKQb2iFc0p3S/YIDUEZ4KsxCHdk9dPiJ4D3mG5e+BKGUMulzYrr
         s7o/82aH7H2ZfsuoB1cSCMQAgoc5Opk9rucY24S3r76G9FcYzN289mBNe6VOuZ3+pbqB
         BiiqofXmHT8iYCP2F5wDyV341ufaEYcZ8Zb7sMxLkW56llqKRCvAqhq1zHdKVKoKhmzf
         6vwi2foHDxkoAHYtzApsr3Q4dzRNNr/dJdFGtbSjPURm7zHs65j095mOjm/EdjiJ6std
         6yVN1gn8ZeU/ecypsO9fA86EMtUss+aGi9QpfvzLKqbepzJ64E9NvnhkYA69xbv/Jy6z
         uJ5g==
X-Forwarded-Encrypted: i=1; AJvYcCXyxPX06sYL/gZ5wQ5qvGFyS17bQ0iiKduhKGM1A1aeKsymvep9i3bExp2ZRMupT4WI8xhyRVbrHRnRXNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGZgSNrDfXT8sTQry2pW2WRId6WFez7cUbPh9I2PJhaKPOiW5C
	GXdMYo2paLIYHoAXC9s41mB9NIUwncDEj6v8uDAFh+xfHAQVARh526QWVmFvcV5RddhYgCGaECB
	ty7WSqQqQyb0j1c6uEDlgu1abhZ1iRECasa1+FAOevjtXZNmN5yQ0ag==
X-Google-Smtp-Source: AGHT+IESWzjH3DKo0FBP1C+K3PcYQOQo9jEzNKav6p3scDXxymE33J8RVLPJwgXLoK94kbQxLatI16b3kt5EXgeRGNo=
X-Received: by 2002:a05:6102:945:b0:4a5:b5db:ec5e with SMTP id
 ada2fe7eead31-4aae16714b4mr2278576137.27.1731057741902; Fri, 08 Nov 2024
 01:22:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107063342.964868073@linuxfoundation.org>
In-Reply-To: <20241107063342.964868073@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 8 Nov 2024 09:22:09 +0000
Message-ID: <CA+G9fYs8jLY9t=u+rBJ8e18LbpB10ortb6q8j0r8yRPw6-J=JA@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/349] 4.19.323-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Nov 2024 at 06:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.323 release.
> There are 349 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 09 Nov 2024 06:33:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.323-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
-----
As other reported the following build warnings were noticed.

fs/udf/inode.c:2175:7: warning: comparison of distinct pointer types
('typeof (sizeof(struct allocExtDesc)) *' (aka 'unsigned int *') and
'typeof (&alen)' (aka 'int *')) [-Wcompare-distinct-pointer-types]
 2175 |                 if (check_add_overflow(sizeof(struct allocExtDesc),
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2176 |
le32_to_cpu(header->lengthAllocDescs), &alen))
      |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/overflow.h:61:15: note: expanded from macro 'check_add_overfl=
ow'
   61 |         (void) (&__a =3D=3D __d);                   \
      |                 ~~~~ ^  ~~~
1 warning generated.

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2oVnF1lNXvgGOE2tM=
mzH9cSJwwP/

## Build
* kernel: 4.19.323-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 9e8e2cfe2de91cde6ce1f79021b5115f44355ce8
* git describe: v4.19.322-350-g9e8e2cfe2de9
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.322-350-g9e8e2cfe2de9

## Test Regressions (compared to v4.19.321-96-g00a71bfa9b89)

## Metric Regressions (compared to v4.19.321-96-g00a71bfa9b89)

## Test Fixes (compared to v4.19.321-96-g00a71bfa9b89)

## Metric Fixes (compared to v4.19.321-96-g00a71bfa9b89)

## Test result summary
total: 24015, pass: 18823, fail: 189, skip: 4969, xfail: 34

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 102 total, 96 passed, 6 failed
* arm64: 27 total, 22 passed, 5 failed
* i386: 15 total, 12 passed, 3 failed
* mips: 20 total, 20 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 23 total, 17 passed, 6 failed

## Test suites summary
* boot
* kunit
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-crypto
* ltp-cve
* ltp-fcntl-locktests
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

