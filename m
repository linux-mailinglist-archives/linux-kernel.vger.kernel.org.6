Return-Path: <linux-kernel+bounces-219081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E84990C9AB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6811F2197C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C5716DC36;
	Tue, 18 Jun 2024 10:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r2pj5gGx"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DA316EB44
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707192; cv=none; b=j02lOHxyqbAOB1POi6zhVbO8466anYesdUQqaMwVtI0OGkri5M17ofKnA0BYJM4W1dppyH3TiZa7uNKb6Sx6l1QVPZ1tl3NEbNBnjRVGpnABAbplbon3vSgyxDpPBtmwW0V8SiSViYACqqtaZXJ3nlx7R5tZikn+i1ZrL7L6wzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707192; c=relaxed/simple;
	bh=lPQaPdityDLfZbHzeDC8ojdjE2XvWy7QdXEXphUNQpc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ja33nlbEdXWV45msDCKKUkXhKooNfly+EGiAYxpH1yGPUz1TypFbbvyr0rHSreATQN8RQDZxaN1mePgs8Nz9XcxOJKQnHZgGLDrmIDULMaDQzQfxaWqCGjQWT8Ij00nF1LHtFoETmsWa+9cIOCw2rAhNEFj4QtVUexHXUPOgOXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r2pj5gGx; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-48c4f2ff8c2so1431916137.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718707190; x=1719311990; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QEljk6ggn8rJlURGstQGLdKQqP2HSFqBtnN4P7FNF6w=;
        b=r2pj5gGx+3sqGJ7cpRvOJdybxTMqRpghFxRBqd47Rjzh6vVbslyXcV0WklQbMrH4iq
         RZDrZYdGwH/PBXN+mKrLm0/u9+HzlqZ2NL7S69T5nhZKFfa3S0hdRZ/WnaA2ycHg9p7f
         m5i/FDccsSkoDK8banJ+Y3oyThH9BrmxiP13PJ5ydjle+IXVH/VjSwAlJBBbGCP1RRWL
         bvrTlkLNOsu9+qHWdruaRccrJGDmUdAQgQFeGdc765m2qrzGBDHavsX3NX4Npu/FrlPu
         9Gqz1SSYk2u7UTqLZNO1R+13qRMrnh96EvTRs17/9R4gclknrVx3Mcln5EVpyl3plJFG
         nzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718707190; x=1719311990;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QEljk6ggn8rJlURGstQGLdKQqP2HSFqBtnN4P7FNF6w=;
        b=t7bgVRuf6X5vAI6f0xhGtxyzhfNppWAdrAkMzjjNkmhC9FwoCtcQ6Qc84H95tzc5pc
         lLkHfjpOxY/QHLvfiCpaqxDCb478VV24rm0cpjKlvYQuzcYIYQv+7fAGQ7eBloHGwTJ/
         FbX117a6y8fK57HN6ZnnigekD1qgLLBz1jCA0BpZ3g054jeVHXFk0CB2/U3FnGiqNTIp
         ALihTublfIMLAnMn0fep7B2uE6dCqOce2MXebfZF/avN9rE86pUrTOFu28bOqC90p3sM
         QF+dXL/VVM3JJrhs1i99Wj74MsQ1xzVyBCWH4XoFS/7TyKs9/BUgrOM/0qiNMgtzX1/x
         z3zA==
X-Gm-Message-State: AOJu0YxqVekcxlFSgexsDWX1rdlWRkabXPnZ3i5JIUcGf265RC/DutjZ
	mmNiPT3jHzMkGCde3cvZx1RHGxsJ+X/rp2Wmwj9guEs6uKaxau9kSSXoTo/JUHkjM22rOJ9QpvY
	zd119GWjHnt0mjQrPpdHNCbmOwy1ax8gKutk7YRHWp2FRr7h0vGbe4A==
X-Google-Smtp-Source: AGHT+IGlfvQiDWgG3QUajDlpAVMqRKc0CBGEed89cfHiSCFaLDQXr5lx8fTA31fnYSylIf9pn2jzMiwAhKa5hARvZYA=
X-Received: by 2002:a67:f88e:0:b0:48d:920a:bd41 with SMTP id
 ada2fe7eead31-48dae38578dmr10393370137.16.1718707189697; Tue, 18 Jun 2024
 03:39:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 18 Jun 2024 16:09:38 +0530
Message-ID: <CA+G9fYvULzMHHQo3OKkcFYU+Tiw1fFU6LKbt3zHfX-E-ozcsdA@mail.gmail.com>
Subject: mm/slub.c:1163:17: error: implicit declaration of function
 '__memset'; did you mean '__memset64'? [-Werror=implicit-function-declaration]
To: open list <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

The Following build failures have been noticed on Powerpc, mips and arc on the
Linux next-20240617 tag.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on mips:
  - gcc-12-bcm47xx_defconfig
  - gcc-12-cavium_octeon_defconfig
  - gcc-8-malta_defconfig
  - gcc-12-malta_defconfig
  - gcc-12-allnoconfig
  - gcc-8-bcm47xx_defconfig
  - gcc-8-allnoconfig
  - gcc-8-cavium_octeon_defconfig
  - clang-18-allnoconfig
  - clang-nightly-allnoconfig


Regressions found on arc:
  - gcc-9-allnoconfig
  - gcc-9-defconfig

Regressions found on powerpc:
  - clang-18-maple_defconfig
  - gcc-13-ppc6xx_defconfig
  - clang-18-allnoconfig
  - clang-18-defconfig
  - clang-18-ppc64e_defconfig
  - gcc-13-defconfig

Build log:
--------
mm/slub.c: In function 'init_object':
mm/slub.c:1163:17: error: implicit declaration of function '__memset';
did you mean '__memset64'? [-Werror=implicit-function-declaration]
 1163 |                 __memset(p - s->red_left_pad, val, s->red_left_pad);
      |                 ^~~~~~~~
      |                 __memset64

The commit id:
  ad5dde7da5f9 kmsan: support SLAB_POISON

metadata:
  git_describe: next-20240617
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 76db4c64526c5e8ba0f56ad3d890dce8f9b00bbc

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/  -
next-20240617/testrun/24380474/suite/  -
test/gcc-13-ppc64e_defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/  -
next-20240617/testrun/24380474/suite/  -
test/gcc-13-ppc64e_defconfig/details/


--
Linaro LKFT
https://lkft.linaro.org

