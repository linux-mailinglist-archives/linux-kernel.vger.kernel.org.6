Return-Path: <linux-kernel+bounces-336232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A09097F0E9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77351F21CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53BF1A08CB;
	Mon, 23 Sep 2024 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="JGwiIuBO"
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D641A08AD
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118016; cv=none; b=NQR0YzarmErFSG57wS0XQTmS8gIhiTHGzcjFi+yVnLgYOCLsy7zmDc+q5AptFrzL9mxPer+0uO3mfOERfJdpuaChinMZ3NRaHSY3cokG8gISVbTfcxDgLumb0yVmYODzDmfNPcQaDhVRvYwoLlyeBDEQfd/oxxwF+niahqz8uyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118016; c=relaxed/simple;
	bh=+Ba9EUL9kS773t5YpyTYbOZvhba7LDJb7g6NTE0uZVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MX4Dzp4lkvBzXKSDpJZ/GI2qmbuslZWKLBdRhOTNsjyhX5hTInScCle5Ta0MBhfXjaD6kCFjjNoeBLLyK1vmwAcHFWHaUDKDXJJlMS8aIIwi6t71KBCaGUfFmPhaKIEiJt7WO4xXFd8kKKZXGxT8my1WUnrAcfRCu//Xf6Gp0ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=JGwiIuBO; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XCBjN0MDWz2mR;
	Mon, 23 Sep 2024 20:44:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1727117047;
	bh=dG8p22DhWVuLVas0YarMUDwAkOaPh/p1GYeaN06+mqw=;
	h=From:To:Cc:Subject:Date:From;
	b=JGwiIuBOpcs1ebRGPNKVHLoRjo7cBDvfGI1Ag1MLtyf4pPqVs+tYqvIKUDj4ioK5r
	 jzVGh0tRGCIpH9sqJ/DFfkuaRYY4NucKFLejfbUDyoqD/BlIe/vwVxAYtIW1uqIaFC
	 7KEsaiyl1ECYwLunbx2J3HdVgkRDN3xRGGYRMT/c=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XCBjM2QDJz5d4;
	Mon, 23 Sep 2024 20:44:07 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jann Horn <jannh@google.com>,
	Paul Moore <paul@paul-moore.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: [GIT PULL] Landlock updates for v6.12
Date: Mon, 23 Sep 2024 20:42:51 +0200
Message-ID: <20240923184251.153123-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi Linus,

This PR brings signal and abstract UNIX socket control to Landlock, contributed
by Tahera Fahimi during her Outreachy internship [1].  These features are
useful to better isolate processes.

Please pull these changes for v6.12-rc1.  These commits merge cleanly with your
master branch.  The kernel code has been tested in the latest linux-next
releases for a few weeks, but I rebased it on your master branch last week
because of VFS and LSM tree dependencies.

We can now scope a Landlock domain thanks to a new "scoped" field that can deny
interactions with resources outside of this domain.  The
LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET flag denies connections to an abstract UNIX
socket created outside of the current scoped domain [2], and the
LANDLOCK_SCOPE_SIGNAL flag denies sending a signal to processes outside of the
current scoped domain [3].  These restrictions also apply to nested domains
according to their scope.  The related changes will also be useful to support
other kind of IPC isolations.

Test coverage for security/landlock is 92.2% of 1046 lines according to
gcc/gcov-14, and it was 91.7% of 961 lines before this series.

Regards,
 Mickaël

Link: https://sched.co/1ej1w [1]
Link: https://lore.kernel.org/r/cover.1725494372.git.fahimitahera@gmail.com [2]
Link: https://lore.kernel.org/r/cover.1725657727.git.fahimitahera@gmail.com [3]

--
The following changes since commit a430d95c5efa2b545d26a094eb5f624e36732af0:

  Merge tag 'lsm-pr-20240911' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm (2024-09-16 18:19:47 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.12-rc1

for you to fetch changes up to 1ca980815e1f284dddcb5e678c91bbd3e3f3a6a6:

  landlock: Document LANDLOCK_SCOPE_SIGNAL (2024-09-16 23:50:55 +0200)

----------------------------------------------------------------
Landlock updates for v6.12-rc1

----------------------------------------------------------------
Tahera Fahimi (14):
      landlock: Add abstract UNIX socket scoping
      selftests/landlock: Test handling of unknown scope
      selftests/landlock: Test abstract UNIX socket scoping
      selftests/landlock: Test UNIX sockets with any address formats
      selftests/landlock: Test connected and unconnected datagram UNIX socket
      selftests/landlock: Test inherited restriction of abstract UNIX socket
      samples/landlock: Add support for abstract UNIX socket scoping
      landlock: Document LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET
      landlock: Add signal scoping
      selftests/landlock: Test signal scoping
      selftests/landlock: Test signal scoping for threads
      selftests/landlock: Test signal created by out-of-bound message
      samples/landlock: Add support for signal scoping
      landlock: Document LANDLOCK_SCOPE_SIGNAL

 Documentation/userspace-api/landlock.rst           |   58 +-
 include/uapi/linux/landlock.h                      |   30 +
 samples/landlock/sandboxer.c                       |   73 +-
 security/landlock/cred.h                           |    2 +-
 security/landlock/fs.c                             |   25 +
 security/landlock/fs.h                             |    7 +
 security/landlock/limits.h                         |    3 +
 security/landlock/ruleset.c                        |    7 +-
 security/landlock/ruleset.h                        |   24 +-
 security/landlock/syscalls.c                       |   17 +-
 security/landlock/task.c                           |  193 ++++
 tools/testing/selftests/landlock/base_test.c       |    2 +-
 tools/testing/selftests/landlock/common.h          |   39 +
 tools/testing/selftests/landlock/fs_test.c         |    1 -
 tools/testing/selftests/landlock/net_test.c        |   31 +-
 .../selftests/landlock/scoped_abstract_unix_test.c | 1041 ++++++++++++++++++++
 .../selftests/landlock/scoped_base_variants.h      |  156 +++
 tools/testing/selftests/landlock/scoped_common.h   |   28 +
 .../landlock/scoped_multiple_domain_variants.h     |  152 +++
 .../selftests/landlock/scoped_signal_test.c        |  484 +++++++++
 tools/testing/selftests/landlock/scoped_test.c     |   33 +
 21 files changed, 2359 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/scoped_abstract_unix_test.c
 create mode 100644 tools/testing/selftests/landlock/scoped_base_variants.h
 create mode 100644 tools/testing/selftests/landlock/scoped_common.h
 create mode 100644 tools/testing/selftests/landlock/scoped_multiple_domain_variants.h
 create mode 100644 tools/testing/selftests/landlock/scoped_signal_test.c
 create mode 100644 tools/testing/selftests/landlock/scoped_test.c

