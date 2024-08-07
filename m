Return-Path: <linux-kernel+bounces-278632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6CD94B2B0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F37A282CD6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A882154445;
	Wed,  7 Aug 2024 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnLPVeB1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CE7146599;
	Wed,  7 Aug 2024 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723068328; cv=none; b=nrSs7J3vwOFCGQc+/Nhvyn1XG6JLoa+yjM2F/8ltmPOKa/XdzTcthQ6AY1cDTucZ1NCnUCNmittvNlmeOuxk7YgMKkC4OOWU50dcwMXCG3OsS4r/9wGxztBAmPByM2A4VxHtbLyDPPfFmDDatKi54JZ6FrbbI/pdJD+AnxE7M2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723068328; c=relaxed/simple;
	bh=bxHeSoKyMDMAGaESLACU55/FdN8ERxl3gla+Fif5osg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VcBLFVgLMj5clPLkeUOoYih3OzOzQNjS0xZDUpK01mndi1OIkD14CSWYPQBB8t41ygqUnHnQEDoP6BfiVsk5fKItHYoLtxrj1Lhck/9yflSZVYzW8lyxFkMHDxjlKozu4OpGNCeheUzg1h3UHDYtAN8rhT5VwfRbWa0TU+tJX+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnLPVeB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9E0C32781;
	Wed,  7 Aug 2024 22:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723068327;
	bh=bxHeSoKyMDMAGaESLACU55/FdN8ERxl3gla+Fif5osg=;
	h=From:To:Cc:Subject:Date:From;
	b=OnLPVeB1h72TiCvuX8iTZB5hsPipEHrh5jliRuGSQo3Pawpc/mPsOCgpdkMknZEN8
	 n7n9kv8BdUXu7GaWax4K3+1cj22xYAl8Y2AYgaoa5Hzt/IxKWIPdvCzeoVeV1NQc+9
	 A6qUD2EENnx901g/3cUTNh8pTg/0hqzX+MW+okDPUBQW+zJXmAYyiOaoPxWjt/fp+2
	 LPow8Aol2pBNBb1yMyCBy49POV50/Y8y8SfqVRUWzs7WQTqIdQOleIV27MWvpVJs3e
	 S12QiTlHNNg7Q0C8OotG+LmahNJDxFJK0MXdreR7GQYJ5INd6Y7KgRaTEmk/4k2qI8
	 hykLLZmXPg+7Q==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	nathan@kernel.org,
	morbo@google.com,
	justinstitt@google.com,
	mcgrof@kernel.org,
	thunder.leizhen@huawei.com,
	kees@kernel.org,
	kernel-team@meta.com,
	song@kernel.org,
	mmaurer@google.com,
	samitolvanen@google.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org
Subject: [PATCH v3 0/2] Fix kallsyms with CONFIG_LTO_CLANG
Date: Wed,  7 Aug 2024 15:05:11 -0700
Message-ID: <20240807220513.3100483-1-song@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_LTO_CLANG, the compiler/linker adds .llvm.<hash> suffix to
local symbols to avoid duplications. Existing scripts/kallsyms sorts
symbols without .llvm.<hash> suffix. However, this causes quite some
issues later on. Some users of kallsyms, such as livepatch, have to match
symbols exactly.

Address this by sorting full symbols at build time, and let kallsyms
lookup APIs to match the symbols exactly.

Changes v2 => v3:
1. Remove the _without_suffix APIs, as kprobe will not use them.
   (Masami Hiramatsu)

v2: https://lore.kernel.org/live-patching/20240802210836.2210140-1-song@kernel.org/T/#u

Changes v1 => v2:
1. Update the APIs to remove all .XXX suffixes (v1 only removes .llvm.*).
2. Rename the APIs as *_without_suffix. (Masami Hiramatsu)
3. Fix another user from kprobe. (Masami Hiramatsu)
4. Add tests for the new APIs in kallsyms_selftests.

v1: https://lore.kernel.org/live-patching/20240730005433.3559731-1-song@kernel.org/T/#u

Song Liu (2):
  kallsyms: Do not cleanup .llvm.<hash> suffix before sorting symbols
  kallsyms: Match symbols exactly with CONFIG_LTO_CLANG

 kernel/kallsyms.c          | 55 +++++---------------------------------
 kernel/kallsyms_selftest.c | 22 +--------------
 scripts/kallsyms.c         | 31 ++-------------------
 scripts/link-vmlinux.sh    |  4 ---
 4 files changed, 9 insertions(+), 103 deletions(-)

--
2.43.5

