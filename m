Return-Path: <linux-kernel+bounces-274544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1767E9479D5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A75BB2279E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE52155733;
	Mon,  5 Aug 2024 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="c+xSjutt"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01891547DD;
	Mon,  5 Aug 2024 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853800; cv=none; b=NHZF57P6RRhmMMVeApFxwe7uxDBmRyYfVDOpodaLe9pXrrc0+tJS6kEdlzpq0kA4VHzjG3798+TaoBSQcj3XODjmL7dkUOufTJ86wspS/E/Ox9d9wAeKaDWquArg+5y46/BvFcPZBD3MlhP4Qb2+WR3wFEpRoceC/YQZJqOyQcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853800; c=relaxed/simple;
	bh=9RcYMtMM4r+MQSxgDOMv3UjOKLUb1JBAjfVJavx3WSE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cz9UNdUYfk7prfW4E2XCU9C7aGLURXq4DD3Pw4tQowE1t/Zcd3OSRcrMKMc4aSn3Txju4L/qGTnQVIe8wfkYsKAiBNLxj19bB3JDiExJj4m9hrc81IvUyU/QV52L6MoHwhTNS/ZiEoGGf/0hC+Zg8vuc7mP4MGx3uaxuPjFXhpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=c+xSjutt; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4755WGqT021667;
	Mon, 5 Aug 2024 05:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=d2cHf22ZBP8FBiZHr6wfdXREEjqKc/hSUSPbj/TXBFw=; b=
	c+xSjuttdqX8ncc91jkijhbgVBzbb9knAtvIarBKShOMSWjlk9CcLux0QEqAWFdP
	cGAtXiE1SlZ6sVH1dDks1tzW7XTo7PanQ4lirmFEW0pnBF4iqpqSrX3XcCywb6wG
	DtZXdNz+lhHKuXIe9pewCTfm0hL+7ecsl/V8hz08jD2aJX+/FtNznhgmGNajqXUS
	1b8q/IWEt/Yd/LC8B95VlV5GpG/YXN0QbhR2VHsG1k6EeC+aDo1CrX334Xay7fa9
	+Jnr3VcOFatHUMdQXVy9l1G+0e0a7o/qMKooYLihqxY3tIbnvmdlaqeBG3TUrZp3
	AlZ61JyVr5Xfe3U1KIP5NA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 40shxx1n3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 05:27:44 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 5 Aug 2024
 11:27:42 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 5 Aug 2024 11:27:41 +0100
Received: from lonswws01.ad.cirrus.com (lonswws01.ad.cirrus.com [198.90.188.26])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id C8A62820241;
	Mon,  5 Aug 2024 10:27:41 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>
Subject: [PATCH 2/2] ASoC: cs35l56: Stop creating ALSA controls for firmware coefficients
Date: Mon, 5 Aug 2024 10:27:21 +0000
Message-ID: <20240805102721.30102-3-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805102721.30102-1-simont@opensource.cirrus.com>
References: <20240805102721.30102-1-simont@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: sBVzMXPYgLNwkSpv0ZkT_I88tf6S0Cns
X-Proofpoint-ORIG-GUID: sBVzMXPYgLNwkSpv0ZkT_I88tf6S0Cns
X-Proofpoint-Spam-Reason: safe

A number of laptops have gone to market with old firmware versions that
export controls that have since been hidden, but we can't just install a
newer firmware because the firmware for each product is customized and
qualified by the OEM. The issue is that alsactl save and restore has no
idea what controls are good to persist which can lead to
misconfiguration.

There is no reason that the UCM or user should need to interact with any
of the ALSA controls for the firmware coefficients so they can be
removed entirely.

Fixes: e49611252900 ("ASoC: cs35l56: Add driver for Cirrus Logic CS35L56")
Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 84c34f5b1a51..757ade6373ed 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -1095,6 +1095,11 @@ int cs35l56_system_resume(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(cs35l56_system_resume);
 
+static int cs35l56_control_add_nop(struct wm_adsp *dsp, struct cs_dsp_coeff_ctl *cs_ctl)
+{
+	return 0;
+}
+
 static int cs35l56_dsp_init(struct cs35l56_private *cs35l56)
 {
 	struct wm_adsp *dsp;
@@ -1117,6 +1122,12 @@ static int cs35l56_dsp_init(struct cs35l56_private *cs35l56)
 	dsp->fw = 12;
 	dsp->wmfw_optional = true;
 
+	/*
+	 * None of the firmware controls need to be exported so add a no-op
+	 * callback that suppresses creating an ALSA control.
+	 */
+	dsp->control_add = &cs35l56_control_add_nop;
+
 	dev_dbg(cs35l56->base.dev, "DSP system name: '%s'\n", dsp->system_name);
 
 	ret = wm_halo_init(dsp);
-- 
2.43.0


