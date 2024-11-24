Return-Path: <linux-kernel+bounces-420121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9897D9D7547
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 16:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFC7287556
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 15:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BA418FC70;
	Sun, 24 Nov 2024 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jqQiHN9B"
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5341E178378
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732459330; cv=none; b=hyOksBKT+HoJme5+TGBpQkf1iwBBz9XelJJzSPBQ1eYcH1Y4YijCuVnzVOcMdcqwaWeFpUXjBsfhNQKiNVORe5EJUFXxFc95LOPsVQxjXmvWvjh9uFhyxM5iJeMQVWFfqRiqSQ3LwimvYV27CFF9f/rR3QC+45RCZYRN6OdWhQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732459330; c=relaxed/simple;
	bh=JJcJfVETs9OtVreOkeCNeX8E38D/+W63WufqrSiavyA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=gV6ucTyfWX7QnpHce/yKGtipeAIHlQGsKsdRVm/hYgeGysxp522i8aF9SVlqfABnfo2l8MEGWeqPlUfndBp9Nd99tnUvJo/weFEPb1h0E5LT3+AlXqZIJkkIKacepf5zcrcvpEmBh0r5FUcSb+lFzKyJzQsMR3MYQt+XjhLN55U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jqQiHN9B; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1732459019; bh=zQC6NaOKMV7ZIDxq/pvImsHvIGeLGjRZKnaH2HH60ig=;
	h=From:To:Cc:Subject:Date;
	b=jqQiHN9BW2y/z6ufCR5TBGFPXeMYmP+c2xDFol2IPZvXgT7WZfnLHjy1WmGnTAsdI
	 A5L72CMwPuSm2YJ2qnR3Qo9aCLLuLvuPVd7ZsHutsq5XJs6XjEkbCSHraioV+qltqG
	 7GnE2ls8EGQZ7Kl9aLqrqk3JXqPfXUXaK1GEyYn4=
Received: from archlinux-sandisk.localdomain ([220.176.232.51])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 7B02E2C9; Sun, 24 Nov 2024 22:30:48 +0800
X-QQ-mid: xmsmtpt1732458648ta73d9xvs
Message-ID: <tencent_B68357134C27627076BD7E44834D9E2C6D09@qq.com>
X-QQ-XMAILINFO: MwqrwaLzgdebDvba6S6v4Yq9FHRCZSb0C8uoR9YkM3Wa07av6DQc46J76mZ+X0
	 6qY+c//GQ5BtAib0Z8G3iK5yQ5gvxyvZr33nHTXCj25klNSXiKO1ytOWE3CuSMphK7ZU0/dViA5t
	 6jgZNtEYtuclnfZKX3VFO2p+80jK0Z641sYAhqILPNqC7rzRJvFU3W5nhqhWtAEdlBlZyXgJzlDT
	 kzZfu+K4toPezFWLf24E6e80V2ulDipIYF3vJ/zaMUFvH2zgka4f+rYfnMw43FQuAIKNIRzikLu4
	 IAn05NC5aADUuavg1Cz7Ewanm+1pXZiQ3KGLNDNZbyA21Lmuj1pQz9jf8M82rdsOAi+nehSF3wkJ
	 fyIWOQv0MA7KBWXKjNl2EA3UYWmgbWLZ73fl9XDeokS+A5GGq9lZ6f963HON+9L5Zl7EAJqbJvTq
	 ARnKbRpvZmLopljku62TpUPc22iATJq5fcuZpwmcWcPEpgHbqK551VidkEZ8wDl3J+LJn49oN2y7
	 SekVELq5mPMJUXYWSzJ4BCYhzfuk/RGQarkAYnQ1qyBvX4/vy5mtG2FbWTrdjM2L11Q3PyReWJ8t
	 S5GBAmP0JRzpaDzFz8I4VUSWOO7I79KIG1+P6/bYLMz50vpkdfRj/AQo/51DOToKMbs4wjJTLrRO
	 gxM78dQ28OTfrgZwUD82+ScAvJPBx538rn6T+XvlM9OezzMhNgYmyiu9SM1E81wb1tvazSmYV+q6
	 JmmPmSmQ84MXNdJi62Kbg61LuQpIXhIccknP/z0Ko/3QwYBGlVXlg4J50JeDFiQMqCeNCiPksIFK
	 jXg3tLA6cEDx7mamFVAX7dO7s01abkvh85x1KBTdowBgVR9vbIwsQkM7p6fF09LTdTjbo4PE3FJf
	 BeI5Sdy7OesIgpWmaIh57bby3TcN7So3QtTNcsUXD3MtGM8n5eEOc=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Jiale Yang <295107659@qq.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jiale Yang <295107659@qq.com>
Subject: [PATCH] mm: Remove braces for single statement block
Date: Sun, 24 Nov 2024 22:30:36 +0800
X-OQ-MSGID: <20241124143036.1572-1-295107659@qq.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linux kernel coding style say braces are not necessary if a block has
only one statement. So remove it.

Signed-off-by: Jiale Yang <295107659@qq.com>
---
 mm/page_alloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a8cd54c02..4915b5d31 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6877,9 +6877,8 @@ bool put_page_back_buddy(struct page *page)
 
 		ClearPageHWPoisonTakenOff(page);
 		__free_one_page(page, pfn, zone, 0, migratetype, FPI_NONE);
-		if (TestClearPageHWPoison(page)) {
+		if (TestClearPageHWPoison(page))
 			ret = true;
-		}
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
 
-- 
2.47.0


