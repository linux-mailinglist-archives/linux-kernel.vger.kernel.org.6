Return-Path: <linux-kernel+bounces-179981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4DF8C686B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60241C20FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8941313F445;
	Wed, 15 May 2024 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wY3kWIk+"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A26A13F439
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715782752; cv=none; b=TixQLqB5wXcdSKzxO+5DJhgkRwwNvMhJ55M4C0hDpdmk3H6ZyW346koNKpi5GxkWTZcXlFnepaZlqR9KQBd1icpbbx22dlCPnfoL7T16m+c4FrlxkiBP/2VD0hr1ETVYuQKvMpg0qtpdvC0k23QgViWuxoPObf24FjtJ100hK3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715782752; c=relaxed/simple;
	bh=iy7dLAEaL4vVGSeorVmj9DuvDO3ifOspxvrna6sksIs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=M/3i0Zx1oIx+TWJF/lrhbrSHkka9u8utXeEl4ihIstf4lEP3RV64Y8LGaNMWQnMksM2JNd2yAXKUji1Kwex1BmbuwbsdIFs6C+r3k9rGrrc787EaohhIJ6QWGEyf8yBv1iSl+sn3zuapuwbNbC7cRYKeY9IGc7K2NF4/NgjWJbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wY3kWIk+; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f0e7af802eso3120969a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715782750; x=1716387550; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a9+nEjIRGhMjrhSd4waxnxR1U1OPOKlFj61G/GYKSuU=;
        b=wY3kWIk+yY5BF8JTjsJrRWMrLO75oAJtuQQcZGR7pkg7nw1WKyjF7pekoLidw6B4BP
         KbH51L0UU0BbgfD9SCNbkDqCG8K/mJ+Te0KIRP/zzHKW7QED9PLm89XbapSX31RETnbV
         P5uIVCRzcmLiIQkl3HOX6wYGZAjX5BSBbh6ER0BxY4W/BMPXK97SuogXX9ic0QTz/ehN
         f9JORBrec9A3cysfUQWgtyY/VoJYOWgUJbteJ63UEi7jzmTF1b1tAtxstwGYReuQwnD/
         o3OPb3qVCre2ABM8j2FFA0VJZUtHPaI6kHmUvx6bTOm/tkJruUKrqjosO+x+ibF7ncth
         sOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715782750; x=1716387550;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a9+nEjIRGhMjrhSd4waxnxR1U1OPOKlFj61G/GYKSuU=;
        b=MFFeW6adzwDbljt7Mz6nGJClMnIwZuchKkargIwL7vGJB5Q+vO/y8M1LKEB08Yv/Cx
         MUYUWtkDdBmNeBfYxRWgEF108BzsF1Qj3WOP3rgLWVC/LixwN9EZTnY4nHYjYy/q1S/Z
         qmr2685AhA/9j2Uuuf0q0T7jX4WUEhDOfCMcrUEt0CDcA+D/Ovtomz0y3XhHuYgRjEAP
         ylVJxzVYxRNmZKRO8m2zxY0CgomjpnmVVFdsMn3LcLHHHy0u7Ywt93LBsOZ9w1TmA5kG
         64gyPwA1LQdYrMcXfXvOgVPdn3T8gUPrepkORgF0PuDcaLPQHbzkKU2QUSH3t5VBVwpi
         Lfsg==
X-Gm-Message-State: AOJu0YyQg9+LH6gh2qEGPpm3wxjG4dE+ecZbYSokBfE445EI6t+7g5EH
	monlaGSO/z9h9RwcpnseBn+pD2mEpXgAdEdWYMxPgMYNM5Eywn1rk+F/mDt62Un1upAppCVjqZV
	HUC6fPvEcJrioh099aMF3JRXQgLPItIMUIkqQ1WGwF/sHuMdn2k5O0kC1
X-Google-Smtp-Source: AGHT+IH/7/dqPY9r1lhR5haX5AIQ/98Ll9YuM9T0D4wFA2HFYmBB4m8nfB/jKUjlQdttEXRU3o5RpwBPOQ1s/m/TNvM=
X-Received: by 2002:a05:6808:2d9:b0:3c8:65ee:6795 with SMTP id
 5614622812f47-3c99704cfbdmr14936618b6e.22.1715782749719; Wed, 15 May 2024
 07:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 15 May 2024 16:18:58 +0200
Message-ID: <CA+G9fYtDtgb8zNGfDQPS2u_n_45rDiDgJR6ud3uuxkJBR0rUzA@mail.gmail.com>
Subject: riscv: irq-riscv-imsic-early.c:52:9: error: too many arguments to
 function 'riscv_ipi_set_virq_range'
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, linux-riscv <linux-riscv@lists.infradead.org>
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

The riscv builds failed on Linux next-20240515 tag due to following build
warnings / errors with gcc-13 and clang toolchain.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build Log:
-----
drivers/irqchip/irq-riscv-imsic-early.c: In function 'imsic_ipi_domain_init':
drivers/irqchip/irq-riscv-imsic-early.c:52:9: error: too many
arguments to function 'riscv_ipi_set_virq_range'
   52 |         riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI, true);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/smp.h:119,
                 from include/linux/lockdep.h:14,
                 from include/linux/spinlock.h:63,
                 from include/linux/sched.h:2142,
                 from include/linux/ratelimit.h:6,
                 from include/linux/dev_printk.h:16,
                 from include/linux/device.h:15,
                 from include/linux/node.h:18,
                 from include/linux/cpu.h:17,
                 from drivers/irqchip/irq-riscv-imsic-early.c:8:
arch/riscv/include/asm/smp.h:52:6: note: declared here
   52 | void riscv_ipi_set_virq_range(int virq, int nr);
      |      ^~~~~~~~~~~~~~~~~~~~~~~~

metadata:
  git_describe: next-20240515
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 82d92a9a1b9ea0ea52aff27cddd05009b4edad49
  git_short_log: 82d92a9a1b9e ("Add linux-next specific files for 20240515")

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240515/testrun/23894295/suite/build/test/gcc-13-lkftconfig/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2gUiKdxX7qM27ritMJT5pRyZhyi/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240515/testrun/23894295/suite/build/test/gcc-13-lkftconfig/history/

--
Linaro LKFT
https://lkft.linaro.org

