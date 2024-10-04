Return-Path: <linux-kernel+bounces-350113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEB999000B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C9C1F244C7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD33E14F12D;
	Fri,  4 Oct 2024 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QN78AA9E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333CF14D2B3
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034887; cv=none; b=jRn1DjSDYNYSFgEyz+kYnRJxTVNZlR9zA1HRpRKrh9yCzZY9K7KC76kRO7eoqanc2llVAULGlEGQuTvADvscAaqn7vyaVFTV+TkqMOXUN+iKVZCBN+H+ksKxVgBuAAcUg4ssduRvQfHDfwJdAFfm9tDfLg5vX7qRA6xRLfsJoMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034887; c=relaxed/simple;
	bh=goZZ1KsKedXb6voFxo0gvOkPhzBsXitOKXEJe53417M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ozvpg0pci27CJIy/+R1ngvQKMQNfN/OjYr2aacmblC4WvnbfIBRx7gb9mFTft3vifelJXutoGb0H/uVzrQoOrqrmGJhFbJsNdUP2F4NttlDeWKujsoS6aVAnO6L7fuBBQ97bj3ESWbvF4FDQzpuTlHqIH+sVFBWYyHlDvqvroGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QN78AA9E; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728034886; x=1759570886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=goZZ1KsKedXb6voFxo0gvOkPhzBsXitOKXEJe53417M=;
  b=QN78AA9EeaBQWxEyra7AWgCh9Bfk4sY9jmRNAZwJTivp5VBZVD72+tCj
   3S4Ecpre09TqMqujsPZk7vkcrrl9sQ43QTqYgCIkq/TEbfvdwRulThDli
   K+XWb4ORTqVAozUcgbIJvGqfZRLsK98BbP8dM+GPkZKv10KvYSkwnO7Rc
   rwl4LjkXkTtGTw+y4osWnhQj9Q8CNWrdEi6+UFsd1elAy2x0zkDvkiaF5
   jb/HKUbV8C+w1NFtz4fwK9GUU/eLblJ3bce7duZ5izsV8JdNcUvRIH+be
   rfHOFB0BdE97edg0sqArP0VWojQuwo4eFZVw/TjLEH+Y6bnGEOyALRKji
   Q==;
X-CSE-ConnectionGUID: ASLndigjSbeYXHMTWmmZvw==
X-CSE-MsgGUID: Bv1a/3QBTDasdbDwiVDZ3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="37856225"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="37856225"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:26 -0700
X-CSE-ConnectionGUID: uaA9iDLqTWSgi/SChSRmlA==
X-CSE-MsgGUID: XqC7wvPSSAWjj9Xfy/7o8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74331935"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:24 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 9D7AE11FA2C;
	Fri,  4 Oct 2024 12:41:22 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1sweoM-000TYJ-1z;
	Fri, 04 Oct 2024 12:41:22 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Sebastian Reichel <sre@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 14/51] HSI: omap_ssi_port: Switch to __pm_runtime_put_autosuspend()
Date: Fri,  4 Oct 2024 12:41:22 +0300
Message-Id: <20241004094122.113589-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend() will soon be changed to include a call to
pm_runtime_mark_last_busy(). This patch switches the current users to
__pm_runtime_put_autosuspend() which will continue to have the
functionality of old pm_runtime_put_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/hsi/controllers/omap_ssi_port.c | 42 ++++++++++++-------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index f0b3eca7376e..893702eeaa86 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -114,7 +114,7 @@ static int ssi_port_regs_show(struct seq_file *m, void *p __maybe_unused)
 		seq_printf(m, "BUFFER_CH%d\t: 0x%08x\n", ch,
 				readl(base + SSI_SSR_BUFFER_CH_REG(ch)));
 	}
-	pm_runtime_put_autosuspend(omap_port->pdev);
+	__pm_runtime_put_autosuspend(omap_port->pdev);
 
 	return 0;
 }
@@ -128,7 +128,7 @@ static int ssi_div_get(void *data, u64 *val)
 
 	pm_runtime_get_sync(omap_port->pdev);
 	*val = readl(omap_port->sst_base + SSI_SST_DIVISOR_REG);
-	pm_runtime_put_autosuspend(omap_port->pdev);
+	__pm_runtime_put_autosuspend(omap_port->pdev);
 
 	return 0;
 }
@@ -144,7 +144,7 @@ static int ssi_div_set(void *data, u64 val)
 	pm_runtime_get_sync(omap_port->pdev);
 	writel(val, omap_port->sst_base + SSI_SST_DIVISOR_REG);
 	omap_port->sst.divisor = val;
