Return-Path: <linux-kernel+bounces-288393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0588B9539A1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE608287F51
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334FB45948;
	Thu, 15 Aug 2024 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIoLnF7m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B81C15CB
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723745312; cv=none; b=ueakq/k1fVp0lhC5R4mK9Nl09Xmwi3IuSF4EnovXvnqjkM2UEDUCw9ZXawVixzv/uSA5IyWccZnLhZTKAl5tzVARTV+Wd6beVilKS1Qy/OCiNXSj6VXhJEP1+zgTolCPeBVEwDuLtGCp/gzFRThguCrhpIAy6ugYOhUpk6w87Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723745312; c=relaxed/simple;
	bh=2qD6ofkbI+L999KFZxOaa73z043ht/eHsHu8/Q81+4I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MTCg6MJETyGiTL0IKxO3ebvxiB70/k2UEboYAVqIwgWhCwus8PthaK+/IiGVqZ/6JYZF2SNsNzxok+Fy3U1jp+FJ7SENl+duUsbGhcDRozUuXZesz4HHB7ZlEqGHOA1nryJrVMWoiQRvXJzuVyoU3IkyB7EG08QOjVTNmFS+eUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIoLnF7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3109C32786;
	Thu, 15 Aug 2024 18:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723745312;
	bh=2qD6ofkbI+L999KFZxOaa73z043ht/eHsHu8/Q81+4I=;
	h=Date:From:To:Cc:Subject:From;
	b=pIoLnF7m81htXYtUNnjHdjTE82C4Ey/XdnnHKKX38HZ/RYn8fD7hO2EzsgfG+52et
	 vbeULWfypBqsjFQxkJ/agONxBTMW0oEI1QNWvM6NNylzhlyj+ppuDv7rq3167B2KXE
	 7f5m9+OCfN7YreuzOxeLrQlKfKiEIZdHGFV4JbjkyTCXZtrv6k9PZBsGpz9RAcAoIm
	 lbNwc5gHphL8w3pn3rzSkHA+61AQgDWrcirt0flnUZOqkkKE0ISnsRcMHo9tBfOaPx
	 Mk8a0KWXwn1Lm9EYGIh1yCetIKGT+iQAYmVmF6TkPoT3+oZT6yRAuetmnCX9ZX0qMb
	 8xpT2ec/QyXug==
Date: Thu, 15 Aug 2024 11:08:30 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>, Kees Cook <kees@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>, Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>, Song Liu <song@kernel.org>,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [GIT PULL] hardening fixes for v6.11-rc4
Message-ID: <202408151107.18E1DC8CE4@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these various hardening fixes for v6.11-rc4.

Thanks!

-Kees

The following changes since commit de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed:

  Linux 6.11-rc2 (2024-08-04 13:50:53 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.11-rc4

for you to fetch changes up to fb6a421fb6153d97cf3058f9bd550b377b76a490:

  kallsyms: Match symbols exactly with CONFIG_LTO_CLANG (2024-08-15 09:33:35 -0700)

----------------------------------------------------------------
hardening fixes for v6.11-rc4

- gcc-plugins: randstruct: Remove GCC 4.7 or newer requirement
  (Thorsten Blum)

- kallsyms: Clean up interaction with LTO suffixes (Song Liu)

- refcount: Report UAF for refcount_sub_and_test(0) when counter==0
  (Petr Pavlu)

- kunit/overflow: Avoid misallocation of driver name (Ivan Orlov)

----------------------------------------------------------------
Ivan Orlov (1):
      kunit/overflow: Fix UB in overflow_allocation_test

Petr Pavlu (1):
      refcount: Report UAF for refcount_sub_and_test(0) when counter==0

Song Liu (2):
      kallsyms: Do not cleanup .llvm.<hash> suffix before sorting symbols
      kallsyms: Match symbols exactly with CONFIG_LTO_CLANG

Thorsten Blum (1):
      gcc-plugins: randstruct: Remove GCC 4.7 or newer requirement

 drivers/misc/lkdtm/refcount.c                 | 16 ++++++++
 include/linux/refcount.h                      |  4 +-
 kernel/kallsyms.c                             | 55 +++------------------------
 kernel/kallsyms_selftest.c                    | 22 +----------
 lib/overflow_kunit.c                          |  3 +-
 scripts/gcc-plugins/randomize_layout_plugin.c |  4 --
 scripts/kallsyms.c                            | 31 +--------------
 scripts/link-vmlinux.sh                       |  4 --
 8 files changed, 28 insertions(+), 111 deletions(-)

-- 
Kees Cook

