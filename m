Return-Path: <linux-kernel+bounces-415294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63FA9D3400
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84CF11F240D5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C37A16A92D;
	Wed, 20 Nov 2024 07:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Au8xUkCf"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FD1158868
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 07:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732086413; cv=none; b=s2G6/F1AZlwHvmFA+RlEGTr1p5BbqFyc74O/i/EXTFkEDjs6S28Bq4s4QmZAgaG1qJkmnJkpdgXoiCka+MyURAbH6dEbL6duta+gv7TBPFWT8UumUhzkma1zRgTfc/wWKm5BkcBSdvhYFyfRrqe7FAibpW0y//LQppfNMS7jFYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732086413; c=relaxed/simple;
	bh=M63QeHnzoqhPG6nzFTmNXvn07cEQsZgCB3WWa3omhQg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eiRrUSvX5wFB7nxaxkXa2Wytv8ZwAYYJHzFedWR+Ylrhoi94yCx7TGUIKfuLrN6yhTbLXaYNdvxIxzMh5CsioCwaFq/mDvSYOBij9yB5EDvfNd34E7cnSGT/yflYPqV6ztGLe5IZDGCej67c9EXFZd0LGphgScl68zO40fGehgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Au8xUkCf; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK5nodO031334;
	Tue, 19 Nov 2024 23:06:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=p
	zqCT5Ae40goklLRpMmLzcsqRe/q0WW2oZKeIia37Kw=; b=Au8xUkCfkKiM74nY/
	zRXpIuYYyF/JFq8OlJOALCXGubGNHSE0mcaZps/F7loZRpXZI1yKEhVgMxS2Y12w
	M8ZtPKj5zKiaIFS298wx/vhCLFwMjEjRuo2+7qpcwxJ8xj8kiVzga99lDDvGNrRb
	aKheKybhv2z0siS/pItPSdJwmHBapBdog458bj2SYc9PYkiApfq2FnkVUKJV0lqj
	Umjvsk29zw8Ot4hxWdlpifw2005dGh/hKH+hD8+7AmxARkG6Z8ltMIqJNxCzJZI5
	fWc/LlodiVw9Js7+V0a4nGBuzqIqOmsoGaFzGr5uymDIA/c/6Qzm+Ci6mvt9BYDL
	wxQNA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4319yeg3tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 23:06:39 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 19 Nov 2024 23:06:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 19 Nov 2024 23:06:38 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
	by maili.marvell.com (Postfix) with ESMTP id 227343F7060;
	Tue, 19 Nov 2024 23:06:34 -0800 (PST)
From: Shijith Thotton <sthotton@marvell.com>
To: <virtualization@lists.linux.dev>, <mst@redhat.com>, <jasowang@redhat.com>
CC: Satha Rao <skoteshwar@marvell.com>, <schalla@marvell.com>,
        <vattunuru@marvell.com>, <ndabilpuram@marvell.com>,
        <jerinj@marvell.com>, Shijith Thotton <sthotton@marvell.com>,
        Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] vdpa/octeon_ep: handle device config change events
Date: Wed, 20 Nov 2024 12:34:51 +0530
Message-ID: <20241120070508.789508-2-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241120070508.789508-1-sthotton@marvell.com>
References: <20241120070508.789508-1-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4xfLTbp2_BL4MS9Nix4bMX1OfHm3PX5a
X-Proofpoint-ORIG-GUID: 4xfLTbp2_BL4MS9Nix4bMX1OfHm3PX5a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

From: Satha Rao <skoteshwar@marvell.com>

The first interrupt of the device is used to notify the host about
device configuration changes, such as link status updates. The ISR
configuration area is updated to indicate a config change event when
triggered.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 drivers/vdpa/octeon_ep/octep_vdpa_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index 482c178a5221..6db951c6cb92 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -74,6 +74,14 @@ static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
 		}
 	}
 
+	/* Check for config interrupt. Config uses the first interrupt */
+	if (unlikely(ring_start == 0 && ioread8(oct_hw->isr))) {
+		iowrite8(0, oct_hw->isr);
+
+		if (likely(oct_hw->config_cb.callback))
+			oct_hw->config_cb.callback(oct_hw->config_cb.private);
+	}
+
 	return IRQ_HANDLED;
 }
 
-- 
2.25.1


