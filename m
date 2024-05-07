Return-Path: <linux-kernel+bounces-170692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7577E8BDAAC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3157B283D96
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 05:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D7C6BB56;
	Tue,  7 May 2024 05:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtaSWS1+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E8E1CFBC
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 05:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715059815; cv=none; b=eBcPF3/dc79VNawCjbm5IvLV3wq/yry3aqKYlA7rRBf7WK1vAwXOGMDA6GENYBorDye3MyTwMKPoWBt81dazJm5+CX3i9yE0Q5039ACdau46zXS5DxaDKy9/THRiF5EjLlcJ8YHbkBLAxWKJsBuTIjggkCA7UFLXKSQzuzEoYek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715059815; c=relaxed/simple;
	bh=/OIeRmlA5blBquQJqBcAtSfI12fTrX9XkSqriyuCZBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=br+ul+e9QPDZXP/oY1JyI63jV8xq3ij4kXlIUY+59d91qRnff6Z5vTWXsOuyKLoiYQX9gT0QjxB9cb9VFDjuaGYz+ooh9Jm0SJOaA5GHoy3YolSy4X3YTVvf5D4yo2yFTVuL8g1O3WWxzmVftRKZXbXgr/XKtdpzk0Z9T+CSMEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtaSWS1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007ACC2BBFC;
	Tue,  7 May 2024 05:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715059814;
	bh=/OIeRmlA5blBquQJqBcAtSfI12fTrX9XkSqriyuCZBQ=;
	h=From:To:Cc:Subject:Date:From;
	b=EtaSWS1+8hYdYOy90Daws4v9hCkIfg7DuEPL6o6Iu2KCMBN4xtiHqJtj1ru/6Yc6q
	 FNnXD1dOmkB449WLf5Q286w8lT4Uz0zEvQ+kK6hWdH5OY2EIB0VDfkll2ZmV6Nnejm
	 Zmo55V5EuOjrmsvshnoN7M2LeFtS0yb/l14MQFO6zYkJlo4pi9df82GHICirf3BK34
	 ptA5gQExvsHSSgoMNUqIO0MlQ5doHKuYmfiECcpM1/hMQiY6QSJ7dWPBZh5arzP3ir
	 CxTGPyqVFsC5p1H6+7aY1Ucd+GRIlKy25VQ5tMqAwRaw5wbuQOKGrxA/XK3pl78COy
	 dXQvztvfZgMGw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v5 0/3] x86/bugs: more BHI
Date: Mon,  6 May 2024 22:30:03 -0700
Message-ID: <cover.1715059256.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 fixes some objtool warnings and enables noreturn-related
optimizations for direct-called syscall handlers.

Patches 2 and 3 add 'spectre_bhi=vmexit' which is useful for mitigating
BHI in cloud host environments.

v5:
- dropped syscall hardening patch for now
- dropped "Fix CPU mitigation defaults for !x86" in favor of Sean's fix
- patch 1 fixes (Paul)

Josh Poimboeuf (3):
  x86/syscall: Mark exit[_group] syscall handlers __noreturn
  x86/bugs: Remove duplicate Spectre cmdline option descriptions
  x86/bugs: Add 'spectre_bhi=vmexit' cmdline option

 Documentation/admin-guide/hw-vuln/spectre.rst | 84 ++-----------------
 .../admin-guide/kernel-parameters.txt         | 12 ++-
 arch/x86/entry/syscall_32.c                   | 10 ++-
 arch/x86/entry/syscall_64.c                   |  9 +-
 arch/x86/entry/syscall_x32.c                  |  7 +-
 arch/x86/entry/syscalls/syscall_32.tbl        |  6 +-
 arch/x86/entry/syscalls/syscall_64.tbl        |  6 +-
 arch/x86/kernel/cpu/bugs.c                    | 16 ++--
 arch/x86/um/sys_call_table_32.c               | 10 ++-
 arch/x86/um/sys_call_table_64.c               | 11 ++-
 scripts/syscalltbl.sh                         | 18 +++-
 tools/objtool/noreturns.h                     |  4 +
 12 files changed, 85 insertions(+), 108 deletions(-)

-- 
2.44.0


