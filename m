Return-Path: <linux-kernel+bounces-513745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776AFA34E25
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E5016B981
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8647D245AFA;
	Thu, 13 Feb 2025 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBcZWwge"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F8715252D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739473211; cv=none; b=c2nI2ehItvMCupX8DeV4NNBGhCSZD23nNbWTUw3MURRSIX+f0wKIXJ+udDXySEy5VgFMevD8Ekot04lF9K9buBL3Omr05LaEjQsox0Rmh6JQfwZHqa+tJ3zRMgDb4/OAfRB3zF1QO8LHfoVhZ79Mo48iZiTJqDkGsNRGBSheFNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739473211; c=relaxed/simple;
	bh=/cBGHGTAKeFBZ48OFF60j7+MiUDe7fnqRQSSmhD8ya8=;
	h=Message-ID:From:To:Cc:Subject:Date; b=p45iekk9GIr8V7m0zzjNk1oCNzTjox58eT7F1DyCuAcd9HKbvYbSAlNqL0JqZji1QI+TAMBjzLupA5TW0RqzzAixjFH2h7V9wAEDZp2sZF/SUESneSUxvYT+pFImCtIzHGitmOHU9RpmqT9Iwr+MY9ngjGFXGHGz5mG7KP7nEso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBcZWwge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C2BC4CED1;
	Thu, 13 Feb 2025 19:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739473211;
	bh=/cBGHGTAKeFBZ48OFF60j7+MiUDe7fnqRQSSmhD8ya8=;
	h=From:To:Cc:Subject:Date:From;
	b=rBcZWwgeRjRAWO4Ej0MyJa7ScTl07r6e7wiYfLSGizsoKD90eKxA8McUqIwS2SDsY
	 vvLrXq/XZbYMG3KTH4+8Km2vYG/mLwhdkywFmLpSxxKBnk/LA/IHubPeFsEmNIoBeT
	 VOyN4IzDPNvEmvrs/eMB14RR3zVHyYmfmJrdKINbVHQ0TH8CIcO/VjG/nY1kVWkxO6
	 cTZlKkkFrcIfMkn2hIWRBOFEOGZY9/PQMg4Zadm18OFaff3AomBlCsA1QdZfR08jrj
	 hWuFQNG7rtRK5PMsCbqkwCkBV1kvDcfVgdrNWT9HMUaweo4UI9HhjyKegCjVOfLK9k
	 QgLZAyY4uAuLA==
Message-ID: <c3dbdf8692edfa264e6c7471a72c0175.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v6.14-rc2
Date: Thu, 13 Feb 2025 18:59:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.14-rc2

for you to fetch changes up to 32ffed055dcee17f6705f545b069e44a66067808:

  regmap-irq: Add missing kfree() (2025-02-05 11:55:42 +0000)

----------------------------------------------------------------
regmap: Fix for v6.14

A simple fix for memory leaks when deallocating regmap-irq controllers.

----------------------------------------------------------------
Jiasheng Jiang (1):
      regmap-irq: Add missing kfree()

 drivers/base/regmap/regmap-irq.c | 2 ++
 1 file changed, 2 insertions(+)

