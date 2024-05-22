Return-Path: <linux-kernel+bounces-185646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 052918CB861
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C46F1F2349D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1512AE8A;
	Wed, 22 May 2024 01:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lapIq5Gk"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0831BEEAD
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339856; cv=none; b=WRR665eJp8O0kVz5HxvnJKfYxY9nwHcWtYgsJ4EqVTlNicMx5/aaYh9qa88vsd0EX1AQ5y1Mr4YNT3G+3e1ANT4zvtiyshua2XxcpvUPifmtiMPxGmy264OZFWnRUBIRO8ij82KBWst94LKuB6PK4TdwN6Z2x0zq76AFWNNPw1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339856; c=relaxed/simple;
	bh=OqYU2toc8VhoFRt8nhJ72nYlMy15OQ6sULFO1f7aqe4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=n8o8Nwsg1sKcNH+jEWk6Gsm6YDvk65FhacKFWh6ogon9hjdadfvwWfX4JY59Rca307G+HZ5vrsvMZ3I+UoaELHaZQKCKbc7MWcUYnQL/ucEAmqtRvOZK8lOIdAdBLP+Lknq7eZzFT9jsCI/E19gNq1D8bHKv6HwUYt7AOOmcl8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lapIq5Gk; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240522010410epoutp045c3bc340d1dd7a1bbbb81fe2df140531~RqgAvhU742360123601epoutp040
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:04:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240522010410epoutp045c3bc340d1dd7a1bbbb81fe2df140531~RqgAvhU742360123601epoutp040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716339850;
	bh=Uitcad8ZpKbqMNDW2YytBLVtTZ4j7uwwqX9O3MWQJPo=;
	h=From:To:Cc:Subject:Date:References:From;
	b=lapIq5GkskK7aRDEkVatV8emSRWbNh4HPuzM77CaA1geDzhCTFC+tjvq2DZ5gA/9m
	 U9IsDp4IYTSpOS9iWF1zS96iVj480Oq/7SJx+3WCXVho75IKTosdXXejZcQe76u6X8
	 ocuag9zW4zX5ZL3XPILy7k28b838/khdOpmoY/YE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20240522010410epcas2p11d5550044515a107ecd4ef5392f36bdc~RqgAbdLEf0338303383epcas2p1e;
	Wed, 22 May 2024 01:04:10 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.69]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VkY3Y64zSz4x9Q9; Wed, 22 May
	2024 01:04:09 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7A.94.19141.9844D466; Wed, 22 May 2024 10:04:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240522010409epcas2p457b2fcb4f423f2500305053f44ae3199~Rqf-d4A7i0068900689epcas2p4s;
	Wed, 22 May 2024 01:04:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240522010409epsmtrp2846a47b1fde03b71481eeb5f30d7a431~Rqf-XLog81573115731epsmtrp2M;
	Wed, 22 May 2024 01:04:09 +0000 (GMT)
X-AuditID: b6c32a4d-869ff70000004ac5-bb-664d44892cd5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	33.61.08924.9844D466; Wed, 22 May 2024 10:04:09 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240522010409epsmtip207170fe17fd7525879063e08d597c994~Rqf-JMfKt2481524815epsmtip2G;
	Wed, 22 May 2024 01:04:09 +0000 (GMT)
From: Daehwan Jung <dh10.jung@samsung.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
	linux-kernel@vger.kernel.org (open list), Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>, Daehwan Jung <dh10.jung@samsung.com>
Subject: [RFC] usb: host: xhci-mem: Write high first on erst base of
 secondary interrupter
