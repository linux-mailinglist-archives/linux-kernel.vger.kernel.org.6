Return-Path: <linux-kernel+bounces-208056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6184E902004
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B74E1F20EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD5979DDB;
	Mon, 10 Jun 2024 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="glvYyz/W"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CAC38DEC;
	Mon, 10 Jun 2024 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718017017; cv=none; b=qzNx8HbnzXz3NLsTXvi60XgiMUfcnD3ec0ij/xsGkua/MPAsQhrk/mURNCm14a5N7HjPy8piAQzB6IFfxons9hVzJ9hdiyz8mc79QL5ucRQXKGs/GfSiRCnf74G/EMwNAcJhcOUGvuzN7N91kcrqvZDLtBHvLgo+J87EjzX8BP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718017017; c=relaxed/simple;
	bh=WPF2iC1SV8AsqNd6SPxTttV/JMzPbLAHKzCU/mAhLq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hYaVfoDLCZIQDZjhJcxAVuVpftnPK3ktuK+dXi24PxoazoHO01v48+Dvw4C7U4bmsi+W4Vh9fumo498WAc/OOuxB1kUFGR6PUjx4X2lrGDoDbCbP5ggVJKVHUrJxNXcSGDMfm3xEYX1SlQefTyLa7drT2ACKb8YDDCT6lRsSgGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=glvYyz/W; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45AAuTbW009009;
	Mon, 10 Jun 2024 05:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718016989;
	bh=m28Tjms8EG/D+LF08iHzhc9HsItx6aYa/0oUcN3SEgw=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=glvYyz/WsEiU2YwVpFf87uAP78t6GUf9L2Se+jmkDNr4kQo/ZCFeOrJxsKFI89JUV
	 DxtbIKX0l8c5qpbDycH5aBWq/mjFRGNQjewNkvy7hagW8zzHZvcc7Gj418jJREIRT7
	 rteukvMIe6O5cRAT6kKlTBAtSamQwF6C2J/LFlqc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45AAuTil004949
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 05:56:29 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 05:56:29 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 05:56:29 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45AAuSlc110545;
	Mon, 10 Jun 2024 05:56:28 -0500
From: Jai Luthra <j-luthra@ti.com>
Date: Mon, 10 Jun 2024 16:26:01 +0530
Subject: [PATCH v2 2/2] ASoC: ti: davinci-mcasp: Set min period size using
 FIFO config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240610-asoc_next-v2-2-b52aaf5d67c4@ti.com>
References: <20240610-asoc_next-v2-0-b52aaf5d67c4@ti.com>
In-Reply-To: <20240610-asoc_next-v2-0-b52aaf5d67c4@ti.com>
To: Lars-Peter Clausen <lars@metafoo.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Devarsh Thakkar <devarsht@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>, Jai
 Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1960; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=WPF2iC1SV8AsqNd6SPxTttV/JMzPbLAHKzCU/mAhLq0=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBmZtvYRZUS1YnZ7wXULBNwFYahVxcCh5M0cRfMj
 OW3gz+xT/mJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZmbb2AAKCRBD3pH5JJpx
 RSYnD/9/UHlozo/st4AN88B7W06HOUrbfDOElMmFCyGwQhRUERSoD1E2xe2iv2HlZERyxH6qOZx
 qc0y3ynQllWf22HxB/v0xGVUk0IVEcDKpx+jHP8/cjeOHdB3gCd/Qbpu3LCFZxGb7P4AFE1qgWW
 y/7RDNYKXnSTb6fhMNLPEeweIGu7T9kxY5Awp6bXAyzoV3KxAtZ4dp4YzfZUOxnUbHgaIxjmb6I
 Sc7sIayOVVg32WbWPElFNlN3ZWPK0dhfXWWVem1Vs+iy9plJ5CW9R9VW/3+lfFS0L7Tvv+Rdegx
 0VQYg05UCkEt38uAgJpSiJV7+x758nQmnI21Th6eGaWS8QN5aiK5fNdpjCbtuc0Opuy+QBQyfqE
 BpoUsTCZK6uK9heI4BU+rrHHa7+TXYeoz9b4EUGJs4sX882Z3ViB4gx+VFIdBkX5WFpY8owP/L/
 Vu8nSk8vnp2BN8djvj5Gwp6AHqIf3b3Ninue++dyi06rNK9xp/oSHnEFYztNU7OVFBF+nbuDhut
 f+vcCRT2nTB9eQowOLFAMUPMoMKNOjx2ePNGyZpixgTuQdgaswm1KPaPzA7K+eV+Jnro3fNb6Z6
 KP6hz9b2I8UXOsAMfRstRUSkxt44is9Vv/DeydzFataw14QLjiXCoxWfn1FHuUnR+91Tw81Vgn+
 CNDOd3qHWIqvCSA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The minimum period size was enforced to 64 as older devices integrating
McASP with EDMA used an internal FIFO of 64 samples.

With UDMA based platforms this internal McASP FIFO is optional, as the
DMA engine internally does some buffering which is already accounted for
when registering the platform. So we should read the actual FIFO
configuration (txnumevt/rxnumevt) instead of hardcoding frames.min to
64.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 sound/soc/ti/davinci-mcasp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 1e760c315521..2b1ed91a736c 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -1472,10 +1472,11 @@ static int davinci_mcasp_hw_rule_min_periodsize(
 {
 	struct snd_interval *period_size = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
+	u8 numevt = *((u8 *)rule->private);
 	struct snd_interval frames;
 
 	snd_interval_any(&frames);
-	frames.min = 64;
+	frames.min = numevt;
 	frames.integer = 1;
 
 	return snd_interval_refine(period_size, &frames);
@@ -1490,6 +1491,7 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 	u32 max_channels = 0;
 	int i, dir, ret;
 	int tdm_slots = mcasp->tdm_slots;
+	u8 *numevt;
 
 	/* Do not allow more then one stream per direction */
 	if (mcasp->substreams[substream->stream])
@@ -1589,9 +1591,12 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 			return ret;
 	}
 
+	numevt = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+			 &mcasp->txnumevt :
+			 &mcasp->rxnumevt;
 	snd_pcm_hw_rule_add(substream->runtime, 0,
 			    SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
-			    davinci_mcasp_hw_rule_min_periodsize, NULL,
+			    davinci_mcasp_hw_rule_min_periodsize, numevt,
 			    SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
 
 	return 0;

-- 
2.43.0


