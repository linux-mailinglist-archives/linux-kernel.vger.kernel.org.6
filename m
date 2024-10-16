Return-Path: <linux-kernel+bounces-367300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B609A009C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84481C23C2E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D1518BC10;
	Wed, 16 Oct 2024 05:28:38 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4471418BBB7
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 05:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056517; cv=none; b=jI85tCjyoSAPmH8YCBavYgfbR8fAYCpwyPYXeS89ozUzOgJ5h8XzWqfquv59kca1T4RVoXDuZ1HGRG2dmXPIThvUsH+KN1F7Hqc2SCQ2lK77502u8MPS1F8imna2ocmUbWIqFuT02suqJ/TaJwW8guZXnYfxmjVbERy31t0ZSbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056517; c=relaxed/simple;
	bh=2FK4Ilowp8FtEBuwE+I4CP0OstUGKRN+a4IOkivpdio=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dbWfhWeTUvVx52rx3l+F/oIFt50o+yX5p1unIuIJWhtCT6hmA8YyriXHXvc8tZn8Qs6vjhB7GE+Wq55sAP/J+cR5q9qlb0+56wVnUJ4EPAZZlzDBraAwNu2z6jCX1RbnB5c9NuntWVvfUDkl0HpVvf5nW66KMXUgPLb098roivA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 49G5S3G0033818;
	Wed, 16 Oct 2024 13:28:03 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XSzy16Q0Wz2SW4QH;
	Wed, 16 Oct 2024 13:27:53 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 16 Oct 2024 13:28:00 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <chao@kernel.org>
CC: <jaegeuk@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <yi.sun@unisoc.com>,
        <sunyibuaa@gmail.com>, <niuzhiguo84@gmail.com>,
        <hao_hao.wang@unisoc.com>, <ke.wang@unisoc.com>
Subject: [RFC PATCH 0/2] Speed up f2fs truncate
Date: Wed, 16 Oct 2024 13:27:56 +0800
Message-ID: <20241016052758.3400359-1-yi.sun@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 49G5S3G0033818

Deleting large files is time-consuming, and a large part
of the time is spent in f2fs_invalidate_blocks()
->down_write(sit_info->sentry_lock) and up_write().

If some blocks are continuous and belong to the same segment,
we can process these blocks at the same time. This can reduce
the number of calls to the down_write() and the up_write(),
thereby improving the overall speed of doing truncate.

Test steps:
Set the CPU and DDR frequencies to the maximum.
dd if=/dev/random of=./test.txt bs=1M count=100000
sync
rm test.txt

Time Comparison of rm:
original        optimization            ratio
7.17s		3.27s			54.39%

Hi, currently I have only optimized the f2fs doing truncate route,
and other functions using f2fs_invalidate_blocks() are not taken
into consideration. So new function
f2fs_invalidate_compress_pages_range() and
check_f2fs_invalidate_consecutive_blocks() are not general functions.
Is this modification acceptable?

Yi Sun (2):
  f2fs: introduce update_sit_entry_for_release()
  f2fs: introduce f2fs_invalidate_consecutive_blocks() for truncate

 fs/f2fs/compress.c |  14 ++++++
 fs/f2fs/f2fs.h     |   5 ++
 fs/f2fs/file.c     |  34 ++++++++++++-
 fs/f2fs/segment.c  | 116 +++++++++++++++++++++++++++++++--------------
 4 files changed, 133 insertions(+), 36 deletions(-)

-- 
2.25.1


