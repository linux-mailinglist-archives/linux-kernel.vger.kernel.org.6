Return-Path: <linux-kernel+bounces-204317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E5B8FE71E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F091F2639E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09000195F06;
	Thu,  6 Jun 2024 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ni+GTbJJ"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00A5194C99;
	Thu,  6 Jun 2024 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679226; cv=none; b=tFBeOlk9aC72QqpfNU5waqU5keQnp5gNFTD+gyATHSAOxnB7YnVY6nvhy5was9tnW1Fa9JLVXq67E03vFYKoezNf51OCWUSX+hTfIHYdhs2TcsqSUXguLwd5v0paTICVUyEuBaZKVijSe1o2a+97Du2q4aD2bgvMg4RSxZP6/DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679226; c=relaxed/simple;
	bh=ri0OOOZWNRWsh9jBgHeTZuU2Qt1Eq8KklkhcUpeO8/E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E2Z8GZUkx3VwqS8XEGFlISUGnVmbmhCoV5vEOV2cwnFj7RjSgmastBHFdfciyk95vtYoiM33MMK2h7OmVNDErU62q8rZFTe7Ppy5HgSPF71/SvOq5V/5N6/44DcFEvIVfQWIw2Oza6cXC+7lNZWARnOACI85sBE+HY5H74bNemk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ni+GTbJJ; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4564ueAZ021615;
	Thu, 6 Jun 2024 08:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=ITJde61E7SQb6Vol
	mPyc4UokVhSx5f60rcqehJhVu64=; b=ni+GTbJJ3hwFOk/GR43llLiiLeXLD0N9
	66x3+YSV1ou4v+gAuO4i89htcg+Ja8tXLEm2l/8d1ytiNabnWLtZ7ti16PHShSs0
	QJjUGZ3E3CTMtQ4abHvZfOAnfaHFZS2sZEf38dhZPcHiRF5pm3LUtDRT3qvVwz/b
	z5DpeA85zxduJZkYXcoDdUuvdlajCLqc8W68W4TmOMpPY3uSaO3J9OMP3WYG1ady
	MXaZHw5JkdNlEfgOESKQs2HVhHYS7VUg2057avmSiAD03EzOvGNOGS/vBrq6ccD+
	szR4PXRWVXdO0kb5syPbltXfa+F3p2zDqwE1XtH1/UbXx9pblSnTMw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3yg02hn5xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 08:03:58 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 14:03:57 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 6 Jun 2024 14:03:57 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.61.65.44])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B6ACF820249;
	Thu,  6 Jun 2024 13:03:56 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 0/4] Add support for Lenovo Thinkbooks
Date: Thu, 6 Jun 2024 14:03:47 +0100
Message-ID: <20240606130351.333495-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: N30JcssQ8WSJj6oXqXQV0dPfca5Q4bqG
X-Proofpoint-ORIG-GUID: N30JcssQ8WSJj6oXqXQV0dPfca5Q4bqG
X-Proofpoint-Spam-Reason: safe

These laptops do not contain _DSD required to support CS35L41 HDA.
To workaround this, add support for these laptops into the configuration
table in cs35l41_hda_property.c.
Also add the required entries into patch_realtek for this SSID.

Stefan Binding (4):
  ALSA: hda: cs35l41: Support Lenovo Thinkbook 16P Gen 5
  ALSA: hda: cs35l41: Support Lenovo Thinkbook 13x Gen 4
  ALSA: hda/realtek: Support Lenovo Thinkbook 16P Gen 5
  ALSA: hda/realtek: Support Lenovo Thinkbook 13x Gen 4

 sound/pci/hda/cs35l41_hda_property.c | 8 ++++++++
 sound/pci/hda/patch_realtek.c        | 4 ++++
 2 files changed, 12 insertions(+)

-- 
2.34.1


