Return-Path: <linux-kernel+bounces-191788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E62F38D1417
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F843B20F20
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 05:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE42C4F207;
	Tue, 28 May 2024 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XsIx4ryW"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2345C4E1B3
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716875832; cv=none; b=s5SldY9o848QDMaOE66hwdqkDXCU+YDUXE3p1nqBeSWPtYkpiMKreHWVFrr9E/3w52oXIKJxfK+7EY1qP4xpPeD7HxgCeoY/lzOfdKyJgzndpz32R0gcd/DdpcdjUTuwOLTEcY4KM1PAkMD65r59sALDX984U0/CPVAaOTJW0QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716875832; c=relaxed/simple;
	bh=UoR5gPGym9uf54ZGp6/U0JiMpXAEVmwnB+CE+byyg1g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=dPn1fA8u67Wf+CpqFcuv28Qpx2iOcQ5BktuxQt5u0nOzA+da1gmY23pZUtHNF/neqLwAgMfp7uzALh/fPTlYMLF1WAxCan4dQeonml0TQ78nBJpMGo1slvrmggdNeRJHkw1YklZOJkvf0KXcXJZZb9wLh6cPXFp+TPQiqJUKONM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XsIx4ryW; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240528055700epoutp01adb560470c334c2b09636362ca6d0e0f~TkXZxlMiq2536025360epoutp01v
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 05:57:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240528055700epoutp01adb560470c334c2b09636362ca6d0e0f~TkXZxlMiq2536025360epoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716875820;
	bh=IZqSyOEN6oaujsmsFgWCF7ZAIEjCMHQeDCmq2lF9xXQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=XsIx4ryWw5G8DlRpgOfFzja1HdT/dxTSr26Ln7us2iJ42A9lmcBcrqFaGoxyk2sgZ
	 WTrlN+ZEgY3CRp+RGxQzVXJ+2UH/2aovba5QSPAHRy/MaTZPyuqt3+rhmm7PlgDPS7
	 UMlt+SoAuuOJJYO9gNLwKvkk5xO+Zl+jDi0kLGLM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240528055700epcas2p48a69c3c3cc2f4fb04907f2eef8988907~TkXZerKBy1671416714epcas2p4a;
	Tue, 28 May 2024 05:57:00 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.70]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VpMGg61J2z4x9Q3; Tue, 28 May
	2024 05:56:59 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C3.16.18956.B2275566; Tue, 28 May 2024 14:56:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240528055659epcas2p4f86642d6647855747cea35b04f8a46cc~TkXYdoRYi0312903129epcas2p4L;
	Tue, 28 May 2024 05:56:59 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240528055659epsmtrp22c4559e1e0fc88d63cf66fc7fc5b5e14~TkXYc_wZq2805328053epsmtrp2X;
	Tue, 28 May 2024 05:56:59 +0000 (GMT)
X-AuditID: b6c32a4d-247ff70000004a0c-3a-6655722b41a3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1F.A4.08622.B2275566; Tue, 28 May 2024 14:56:59 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240528055659epsmtip228d801d5b246e5c824b0b5929700980f~TkXYTETEO1503015030epsmtip2q;
	Tue, 28 May 2024 05:56:59 +0000 (GMT)
From: Daehwan Jung <dh10.jung@samsung.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
	linux-kernel@vger.kernel.org (open list), Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>, Daehwan Jung <dh10.jung@samsung.com>
