Return-Path: <linux-kernel+bounces-434877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E2F9E6C60
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58453188099A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3345201104;
	Fri,  6 Dec 2024 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkFGVu7I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BCE1FC7CB
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480792; cv=none; b=XvJm/qp5A6o5Ll/rD7SoFaf85VdwNSYZzgkXQFgUoN70v76bgJ1tOx25SDdeP0wkWD+0UTCngCPS90ZmzzrMaV4cnwndPrxrqDuqTApBn/5pHk667o8uxIRhktu/XC4bx6MoPN7D0CWNebUd/YYwrx1miEKNvhMuDwW1bwkhgws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480792; c=relaxed/simple;
	bh=QgY/p8o4MoYwmaB9p+ZHNIbF1pl77aGEMpBVKTpyrto=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uwpbd+8c9kA+2oQw5Pexu1cWYGGayQBQnYjzGxy+FRw41rGL1vQo0R8wATmE4KAAAX0InQOBx5V+Z3kdGeiaeFYLlXJiBuwkKXqUkq7LclBVQmZRWfen5bm6IgKMP5LSpY15KFFLfF6RMEQRzbEaPT4p63r4SwtlSZJOICbuSZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkFGVu7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930C8C4CED1;
	Fri,  6 Dec 2024 10:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733480791;
	bh=QgY/p8o4MoYwmaB9p+ZHNIbF1pl77aGEMpBVKTpyrto=;
	h=Date:From:To:Cc:Subject:From;
	b=RkFGVu7IW7rr+XvPQP/stnT7EpTNaQdoyR6jjk3GerKlG0hkLkiUt1dunoTC6YYAW
	 PeZJ9bfS1V9jxnoDxMzNeNyVem8wVYxX8TjPtc1jiMMRQ3okThA/2mCNJtbptK+iu7
	 DF/2N09AQuyGSMotOBPTv6TW7Smm1l5Mtdf/909l+itL2fa5I/gcqwFcpp/nFyV3Dy
	 RMU5CXSm+RvvaINkZyMr1tYPxPKof2My71Tl5mlCFeDTROS4I3m3o+Ypo56NQ441jD
	 Vlsyi7BtCZPR6ipO1c1bxzmrRcrNpYtu5QNtzP78t8vFrrs2KntRQJyHOmTuXt3upT
	 NSJ6l3StpaJOw==
Date: Fri, 6 Dec 2024 12:26:20 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Marc Zyngier <maz@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock: restore check for node validity in arch_numa
Message-ID: <Z1LRTHMT2as5VhEU@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit bcc8eda6d34934d80b96adb8dc4ff5dfc632a53a:

  Merge tag 'turbostat-2024.11.30' of git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux (2024-11-30 18:30:22 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2024-12-06

for you to fetch changes up to 180bbad698641873120a48857bb3b9f3166bf684:

  arch_numa: Restore nid checks before registering a memblock with a node (2024-12-01 22:04:52 +0200)

----------------------------------------------------------------
memblock: restore check for node validity in arch_numa

Rework of NUMA initialization in arch_numa dropped a check that refused to
accept configurations with invalid node IDs.

Restore that check to ensure that when firmware passes invalid nodes, such
configuration is rejected and kernel gracefully falls back to dummy NUMA.

----------------------------------------------------------------
Marc Zyngier (1):
      arch_numa: Restore nid checks before registering a memblock with a node

Mike Rapoport (Microsoft) (1):
      memblock: allow zero threshold in validate_numa_converage()

 drivers/base/arch_numa.c | 4 ++++
 mm/memblock.c            | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
Sincerely yours,
Mike.

