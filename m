Return-Path: <linux-kernel+bounces-403780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB489C3AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBFD1C21884
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E9A15A86B;
	Mon, 11 Nov 2024 09:19:59 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BE115B135
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731316798; cv=none; b=tPUtosWYI/OAyOIKrGNjD7a61/VLYwiuV8RttLZqMaxNOqpE+6hegJaKfRfEJQwRhFFGfv2snFgSmkkrTsDkDorWUxUN2vvDMAXugHsfZwGovxHHW2KzQjZ8V/cQSDwuIfseAtum8C0tqLmWCjRix3D/eE+6UjrLMzQ11lL648M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731316798; c=relaxed/simple;
	bh=RhAf6YII2bAh3VkGVugE0oxhJ5s2i2DqVY98QNkfo8k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=aCQxMjv19+mnc4zNF/+fw6yT9Omi6y0/PIX3yqmmIXHOGs0rdM3TwfYJ5G0r47VyziARYARGVR8FNQV9asLTknHAp0hR6y2eeP/HtJxIW21FA8sAFcXCfmVbWP2lY1tNpM/0eKi2kdWdjvNpRXvOX+zUdnK45nDMuwzgXNS9tro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36731cc3840e-d3c34;
	Mon, 11 Nov 2024 17:19:52 +0800 (CST)
X-RM-TRANSID:2ee36731cc3840e-d3c34
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36731cc37173-233df;
	Mon, 11 Nov 2024 17:19:52 +0800 (CST)
X-RM-TRANSID:2ee36731cc37173-233df
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: arnd@arndb.de
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] misc: Fix the wrong format specifier
Date: Mon, 11 Nov 2024 01:19:50 -0800
Message-Id: <20241111091950.4299-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The format specifier of "unsigned long int" in sprintf() should be "%lu", not
"%ld".

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 drivers/misc/isl29020.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/isl29020.c b/drivers/misc/isl29020.c
index 1643ba2ff964..c288aeec16c0 100644
--- a/drivers/misc/isl29020.c
+++ b/drivers/misc/isl29020.c
@@ -68,7 +68,7 @@ static ssize_t als_lux_input_data_show(struct device *dev,
 	if (val < 0)
 		return val;
 	lux = ((((1 << (2 * (val & 3))))*1000) * ret_val) / 65536;
-	return sprintf(buf, "%ld\n", lux);
+	return sprintf(buf, "%lu\n", lux);
 }
 
 static ssize_t als_sensing_range_store(struct device *dev,
-- 
2.17.1




