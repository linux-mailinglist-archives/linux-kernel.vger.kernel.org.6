Return-Path: <linux-kernel+bounces-376296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71609AA2CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C1A1F24CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C42B19DF66;
	Tue, 22 Oct 2024 13:13:52 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8A52BCF8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729602832; cv=none; b=red54rekLDNc5vvx74adPXZ+i5ovSoNsIVbky5rx2fYrX40BKrX+aIBrJENGR4mbEhwz+4lORk1HA4JzhVQH91+Amw6xD+SH6Q3rE426X3qUQJnGekpUTYUsNRwVHNyU496ImJxHI6WfBl7JoRYqX0ewy5N0kXdDlNnJcOusQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729602832; c=relaxed/simple;
	bh=KiW+eNna6EcBKkv0hZQ/VfP0ivwKnwllYKQHBIqxtec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TFr7r3GeH9910axbloEMGUefidR2s1AmC7Za7hLtTHigC/Nj69EtSqU3XQlFqXAQZ+6WUTjIjfrH1ZVpkGTMN7O3G0YGTVQ/rSvTabYkIzODRjLpsjXXjO+9TepFZdmtv1QJaD5CPw4zqr10vgBh5L5rPb5FetQsgxN5Vtqdrhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66717a4fbed5-2f79c;
	Tue, 22 Oct 2024 21:13:39 +0800 (CST)
X-RM-TRANSID:2ee66717a4fbed5-2f79c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46717a502c0c-885fc;
	Tue, 22 Oct 2024 21:13:39 +0800 (CST)
X-RM-TRANSID:2ee46717a502c0c-885fc
From: Liu Jing <liujing@cmss.chinamobile.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] tools/mm: Free the allocated memory
Date: Tue, 22 Oct 2024 09:25:26 +0800
Message-Id: <20241022012526.7597-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comm_str memory needs to be freed if the search_pattern function call fails in get_comm

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>

diff --git a/tools/mm/page_owner_sort.c b/tools/mm/page_owner_sort.c
index e1f264444342..724d024e0756 100644
--- a/tools/mm/page_owner_sort.c
+++ b/tools/mm/page_owner_sort.c
@@ -377,6 +377,7 @@ static char *get_comm(char *buf)
 	if (errno != 0) {
 		if (debug_on)
 			fprintf(stderr, "wrong comm in follow buf:\n%s\n", buf);
+		free (comm_str);
 		return NULL;
 	}
 
-- 
2.27.0




