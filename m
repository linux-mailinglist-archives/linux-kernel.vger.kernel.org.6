Return-Path: <linux-kernel+bounces-197052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54C58D6583
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433FF1F2799B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C485158DBA;
	Fri, 31 May 2024 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="YXdV7O+d"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183D978C7A;
	Fri, 31 May 2024 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168531; cv=none; b=gqxN3nUyFRMhSqYHyDG9XGUJ+L7F4kglyd0RnlH98olBU2zqOJDbVdvcKaVATacVRrlyphSWTo4Dh2sy7nIlwj7gq5KSpa0lFzXyT8TB8c1JeD/Xvb/3zsIE7ENfq4TpAqhTTHN4vm6Pg2KOZn9XJEvSLqwfMBQvYjU16i2UnlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168531; c=relaxed/simple;
	bh=fY7MkT5JoP238inIzvp80l8R/QuTlnYxL8jXzTxaxIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jcp6sGrX3o9V3wQ4SukQXmKFT7Qhp8TOMpCcjudv3vBDZf92+vbXq5E0PcExTOBXDRn1kLQwHh7/kfS7LuPUvAZYzd0oweSB3FM7mBNZ8qKMH2rIxYSyiTXTiBLtk6sKl+J/rO+BRgEAxK4atNOTwe5x+KJ7vzfWyQgAEEEPRcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=YXdV7O+d; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VB0WSs017940;
	Fri, 31 May 2024 10:15:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=/31H52Kx5dI0pIOnMzUjAMQTByFunlPMmeUhLGzbe3M=; b=
	YXdV7O+dAioIHxo99tthgI5iI/xwthaDzsjt0ywr7hs4qN2g7mPYhtI7bgWsLDeV
	Pl4kxGunRXSLIxavNE5hcGfM0cgBa9+P7y941bdcRflcpnhY730uSQLJ34FQnY4G
	DcXupyofUqbpvZg5ia4MKDnx32ESsTo+MIGE7kvz3KDoJyN98BVbmp1QZkPfm3Qt
	Rp43I+CT93QGsHwWB1VxO4fZg1Tg4r34OQS7+B9rof0BAhJiFLn8WksLHQhgmMAH
	vz1X6p0+b4Ha1CdUWq71RUfG6dbsm9aeNbE4oLxClYwT0vj6aS0Yew2w03tX1yup
	vMZDi9aYMJSaARgB9y1cJw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ybcdhe0a3-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 10:15:13 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 16:15:10 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Fri, 31 May 2024 16:15:10 +0100
Received: from EDIN6ZZ2FY3.ad.cirrus.com (EDIN6ZZ2FY3.ad.cirrus.com [198.61.65.72])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 258BF820244;
	Fri, 31 May 2024 15:15:10 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <soyer@irl.hu>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <kailang@realtek.com>,
        Simon Trimmer
	<simont@opensource.cirrus.com>
Subject: [PATCH 2/7] ALSA: hda: cs35l41: Component should be unbound before deconstruction
Date: Fri, 31 May 2024 16:14:04 +0100
Message-ID: <20240531151409.80284-3-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531151409.80284-1-simont@opensource.cirrus.com>
References: <20240531151409.80284-1-simont@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: HCZRzOeut7LNDgWaToKphYa35UK_rfmr
X-Proofpoint-ORIG-GUID: HCZRzOeut7LNDgWaToKphYa35UK_rfmr
X-Proofpoint-Spam-Reason: safe

The interface associated with the hda_component should be deactivated
before the driver is deconstructed during removal.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index d54d4d60b03e..031703f010be 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -2019,6 +2019,8 @@ void cs35l41_hda_remove(struct device *dev)
 {
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
 
+	component_del(cs35l41->dev, &cs35l41_hda_comp_ops);
+
 	pm_runtime_get_sync(cs35l41->dev);
 	pm_runtime_dont_use_autosuspend(cs35l41->dev);
 	pm_runtime_disable(cs35l41->dev);
@@ -2026,8 +2028,6 @@ void cs35l41_hda_remove(struct device *dev)
 	if (cs35l41->halo_initialized)
 		cs35l41_remove_dsp(cs35l41);
 
-	component_del(cs35l41->dev, &cs35l41_hda_comp_ops);
-
 	acpi_dev_put(cs35l41->dacpi);
 
 	pm_runtime_put_noidle(cs35l41->dev);
-- 
2.34.1


