Return-Path: <linux-kernel+bounces-224001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07686911BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B126A1F25E03
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1923C14D2AC;
	Fri, 21 Jun 2024 06:27:03 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C78158206
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951222; cv=none; b=mCuwjSiR4wdT7KTevUMVohmUbhtRUXy+SKKRfI6Xr1eDFG1U+B94kbaQn5XXgcYcyzXwhEOqkg61xDe+1W/Za+DSkxvLFOJ/w82WelRmSJnMrvdEs4TvKCPgvRiRFcxwMWvo6aC42oxpvHTm9ArcvwySbmx+EbNYcU6VRlCwj0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951222; c=relaxed/simple;
	bh=Rgg13Y1pEPKutlwF3Nz9RL7W3x8cFY8BhqAnKo+5JzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZA/z2qQuEDG8OFDUop/y8XnRT0IHN7K+1FYzB9/dxDtgO/YIm34uG4RUWgU2mDVJGqa5JL4GuG6ggsiFnfaLra0BsnrppO66goE8kT9DQmvbmpWeFubD+eMS/ycmYcVeKkaNcd6KEcWudBkZOwvSQvqy1C1JrXlKzy1+gG+W75E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 45L6QWPL041450;
	Fri, 21 Jun 2024 14:26:32 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4W56hS1zfhz2SFCkm;
	Fri, 21 Jun 2024 14:22:00 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 21 Jun 2024 14:26:30 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <sunyibuaa@gmail.com>, <tj@kernel.org>, <jaegeuk@kernel.org>,
        <chao@kernel.org>
CC: <ebiggers@google.com>, <jiangshanlai@gmail.com>,
        <kent.overstreet@linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <niuzhiguo84@gmail.com>,
        <Hao_hao.Wang@unisoc.com>, <yunlongxing23@gmail.com>
Subject: [PATCH 2/2] f2fs: set f2fs verify work io priority
Date: Fri, 21 Jun 2024 14:26:17 +0800
Message-ID: <20240621062617.595007-3-yi.sun@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240621062617.595007-1-yi.sun@unisoc.com>
References: <20240621062617.595007-1-yi.sun@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 45L6QWPL041450

The io priority of reading the original data of the verity-file
and reading hash blocks during verification should be consistent.
If the io priority is not set, when a high-task-priority process
reads the verity-file, the kworker's io priority may be too low,
resulting in delayed reading of hash blocks, which eventually
causes the high-task-priority process to response slowly.

Signed-off-by: Yi Sun <yi.sun@unisoc.com>
---
 fs/f2fs/data.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b9b0debc6b3d..705a2bdf0848 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -172,6 +172,8 @@ static void f2fs_verify_bio(struct work_struct *work)
 	struct bio *bio = ctx->bio;
 	bool may_have_compressed_pages = (ctx->enabled_steps & STEP_DECOMPRESS);
 
+	may_adjust_work_task_ioprio(work);
+
 	/*
 	 * fsverity_verify_bio() may call readahead() again, and while verity
 	 * will be disabled for this, decryption and/or decompression may still
@@ -204,6 +206,8 @@ static void f2fs_verify_bio(struct work_struct *work)
 	}
 
 	f2fs_finish_read_bio(bio, true);
+
+	restore_work_task_ioprio(work);
 }
 
 /*
@@ -221,6 +225,7 @@ static void f2fs_verify_and_finish_bio(struct bio *bio, bool in_task)
 
 	if (ctx && (ctx->enabled_steps & STEP_VERITY)) {
 		INIT_WORK(&ctx->work, f2fs_verify_bio);
+		set_work_ioprio(&ctx->work, bio->bi_ioprio);
 		fsverity_enqueue_verify_work(&ctx->work);
 	} else {
 		f2fs_finish_read_bio(bio, in_task);
-- 
2.25.1


