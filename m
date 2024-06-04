Return-Path: <linux-kernel+bounces-200247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFD28FAD85
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B716D1F2334C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C410C142652;
	Tue,  4 Jun 2024 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="KXH20xxd"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEEA13C672
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717489560; cv=none; b=BZLxovANV6pBzg3PjcbjBBUVMdI0UxFXS7kKPwggqexNi3h+021MJDif2g4+7lIj+/SF4X5oLJsqARS/JoxoEEif5EPcwui3aFXhe45UcuJhHW+Jcl/lH9w85/OhXThf4fVKmET9i+ZtPQjMF+deaK0xj15VerFwoihHFcW9W6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717489560; c=relaxed/simple;
	bh=Lsvp21eluqUR+nNFHRgYZYvdJf0Ss2HATtMd4tk741I=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ky2r1b5dmn7MwUzPKyGVbFTEElTjEay///pvzK2uIfPHnT7d2eHsO5TQITt+5WMSMQTrTIdIlttsp7ifiok80o1wvNcDO/i149mCsiwaT14xm34aIKnKVOK5pf+M2ZZf+UGoS2oTVDOJUqxmA1y/NiIgyJW0I1pPE0235zzKELM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=KXH20xxd; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=L6lmGhh2mmH9xiMqt/
	TccnGyxfRKcpMSgbXuk5MLT+c=; b=KXH20xxdlPbAqmmc+zexY21DZlYu5xUzmj
	+7M48wxoBSlKKmfmNPAWcPDRsZVD8NGvQ1eUefvPXKECDWUlo2bBY/QJN/nBt6+e
	xVIEcp2KKW6tgceg+Rbyj3V/UO4v1i+aJVkAKfp3Q16mMrwdSYnEuWqtXdcZWLCR
	91vxGLnL4=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [118.242.3.34])
	by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wBHh0S5y15mXcy4Cw--.308S2;
	Tue, 04 Jun 2024 16:09:29 +0800 (CST)
From: yangge1116@126.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	baolin.wang@linux.alibaba.com,
	liuzixing@hygon.cn,
	yangge <yangge1116@126.com>
Subject: [PATCH] mm/gup: don't check page lru flag before draining it
Date: Tue,  4 Jun 2024 16:09:11 +0800
Message-Id: <1717488551-18053-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wBHh0S5y15mXcy4Cw--.308S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrWktw4rXFW7Gw18ArW5Wrg_yoWDGFb_Ga
	1DtFy8uan8XrZxZFyY93ySqrZrWasxCr4DGFy5Xr12ya45Xrn8WF1kAF43tFWxWw12vF9a
	gry5ArsxCwn2vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8g6pJUUUUU==
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWQXzG2VLajBwFQAAsl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: yangge <yangge1116@126.com>

If a page is added in pagevec, its ref count increases one, remove
the page from pagevec decreases one. Page migration requires the
page is not referrened by others except page mapping. Before
migrating a page, we should try to drain the page from pagevec in
case the page is in it, however, folio_test_lru() is not sufficient
to tell whether the page is in pagevec or not, if the page is in
pagevec, the migration will fail.

Remove the condition and drain lru once to ensure the page is not
referrenced by pagevec.

Signed-off-by: yangge <yangge1116@126.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index ca0f5ce..890dcbc 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2411,7 +2411,7 @@ static unsigned long collect_longterm_unpinnable_pages(
 			continue;
 		}
 
-		if (!folio_test_lru(folio) && drain_allow) {
+		if (drain_allow) {
 			lru_add_drain_all();
 			drain_allow = false;
 		}
-- 
2.7.4


