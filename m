Return-Path: <linux-kernel+bounces-379596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1279AE0D4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB762813C5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E001C07D9;
	Thu, 24 Oct 2024 09:30:24 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46371B3922
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762223; cv=none; b=HtoIEFeCqU04NLUptFo5rifKCEjxAFKH3UthDiYC8gD4v/qQ9OmjJNZRLFWN6PtTooXfz/O043l5kkYwdqOCAPSt5jvc/TxUrzcgDtg3Bhps7JRfKCydryUugCgl3wY+/6X9fxjZHJIFyFUUy0fbCpBqTYKuH6s++c/UpnBQpTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762223; c=relaxed/simple;
	bh=XrlQbrMrrU7eqJ4H7oAN38ZAaKV7863YZkDzNXs739U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PA4OuAwec7KSphXkx0eUxD1wcwQyAWh/nOj6ARNnCRrcK3CerKAiV97FHEBidvC2a+Av/X71xnhuSKzz54dHVxEt7KwyTHWAtLWqNx+uY1GRpBNxybe4BgQKaM84QBRwgGhnZ/7AvMSDnX9tnZRkUYHF5I1RyQdM45n4JTh/70A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 49O9T9bL001342;
	Thu, 24 Oct 2024 17:29:09 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XZ0wD1k5Mz2K25Nw;
	Thu, 24 Oct 2024 17:28:44 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 24 Oct 2024 17:29:07 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <Hao_hao.Wang@unisoc.com>
Subject: [PATCH] f2fs-tools: correct some confused desc about unit
Date: Thu, 24 Oct 2024 17:28:54 +0800
Message-ID: <1729762134-380-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 49O9T9bL001342

F2FS_BLKSIZE may be 4KB, 16KB, so use F2FS_BLKSIZE to replace
some hardcode desc about unit in some f2fs_io cmd, also
adjust "-c" parameters in mkfs man, to be consistent with
commit c35fa8cd75ac ("mkfs.f2fs: change -c option description").

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 man/mkfs.f2fs.8         | 2 +-
 tools/f2fs_io/f2fs_io.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
index de885be..8b3b0cc 100644
--- a/man/mkfs.f2fs.8
+++ b/man/mkfs.f2fs.8
@@ -122,7 +122,7 @@ block size matches the page size.
 The default value is 4096.
 .TP
 .BI \-c " device-list"
-Build f2fs with these additional comma separated devices, so that the user can
+Build f2fs with these additional devices, so that the user can
 see all the devices as one big volume.
 Supports up to 7 devices except meta device.
 .TP
diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 95f575f..ee4ed0e 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -1013,7 +1013,7 @@ static void do_randread(int argc, char **argv, const struct cmd_desc *cmd)
 
 #define fiemap_desc "get block address in file"
 #define fiemap_help					\
-"f2fs_io fiemap [offset in 4kb] [count in 4kb] [file_path]\n\n"\
+"f2fs_io fiemap [offset in F2FS_BLKSIZE] [count in F2FS_BLKSIZE] [file_path]\n\n"\
 
 #if defined(HAVE_LINUX_FIEMAP_H) && defined(HAVE_LINUX_FS_H)
 static void do_fiemap(int argc, char **argv, const struct cmd_desc *cmd)
@@ -1617,8 +1617,8 @@ static void do_move_range(int argc, char **argv, const struct cmd_desc *cmd)
 #define gc_range_desc "trigger filesystem gc_range"
 #define gc_range_help "f2fs_io gc_range [sync_mode] [start] [length] [file_path]\n\n"\
 "  sync_mode : 0: asynchronous, 1: synchronous\n"			\
-"  start     : start offset of defragment region, unit: 4kb\n"	\
-"  length    : bytes number of defragment region, unit: 4kb\n"	\
+"  start     : start offset of defragment region, unit: F2FS_BLKSIZE\n"	\
+"  length    : bytes number of defragment region, unit: F2FS_BLKSIZE\n"	\
 
 static void do_gc_range(int argc, char **argv, const struct cmd_desc *cmd)
 {
-- 
1.9.1


