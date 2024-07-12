Return-Path: <linux-kernel+bounces-250621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9916F92FA05
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5306B282CEB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F25F16D326;
	Fri, 12 Jul 2024 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jIWPfkOL"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAC216CD13
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720786405; cv=none; b=KQ5ER91Df3O8NVLwNWIKUpJZvn2uzTI8t1OnhJG+4e0MYh9KGt7jewzdncMDh2YbvmzV8T/h+kCfv/Jtoyt4I2gly7IX2clQDUjFChjAvufbT5w7ZdWLy6ycnQ47nGzqzNGq2T/rzoOxbedkMYS2YciqmUqLdX6OPOSCYrzlDIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720786405; c=relaxed/simple;
	bh=LBj4SQRwyrE8yY7XesL7tCePMcwxLzLVnEVEAGo/kgM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZvmEEzf4pGoFEuVz/SXqc3bbc51OTU7fVWFK51rxq75CnGkdNIkkBCLYvFSp42vBqUsIAZr9+6EvJFaMTWhFnqccdbnnSjojh/no3paVmj5YXLhJAIfymiSva8eilBkrbwld1SRKj9CDoU9PHgc1pjWn6mrBP5N7Lv9qaEZb9dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jIWPfkOL; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-80d61a602f2so675289241.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720786402; x=1721391202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gwhdBjeO0fqelfc4OGEmz1A/F4AWgJGOt3zPASzEWac=;
        b=jIWPfkOLbQi9koTqI7C6vxo2g3bbgHgnIiMQnJdo7Mk7SXUSz/DTTtXHMapADCa2pP
         jSlEe/u3/rm2Me4QWA0cvCr7u5i7xVj0N9fC88HHmqVn3I1cBANlyWXXAIEyfVrV0qWf
         Kin8CZ37qEigMmMCmf49t7COqNixjKEIRhvfYcTOX4NrdOF/CGdcISc6sGnqOi/rEBJx
         Hnii0Ncy6abPB0H7gWzSVdqhOgH9kwpfEMf7M1KRHpZpaovro7TeFIxIeO66GXHt18s5
         Qhs/P6ktqFgGxIa3XQq64AeDREyBY4ubEGWht5rOhZsWCBIDPky/R1640J8+N+1xjUQV
         VEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720786402; x=1721391202;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gwhdBjeO0fqelfc4OGEmz1A/F4AWgJGOt3zPASzEWac=;
        b=rVVaiX9Slwg3sFe3DE06Ew/AZpe2idAA0F52xyCpoLtLQbiH0hoFOfcSOZ5WujhwWh
         rveFrqhCysN3NV4b5dPHObn8DzPVfG0pi4O2C+OzNefboGqOPsfTbo2eBSG6LuXGn36U
         PN6006EUDnf2ofMOoi6hYbJkhks75c1esiECpQqu8S66YAkySsZkdosEMbu7S6MMeDL+
         B7nZjNZ7YNzo5owFGLrpObJ4VTJ5HDD5acc5dj2msMdRcDbm2VCb3UnR1OSjhImVUrsS
         0oMMWJA11ceFrggunmO2Pdwzza6BougGdmBC0ZrSXZ+BKdcEwDGM0dbokHZZuwmTjdZW
         Yegw==
X-Gm-Message-State: AOJu0YzEXXvapqhbL57K9JxLg4qht0kFpuWyjJIWYeImQqHRO5xZ2+3l
	nie8dro40fVNvAJQN22aIuOJQG/0uG4mS+tGmnQZRWMwtG3Hkt8zXleC170EKIPsC7CiyKr8rcM
	D5CaXRdVWU+j9/67RdsMmZqXZxIm1WQS9cox98+9JaLpl5BH16jHE2Q==
X-Google-Smtp-Source: AGHT+IEgrOE8YMX97+A4eDRf9A0EAdSUgcmTic5fHDg/T2R33V8gb4DhoqOcfnYofwrjC9lpqa3D2Ysp+1hDHZh7sj8=
X-Received: by 2002:a05:6122:2a0e:b0:4f2:ff08:ba3c with SMTP id
 71dfb90a1353d-4f33f1bf527mr14016158e0c.5.1720786402550; Fri, 12 Jul 2024
 05:13:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 12 Jul 2024 17:43:11 +0530
Message-ID: <CA+G9fYv0xfJbt=+STRDu65G-Tq_w9wEH3C0q1ucyoAa7DbWLAQ@mail.gmail.com>
Subject: next-20240712: task_work.c:(.text+0xc2): undefined reference to `irq_work_queue'
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

The 32-bit arm, mips and powerpc the tinyconfig builds failed on today's
Linux next-20240712 tag with gcc and clang builds.
The defconfig builds pass.

  GOOD: next-20240711
  BAD:  next-20240712

Build error:
------
arm-linux-gnueabihf-ld: kernel/task_work.o: in function `task_work_add':
task_work.c:(.text+0xc2): undefined reference to `irq_work_queue'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build link:
-----
  [1] https://storage.tuxsuite.com/public/linaro/lkft/builds/2j8Y3PffxvTIFJIR8HODmHEU9oM/
  [2] https://storage.tuxsuite.com/public/linaro/lkft/builds/2j8Y3PffxvTIFJIR8HODmHEU9oM/config

Build details:
--------
  git_describe: next-20240712
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 3fe121b622825ff8cc995a1e6b026181c48188db
  git_short_log: 3fe121b62282 ("Add linux-next specific files for 20240712")
  arch: arm, mips, powerpc, s390
  config: tinyconfig
  toolchain: gcc-13, gcc-12 and clang

--
Linaro LKFT
https://lkft.linaro.org

