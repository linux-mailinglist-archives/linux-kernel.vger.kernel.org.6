Return-Path: <linux-kernel+bounces-284658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7129503BA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 678DDB232F3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74401990DB;
	Tue, 13 Aug 2024 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HmH4etQt"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728191990D2;
	Tue, 13 Aug 2024 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548737; cv=none; b=KNdREsdNdO0Vtek0FiOUAjHP5wonpqty07S8QTi0CXw/GjGDcMVR7VaH06H31uuOB6hdfRPy+Iv+I/yAUIV07xjeryXd4fChALowopUQEqzei+spJaLFQZfKF7ozlGI02FWdYEUeF+8TNGfwbt1kuntkBotCLwVeAljQ2eiax2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548737; c=relaxed/simple;
	bh=tMnQOJChe9KXLcZG5XFMABHUyzPRb5t0/FS7qg6VR3A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G1WRCfhMxZBIWu9B16sKHMn5YRB+GyjKQQ0B52O+J01EUKDQUK8RZyEMxdM4xLPt1YLHgFN5L4WDIENResctG8K5lx4gIJ4FeAXYiyV8jCm1juZLqwPOKnPHdOAftfdnsfgdYr3ifJGcXGzcz0lu5zSjVMTyjavv43PlEHWE3uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=HmH4etQt; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D2TvUh023256;
	Tue, 13 Aug 2024 06:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=u68SVm+ii+JgiV4O
	dRIuHVByVWx9R++flkNsbG3/me0=; b=HmH4etQtR7T5gdj9Pi5S/le4r7rdZYsh
	hZluyda6kGT/jXnNfLzrER2pqTtvhj731RlH3/wjgAtM6aOmaTQPsTNtuDx0+KKr
	kMkN1YQY5ECCDcTdZBwNt2qVDadJGvukNEoQt2WSv6jHlioQDRkaiY5pYrXhPgSe
	d1YZSKcDabNPgaoJ8zz+IuZBjbKnOVZdZhNzwEkn7AQUPi4zNa+8V7w1wEiiDmTF
	N2e2BHYWOGjQjG/8B6OIJKD0q+VLt4kPL/vyMCm/K1/2p52igC4M8J9Htrz6XuEW
	n190aoBNz9xLGgA4HuaQGhvTuL66CZ4q75hXMK3FG8+jEmKmQPFZ3w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 40x5kwk4x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 06:32:13 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 12:32:11 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 13 Aug 2024 12:32:11 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.68.170])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 0DE1B820241;
	Tue, 13 Aug 2024 11:32:11 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda: cs35l41: Remove redundant call to hda_cs_dsp_control_remove()
Date: Tue, 13 Aug 2024 12:32:09 +0100
Message-ID: <20240813113209.648-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: t_Zww_c1c2Mbx_mH0l6kBsmQPA3rfHTs
X-Proofpoint-GUID: t_Zww_c1c2Mbx_mH0l6kBsmQPA3rfHTs
X-Proofpoint-Spam-Reason: safe

The driver doesn't create any ALSA controls for firmware controls, so it
shouldn't be calling hda_cs_dsp_control_remove().

commit 312c04cee408 ("ALSA: hda: cs35l41: Stop creating ALSA Controls for
firmware coefficients") removed the call to hda_cs_dsp_add_controls() but
didn't remove the call for destroying those controls.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 312c04cee408 ("ALSA: hda: cs35l41: Stop creating ALSA Controls for firmware coefficients")
---
 sound/pci/hda/cs35l41_hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 3a92e98da72d..d68bf7591d90 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -134,7 +134,7 @@ static const struct reg_sequence cs35l41_hda_mute[] = {
 };
 
 static const struct cs_dsp_client_ops client_ops = {
-	.control_remove = hda_cs_dsp_control_remove,
+	/* cs_dsp requires the client to provide this even if it is empty */
 };
 
 static int cs35l41_request_tuning_param_file(struct cs35l41_hda *cs35l41, char *tuning_filename,
-- 
2.39.2