Date: Wed, 22 May 2024 10:03:59 +0900
Message-Id: <1716339839-44022-1-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7bCmqW6ni2+aweM+Q4s7C6YxWTQvXs9m
	cXnXHDaLRctamS2aN01htVi14AC7A5vH4j0vmTz2z13D7tG3ZRWjx5b9nxk9Pm+SC2CNyrbJ
	SE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpASaEsMacU
	KBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdseXx
	GvaCp4IVv6fNYG1g/M/XxcjJISFgIjHh6FwmEFtIYA+jxK9VrF2MXED2J0aJrRdes0E43xgl
	9m77xQzTcePPAajEXkaJbS3/mCGcH4wSvbfaWboYOTjYBLQkvi9kBGkQEYiTWNp5iQmkhllg
	O6PEjBfP2EESwgIxEpvvngKbyiKgKrHl5y82EJtXwFVizvWHjBDb5CRunusEWyAhsIpdYk37
	CVaIhIvE1ksHWSBsYYlXx7ewQ9hSEp/f7WWDsIslbj1/BtXcwiix4lUL1A/GErOetTOCXMos
	oCmxfpc+iCkhoCxx5BbYSGYBPomOw3/ZIcK8Eh1tQhCNyhLTL0+AukBS4uDrc1ADPSQ6WuYz
	QoIxVuLrhW2MExhlZyHMX8DIuIpRKrWgODc9NdmowFA3L7UcHlHJ+bmbGMEJS8t3B+Pr9X/1
	DjEycTAeYpTgYFYS4d20xTNNiDclsbIqtSg/vqg0J7X4EKMpMMwmMkuJJucDU2ZeSbyhiaWB
	iZmZobmRqYG5kjjvvda5KUIC6YklqdmpqQWpRTB9TBycUg1MPP+Z/vakTklYf+COHGe0SWNT
	nZHVnO0+Vlc2SSlcXpipzv5+0j29ibtnXQsS+nMupnjriZiHdhf1Tgd1lCksOphlH25ksD5J
	6Xh1xqxpQgX//p8IeuqzbSv3nXP/O9/G6HFq2pw1DH8d9OqfuU9a3BzPDw8f5G7yP23gXDwr
	tXTljAs2WZuEknbNXLCi65B/68PDN/okuOuYuH5seeUaf/GihKpsaURxlPkr2QmRM++XltTu
	2SsfGa70JnCe5oLP08prX0Vd3vgudfb5vru3qw3ufjq/3m5KoGOBZ5uSivjEsgbV4jMeJhG2
	ba7Ghc7rgm42vPJ4zHeEtX5jj+H/2Lzl/b7rr1x+fvyWYuhuJZbijERDLeai4kQAPQIb4uED
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFJMWRmVeSWpSXmKPExsWy7bCSvG6ni2+awdR9nBZ3FkxjsmhevJ7N
	4vKuOWwWi5a1Mls0b5rCarFqwQF2BzaPxXteMnnsn7uG3aNvyypGjy37PzN6fN4kF8AaxWWT
	kpqTWZZapG+XwJWx5fEa9oKnghW/p81gbWD8z9fFyMkhIWAicePPAbYuRi4OIYHdjBKXV2xi
	h0hISiydewPKFpa433KEFaLoG6PEgl9PgDo4ONgEtCS+L2QEqRERiJNYcXkPC0gNs8BORonb
	H3awgSSEBaIk/vfcARvEIqAqseXnL7A4r4CrxJzrDxkhFshJ3DzXyTyBkWcBI8MqRsnUguLc
	9NxiwwLDvNRyveLE3OLSvHS95PzcTYzg4NHS3MG4fdUHvUOMTByMhxglOJiVRHg3bfFME+JN
	SaysSi3Kjy8qzUktPsQozcGiJM4r/qI3RUggPbEkNTs1tSC1CCbLxMEp1cDk0h+g3nT/bezf
	H0/m8Xvd27WiVHp/3G/jmZsqXjedVc9vv50064WJwZlnF2VL5q8WM+PVf7bhg+H25slOJrdb
	+1wOPnwpFBLPMvFiwEal2eUvTu+8ousSI822r/iQt7Xy5bqN53bqtN/9y6bTt6Ky+iH7spIb
	TR0MewMmsv8Q5RP9vtJG6twPPd/eReWVCpOnH3wXFGBh/orZ4bYdxzmJvcZ8jy7l9Quu3fdB
	zt1aTCaWy/7pgfseu/ctVeZWyHNRERdcIiRo80Pp/Y4Xf180/y9Q1lM58OrT6yUc54yVjlt+
	WWrMLZv8W2jFZ+l+hg3L7K2MWH1NbhnuvbxHTdV0z6Eob9VdPsFni6bP2pOgxFKckWioxVxU
	nAgAkSKzKY0CAAA=
X-CMS-MailID: 20240522010409epcas2p457b2fcb4f423f2500305053f44ae3199
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240522010409epcas2p457b2fcb4f423f2500305053f44ae3199
References: <CGME20240522010409epcas2p457b2fcb4f423f2500305053f44ae3199@epcas2p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

ERSTBA_HI should be written first on secondary interrupter.
That's why secondary interrupter could be set while Host Controller
is already running.

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
 drivers/usb/host/xhci.h     | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 3100219..36ee704 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2325,7 +2325,10 @@ xhci_add_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir,
 	erst_base = xhci_read_64(xhci, &ir->ir_set->erst_base);
 	erst_base &= ERST_BASE_RSVDP;
 	erst_base |= ir->erst.erst_dma_addr & ~ERST_BASE_RSVDP;
-	xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
+	if (intr_num == 0)
+		xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
+	else
+		xhci_write_64_r(xhci, erst_base, &ir->ir_set->erst_base);
 
 	/* Set the event ring dequeue address of this interrupter */
 	xhci_set_hc_event_deq(xhci, ir);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 3041515..7951c0e 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/usb/hcd.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/io-64-nonatomic-hi-lo.h>
 
 /* Code sharing between pci-quirks and xhci hcd */
 #include	"xhci-ext-caps.h"
@@ -1747,6 +1748,11 @@ static inline void xhci_write_64(struct xhci_hcd *xhci,
 {
 	lo_hi_writeq(val, regs);
 }
+static inline void xhci_write_64_r(struct xhci_hcd *xhci,
+				 const u64 val, __le64 __iomem *regs)
+{
+	hi_lo_writeq(val, regs);
+}
 
 static inline int xhci_link_trb_quirk(struct xhci_hcd *xhci)
 {
-- 
2.7.4


