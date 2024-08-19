Return-Path: <linux-kernel+bounces-292322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6566A956DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E65286E95
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4512178377;
	Mon, 19 Aug 2024 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BlRc8/Qi"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5989178383
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079375; cv=none; b=JIusz6Ew9X7ql+a0zPr/r1E1JjGvJbUzxMlXzLqmRuoIdOIsMoq8xQ32UK3wNDUjaHOeK2cuVK/55pfcbaPcWamx1C7rA2NhJ0LgF0tRWCYU3zMhNcf+8q7aSR/bdTHmUILtb0cH/V8YDUuW2OYr1GiRucbgLOpsCHYHgdpWTN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079375; c=relaxed/simple;
	bh=GWPj417j8zzHeYmnsGaTHikctCfMEndcS+75h8wmqXc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=TWMHL4GoYbNvWGWWnE+Wd4TghxTluzeKNjXXnb/3Rf0OvxCtF4i+ntrn4qduQcAJuxT2CAQmbrvs1U7cPv2gh+T9EtW634wkxBUkr3Lhv5/3g7wBnu55P4xxxpvZJrY0+Y/9zVdtJ9IFTSvv+G1gdwr9OCo5XPCss+uqkBdp5o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BlRc8/Qi; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724079364; bh=oOn6+C2hQUQF0uGoVQm56ZSL+X2MtgUp158lV4Y0SgA=;
	h=From:To:Cc:Subject:Date;
	b=BlRc8/Qil9stAK3JclXZ4RSE0V0I/PBzbfODqTZ6u6CxtfuBpQ6M9CLt1kBVvQ6Gn
	 fWUsKUG7RM+FirU9BfeEKrybUqMH+O7JJzX/oIr/epFK0yoH5Mgo8aMbMBxXXHT4fL
	 zzvmpRdT3z4XxGghPx0MfCWvtfGzQ5nyToYE7COk=
Received: from localhost.localdomain ([112.64.14.141])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id D9334C54; Mon, 19 Aug 2024 22:54:19 +0800
X-QQ-mid: xmsmtpt1724079259tzjn25qdr
Message-ID: <tencent_65B128564B40DAFEBCBF06F8E2011BC32407@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznFa8nw2ZJtee8WuQcQdZ1eDyoJ+1xBxhPLUG+CglSkUgcCxQ5s6
	 dTP/z/8UUee9oVpNiDrVYug9WO4H4X7/NGD+7ZI0RpMXyr87/zIcjJuzZb4Mg3PFWt2SDzGzhWe0
	 tfhC6S4+QGyWV03ecWmHecQsu9IQImfPSnjO8Jad5CLDXicTL8pcfp6zVYQVXdj+43UgcPESEvRH
	 X2Tftx+h6GA/usF7sOKz5XzLTzNHrjzA3BqkNN2nkQC5nJNb3TFtm+XjY8qzBWzXYI8DU/HFw920
	 jupo7xycNIPbQHMEmetkm7YBe/JhYOrJnfYOAdZ2e//XQqtxUfA9jmKdh7XhlPjdVZ1R9sfLEM7r
	 9Qw1cCM67FGQ+xRC1kzTc7A0h+ldvo+0hn79QT39I7dK67NeiUgiTKOVdZax3zrWLwETTn0+urP6
	 gCQdbbdwx/SAHbatHAeFXkiN3+uYLKEWQZqmej84tQxsrD6DMomiSl9JyiGDneT50AELWxASm5TX
	 JFKIVVDcrcbBVXasigIg2rsdVjmLOIwTRLb4mA7a8yhx2VPlwJ8d7TvuqEYT/BEvKCPWHaijggoa
	 kHPA/tgM+r3vq97mhjH14MMhnGmwKCVFBTt5waBvigaS7e/lTiU1M8D7GiPo/Qm38XoZXmNWdg3P
	 tfowO/phKsNEov2hzfaomR79YEvXTxLwq0sa1iZYn6K377QkRImOwUr5tn+i3hMs9BB1Wun2sUNv
	 DrAp0Mdk+fhJQkbmP20Mz6n+srLNDQDL0vXRe+EMrS7FED7Q/IcoPAbfMyk6eVEJA3NH4lju+uBO
	 51z2x8iTPh7yPQXC7tAxjtUVd3HDtyRjcB2qN4EPHmtKbK3pUFwad1zgyZU9wFdQ242DScQmpt31
	 ktY0OfXxNIo0jl5zTN5RdXczd5oRxiVGeik4ueqWnKMmo/BK8hvlggzUy1iJikaP1u7ZV0RF2URL
	 jqso4GFuiKJH9zea7MrGAClyzQXCrN1qB2SH5mWqPy5VWREGbr628YIo8hLiKYwk39NUVjETocPE
	 +1fyIDaRJN0JGLC/gh
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: jiping huang <huangjiping95@qq.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	jiping huang <huangjiping95@qq.com>
Subject: [PATCH] mm: Avoid a risk of null pointer.
Date: Mon, 19 Aug 2024 22:54:16 +0800
X-OQ-MSGID: <20240819145416.1504-1-huangjiping95@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a probability that we will get a null pointer when we use
find_vm() interface.

Signed-off-by: jiping huang <huangjiping95@qq.com>

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index aec756ae5637..a0bcc1865c62 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1079,6 +1079,11 @@ static long migrate_to_node(struct mm_struct *mm, int source, int dest,
 	mmap_read_lock(mm);
 	vma = find_vma(mm, 0);
 
+	if (!vma) {
+		mmap_read_unlock(mm);
+		return -EFAULT;
+	}
+
 	/*
 	 * This does not migrate the range, but isolates all pages that
 	 * need migration.  Between passing in the full user address
-- 
2.34.1


