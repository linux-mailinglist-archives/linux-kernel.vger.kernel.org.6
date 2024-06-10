Return-Path: <linux-kernel+bounces-208055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521A090200F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E8ADB23881
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9750D7A702;
	Mon, 10 Jun 2024 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jno0hY7l"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C74FC01;
	Mon, 10 Jun 2024 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718017017; cv=none; b=B0/9hdnAv5g8i/DvZSWEBQnDAtG8+pp7XJN9AI+QpWt4FWCDChizIaqMW6+ctQ/JP1syClAdxjvwUT9WYAWKsSq1Ll5PBbciE39AwSe1gwHqfiemgilzL0FontBCpTv+5UoaB9JYYaIBMp/C7b2Jwekf9WYYvFwu8fRe6NwjWQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718017017; c=relaxed/simple;
	bh=O+lWqMRXwSy8zBJ1mc67aSXihmGU78/BDKwHYJeNvQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OysXcWeD5cWCwuyN6vYyJ4+e55VubyRXPZD+ozg+dJyvt1LbRq4/abwqBiF/8wP+Gp7rnNcBxqWkjhnZ6MxJJGsr/LZKuUO0Au6rOyeT6U1fDMza5V2986UA3k6KbUBu572HIPAC9rG2Hsm6zOvBTey5VrI8BgBAxdjR3lnrPrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jno0hY7l; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45AAuS2t009004;
	Mon, 10 Jun 2024 05:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718016988;
	bh=/WPuP+3MqrfuEjdImm1fPrjNvw+T0MBh7NTiOXP2HsM=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=jno0hY7lIhYQBmxspZnUlszmMjEftMmiz0wE6cMssYG7tdUznQxty5JlaGzhWQ1lc
	 KQ9IyUKCPpQSse4UVKOd6EClxyiSa74tKPViRZphiK7bdUfzykIKfAFLEW1ghBLGwd
	 XRh4+LPwmfIbkg5gntDznAzKOCd3H3O9UTrgsvNc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45AAuS1d061861
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 05:56:28 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 05:56:27 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 05:56:27 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45AAuQnD079439;
	Mon, 10 Jun 2024 05:56:27 -0500
From: Jai Luthra <j-luthra@ti.com>
Date: Mon, 10 Jun 2024 16:26:00 +0530
Subject: [PATCH v2 1/2] ALSA: dmaengine: Synchronize dma channel in
 prepare()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240610-asoc_next-v2-1-b52aaf5d67c4@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3364; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=O+lWqMRXwSy8zBJ1mc67aSXihmGU78/BDKwHYJeNvQw=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBmZtvXvyGKfK9Fw7nQW8ivV8GWNEMKrun8JD93m
 24/mt6wReOJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZmbb1wAKCRBD3pH5JJpx
 RRZVEACYO/2PEQhnin0tBClnmN5daonwZs/efSNQ0rQ/6aq0El9FRVHGeDUN6vYFdPMloxR5ny0
 vpTFccQKV2DQa6uyiw5jIWjiNr1su8HEXlizOINmu/F8bsUaL/A/7hb2182YWKikBNWzbW4XkyF
 pETB13RztXAD3d15rjIAuPIjxbf2GonuBwuqVM37ypWcrimCxNk11Qugxh3Shuw/HPEhwBdVXkb
 cvDE2IE2m2J+uwHCiS0YSSQ7Z4hGlPa85ZF4OL47nkt2yW3b4Q8LGcrNEWZ4Vyt2ilURdL9bVS8
 v4jakrlH8Ce0xmvvtiL2ytSl9IlRXvUzTMUNU8R+QSoNI8DgiueK4wwVbf93jta4B2WNoQcftm4
 FL4qTkjo8l2ip6R2O68DaTTtCoGU6QAY1nEDpTXdZr3MrP3a0cPuTJXGYmwTs3vo3zLgfKum0sP
 TsLlT3ORUdDnqNDUK8+e+7S1hLiAwGdRkv4aBv47j8bMkZQjT8sboXGnImAq2Wfef18UiyBOaxD
 vvMHQdU3z34qfM6IvCFnLPgWqYdR+O2HK0ioMptZ4sRGTd57Zhi0ncccO0CtrDi4ZfPDW8cNEk4
 yBz83QnS2VZAtJwogbGoO0f6rtpdxZedN0Sok+Kdm+F9IK7pyxkUMIvLxiSrX///Da0wDyv+3kl
 Z2++lP+bEbDZepQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Sometimes the stream may be stopped due to XRUN events, in which case
the userspace can call snd_pcm_drop() and snd_pcm_prepare() to stop and
start the stream again.

In these cases, we must wait for the DMA channel to synchronize before
marking the stream as prepared for playback, as the DMA channel gets
stopped by snd_pcm_drop() without any synchronization.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 include/sound/dmaengine_pcm.h         |  1 +
 sound/core/pcm_dmaengine.c            | 10 ++++++++++
 sound/soc/soc-generic-dmaengine-pcm.c |  8 ++++++++
 3 files changed, 19 insertions(+)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index c11aaf8079fb..9c5800e5659f 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -36,6 +36,7 @@ snd_pcm_uframes_t snd_dmaengine_pcm_pointer_no_residue(struct snd_pcm_substream
 int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
 	struct dma_chan *chan);
 int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream);
+int snd_dmaengine_pcm_prepare(struct snd_pcm_substream *substream);
 
 int snd_dmaengine_pcm_open_request_chan(struct snd_pcm_substream *substream,
 	dma_filter_fn filter_fn, void *filter_data);
diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 12aa1cef11a1..dbf5c6136d68 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -349,6 +349,16 @@ int snd_dmaengine_pcm_open_request_chan(struct snd_pcm_substream *substream,
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_open_request_chan);
 
+int snd_dmaengine_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
+
+	dmaengine_synchronize(prtd->dma_chan);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_prepare);
+
 /**
  * snd_dmaengine_pcm_close - Close a dmaengine based PCM substream
  * @substream: PCM substream
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index ea3bc9318412..078fcb0ba8a2 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -318,6 +318,12 @@ static int dmaengine_copy(struct snd_soc_component *component,
 	return 0;
 }
 
+static int dmaengine_pcm_prepare(struct snd_soc_component *component,
+				 struct snd_pcm_substream *substream)
+{
+	return snd_dmaengine_pcm_prepare(substream);
+}
+
 static const struct snd_soc_component_driver dmaengine_pcm_component = {
 	.name		= SND_DMAENGINE_PCM_DRV_NAME,
 	.probe_order	= SND_SOC_COMP_ORDER_LATE,
@@ -327,6 +333,7 @@ static const struct snd_soc_component_driver dmaengine_pcm_component = {
 	.trigger	= dmaengine_pcm_trigger,
 	.pointer	= dmaengine_pcm_pointer,
 	.pcm_construct	= dmaengine_pcm_new,
+	.prepare	= dmaengine_pcm_prepare,
 };
 
 static const struct snd_soc_component_driver dmaengine_pcm_component_process = {
@@ -339,6 +346,7 @@ static const struct snd_soc_component_driver dmaengine_pcm_component_process = {
 	.pointer	= dmaengine_pcm_pointer,
 	.copy		= dmaengine_copy,
 	.pcm_construct	= dmaengine_pcm_new,
+	.prepare	= dmaengine_pcm_prepare,
 };
 
 static const char * const dmaengine_pcm_dma_channel_names[] = {

-- 
2.43.0


