Return-Path: <linux-kernel+bounces-358128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E9B997A81
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBC01F23E90
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B802A3A1BF;
	Thu, 10 Oct 2024 02:18:56 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB422BA3F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728526736; cv=none; b=K1npI4DNeHdVI7kSXKfLzHuGW2lY3OlUq4XWV8iuow0nKzIyUG54G7fO4Gi4IDm7hAyoBoT1GXgPb5AlD08WOEEjN4DeiFm/ijPi3d8f81Ixe/kQzg0h7qZbUI3jQTwTvuAVfP7RKdt2T5l8pPnKjTCqRYccdepRtdXtBai+AUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728526736; c=relaxed/simple;
	bh=H0GPgm/dq9wZFdjKf45P5ehiUNnwu4cv8a7qqYfvKK0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ojkCVYWB3H930WL98UrsGfaI1QadbrD5hkLcPrfGI68abLSGqnKWhZvV0JBYNoMbTVvPXW50hKfn9TaPVdZQHW6RjStuREnRkNCI9ST5YdVJlbFVzrbEBMYOQXbJGh0dxJJioMqcTdboMjPEHNnN3v5g6LhoWMTFp3Ew4L/XjVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee267073989833-27848;
	Thu, 10 Oct 2024 10:18:50 +0800 (CST)
X-RM-TRANSID:2ee267073989833-27848
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee467073988090-25a8f;
	Thu, 10 Oct 2024 10:18:49 +0800 (CST)
X-RM-TRANSID:2ee467073988090-25a8f
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: linux-kernel@vger.kernel.org
Cc: zhujun2@cmss.chinamobile.com
Subject: [PATCH] samples: connector: Ensure socket is closed after message sending
Date: Wed,  9 Oct 2024 19:18:48 -0700
Message-Id: <20241010021848.3157-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Added a call to close(s) at the end of the message sending loop
in main function.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 samples/connector/ucon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/connector/ucon.c b/samples/connector/ucon.c
index fa17f864200e..4934a95622d0 100644
--- a/samples/connector/ucon.c
+++ b/samples/connector/ucon.c
@@ -181,6 +181,7 @@ int main(int argc, char *argv[])
 			ulog("%d messages have been sent to %08x.%08x.\n", i, data->id.idx, data->id.val);
 		}
 
+		close(s);
 		return 0;
 	}
 
-- 
2.17.1




