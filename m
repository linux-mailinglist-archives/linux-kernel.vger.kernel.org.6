Return-Path: <linux-kernel+bounces-197051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C538D6581
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065BB1C26BBB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A10D158D9C;
	Fri, 31 May 2024 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="iTY6TGm1"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184BE13D63E;
	Fri, 31 May 2024 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168531; cv=none; b=pCC+yg3aQV65C5osxpWTTxmH9+3/xNYa4cnTsRglQ4lJhNC1AZSbY6vl3PsPtryaUZ3tCn6NfNvc6mtNneDkAWQS5UkCe2GHGZDWLuu4duuqIOJm+XwNQXD76Op9osacXHqNRVHL6rW+h655F3COwAQqcqWvBtyBMAIMjsp67+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168531; c=relaxed/simple;
	bh=z9ks63cL85mhkLcOnvb3ahawtzRr8EIrpG1aeu2Bwrw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lDv1UcmkMk5Fn6tSb8CBdFQvHC9LXTSL5wgZwOsUGDBdiLxZE/cljJmkTddI4FbXgOtPfz8zqbaBrVqNjtTOlKYfnEdfxtQl5h4E8mFfJG1SuiRrdGFgLnB2Zq3Zq74URPv9CQlb5L495b0gz8aUsetWQo2bgJAthcmHG1PELmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=iTY6TGm1; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VB0WSp017940;
	Fri, 31 May 2024 10:15:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=Y4m3MsoMsbca1Nbl
	2qGve/cq5PJ1F3O1UChPigH7UYU=; b=iTY6TGm173K86uJPMzauwmZBBRUaT8ht
	vVDCHirFRueYxgEotoeze4uPnqIMGf4zSMw+LV2GSsZjxxr13xpJolO+iS+YNuyv
	6eBsrKU6L0Avdfpp4X5Z9LHIpz04nJk1M2mt1cLRXPGizcqY9ek/dqjKpXfsgmaC
	xkagPnSpCZqkgSoTYWLk32o4xrCjBQfksPbvO66Xf41DBtkmXtBk/GiBjYFxtnvb
	quJvZyy6YtvJ/OYGs4W5/NqnyvHqTPr3QdoLfbpMJ0GDtJGP70PhGJga1l3yWmGp
	fnXHLzdiiXXWkk6ud4IQLgO23XIGEIND9swo3JAGpZ/7SzI3mux/HA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ybcdhe0a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 10:15:11 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 16:15:09 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Fri, 31 May 2024 16:15:09 +0100
Received: from EDIN6ZZ2FY3.ad.cirrus.com (EDIN6ZZ2FY3.ad.cirrus.com [198.61.65.72])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3D1AA820244;
	Fri, 31 May 2024 15:15:09 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <soyer@irl.hu>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <kailang@realtek.com>,
        Simon Trimmer
	<simont@opensource.cirrus.com>
Subject: [PATCH 0/7] ALSA: hda: Improvements to hda_component
Date: Fri, 31 May 2024 16:14:02 +0100
Message-ID: <20240531151409.80284-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: GGAIf1TMiFTYMryBMBZzhBn6acOXJBAv
X-Proofpoint-ORIG-GUID: GGAIf1TMiFTYMryBMBZzhBn6acOXJBAv
X-Proofpoint-Spam-Reason: safe

This series of patches makes sure that the existing consumers of
the infrastructure unbind their interface before they begin
destroying the driver, moves duplicated members from the
instanced component structures into a new parent structure and
introduces locking so that consumers of the interface do not use
stale data.

Simon Trimmer (7):
  ALSA: hda: cs35l56: Component should be unbound before deconstruction
  ALSA: hda: cs35l41: Component should be unbound before deconstruction
  ALSA: hda/tas2781: Component should be unbound before deconstruction
  ALSA: hda: hda_component: Introduce component parent structure
  ALSA: hda: hda_component: Change codecs to use component parent
    structure
  ALSA: hda: hda_component: Move codec field into the parent
  ALSA: hda: hda_component: Protect shared data with a mutex

 sound/pci/hda/cs35l41_hda.c     | 47 +++++++++++---------
 sound/pci/hda/cs35l56_hda.c     | 29 +++++++------
 sound/pci/hda/hda_component.c   | 76 ++++++++++++++++++++-------------
 sound/pci/hda/hda_component.h   | 48 ++++++++++++++-------
 sound/pci/hda/patch_realtek.c   | 17 ++++----
 sound/pci/hda/tas2781_hda_i2c.c | 37 ++++++++--------
 6 files changed, 148 insertions(+), 106 deletions(-)

-- 
2.34.1