Subject: [PATCH] usb: host: Add a quirk for writing ERST in high-low order
Date: Tue, 28 May 2024 14:57:16 +0900
Message-Id: <1716875836-186791-1-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7bCmqa52UWiaweQ9ehZ3FkxjsmhevJ7N
	4vKuOWwWi5a1Mls0b5rCarFqwQF2BzaPxXteMnnsn7uG3aNvyypGjy37PzN6fN4kF8AalW2T
	kZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SBkkJZYk4p
	UCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECvODG3uDQvXS8vtcTK0MDAyBSoMCE7o23q
	QbaCFQIVT7d0MTcwfuDtYuTkkBAwkZj2YwJTFyMXh5DAHkaJhsnPoZxPjBL7Zk9hh3C+MUr0
	/f7DCtOyue0+VGIvo8Ss3bfBEkICPxglrqxQ72Lk4GAT0JL4vpARJCwiECextPMS2FRmge2M
	EjNePGMHSQgLeEnsOHebGcRmEVCVuNC3HCzOK+AmservOWaIZXISN891Qtmb2CWmzQ+GsF0k
	Oj/9Z4KwhSVeHd/CDmFLSXx+t5cNwi6WuPX8GTPIYgmBFkaJFa9aoAYZS8x61s4IciizgKbE
	+l36IKaEgLLEkVssIBXMAnwSHYf/skOEeSU62oQgGpUlpl+eAA0GSYmDr2Gu9JBYfuIvM0i5
	kECsxOyV+RMYZWchjF/AyLiKUSq1oDg3PTXZqMBQNy+1HB5Nyfm5mxjByUrLdwfj6/V/9Q4x
	MnEwHmKU4GBWEuEVmReYJsSbklhZlVqUH19UmpNafIjRFBhiE5mlRJPzgekyryTe0MTSwMTM
	zNDcyNTAXEmc917r3BQhgfTEktTs1NSC1CKYPiYOTqkGprCU2L+811S/thxcLfk++GmLzPaN
	T/ZmypV4apw79HLqP+XHH/o4lhw5L/3Nd4eixSVJtyu/jFmuP1wl2xZetyM70729sfaZ58EO
	QQPBXy+PS/WU7j/spbco9DefzCfZ7npLbS5rI0PFW2yiNSvN3zBMMzn/wdhritZS7s/PVKOj
	eWWF3T/+n/ByKevlDb9i/342fFjHn+K92MSU95XHYqW3nv9XsRW0qTDH2b15NTGjUJjFZm38
	hztCjN+/LvhwIymk+oPFUf7ot7ctWbPkvl7xezvD+3/31sV3r1yslvipGmkSr/zeY1P2Hr28
	tIQH7C9Se7kaV8XXX56Q0M+ebm/cHphlZ1I2eb2eu9M/JZbijERDLeai4kQAzMVSiN8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFJMWRmVeSWpSXmKPExsWy7bCSvK52UWiawbEPohZ3FkxjsmhevJ7N
	4vKuOWwWi5a1Mls0b5rCarFqwQF2BzaPxXteMnnsn7uG3aNvyypGjy37PzN6fN4kF8AaxWWT
	kpqTWZZapG+XwJXRNvUgW8EKgYqnW7qYGxg/8HYxcnJICJhIbG67z97FyMUhJLCbUWLhxdus
	EAlJiaVzb7BD2MIS91uOsEIUfWOUuLV2PVsXIwcHm4CWxPeFjCA1IgJxEisu72EBqWEW2Mko
	cfvDDjaQhLCAl8SOc7eZQWwWAVWJC33LwYbyCrhJrPp7jhligZzEzXOdzBMYeRYwMqxilEwt
	KM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAgOHi2tHYx7Vn3QO8TIxMF4iFGCg1lJhFdkXmCa
	EG9KYmVValF+fFFpTmrxIUZpDhYlcd5vr3tThATSE0tSs1NTC1KLYLJMHJxSDUyzedj0RNN/
	3rZ03XFgY92+Gm8H7lvRJ3fs8C94c0/3wUnrDy+nvzg6K+HCJub7oidWlSzuSlj5PPrd9kZv
	h7Mun6xNJvYfY3vGtqtTOO33nCVMO83Pptzzvn9k7p/D0dGV19ftMljw+N6L9rwfjz/HbPl6
	rJn1qd1erinnhU9K7ZhflWnfLzn396kYu0Y+jYRtipFSMz/HpfrftNbZEVT2x+n45W32u0yC
	3u+Jqfh441CXustJvv/3frwTiM7dP/3PzJ0XVireV7++7L/eWbNNtY+V1fnsZ0w/c62ayZBF
	5OCysvc/Oze+OHrY9kRb3GE+2VPpkdYPA63j1RcanqmY1u3RbuB27jJ78YUt/eubNyuxFGck
	GmoxFxUnAgC/FfL8jQIAAA==
X-CMS-MailID: 20240528055659epcas2p4f86642d6647855747cea35b04f8a46cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240528055659epcas2p4f86642d6647855747cea35b04f8a46cc
References: <CGME20240528055659epcas2p4f86642d6647855747cea35b04f8a46cc@epcas2p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

[Synopsys]- The host controller was design to support ERST setting
during the RUN state. But since there is a limitation in controller
in supporting separate ERSTBA_HI and ERSTBA_LO programming,
It is supported when the ERSTBA is programmed in 64bit,
or in 32 bit mode ERSTBA_HI before ERSTBA_LO

[Synopsys]- The internal initialization of event ring fetches
the "Event Ring Segment Table Entry" based on the indication of
ERSTBA_LO written.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
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


