Return-Path: <linux-kernel+bounces-407167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F709C6994
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE7B283540
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3BC17D36A;
	Wed, 13 Nov 2024 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xjCpvlrp"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BBB175D5D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731481083; cv=none; b=MJGitwP1YjtMPTVCX/OeySQEDzoYhZb0OSKmkWfeOjaXZCCLva1m4ADVfQTSwInewjBFUiXJu9xL8/BZRZ0oJ96RO8GT6k9HUK7lEr0GjLdcBuQ7zHMyyufZR5nHoU7zuNyTjDhCHsIbLOfjlz5eq7EwggOhfrN552bUk2/QfaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731481083; c=relaxed/simple;
	bh=2LyT2ytOHpI56gVOhi30JOWQoaaKXwzedoqfM6TX8WM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DLI5PA71fAMamg9BWQmGjgfgEqW5QzGee2RpGT2JCuKc+rLoYJdN3FeHucf9ZWxUpkslagRWHw5qLIHr3P4s4/sJHw9K0fBobskPRlgRQXAMyV/iQ5t5V0/5rxeOwctU2xz5pcNe/snMcBAahvzZGeXUqJUHLsjzPaplnjyYjOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xjCpvlrp; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731481072; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=oqsze9NznjQ0CsDYvscc1QQzoVPJPLXccLE0cyDkLNM=;
	b=xjCpvlrpSpk5a45akjKFKp8QFMinaQByCCiNwwOKdYJwZmP6jtGHV5ndLigwsRq85IFhM6CU0elpHc5w4EEvn8M7WbabWfX971MpxccxJMx01mZe2DVzVaH/Cmvn5Y8bs3nac/58aVRhJJHuBYI7KjkupvX8Nkx3amfCrq37u4g=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WJK5KpL_1731481070 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 Nov 2024 14:57:50 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: baolin.wang@linux.alibaba.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	da.gomez@samsung.com,
	david@redhat.com,
	hughd@google.com,
	ioworker0@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org
Subject: [PATCH] docs: tmpfs: update the huge folios policy for tmpfs and shmem fix
Date: Wed, 13 Nov 2024 14:57:46 +0800
Message-Id: <45509f49416849e6708a4fd57c988b8b0921210a.1731480582.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <c6a2085278292be8ccc24635ad75b0a59f3cd7dd.1731397290.git.baolin.wang@linux.alibaba.com>
References: <c6a2085278292be8ccc24635ad75b0a59f3cd7dd.1731397290.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop 'fadvise()' from the doc, since fadvise() has no HUGEPAGE advise
currently.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index ba6edff728ed..333958ef0d5f 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -382,10 +382,10 @@ never
 
 within_size
     Only allocate huge page if it will be fully within i_size.
-    Also respect fadvise()/madvise() hints;
+    Also respect madvise() hints;
 
 advise
-    Only allocate huge pages if requested with fadvise()/madvise();
+    Only allocate huge pages if requested with madvise();
 
 Remember, that the kernel may use huge pages of all available sizes, and
 that no fine control as for the internal tmpfs mount is available.
@@ -438,10 +438,10 @@ never
 
 within_size
     Only allocate <size> huge page if it will be fully within i_size.
-    Also respect fadvise()/madvise() hints;
+    Also respect madvise() hints;
 
 advise
-    Only allocate <size> huge pages if requested with fadvise()/madvise();
+    Only allocate <size> huge pages if requested with madvise();
 
 Need of application restart
 ===========================
-- 
2.39.3


