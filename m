Return-Path: <linux-kernel+bounces-574485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 027E7A6E5F0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F5118919C6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943C01EA7E7;
	Mon, 24 Mar 2025 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZP+HBebW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D9B2E3374
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853382; cv=none; b=rdQ4xUhtYlIhXWdKiR/aabp2Q3xortqdwCL6JnQbxQbqhmXkejWlGbwGDAvkJImClo/ZjBLSDWMiqRCPmHS73Z2Qz2v2MQE69eek6T9DSk54vwK/VQsQKiOJTpO2hnfnMWkAgi4fYLiMBF7A+kbUx9kfvTrsjx4Nwm8V1hCYsJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853382; c=relaxed/simple;
	bh=3FKHjzF/gbESgMd+FKLxuKmtdTGVSH0vXl4Qsmrd38Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VjTtRRQzrwBEA3GIxVyhltYJcICZm3EG7Gf+n6czInMle504NSe0AP+5gGp/PP60kqYrYuEKk0MMHtR5jTSRBlTMHKLjlWhuL2uTWAYIjOnbuopnXBhueNCpGwZUuWfUF5E6KHOaVODZutMGL93SfoTY5tjH1AQoZayk+eKZuzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZP+HBebW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA03C4CEDD;
	Mon, 24 Mar 2025 21:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853381;
	bh=3FKHjzF/gbESgMd+FKLxuKmtdTGVSH0vXl4Qsmrd38Y=;
	h=From:To:Cc:Subject:Date:From;
	b=ZP+HBebWkTpPWMSerecjHtM37mLB/JnRJPKANb+puZTsnbNPeGIlfO9Gp0ScEri8E
	 WOd8afjZqeW+6OukeCPQwf/ipMlnOCpqKvOnZsLbYxRLAPmjtvR9lm/78Qe81dUwH8
	 F41gDce7Hfdi/XuCBKbL69Gj2GY0jAnc5Rr6DAXg/BZQShJtUGI8H0xXKYXcb3Hexn
	 8XNZdXyq7+MILVSga/tiqeTrMTOYpGWlHUEyuVLxlgax3IhFD4AvpUF3aX/P5ekRJC
	 8b/sOl1a+Sqp7n5w1KzWtogWRGfATXxlE4p4gqhc0eWc52Ri84vHaXZQAr6hmf4XaE
	 xQjSWqJlT1aRQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH 00/22] objtool: CONFIG_OBJTOOL_WERROR fixes and cleanups
Date: Mon, 24 Mar 2025 14:55:50 -0700
Message-ID: <cover.1742852846.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since CONFIG_OBJTOOL_WERROR got merged into -tip, a lot of warnings have
been reported.  Fix those along with several other improvements.

Cc: Raju Rangoju <Raju.Rangoju@amd.com>
CC: Mark Brown <broonie@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <kees@kernel.org>

Josh Poimboeuf (22):
  objtool: Fix detection of consecutive jump tables
  objtool: Warn when disabling unreachable warnings
  objtool: Ignore entire functions rather than instructions
  objtool: Fix X86_FEATURE_SMAP alternative handling
  objtool: Fix CONFIG_OBJTOOL_WERROR for vmlinux.o
  objtool: Fix init_module() handling
  objtool: Silence more KCOV warnings
  objtool: Properly disable uaccess validation
  objtool: Improve error handling
  objtool: Reduce CONFIG_OBJTOOL_WERROR verbosity
  objtool: Fix up some outdated references to ENTRY/ENDPROC
  objtool: Remove --no-unreachable for noinstr-only vmlinux.o runs
  objtool: Remove redundant opts.noinstr dependency
  spi: amd: Fix out-of-bounds stack access in amd_set_spi_freq()
  nvmet: Fix out-of-bounds stack access in nvmet_ctrl_state_show()
  media: dib8000: Prevent divide-by-zero in dib8000_set_dds()
  panic: Disable SMAP in __stack_chk_fail()
  Input: cyapa - remove undefined behavior in cyapa_update_fw_store()
  ASoC: codecs: wcd934x: Remove undefined behavior in
    wcd934x_slim_irq_handler()
  regulator: rk808: Remove undefined behavior in rk806_set_mode_dcdc()
  pwm: mediatek: Prevent divide-by-zero in pwm_mediatek_config()
  lkdtm: Obfuscate do_nothing() pointer

 arch/x86/include/asm/arch_hweight.h     |   8 +-
 arch/x86/include/asm/smap.h             |  23 +-
 arch/x86/include/asm/xen/hypercall.h    |   6 +-
 drivers/input/mouse/cyapa.c             |   4 +-
 drivers/media/dvb-frontends/dib8000.c   |   5 +-
 drivers/misc/lkdtm/perms.c              |  14 +-
 drivers/nvme/target/debugfs.c           |   2 +-
 drivers/pwm/pwm-mediatek.c              |   8 +-
 drivers/regulator/rk808-regulator.c     |   4 +-
 drivers/spi/spi-amd.c                   |   2 +-
 include/linux/linkage.h                 |   4 -
 include/linux/objtool.h                 |   2 +-
 kernel/panic.c                          |   6 +
 scripts/Makefile.lib                    |   2 +-
 scripts/Makefile.vmlinux_o              |  15 +-
 sound/soc/codecs/wcd934x.c              |   2 +-
 tools/objtool/Documentation/objtool.txt |  10 +-
 tools/objtool/arch/x86/special.c        |  38 +-
 tools/objtool/builtin-check.c           | 146 ++++---
 tools/objtool/check.c                   | 525 ++++++++++++------------
 tools/objtool/elf.c                     |  28 +-
 tools/objtool/include/objtool/builtin.h |   6 +-
 tools/objtool/include/objtool/check.h   |   3 +-
 tools/objtool/include/objtool/elf.h     |  28 +-
 tools/objtool/include/objtool/objtool.h |   2 +-
 tools/objtool/include/objtool/special.h |   4 +-
 tools/objtool/include/objtool/warn.h    |  13 +-
 tools/objtool/objtool.c                 |  11 +-
 tools/objtool/special.c                 |  12 +-
 29 files changed, 477 insertions(+), 456 deletions(-)

-- 
2.48.1


