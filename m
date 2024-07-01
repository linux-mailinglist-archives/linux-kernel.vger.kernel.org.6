Return-Path: <linux-kernel+bounces-235769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83DD91D96F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828EB283BCE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4776678C63;
	Mon,  1 Jul 2024 07:52:32 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7AC5464A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719820351; cv=none; b=iOFMPggIfUp06c1DJlG0YmL3WsVptmb63dPwccrSPJr2idzOBrrqwhGXBDsRohdDkCfgGOCp0/g0dAveCZ43ouPsE1281nYtjuOn5Lkd8D3e4D/Fwk7asiroJjy4WsCI7KGz/v16nB5cQpzZ4PfDKKD7o6KVxFitTMMbqGrCg/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719820351; c=relaxed/simple;
	bh=/ryUKJdqaZfPKcS/2355ZyYtgwBGnJCoq926DFbJbv0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GU3NLzazOf2M+0cUyWxPaevoL3JBp/Fup5IxAg2gagZLisLdfN/IRcYgS6Dnvmr/0tLoM3AnoF6maVpSnOs5/H/dfqOEtth9+aH5b+2S16PLxW6rZ8ozed1mpjtUkMCqYi+38nrunhlpktraq0P3nkecLA8X6QJus6NFeNWsIfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4617pgek064460;
	Mon, 1 Jul 2024 15:51:42 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WCJ5k4V8Vz2KKCbl;
	Mon,  1 Jul 2024 15:46:50 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 1 Jul 2024 15:51:40 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <sunyibuaa@gmail.com>, <tj@kernel.org>, <jiangshanlai@gmail.com>,
        <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <ebiggers@google.com>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <kent.overstreet@linux.dev>,
        <niuzhiguo84@gmail.com>, <Hao_hao.Wang@unisoc.com>,
        <yunlongxing23@gmail.com>, <yi.sun@unisoc.com>
Subject: [PATCH v2 0/2] new struct io_work and use it in f2fs fsverity work
Date: Mon, 1 Jul 2024 15:51:36 +0800
Message-ID: <20240701075138.1144575-1-yi.sun@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 4617pgek064460

Many works will go to submit_bio(). In many cases, the default
io priority of kworker cannot meet the real-time requirements of
the work. Such as f2fs_verify_bio work.

If a high-task-priority process reads the verity-file, it is
possible that the high-task-priority process will be slowly
because the kworker's io priority is too low.

A new work struct containing io priority can solve this problem.

Yi Sun (2):
  workqueue: new struct io_work
  f2fs: set io priority for fsverity work

 fs/f2fs/data.c            | 17 +++++++------
 fs/f2fs/f2fs.h            |  1 +
 fs/f2fs/verity.c          |  5 ++++
 include/linux/workqueue.h | 47 ++++++++++++++++++++++++++++++++++++
 kernel/workqueue.c        | 50 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 113 insertions(+), 7 deletions(-)

-- 
2.25.1


