Return-Path: <linux-kernel+bounces-276001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50AC948D16
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A4E2879A6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582021C2314;
	Tue,  6 Aug 2024 10:47:44 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B42D1BE852;
	Tue,  6 Aug 2024 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941263; cv=none; b=cXXNIS8xmuMT+6aErabiU8rBBD0yb5+ipZffifK3ephW3uStFKuqmBPhOyA+p//olF+buS6UEzbazWhx4UlYH1d0C9+5rtuZ5OJm98xyRnUcBQa2npasp0PrAQ7O9pQ2tVLZ240Vl53yZEWq2JGadeOupTurMxMgRZY5VUSLvYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941263; c=relaxed/simple;
	bh=D8fxv6K1FdcjQMOVGh2RFrv2mloy+4n5K/2MJEyk4+k=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=nKF4nF30yhWGDg9UNeZnywyYGkKKqKE7FU4Hx/xTdEJxZEFCav2BuF9wfDdLWre5HWz/QucCJ8Lxn375v6CB68X5ZJaYVS0cVR12XEfJLk1OwaotuLPZhtXMHHhxA/2vcryUgvsBDFkCM4dn4f+/Vv3vPyAmlCEdrbTNFIqzpj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 07C97200E48;
	Tue,  6 Aug 2024 12:47:35 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C2BDA200E29;
	Tue,  6 Aug 2024 12:47:34 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 14B3A180226C;
	Tue,  6 Aug 2024 18:47:33 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 1/6] ALSA: compress: add Sample Rate Converter codec support
Date: Tue,  6 Aug 2024 18:26:38 +0800
Message-Id: <1722940003-20126-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1722940003-20126-1-git-send-email-shengjiu.wang@nxp.com>
References: <1722940003-20126-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add Sample Rate Converter(SRC) codec support, define the output
format and rate for SRC.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 include/uapi/sound/compress_offload.h | 2 ++
 include/uapi/sound/compress_params.h  | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
index 98772b0cbcb7..8b2b72f94e26 100644
--- a/include/uapi/sound/compress_offload.h
+++ b/include/uapi/sound/compress_offload.h
@@ -112,10 +112,12 @@ struct snd_compr_codec_caps {
  * end of the track
  * @SNDRV_COMPRESS_ENCODER_DELAY: no of samples inserted by the encoder at the
  * beginning of the track
+ * @SNDRV_COMPRESS_SRC_RATIO_MOD: Resampling Ratio Modifier for sample rate converter
  */
 enum sndrv_compress_encoder {
 	SNDRV_COMPRESS_ENCODER_PADDING = 1,
 	SNDRV_COMPRESS_ENCODER_DELAY = 2,
+	SNDRV_COMPRESS_SRC_RATIO_MOD = 3,
 };
 
 /**
diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
index ddc77322d571..0843773ea6b4 100644
--- a/include/uapi/sound/compress_params.h
+++ b/include/uapi/sound/compress_params.h
@@ -43,7 +43,8 @@
 #define SND_AUDIOCODEC_BESPOKE               ((__u32) 0x0000000E)
 #define SND_AUDIOCODEC_ALAC                  ((__u32) 0x0000000F)
 #define SND_AUDIOCODEC_APE                   ((__u32) 0x00000010)
-#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_APE
+#define SND_AUDIOCODEC_SRC                   ((__u32) 0x00000011)
+#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_SRC
 
 /*
  * Profile and modes are listed with bit masks. This allows for a
@@ -324,6 +325,11 @@ struct snd_dec_ape {
 	__u32 seek_table_present;
 } __attribute__((packed, aligned(4)));
 
+struct snd_dec_src {
+	__u32 format_out;
+	__u32 rate_out;
+} __attribute__((packed, aligned(4)));
+
 union snd_codec_options {
 	struct snd_enc_wma wma;
 	struct snd_enc_vorbis vorbis;
@@ -334,6 +340,7 @@ union snd_codec_options {
 	struct snd_dec_wma wma_d;
 	struct snd_dec_alac alac_d;
 	struct snd_dec_ape ape_d;
+	struct snd_dec_src src;
 } __attribute__((packed, aligned(4)));
 
 /** struct snd_codec_desc - description of codec capabilities
-- 
2.34.1


