Return-Path: <linux-kernel+bounces-232446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A7D91A8F3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0642851EA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971EB198842;
	Thu, 27 Jun 2024 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="a4XRwywB"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5111946BB;
	Thu, 27 Jun 2024 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497683; cv=none; b=ZrAHzSSoSqnW+DyIpFUqkE5VeQKVT4/hwennOYA0HBXZZpWjh7B2W3RSlrFrGXEsnJO+trSfeS9vp522C21lidTB+KquMEzBK7+oLA6TkRadBQP6xw0qpuIKQPC9rQ8m+mWaKyeZmdUGHrT1g7RazPw+EXS6zjGVOyva/ixivXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497683; c=relaxed/simple;
	bh=OQ0U4kjpqazjir74iOIxPPwvSKrOayMnsLvpYVcMIPs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GtFNaTR9gFlK4aQq/LuXMF5h82PA4IhhuMczYde4487sL7NSI4wJOHJOGJuSprgpL3oD9GQCK+GqDluOlrfmUuSqWZO2brT5C1sjmSN7RbC2ZQMyowIR+1DAxNLFhq9EnGQr3bvzXWpZqLFJl7QP5fZ7kmoj62tP9GH3R8gdJTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=a4XRwywB; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RCpZV9009358;
	Thu, 27 Jun 2024 09:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=MCVtrJtn2IVRVV12
	a/GpV1qk2cW+zeuMidMKP6Eg6FY=; b=a4XRwywBjRsYPB+vFcyH9JdsCtezXVLj
	IZG11DhzbmBA2dV35iuUtvHOQjCyYnH/RVnRv1J4Sf1es73e2sCpaNFezWTY01jf
	o0BdUHnEnAS73LSl4Fzbn6lUkIZNfYVkb7ZWXWI8Fru3u2/Ye99GeAf/yNcrAnAz
	lkkRyjuYsWURoTh+FiVtmw25r/yOc/PF3NXDSX8Ud/Kz7+YG58oo/y+ALXzXLTEm
	isn2ojniBagL2GrOgr8xRBgvnQvoO9VLTEnAN/UcuVZZgA+KqQg1QReN/iHsJ0/w
	GSdzvz3pu0IW7v37B7I1VApuaMf8KOXbtjqyQDllpYN5nNBewwqbrA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 400nbds7rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:14:34 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Jun
 2024 15:14:32 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 27 Jun 2024 15:14:32 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 54B3C820270;
	Thu, 27 Jun 2024 14:14:32 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH 0/4] firmware: cs_dsp: Add check to prevent overrunning the firmware file
Date: Thu, 27 Jun 2024 15:14:28 +0100
Message-ID: <20240627141432.93056-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: NqvQZcRcVTqnG_vpKPiSt7_IRLYcV8ql
X-Proofpoint-GUID: NqvQZcRcVTqnG_vpKPiSt7_IRLYcV8ql
X-Proofpoint-Spam-Reason: safe

This series fixes various missing length checks when processing
variable-length data from the firmware file. These could have
caused overrunning the end of firmware file buffer, or wild
pointer accesses.

Richard Fitzgerald (4):
  firmware: cs_dsp: Fix overflow checking of wmfw header
  firmware: cs_dsp: Return error if block header overflows file
  firmware: cs_dsp: Validate payload length before processing block
  firmware: cs_dsp: Prevent buffer overrun when processing V2 alg
    headers

 drivers/firmware/cirrus/cs_dsp.c | 223 ++++++++++++++++++++++---------
 1 file changed, 160 insertions(+), 63 deletions(-)

-- 
2.39.2


