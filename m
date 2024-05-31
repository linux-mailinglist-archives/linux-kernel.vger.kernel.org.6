Return-Path: <linux-kernel+bounces-196326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838438D5A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DFE41C204E8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FB47F7D1;
	Fri, 31 May 2024 06:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ha0wHgSf"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D037F7D3EC
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717135655; cv=none; b=YX6KlUtvcPjIPurjp3SuNsnJz4lGfxXyKZ1b9nQpQppVXSht28VjiE3WStIUxXuubPk/tmbvOQQHCKNiXUqCCocDPnS3dMjHDedzRZaK4xszs5ciceSWrDTD17euUVKyRvR74o0yXvDpZKriYNT753fG1oHPogHapZCkLnjr+aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717135655; c=relaxed/simple;
	bh=1U7q0ge9pHo5hwGtKoiQ5VB13Mf9XHOlW3CJqvv3wUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=Rnra1dutg97GxSYp+Zx5PDmByQgmrnfWDy4NnSzuKnqBjdypOD6dxG+Uvv1ayhJk1UESWtnG/mxGFkob+3eb0IJqgAmM7JRrcTCjAHbzR2f+0OQKw8kPzDziPXOTtDktZ4u0+Z6JbipszC5c3VnsT+GgDpTKoc1HjW1eTvp8FOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Ha0wHgSf; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240531060732epoutp03b319f6a166d8a003e97f24dc27c53b14~Ufcckvs551007510075epoutp03P
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:07:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240531060732epoutp03b319f6a166d8a003e97f24dc27c53b14~Ufcckvs551007510075epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717135652;
	bh=LX4H2dAcFEABKYFEQtbp4BH573q30eTVODmNH8eOMZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ha0wHgSfleDM5ZWp3wTdJz67r+tZOngeoFC9bdnqB84TD0dKIF/LJFDOCkTLV955m
	 nE94f46nCmDWhORcvMiR6go4A34Jwsf2wc2zW0WDlJnyN6Rs//72UlgBYsIgUYGWOp
	 gMopGrdqucfZ8p/3ST/IJeBgOOGaocvLlUZNmtIg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240531060731epcas2p4f30ff1dc4579b91089207fcb7eaffbc0~UfccJRN5C0491204912epcas2p4I;
	Fri, 31 May 2024 06:07:31 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.100]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VrCMR312bz4x9QC; Fri, 31 May
	2024 06:07:31 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	D0.1B.09848.32969566; Fri, 31 May 2024 15:07:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240531060731epcas2p4d4cb51e9bb30bab4195d2d12567b1391~Ufcbd3b-X0345403454epcas2p4U;
	Fri, 31 May 2024 06:07:31 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240531060731epsmtrp28acaeea45f99869b1635308ad490ad62~UfcbdJC0y3252232522epsmtrp2J;
	Fri, 31 May 2024 06:07:31 +0000 (GMT)
X-AuditID: b6c32a45-a536da8000002678-61-665969236bcf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	A2.30.18846.22969566; Fri, 31 May 2024 15:07:30 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240531060730epsmtip186ef2b9ee394f3aa91319af99be60253~UfcbRlF960050400504epsmtip1G;
	Fri, 31 May 2024 06:07:30 +0000 (GMT)
From: Daehwan Jung <dh10.jung@samsung.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Mathias
	Nyman <mathias.nyman@intel.com>, Felipe Balbi <balbi@kernel.org>
Cc: linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE
	TREE BINDINGS), linux-kernel@vger.kernel.org (open list), Daehwan Jung
	<dh10.jung@samsung.com>
