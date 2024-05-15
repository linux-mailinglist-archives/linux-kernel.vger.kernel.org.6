Return-Path: <linux-kernel+bounces-179544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBD28C612C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772241F23770
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5DB481AC;
	Wed, 15 May 2024 07:09:06 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2D5433AF;
	Wed, 15 May 2024 07:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715756946; cv=none; b=k2YEFhc4LVbs9grcF3St03KMywolydEYafa1ILI/m5TDqrD6b8OuYs5xbQRroPaNpaITiEYiCnYrJ0zsurK+8i37J2l4V03Z8ie5M5/jjnL0fubQKxyv//dUugTD86UbgflAuPxcLP05ErcXFxrwHsSm3e+tqD15+nN2tg31RDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715756946; c=relaxed/simple;
	bh=tVNkzEuog16eOwLrJZX7K+CfRtoBM/F3bxnsfgBYkP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OS/5ePpIWIz4LqyfAZZVMH9XtihGuUO1JUMjWcFB4xYoi+jVbMiwXaNJNu9YHPZYDV6tNqLuchethCKVaoBXK6gxDWZpGDuwR7mLJKJ80JdjjrmdLWwTBlirmypvQn+nFmSHS4d1yiwlYcnc0wl1BoaP6Lj6nOUArHAspRPe7V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0ECF7201AAC;
	Wed, 15 May 2024 09:08:57 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7370A200004;
	Wed, 15 May 2024 09:08:56 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B3B65181D0F9;
	Wed, 15 May 2024 15:08:54 +0800 (+08)
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	rohit.fule@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	haibo.chen@nxp.com,
	LnxRevLi@nxp.com,
	guillaume.legoupil@nxp.com,
	salim.chebbo@nxp.com
Subject: [PATCH v1 1/3] Bluetooth: btnxpuart: Fix Null pointer dereference in btnxpuart_flush()
Date: Wed, 15 May 2024 12:36:55 +0530
Message-Id: <20240515070657.85132-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515070657.85132-1-neeraj.sanjaykale@nxp.com>
References: <20240515070657.85132-1-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This adds a check before freeing the rx->skb in flush and close
functions to handle the kernel crash seen while removing driver after FW
download fails or before FW download completes.

dmesg log:
[   54.634586] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
[   54.643398] Mem abort info:
[   54.646204]   ESR = 0x0000000096000004
[   54.649964]   EC = 0x25: DABT (current EL), IL = 32 bits
[   54.655286]   SET = 0, FnV = 0
[   54.658348]   EA = 0, S1PTW = 0
[   54.661498]   FSC = 0x04: level 0 translation fault
[   54.666391] Data abort info:
[   54.669273]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[   54.674768]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   54.674771]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   54.674775] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000048860000
[   54.674780] [0000000000000080] pgd=0000000000000000, p4d=0000000000000000
[   54.703880] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[   54.710152] Modules linked in: btnxpuart(-) overlay fsl_jr_uio caam_jr caamkeyblob_desc caamhash_desc caamalg_desc crypto_engine authenc libdes crct10dif_ce polyval_ce polyval_generic snd_soc_imx_spdif snd_soc_imx_card snd_soc_ak5558 snd_soc_ak4458 caam secvio error snd_soc_fsl_micfil snd_soc_fsl_spdif snd_soc_fsl_sai snd_soc_fsl_utils imx_pcm_dma gpio_ir_recv rc_core sch_fq_codel fuse
[   54.744357] CPU: 3 PID: 72 Comm: kworker/u9:0 Not tainted 6.6.3-otbr-g128004619037 #2
[   54.744364] Hardware name: FSL i.MX8MM EVK board (DT)
[   54.744368] Workqueue: hci0 hci_power_on
[   54.757244] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   54.757249] pc : kfree_skb_reason+0x18/0xb0
[   54.772299] lr : btnxpuart_flush+0x40/0x58 [btnxpuart]
[   54.782921] sp : ffff8000805ebca0
[   54.782923] x29: ffff8000805ebca0 x28: ffffa5c6cf1869c0 x27: ffffa5c6cf186000
[   54.782931] x26: ffff377b84852400 x25: ffff377b848523c0 x24: ffff377b845e7230
[   54.782938] x23: ffffa5c6ce8dbe08 x22: ffffa5c6ceb65410 x21: 00000000ffffff92
[   54.782945] x20: ffffa5c6ce8dbe98 x19: ffffffffffffffac x18: ffffffffffffffff
[   54.807651] x17: 0000000000000000 x16: ffffa5c6ce2824ec x15: ffff8001005eb857
[   54.821917] x14: 0000000000000000 x13: ffffa5c6cf1a02e0 x12: 0000000000000642
[   54.821924] x11: 0000000000000040 x10: ffffa5c6cf19d690 x9 : ffffa5c6cf19d688
[   54.821931] x8 : ffff377b86000028 x7 : 0000000000000000 x6 : 0000000000000000
[   54.821938] x5 : ffff377b86000000 x4 : 0000000000000000 x3 : 0000000000000000
[   54.843331] x2 : 0000000000000000 x1 : 0000000000000002 x0 : ffffffffffffffac
[   54.857599] Call trace:
[   54.857601]  kfree_skb_reason+0x18/0xb0
[   54.863878]  btnxpuart_flush+0x40/0x58 [btnxpuart]
[   54.863888]  hci_dev_open_sync+0x3a8/0xa04
[   54.872773]  hci_power_on+0x54/0x2e4
[   54.881832]  process_one_work+0x138/0x260
[   54.881842]  worker_thread+0x32c/0x438
[   54.881847]  kthread+0x118/0x11c
[   54.881853]  ret_from_fork+0x10/0x20
[   54.896406] Code: a9be7bfd 910003fd f9000bf3 aa0003f3 (b940d400)
[   54.896410] ---[ end trace 0000000000000000 ]---

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Tested-by: Guillaume Legoupil <guillaume.legoupil@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 0b93c2ff29e4..0677b48a456e 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1253,8 +1253,10 @@ static int btnxpuart_close(struct hci_dev *hdev)
 	ps_wakeup(nxpdev);
 	serdev_device_close(nxpdev->serdev);
 	skb_queue_purge(&nxpdev->txq);
-	kfree_skb(nxpdev->rx_skb);
-	nxpdev->rx_skb = NULL;
+	if (!IS_ERR_OR_NULL(nxpdev->rx_skb)) {
+		kfree_skb(nxpdev->rx_skb);
+		nxpdev->rx_skb = NULL;
+	}
 	clear_bit(BTNXPUART_SERDEV_OPEN, &nxpdev->tx_state);
 	return 0;
 }
@@ -1269,8 +1271,10 @@ static int btnxpuart_flush(struct hci_dev *hdev)
 
 	cancel_work_sync(&nxpdev->tx_work);
 
-	kfree_skb(nxpdev->rx_skb);
-	nxpdev->rx_skb = NULL;
+	if (!IS_ERR_OR_NULL(nxpdev->rx_skb)) {
+		kfree_skb(nxpdev->rx_skb);
+		nxpdev->rx_skb = NULL;
+	}
 
 	return 0;
 }
-- 
2.34.1


