Return-Path: <linux-kernel+bounces-567903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 529BEA68BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0468A0164
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B526625523B;
	Wed, 19 Mar 2025 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BcRrRpWV"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3F6253F1B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383891; cv=none; b=bBHvzBWJ82VGbgrHwG++RYbdJBAmnW39n+QOPlazH2m/uL+rone/ZAwwFB1PDpSjE1uE0x8p9Hh7RsCYW/odR1ZzAQOSnhzjOybwR+hJ3G20B4jS85TOp7DjkCocnRLv6k41a8n9BRDpvlU/nv0aIFoyYuRBDKHXfAzfhpU01dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383891; c=relaxed/simple;
	bh=uHypwcrRHl+SgqVLmPSjnzt1sQS71BQ4kVSWgN/L4Bw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ae1B5/Hb6AgzCm+3J95pn73WD40jkuE8ILNdQJSh9H6liuDs7TMLuX3WOHZqM5S+bis8zH37VYDxqQz75aDlTaAI8reZxzGriy9rgHGW+Fo2a6PX7+bAh6oljWBIitv5aopkrXUvNnajRqpjN8nP/0k3ah8rbOrJfa+o0XK44xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BcRrRpWV; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5259327a93bso24311e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742383887; x=1742988687; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m+jLPHrj8ZPA3XVCoYQzPMElmxuzbulUtWiqu8pWMqw=;
        b=BcRrRpWVb7MZF3k/jM7ouDfaXOufcFIbdwq73Fpk+3RYA7/zUS8U11k7iJqR7lIEw/
         DmrkNfVno29assWrVc9OEGLqP0/XgAGHdCa5189zpSCVcQ0L1b7Vcl9ELG5mYNYVLLf7
         294PAR6GO29Hyw56iy+n0akVz6nsBRxCq9aDRTlCngSr7W3nYZLGG4Mf1F1sTmiZ0AN7
         I5HzvOZYzcLUr61o2NnTaj2KOEjdLurdsw2SzB/hYeb385Ol6CiJhtw20QS4SM+HtUqO
         c+F72XGDEuY752GsrHRz/mpGvIX5dJA2AXuQSjTrBWYdWNwRcvLhEQfpcZMxUdwave55
         JVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742383887; x=1742988687;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m+jLPHrj8ZPA3XVCoYQzPMElmxuzbulUtWiqu8pWMqw=;
        b=MoJCmlMn3ugOwqt3f3Cx4VwQuU3kZpRbe2zXteBAwCrEQ2ojnHzH8jSMAXTQd49da+
         KGfmfg8ggQ+Iy1GcQ+nbpCAruF0NnMoaC/lWGuVjTmsrI1GHLj1mitSyROl4FDM9Nx3S
         Sd9yEBnj+Bo6J/G+2mkMgWGWZNKJRFcp3hXi+2NDMry9Vy/GRBWWK5SHCEjTmzQglZJp
         jzBS31+EGOjYY1m+yePwmTQno0u5jSTqwVlj8X8zrrJP78bxzVF3cei7BhkUBmKYFfm2
         DkKBemFa1sxaR9pO9V6tl6Nw0HufHvyhNoJLgjfYUapYjuQQXSx5XfVHiDR1XGbvFwMz
         ZpYQ==
X-Gm-Message-State: AOJu0Yx/TUBXvCy5cvNscynUqrsZ/55zhl0TsG/Y/LlzItRfdihPFOu1
	zQitlvFIy7e9A4UMscTGtU3mvqBrEMgPd8XjlNXu8z0k9PNni7g9QyaB63+jRA3jmuCHYN/UnPW
	uNFA+6XddNxrjIzfFCq4agP9FK5vntUgxH7rASxSxYqjpuWgByHQ=
X-Gm-Gg: ASbGncvpnJm17q5vQKSd1KhdmmIVtzgtE7vFTOxJZFfae6A0xIA988Enp/4S12lj6tl
	PBfGqFCpv6hnxu7aYrj2W5oQpxurm26FxjuXnzcpMMzNWoP6jOMWKqgsOgTbQpcxiAtBIQKm9cy
	K5HzU97K5b3JJtLHxOsn89xXJgmi0HjNrnCEcuOIcPr6tEHFCj5Zt1pSQMnnrnIYLH4vohHQ==
X-Google-Smtp-Source: AGHT+IEafdpVOBAa5pTQIO6t8jfUeEW2i1TdUhI5BgPgwIlXHBkKShF7vYcOGmK23Sd3ddxvxbUeCyPxJMm1D573itI=
X-Received: by 2002:a05:6122:309f:b0:516:230b:eec with SMTP id
 71dfb90a1353d-5258912107amr1143140e0c.5.1742383887486; Wed, 19 Mar 2025
 04:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 19 Mar 2025 17:01:16 +0530
X-Gm-Features: AQ5f1Jom0KVj0bHEN5s3vaEzIeI9v3O6c6_HQfHuayaz3HGWB-1p8XHKc-Q7AtI
Message-ID: <CA+G9fYs62qxt1PajEp2A8uUmQFeAsC2JBV2wuspbAxz_hFF7CA@mail.gmail.com>
Subject: next-20250319: arm shmobile_defconfig trace.c undefined type 'struct module'
To: open list <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Regressions on arm the shmobile_defconfig builds failed with clang-20 and gcc-13

First seen on the next-20250312
 Good: next-20250311
 Bad:  next-20250312 .. next-20250319

Regressions found on arm:
 - gcc-13-shmobile_defconfig
 - gcc-8-shmobile_defconfig
 - clang-20-shmobile_defconfig

Regression Analysis:
 - New regression? Yes
 - Reproducible? Yes

Build regression: arm shmobile_defconfig trace.c undefined type 'struct module'
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
kernel/trace/trace.c: In function 'save_mod':
kernel/trace/trace.c:6036:45: error: invalid use of undefined type
'struct module'
 6036 |         entry->mod_addr = (unsigned long)mod->mem[MOD_TEXT].base;
      |                                             ^~
kernel/trace/trace.c:6036:51: error: 'MOD_TEXT' undeclared (first use
in this function)
 6036 |         entry->mod_addr = (unsigned long)mod->mem[MOD_TEXT].base;
      |                                                   ^~~~~~~~

## Source
* Kernel version: 6.14.0-rc7
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: ff7f9b199e3f4cc7d61df5a9a26a7cbb5c1492e6
* Git describe: next-20250319
* Project details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319/testrun/27672563/suite/build/test/gcc-13-shmobile_defconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319/testrun/27672563/suite/build/test/gcc-13-shmobile_defconfig/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319/testrun/27672563/suite/build/test/gcc-13-shmobile_defconfig
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2uX2E69ngTqvrymzOdYQz0JQ16z/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2uX2E69ngTqvrymzOdYQz0JQ16z/config

## Steps to reproduce
 - tuxmake --runtime podman --target-arch arm --toolchain gcc-13
--kconfig shmobile_defconfig


--
Linaro LKFT
https://lkft.linaro.org

