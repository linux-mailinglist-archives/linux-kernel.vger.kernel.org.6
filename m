Return-Path: <linux-kernel+bounces-562017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD6EA61A96
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19AD4639BC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E935720765E;
	Fri, 14 Mar 2025 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrrRxCB9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DAF2066C5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980569; cv=none; b=GoBfMWl+HOQsHV3hBW4VofOTFx4RHQfiRGrBDhuExjoMhl9bjsNojlApolgVWKykyIIJb5iIpjCI+lbKcPUyTr8RU2Ggf8IYp4FnEd+Qb129PXUtYN7F3sUzjJl2jwagz8kqGt/XB7/+A46E5AJHWH8GMwb+7Hw7DG0CdqUlotU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980569; c=relaxed/simple;
	bh=lU5ibQqCuoPhaQ1InXMQ1Ireha36PIp4tfiybZ+/WZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c4vBpUzA4IId0Rd03uWztC/jJWFHH4lnX37enP23fHHd5t1t+Gu/pjicwR8vEZfnFT27foBtOG6+5F1JqnoFSCiv47BRbZP2gzoHfu1ushbhXIjlmOoAQV+5kdXj+sRa0VTEPnZzehmvEyChumpJ59tdbuPekP2txIAVRNIoCiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrrRxCB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1A5C19425;
	Fri, 14 Mar 2025 19:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741980568;
	bh=lU5ibQqCuoPhaQ1InXMQ1Ireha36PIp4tfiybZ+/WZg=;
	h=From:To:Cc:Subject:Date:From;
	b=rrrRxCB9PdpOatO8iTFnFiwNgsylcjbzT3t6nhQJrjA7Mei1IpgwC2+LsMkBfE4pS
	 nWKuNEVU0z+2upDC7bH5KJrMU0f+cidIJtuyNyIhwK9CUYuBTEjPg3Uy2bJxo3nmi6
	 CQ96ioaclLCkugLNWACAo1oTBng5qXh2dFNh2VJZAiSeZz+g+dx9c5mqCueFLH786U
	 +JETmU0fxW+ZFNIqpZSpjl2ChSsjpaEU1LVFL65JdxLuchiJX7MrdERyZDD9ix9b9c
	 vLCF4KBKA7IgKZTAJNU+vgOt7AZW1yq/NRscoddDPvvzpJMvZh1Zx2XNPjxCsSwUcC
	 n9EH3w23hxeaQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 00/13] Fail the build on objtool warnings
Date: Fri, 14 Mar 2025 12:28:58 -0700
Message-ID: <cover.1741975349.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an option to fail the build on objtool warnings, and enable it by
default except for CONFIG_COMPILE_TEST.

This is long overdue, probably the only reason we didn't do it before
(other than lack of time) was because there are still some obscure
warnings out there, especially once KCOV and sanitizers get added to the
mix.

But those are mostly bot issues, the main concern for objtool warnings
is actual real live kernels.  Hopefully the !COMPILE_TEST guard will
avoid too much wreckage for now.


Josh Poimboeuf (13):
  x86/traps: Make exc_double_fault() consistently noreturn
  objtool: Fix error handling inconsistencies in check()
  objtool: Improve __noreturn annotation warning
  objtool: Update documentation
  objtool: Increase per-function WARN_FUNC() rate limit
  objtool: Remove --unret dependency on --rethunk
  objtool: Consolidate option validation
  objtool: Upgrade "Linked object detected" warning to error
  objtool: Add --output option
  objtool: Add --Werror option
  objtool: Change "warning:" to "error:" for --Werror
  objtool: Create backup on error and print args
  objtool: Add CONFIG_OBJTOOL_WERROR

 arch/x86/kernel/traps.c                 |  18 +-
 lib/Kconfig.debug                       |  12 ++
 scripts/Makefile.lib                    |   1 +
 tools/objtool/Documentation/objtool.txt | 105 ++++++------
 tools/objtool/builtin-check.c           | 212 ++++++++++++++++++------
 tools/objtool/check.c                   |  60 +++----
 tools/objtool/elf.c                     |   3 -
 tools/objtool/include/objtool/builtin.h |   3 +-
 tools/objtool/include/objtool/elf.h     |   2 +-
 tools/objtool/include/objtool/warn.h    |  20 ++-
 tools/objtool/objtool.c                 |  78 +--------
 tools/objtool/orc_dump.c                |   7 +-
 12 files changed, 290 insertions(+), 231 deletions(-)

-- 
2.48.1


