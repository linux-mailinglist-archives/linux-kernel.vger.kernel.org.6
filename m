Return-Path: <linux-kernel+bounces-237646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BA2923C15
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19EE2840DD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5E615AADA;
	Tue,  2 Jul 2024 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XTCLedTV"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2762158D60;
	Tue,  2 Jul 2024 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918516; cv=none; b=eWDsre61afwh19Mb0x2FYVpvpnvXy3MJN9z4NY//zXsRYaZo7A/1U7FEeH6k1mqPL2haaOiO+PcGvy5r2EfGEAkTVczLadMOEjJn07KVruZcZcmxD8jeu0Da7lZCv94urlAJyx4QSraF/t1QE1uLHRtblJlt45+sHNU/FDri0h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918516; c=relaxed/simple;
	bh=n5no851s4EqSpb91NEEhXc2fA3vfWAjE+sOHLwT1ZGw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ESQiRVPCAxt0aliY7XtE9H762TjWOt3+kE57Sb/g0bmhr/0ipAgy+2EW7WJdZv8ij9i+7JTQL9/D3fE/DO8EM7bnJb0o0OyEOBpTG9aKhRiJRRZlYHLl/k8sTxuU6fSu9AWjT+qcPJllWO0/WGrr6UP428/YyNQThY0hfVVCSkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=XTCLedTV; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4625w9tW022383;
	Tue, 2 Jul 2024 06:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=CSRl7sRT2Z1oI9e6
	B+Pg7fpYU5oWGS/FDqjHOl/KzEw=; b=XTCLedTVv4JZLYIn154fQ85Qmh81g3XR
	oXmb7G3Es5qBRlGDMdD+xRIG0LjsMbtVzPGAwzkxeMmiZ90v/9sBSbDuGbbY8DDh
	fI1qLRqvrEWm8kpZmJmwyScQ1guUQkbifTDiE0KqJF+PeE0IFOQgaGynRgYWSR1V
	O3jb/BauAXuZhHW6YVABNxk++jjuHEwSerhmxruPbrlISSzL3itSOt3kYWQxCZIm
	+eEuIf+ibxnCRofROi/DguDoAkblIRH2efkgkfpOonyyjJE8XKJixb4CRyp2iE5W
	uH3bfDGyT7Cm5Db5ELYc1bJcdq6OLkM0iLAIBpHvl6+yDMEnMt5Ltw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 402epjbte7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 06:08:14 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 2 Jul 2024
 12:08:13 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 2 Jul 2024 12:08:13 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.68.170])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id AE3BF820244;
	Tue,  2 Jul 2024 11:08:12 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH] firmware: cs_dsp: Don't allow writes to read-only controls
Date: Tue, 2 Jul 2024 12:08:09 +0100
Message-ID: <20240702110809.16836-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: lBNBSqB8R0zprM-c8oEhesQYylmjmetz
X-Proofpoint-ORIG-GUID: lBNBSqB8R0zprM-c8oEhesQYylmjmetz
X-Proofpoint-Spam-Reason: safe

Add a check to cs_dsp_coeff_write_ctrl() to abort if the control
is not writeable.

The cs_dsp code originated as an ASoC driver (wm_adsp) where all
controls were exported as ALSA controls. It relied on ALSA to
enforce the read-only permission. Now that the code has been
separated from ALSA/ASoC it must perform its own permission check.

This isn't currently causing any problems so there shouldn't be any
need to backport this. If the client of cs_dsp exposes the control as
an ALSA control, it should set permissions on that ALSA control to
protect it. The few uses of cs_dsp_coeff_write_ctrl() inside drivers
are for writable controls.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/firmware/cirrus/cs_dsp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 16484ab9b09d..be8747d227db 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -796,6 +796,9 @@ int cs_dsp_coeff_write_ctrl(struct cs_dsp_coeff_ctl *ctl,
 
 	lockdep_assert_held(&ctl->dsp->pwr_lock);
 
+	if (ctl->flags && !(ctl->flags & WMFW_CTL_FLAG_WRITEABLE))
+		return -EPERM;
+
 	if (len + off * sizeof(u32) > ctl->len)
 		return -EINVAL;
 
-- 
2.39.2


