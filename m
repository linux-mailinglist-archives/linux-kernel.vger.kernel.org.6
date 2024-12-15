Return-Path: <linux-kernel+bounces-446556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D649F2617
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 21:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4071F188536D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 20:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906B91B85C9;
	Sun, 15 Dec 2024 20:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbOV9EL5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9F81FDD
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734295797; cv=none; b=e/MLuSEylYNXMvvXlQTzgrjSIC3VpMcDT08pH29zTqsEYAP50zvypT4n4eIdSeFj2n2vqTvSnFR3ppSXzFqBvIIEHYT3UBGVAnv/+Wys3wpzP7DawuT0PmkqjTerU7aCAm2UViGKwrd9oPkSC6obsrzrmPBUn5xlOQVbZMHJsME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734295797; c=relaxed/simple;
	bh=cPKzzqKkHLMu415YDondciNGZujnY7eo/7uNqZFN2Og=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=o4KHihnHtr/P09eE8aLQIItir+gRJLepPuFFcLjxRJ+R4HvTCoh62lsnA6hgJdMTW0YbJ2W0LHG4QyTgijEhTPFCgHEQFK5wyWXTZxT1UwfkH7qhs7ZKmDuccGNEWrDC8Mfe6p/VTBxhj/3E3o37q8mtfrmci/LylTZgt/pdHJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbOV9EL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63163C4CECE;
	Sun, 15 Dec 2024 20:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734295796;
	bh=cPKzzqKkHLMu415YDondciNGZujnY7eo/7uNqZFN2Og=;
	h=Date:From:To:Cc:Subject:From;
	b=cbOV9EL5jLa3n5F3LUQJZnYvdCQSmsfzn95xNy6BNjZNdZXvGetfVl2ynCDdhpcc1
	 PLE7laxf1z/V62x8Fhita/SW9s9DdWhfa+d+RTXixMWfuhuI27lh6mGhqY2efYf3AQ
	 zv0Gfe2ohqvHDREVuXGC1QMkYZiKIbILT/4POarVYO8bFAcx8PV6bflRKzVKaNLXCI
	 7cyixIJf3FK+kyhuf79oydNht3asvOMk03EbTBsufnE+YfUhoNP4ree1f95MkzwDeu
	 fdQqzubPzTo0OuVeXoLFmwFoLsq+GFAyS9jj/a7JHEUPG6Q4FJzGtu+GsWBZ51h4yf
	 MdwBYuyMTuvPQ==
Message-ID: <c7e0d492-c7a2-4266-904c-9b247a41fa20@kernel.org>
Date: Sun, 15 Dec 2024 12:49:55 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vineet Gupta <vgupta@kernel.org>
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
 arcml <linux-snps-arc@lists.infradead.org>,
 =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>,
 Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
 Leon Romanovsky <leon@kernel.org>, lukas Bulwahn <lukas.bulwahn@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Subject: [GIT PULL] ARC fixes for 6.13
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

A little pile of long pending fixes for ARC.
Please pull ! Happy Holidays.

Thx,
-Vineet
--------------------->
The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-6.13-fixes

for you to fetch changes up to 824927e88456331c7a999fdf5d9d27923b619590:

  ARC: build: Try to guess GCC variant of cross compiler (2024-12-13 14:39:24 -0800)

----------------------------------------------------------------
ARC fixes for 6.13-r32 or rc4

 - Sundry build and miscll fixes

----------------------------------------------------------------
Benjamin Szőke (1):
      arc: rename aux.h to arc_aux.h

Hardevsinh Palaniya (1):
      ARC: bpf: Correct conditional check in 'check_jmp_32'

Leon Romanovsky (1):
      ARC: build: Try to guess GCC variant of cross compiler

Lukas Bulwahn (1):
      ARC: fix reference of dependency for PAE40 config

Paul E. McKenney (1):
      ARC: build: Use __force to suppress per-CPU cmpxchg warnings

Uwe Kleine-König (1):
      ARC: dts: Replace deprecated snps,nr-gpios property for
snps,dw-apb-gpio-port devices

Vineet Gupta (1):
      ARC: build: disallow invalid PAE40 + 4K page config

 arch/arc/Kconfig                     |  4 ++--
 arch/arc/Makefile                    |  2 +-
 arch/arc/boot/dts/axc001.dtsi        |  2 +-
 arch/arc/boot/dts/axc003.dtsi        |  2 +-
 arch/arc/boot/dts/axc003_idu.dtsi    |  2 +-
 arch/arc/boot/dts/axs10x_mb.dtsi     | 12 ++++++------
 arch/arc/boot/dts/hsdk.dts           |  2 +-
 arch/arc/include/asm/arcregs.h       |  2 +-
 arch/arc/include/asm/cmpxchg.h       |  2 +-
 arch/arc/include/asm/mmu-arcv2.h     |  2 +-
 arch/arc/net/bpf_jit_arcv2.c         |  2 +-
 include/soc/arc/{aux.h => arc_aux.h} |  0
 include/soc/arc/mcip.h               |  2 +-
 include/soc/arc/timers.h             |  2 +-
 14 files changed, 19 insertions(+), 19 deletions(-)
 rename include/soc/arc/{aux.h => arc_aux.h} (100%)

