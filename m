Return-Path: <linux-kernel+bounces-568524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54139A696D8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B549719C4B29
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3421209673;
	Wed, 19 Mar 2025 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="eI9FaOJL"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990801EB5F9;
	Wed, 19 Mar 2025 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406693; cv=none; b=M/6ynEzaxE2X0jG4WSiOZbJ764MAOg8HofVLXoiVYOroLgFwHZcnAwvVA20HfCGc5PHpI/TF/ar6cibF11jo1AmzNSF6s2YigeBECzyZ5TtggiB7m8zCrY7AxQq57Ipa1QVvHzPGMk9nG0nV/kscSLtXpYX8klYjOoiG8vjOqrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406693; c=relaxed/simple;
	bh=//kwESiBw8osfYUnhjpfIVwLkjAF8lZ3P1LOHrfzOLA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Um86Ng2UcbHrRN0IBYtnuni/c5Pv9FrYAyFHTy6BWJ07TYZd3BWkMFtzpuQ7G/j3AURle2Mfl+TLfJLGcbWm6y/M1M64sEsSKypeXxQ6NtZy78qUKWsIKGrvc895KrwDAwFk/yV13RGPURH+OCS4Xo4R9HX6V70VDyn8iiCIQtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=eI9FaOJL; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J5OEjR031622;
	Wed, 19 Mar 2025 12:51:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=YC5umwHEYlIvy34O
	aXqTR3ITq5H1NFCF8Py0BCcg1hI=; b=eI9FaOJLoMjWOrUQxp4LwSzDgXyHAcWr
	PU9pHRVkEz8ex83SIH3ZYeZYBWjBLVs2Ojcf0vpCedKcUlq8ejOgDF/WzKOv7BTL
	+8MHS4q5WbDsF4r6r43GacmtSV03jFYCYQiWpAU/f00afti158r8TDJ4jTOKzgXB
	DLfZK9gEzRBh61Ekv19LKr6kXoEVHIoho//DHZ1LZ0aKKvnqWCtFMJfz2ScPQESx
	ZLGzNf657FArGkRWI0R4rsT+uG53gdSVoyJTt2IBGZvAvkQGKOVn+52iWd6JRSGB
	PTzBrxNYOEOha4u1JVSCWsWtah2f7fgN+y37td1Rq9vrt9bhz8gaSA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45dc0mtgjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 12:51:26 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Mar
 2025 17:51:24 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 17:51:24 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id EC47A82255A;
	Wed, 19 Mar 2025 17:51:23 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH v2 0/3] Tidy up ASoC control get and put handlers
Date: Wed, 19 Mar 2025 17:51:20 +0000
Message-ID: <20250319175123.3835849-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: AO6uOPoEG9AvhymXZYVHKV7hA3_SLr--
X-Proofpoint-ORIG-GUID: AO6uOPoEG9AvhymXZYVHKV7hA3_SLr--
X-Authority-Analysis: v=2.4 cv=XY+JzJ55 c=1 sm=1 tr=0 ts=67db041e cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=dA91AMQFZq1surh0KrwA:9
X-Proofpoint-Spam-Reason: safe

There is a lot of duplicated and occasionally slightly incorrect code
around the ASoC control get and put handlers. This series add some kunit
tests and then refactors the code to get all the tests passing and
reduce some of the duplication. The focus here is on the volsw handlers,
future work could still be done on some of the others but these were the
ones that most required attention.

Hopefully the only slightly controversal change is the very last patch
which changes platform_max to be applied after the control type is
determined, more discussion in the commit message for that one.

Thanks,
Charles

Changes since v1:
 - Drop already applied patches
 - Move dropping of a couple of local variables from one patch to
   another to avoid a build warning

Charles Keepax (3):
  ASoC: ops: Factor out common code from get callbacks
  ASoC: ops: Remove some unnecessary local variables
  ASoC: ops: Apply platform_max after deciding control type

 sound/soc/soc-ops.c | 116 +++++++++++++++++++-------------------------
 1 file changed, 49 insertions(+), 67 deletions(-)

-- 
2.39.5


