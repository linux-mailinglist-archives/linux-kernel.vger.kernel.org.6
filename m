Return-Path: <linux-kernel+bounces-299810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A42DC95DA47
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 02:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C241F21A47
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 00:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59F35CB8;
	Sat, 24 Aug 2024 00:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gp5R/gb+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FB24A05
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 00:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724461149; cv=none; b=u80n6q6/87Zm50Mt9EA1N7gjMDBlZUaCrdTN2l8NGAewEEa0kMtkYjQRAlOP6sy1Vp0IFmvAED6K7mz8lJ5k41pnMDUtubIFz6AxEWG+VkE70d/ySPjVcGg1sxbNJb1A3qhRv5K8Iz9lBrtCH2t+wPG0s6Ra6AXtH52wFDcZ9GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724461149; c=relaxed/simple;
	bh=HHEjcaYJKwK2DJBCvLb41BHJFBYqPtFELEzoih4Ng2M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L0UqhZG9ebnubdtKYhTq+lWddq8ZXGdzGANIRPOTtvSq3SEfRIzhDQrGQCHQSPXjahQE1E1T+erZyxyIIA9UTDny/QfXO3Kc9mm0plXPgPhooO+pLxABCrtgAap/HTbsnBhZ1qgXpOu2yUfI8yUBtFys1E6I6ZSGi9OMguTvcPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gp5R/gb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C729C32786;
	Sat, 24 Aug 2024 00:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724461148;
	bh=HHEjcaYJKwK2DJBCvLb41BHJFBYqPtFELEzoih4Ng2M=;
	h=Date:From:To:Cc:Subject:From;
	b=gp5R/gb+0kN81Sy7Ap8nAhPrTAfz5vmmjwC1q84UFS1MJ5qEfIiPIT5JvJpi/m3D4
	 Mc+QdcTcoxw9w5lDwPWOFPEYlydS1unBCnBSgsqByRoZCyUVhiqsL0b0/0T5PFaq++
	 HsdMfIX8k+t5mZKNPqO+UCLPqjz2xU9QX65DhMCvbTQucx9uJMGuHu9uOf5k3+T8rn
	 NMu9nLOw41TwUKEfQUxtOhMS+10L1DITOFSvFGdOyJRTtY1yo3GAcdrR3SYMsAfCqC
	 I9raJ5O3wnRY0y1F0iHSiaj7N6WrksOdegWkmQ9+aE5/TGgVIzppI+imtFhXgu5VDJ
	 xz87JTJwgacmw==
Date: Fri, 23 Aug 2024 14:59:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue: Fixes for v6.11-rc4
Message-ID: <ZskwWy-gDniofgyx@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.11-rc4-fixes

for you to fetch changes up to c4c8f369b6a6d21ce27286de1501137771e01dc3:

  workqueue: Correct declaration of cpu_pwq in struct workqueue_struct (2024-08-05 18:34:02 -1000)

----------------------------------------------------------------
workqueue: Fixes for v6.11-rc4

Nothing too interesting. One patch to remove spurious warning and others to
address static checker warnings.

----------------------------------------------------------------
Lai Jiangshan (1):
      workqueue: Remove incorrect "WARN_ON_ONCE(!list_empty(&worker->entry));" from dying worker

Nikita Shubin (1):
      workqueue: doc: Fix function name, remove markers

Tejun Heo (1):
      workqueue: Fix spruious data race in __flush_work()

Uros Bizjak (1):
      workqueue: Correct declaration of cpu_pwq in struct workqueue_struct

Will Deacon (1):
      workqueue: Fix UBSAN 'subtraction overflow' error in shift_and_mask()

 Documentation/core-api/workqueue.rst |  2 +-
 kernel/workqueue.c                   | 50 +++++++++++++++++++-----------------
 2 files changed, 28 insertions(+), 24 deletions(-)

