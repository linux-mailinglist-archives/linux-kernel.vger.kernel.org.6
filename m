Return-Path: <linux-kernel+bounces-293180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E98957BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 05:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B30A5B21366
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAD22E634;
	Tue, 20 Aug 2024 03:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="njMO9TNU"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E1733F9;
	Tue, 20 Aug 2024 03:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724123045; cv=none; b=XtK1uORLP82tr3u/H5uWRqed3RN8P9tVIIHsWsRVviS3uRKCDcvMBYf41bu4hYGjHhUtsSWwgFw+6e9qcvkTPqSlPQXbL4Kk1B3hy2g/VHAokdHRr4+4TfUAFMdQwYcW2BM6VKtYV4VLvih02kFLfocDkZuSLgzFcbjt/C6dJAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724123045; c=relaxed/simple;
	bh=OjjfPsRQw2C5OYfWFUNyPBR+zTrnb8hFbXcYKzQlOJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dlMWEoJZntLyZN9aRyuGEGGOleKMMYp5VFc+yRrI9E2X38TIPstppF1qZsWal6xZd6VTm60EBswSSc394WcTz6RgQxRIOz68AxUFfHOwd4GZcXTw/z8yGyI2OVUj2ZMfazwwyP6NG3I7Bcey8VFvr0lp1GYmcyr69ACEducfSuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=njMO9TNU; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1724123041;
	bh=zOJXN3PPcGbNvywa22BP3hA8HhqWXwzidaOciMyqTGg=;
	h=From:To:Cc:Subject:Date:From;
	b=njMO9TNUd8w07bVzEmCHfZBWYSHFjyDQ2Eh/HuPH3RNxwcPshGk1qDY4/FdJYJ2Di
	 opc/M6BpX7Fjei0n1tUmLTA3yLAO2ChcYzonDX0byT6ostYCB+HDhBISTj+k13mcG0
	 CIRNXv7/9MXxKMMJWUniI9jyX4zY2y48LannEJ0iYgO+IO6wnJzwXb0BJbOxf8bAEU
	 1EjJOAY/9m5ew2WmEKgWYw10/1DfygMN0UymGJUMmTzj9NSxaWpEVvKq3zwMh5VAoe
	 0JHKpadeR06QeaQ016L1Lton0Bx1AdktGOi1e1+nlXzYdwtLi9iExqJ4JP4D66QLsr
	 qopox6JhliG1A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WnvSK3h96z4w2F;
	Tue, 20 Aug 2024 13:04:01 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: cassel@kernel.org
Cc: dlemoal@kernel.org,
	linux-ide@vger.kernel.org,
	<linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>,
	<hch@lst.de>,
	linux-ppc@kolla.no,
	vidra@ufal.mff.cuni.cz