Subject: [PATCH v2 4/5] xhci: Add a quirk for writing ERST in high-low order
Date: Fri, 31 May 2024 15:07:36 +0900
Message-Id: <1717135657-120818-5-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1717135657-120818-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmqa5yZmSawamlYhbH2p6wW6zZe47J
	Yv6Rc6wWdxZMY7JoXryezeLlrHtsFpd3zWGzWLSsldmiedMUVov/e3awW6xacIDdgdtj8Z6X
	TB6bVnWyeeyfu4bdo2/LKkaPLfs/M3p83iQXwBaVbZORmpiSWqSQmpecn5KZl26r5B0c7xxv
	amZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdJ+SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYp
	tSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj++LrzAUzBCq2NJ9gbmB8wNvFyMkhIWAi
	sWvTfLYuRi4OIYEdjBIn909nAUkICXxilGjYIwGRALJnznvJCNPR/eEfK0RiJ6PEwUlf2SE6
	fjBK9F2S6WLk4GAT0JL4vpARpEZEYBaTxKM5d8EcZoFnjBLr/5xnAmkQFvCRmPZpBwtIA4uA
	qsSSG4UgYV4BN4nJm06yQiyTk7h5rpMZxOYUcJd4MOccC8gcCYGP7BJfPy6GushF4uupxcwQ
	trDEq+Nb2CFsKYnP7/ayQdjFEreeP2OGaG5hlFjxqgWqwVhi1rN2RpAjmAU0Jdbv0gcxJQSU
	JY7cAocEswCfRMfhv+wQYV6JjjYhiEZliemXJ0CdKSlx8PU5qIEeErc3fWOGhM8sRolb/bMY
	JzDKzUJYsICRcRWjWGpBcW56arFRgSE8wpLzczcxgpOflusOxslvP+gdYmTiYDzEKMHBrCTC
	+ys9Ik2INyWxsiq1KD++qDQntfgQoykw7CYyS4km5wPTb15JvKGJpYGJmZmhuZGpgbmSOO+9
	1rkpQgLpiSWp2ampBalFMH1MHJxSDUxaJVVfAp45b47Vvfd67TKbP5ObBPwn3K82txD+dYC3
	Neb6G5EJMysDN0hOmB0nNudk0pIvvSGNCh5Ni4JdLxdbybw7vs3LQTgtV5DR6AZ/jGv0q/nX
	VvFyHJ95MWzWiibX+0cqqhcuW8d+oXTmIqX8qBNLVW0P/vx0av9pq7z+jx9iAqrW32dPn7ju
	nWby/40mboZtnptYbk0/VRa8Z8mJF80K71LdmXInmN2a1jJjWZLZ3f8139+cTrpmZeSzzUhZ
	XqZlN0fatGP5mf5/mxOynNeEcj7WLbF5E3E0JPN1I9MdnroJuz/OWLcpyCsta+mJ5gl7qo41
	2gdppC/h+e3RElUV1/c/Qs75zvfley4osRRnJBpqMRcVJwIA7tj6egcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsWy7bCSnK5SZmSawbcmC4tjbU/YLdbsPcdk
	Mf/IOVaLOwumMVk0L17PZvFy1j02i8u75rBZLFrWymzRvGkKq8X/PTvYLVYtOMDuwO2xeM9L
	Jo9NqzrZPPbPXcPu0bdlFaPHlv2fGT0+b5ILYIvisklJzcksSy3St0vgyvi++DpzwQyBii3N
	J5gbGB/wdjFyckgImEh0f/jH2sXIxSEksJ1RYvLMvewQCUmJpXNvQNnCEvdbjkAVfWOU2HRj
	FWMXIwcHm4CWxPeFjCBxEYEFTBLXpt1mB3GYBZ4xStx70MIK0i0s4CMx7dMOFpAGFgFViSU3
	CkHCvAJuEpM3nWSFWCAncfNcJzOIzSngLvFgzjkWEFsIqGbXpQPsExj5FjAyrGIUTS0ozk3P
	TS4w1CtOzC0uzUvXS87P3cQIDlCtoB2My9b/1TvEyMTBeIhRgoNZSYT3V3pEmhBvSmJlVWpR
	fnxRaU5q8SFGaQ4WJXFe5ZzOFCGB9MSS1OzU1ILUIpgsEwenVAPT2uBrqTvELCJE1i57q9Nl
	0hn9sW/j2Ws3zHlO1WifCF/smmFtGSO8Yassz6I5iudNr5cWbTR1+ntU69f8oryVgW2Tnzp4
	hT92bxDy0ztp/P26oumTpP13p7xZkbxiypKF5fyckcw/d51drCLcXeujUnvAruqakOEpH+Fw
	03eFZw/Yz5O8/u30IsdzV/LLb678d7jn3KTzK35Ldku0zG3dtXtu1862A7PO7bfmZvKYpfi8
	a8eEGTeT9jIKiGxf5Ojt5tmX9mcK36nrv76Fvz8f88l0rhjvxd9PJCqeXIvQuz+dXbM6ePeV
	R6w3boieCEhd6f2+dMMczedyD1TfW3P/PzZb7xZP8wWV57nJ0ovPRimxFGckGmoxFxUnAgCQ
	el5TvwIAAA==
X-CMS-MailID: 20240531060731epcas2p4d4cb51e9bb30bab4195d2d12567b1391
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240531060731epcas2p4d4cb51e9bb30bab4195d2d12567b1391
References: <1717135657-120818-1-git-send-email-dh10.jung@samsung.com>
	<CGME20240531060731epcas2p4d4cb51e9bb30bab4195d2d12567b1391@epcas2p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This quirk is for the controller that has a limitation in supporting
separate ERSTBA_HI and ERSTBA_LO programming. It's supported when
the ERSTBA is programmed ERSTBA_HI before ERSTBA_LO. That's because
the internal initialization of event ring fetches the
"Event Ring Segment Table Entry" based on the indication of ERSTBA_LO
written.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
RFC -> v1:
- add a quirk in xhci
- use the quirk for programming ERST high-low order
---
 drivers/usb/host/xhci-mem.c | 5 ++++-
 drivers/usb/host/xhci.h     | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 3100219..ef768e6 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2325,7 +2325,10 @@ xhci_add_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir,
 	erst_base = xhci_read_64(xhci, &ir->ir_set->erst_base);
 	erst_base &= ERST_BASE_RSVDP;
 	erst_base |= ir->erst.erst_dma_addr & ~ERST_BASE_RSVDP;
-	xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
+	if (xhci->quirks & XHCI_WRITE_64_HI_LO)
+		hi_lo_writeq(erst_base, &ir->ir_set->erst_base);
+	else
+		xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
 
 	/* Set the event ring dequeue address of this interrupter */
 	xhci_set_hc_event_deq(xhci, ir);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 3041515..8664dd1 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/usb/hcd.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/io-64-nonatomic-hi-lo.h>
 
 /* Code sharing between pci-quirks and xhci hcd */
 #include	"xhci-ext-caps.h"
@@ -1627,6 +1628,7 @@ struct xhci_hcd {
 #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
 #define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
 #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
+#define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
2.7.4


