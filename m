Return-Path: <linux-kernel+bounces-204316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 359FD8FE71B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A063B1F261C2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED1E195F1C;
	Thu,  6 Jun 2024 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="FH0FLrN3"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EDC195B33;
	Thu,  6 Jun 2024 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679186; cv=none; b=PQLOU1e0+vysJxvhNMi3M3WlTUT69BR178bvejihGToQZCkNH6jaK4PqDA9hbuV4Gj1mcvXOqDfeTWYd2mkndS07AImzP+7LZ9SoBBkvFOItRRtWMWIP+CySsUl71h/KrkOruGyFvwASNbWMLZd6A7yROns/nXwnMau4s1BqdUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679186; c=relaxed/simple;
	bh=0Kx8hqLQGitntoFzXerDXeNFIOulpKRW07HQjXgMiFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uFTRTJSSg3hcSUn7KUH6k6kvueTjMxdZP5NkWt2WVQjRhpTYX/F9o/b2FyjBiVGFUbFZXLeehwxM/iYvgGnq/HibDLvz3m1IBvq3JhL+E5RZtdL+6VqOFEQ/q819jIz4swwnXuL+kWNTerYffrdjzfp9IfbwG46EGZrYZUCAaWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=FH0FLrN3; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4565uenA010646;
	Thu, 6 Jun 2024 08:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=PAh85hwQZsafzP/3SaO3leBJB50ZLINVkNpAHcoAWn0=; b=
	FH0FLrN3m0ebJQajGy5R35N9fc0ADA4OorqFqdXsCWpWfOrqoI/XyUB4oObjvcTn
	z1BZ1onkKznYp4zxkW1ArUBRLP4BU6UsLWiiBeWVBAw+8uNHEVEPD5zcOk33HzJY
	FwPzHKT/kij1//NZ/FB36tb3QhE6Mu5eGMMkEnnzZDMEP0bicpXit+xdCcDUb1eH
	jWLGG/WGTaVC/NUefJX2L4tRMuvwOBWWgKkZQKlQ774iWRVUF8hm8kPmdMYze4JX
	GNc3ed2buvsmZyA3rsY2sfatiI67tk5CsRS3IKZqo8niwRHBH21rSCLE5r8gsSDJ
	9ginf71nzCv+ex8JD9pQ/Q==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3yg11xw66m-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 08:04:06 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 14:03:57 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 6 Jun 2024 14:03:57 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.61.65.44])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 2F844820249;
	Thu,  6 Jun 2024 13:03:57 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 2/4] ALSA: hda: cs35l41: Support Lenovo Thinkbook 13x Gen 4
Date: Thu, 6 Jun 2024 14:03:49 +0100
Message-ID: <20240606130351.333495-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606130351.333495-1-sbinding@opensource.cirrus.com>
References: <20240606130351.333495-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: qDjOc460vRMTcMGS1p0QVrb9FTBBXQgL
X-Proofpoint-ORIG-GUID: qDjOc460vRMTcMGS1p0QVrb9FTBBXQgL
X-Proofpoint-Spam-Reason: safe

This laptop does not contain _DSD so needs to be supported using the
configuration table.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 046a94250683..51998d1c72ff 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -128,6 +128,8 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "17AA38B5", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA38B6", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA38B7", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
+	{ "17AA38C7", 4, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, CS35L41_LEFT, CS35L41_RIGHT }, 0, 2, -1, 1000, 4500, 24 },
+	{ "17AA38C8", 4, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, CS35L41_LEFT, CS35L41_RIGHT }, 0, 2, -1, 1000, 4500, 24 },
 	{ "17AA38F9", 2, EXTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
 	{ "17AA38FA", 2, EXTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
 	{}
@@ -531,6 +533,8 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "17AA38B5", generic_dsd_config },
 	{ "CSC3551", "17AA38B6", generic_dsd_config },
 	{ "CSC3551", "17AA38B7", generic_dsd_config },
+	{ "CSC3551", "17AA38C7", generic_dsd_config },
+	{ "CSC3551", "17AA38C8", generic_dsd_config },
 	{ "CSC3551", "17AA38F9", generic_dsd_config },
 	{ "CSC3551", "17AA38FA", generic_dsd_config },
 	{}
-- 
2.34.1


