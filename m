Return-Path: <linux-kernel+bounces-397538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ECD9BDD24
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70117B254E9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467EF18F2D8;
	Wed,  6 Nov 2024 02:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="Hvl+GhNX"
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E9133F3;
	Wed,  6 Nov 2024 02:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730860892; cv=none; b=hbRIueEisTkVD1UFb/ULyVFnkNmijmZ0uIHzCXeSfeLCqRd6mnYDmat/hg9rPV+Vu14hW7XAF6yWSiJ5IJjjB04XcHJnofWumTIE6u9Qc/bBJhgU3IhtK3suGJq+j9CoMbc4aLEB1GyUw/oC6sYB7hPQTtxamxd3GOWLPjHqNI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730860892; c=relaxed/simple;
	bh=pS64vwLpBrJlarWl0zzizwy0z0t8uYC6elUgESteGMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LTWk5B9B7Xs3hmTXm0T3tFDyVTUcCnwUKBp1qp1GK26mtpzqDyyl/DtQtlPEBUW+Im1YLWcd9EvHtTQfrqR/CHeBxXlc5rdRT81m5jdv2gwG1sc4gfobbUvT8U7q81mkh+UpkxnW3bJEX8M18uU16k80NcnWGmJXBot+9qAlfLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=Hvl+GhNX; arc=none smtp.client-ip=159.100.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.156])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 55F1626760;
	Wed,  6 Nov 2024 02:41:28 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay4.mymailcheap.com (Postfix) with ESMTPS id 704A820339;
	Wed,  6 Nov 2024 02:41:19 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 051E840078;
	Wed,  6 Nov 2024 02:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1730860878; bh=pS64vwLpBrJlarWl0zzizwy0z0t8uYC6elUgESteGMI=;
	h=From:To:Cc:Subject:Date:From;
	b=Hvl+GhNXisHeHxVH/sqJ58w6zYU6J+4Po5uS7xNgL4gYfNVifuO8QwLbFleya1rgB
	 vCEtqYJnYRAMeVkND/kgi8Vl60IObq1bwKbcVukXx1tTqC8U8nd1FdzBUyVsCeUkcm
	 gMe8q2igrw3YfR26Crp1huE6LvUihzYHVPOldupI=
Received: from JellyNote.localdomain (unknown [38.179.66.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 0100141344;
	Wed,  6 Nov 2024 02:41:14 +0000 (UTC)
From: Mingcong Bai <jeffbai@aosc.io>
To: broonie@kernel.org
Cc: kexybiscuit@aosc.io,
	Mingcong Bai <jeffbai@aosc.io>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"end.to.start" <end.to.start@mail.ru>,
	Jiawei Wang <me@jwang.link>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: amd: yc: fix internal mic on Xiaomi Book Pro 14 2022
Date: Wed,  6 Nov 2024 10:40:50 +0800
Message-ID: <20241106024052.15748-1-jeffbai@aosc.io>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 051E840078
X-Rspamd-Server: nf1.mymailcheap.com
X-Spamd-Result: default: False [1.10 / 10.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	BAYES_HAM(-0.30)[75.02%];
	MIME_GOOD(-0.10)[text/plain];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,mail.ru];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_CC(0.00)[aosc.io,gmail.com,perex.cz,suse.com,amd.com,mail.ru,jwang.link,vger.kernel.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action

Xiaomi Book Pro 14 2022 (MIA2210-AD) requires a quirk entry for its
internal microphone to be enabled.

This is likely due to similar reasons as seen previously on Redmi Book
14/15 Pro 2022 models (since they likely came with similar firmware):

- commit dcff8b7ca92d ("ASoC: amd: yc: Add Xiaomi Redmi Book Pro 15 2022
  into DMI table")
- commit c1dd6bf61997 ("ASoC: amd: yc: Add Xiaomi Redmi Book Pro 14 2022
  into DMI table")

A quirk would likely be needed for Xiaomi Book Pro 15 2022 models, too.
However, I do not have such device on hand so I will leave it for now.

Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 438865d5e376..dc476bfb6da4 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -395,6 +395,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Redmi Book Pro 15 2022"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "TIMI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Xiaomi Book Pro 14 2022"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.47.0


