Return-Path: <linux-kernel+bounces-310520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AC1967DE3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A278B23DE3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 02:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C11F3BB21;
	Mon,  2 Sep 2024 02:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="APEag89X"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06DC38DE5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 02:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244608; cv=none; b=QQIIRiDufjywmk57x/7+7qdXsEvOcnEmd4vZzCCybgL87/MSWz8ACYDjY9S+doD5ZRMm3cnyRNwx6FxkjMMwFFESJb3+37KNXVjopODy69GEoUz/9uSZV+ATWIVCIbaTWMc5MeAFJv2ewKFRRcOmCaEA9yfKDrl7Bfb8zckvVdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244608; c=relaxed/simple;
	bh=/v5+Nj5heAtqiXqJxuumZ0IQx01iQfXW6VTPVS7QrSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=grieyo2UVP3qcUgLuO5Gat9ZuOR0ukmGxOv0bjFw5w4BiscBsnMnIVHt1p2E0kU6Vl4bwfOQP0pWAnT82dKlcB6DX9wqFE1mGjTu+EH2ttf1gio8IWlhlS8gqFrDEOFMQs3l98YFNs+bR4AdM1kTvF9Xtr23x/NIaEl8fHfgL0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=APEag89X; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725244597; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ChehcMT61sXTyQ7rRVqr54vujGM9pbYTlJ0+I2dxfp8=;
	b=APEag89XxBLScJ5CmSFapAh/+BZXXSnMquct4qr7J+ldP3HMTDQr9p25GbOOXTxOs+BGxmWm6pxHa6Hum1px3SuwgTiBbvCEEzsk9h5dY16Rnl11hQz/YqIGZ4BgXBUaxvSBOgbQTphJv0rJj7z+L7r495qfMxldag2XCo7jw/Y=
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WE1gx-G_1725244596)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 10:36:37 +0800
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Lizhi Xu <lizhi.xu@windriver.com>,
	Heming Zhao <heming.zhao@suse.com>
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jlbec@evilplan.org,
	mark@fasheh.com,
	syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH v5 RESEND 0/2] Misc fixes for ocfs2_read_blocks
Date: Mon,  2 Sep 2024 10:36:34 +0800
Message-Id: <20240902023636.1843422-1-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains 2 fixes for ocfs2_read_blocks().
The first patch fix the issue reported by syzbot, which detects bad
unlock balance in ocfs2_read_blocks().
The second patch fix an issue reported by Heming Zhao when reviewing
above fix.

Lizhi Xu (2):
  ocfs2: remove unreasonable unlock in ocfs2_read_blocks
  ocfs2: Fix possible null-ptr-deref in ocfs2_set_buffer_uptodate

 fs/ocfs2/buffer_head_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.39.3


