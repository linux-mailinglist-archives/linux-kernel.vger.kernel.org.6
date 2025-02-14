Return-Path: <linux-kernel+bounces-515360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3232CA363BC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE6A97A3687
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B67D267AEB;
	Fri, 14 Feb 2025 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ts8eHq6m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF14326773C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552314; cv=none; b=i/k7oFc9BYAFqwUF7csCz8iLdph235JeKoATejsNz7urvaQucG3LQ8phRyPynuf2Djnxe0C4icbPShHibhSCI3w5vDEl/2Yb+4+1pGmeawBqmnrGHs0lys4je7F0SKNSvVZx+cZ/Qzl/TKYF4HDp9k6J1ssySy5CA9q3rHs8w/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552314; c=relaxed/simple;
	bh=uYxbOqSRVZ7RwTmQu8CyGP4M4SHt9+FLmQ3Hk+pyjMA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hrCvy61DpT8xiceJhBKQjSZ6nA4tmY+vJDCwXcPAiRT7uSEr8dSS15c2JCXjZYYz2hGBktqeVqKxhZboF0tJYQERNBosOONc70dZ874NzGJWuSmNCqoKjo22nivmzCI8vHmtHOlhiO2htu40zoHFz0QnmZr2EhU+GMTcflj9Dh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ts8eHq6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B94C4CED1;
	Fri, 14 Feb 2025 16:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739552314;
	bh=uYxbOqSRVZ7RwTmQu8CyGP4M4SHt9+FLmQ3Hk+pyjMA=;
	h=Date:From:To:Cc:Subject:From;
	b=ts8eHq6m01HXipowDMzT+hvx9PMLPSnrIZGWu37ZJwG4BhrKpTrZBtqchu+UEa/2p
	 Md5Gph3BEu2VSW6KKiLoNUnB4wNQGtrFYwrDZ1arjmjFm3jhn7fKwG8CUESz6RAQlc
	 XDVq/YFwx/XfgDN7uN+v3cDZy3OsRHDdYpI0InHKqgF+IK/5LiFLR0AmhZSqR8cVn9
	 C5pyIl8F8gAuDrI1x/WIPG2cdHLssbui0Eo33F+JBckjk2DNdTonNB+v7eymK1Ogkd
	 lBC5Ep6bU04h3M3sr12FsNIHdwfDBgotQp1o/ZaS9G3dBwNfKcQrns3C+eVKH/r8mo
	 RHkbjrSQBkLfQ==
Date: Fri, 14 Feb 2025 06:58:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue: Fixes for v6.14-rc2
Message-ID: <Z692OY2tsm2GWeCM@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit ab18b8fff124c9b76ea12692571ca822dcd92854:

  Merge tag 'auxdisplay-v6.14-1' of git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-auxdisplay (2025-01-24 08:03:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.14-rc2-fixes

for you to fetch changes up to e76946110137703c16423baf6ee177b751a34b7e:

  workqueue: Put the pwq after detaching the rescuer from the pool (2025-01-24 09:29:46 -1000)

----------------------------------------------------------------
workqueue: Fixes for v6.14-rc2

- Fix a regression where a worker pool can be freed before rescuer workers
  are done with it leading to user-after-free.

----------------------------------------------------------------
Lai Jiangshan (1):
      workqueue: Put the pwq after detaching the rescuer from the pool

 kernel/workqueue.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
tejun

