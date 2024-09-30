Return-Path: <linux-kernel+bounces-344294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EAD98A7E4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6EAB1C23775
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90A31922D7;
	Mon, 30 Sep 2024 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7FizeEN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9911917F2
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727708072; cv=none; b=OvQ+TngqFzzRBNtB5/eJGdzdXR8oM5jjRfTgpaChwCE226upYc2GXCNTK2BVQx96WZOyaN2v+ysFPC0zBpbXr/rDNj69rb7g3qlPorU4aqVsOuwxjaK+72kc5PsYPi+VMfgeDiHhgxp7lB9CcU3gGN855RceKfXzSVC7gWPzUvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727708072; c=relaxed/simple;
	bh=/JWk2c3RJLiKkNr4uJaQal5/fmki64lMPPToa0iog7E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=R2UoY3bAGOXLEEjH/NlWOW6bPKEfyJf551I8zQ5X/Hg7tsUuvlwuaam1e4exhj8XH8/WEAnC5Xr0bKw2byR7Ogmqt73KgAo4m+69ItydSGZ+mVZH+CMnQJi9IIuQvniu4OuBqgpHtt3sZETfM8GSg1AaSzU43N20Wjnl/DEL5TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7FizeEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3935C4CECF
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727708071;
	bh=/JWk2c3RJLiKkNr4uJaQal5/fmki64lMPPToa0iog7E=;
	h=From:Date:Subject:To:Cc:From;
	b=b7FizeENg77MKbom+2zTJGU4IpbLDyRzueqz1pgn11Erca+an93XR6UMqbg2hXPlZ
	 j0esz+ZmB/8TGmA5iy2uWPppf6EooooreE9qFvYxdz8zBu9PJPEhtcDrklPRD0yizi
	 1K55z5c38G5J+v5DHSSeQ02nMehByrHdTh79CLJFLOgvioQthmDjuj9dPkHvHQkqHr
	 WhlXzvfSjmBWC5GNYgCApK6AjkqmXS/WtY2ItGap7lcxk3bxIYQgwX/M1JYdcUsGDZ
	 /9GgOnVUrt2BZtw4RPS3EuckC31dSuKYFIZfFfZEWgBYP0KihLD2aeFibHwTi2Ho0Z
	 koTKf/908iLww==
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cb37b34a87so31948246d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:54:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwHt18VQmUgy6dOW1y1HSVGEEk27gMW4JZ0+fEkBpR/9MC8OXtjBuZ9mXs8t6ABhLZ0V9puW2wkhR2b1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWAuxLFc9BOxnqBOdLL8M3C20wq0nh7PtU93xcXK+nHrSmd1+8
	XF6SP406iTLMju3+y30J2MwGDZV2iLabF419vncOmL+/nCP3Oz5Wo1NQDut+EXwAieC5t10idOl
	VE//g8/4qcILSIzuTdaNUYdC1t1E=
X-Google-Smtp-Source: AGHT+IH/4DZQp0uzTsMI40zAn+1n2UViUSzRuwG37vCHfnoR2MSpWkb0k5JZSIt5ebWGcwB4s3FMVmIQSsDEap60QEA=
X-Received: by 2002:a05:6214:4519:b0:6cb:5f8a:4fda with SMTP id
 6a1803df08f44-6cb5f8a54e0mr66594666d6.6.1727708070837; Mon, 30 Sep 2024
 07:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Mon, 30 Sep 2024 16:54:19 +0200
X-Gmail-Original-Message-ID: <CAJ+HfNjwqMhAFUvKRsWEAD1BZNC19ouYmJ9XMNP2HrcyKo6Ltg@mail.gmail.com>
Message-ID: <CAJ+HfNjwqMhAFUvKRsWEAD1BZNC19ouYmJ9XMNP2HrcyKo6Ltg@mail.gmail.com>
Subject: Github RISC-V CI (BoF follow-up)
To: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-riscv <linux-riscv@lists.infradead.org>
Cc: Charlie Jenkins <charlie@rivosinc.com>, Conor Dooley <conor@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Drew Fustini <dfustini@tenstorrent.com>, Arnd Bergmann <arnd@arndb.de>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Following up on the discussion around CI that came up during Plumbers
RISC-V BoF.

TL;DR: There's a CI running builds/and tests for RISC-V. Check out [4],
if you're a nice person, try to fix what's broken.

Long version: As most of you know there are a number of Linux kernel
CIs out there, that build/test some areas of RISC-V. kernelci does
some, and Linaro LKFT some.

Yet another CI runs in parallel to the RISC-V Patchwork CI on Github,
running on the RISE sponsored runners [1].

A major piece missing is a summary/dashboard page. That's still in the
planning phase. I'll be looking into what the kernel CI folks are
offering in that space (KCIDB).

The CI pulls in a couple of branches, e.g. Linus' master, Palmer's
staging branches, and more. All branches are listed via the PRs here
[4].

There are two workflows ci-series (build and boot), and for bpf,
bpf-next, and Linus' master ci-kselftest is running as an experiment.
I'll be adding kselftest to the other branches, and a couple of other
suites once we get more build machines, and the tests are somewhat
more stable. ;-)

All the builds are cross compiled, and the tests are performed on
qemu. It's all run in a Docker container [3], that can be pulled with:

  $ docker pull ghcr.io/linux-riscv/pw-builder:latest

The Github CI scripts (again, shared with Patchwork) reside here [2].

Each time a tree moves, a new build is performed. Sometimes, the tree
moves before the job is done. In that case it's cancelled, and re-run
on the new head.

Build/boot: A 6.12-rc1 run is here [6]. The log artifacts are at the bottom=
.
Click "build-series", and expand "Run checks" for more details (or
checkout the logs).

Kselftest: A 6.12-rc1 run is here [5]. The kernel configuration is
defconfig+kselftest-merge (plus some additional bandaid patches that
haven't made it to mainline [7]. The test suites include everything
that's explicitly in TARGETS (top kselftest Makefile), and that has
cross compile support (e.g. NOT sched_ext yet ;-)).

Download the logs from [5], and then:

  $ egrep -a '^TEST|^not|Kernel panic' *__kselftest{,-bpf,-net,-ftrace}.log

to view the failed tests. On 6.12-rc1 the ftrace suite panics! :-P

It's far from perfect, and we're still not running enough (AFAIK) tests on
real HW, but it's something that's available now. Patches are *welcome*
X-D.


Bj=C3=B6rn

[1] https://github.com/linux-riscv/linux-riscv
[2] https://github.com/linux-riscv/github-ci/
[3] https://github.com/linux-riscv/docker
[4] https://github.com/linux-riscv/linux-riscv/pulls?q=3Dis%3Apr+is%3Aopen+=
test%5D
[5] https://github.com/linux-riscv/linux-riscv/actions/runs/11096387863
[6] https://github.com/linux-riscv/linux-riscv/actions/runs/11096387858
[7] https://github.com/linux-riscv/github-ci/tree/main/.github/scripts/seri=
es/patches