-	pm_runtime_put_autosuspend(omap_port->pdev);
+	__pm_runtime_put_autosuspend(omap_port->pdev);
 
 	return 0;
 }
@@ -217,7 +217,7 @@ static int ssi_start_dma(struct hsi_msg *msg, int lch)
 
 	if (!pm_runtime_active(omap_port->pdev)) {
 		dev_warn(&port->device, "ssi_start_dma called without runtime PM!\n");
-		pm_runtime_put_autosuspend(omap_port->pdev);
+		__pm_runtime_put_autosuspend(omap_port->pdev);
 		return -EREMOTEIO;
 	}
 
@@ -226,7 +226,7 @@ static int ssi_start_dma(struct hsi_msg *msg, int lch)
 							DMA_FROM_DEVICE);
 		if (!err) {
 			dev_dbg(&ssi->device, "DMA map SG failed !\n");
-			pm_runtime_put_autosuspend(omap_port->pdev);
+			__pm_runtime_put_autosuspend(omap_port->pdev);
 			return -EIO;
 		}
 		csdp = SSI_DST_BURST_4x32_BIT | SSI_DST_MEMORY_PORT |
@@ -243,7 +243,7 @@ static int ssi_start_dma(struct hsi_msg *msg, int lch)
 							DMA_TO_DEVICE);
 		if (!err) {
 			dev_dbg(&ssi->device, "DMA map SG failed !\n");
-			pm_runtime_put_autosuspend(omap_port->pdev);
+			__pm_runtime_put_autosuspend(omap_port->pdev);
 			return -EIO;
 		}
 		csdp = SSI_SRC_BURST_4x32_BIT | SSI_SRC_MEMORY_PORT |
@@ -289,7 +289,7 @@ static int ssi_start_pio(struct hsi_msg *msg)
 
 	if (!pm_runtime_active(omap_port->pdev)) {
 		dev_warn(&port->device, "ssi_start_pio called without runtime PM!\n");
-		pm_runtime_put_autosuspend(omap_port->pdev);
+		__pm_runtime_put_autosuspend(omap_port->pdev);
 		return -EREMOTEIO;
 	}
 
@@ -304,7 +304,7 @@ static int ssi_start_pio(struct hsi_msg *msg)
 						msg->ttype ? "write" : "read");
 	val |= readl(omap_ssi->sys + SSI_MPU_ENABLE_REG(port->num, 0));
 	writel(val, omap_ssi->sys + SSI_MPU_ENABLE_REG(port->num, 0));
-	pm_runtime_put_autosuspend(omap_port->pdev);
+	__pm_runtime_put_autosuspend(omap_port->pdev);
 	msg->actual_len = 0;
 	msg->status = HSI_STATUS_PROCEEDING;
 
@@ -363,7 +363,7 @@ static int ssi_async_break(struct hsi_msg *msg)
 	}
 out:
 	pm_runtime_mark_last_busy(omap_port->pdev);
-	pm_runtime_put_autosuspend(omap_port->pdev);
+	__pm_runtime_put_autosuspend(omap_port->pdev);
 
 	return err;
 }
@@ -402,7 +402,7 @@ static int ssi_async(struct hsi_msg *msg)
 	}
 	spin_unlock_bh(&omap_port->lock);
 	pm_runtime_mark_last_busy(omap_port->pdev);
-	pm_runtime_put_autosuspend(omap_port->pdev);
+	__pm_runtime_put_autosuspend(omap_port->pdev);
 	dev_dbg(&port->device, "msg status %d ttype %d ch %d\n",
 				msg->status, msg->ttype, msg->channel);
 
@@ -505,7 +505,7 @@ static int ssi_setup(struct hsi_client *cl)
 out:
 	spin_unlock_bh(&omap_port->lock);
 	pm_runtime_mark_last_busy(omap_port->pdev);
-	pm_runtime_put_autosuspend(omap_port->pdev);
+	__pm_runtime_put_autosuspend(omap_port->pdev);
 
 	return err;
 }
@@ -536,7 +536,7 @@ static int ssi_flush(struct hsi_client *cl)
 			continue;
 		writew_relaxed(0, omap_ssi->gdd + SSI_GDD_CCR_REG(i));
 		if (msg->ttype == HSI_MSG_READ)
-			pm_runtime_put_autosuspend(omap_port->pdev);
+			__pm_runtime_put_autosuspend(omap_port->pdev);
 		omap_ssi->gdd_trn[i].msg = NULL;
 	}
 	/* Flush all SST buffers */
