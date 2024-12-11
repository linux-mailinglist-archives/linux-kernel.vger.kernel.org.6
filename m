Return-Path: <linux-kernel+bounces-440799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 952979EC462
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 06:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90308284D24
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 05:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DA41C1F0F;
	Wed, 11 Dec 2024 05:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sVTt5JUS"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EA74A0A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733895601; cv=none; b=c1K1L2jHHgGthc3v80RM1Vbo5sFbbtMVBsmM8sQdA5WMVFeuq1VqzpghfGWOsxG6Gf6w/LufqwOTOTi8tmI4KPo5uX3ie0aIIws/8Y+KD385/HNKIN8JnQuFaUNoauq29qZeoAGIXeCsOi2jFmLhRPV7DnpWDWoW6YHu3Ino7Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733895601; c=relaxed/simple;
	bh=cmLSSNnhREF3JwUwweEtDJM+TE6MLim68CUGz24LJFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdG+9xuzVEnVpaGKHZkjFAyuSf9sqLwX/xJSEYnfa61B/S6Y2egC3TC+NMUE2Z7ofbDlZypYDeNB4dy3xQQEI2Cs0FNEGejWFT/srCPYkqGprMSjl3adUY0t6Zi4Ep3oWzgsk3jrHRU/+r8m7pB9rMIZnaPaEFt9JbfTxKZaDNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sVTt5JUS; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5189a440a65so627408e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733895598; x=1734500398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L2JyqkiU/6R1xmttvdUUGuANembyWIMM8crCm1+D1nE=;
        b=sVTt5JUS7UmvwiFC+vzXGMYQs/Ss/UF7U1VOEL248r35uiYLK4rxkGqoH258wNu2HH
         GpbhfdsL+PfsJyF8zRYnbKnAvNZV6tc0Ol/h6pTyhj83RzIHSdVq1/XifVI9ORmROGbV
         B46yvpZb78iWI0SNPObVbEJRt0in7Hl83QqUo84eDHe+nmDFSqVTuVcGXcelNy17/xQg
         yZelDkUZl4fHw6LBAlkYYIEAfdNRuI5Zssjt5au00IU6jecCOUfcmeAmIAq/p+KHdnYF
         GrWrxt+dLiutUpRsrgeBZ9g7dD8G2NF/0/YM8shlCQhK3bRlMpUxicIk4rfhkxdJ2GRw
         MVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733895598; x=1734500398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2JyqkiU/6R1xmttvdUUGuANembyWIMM8crCm1+D1nE=;
        b=bdS2i/MvrUoGgdrjaA7vVGK+vsjmYsSReDVmYqRN6bwkvBldmJ3rGnSYT1Z+lkt4LV
         ythBqkH0syYTRIm01PR8adBHBJGexpZpGWLggXJSz0UTNcx6K0wwcQ8rihXeN2k6M7hq
         6wxb1dvRT4fbiUpv6QHYxCCaP+u9ZEv+ydYC022uDXIlTy4hhNBD73vCSI05lJt9FzUa
         euovNbysjfh2mx3udMnbOk4qaMHIUg25ucWFCif6h5N5S1MPhJpIgqTI5o4Jly9A7v8A
         IYFIbiw3Rx1joVB9ZhfS5VVy3hGxxTtJeCfigt3O5B/KSu9r7O0BtdZN2CcPf/bKBW46
         k6Ew==
X-Gm-Message-State: AOJu0YwLzFx5ysp2q7DCfRHeeVxfwUmKoO6eQzYZvWpdkblv8qoHyomk
	vem6a3QGdG/oFA8qkfMAC5SSrzgYsraZl5svPgs0z1XOqWbdxDndZrtHatX2AAp8i0dFc+oeooY
	NlqNHUqOX5nyCG7fB8KwUZYmyxEu313LsCWfRxbf2rA8TozPu2R0=
X-Gm-Gg: ASbGncsVU79Du0JLYKqGO7AgqaLkFPlM9sicHW9j2eVFQHhoRSOe7GRZbH/56GiXgmE
	dGIbBj641wYhsBxBFs1cwPzhb90Lu806TEw==
X-Google-Smtp-Source: AGHT+IGaVQqa3Q+BI6ngTSIj2GVkueSl4Jrs/cm3+CtAoLXynlarl8woucxcn3CryRSjN8OBkzE56/rteEslmfJ/Svc=
X-Received: by 2002:a05:6122:8292:b0:515:e4c4:3664 with SMTP id
 71dfb90a1353d-518a3cc3352mr1602173e0c.9.1733895597732; Tue, 10 Dec 2024
 21:39:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvcBvbabg+m7brKfpGCGZUcK+KHHTFX7hFvW6GmN2XF0g@mail.gmail.com>
In-Reply-To: <CA+G9fYvcBvbabg+m7brKfpGCGZUcK+KHHTFX7hFvW6GmN2XF0g@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 11 Dec 2024 11:09:46 +0530
Message-ID: <CA+G9fYuHGTKM5P+nEifZwfALPfO9uw7sraCrGo-c3YzR=JjwJg@mail.gmail.com>
Subject: Re: selftests: core: unshare_test: WARNING: at mm/util.c:671 __kvmalloc_node_noprof
To: open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, LTP List <ltp@lists.linux.it>
Cc: Shuah Khan <shuah@kernel.org>, David Gow <davidgow@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Barry Song <baohua@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

