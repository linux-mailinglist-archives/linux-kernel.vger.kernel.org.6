Return-Path: <linux-kernel+bounces-336148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8281E97EFB9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39C11C214D7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23E819F129;
	Mon, 23 Sep 2024 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuYss/I2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF7C81AD7
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727111066; cv=none; b=PA2/3reP06u6sZnDt9K0/BywRQY06NUHK4asM73P4h5pyeWhIcFkPUghq5yezqRUA1/lYzLCAxt+lQ4P4D3o7gZipvuEeioGEM8ciMs2RyPCBcwmsS8xQnTIxy1teuKfC3YGQoiOLuhTcjDtHQyD0I6Kqn4GKkSyAWRuxTSJaL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727111066; c=relaxed/simple;
	bh=HdIcTKk2kFF+r2SokNbiQMH78hZTrKkJjPbDb5G0bk8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PeNeB4XVnspRgulcL4GPmI5x1Ypu694RRkpSZ77HxQbHglKf0wP8ftV14Ep+oYX7i6qnI8nti8jamCN6Bn6eyOCThJzsk8DEW1SXJDbi7RoVO+cnEkHzvx+hDNO/4rBKKEA1MtLhh2mi6HtB6+cB5E1ITdI/nNYaWA8IPGHyoUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuYss/I2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF687C4CEC4;
	Mon, 23 Sep 2024 17:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727111065;
	bh=HdIcTKk2kFF+r2SokNbiQMH78hZTrKkJjPbDb5G0bk8=;
	h=Date:From:To:Cc:Subject:From;
	b=JuYss/I2OFUjMNBoEb5QTSM8dtbOUffgS/i4F5ZbEKUQ5Q+mZKufqSfjmWP4tAj5e
	 0hbz7VSxDW9YZbW+FDgEHhFfJXE3iX2rsyNfjf1WUt9fIvd1tvUtwDmL0fHUSkUmo/
	 bYzN48kULtjSPiZxA8PZ6t0UVtygJWg9O0tjL//PJj12qNJKrRZv1xtmprEqkpSvdT
	 5YXf0100yKTmQhQXNXnDFlmkn+NOwbMUdXHwICiE7T73IuK51XxrxRo1sMccy7CnAz
	 h7SuKh/cfx6PeZvY+wBGafxxoyR+cTU46JVwT/9q5ZiixiQLwW5xDjWR6h22BoEEs7
	 3V3RWygYHPw7A==
Date: Mon, 23 Sep 2024 07:04:24 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com,
	David Vernet <void@manifault.com>
Subject: [GIT PULL] sched_ext: Fixes for v6.12-rc1
Message-ID: <ZvGfmIJt-5gg9EwU@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 88264981f2082248e892a706b2c5004650faac54:

  Merge tag 'sched_ext-for-6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext (2024-09-21 09:44:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12-rc1-fixes

for you to fetch changes up to 431844b65f4c1b988ccd886f2ed29c138f7bb262:

  sched_ext: Provide a sysfs enable_seq counter (2024-09-23 06:53:02 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v6.12-rc1

- Three build fixes.

- The fix for a stall bug introduced by a recent optimization in sched core
  (SM_IDLE).

- Addition of /sys/kernel/sched_ext/enable_seq. While not a fix, it is a
  simple addition that distro people want to be able to tell whether an SCX
  scheduler has ever been loaded on the system.

----------------------------------------------------------------
Andrea Righi (1):
      sched_ext: Provide a sysfs enable_seq counter

Pat Somaru (1):
      sched, sched_ext: Disable SM_IDLE/rq empty path when scx_enabled()

Tejun Heo (1):
      sched_ext: Fix build when !CONFIG_STACKTRACE

Yu Liao (2):
      sched: Add dummy version of sched_group_set_idle()
      sched: Put task_group::idle under CONFIG_GROUP_SCHED_WEIGHT

 Documentation/scheduler/sched-ext.rst | 10 ++++++++++
 kernel/sched/core.c                   |  3 ++-
 kernel/sched/ext.c                    | 24 +++++++++++++++++++++---
 kernel/sched/sched.h                  | 10 ++++++----
 tools/sched_ext/scx_show_state.py     |  1 +
 5 files changed, 40 insertions(+), 8 deletions(-)

-- 
tejun

