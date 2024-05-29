Return-Path: <linux-kernel+bounces-193290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B10D28D29E3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 03:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620301F270DF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 01:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA93115ADB0;
	Wed, 29 May 2024 01:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="F9DCJFET"
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2203015AD83
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716945653; cv=none; b=MyyMweAYrqE1D+2CbpElevccZB3GGj8fN4mTpbkvllqIkQJmxznsAx5k8OdwQgCjKcjwFbODqJCQq8xVHmtAhLBeEaeGeDelpwhVZ3aUkbJuIk/Tkar47btKGPS7bPQFVCSeGpd8n9wnRZsghhkzg0N5dtAq3s/DjymR7GS2aOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716945653; c=relaxed/simple;
	bh=0IpIY6svVVqs936/3Ecv6ppMPPOb1PbWw/SJkBQdBNU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D7NC0ZCi+pg+NRNCKaJiE6IqiQNT4KXSMxd+ypnVySeFY9+G/ejCuVeL63CIL/ey1Q5aR0qFfO4joG08DHp9FPUDqF8lnNvBf7nuaxv+Btp9SRHGloeP2zMNgUIwNCONFWBhphBknjDu4+DvwXSrfLHE05ZpYJz5VW5MMj8WNms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=F9DCJFET; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D6A3114C1E1;
	Wed, 29 May 2024 03:20:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1716945642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Q10rdA6tlxh/SUGCLGRTZhLPngV4CNCKcsEszGpgXGk=;
	b=F9DCJFETCjLYVNh+zE23ywNLvZHlKJrkgdfW89ezkztqGi/mJ5yVBlcggbgX3859SHDlIh
	lWMMUSaOHQJZp+xASCg+bbF98I5MA77lnb7lueOV6Owxw44kBtycO/Ofz695iFX/piBV0C
	VJO8tEVIl5fnJKt7gZTaAtELvVT6miupHE2i2FN5XvTrz2u0670mgD2foUNWgjaXg/fyTe
	Cv7J6+LYIv/iBMA3WINZmCh8mfl8VWHlFXKnXP2nnqrZWFLDcmAOSPuehtvgzP4DQxfqMU
	8nqoYV96NDwd7EF7FpSHx2VkO/aCBmPsDSV72Qsh9dxDTUN8BRP5fqOsIZ/rXA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id dfdcbf57;
	Wed, 29 May 2024 01:20:36 +0000 (UTC)
Date: Wed, 29 May 2024 10:20:21 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] 9p fixes for 6.10-rc2
Message-ID: <ZlaC1Sn6WZtEGsbK@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The following changes since commit a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6:

  Linux 6.9 (2024-05-12 14:12:29 -0700)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-6.10-rc2

for you to fetch changes up to c898afdc15645efb555acb6d85b484eb40a45409:

  9p: add missing locking around taking dentry fid list (2024-05-23 20:29:09 +0900)

----------------------------------------------------------------
Two fixes headed to stable trees:

- some trace event was dumping uninitialized values
- a missing lock somewhere that was thought to have exclusive access,
and it turned out not to

----------------------------------------------------------------
Dominique Martinet (1):
      9p: add missing locking around taking dentry fid list

Nikita Zhandarovich (1):
      net/9p: fix uninit-value in p9_client_rpc()

 fs/9p/vfs_dentry.c | 9 +++++++--
 net/9p/client.c    | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
Dominique Martinet | Asmadeus

