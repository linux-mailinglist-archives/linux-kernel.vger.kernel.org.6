Return-Path: <linux-kernel+bounces-220544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B66A90E382
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3972841EB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DED6F2FA;
	Wed, 19 Jun 2024 06:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="Fxv1iIJ4"
Received: from mail02.habana.ai (habanamailrelay02.habana.ai [62.90.112.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A1B2582
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.90.112.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718778889; cv=none; b=HqbhW1c3+IecBGZRvRfVEZIC18QFJM9pWlYDuOIhNPKEB0x8eWmHdMBb9cOPi0S6uNnlVRg0xC+crnKhcamgM8Ub1sY1fZee9Eodce0kZc+mOG9/6Yflze5LZEHDbvi+9rBERIq7jNCuD3VOLmHvn7nAWK6iwvQxA6PA/tjnqlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718778889; c=relaxed/simple;
	bh=7oYiZeDx+fTfe10HbMzhX8OPBVI3EpolpvrHlGHSnw4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=r6PdR6pjvOjW02AkmHRreVJo9UF9rDStZ8jbHw+1AwoDqdUNWf10wTo9QYRqu7OILYUMdzkQkYtvc9S+U3lFNp7i/DAVtTmvEna+XF2X6r6n4GXZzPCHXMOcZnxbw00vipu/Gz0bpw7X0rFYtRLdZg7Dkc0oPBkjuB6cd8lX9FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=Fxv1iIJ4; arc=none smtp.client-ip=62.90.112.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1718778876; bh=7oYiZeDx+fTfe10HbMzhX8OPBVI3EpolpvrHlGHSnw4=;
	h=From:To:Subject:Date:From;
	b=Fxv1iIJ4pkR2dIjIynHvrT4ANRzILengTWF9k3ehg2v9UvVrBb4muC/5+wXa1mc+D
	 6vmTnwH5PcQ7aGiya32rfuT0wRbm4dez38+ZF9q+Vt180ZEU2PAy0VT5IqSBtzwYOe
	 w4n215l7cErbm+9v9hh3Zbx4DFIgh8QiYdnxoq9HLWiKbIbhHvRz1e4EpE6mtemP5N
	 DgAv1F5V9/jiFKO2uby7KlsNAzwF/NJRXOXFZW0L7vM9woUbZ2K7TSEou3tjbIbgVN
	 z9QUGK/kJQpNw5KHvuCxcnaXI2gCBjLhrFoQrPbexb79TwJi9asc9VsEJEzRL4duUJ
	 SzAg+Xje7kr6A==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 45J6YQB11377354;
	Wed, 19 Jun 2024 09:34:26 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] accel/habanalbs/gaudi2: reduce interrupt count to 128
Date: Wed, 19 Jun 2024 09:34:17 +0300
Message-Id: <20240619063425.1377327-1-obitton@habana.ai>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some systems allow a maximum number of 128 MSI-X interrupts.
Hence we reduce the interrupt count to 128 instead of 512.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
---
 drivers/accel/habanalabs/gaudi2/gaudi2P.h        | 8 ++++----
 drivers/accel/habanalabs/include/gaudi2/gaudi2.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2P.h b/drivers/accel/habanalabs/gaudi2/gaudi2P.h
index eee41387b269..05117272cac7 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2P.h
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2P.h
@@ -384,7 +384,7 @@ enum gaudi2_edma_id {
 /* User interrupt count is aligned with HW CQ count.
  * We have 64 CQ's per dcore, CQ0 in dcore 0 is reserved for legacy mode
  */
-#define GAUDI2_NUM_USER_INTERRUPTS 255
+#define GAUDI2_NUM_USER_INTERRUPTS 64
 #define GAUDI2_NUM_RESERVED_INTERRUPTS 1
 #define GAUDI2_TOTAL_USER_INTERRUPTS (GAUDI2_NUM_USER_INTERRUPTS + GAUDI2_NUM_RESERVED_INTERRUPTS)
 
@@ -416,11 +416,11 @@ enum gaudi2_irq_num {
 	GAUDI2_IRQ_NUM_NIC_PORT_LAST = (GAUDI2_IRQ_NUM_NIC_PORT_FIRST + NIC_NUMBER_OF_PORTS - 1),
 	GAUDI2_IRQ_NUM_TPC_ASSERT,
 	GAUDI2_IRQ_NUM_EQ_ERROR,
+	GAUDI2_IRQ_NUM_USER_FIRST,
+	GAUDI2_IRQ_NUM_USER_LAST = (GAUDI2_IRQ_NUM_USER_FIRST + GAUDI2_NUM_USER_INTERRUPTS - 1),
 	GAUDI2_IRQ_NUM_RESERVED_FIRST,
-	GAUDI2_IRQ_NUM_RESERVED_LAST = (GAUDI2_MSIX_ENTRIES - GAUDI2_TOTAL_USER_INTERRUPTS - 1),
+	GAUDI2_IRQ_NUM_RESERVED_LAST = (GAUDI2_MSIX_ENTRIES - GAUDI2_NUM_RESERVED_INTERRUPTS - 1),
 	GAUDI2_IRQ_NUM_UNEXPECTED_ERROR = RESERVED_MSIX_UNEXPECTED_USER_ERROR_INTERRUPT,
-	GAUDI2_IRQ_NUM_USER_FIRST = GAUDI2_IRQ_NUM_UNEXPECTED_ERROR + 1,
-	GAUDI2_IRQ_NUM_USER_LAST = (GAUDI2_IRQ_NUM_USER_FIRST + GAUDI2_NUM_USER_INTERRUPTS - 1),
 	GAUDI2_IRQ_NUM_LAST = (GAUDI2_MSIX_ENTRIES - 1)
 };
 
diff --git a/drivers/accel/habanalabs/include/gaudi2/gaudi2.h b/drivers/accel/habanalabs/include/gaudi2/gaudi2.h
index 0231d6c55b4a..753d46a2836b 100644
--- a/drivers/accel/habanalabs/include/gaudi2/gaudi2.h
+++ b/drivers/accel/habanalabs/include/gaudi2/gaudi2.h
@@ -63,9 +63,9 @@
 #define RESERVED_VA_RANGE_FOR_ARC_ON_HOST_HPAGE_START	0xFFF0F80000000000ull
 #define RESERVED_VA_RANGE_FOR_ARC_ON_HOST_HPAGE_END	0xFFF0FFFFFFFFFFFFull
 
-#define RESERVED_MSIX_UNEXPECTED_USER_ERROR_INTERRUPT	256
+#define RESERVED_MSIX_UNEXPECTED_USER_ERROR_INTERRUPT	127
 
-#define GAUDI2_MSIX_ENTRIES	512
+#define GAUDI2_MSIX_ENTRIES	128
 
 #define QMAN_PQ_ENTRY_SIZE	16			/* Bytes */
 
-- 
2.34.1


