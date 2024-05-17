Return-Path: <linux-kernel+bounces-181949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAECB8C8403
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A269B2247A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219C528DB7;
	Fri, 17 May 2024 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="akXQueg0"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4ED18C05
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715938932; cv=none; b=jRFrDQzdPSkrpYdSiEgA+1bbUHTlENTwGkVIpEUOt7vLj/IDjQYgYDYHkhwjSHcDivsoOphs6Ht1ODUJVys8jQUdHnSWzRXoKHb6hZLlhIqfYKBT6hpUHZYrb9WmASGt7BZBdVCEg1fia1+LLcEGOcsysUA9WIWsXq4dPLnjY6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715938932; c=relaxed/simple;
	bh=IVvnRV6hnYHhtVXXcf/vgiezSElLbioCWLuRkoRmcHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iqyxm2ZM79NqIskIGuOAo5GU8UT0Idv33jYD+JOD3wzg0h2BmRWfERjjY2LNqXfE+sbRR0UAhiHJy/eHgcZ9wGpbUTcFuR6uw9cW8oV3RtG94DS+s0kHJE6sEbIgZAjMOJaPPAkS/24NXjgagQZfNRfNll+6QVPfxPEN/1t3lEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=akXQueg0; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715938921; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QgYHiA2D/PhDXSmwX2QgWvfRzxnp5N5zSE4/nZm4IEY=;
	b=akXQueg0O3mCXtuf5NW0AGO8Eok8AGrDfrrZttTL56KbnRu7G/M7JIGbT5t2PmZHd+VkFd0QlxGMWr4BrGhecYXlxsr2iR+0Te7ZhvTaeTsy8c56UXC13n73y8BTcJu6Rfs/LhEOkkafyZqdLrPq5mBgT7pwjYSdv19MiAmjEGU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W6eF4EW_1715938910;
Received: from j66c13357.sqa.eu95.tbsite.net(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0W6eF4EW_1715938910)
          by smtp.aliyun-inc.com;
          Fri, 17 May 2024 17:42:01 +0800
From: Ferry Meng <mengferry@linux.alibaba.com>
To: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	ocfs2-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Ferry Meng <mengferry@linux.alibaba.com>
Subject: [PATCH v2 0/2] ocfs2: add checks in ocfs2_xattr_find_entry() to avoid potential out-of-bound access.
Date: Fri, 17 May 2024 17:41:45 +0800
Message-Id: <20240517094147.87133-1-mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, all:

This patch series attempts to address a scenario where accessing user-defined
xattrs in a carefully crafted image can lead to out-of-bound access.(To speak
truthfully, I do not think this vehavior would occur under proper usage.)

In my testing environment, I constructed an OCFS2 image, created a file with
several user-defined xattrs(long name attributes, this will cause a "Non-INLINE"
xattr, which requires additional space for storage), and then forcibly modified
the xe_name_offset using a binary editing tool (e.g "hexedit"). Upon remounting
the image and running 'getfattr -d /path/to/file', this patchset was able to 
detect "partial" malicious modification.

In v2, I make these changes:
- (1/2) use xs->end directly, no need to parse a parameter.
- (2/2) define a local var 'name_offset'.

Ferry Meng (2):
  ocfs2: add bounds checking to ocfs2_xattr_find_entry()
  ocfs2: strict bound check before memcmp in ocfs2_xattr_find_entry()

 fs/ocfs2/xattr.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

-- 
2.32.0.3.g01195cf9f


