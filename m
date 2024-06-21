Return-Path: <linux-kernel+bounces-224000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25570911BAF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51AD21C23B31
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4C3167DA0;
	Fri, 21 Jun 2024 06:27:00 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D0E1420CC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951220; cv=none; b=in0RIgDmLDbPb1l0Yv5bfAyLqLP6JNdNzB0PQcKRS6cIyKw5VFDhmN7BG5JmlpuDvEvR3eUDR7KWTyPT+ZTuCYBloPdRBvyvV1rRgzy5c8Oc61U/ZP6a3sqnTG2ti/n/1Tdo/EXoiRpBHbLbOw5KYGQjifEkc7gM4o/AHm/pp9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951220; c=relaxed/simple;
	bh=IPvwmDA4Z3wPA0wGRZuXEd9aGAohHVS1gYZKNNtFs60=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iiDt8AX2ITuoaD3JEqC5ESsd0bQNemdXj0JKJmLIALoH/Thq6cqIvF/c0B7eIBgBZ78XCoYZRrUIGCNGm9nOIlv+b7kN47DZPJlFL4oA9dt3bMQKluRi3EZ7/mrni2bdODTW1SCQKperXHsiA/JakAllxGuyQPQbvB+zLVDrrbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 45L6QUrP041081;
	Fri, 21 Jun 2024 14:26:30 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4W56hP6fg0z2SFCkm;
	Fri, 21 Jun 2024 14:21:57 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 21 Jun 2024 14:26:27 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <sunyibuaa@gmail.com>, <tj@kernel.org>, <jaegeuk@kernel.org>,
        <chao@kernel.org>
CC: <ebiggers@google.com>, <jiangshanlai@gmail.com>,
        <kent.overstreet@linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <niuzhiguo84@gmail.com>,
        <Hao_hao.Wang@unisoc.com>, <yunlongxing23@gmail.com>
Subject: [PATCH 0/2] add io priority feature to work and use it in f2fs fsverity work
Date: Fri, 21 Jun 2024 14:26:15 +0800
Message-ID: <20240621062617.595007-1-yi.sun@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 45L6QUrP041081

Many works will go to submit_bio(). In many cases, the default
io priority of kworker cannot meet the real-time requirements of
the work. Such as f2fs_verify_bio work.

If a high-task-priority process reads the verity-file, it is likely
that the high-task-priority process will be slowly because the
kworker's io priority is too low.

Patch 1: Provide a set of interfaces for temporarily changing the
io priority of kworker.
Patch 2: Use the interfaces provided in patch1 to temporarily change
the io priority of f2fs_verify_bio work.

Yi Sun (2):
  workqueue: add io priority to work_struct
  f2fs: set f2fs verify work io priority

 fs/f2fs/data.c                  |  5 ++++
 include/linux/workqueue.h       |  9 ++++++
 include/linux/workqueue_types.h |  6 ++++
 kernel/workqueue.c              | 51 +++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+)

-- 
2.25.1


