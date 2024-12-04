Return-Path: <linux-kernel+bounces-431462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 735C79E3EBE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FE0DB2D766
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADD720B1F3;
	Wed,  4 Dec 2024 15:03:31 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA70433C4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733324611; cv=none; b=LKzx6D4JGnz2XQOKRogQWCnbLjb3MDGdv+SI1qijtoijkCGVv3HcJ7ZJjyZVehQIs/ND5zmtXvfUQkc6xD6JDFEWe8GtFaVnWANkCGMoboxHSdomp9HeAlmPNE2bFBRyAmMekg60xMvf4L02Lazm4mIjCwY1BFN0IST0vdBDYXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733324611; c=relaxed/simple;
	bh=P5AN3f+KRpsmJfLXfOUE5d+wj8rAauS6H3U1vUW0Ybc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BWvSRHnlV4H070JdSowI+fik+ihPV3VXEcoewIGPKCQBgg+L42nKdm6PT85x6aUEVTLGzJ9UInKtT16X0Zs7eGLLoQBWBxGVWGhAzFOze/kbJb5nvbqCPFW3u8dphrd5bnmZ7NCRtjffRsJNs/VmE5sSRrgdHJkGJyQwBgvOEXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee567506f3c58c-cd5a3;
	Wed, 04 Dec 2024 23:03:24 +0800 (CST)
X-RM-TRANSID:2ee567506f3c58c-cd5a3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from 192.168.28.197 (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee567506f38ad6-71897;
	Wed, 04 Dec 2024 23:03:23 +0800 (CST)
X-RM-TRANSID:2ee567506f38ad6-71897
From: liujing <liujing@cmss.chinamobile.com>
To: w.d.hubbs@gmail.com,
	chris@the-brannons.com,
	kirk@reisers.ca,
	samuel.thibault@ens-lyon.org,
	masahiroy@kernel.org
Cc: nicolas@fjasle.eu,
	speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] speakup: Fix the wrong format specifier
Date: Wed,  4 Dec 2024 23:03:03 +0800
Message-Id: <20241204150303.8219-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make a minor change to eliminate a static checker warning. The type
of '(unsigned int)kp[i]' is unsigned int, so the correct format specifier should be
%u instead of %d.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/drivers/accessibility/speakup/genmap.c b/drivers/accessibility/speakup/genmap.c
index 0882bab10fb8..9bd78e1f023b 100644
--- a/drivers/accessibility/speakup/genmap.c
+++ b/drivers/accessibility/speakup/genmap.c
@@ -153,7 +153,7 @@ main(int argc, char *argv[])
 			continue;
 		printf("\n\t%d,", lc);
 		for (i = 0; i < max_states; i++)
-			printf(" %d,", (unsigned int)kp[i]);
+			printf(" %u,", (unsigned int)kp[i]);
 	}
 	printf("\n\t0, %d\n", map_ver);
 
-- 
2.27.0




