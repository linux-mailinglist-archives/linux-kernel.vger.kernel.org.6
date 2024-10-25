Return-Path: <linux-kernel+bounces-382667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B530C9B11A9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 23:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76DD1C2166D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4BA20D50C;
	Fri, 25 Oct 2024 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="D6PWwpMd"
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1249C217F4C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729892190; cv=none; b=Pqc4p7A+kK4HcIVtLrCY2T1bVuus9aj1Or7kRtWXrUIf1fS+VmkPxlLY38ydTQ0B2DloZ7GAUjir89Jxkv6wiB9Jy38sBnPiB8GgnD285Sld0hyLcOeP5H3xSewjV8mbfmka2VOD8peq7vm5pe2Ng4idaQBwMm4Lrj4rU1WXUTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729892190; c=relaxed/simple;
	bh=3+KFcHbQIWjyeAheH/KxRYzNPHaMjPzLwH/4JdM3JuE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GSgU/ITKYHFKsaP6WsbqJvfsDTWxbn+JM65S/P2qy0aqgPy0wYZwj4cLG5QsYmrD94eDkKRm9kZ97u16/fXPba/n3IvSNqpdOkh/tteGRfNGFAEXzPztxhJuGSKrbZjm/5VR0cx9rkNzzXPMVVY++g4ac82PH6Q2QEDNvY5J5fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=D6PWwpMd; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 7BB8614C1E1;
	Fri, 25 Oct 2024 23:36:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1729892180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=msbetZUBXaor1UFV07AVhHFCrgXr3mbw/IjluhVXHM4=;
	b=D6PWwpMdLY9aY8+NBHz88UfHB9v/5gbTZODCv5WB5kCgPBrqKxROqb1TIn1y4ZnIETEzz3
	HJYic+0mrXHc8otqob6EONxI+PFNOEff5v6QYskoCEBRTYekQDePo6QSIQDmSWshddyt/B
	4E3Dp9jP6U8gv5icTcGuen6HMUi2Vt1NgEs5rg4gX+CkMIalAd8mfbKKvMO3Pj3/v+GOhb
	S9oczEeLcaEf2V46lxLNmeOFunRXneWCbNgGMoqqgNxzX1Qn3tQjk62mV1KGFK78lQdBE0
	IzU/4t+Qe3IUk+12Jy9XhD1iRe3bBvrxfIUu4eP9IliIvuRmKOCnHoGj25jqUg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 1d34c561;
	Fri, 25 Oct 2024 21:36:16 +0000 (UTC)
Date: Sat, 26 Oct 2024 06:36:01 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [GIT PULL] more 9p reverts for 6.12-rc5
Message-ID: <ZxwPQTUCnbGEt1KQ@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

- see tip commit (simplify iget revert) for full explanation.
This problem had been ignored for too long and the reverts will also
head to stable (6.9+)
- rebased yesterday to remove the use-folio revert that was applied
directly, but patches are fairly new anyway. I'm confident this set of
patches gets us back to previous behaviour (another related patch had
already been reverted back in April and we're almost back to square 1,
and the rest didn't touch inode lifecycle)

Thanks!


The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-6.12-rc5

for you to fetch changes up to be2ca3825372085d669d322dccd0542a90e5b434:

  Revert "fs/9p: simplify iget to remove unnecessary paths" (2024-10-25 06:26:09 +0900)

----------------------------------------------------------------
Revert patches causing inode collision problems

----------------------------------------------------------------
Dominique Martinet (4):
      Revert " fs/9p: mitigate inode collisions"
      Revert "fs/9p: remove redundant pointer v9ses"
      Revert "fs/9p: fix uaf in in v9fs_stat2inode_dotl"
      Revert "fs/9p: simplify iget to remove unnecessary paths"

 fs/9p/v9fs.h           |  34 +++++++++++++++----
 fs/9p/v9fs_vfs.h       |   2 +-
 fs/9p/vfs_inode.c      | 129 ++++++++++++++++++++++++++++++++++++++++++++++--------------------------
 fs/9p/vfs_inode_dotl.c | 112 ++++++++++++++++++++++++++++++++++++++++++++------------------
 fs/9p/vfs_super.c      |   2 +-
 5 files changed, 192 insertions(+), 87 deletions(-)

--
Dominique Martinet | Asmadeus

