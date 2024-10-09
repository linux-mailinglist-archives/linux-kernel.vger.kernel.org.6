Return-Path: <linux-kernel+bounces-357208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC1C996D92
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53B3F1F22062
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E158619D097;
	Wed,  9 Oct 2024 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="vNiavDZ7"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC3D199FDD
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728483846; cv=none; b=ezundsA0/eIPyNSXUA2YKWTj3UJaoLREIgnrtXoAh4lnH46/2v8oysjNmFIKiuEE3iqTP3FRzYYg9wDEcMGeOi8apNKQhAJUnEENe+kvxHcGZ8N61OLcXuhL3sZ/aGbwKSiyfJrUaqN+Mjypo8XDfWi6sGTanU57jhhWaD7bSSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728483846; c=relaxed/simple;
	bh=H6xXvQuMHVTtf9QtTh7Oq+emPniY5I1qE+Fp5rmLsRc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X0c2rrZK5n3gm7cNpAyjqZZU7NMgm4wVM2OeXqJbWo+Es3Rh6zMTlEETm1V/wW/9Pg1PqTEDF4MtP75Q6ow1wpH5Q79j+sJzWruSeJMs46wTuJ7yfWZeNl9P8Wv74JWWGfQMyGOWlNVpKqN9KDjZurBAX0YlhXws7Ul+Qg17Wq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=vNiavDZ7; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499CndOo018680;
	Wed, 9 Oct 2024 16:23:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=fdirs8B0Ru7Jst3Sjcp88b
	8CTT5n584TdaQblKHqoyQ=; b=vNiavDZ76zocScRt2Yv6pMFoKwJYgP5gg6ECMQ
	CUy3O5XRT5E7licYiFoMBQJCAIMWtOLuz03Kv3IcsN/oT9iLV6GThOl0pjDujYzm
	vY1RdMIiFQBap0v8YUhCPpBspnVI6kLQfijtBBkk2EEv/S90RNVGQM/+Qz+GBpd5
	89XA4s7yGO/3wvt6x1acR/KXDISIjwHkyj5L/NV3dJyPYgVHjoKq7+ITE9/VLlv/
	94ozbv26/nSnzf1M3Ozuw33QP/73dRvtwcBGW4Wkcyxd9QuE9HfWfx15FWzH5I6L
	oNbBNBO/1Bb2A9DbrXmRBDTKej4Pm5Ul1i8EYwfjDTAfcA9Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 423gdmsab6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 16:23:52 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D50A240045;
	Wed,  9 Oct 2024 16:23:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 38B382606C6;
	Wed,  9 Oct 2024 16:22:37 +0200 (CEST)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 9 Oct
 2024 16:22:36 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <linux@armlinux.org.uk>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <christian.bruel@foss.st.com>, <alexandre.torgue@foss.st.com>
Subject: [PATCH 0/1] Fix protection fault during kernel relocation
Date: Wed, 9 Oct 2024 16:22:21 +0200
Message-ID: <20241009142222.1489500-1-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

A trusted boot firmware might set the CTLR.WWN bits, preventing execution
of the relocated code treated as XN permission.
Another solution to clear the CTLR.WXN and CTLR.UWXN bits but would open a
security breach.

Best is probably just not to use the Client access domain here.

thanks,

Christian Bruel (1):
  ARM: decompressor: Use Domain Manager Access permissions

 arch/arm/boot/compressed/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1


