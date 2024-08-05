Return-Path: <linux-kernel+bounces-274542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 468659479D3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6DFD1F20F46
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740B31547DB;
	Mon,  5 Aug 2024 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WUWXTUrj"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C841E505;
	Mon,  5 Aug 2024 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853797; cv=none; b=NB3jxOKtI2Q4RLcDeC93f9VgyiPAuGSvR5QNpeuAY64L28Y0gtSC19a3+ZEpEkrNTvQUj1kqaIupCCoX9c/chP2bHPWrOT9V4Ru6RVbCWW6lsLjLz/v1f33mUyFq+b14rMK9ucVN0HWEJZzI6E2mcEgiqlTf+3BM02p6WQ5+5xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853797; c=relaxed/simple;
	bh=ZeqSfLoissZBrgzCEz1AO0KXc11j7fM6/NaCc3pgp7g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G15Cyb4+dwO1D0buPeShgDX/aF8yImEz/XpBtTMzeIWp2TixPqwLkmge2D5tsJeSHq7WNptNC8cid/qf0CIBz5KNvyKHpwnabc9iVBGvdE9Fr5nLjM4LabNEoyvuTH5vedClU7X+qc5x3u6/9LusFBzKMZX53DiMuV+HTa/uddw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=WUWXTUrj; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47571BNJ029909;
	Mon, 5 Aug 2024 05:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=3SsXaADfYXmkfGdF
	EQ8BqI7QxDoQ1bVhx0E6UcjhWAc=; b=WUWXTUrjsFapGsgTKQVMEPNHnfKVfkps
	M1wmzCsUqkstq+9p788Gm32EXrpD5GXWH1sqQqIrt+dLrVMCupM9huYos+zs92q+
	ffkoENxY4mMCvws0lEkZ1YsHMko8iZGfla0uOLuT8OXZwl+buuUP4FyyiQWXAnzy
	YL0W2v9qyRjX6prsfuFBFcH1tvoOE/YdlTjSjJtK1Q8Gqz8LfSOAVXagD6Tssye1
	LsHcqswkjE0mgSCHX4YskAA0TgK5qgUjdmp8CtqQW6+a6OXCecWvAWrs3cCTHbtF
	SyU6cRtkBj+DHpE6ODuj+z5z6/4d6obl4Z2MRVoJxT9kZE+j0QFX1A==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40sgyhsmt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 05:27:40 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 5 Aug 2024
 11:27:39 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 5 Aug 2024 11:27:39 +0100
Received: from lonswws01.ad.cirrus.com (lonswws01.ad.cirrus.com [198.90.188.26])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 0562A820241;
	Mon,  5 Aug 2024 10:27:39 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>
Subject: [PATCH 0/2] ASoC: Extend wm_adsp so cs35l56 can suppress controls
Date: Mon, 5 Aug 2024 10:27:19 +0000
Message-ID: <20240805102721.30102-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: y4efbioVgD9Uc8QXDjlnAqFMtOy9A9lO
X-Proofpoint-GUID: y4efbioVgD9Uc8QXDjlnAqFMtOy9A9lO
X-Proofpoint-Spam-Reason: safe

This pair of patches extend wm_adsp to add a callback that can be used
to control whether ALSA controls are added and then tweak cs35l56 to use
it to suppress controls made from firmware coefficients.

Simon Trimmer (2):
  ASoC: wm_adsp: Add control_add callback and export
    wm_adsp_control_add()
  ASoC: cs35l56: Stop creating ALSA controls for firmware coefficients

 sound/soc/codecs/cs35l56.c | 11 +++++++++++
 sound/soc/codecs/wm_adsp.c | 17 ++++++++++++++---
 sound/soc/codecs/wm_adsp.h |  3 +++
 3 files changed, 28 insertions(+), 3 deletions(-)

-- 
2.43.0


