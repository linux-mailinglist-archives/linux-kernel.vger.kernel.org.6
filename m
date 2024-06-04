Return-Path: <linux-kernel+bounces-201403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 957478FBE10
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552382851D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB0314B976;
	Tue,  4 Jun 2024 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ZdJZDbBc"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51C145C1C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717536569; cv=none; b=mtFKhQqUamnV/X9gumKzF3tJp97gC0FHeLzeyx52bSQkTjwvNC8d6B6mKmIgt39aTX2yLA0I0fmhWTSoiI0mJsKsnhI/DfMMmKWVvROjO0GJJx1v8lEjNcJSySVJe6+t9uurFjQU0/jmFmsfaQ/YjhHJ9zH4DGAjc6j2EfJCTJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717536569; c=relaxed/simple;
	bh=MCqrxBa4S8U5u7MCmrYYze0aL09UL2JVbSqJf0mQYOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hMidYGXBOT2R4wHdm3VyE4TpjrBrNsfIPUhBac5+XPN0h++P3K5aR/f9oPTe0BbCTSSLHCfmgYHTaG+qO+pvR88fnHWAl80wGMtztL66jbx4CERgkDkkxaF6CdgW9RxWUqeNLeGSqyxjRfGZYrFVxZcYfV3ps6ZTvzlYYrnBOBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ZdJZDbBc; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=LWsYD8EI4ECNkK
	uHeAZPt+ug0/S0KoVB/ZZVlAu0SMU=; b=ZdJZDbBc22cv9m8UWoeg3yme/4+yOz
	5SvA0tZgBV57Tu33GOr7OtENrx14IZG2qyt7+YVjdxZc6Tibo4FcrqP+TMNOCH+3
	puOvlB6M4WHRhxot2aZMyXpF+HwWSL1rvvp8rqhl5ZO+Wb/z4N07sfYImA0w2og5
	0Laf7IZrs5TfuHuIUvQTippQT6rNZEZW1P74P+3GFsEVigZ3S5I42jSl5tQwNNJx
	ficrJSiBkB+AUfdOb96FCckH4fRl05EujAq9jwd2P6dWcH5qecH76TgyEy/qB1xX
	mtSVl5TXqbpQJi2A1rlN8V4y1Y/E2/Xgb6/o/uoEMsLo5gfLxfk+QAZw==
Received: (qmail 2450878 invoked from network); 4 Jun 2024 23:29:25 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Jun 2024 23:29:25 +0200
X-UD-Smtp-Session: l3s3148p1@yqDgJBca7tlehhtB
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mtd@lists.infradead.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 0/2] mtd: use 'time_left' instead of 'timeout' with wait_*() functions
Date: Tue,  4 Jun 2024 23:29:19 +0200
Message-ID: <20240604212919.5038-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_*() functions causing patterns like:

        timeout = wait_for_completion_timeout(...)
        if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
obvious and self explaining.

This is part of a tree-wide series. The rest of the patches can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/time_left

Because these patches are generated, I audit them before sending. This is why I
will send series step by step. Build bot is happy with these patches, though.
No functional changes intended.

Wolfram Sang (2):
  mtd: nand: mxc_nand: use 'time_left' variable with
    wait_for_completion_timeout()
  mtd: rawnand: intel: use 'time_left' variable with
    wait_for_completion_timeout()

 drivers/mtd/nand/raw/intel-nand-controller.c | 6 +++---
 drivers/mtd/nand/raw/mxc_nand.c              | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.43.0