[Gentle Reminder]

On Mon, 26 Aug 2024 at 18:50, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The following kernel warning is noticed on all arch and all devices while
> running selftests: core: unshare_test on Linux next-20240823 and next-20240826.
>
> First seen on next-20240823.
>   Good: next-20240822
>   BAD:  next-20240823 and next-20240826

This is an open issue from August.
The reported kernel warning is still seen on linux next and mainline
while running selftests: core: unshare_test.

Linux version: 6.13.0-rc2-next-20241210

>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Crash log:
> --------
> # selftests: core: unshare_test
> <4>[   61.084149] ------------[ cut here ]------------
> <4>[ 61.085175] WARNING: CPU: 0 PID: 477 at mm/util.c:671
> __kvmalloc_node_noprof (mm/util.c:671 (discriminator 1))
> <4>[   61.088958] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
> sha512_ce sha512_arm64 drm fuse backlight dm_mod ip_tables x_tables
> <4>[   61.093141] CPU: 0 UID: 0 PID: 477 Comm: unshare_test Not
> tainted 6.11.0-rc5-next-20240826 #1
> <4>[   61.094558] Hardware name: linux,dummy-virt (DT)
> <4>[   61.096763] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT
> -SSBS BTYPE=--)
> <4>[ 61.097841] pc : __kvmalloc_node_noprof (mm/util.c:671 (discriminator 1))
> <4>[ 61.099701] lr : __kvmalloc_node_noprof (mm/util.c:661)
> <4>[   61.100448] sp : ffff800080abbce0
> <4>[   61.100819] x29: ffff800080abbcf0 x28: fff0000004549280 x27:
> 0000000000000000
> <4>[   61.101744] x26: 0000000000000000 x25: 0000000000000000 x24:
> fff0000003615e40
> <4>[   61.102512] x23: fff0000003615ec0 x22: bfafa45863b285c8 x21:
> 0000000200002000
> <4>[   61.103232] x20: 00000000ffffffff x19: 0000000000400cc0 x18:
> 0000000000000000
> <4>[   61.104053] x17: 0000000000000000 x16: 0000000000000000 x15:
> 0000000000000000
> <4>[   61.104927] x14: 0000000000000000 x13: 0000000000000000 x12:
> 0000000000000000
> <4>[   61.105752] x11: 0000000000000000 x10: 0000000000000000 x9 :
> 0000000000000000
> <4>[   61.106606] x8 : 0000000000000001 x7 : 0000000000000001 x6 :
> 0000000000000005
> <4>[   61.107377] x5 : 0000000000000000 x4 : fff0000004549280 x3 :
> 0000000000000000
> <4>[   61.108207] x2 : 0000000000000000 x1 : 000000007fffffff x0 :
> 0000000000000000
> <4>[   61.109262] Call trace:
> <4>[ 61.109619] __kvmalloc_node_noprof (mm/util.c:671 (discriminator 1))
> <4>[ 61.110248] alloc_fdtable (fs/file.c:133)
> <4>[ 61.110751] expand_files
> (include/linux/atomic/atomic-arch-fallback.h:457
> include/linux/atomic/atomic-instrumented.h:33 fs/file.c:177
> fs/file.c:238)
> <4>[ 61.111171] ksys_dup3 (fs/file.c:1337)
> <4>[ 61.111596] __arm64_sys_dup3 (fs/file.c:1355)
> <4>[ 61.112006] invoke_syscall (arch/arm64/include/asm/current.h:19
> arch/arm64/kernel/syscall.c:54)
> <4>[ 61.112480] el0_svc_common.constprop.0
> (include/linux/thread_info.h:127 (discriminator 2)
> arch/arm64/kernel/syscall.c:140 (discriminator 2))
> <4>[ 61.112955] do_el0_svc (arch/arm64/kernel/syscall.c:152)
> <4>[ 61.113384] el0_svc (arch/arm64/include/asm/irqflags.h:55
> arch/arm64/include/asm/irqflags.h:76
> arch/arm64/kernel/entry-common.c:165
> arch/arm64/kernel/entry-common.c:178
> arch/arm64/kernel/entry-common.c:713)
> <4>[ 61.113742] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:731)
> <4>[ 61.115181] el0t_64_sync (arch/arm64/kernel/entry.S:598)
> <4>[   61.115709] ---[ end trace 0000000000000000 ]---
>
>
> Crash Log links,
> --------
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240826/testrun/24953436/suite/log-parser-test/test/check-kernel-exception-warning-cpu-pid-at-mmutilc-__kvmalloc_node_noprof/log
>
> Crash failed comparison:
> ----------
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240826/testrun/24953436/suite/log-parser-test/test/check-kernel-exception-warning-cpu-pid-at-mmutilc-__kvmalloc_node_noprof/history/
>
> metadata:
> ----
>   git describe: next-20240823 and next-20240826
>   git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git sha: c79c85875f1af04040fe4492ed94ce37ad729c4d
>
> Please let me know if you need more information.
>

Kernel warning log:
-----------------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241210/testrun/26261199/suite/kselftest-core/test/core_unshare_test/log

> --
> Linaro LKFT
> https://lkft.linaro.org