@@ -560,7 +560,7 @@ static int ssi_flush(struct hsi_client *cl)
 	for (i = 0; i < omap_port->channels; i++) {
 		/* Release write clocks */
 		if (!list_empty(&omap_port->txqueue[i]))
-			pm_runtime_put_autosuspend(omap_port->pdev);
+			__pm_runtime_put_autosuspend(omap_port->pdev);
 		ssi_flush_queue(&omap_port->txqueue[i], NULL);
 		ssi_flush_queue(&omap_port->rxqueue[i], NULL);
 	}
@@ -571,7 +571,7 @@ static int ssi_flush(struct hsi_client *cl)
 
 	spin_unlock_bh(&omap_port->lock);
 	pm_runtime_mark_last_busy(omap_port->pdev);
-	pm_runtime_put_autosuspend(omap_port->pdev);
+	__pm_runtime_put_autosuspend(omap_port->pdev);
 
 	return 0;
 }
@@ -626,7 +626,7 @@ static int ssi_stop_tx(struct hsi_client *cl)
 	spin_unlock_bh(&omap_port->wk_lock);
 
 	pm_runtime_mark_last_busy(omap_port->pdev);
-	pm_runtime_put_autosuspend(omap_port->pdev); /* Release clocks */
+	__pm_runtime_put_autosuspend(omap_port->pdev); /* Release clocks */
 
 
 	return 0;
@@ -654,7 +654,7 @@ static void ssi_transfer(struct omap_ssi_port *omap_port,
 	}
 	spin_unlock_bh(&omap_port->lock);
 	pm_runtime_mark_last_busy(omap_port->pdev);
-	pm_runtime_put_autosuspend(omap_port->pdev);
+	__pm_runtime_put_autosuspend(omap_port->pdev);
 }
 
 static void ssi_cleanup_queues(struct hsi_client *cl)
@@ -684,7 +684,7 @@ static void ssi_cleanup_queues(struct hsi_client *cl)
 			status |= SSI_DATAACCEPT(i);
 			/* Release the clocks writes, also GDD ones */
 			pm_runtime_mark_last_busy(omap_port->pdev);
-			pm_runtime_put_autosuspend(omap_port->pdev);
+			__pm_runtime_put_autosuspend(omap_port->pdev);
 		}
 		ssi_flush_queue(&omap_port->txqueue[i], cl);
 	}
@@ -740,7 +740,7 @@ static void ssi_cleanup_gdd(struct hsi_controller *ssi, struct hsi_client *cl)
 		 */
 		if (msg->ttype == HSI_MSG_READ) {
 			pm_runtime_mark_last_busy(omap_port->pdev);
-			pm_runtime_put_autosuspend(omap_port->pdev);
+			__pm_runtime_put_autosuspend(omap_port->pdev);
 		}
 		omap_ssi->gdd_trn[i].msg = NULL;
 	}
@@ -937,7 +937,7 @@ static void ssi_pio_complete(struct hsi_port *port, struct list_head *queue)
 	if (msg->ttype == HSI_MSG_WRITE) {
 		/* Release clocks for write transfer */
 		pm_runtime_mark_last_busy(omap_port->pdev);
-		pm_runtime_put_autosuspend(omap_port->pdev);
+		__pm_runtime_put_autosuspend(omap_port->pdev);
 	}
 	reg &= ~val;
 	writel_relaxed(reg, omap_ssi->sys + SSI_MPU_ENABLE_REG(port->num, 0));
@@ -982,7 +982,7 @@ static irqreturn_t ssi_pio_thread(int irq, void *ssi_port)
 	} while (status_reg);
 
 	pm_runtime_mark_last_busy(omap_port->pdev);
-	pm_runtime_put_autosuspend(omap_port->pdev);
+	__pm_runtime_put_autosuspend(omap_port->pdev);
 
 	return IRQ_HANDLED;
 }
@@ -1019,7 +1019,7 @@ static irqreturn_t ssi_wake_thread(int irq __maybe_unused, void *ssi_port)
 		hsi_event(port, HSI_EVENT_STOP_RX);
 		if (test_and_clear_bit(SSI_WAKE_EN, &omap_port->flags)) {
 			pm_runtime_mark_last_busy(omap_port->pdev);
-			pm_runtime_put_autosuspend(omap_port->pdev);
+			__pm_runtime_put_autosuspend(omap_port->pdev);
 		}
 	}
 
-- 
2.39.5


