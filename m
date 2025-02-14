Return-Path: <linux-kernel+bounces-514611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA679A35946
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3C5188FF60
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2BC227BAA;
	Fri, 14 Feb 2025 08:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRR1CKAB"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A508207E13
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739522789; cv=none; b=IUaphgMzB4uquiPTghbP0KCKYKe1CwFqYcEDLakeKAW6KE7CEXLNSlex4XUApb2DAzul4HoxkS25ezj7SuwiO/xpcjPzL5eAPUm4zNmA8UFCQQXMuCCJRINW7ADHUg6flw1CiVatk1u8dbg4A/Bnjw4yK+nuEpbORTxBPcgksFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739522789; c=relaxed/simple;
	bh=DaapRn/iW7Nn3mWXq/1zNU2x1WmgQpD91mDAIchYOno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0pyGfx7i63mravadnfOp2jVPv0Qw642MuPOAVYndoiBSAQSFQwgxtFHbmfAiSsA6/IhvMEb7klB5aEgSkjXPZwiKYLzFD5EU20gXM6NSYIdxJak7akUvM52JCU39Dg/O8ntJEkz6XOiTrbkoXvKYqbtUvNeNLXyAHMamAanDZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mRR1CKAB; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5203e42d3a2so1075344e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 00:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739522785; x=1740127585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s/SpVrueRYoLO67L8eIIkV6jzrQYHfIk1nopkq7+ltQ=;
        b=mRR1CKABP2MCEa4qcB5AWjHEhB9x81OVQR2pLhPKP/4IT5sSa1fRSUaF3TrFwDvWCM
         BPrJAg+JyC6A5MsDVLE3g0UXr1TtuQlnJK/ODRZhsLGDLjY6eScloqDPGz8UCfT0X1WE
         TeFu9cmZxikMC/k1tkUPUAkmtlbG1RzWKBpNILF28etIsTtx/X/M5e54Ea5MQB1lgm96
         nT/jLcScWOKPnLgld/iXBiZhSFnF4AGDhfiOsdXQTQiUTxp6Z3ucp8cdEmmN/hwptzQl
         KdEiTllQOsCI3wYLod0ks3+OPLzK0BrUhAYAAABvce91wzJUhE3AN1krpSXsld6vQGRj
         XDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739522785; x=1740127585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/SpVrueRYoLO67L8eIIkV6jzrQYHfIk1nopkq7+ltQ=;
        b=GsLffo7g2CxYPn6fbuOb0CQkBVd//1F8CR5dT4Rp5XcNOPQdlLhvdpgqTDjacTEfJ8
         ZTgyAykyBn8iAAP/+ORzVYv9h12thO6tQCNaR4EmO/fFQ7jn+jjnN2We1ech07O0anzW
         LUL5MHM0Bfa7ipEkH2oPVaMFGwnbDiBODLuAmw/SqGG/zlC/l0vRAe8RtI76WO2Wq2uO
         iARj4vJ6D9vOs7+NAV7x1/aotwZASXZFIgKf8tpDxAVjeidfxREXg1mbmdqM2dkPxEtP
         bUCeLKW1eQwmLGN0uKaPtN12Y+kihk0pB+U/jV4SbEyzkPeH0Z6QQNgq/JdP9GNO//m5
         sY4g==
X-Forwarded-Encrypted: i=1; AJvYcCXr/9iyKZ6lnf5kYfUMi2FkuBrmt+9irxvDs0YOiAvdcun4/Ysah/CEl/JtksqAnnM8UZdaM31NoIi8HOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjfKBdSsZPIfc9acBS1qFL9GCkjUObIGcI70XPCh4FpYuiTgbQ
	Hsq8Dbhgylt7ZlEzkJ1jdWKO5BEXQEVPoNIxsPxJ6pXgOGbKzmk/P+RNU9Q4R8ts6/A7ItwcAY/
	DI/J7GRvRYfqgzieVOUryAGBx3cnWoQdB7PolbA==
X-Gm-Gg: ASbGncshP+9In9YYo07ZICiFoSmPzti4KyuwVkiSnZpKTJaXXB1H4XnhHthwLieF3PZ
	THArBYxczn3pKz2V3Djn+u0U8RfhQ7fhsomHuGfAilscbQI79PQprneM6TgncJQguM9MXGY2d5P
	ZyEkNnfQmHDzPF+O1JHl9EGAvvX+cswus=
