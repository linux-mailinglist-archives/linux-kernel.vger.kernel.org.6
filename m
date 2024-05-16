Return-Path: <linux-kernel+bounces-181112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FC78C7792
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385A01C2259A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A981474B4;
	Thu, 16 May 2024 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="OIbMra9Y"
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6DE146A81
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715865999; cv=none; b=mxDe0/pSDUNpGOkVBrtLqqbwxrvw0EtpcDrjb20VHi0mM8cJ1vrDHwJHSVV3xOHLHLwpDXinL8G8H5XQ+2lUc9rclyT63BgBp2XTboyddR9lV2fuQpX3ciJ0e6LbEK8lz29+tqNveEx++gPUpoU5hLEKA+emOq2i7A6zciSC0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715865999; c=relaxed/simple;
	bh=B+YQIsWwKDS2kXk4dBcyryjLpZFGQQdjRWPllppP1HA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u0xybgppZ2EBDLcNCKE+8T4JaEWQk1Odv0U0ekBX/iPUI3yY6Y+qKfCljMMOTriw+OUgafhtNLXMcPMwKdHICCnqO/orFN86veUuiXOAj3LJQcWrxl1KFliTwwT80y/AcZS90sPteyFpxBl1BO+O6iKMEJCsoHjnSRgoyiUAnmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=OIbMra9Y; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vg9pp3lDpzK21;
	Thu, 16 May 2024 15:26:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1715865986;
	bh=r3mi6lzal3IHo9WDD7iyS0/n1GYGenLY2na/Gr2Y/iU=;
	h=From:To:Cc:Subject:Date:From;
	b=OIbMra9YBi61V+j1Qta2E0xgwjLiMVB1YL6K/fu/RN26n8aiw+vTL4IA8IaxVMDsw
	 fd+ZK4SQ/X7m3q2uuRD9e7yJF8MpWouhEl4uevz5jmXuhsBd+9G//kLYjOPFWHQUP/
	 7czlu7NjU6vzfXFLwEIH3vWxon3cml3j94vRVhPY=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Vg9pn4vFDzrbk;
	Thu, 16 May 2024 15:26:25 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock updates for v6.10
Date: Thu, 16 May 2024 15:26:24 +0200
Message-ID: <20240516132624.1536065-1-mic@digikod.net>
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

This PR mainly brings IOCTL control to Landlock, contributed by Günther Noack.
This also adds him as a Landlock reviewer, and fixes an issue in the sample.

Please pull these changes for v6.10-rc1.  This commit merged cleanly with your
master branch.  The kernel code has been tested in the latest linux-next
releases for a few weeks, but I rebased it on v6.9 to avoid a merge conflict
because of the recent Kselftest fixes.

syzkaller has also been patched to know about this new access right.

Regards,
 Mickaël

--
The following changes since commit a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6:

  Linux 6.9 (2024-05-12 14:12:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.10-rc1

for you to fetch changes up to 5bf9e57e634bd72a97b4b12c87186fc052a6a116:

  MAINTAINERS: Add Günther Noack as Landlock reviewer (2024-05-13 06:58:36 +0200)

----------------------------------------------------------------
Landlock updates for v6.10-rc1

----------------------------------------------------------------
Günther Noack (11):
      landlock: Add IOCTL access right for character and block devices
      selftests/landlock: Test IOCTL support
      selftests/landlock: Test IOCTL with memfds
      selftests/landlock: Test ioctl(2) and ftruncate(2) with open(O_PATH)
      selftests/landlock: Test IOCTLs on named pipes
      selftests/landlock: Check IOCTL restrictions for named UNIX domain sockets
      selftests/landlock: Exhaustive test for the IOCTL allow-list
      samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL_DEV
      landlock: Document IOCTL support
      MAINTAINERS: Notify Landlock maintainers about changes to fs/ioctl.c
      fs/ioctl: Add a comment to keep the logic in sync with LSM policies

Ivanov Mikhail (1):
      samples/landlock: Fix incorrect free in populate_ruleset_net

Mickaël Salaün (1):
      MAINTAINERS: Add Günther Noack as Landlock reviewer

 Documentation/userspace-api/landlock.rst     |  78 ++++-
 MAINTAINERS                                  |   2 +
 fs/ioctl.c                                   |   3 +
 include/uapi/linux/landlock.h                |  38 ++-
 samples/landlock/sandboxer.c                 |  18 +-
 security/landlock/fs.c                       | 225 ++++++++++++-
 security/landlock/limits.h                   |   2 +-
 security/landlock/syscalls.c                 |   2 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   | 487 ++++++++++++++++++++++++++-
 10 files changed, 811 insertions(+), 46 deletions(-)

