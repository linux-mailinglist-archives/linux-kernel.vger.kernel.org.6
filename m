Return-Path: <linux-kernel+bounces-393253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4A69B9E4F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 10:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127001F22EF6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 09:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B7F170828;
	Sat,  2 Nov 2024 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="I9zQPgRb"
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A516716DEBB;
	Sat,  2 Nov 2024 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730540178; cv=none; b=odJo4cyz7NPbIgENjKDshJKBVZggWR5KG2DYTdyvDexhu+/trsfsTN3CMDStsOA5e8iMJj5zf/KzfA9coZiGBw8N3GXBYR8/L8N5d4WXbxKHPjiwE9FK74jBf5+B6raRNatzlFdNx23+0njCaolCuVSmhzjxyds0bvpB7R/eRvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730540178; c=relaxed/simple;
	bh=CIhGn6JUonAr+sLcF5RR1Wkja2QXg57FxAXUPEtF/4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LPU9KyWhDmno8XaRCBCe0tGldP0OBTR1VKRgf9+NGNpV0Fa9HhUwCqOT/GuKweGy6d5kbwizwonPiHLJJpusNnVOJaOa8E3KXIKUcsc7UVySFpvdGoWg8aszY0RHO8+rO9WKSpTHX5RDQ7NyApxCxnmMhTHcBr27N4UyPx7ylLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=I9zQPgRb; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 7AYBtqJIgpBS87AYBtJqoH; Sat, 02 Nov 2024 10:36:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1730540169;
	bh=NyhZO+p/ZIiZc1HaYQM5EPp9Jxx4qvXRWG7UB7JsmrM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=I9zQPgRboy8/raEXy9Rjy2ghjxUtTxO7MuXDU5tJejgfRT2iwqcMiMnl+mz1EzNQx
	 o6D5KLxv73nNjuD9WmqF1SdDX0hNu4CIEqf7wKRZ8Gfnn2W6+k4zR6O8AU8U5MjAEK
	 AV+BCeg1h3xLK25WQBqoE7Sqfo4CkVj6BeMkNHlNHWicvLPCE+h/YokVrc3fVZQUw9
	 ohZZlD7Iduj6NMRHJYA4RFdOyxpFYVOjBdCfe+bYXx9rn+9tnxoeU5VrtKMhPQW0vZ
	 LSXKRiD3+8Wfhm2LjUhB8vPs6lz3imQ8lBDFjXkfCEx9fUcXucgKUZw7Yx7369/QvZ
	 o5TJHcpoBWIgA==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 02 Nov 2024 10:36:09 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	greybus-dev@lists.linaro.org
Subject: [PATCH] greybus: Fix a typo
Date: Sat,  2 Nov 2024 10:35:56 +0100
Message-ID: <aad9d19c20ea0463974b7652ba7f2f8d9fec1186.1730540152.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/interfce/interface/
A 'a' is missing. Add it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/greybus/interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/greybus/interface.c b/drivers/greybus/interface.c
index d022bfb5e95d..a0f3e9422721 100644
--- a/drivers/greybus/interface.c
+++ b/drivers/greybus/interface.c
@@ -780,7 +780,7 @@ const struct device_type greybus_interface_type = {
  * The position of interface within the Endo is encoded in "interface_id"
  * argument.
  *
- * Returns a pointer to the new interfce or a null pointer if a
+ * Returns a pointer to the new interface or a null pointer if a
  * failure occurs due to memory exhaustion.
  */
 struct gb_interface *gb_interface_create(struct gb_module *module,
-- 
2.47.0


