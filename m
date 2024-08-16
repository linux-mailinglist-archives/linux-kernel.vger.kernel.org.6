Return-Path: <linux-kernel+bounces-289566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 217459547B1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE3F1F20FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31731B32C0;
	Fri, 16 Aug 2024 11:12:58 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3A81AD9E2;
	Fri, 16 Aug 2024 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806778; cv=none; b=pgZznDFBLUdSfVSjIWaZuW6ugv61yFmMO3Vma/fDt5qB68IhZeXJDNoQ3ZLRArmCt5BYWCiiSYEKlsPd6OP+hUFGicHkvbvbKuZk9DdAqD+Hp0jmmN47hR1agYlN/kxvdgWBHcnKWs8QibfqRo5ru//KeQWo2TV0KHMR8tDh8Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806778; c=relaxed/simple;
	bh=5h6HEePH2xoOdnHNUdWDHF6E8n/HdR37iEtFBS3/PRM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=YXZTCmw3M62Nx58EpUHHsqcaC8jvv71PWJXLL7x4n66QeglRQO6PaY4L61CITcPxjtvup5jrHtQ6aYUzFMVKh6exsGKMLqVElEpZ+Z+mYZme1MR2AMg1d+E0QQdzWG1AQZ2vwadBsQJ7Jj/zbOwa2chCZPkQh00v818a8Julk64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B33561A0DD3;
	Fri, 16 Aug 2024 13:03:13 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 68A2C1A01D1;
	Fri, 16 Aug 2024 13:03:13 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7865F181D0FF;
	Fri, 16 Aug 2024 19:03:11 +0800 (+08)
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
Subject: [RFC PATCH v2 1/6] ALSA: compress: reserve space in snd_compr_metadata.key for private usage
Date: Fri, 16 Aug 2024 18:42:34 +0800
Message-Id: <1723804959-31921-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1723804959-31921-1-git-send-email-shengjiu.wang@nxp.com>
References: <1723804959-31921-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Reserve the key value which is larger than 0x80000000 for driver
private usage. Driver may define its own key values which are not
public in ALSA header

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 include/uapi/sound/compress_offload.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
index 98772b0cbcb7..7e9190538df2 100644
--- a/include/uapi/sound/compress_offload.h
+++ b/include/uapi/sound/compress_offload.h
@@ -120,7 +120,7 @@ enum sndrv_compress_encoder {
 
 /**
  * struct snd_compr_metadata - compressed stream metadata
- * @key: key id
+ * @key: key id, value larger than 0x80000000 reserved for driver private usage
  * @value: key value
  */
 struct snd_compr_metadata {
-- 
2.34.1


