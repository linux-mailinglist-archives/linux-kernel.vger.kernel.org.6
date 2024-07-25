Return-Path: <linux-kernel+bounces-261838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB15E93BCC3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 565CDB21101
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6813416DED1;
	Thu, 25 Jul 2024 06:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="fSsFS/jx"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCBA16D32C;
	Thu, 25 Jul 2024 06:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721890471; cv=none; b=gjGIl6+NM9B19W2CRu93uz5P/Uwr2fF5uNIu2qGedzr3s5ubb34dx0FG1r/Tm+CbpB1KGxKE/7NpIUfB/VWggmanYCKBI27PBD7u4mpOnHsH5LfBd+MczctQeR9UHGz4Rpp28AwiLm0IvzEkDrhoyPnFN69bsi0xgXsUAwCY+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721890471; c=relaxed/simple;
	bh=Wbboll2KAmo/66iIANXiKGVkk7S9lbaf5Yj7cK4vFQ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qon3F04WKe9BoqbxkpEaHJMHU4njJOgnAsm/yhfic79IMRr9Pfdbp1zVq5GaCck1UuVi72YE2TFK7T9nB/iOX/6qNbGrkHF9xQ7zDOmaHlpdDyOa1J1W+PKSkqfi4pioNuIPtQ9+exjewLNUqmVsFRuwAx5nkVjK/CTcKlY1eEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=fSsFS/jx; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OM0vpw025594;
	Thu, 25 Jul 2024 08:54:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=uy8sxC4oTjR1r4dO0TK3Mj
	oSgbNjM8fJGUvA9y13SGY=; b=fSsFS/jxZ1vE/5Yyk7+buXW4jM1BOQxWpc+RCC
	SXHzYiFijOaSGIwYBTy3q4998c6xuk4TX4FjgNJj3pkPkyZDtKgZ0kSsB0dMRvo3
	Jlw5g5iNFsD+mzEodNkgjOCAUFGoPNNu3yJqKNxYLM9dBDdrzUPq59jevs9q1M5e
	zbAv2HxbM2hNxi+ZhJuYF4bHbTmCcJUDQ1mxRWWRp3SO4o/kM1VSWgce/B9nNk0u
	eQU63TNWRipBTf+5mSb548i+Umuk2TByv9W3/5TJVlKr7UUfZr6w3AfxGgoiVXlr
	fOWIBCcCs8udodonB28hDXXCNAHQSxR4/ddKurHjCNaejNPQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40gr6j85wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 08:54:18 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E806440049;
	Thu, 25 Jul 2024 08:53:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BB239210721;
	Thu, 25 Jul 2024 08:53:21 +0200 (CEST)
Received: from localhost (10.48.86.128) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 25 Jul
 2024 08:53:21 +0200
From: Etienne Carriere <etienne.carriere@foss.st.com>
To: <linux-kernel@vger.kernel.org>
CC: Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi
	<cristian.marussi@arm.com>,
        <arm-scmi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Etienne Carriere
	<etienne.carriere@foss.st.com>
Subject: [PATCH] firmware: arm_scmi: fix voltage description in failure cases
Date: Thu, 25 Jul 2024 08:53:17 +0200
Message-ID: <20240725065317.3758165-1-etienne.carriere@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_07,2024-07-25_02,2024-05-17_01

Reset the reception buffer max size when a voltage domain description
request fails, for example when the voltage domain returns an access
permission error (SCMI_ERR_ACCESS) unless what only a single 32bit
word is read back for the remaining voltage description requests
responses leading to invalid information. The side effect of this
issue is that the voltage regulators registered from those remaining
SCMI voltage domain were assigned a wrong regulator name.

Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
 drivers/firmware/arm_scmi/voltage.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
index 2175ffd6cef5..f1a7c04ae820 100644
--- a/drivers/firmware/arm_scmi/voltage.c
+++ b/drivers/firmware/arm_scmi/voltage.c
@@ -229,8 +229,10 @@ static int scmi_voltage_descriptors_get(const struct scmi_protocol_handle *ph,
 		/* Retrieve domain attributes at first ... */
 		put_unaligned_le32(dom, td->tx.buf);
 		/* Skip domain on comms error */
-		if (ph->xops->do_xfer(ph, td))
+		if (ph->xops->do_xfer(ph, td)) {
+			ph->xops->reset_rx_to_maxsz(ph, td);
 			continue;
+		}
 
 		v = vinfo->domains + dom;
 		v->id = dom;
-- 
2.25.1


