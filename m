Return-Path: <linux-kernel+bounces-533058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCC8A45546
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07B21898430
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012762676DD;
	Wed, 26 Feb 2025 06:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RMm8SUg0"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C008B260A20
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550073; cv=none; b=bQGYR1EpMM8c2emkdmOSwN5wFSoLOjfI0DgfE5RqcBJDuoKCN270Pp146BiFiQd7WjBF5Q+5erPNWBwyUV6UmhKmQ686mMJk8lzVxS6+eswcUJM6FQwJIr4TeHJVumZnqFmngSmmEtssgvDUVy3Xel0Szs2hr9m6jN7EwEvSxLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550073; c=relaxed/simple;
	bh=8k4y1k9uoqfb+mNYhBKVhr39gYXqU/HUdNIc+gDhJpk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uhWhKuM2mCJcYDGyHzOHBqlOiPjTG53JsUY8wSukpIJm5LTXyYIbws4KrXKWoVnV5sH4CO7Tg8cAR00/Q4n/nfj0YCPISRCtRbGn1f3N9e1AHPp4jbN9W1YaVCyOlk4ZOuhViwBG3vEvgcJwGjEuOBIryDvv/kPoM2TFOAuhzy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RMm8SUg0; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740550065; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=wAxArRDxBnjpu2aNqzZ/Asf0HNXmKUNnebF3IwcFNFM=;
	b=RMm8SUg0A/nDxObKfJ4tzG43FIVeff9z14K1P0qL6KzeMwteMkHrLFYUjyx7pcDLs0rDM4C2BoJIlATYYbRBHWcsO8+GDyQPG7OPG9SHiDsCEQ79WGjnS0x6BmHZ1a1OxGn1R81MM2cIXzmodn5pBmLkt0t2Y2zN1YOIjEOHWfY=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WQH-AtE_1740550058 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 26 Feb 2025 14:07:44 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 1/2] staging: gpib: Remove unnecessary print function dev_err()
Date: Wed, 26 Feb 2025 14:07:34 +0800
Message-Id: <20250226060735.7484-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The print function dev_err() is redundant because platform_get_irq()
already prints an error.

./drivers/staging/gpib/eastwood/fluke_gpib.c:1027:2-9: line 1027 is redundant because platform_get_irq() already prints an error.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=19058
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/staging/gpib/eastwood/fluke_gpib.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/staging/gpib/eastwood/fluke_gpib.c
index 731732bd8301..4fd3a6cad0d2 100644
--- a/drivers/staging/gpib/eastwood/fluke_gpib.c
+++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
@@ -1023,10 +1023,9 @@ static int fluke_attach_impl(gpib_board_t *board, const gpib_board_config_t *con
 	}
 
 	irq = platform_get_irq(fluke_gpib_pdev, 0);
-	if (irq < 0) {
-		dev_err(&fluke_gpib_pdev->dev, "failed to obtain IRQ\n");
+	if (irq < 0)
 		return -EBUSY;
-	}
+
 	retval = request_irq(irq, fluke_gpib_interrupt, isr_flags, fluke_gpib_pdev->name, board);
 	if (retval) {
 		dev_err(&fluke_gpib_pdev->dev,
-- 
2.32.0.3.g01195cf9f


