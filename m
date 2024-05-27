Return-Path: <linux-kernel+bounces-190408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A738CFDEF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B905EB22212
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5F213AD12;
	Mon, 27 May 2024 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="h0B7aYnF"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53027DF60;
	Mon, 27 May 2024 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716804814; cv=none; b=hvP1iHLCtvgoHWDUmjnQPED6U4uQvW7r9wBQFlNYvnYP9Ieu2/yvBvDD+wbMO24qW70xjRH+dTVYfnUG2bWHK0Z5D5w46xzwzONM2r+WkiVe+4jlBMGECi50qGYJVNtVvjMREksW+RLDidgjrogJfrCoO8fpOeiLMPxh2ugnqMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716804814; c=relaxed/simple;
	bh=vGTDta5cr4YnLhTy9vZYMIz6pfgtC+BMB/uANO4R624=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u5mE9QFAU7Kk6bE5CMo6Irfr9XKMfgkHw+j1OooH63Fc0ubJix5RVYpUCkjgZpGcSw6XMdhu4+ikJHsqYoDVlYArzTOJH6uQMFtGAmdmMMW+0YJ08apdd3dOzlyKpsA1PPgPq0HozzoyDPf8EY0a7cEoDdVHkLRVK5fLgWOu3WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=h0B7aYnF; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44R72PqS010857;
	Mon, 27 May 2024 05:13:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=9v5Sit+UNcMkGJqw
	ZJxWcCcxnPrTKllqGqdXUYIyndE=; b=h0B7aYnFfI6hjV7KwPUgT/iMzYrzzoZJ
	t8qltkt73Ll+jtk1pFPrP69PuQmEGP30dxCcYYEBIIufq9/n9NhuZB2W2uM5REjJ
	KWrSsbhyUXpwrkxyku3bv5mNImyGMAw7hGstksA8heJgb6RhvtvGrk8eCm72EPBw
	J30EXX8lkpt/LzLNQYNga3DOtlPutX6MMXynbPgotoNA+m6NIN4z3rz9CBlhyCK9
	9rJWoyuo8fncXd7An47RwltQ/fbnGJTv9kuZBEieOcQP4Kv88XA0YZXcap8B6ni8
	aBgphBsfCcPdKl1XcNbe4g0FhgwTn7v7B2whhoTJY0b27d7VgKD4Aw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ybdcws9s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 05:13:29 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 27 May
 2024 11:13:27 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 27 May 2024 11:13:27 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id E84A4820270;
	Mon, 27 May 2024 10:13:26 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH] MAINTAINERS: Remove James Schulman from Cirrus audio maintainers
Date: Mon, 27 May 2024 11:13:26 +0100
Message-ID: <20240527101326.440345-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: aY3ADv1RmAiA9svDEXnkT2zoyUYBMGWa
X-Proofpoint-ORIG-GUID: aY3ADv1RmAiA9svDEXnkT2zoyUYBMGWa
X-Proofpoint-Spam-Reason: safe

James no longer works for Cirrus Logic, remove him from the list of
maintainers for the Cirrus audio CODEC drivers.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dc6818d0938d..f056140236f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5040,7 +5040,6 @@ F:	Documentation/devicetree/bindings/media/i2c/chrontel,ch7322.yaml
 F:	drivers/media/cec/i2c/ch7322.c
 
 CIRRUS LOGIC AUDIO CODEC DRIVERS
-M:	James Schulman <james.schulman@cirrus.com>
 M:	David Rhodes <david.rhodes@cirrus.com>
 M:	Richard Fitzgerald <rf@opensource.cirrus.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-- 
2.39.2