X-Google-Smtp-Source: AGHT+IEmsJZT+jXKj4JBRFBmsWO8P+p3scpYQLSYSd7oc2CaHyRP52nyDmef7v9VG3cRCZJx74tDbUVT3Hl5ru2KBmM=
X-Received: by 2002:a05:6122:2028:b0:520:3d87:5cdb with SMTP id
 71dfb90a1353d-52067c9792amr8941602e0c.9.1739522785112; Fri, 14 Feb 2025
 00:46:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213142436.408121546@linuxfoundation.org>
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 14 Feb 2025 14:16:13 +0530
X-Gm-Features: AWEUYZmYXnFVTFbZ3xpIYpccIn9qqsxnpqLJJ2bHanM_Ra-e0XbxIu6KOWpiedk
Message-ID: <CA+G9fYuVj+rhFPLshE_RKfBMyMvKiHaDzPttZ1FeqqeJHOnSbQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/422] 6.12.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	linux-xfs@vger.kernel.org, chandan.babu@oracle.com, 
	"Darrick J. Wong" <djwong@kernel.org>, Long Li <leo.lilong@huawei.com>, 
	Wentao Liang <vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Feb 2025 at 20:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.14 release.
> There are 422 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Feb 2025 14:23:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.14-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on the arm64, powerpc builds failed with gcc-8/13 and clang
on the Linux stable-rc 6.12.14-rc1.

Build regression: arm, powerpc, fs/xfs/xfs_trans.c too few arguments

Good: v6.12.13
Bad:  6.12.14-rc1 (v6.12.13-423-gfb9a4bb2450b)

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

* arm, build
  - clang-19-davinci_all_defconfig
  - clang-nightly-davinci_all_defconfig
  - gcc-13-davinci_all_defconfig
  - gcc-8-davinci_all_defconfig

* powerpc, build
  - clang-19-defconfig
  - clang-19-ppc64e_defconfig
  - clang-nightly-allyesconfig
  - clang-nightly-defconfig
  - clang-nightly-lkftconfig-hardening
  - clang-nightly-lkftconfig-lto-full
  - clang-nightly-lkftconfig-lto-thing
  - clang-nightly-ppc64e_defconfig
  - gcc-13-defconfig
  - gcc-13-lkftconfig-hardening
  - gcc-13-ppc64e_defconfig
  - gcc-8-defconfig
  - gcc-8-lkftconfig-hardening
  - gcc-8-ppc64e_defconfig
  - korg-clang-19-lkftconfig-hardening
  - korg-clang-19-lkftconfig-lto-full
  - korg-clang-19-lkftconfig-lto-thing


## Build log arm and powerpc
fs/xfs/xfs_trans.c:843:33: error: too few arguments provided to
function-like macro invocation
  843 |         xfs_trans_apply_dquot_deltas(tp);
      |                                        ^
fs/xfs/xfs_quota.h:169:9: note: macro 'xfs_trans_apply_dquot_deltas'
defined here
  169 | #define xfs_trans_apply_dquot_deltas(tp, a)
      |         ^
fs/xfs/xfs_trans.c:843:2: error: use of undeclared identifier
'xfs_trans_apply_dquot_deltas'; did you mean
'xfs_trans_apply_sb_deltas'?
  843 |         xfs_trans_apply_dquot_deltas(tp);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |         xfs_trans_apply_sb_deltas
fs/xfs/xfs_trans.c:475:1: note: 'xfs_trans_apply_sb_deltas' declared here
  475 | xfs_trans_apply_sb_deltas(
      | ^
fs/xfs/xfs_trans.c:843:2: warning: expression result unused [-Wunused-value]
  843 |         xfs_trans_apply_dquot_deltas(tp);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning and 2 errors generated.


## Source
* kernel version: 6.12.14-rc1
* git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git sha: fb9a4bb2450b6b0f073a493bd6a1f54f231413e9
* git describe: v6.12.13-423-gfb9a4bb2450b
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.13-423-gfb9a4bb2450b

## Build
* build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2szXNYzJaqUDby0ajsj9cBcVrPY/
* build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.13-423-gfb9a4bb2450b/testrun/27280977/suite/build/test/clang-19-davinci_all_defconfig/log
* build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.13-423-gfb9a4bb2450b/testrun/27280977/suite/build/test/clang-19-davinci_all_defconfig/history/
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.13-423-gfb9a4bb2450b/testrun/27280977/suite/build/test/clang-19-davinci_all_defconfig/
* kernel config: arm-clang-19-davinci_all_defconfig and gcc-8-ppc64e_defconfig
* architectures: arm, powerpc
* toolchain version: clang and gcc

## Steps to reproduce
# tuxmake --runtime podman --target-arch arm --toolchain clang-19
--kconfig davinci_all_defconfig LLVM=1 LLVM_IAS=1

--
Linaro LKFT
https://lkft.linaro.org

