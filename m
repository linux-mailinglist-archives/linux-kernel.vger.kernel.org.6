Return-Path: <linux-kernel+bounces-437891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBBB9E9A30
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319F616352E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F1E1B423B;
	Mon,  9 Dec 2024 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jP5MygPO"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4781BEF92
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757380; cv=none; b=nHZZ3PdQAO1MsQ3/66Sa/9i+lSc7ggP397BqugX3lH+05m9zUy6BBXsjRnXL3BEbXTovfxqylToLm4VYhrKfOPl2jRyLaSUn70f9bRezGX9XcAnjQEOohOS8xFW+AmBVahq1KtZQiwZZuS6th/DJHM+VZ/J4wb9pWLS6GiaK5kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757380; c=relaxed/simple;
	bh=RWx2T+EHH8ZA661k7UcOZCj6Iro0jmSaSRRPjwhibyE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ih2aargKPy2xqwjhyGbYxO638faYeqNYJ9TIISmYGfgRe7bVqsVaaTsEkpKtT/SWsdUfDD5klGdB4+1VZIifxhVRH3/AQPx1pJPG+VheONcA2Ofw6t9b3Pg0W1vzICP6AT8E6Amie1nHq8T3uW0s+IoyTYqg4QQmRm9OAqn0N6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jP5MygPO; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B96xnVr004928;
	Mon, 9 Dec 2024 07:16:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=g
	Qf66/KaYKcWa+p3FKwoWdRJc0PNKIU9Ziq/elvIUAk=; b=jP5MygPOLSO5R7enr
	AXfnQMjOuRNxAwBuqBGBsdC9HysIUhgIKvdJz9OypDGeHcvy0bg/G4Bj5ezghCaN
	ktCkOiAf2QU3fKwiFsDLUorW4PljXfic4PjRiiB+6iUshgqqhZ4OpOnMnlOMMw+5
	uv4ghdBnagQHoYEvFZ5ax888h3sUqioHO8WbhCWk4UYoL90Q8yLEbFR1LJ6V6qfr
	N1OdFUcs0cbt+QgX+A3L9Ykbxj2LA5a2ooJcu0nup5UnR9rqEWpEX9zV6ysHbyrr
	mE4g7v4bzx2f3AYo/dZcwar86FZY/owHaeC+MKEDqG4c9HHKUxK5nJ2XEbznaZOv
	JEa4w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43dus5gyp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 07:16:07 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Dec 2024 07:16:06 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Dec 2024 07:16:06 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
	by maili.marvell.com (Postfix) with ESMTP id 7CF4B5B693E;
	Mon,  9 Dec 2024 07:16:02 -0800 (PST)
From: Shijith Thotton <sthotton@marvell.com>
To: <virtualization@lists.linux.dev>, <mst@redhat.com>, <jasowang@redhat.com>,
        <dan.carpenter@linaro.org>
CC: Shijith Thotton <sthotton@marvell.com>, <schalla@marvell.com>,
        <vattunuru@marvell.com>, <ndabilpuram@marvell.com>,
        <jerinj@marvell.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/4] virtio-pci: define type and header for PCI vendor data
Date: Mon, 9 Dec 2024 20:42:15 +0530
Message-ID: <20241209151427.3720026-3-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241209151427.3720026-1-sthotton@marvell.com>
References: <20241209151427.3720026-1-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9T7pgFdMQztPDOJVQgmvpJlpZ6khaa93
X-Proofpoint-GUID: 9T7pgFdMQztPDOJVQgmvpJlpZ6khaa93
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Added macro definition for VIRTIO_PCI_CAP_VENDOR_CFG to identify the PCI
vendor data type in the virtio_pci_cap structure. Defined a new struct
virtio_pci_vndr_data for the vendor data capability header as per the
specification.

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 include/uapi/linux/virtio_pci.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index a8208492e822..1f3ea5d2a6af 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -115,6 +115,8 @@
 #define VIRTIO_PCI_CAP_PCI_CFG		5
 /* Additional shared memory capability */
 #define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
+/* PCI vendor data configuration */
+#define VIRTIO_PCI_CAP_VENDOR_CFG	9
 
 /* This is the PCI capability header: */
 struct virtio_pci_cap {
@@ -129,6 +131,15 @@ struct virtio_pci_cap {
 	__le32 length;		/* Length of the structure, in bytes. */
 };
 
+/* This is the PCI vendor data capability header: */
+struct virtio_pci_vndr_data {
+	__u8 cap_vndr;		/* Generic PCI field: PCI_CAP_ID_VNDR */
+	__u8 cap_next;		/* Generic PCI field: next ptr. */
+	__u8 cap_len;		/* Generic PCI field: capability length */
+	__u8 cfg_type;		/* Identifies the structure. */
+	__u16 vendor_id;	/* Identifies the vendor-specific format. */
+};
+
 struct virtio_pci_cap64 {
 	struct virtio_pci_cap cap;
 	__le32 offset_hi;             /* Most sig 32 bits of offset */
-- 
2.25.1


