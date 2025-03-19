Return-Path: <linux-kernel+bounces-568195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864BFA69054
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A384717A79C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22895218AA3;
	Wed, 19 Mar 2025 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eoDjPgnw"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F179421638D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395083; cv=none; b=ZP8I/C3M/QidmWnAAjapLX5c9df0FrB7dDQJQ5jqHE8rYHvjXZ24RS9k6qqJiklVrf+742rv4gfj8TFyTIHxBKGVXIm5fOXAebGwmdOjzh4mtHcMdqcczEz9EEmpTf074aJKHla1fXqEN98KXcLeZPsvY5fnQSW91Mdb1IM5pCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395083; c=relaxed/simple;
	bh=SWQiLXz3UQSRH0sgda5pipDAoE1Jf6PULp6wnmA0Nrc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dWW+UcHiCQhuA1i8qlFaGbLkC37yAuLlzDtAiZW6VEJpmm9CaSnRr0QIyynaKkVjRtjEg5XrIE6VxTIYHwq3rsuf0lgCsRNVSqeKJF2AQxqKNOrut28Cm+9syGDgr5Zn/UZd0ZxaVm1i9LrdTlyQKMCrpRr8f3SQha6H7P4O/bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eoDjPgnw; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-523eb86b31aso2861224e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742395080; x=1742999880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EAQMc4ueVeym6ao2O+BFRKNQiM2evdanfHeGpELVuW8=;
        b=eoDjPgnwEl3Sz4mIsyVu4Zds0eU1MJqfzhG4D5bXkZymT70ycqVzAD3UQ+m+Nd7NZD
         +N2iQf0+JCAR0Ak75s+jXpwFu2+BQEAUOTepNojVgzv5hEs3jbIVIM7/sA0yD89x+aWn
         9xrs5b0teIUnfhziufpCNPFEmLMzwbKB/19KmYHFgFD9HBhPcAP5fpbdLHiLFjjpdoNy
         m2PBqdxOnm9XkXGa8IfY6W1yuqrjas+NIoO0aQoAxJzRd53O70m1pKoMaVxcX4gWsCPd
         2L3OauMcuZPDutHE6ikmRxbcuWtQoBwmxLJHng5vukKwn0aqLHhKUgbzE9Fm53OU7M77
         RRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742395080; x=1742999880;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EAQMc4ueVeym6ao2O+BFRKNQiM2evdanfHeGpELVuW8=;
        b=tZ8gdYM7WX0v7Uj+sLN9S//I/q8wm6IGSh9Fl3Ik++Ev4OzLPkzlUUWPFbyiuyWhq+
         VnWVHoflEX5AmzX26d7xBdvUhvqy07vXEl3+V2liCHuMlzz7WQZb8dxTE4+y2gLLBKj1
         CeOA2rXporXpTX3Va5Pg/ZgO9f5hb1tC6c1VHAZVcdXsoXsvu4vczMgCfOEnaRhJhkz2
         15ynR6u/mIlS99DElott/k8691Cz2H95XVuugQooMa8S7/jl2rj62LxpANrYXXpRbFKc
         lvzCdGlUoJ8yl1msW0DJOXPDmGpt07m/q6ZkQyVfyuP5D27XdFO6ISjbIuTpnh9AwJX/
         7Skg==
X-Gm-Message-State: AOJu0YzcM6CjQY8p3748KlzcMMHsvY/unfGAvQscIKzHjgg24FITIyNh
	UrvZLVlkI7Fu9YzsqfDhqS6doKW1RnQ4/4F+92rVMCMyjUjWhnyE4UzWtd3CH51RRaUGBDGcnxF
	xdJP4rzh0QIeHWE8JdDc2tiz0TfH8MHo+i8gl/iA2vykTHqqoIww=
X-Gm-Gg: ASbGncvVasFEaekVJ7Z7MQi4A0LnHCdIUULr5aFw7EEMd+fdGd555dHUNlnpcwbE9Ta
	zq7zpxapjyUTOiMY958uONzBBNyfXDxP50RcVdPVtQ0K/vXbzxp9vdcDU3Ye7xzQ0eNnl9OQG8B
	dx4ITqkY+8DM7ZK62Phs5UjCJIC9wckmo/27MnPNrehfrdsn17B46IW2A=
X-Google-Smtp-Source: AGHT+IGxLhVT/ftDT8iYJ5Mr8vDPr54sfBtr7wxTMeJWhsyv6YLFWJHjY8iY8qPGLL2vFTHUSH2SqM4ZK2rC2ioWlfU=
X-Received: by 2002:a05:6122:1d12:b0:520:997d:d0b4 with SMTP id
 71dfb90a1353d-5258918cba1mr2246266e0c.4.1742395080564; Wed, 19 Mar 2025
 07:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 19 Mar 2025 20:07:47 +0530
X-Gm-Features: AQ5f1Jo_Jk6yP8Zz1gP_WLfB-CYzXNkDEG6hUQTy-hEqsCfLQJSmsIGoXWLSd3U
Message-ID: <CA+G9fYvPu+MQKhYyPZSSDpAn-zhRGmeHQ8hJksT_cdDdxfbB-g@mail.gmail.com>
Subject: Fast model boot failure with Linux next-20250312
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, kvmarm@lists.linux.dev
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Rob Herring <robh@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Aishwarya TCV <aishwarya.tcv@arm.com>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Regressions on the arm64 Fast Model (FVP-AEMvA) caused boot failures starting
with Linux next-20250312 and persisting through next-20250319.

First seen on the next-20250312
 Good: next-20250311
 Bad:  next-20250312 .. next-20250319

Regressions found on FVP:
 - boot

Regression Analysis:
 - New regression? Yes
 - Reproducible? Yes

Boot regression: Fast model boot failure with Linux next-20250312
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Anders bisected this to this commit id,

# first bad commit:
  [858c7bfcb35e1100b58bb63c9f562d86e09418d9]
  arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9

NOTE:
  LKFT is currently running FVP Fast Models version 11.24.
  Planned upgrade to the Fast Models version 11.28 in this sprint.

## Boot log
  <No crash log on the console>

## Source
* Kernel version: 6.14.0-rc7
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: ff7f9b199e3f4cc7d61df5a9a26a7cbb5c1492e6
* Git describe: next-20250319
* Project details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319
* DUT: arm64 Fast Model (FVP-AEMvA)
* Toolchains: gcc-13 and clang-20

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319/testrun/27675691/suite/boot/test/gcc-13-lkftconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319/testrun/27675685/suite/boot/test/gcc-13-lkftconfig/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319/testrun/27675691/suite/boot/test/gcc-13-lkftconfig/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2uX2EtC2pQdmVZ7ccoyhoi01Yy0/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2uX2EtC2pQdmVZ7ccoyhoi01Yy0/config

--
Linaro LKFT
https://lkft.linaro.org

