Return-Path: <linux-kernel+bounces-200462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A2F8FB05D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6717028142A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEB3144D0E;
	Tue,  4 Jun 2024 10:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="BB6j8MFP"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45E713C67C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717498196; cv=none; b=amTax781CLKPT9qlrHW5jVsrlcmYX8HJQwZrZtjhmF5mTlaacl2UxFFr5Wv3SV4efKFImT5XedtsDDvHVNb/mq7kiyCxUtEc7O5DqSktgdiJ4t8omxZqnqCdmnrShT6RxCGqbXoqzUb6A9uQ0hdfGiMBZgJ+KiSkJwVIgbSqpRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717498196; c=relaxed/simple;
	bh=Dh0JzK0lXzkWe3f8aBs4uDAAXvnYwDB/LG4D6LTFPgw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=aLIHiop6TesJ4nW7dcCetLFFv+UQbgf8Noqyp0o+unAVfcz+/vcoT+bTBB9dvyGVhUVBdPUunalTRFA37B/Z4fMnV0ctyUWmfO6FMR4bVPidMeDBHDHSdFDnxROL/3pHHO7ylskpOKu6fhw2J1kGnHojZpJ96a5GBhMAnUNZyuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=BB6j8MFP; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=emKGznr4V0DNwDnZbL
	ylce4/u/GthEKwTnfDwt4vDCE=; b=BB6j8MFP5Fv95hli9V11jArmhseLDPr5zY
	qVIptYp+xHRgBg1DXDR9tt7/Dkl5Wpyn61gKSK7FwMZseEb2OZMjHjJixK+nwljg
	VM2xCI3AyCES27fQA5Cd1J1l3ExFVz8agbD6LPP3rXSMb2hpLCj0Z4tcxpkorwfw
	MT4uEqLmI=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wDnjxYL8V5mY7QUAA--.8619S2;
	Tue, 04 Jun 2024 18:48:44 +0800 (CST)
From: yangge1116@126.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	baolin.wang@linux.alibaba.com,
	liuzixing@hygon.cn,
	yangge <yangge1116@126.com>
Subject: [PATCH] mm/gup: don't check page lru flag before draining it
Date: Tue,  4 Jun 2024 18:48:41 +0800
Message-Id: <1717498121-20926-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wDnjxYL8V5mY7QUAA--.8619S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrWktw4rXFW7XF1rJrW3GFg_yoWDGFb_Ga
	1Dta48uan8XrZrZa4jg3ySqrZrWasxCr4DGFy5Xr17Aa45Xrn8WF1kAF4ayFWxWw17ZF93
	Wr98ArsxCwn2vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU045lUUUUUU==
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWQrzG2VLajM+uwAAsJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: yangge <yangge1116@126.com>

If a page is added in pagevec, its ref count increases one, remove
the page from pagevec decreases one. Page migration requires the
page is not referenced by others except page mapping. Before
migrating a page, we should try to drain the page from pagevec in
case the page is in it, however, folio_test_lru() is not sufficient
to tell whether the page is in pagevec or not, if the page is in
pagevec, the migration will fail.

Remove the condition and drain lru once to ensure the page is not
referenced by pagevec.

Signed-off-by: yangge <yangge1116@126.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index e17466f..4fa739c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2460,7 +2460,7 @@ static unsigned long collect_longterm_unpinnable_folios(
 			continue;
 		}
 
-		if (!folio_test_lru(folio) && drain_allow) {
+		if (drain_allow) {
 			lru_add_drain_all();
 			drain_allow = false;
 		}
-- 
2.7.4


