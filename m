Return-Path: <linux-kernel+bounces-301203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A65D95EDA8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0F81C216B9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8979A145FF9;
	Mon, 26 Aug 2024 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Jf2KuSeo"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EA778C98;
	Mon, 26 Aug 2024 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724665786; cv=none; b=jEemzUCY0/+Hu5LMrbwPXYQIOYjIF1uQ36eFfLaVAM47deuetX6IPQvVhrPDdwZZxKSPMifpYbtD75E36d21V/oDJwVw+0CVgISY+gYnDSSf3lx4vr2Ci9AZaE+BWOvRARkNf1fO45qNNY+Rc+vWVFHhjg3g/+M1tvyrc3s2N8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724665786; c=relaxed/simple;
	bh=RjTuyzJCY9QLNEAgO3+vyXvKJ/nw1ssOx/yZ07sZc0o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i9+kO5hYG+mT5ekfb8SgY2RwMyIyMMAMenGpKK/19wCW2Phc3ZAwZioLoyIG6XC+o+Rvz7YO77KABa6BVjMc10cxLmPMWEfZRooN00/ff8hxLBKdL2DCYpf9OlcW1Gxm0WioGpJArWmstuNxVkJnHPV3ztzzlP3z19I3F8Sj4Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Jf2KuSeo; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q5KxHj015635;
	Mon, 26 Aug 2024 04:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=JL7J2MV/9WledA94
	7J5Ab1DI48Hnm9JBT5wXpkfVIJQ=; b=Jf2KuSeo1cm4syYTv3hXzIO+En8ZI0Gz
	iK1Bp5O66rM5sG/IMP2vvThMGRzFEJ3+iG/yCFafQbnxZ019KXxWTaisCe4iJbjc
	fZef3PQ1iqb1HtfXxZxMAy3wmroXPUs3ceQ+YHReDjn7OZGwOb9TSux+rHPGLBST
	ykcTeG0olEled4GLUtt3t00FSkMW/jpYixhy/j/YRUyG1rTwITDPHwhvVWlU7er5
	f2JuENjf2lNEVGDJkSZMnGAA+cmg9of6Q4V+WqbHHNuXcolTIZ89gko55j1M0hZH
	XjkKkkopMPRDHzr1udc9MH0PhxeOqrUdCV6QJrK1jZEA+6s6TPnjJQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 417cwxhenr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 04:49:42 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 26 Aug
 2024 10:49:40 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 26 Aug 2024 10:49:40 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 67040820249;
	Mon, 26 Aug 2024 09:49:40 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda: hda_component: Fix mutex crash if nothing ever binds
Date: Mon, 26 Aug 2024 10:49:40 +0100
Message-ID: <20240826094940.45563-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: EgbLWJzl1q8sUgGO0GHI488JH-oHorCk
X-Proofpoint-ORIG-GUID: EgbLWJzl1q8sUgGO0GHI488JH-oHorCk
X-Proofpoint-Spam-Reason: safe

Move the initialization of parent->mutex into
hda_component_manager_init() so that it is always valid.

In hda_component_manager_bind() do not clear the parent information.
Only zero-fill the per-component data ready for it to be filled in
by the components as they bind.

Previously parent->mutex was being initialized only in
hda_component_manager_bind(). This meant that it was only
initialized if all components appeared and there was a bind callback.
If there wasn't a bind the mutex object was not valid when the
Realtek driver called any of the other functions.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 047b9cbbaa8e ("ALSA: hda: hda_component: Protect shared data with a mutex")
---
 sound/pci/hda/hda_component.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_component.c b/sound/pci/hda/hda_component.c
index 7b19cb38b4e0..b7dfdb10d156 100644
--- a/sound/pci/hda/hda_component.c
+++ b/sound/pci/hda/hda_component.c
@@ -141,8 +141,7 @@ int hda_component_manager_bind(struct hda_codec *cdc,
 	int ret;
 
 	/* Init shared and component specific data */
-	memset(parent, 0, sizeof(*parent));
-	mutex_init(&parent->mutex);
+	memset(parent->comps, 0, sizeof(parent->comps));
 	parent->codec = cdc;
 
 	mutex_lock(&parent->mutex);
@@ -164,6 +163,8 @@ int hda_component_manager_init(struct hda_codec *cdc,
 	struct hda_scodec_match *sm;
 	int ret, i;
 
+	mutex_init(&parent->mutex);
+
 	for (i = 0; i < count; i++) {
 		sm = devm_kmalloc(dev, sizeof(*sm), GFP_KERNEL);
 		if (!sm)
-- 
2.39.2


