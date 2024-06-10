Return-Path: <linux-kernel+bounces-208089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8AB90207F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5430E1F21BA3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEB51B80F;
	Mon, 10 Jun 2024 11:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IYPrkSrx"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C377C6EB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718019538; cv=none; b=sTds+zCY4l4tgBEmMXgTXq+9Sum+pFKSNtO6GTOj4C/W0rnufI4YqCNBi+KgixUsHjUPHCdtlxCHV5WE7zLcXc+RJYmrAh7G6jlXxSDWdlZKNr/Pwo+LRhgOXzVBcEDcyAiOwOa9FCg0mC+WtEg7crRUX+idhapav1KLm/LnV1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718019538; c=relaxed/simple;
	bh=ICqFw5ZZMvRyWPAU8BnmipUzEkrscSUQMD/V8Z0VPtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=pwJKHHash/S0kj8GL6GElPGiQWi5tQvjrJYKS5biBRU5S7P/ikgcNrbfoanh/fbi/tfoIgZoOq4Lft51wmUuRYL0ku2r4ChoLvyj9+VqXqJNfl/H1uSgczL6NOo4wUlcfAMM9uX90QZXyNfz6AeVuveEmQLr9eYJJ3jmulM/4+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IYPrkSrx; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240610113850epoutp0364f65fc2978c7d7b26658b101d6813fe~XoakjeGz81812018120epoutp03D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:38:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240610113850epoutp0364f65fc2978c7d7b26658b101d6813fe~XoakjeGz81812018120epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718019530;
	bh=TV4KTUZnCE6pjbCnux0zhwSr84BxKZ1ykWq8bSkM1YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IYPrkSrxzaUXnstAf9uz1tnO4fEz2hjiwmi2eqGiOuzLG2LFsoZVw70S5wnDmqoTa
	 GXJATXOnSSN9JD3z7eTch/Gpah9kFV5cabXOiH5+5O90h5lu1vMRIe8DB7v3vZcO0B
	 sxJ6GrfD65xpl+MK0XmR/rgP8x7fENNUkqM/cI6Q=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240610113850epcas2p4c8b75587503830ebfc0c82433a4860ca~XoakLIBum1513815138epcas2p44;
	Mon, 10 Jun 2024 11:38:50 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.91]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VyVF56gm0z4x9Pt; Mon, 10 Jun
	2024 11:38:49 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	1F.55.56241.9C5E6666; Mon, 10 Jun 2024 20:38:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20240610113849epcas2p225c0dde8fbb833e37be9c2b63850d520~XoajYipcq0449004490epcas2p2p;
	Mon, 10 Jun 2024 11:38:49 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240610113849epsmtrp22ef630505b243d015bef204cf00f8ff3~XoajX4s9F2502825028epsmtrp28;
	Mon, 10 Jun 2024 11:38:49 +0000 (GMT)
X-AuditID: b6c32a43-c03fd7000000dbb1-bf-6666e5c943c1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	30.67.18846.9C5E6666; Mon, 10 Jun 2024 20:38:49 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240610113849epsmtip2a0da05666ea452d474f28f6ad3d81aad~XoajNecFO1786817868epsmtip2o;
	Mon, 10 Jun 2024 11:38:49 +0000 (GMT)
From: Daehwan Jung <dh10.jung@samsung.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>, Mathias Nyman <mathias.nyman@intel.com>
Cc: linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list), h10.kim@samsung.com, Daehwan Jung
	<dh10.jung@samsung.com>
