Return-Path: <linux-kernel+bounces-566618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58932A67A8B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10053AA32B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4001E212FBA;
	Tue, 18 Mar 2025 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="NWByQRVY"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFA3211A22;
	Tue, 18 Mar 2025 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318113; cv=none; b=UhFv1qcArcD8T3x16shOJvcCs5dCNFNTDw+0hRIZRT28Z5JE/RyiDfgP6JYMclrbpUc9x1ncRQOa6lM6lK9QedFRW8EYHvp/myelTt4XmuYeSATebcVRR4OW1eEFWjA3gyeyo5mj0y4ZGwTLVu9Slu2HXArIGjpMVekOjIwr7KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318113; c=relaxed/simple;
	bh=xx1EnGkkvElvXQETrT9c7K2n4QpOm+bT2/jsuqX9Xl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnG5MFRVLJENjbLS2mU42IRKxV+2PDsc4UbnCdsBfuLCjmIVwXO2z7WomhcNVoxaGlYv2CXlVX1mF4GdJXn2x0uMUqyQegkRDVl8oSIKPBIcfLwcEBJoBVFT1pOgOP3sN5tvtkLWe/L6RtK27iTaMXfyVMKbShKNIDmgIP2bs3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=NWByQRVY; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I5qiuE018522;
	Tue, 18 Mar 2025 12:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=geYgAdLRwcGRrNh5U0xYwjeAHc7QQR8431tY3d0KHvI=; b=
	NWByQRVY3axzJdEU8PNtFUwAD/tPZg0IC9t3CqgwQFK7A46Gd116HqFQMgHzQBNy
	MTsnHeh2wzG777+3WPrk0NJbF591nTANh2j2SSg3V4y0+kS+1NexnBW2JLGwpra1
	Qk5DUz6oL8U/UWGLPYj/DMiqUIxrCjVXzYAhaXyHncFRUBFprm8GdDgWE7/0QlCl
	xNfyNpL2x91iF8EapYHkoQZdN2u9VJG/idjLy+v3vwKF8iaoG+L5HS06TBFxKiFr
	HC7jpVeHWP9lEfdy4cA2dVGwC/RMCtfJWqXpLJT14zc6hL111ugdwM9GfB2QD+Js
	9sstEc0kCFcVL/tyM/juew==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45d5yh879v-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 12:15:03 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 17:14:59 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 17:14:59 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 8467482255E;
	Tue, 18 Mar 2025 17:14:59 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 03/15] ASoC: ops: Update comments for xr_sx control helpers
Date: Tue, 18 Mar 2025 17:14:47 +0000
Message-ID: <20250318171459.3203730-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318171459.3203730-1-ckeepax@opensource.cirrus.com>
References: <20250318171459.3203730-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=GrhC+l1C c=1 sm=1 tr=0 ts=67d9aa17 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=BUxhUEZR2ltZMw_a-foA:9
X-Proofpoint-GUID: ue0o9TimriSVkGwBXNPUBQsExhVK-GNr
X-Proofpoint-ORIG-GUID: ue0o9TimriSVkGwBXNPUBQsExhVK-GNr
X-Proofpoint-Spam-Reason: safe

Update the comments for the xr_sx control helper functions to better
clarify the difference between these and the normal sx helpers.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/soc-ops.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 9039bf3b6fb48..dac55138210d5 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -846,9 +846,10 @@ EXPORT_SYMBOL_GPL(snd_soc_bytes_tlv_callback);
  * @kcontrol: mreg control
  * @uinfo: control element information
  *
- * Callback to provide information of a control that can
- * span multiple codec registers which together
- * forms a single signed value in a MSB/LSB manner.
+ * Callback to provide information of a control that can span multiple
+ * codec registers which together forms a single signed value. Note
+ * that unlike the non-xr variant of sx controls these may or may not
+ * include the sign bit, depending on nbits, and there is no shift.
  *
  * Returns 0 for success.
  */
@@ -872,11 +873,12 @@ EXPORT_SYMBOL_GPL(snd_soc_info_xr_sx);
  * @kcontrol: mreg control
  * @ucontrol: control element information
  *
- * Callback to get the value of a control that can span
- * multiple codec registers which together forms a single
- * signed value in a MSB/LSB manner. The control supports
- * specifying total no of bits used to allow for bitfields
- * across the multiple codec registers.
+ * Callback to get the value of a control that can span multiple codec
+ * registers which together forms a single signed value. The control
+ * supports specifying total no of bits used to allow for bitfields
+ * across the multiple codec registers. Note that unlike the non-xr
+ * variant of sx controls these may or may not include the sign bit,
+ * depending on nbits, and there is no shift.
  *
  * Returns 0 for success.
  */
@@ -918,11 +920,12 @@ EXPORT_SYMBOL_GPL(snd_soc_get_xr_sx);
  * @kcontrol: mreg control
  * @ucontrol: control element information
  *
- * Callback to set the value of a control that can span
- * multiple codec registers which together forms a single
- * signed value in a MSB/LSB manner. The control supports
- * specifying total no of bits used to allow for bitfields
- * across the multiple codec registers.
+ * Callback to set the value of a control that can span multiple codec
+ * registers which together forms a single signed value. The control
+ * supports specifying total no of bits used to allow for bitfields
+ * across the multiple codec registers. Note that unlike the non-xr
+ * variant of sx controls these may or may not include the sign bit,
+ * depending on nbits, and there is no shift.
  *
  * Returns 0 for success.
  */
-- 
2.39.5


