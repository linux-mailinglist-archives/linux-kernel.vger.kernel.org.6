Return-Path: <linux-kernel+bounces-182017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE0E8C8529
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 13:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096621C22750
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916EE3B1AE;
	Fri, 17 May 2024 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hRW/A4Ep"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA4A2D044
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715943643; cv=none; b=J3CXpxJzcoErH4ma0oAPo0Z7am3AvNbgJMPd4sU6TG/5vMph2lomgtxQvAf16WN0oxLVM/WS3X6zivvQNSAJdNvFpiEj8mPNd7aSyRCZuf+sepHRucRKn9XXTkl9BrQ7txnAbbK1D5YCTAi6RGdU9EuSvMEagDoQQqbACiQZmgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715943643; c=relaxed/simple;
	bh=7EEC64SS9Fi698JqjKcaoeII5qyUxMCkfT/0NkvGVLo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lPy3DYKn1LeEdqmWtiYECTD6SyLnAtiHyjCmCRMTkBhnLxbDG51z5b5830aruwcCLKRJPOt+BtY4f993z0oy7XuycU/Ge2T3beV6RVVTC7dvQsS7GmyVEHljq5m4QkdyfMPMbrqHtxRLYUsHI2PqshDpxGN7s+MoQlDoKoqLsx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hRW/A4Ep; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57342829409so6440504a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 04:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715943639; x=1716548439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qNOVue41hqxQ8m+b+AVJiBo42I4XisayKzHkj86Mjb4=;
        b=hRW/A4EpTrUVxsWDwHlK42rgkbJGk2/zYw01daM3mpr73RHrc96ZWc78tGywtJoRL8
         6ZVvDEKMk5Mk/r8qXhZwo6/HzYGRUTFTgk44Eacs/uSJT8ZkUHbfTcgyTzfVLx9d0CPu
         Z9LonyL0zipsv11/JVVZOgawsZ7uPhLzz/ZwlIBYH1M9sPyyXQeNl9MEkvgXxlSKONYy
         d5fTfDRHauFFjKJDaHzZi0PpQErhuBrRU0mhqgJsT7rg0i/SKRENKvUbNzCD71k34Ucc
         RGzq1tNt0TUMOE3fKaK9zuS7goXm5M8VCvaSK+jnuy9r3o7XwQBINQ7/R4aaEiQr8sWJ
         7dVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715943639; x=1716548439;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qNOVue41hqxQ8m+b+AVJiBo42I4XisayKzHkj86Mjb4=;
        b=gekmbMR8rbnY9Vqxtuetj6eht1MVnbfBuKbPElJMUSFTwHCuQKSXIOUgaQF7Vt35Ft
         5mP0WleW87L491N9kNj6+LBRnTU5nLbUfjTn09e8XEeEm7ID8HGQo3PGhtzCEEiGVKkN
         VssKzORn1rV3yec+uLMDitZKHnwcIQnrA/spAuS5Q3BUcb/syfSXrXeJ1/Zl4M/RQ5NP
         yCViit74jn7dNdBPYyDFrqdcCDJPscsUhi1gXadp/7Oine+ssCBeNuDssiKmsyk4+VGW
         y+fIualm0AJYgclh0oANhl1Tl+0xHpgOZjw+bculqUe1XRRgeO/In3dGQJIhLv81bvmb
         i7kg==
X-Gm-Message-State: AOJu0Yw2NMNWtlSdfZeRAj1Jb7NX/rX7Py3U0ZoAMkBleWTq5aPceFS4
	k7t+9AKjUk5RAHY1JxNrrWO9xQcWRnwdNaZx/jh2ATcONduOa6tArdOcW8PLMmHmkzXRI+6wSbp
	KkXBOvCgCKaBq2fv84ime71uf/zoDEbu+blds2Kvy1thGElHS0cMsunEP
X-Google-Smtp-Source: AGHT+IHIImsL921tTTC6eatZ7SLL8Yqy2JoDfWbe97SkkDBCfuoHgNHRicDxspmiNsu4E21WbigzJYVQ83mzmvaMVmg=
X-Received: by 2002:a50:ab19:0:b0:574:ec3d:262a with SMTP id
 4fb4d7f45d1cf-574ec3d28d3mr8234840a12.5.1715943639134; Fri, 17 May 2024
 04:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 17 May 2024 13:00:25 +0200
Message-ID: <CA+G9fYuyPFBVyqqg0RVhaz4c0S+H4TMm1apxgwyTUOkge9NY7A@mail.gmail.com>
Subject: clang: arch/x86/boot/printf.c:257:3: error: unannotated fall-through
 between switch labels [-Werror,-Wimplicit-fallthrough]
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	clang-built-linux <llvm@lists.linux.dev>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Borislav Petkov <bp@suse.de>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

The following x86 build failed on Linux next-20240517 tag due to following
warnings / errors only seen with clang builds.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build errors:
----
arch/x86/boot/printf.c:257:3: error: unannotated fall-through between
switch labels [-Werror,-Wimplicit-fallthrough]
  257 |                 case 'u':
      |                 ^
arch/x86/boot/printf.c:257:3: note: insert 'break;' to avoid fall-through
  257 |                 case 'u':
      |                 ^
      |                 break;
1 error generated.

The suspected patch,
x86/boot: Add a fallthrough annotation

metadata:
---
  git_describe: next-20240517
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: c75962170e49f24399141276ae119e6a879f36dc
  git_short_log: c75962170e49 ("Add linux-next specific files for 20240517")
  build_name: clang-18-lkftconfig


Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240517/testrun/23951572/suite/build/test/clang-18-lkftconfig/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240517/testrun/23951572/suite/build/test/clang-18-lkftconfig/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2gZwb1q4GHgVCuOfQIMCJ6tqMFn/


--
Linaro LKFT
https://lkft.linaro.org

