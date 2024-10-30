Return-Path: <linux-kernel+bounces-388478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA5D9B6033
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3251C217A4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0B11E2848;
	Wed, 30 Oct 2024 10:32:27 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCA71E3784
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730284347; cv=none; b=h5AlDQk7dJ54aXOYOtny2g48rlzyUoEPFWJBeKklhdeMZOFAr0lTWQYr44lViNL2RJh+NKdLCQ/w7ZkKZUaHna+vGQvQGBhpdoJnZOGfwacw7RM+7U41Cnn/xanWgaVQ358UxnKzrJzPASW1kurVL1v4K5hvOhTR4zJlyFX++ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730284347; c=relaxed/simple;
	bh=ONljCAaXxr7CvIpXfPSLakG9YzdXAgNj39DDo3OpjOQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tpr29FG4kWzZ3Ndsho2xwmtt7ZB3LoEW0bNgbdywIf1M35LrbvXfjNTJC7cmcqGZzoHDeJvVecV/uIuUiqGs1a2aDG2Muq7henDf71L6DG/M8QXUn/tgVHVE2pCGeVd6kqEvdR03gtXGKkyn0AQXiUfr/Q5d3F1Um4nahSuzuQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 49UAVevu026664;
	Wed, 30 Oct 2024 18:31:40 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Xdk1L6f7gz2K4lHM;
	Wed, 30 Oct 2024 18:31:02 +0800 (CST)
Received: from tj10379pcu1.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 30 Oct 2024 18:31:38 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <chao@kernel.org>, <jaegeuk@kernel.org>
CC: <yi.sun@unisoc.com>, <sunyibuaa@gmail.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <niuzhiguo84@gmail.com>,
        <hao_hao.wang@unisoc.com>, <ke.wang@unisoc.com>
Subject: [PATCH v2 0/5] Speed up f2fs truncate
Date: Wed, 30 Oct 2024 18:31:31 +0800
Message-ID: <20241030103136.2874140-1-yi.sun@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 49UAVevu026664

Deleting large files is time-consuming, and a large part
of the time is spent in f2fs_invalidate_blocks()
->down_write(sit_info->sentry_lock) and up_write().

If some blocks are continuous, we can process these blocks
at the same time. This can reduce the number of calls to
the down_write() and the up_write(), thereby improving the
overall speed of doing truncate.

Test steps:
Set the CPU and DDR frequencies to the maximum.
dd if=/dev/random of=./test.txt bs=1M count=100000
sync
rm test.txt

Time Comparison of rm:
original        optimization            ratio
7.17s           3.27s                   54.39%

Yi Sun (5):
  f2fs: blocks need to belong to the same segment when using
    update_sit_entry()
  f2fs: expand f2fs_invalidate_compress_page() to
    f2fs_invalidate_compress_pages_range()
  f2fs: add parameter @len to f2fs_invalidate_internal_cache()
  f2fs: add parameter @len to f2fs_invalidate_blocks()
  f2fs: Optimize f2fs_truncate_data_blocks_range()

 fs/f2fs/compress.c | 11 +++---
 fs/f2fs/data.c     |  2 +-
 fs/f2fs/f2fs.h     | 16 +++++----
 fs/f2fs/file.c     | 78 ++++++++++++++++++++++++++++++++++++++----
 fs/f2fs/gc.c       |  2 +-
 fs/f2fs/node.c     |  4 +--
 fs/f2fs/segment.c  | 84 +++++++++++++++++++++++++++++++++++++++-------
 7 files changed, 161 insertions(+), 36 deletions(-)

-- 
2.25.1


