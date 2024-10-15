Return-Path: <linux-kernel+bounces-365051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB7499DCDB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 05:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 666A9B21EFE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAC0170A1A;
	Tue, 15 Oct 2024 03:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PL60Acov"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59294A3C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728963370; cv=none; b=Jtj+valQKFjrL/tv8pe7pdWmJ0bhmsdVFJBw2Mk7h8L3HBUEU6wLp2hO2sqH2MEStqKT9UodBc3ruxuFa5dCBCYchVbOB0tSAIJUdnJkzR3WBKzMGgBBAzpgZTx7vmeftan6BYXel1ByH3/Ygw92PCG+25fW/UKEjMrA4hIUIaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728963370; c=relaxed/simple;
	bh=2MoicOKn4zhHiXNq+zaJjQeHE1CLIN9RFW8Ycz0pbw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RhTyYr4XcXhqp3qV/siDS7ADrrtCltJYH+wf+N7nZYdmjwwWVja2byTe6Pp7uKyq5ztDMLTlFR7gDINZFgTY6/gs7ReeMe0NVw2iitRG7FJl61LIsm2k8hB6eqJxO/tjSSzr5z46rPsajP2Kb6vWy0Luzu1VznHLGgKvSDdTTGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PL60Acov; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728963364; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=KAnLsh6bLgE9XrlGeHLBUwKUDXPUE2E6PeL04XoPxyM=;
	b=PL60AcovyOiN4psNYi0SdZj4+ebmP9S/IDTYvxcCSCRE7B5Y4NBxexCgRHA5Ryr4WRXal4gL9PUFE7/sI5U98Kn0Ycu3BLmkigK7gsOfmEfSwq+HttWElFmqASZqXc2ICo+1Y2iEw2vMamQfvewFzpFajN8WTXauIko4rhN2Z2Q=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WHBnLfO_1728963363 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 11:36:03 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	Hongzhen Luo <hongzhen@linux.alibaba.com>
Subject: [PATCH] erofs: fix unsupported blksize in fileio mode
Date: Tue, 15 Oct 2024 11:36:01 +0800
Message-ID: <20241015033601.3206952-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fileio mode, when blcksize is not equal to PAGE_SIZE,
erofs will attempt to set the block size of sb->s_bdev,
which will trigger a panic. This patch fixes this.

Fixes: fb176750266a ("erofs: add file-backed mount support")

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/super.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 320d586c3896..a7635e667d4b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -631,6 +631,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 			errorfc(fc, "unsupported blksize for fscache mode");
 			return -EINVAL;
 		}
+		if (erofs_is_fileio_mode(sbi)) {
+			errorfc(fc, "unsupported blksize for fileio mode");
+			return -EINVAL;
+		}
 		if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
 			errorfc(fc, "failed to set erofs blksize");
 			return -EINVAL;
-- 
2.43.5