Subject: [PATCH v2] ata: pata_macio: Fix DMA table overflow
Date: Tue, 20 Aug 2024 13:03:58 +1000
Message-ID: <20240820030358.627711-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Kolbjørn and Jonáš reported that their 32-bit PowerMacs were crashing
in pata-macio since commit 09fe2bfa6b83 ("ata: pata_macio: Fix
max_segment_size with PAGE_SIZE == 64K").

For example:

  kernel BUG at drivers/ata/pata_macio.c:544!
  Oops: Exception in kernel mode, sig: 5 [#1]
  BE PAGE_SIZE=4K MMU=Hash SMP NR_CPUS=2 DEBUG_PAGEALLOC PowerMac
  ...
  NIP pata_macio_qc_prep+0xf4/0x190
  LR  pata_macio_qc_prep+0xfc/0x190
  Call Trace:
    0xc1421660 (unreliable)
    ata_qc_issue+0x14c/0x2d4
    __ata_scsi_queuecmd+0x200/0x53c
    ata_scsi_queuecmd+0x50/0xe0
    scsi_queue_rq+0x788/0xb1c
    __blk_mq_issue_directly+0x58/0xf4
    blk_mq_plug_issue_direct+0x8c/0x1b4
    blk_mq_flush_plug_list.part.0+0x584/0x5e0
    __blk_flush_plug+0xf8/0x194
    __submit_bio+0x1b8/0x2e0
    submit_bio_noacct_nocheck+0x230/0x304
    btrfs_work_helper+0x200/0x338
    process_one_work+0x1a8/0x338
    worker_thread+0x364/0x4c0
    kthread+0x100/0x104
    start_kernel_thread+0x10/0x14

That commit increased max_segment_size to 64KB, with the justification
that the SCSI core was already using that size when PAGE_SIZE == 64KB,
and that there was existing logic to split over-sized requests.

However with a sufficiently large request, the splitting logic causes
each sg to be split into two commands in the DMA table, leading to
overflow of the DMA table, triggering the BUG_ON().

With default settings the bug doesn't trigger, because the request size
is limited by max_sectors_kb == 1280, however max_sectors_kb can be
increased, and apparently some distros do that by default using udev
rules.

Fix the bug for 4KB kernels by reverting to the old max_segment_size.

For 64KB kernels the sg_tablesize needs to be halved, to allow for the
possibility that each sg will be split into two.

Fixes: 09fe2bfa6b83 ("ata: pata_macio: Fix max_segment_size with PAGE_SIZE == 64K")
Cc: stable@vger.kernel.org # v6.10+
Reported-by: Kolbjørn Barmen <linux-ppc@kolla.no>
Closes: https://lore.kernel.org/all/62d248bb-e97a-25d2-bcf2-9160c518cae5@kolla.no/
Reported-by: Jonáš Vidra <vidra@ufal.mff.cuni.cz>
Closes: https://lore.kernel.org/all/3b6441b8-06e6-45da-9e55-f92f2c86933e@ufal.mff.cuni.cz/
Tested-by: Kolbjørn Barmen <linux-ppc@kolla.no>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/ata/pata_macio.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

v2: Namespace the defines as requested by Damien.
    Tab align the defines.

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 1b85e8bf4ef9..1cb8d24b088f 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -208,6 +208,19 @@ static const char* macio_ata_names[] = {
 /* Don't let a DMA segment go all the way to 64K */
 #define MAX_DBDMA_SEG		0xff00
 
+#ifdef CONFIG_PAGE_SIZE_64KB
+/*
+ * The SCSI core requires the segment size to cover at least a page, so
+ * for 64K page size kernels it must be at least 64K. However the
+ * hardware can't handle 64K, so pata_macio_qc_prep() will split large
+ * requests. To handle the split requests the tablesize must be halved.
+ */
+#define PATA_MACIO_MAX_SEGMENT_SIZE	SZ_64K
+#define PATA_MACIO_SG_TABLESIZE		(MAX_DCMDS / 2)
+#else
+#define PATA_MACIO_MAX_SEGMENT_SIZE	MAX_DBDMA_SEG
+#define PATA_MACIO_SG_TABLESIZE		MAX_DCMDS
+#endif
 
 /*
  * Wait 1s for disk to answer on IDE bus after a hard reset
@@ -912,16 +925,10 @@ static int pata_macio_do_resume(struct pata_macio_priv *priv)
 
 static const struct scsi_host_template pata_macio_sht = {
 	__ATA_BASE_SHT(DRV_NAME),
-	.sg_tablesize		= MAX_DCMDS,
+	.sg_tablesize		= PATA_MACIO_SG_TABLESIZE,
 	/* We may not need that strict one */
 	.dma_boundary		= ATA_DMA_BOUNDARY,
-	/*
-	 * The SCSI core requires the segment size to cover at least a page, so
-	 * for 64K page size kernels this must be at least 64K. However the
-	 * hardware can't handle 64K, so pata_macio_qc_prep() will split large
-	 * requests.
-	 */
-	.max_segment_size	= SZ_64K,
+	.max_segment_size	= PATA_MACIO_MAX_SEGMENT_SIZE,
 	.device_configure	= pata_macio_device_configure,
 	.sdev_groups		= ata_common_sdev_groups,
 	.can_queue		= ATA_DEF_QUEUE,
-- 
2.46.0


