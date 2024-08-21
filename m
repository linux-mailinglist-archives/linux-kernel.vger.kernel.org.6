Return-Path: <linux-kernel+bounces-295489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6869D959BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAAD1B241F7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12AD16BE03;
	Wed, 21 Aug 2024 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0O38Ljc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3604B1E507
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243077; cv=none; b=iND1vMRiHjzKAE1C817r2+CclIqC+kXbUDZFtD8XChxn0hoiGz92SiwVe9MboKuGt3jlcJaLVVOgIuXE38DLNncOzHyl74okFdLybWGwZYMfgeUGmu0mQ7ZKavC5icny5tPgdEGj6cAJXbnkYeYIrt0MBJ2uDUjOHKMwvi79x4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243077; c=relaxed/simple;
	bh=7Jml25bVydYsXgiMrn6j29Y0MUA8dnPhETeqDcz5x7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZclW/zXsqUOe+fXalQ/aAbOpIopYMOht+GhuiryY7T8ZXU6C8V1tze17GJ8Xusqp+R7qaT0a0KzplyHhtLETKETLuISKVdFuHhtAS/O6Go5RwllOahmpmlOz+plwFMNCUXmlyY2rBWftbC3SWdbtY4x8kGbP9hDWVAHDoZtaJfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0O38Ljc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72A0C32782;
	Wed, 21 Aug 2024 12:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724243076;
	bh=7Jml25bVydYsXgiMrn6j29Y0MUA8dnPhETeqDcz5x7Y=;
	h=Date:From:To:Cc:Subject:From;
	b=k0O38LjcQ+Go64NbMEQM6LFkrnF+xdQCZmO8tAD4Dt69qv79Kxc0zIakLiRZn0weP
	 K9nVB8NFucBxaVDkJ0zHKYQT1pEU43t9a5ZIDcRbLAic7GDJj86X/CMdRGvaW0FZWJ
	 /vTGZZ9aW2gU5jtovTyM+mu0dNPVE4GyBriN1V/2MkxiVpx40AjxDFCYXFiCv8ADw2
	 1T1qhA9KXCkpFvfV+yGDK4A7CXrUJ3wC5wxVmH8kvkEr/+qd/yJeAMOo4P6J3d79ZZ
	 zKGSsIGuZUl6LCXTRGnaG1E0AI/gC1lGQWCnU0ShLdlnis8EkXUvUhluyzisdSehgd
	 kF4JiL2Q+iuJA==
Date: Wed, 21 Aug 2024 20:24:28 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Hongzhen Luo <hongzhen@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Chunhai Guo <guochunhai@vivo.com>
Subject: [GIT PULL] erofs fixes for 6.11-rc5
Message-ID: <ZsXcfPaKq3X+Wa5h@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Hongzhen Luo <hongzhen@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Chunhai Guo <guochunhai@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Could you consider these patches for 6.11-rc5?

As I mentioned in [1], there is a regression which could cause system
hang due to page migration.  The corresponding fix [2] was landed
upstream through MM tree last week, therefore large folios can be safely
allowed for compressed inodes and stress tests have been running on my
fleet for over 20 days without any regression.  Users have explicitly
requested this for months, so let's allow large folios for EROFS full
cases now for wider testing.

Additionally, there is a fix which addresses invalid memory accesses on
a failure path triggered by fault injection and two minor cleanups to
simplify the codebase.

All commits have been in -next except for Sandeep's new reviewed-by.
No potential merge conflict is observed.

[1] https://lore.kernel.org/r/ZpTAI1mLZ1pfTnz8@debian
[2] 2e6506e1c4ee ("mm/migrate: fix deadlock in migrate_pages_batch() on large folios")

Thanks,
Gao Xiang

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.11-rc5-fixes

for you to fetch changes up to 0005e01e1e875c5e27130c5e2ed0189749d1e08a:

  erofs: fix out-of-bound access when z_erofs_gbuf_growsize() partially fails (2024-08-21 08:12:05 +0800)

----------------------------------------------------------------
Changes since last update:

 - Allow large folios on compressed inodes;

 - Fix invalid memory accesses if z_erofs_gbuf_growsize()
   partially fails;

 - Two minor cleanups.

----------------------------------------------------------------
Gao Xiang (2):
      erofs: allow large folios for compressed files
      erofs: fix out-of-bound access when z_erofs_gbuf_growsize() partially fails

Hongzhen Luo (2):
      erofs: simplify readdir operation
      erofs: get rid of check_layout_compatibility()

 Documentation/filesystems/erofs.rst |  2 +-
 fs/erofs/dir.c                      | 35 ++++++++++++-----------------------
 fs/erofs/inode.c                    | 18 ++++++++----------
 fs/erofs/internal.h                 |  2 +-
 fs/erofs/super.c                    | 26 ++++++--------------------
 fs/erofs/zutil.c                    |  3 ++-
 6 files changed, 30 insertions(+), 56 deletions(-)