Subject: [PATCH v3 2/3] xhci: Add a quirk for writing ERST in high-low order
Date: Mon, 10 Jun 2024 20:39:12 +0900
Message-Id: <1718019553-111939-3-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1718019553-111939-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7bCmme7Jp2lpBt8nGFvcWTCNyaJ58Xo2
	i7+3L7JaXN41h81i0bJWZovmTVNYLVYtOMDuwO6xeM9LJo/9c9ewe/RtWcXosWX/Z0aPz5vk
	Alijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgM5Q
	UihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIV
	JmRntD4LLNgnUNH2+xBzA+MP3i5GTg4JAROJg9ObWLoYuTiEBHYwSnTM/MQG4XxilJi5bS0j
	nNPdPYEdpuX1oZPsEImdjBJbd86C6v/BKPH76kkgh4ODTUBL4vtCsG4RgQ5GiaPPT4PNZRZY
	wCjx4OQiRpBRwgI+Eq09t8HGsgioShw5+JAJpJlXwE3i93pBiG1yEjfPdTKD2JwC7hIv5/9l
	gYgfY5d4taEEwnaRODKxnQ3CFpZ4dXwL1KVSEp/f7YWKF0vcev6MGeQGCYEWRokVr1qYIRLG
	ErOetTOC7GUW0JRYv0sfxJQQUJY4cgtsFbMAn0TH4b/sEGFeiY42IYhGZYnplyewQtiSEgdf
	n4Ma6CFxsf8LNOBmMUosnHWMeQKj3CyEBQsYGVcxiqUWFOempyYbFRjCIyw5P3cTIziVaTnv
	YLwy/5/eIUYmDsZDjBIczEoivEIZyWlCvCmJlVWpRfnxRaU5qcWHGE2BQTeRWUo0OR+YTPNK
	4g1NLA1MzMwMzY1MDcyVxHnvtc5NERJITyxJzU5NLUgtgulj4uCUamCaL1Xh6nHlabHQwgdr
	jtby3r+VtP2cYNhElR/h833vXsixPrXUWbtox29TwchP6/4ulteLOz9lQugZrmeHHzRYJE0K
	Ed2231ZY+aCjQ/3J+u6PZ9IEsw3X/N3+9dgOb4dp+TO3LTPYVX95Z17W9bJ8xz8PNmw+zzJV
	syvlm5V41XqjbT93hWo/6tn9yma+A2dYYdq6jyI/Ln66d9bBcBrD6a0HVbZNPTXhi/l7lWOf
	vq816nwrpyktP4khietCawHfq9JuqxNr+ey3f97R2mj4//Cr0nI3WdHn37xub+K5pGz997v9
	9vXqv7kFgpv3/flalP6i5Nzu21qfXiUG6c157/ezY+FGjQapd+cnRO5OfaHEUpyRaKjFXFSc
	CACTDnML7gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprELMWRmVeSWpSXmKPExsWy7bCSvO7Jp2lpBm8miVjcWTCNyaJ58Xo2
	i7+3L7JaXN41h81i0bJWZovmTVNYLVYtOMDuwO6xeM9LJo/9c9ewe/RtWcXosWX/Z0aPz5vk
	AlijuGxSUnMyy1KL9O0SuDJanwUW7BOoaPt9iLmB8QdvFyMnh4SAicTrQyfZuxi5OIQEtjNK
	7LrWygKRkJRYOvcGO4QtLHG/5QgrRNE3Rok9OxYCJTg42AS0JL4vZASJiwh0MUo82HSHBcRh
	FljEKPGm9w4jSLewgI9Ea89tsEksAqoSRw4+ZAJp5hVwk/i9XhBigZzEzXOdzCA2p4C7xMv5
	f8GOEAIqOXt6FcsERr4FjAyrGEVTC4pz03OTCwz1ihNzi0vz0vWS83M3MYKDTStoB+Oy9X/1
	DjEycTAeYpTgYFYS4RXKSE4T4k1JrKxKLcqPLyrNSS0+xCjNwaIkzquc05kiJJCeWJKanZpa
	kFoEk2Xi4JRqYNooPDWOc+riI50Laqwy/aw0/YtPyfLxf72yiFOt6ZlrXdfyfEtewYCnc9uU
	7y7XkTtYGbw3UN8hIube5MbFE7dmvN292uV279N9O3M4dB+48d49dYlr74NvDjU2OU2vLd0i
	2Q+bHZilEN6cIPlT0jTB/8+fiS/mO87K/3sq4Jxt4bKS6zfU7kp9uf2N6ygr27nLOWm7WVwO
	/Embam675fXhXbuP+hz38Q3cPvukoOkjjoX/lO78OzONcd/K3Zx8e44eSji4Mzf7hdHND5/W
	Oq34tflHxYR3Gtdt274tvXW94vbGGaG2XNLP+jz0BP2LWw/r+s2S7zUNerZeRmvGuo4zlzZN
	t4/eYpZ7wn+u6WNDJZbijERDLeai4kQAPsykD6UCAAA=
X-CMS-MailID: 20240610113849epcas2p225c0dde8fbb833e37be9c2b63850d520
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240610113849epcas2p225c0dde8fbb833e37be9c2b63850d520
References: <1718019553-111939-1-git-send-email-dh10.jung@samsung.com>
	<CGME20240610113849epcas2p225c0dde8fbb833e37be9c2b63850d520@epcas2p2.samsung.com>
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
v1 -> v2:
- none
v2 -> v3:
- none
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


