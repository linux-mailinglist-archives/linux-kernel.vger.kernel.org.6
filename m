Return-Path: <linux-kernel+bounces-179917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D1D8C6765
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D051C217B9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 13:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC84812A14C;
	Wed, 15 May 2024 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kZC3RbZF"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7D2127E12
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715779801; cv=none; b=qmUWHH1QL+LY+vveBiSzL6YTYbPVEP8xLE9VKHp8Ct1zQvyiFE4GY/tkzZQXo/fe8LhCNRGojNXOJ34ZFb1znQO93tpwXoLNSqHhpKWb3kpwbUeKzY8EJQ76MIv2+zxTABh7aHQ1vean1+T4Saz3ihwrXDJ3gjVRW61RZ/9gD6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715779801; c=relaxed/simple;
	bh=mkKjpPpuGEd4/WEi+kqlcv0kfuYm/u5RzqJD/2y2c7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u6etoMGRXtajYNYnaj66rROBNvlzpfreBK3K4tcGM2I5hJhdpdKbYtahQ9iDZiyFlZ3Aa1CukhgckwBkQoqVYuoW7m6UtWEGG5cB6f0cw2Dp9KsZxHYex3Ouc7kkSpH+Qwmw0yJ4Nvr254h7y87MxRP9x756AfGrnuPLW49YMvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kZC3RbZF; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715779791; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=YOi4tDk8CK2U3Nzvqq2F2lyNfJlKybMBPqcVB0ycB68=;
	b=kZC3RbZFslVMWf3Ld/HrBcoWKi8PLU5Vy5R7wo56KPUQA/zP7z6wQSPKRM7hwNuCivYlDOE6fNQsAjMLFG8FZebZSxs8/SOZ6NrbyxT5b/sGnGn7RCoVpLKM0vloGyibp3xrOL2IYcG4V6JtjxBAWewD4pdUL81UArqkoGACtQc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W6YDIG7_1715779788;
Received: from j66c13357.sqa.eu95.tbsite.net(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0W6YDIG7_1715779788)
          by smtp.aliyun-inc.com;
          Wed, 15 May 2024 21:29:50 +0800
From: Ferry Meng <mengferry@linux.alibaba.com>
To: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	ocfs2-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Ferry Meng <mengferry@linux.alibaba.com>
Subject: [PATCH 2/2] ocfs2: strict bound check before memcmp in ocfs2_xattr_find_entry()
Date: Wed, 15 May 2024 21:29:34 +0800
Message-Id: <20240515132934.69511-3-mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240515132934.69511-1-mengferry@linux.alibaba.com>
References: <20240515132934.69511-1-mengferry@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xattr in ocfs2 maybe not INLINE, but saved with additional space
requested. It's better to check if the memory is out of bound before
memcmp, although this possibility mainly comes from custom poisonous
images.

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
---
 fs/ocfs2/xattr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 37be4a286faf..4ceb0cb4cb71 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -1083,10 +1083,15 @@ static int ocfs2_xattr_find_entry(struct inode *inode, void *end,
 		cmp = name_index - ocfs2_xattr_get_type(entry);
 		if (!cmp)
 			cmp = name_len - entry->xe_name_len;
-		if (!cmp)
+		if (!cmp) {
+			if ((xs->base + le16_to_cpu(entry->xe_name_offset) + name_len) > end) {
+				ocfs2_error(inode->i_sb, "corrupted xattr entries");
+				return -EFSCORRUPTED;
+			}
 			cmp = memcmp(name, (xs->base +
 				     le16_to_cpu(entry->xe_name_offset)),
 				     name_len);
+		}
 		if (cmp == 0)
 			break;
 		entry += 1;
-- 
2.32.0.3.g01195cf9f


