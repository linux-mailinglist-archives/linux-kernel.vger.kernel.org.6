Return-Path: <linux-kernel+bounces-208088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E84AC90207D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44711B244C7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA97D7F7F5;
	Mon, 10 Jun 2024 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jy7fJjkQ"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C6F7CF25
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718019537; cv=none; b=dbOrjVE5cumJOEJ0XF1yT60YJfURiyjbhOklTi1CsxSsYuOGabeH3uGP7jZqmfJy/S5BJKpXrg8L2THe3GRS1CVhxaac6llu4PQqCZ5cHnYHIP63w9Z4cSLCjTkbtNi4Dr+eUmEB/FaVAm9ZGr9qoRo8XSLKrwscvK5S5dcaaKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718019537; c=relaxed/simple;
	bh=w4aoBE2RHPHu2ZSiA+i0yxvAaX2L0ErPKpUGuL84L88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=Wq7iasAkTONxqUxiON9ixt/IILFmk1EsoU8nb4EhMwgZTUPl8Pw8t8XDdoy0N5rIOxySRc+DWjWU5B24RGM9/uKK6tYY8RD5Tm15b6DSTjSxTywFKalyPk93VrA0hJUqynCGQ9r/JUZlloe3QGS2KPqbH4tw1LWVKzUMRCyeOLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jy7fJjkQ; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240610113851epoutp049208c844cd69376ca096c3ca542fea3e~XoalwFJY51836418364epoutp04C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:38:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240610113851epoutp049208c844cd69376ca096c3ca542fea3e~XoalwFJY51836418364epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718019532;
	bh=JxfLXLQD8x6rYjmBvtf0D1L1IPRfMZxdKMeIJSsIEUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jy7fJjkQ2G3HbCVR4a0gTk/+we1dtDbCi0OPYeFQAVwlg7QdrNLIGQVWBinNKOQuw
	 MHaUnh2pgAQ1iPNw7w9tWX7fA4grGz2I/Rs7oLu2/XZgmKcvZst12HhNu4TATC/p+K
	 Zv4esQu8uJt8QNuOJwu1FGGjsYZwVn9I11QpXnnE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20240610113850epcas2p30a935a008aea087500307f1836f90d32~XoaknCzlL2317623176epcas2p35;
	Mon, 10 Jun 2024 11:38:50 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.88]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VyVF61SWvz4x9Pv; Mon, 10 Jun
	2024 11:38:50 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	EB.6F.09806.AC5E6666; Mon, 10 Jun 2024 20:38:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240610113849epcas2p4a61cf754aeb74e62fbcc305f3e5dac59~XoajzS1Bv1984319843epcas2p4B;
	Mon, 10 Jun 2024 11:38:49 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240610113849epsmtrp15769d572ecd01bfd5af42ac753b30462~Xoajyp4o82171421714epsmtrp1P;
	Mon, 10 Jun 2024 11:38:49 +0000 (GMT)
X-AuditID: b6c32a47-c6bff7000000264e-db-6666e5cab052
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	80.52.08622.9C5E6666; Mon, 10 Jun 2024 20:38:49 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240610113849epsmtip277a0976d343b66485873ab18d29d59be~XoajnR-TK1851618516epsmtip2H;
	Mon, 10 Jun 2024 11:38:49 +0000 (GMT)
From: Daehwan Jung <dh10.jung@samsung.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>, Mathias Nyman <mathias.nyman@intel.com>
Cc: linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list), h10.kim@samsung.com, Daehwan Jung
	<dh10.jung@samsung.com>
Subject: [PATCH v3 3/3] usb: host: xhci-plat: Add support for
 XHCI_WRITE_64_HI_LO
Date: Mon, 10 Jun 2024 20:39:13 +0900
Message-Id: <1718019553-111939-4-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1718019553-111939-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7bCmqe6pp2lpBi2X2SzuLJjGZNG8eD2b
	xd/bF1ktLu+aw2axaFkrs0XzpimsFqsWHGB3YPdYvOclk8f+uWvYPfq2rGL02LL/M6PH501y
	AaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QGco
	KZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEK
	E7Iz9s8KLpjEWfFna2YD40X2LkZODgkBE4n2iy1sXYxcHEICOxgldrXeYIVwPjFK7D+1lgnC
	+cYo8fLzHyaYlrf7/jJCJPYySixtuQPV/4NRYsXsfqAqDg42AS2J7wvBikQEOhgljj4/DVbE
	LLCAUeLByUWMIKOEBYIlTr9YzALSwCKgKjFxlwlImFfATWLPgnaobXISN891MoPYnALuEi/n
	/2UBmSMhcIxdYvu7c4wQRS4ST/bthGoQlnh1fAvUd1ISL/vboOxiiVvPnzFDNLcAXfqqhRki
	YSwx61k7I8gRzAKaEut36YOYEgLKEkdusYBUMAvwSXQc/ssOEeaV6GgTgmhUlph+eQIrhC0p
	cfD1OaiBHhKzt1yEhtwsoE0X7rJPYJSbhbBgASPjKkax1ILi3PTUYqMCY3iEJefnbmIEpzIt
	9x2MM95+0DvEyMTBeIhRgoNZSYRXKCM5TYg3JbGyKrUoP76oNCe1+BCjKTDsJjJLiSbnA5Np
	Xkm8oYmlgYmZmaG5kamBuZI4773WuSlCAumJJanZqakFqUUwfUwcnFINTB3/ZvNfdkluWnvg
	9MEbvP3vnhZvTtKveP+/b57rrLhdbkeZvfXLIhjuz/k+z+r5qb28ma+V6t4Kthm5NStcbChY
	17Y/7NOfZTl27/e3pTg9usRwVOl+X/zvljaJrIobJbJieXE2Uu+/cotb/nKf3zU9UMOJ79FB
	qRMfPIoF/v//k/6zdfmMw4UKl31yHja/kt58N2MCh+4Uu+Vq1aslnzz/d3TWm9zemsa99nHh
	ofbNptMWri/p/l9yYK/5t0MO5t4Hrz2cE1MbtNZOOvj8rfjbs+NVu15fthY0fP/5fXj+lbyE
	aTF/SpLUJ96P+/pow5XHoQnxTzl+8D/XC98T/+pIh/DZn/+n3Io6ZnBsznUlluKMREMt5qLi
	RADZ2XkR7gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKLMWRmVeSWpSXmKPExsWy7bCSvO7Jp2lpBlfuGljcWTCNyaJ58Xo2
	i7+3L7JaXN41h81i0bJWZovmTVNYLVYtOMDuwO6xeM9LJo/9c9ewe/RtWcXosWX/Z0aPz5vk
	AlijuGxSUnMyy1KL9O0SuDL2zwoumMRZ8WdrZgPjRfYuRk4OCQETibf7/jJ2MXJxCAnsZpRY
	tbGPGSIhKbF07g2oImGJ+y1HWCGKvjFKbFu9iKmLkYODTUBL4vtCsGYRgS5GiQeb7rCAOMwC
	ixgl3vTeYQTpFhYIlPh4ez8jSAOLgKrExF0mIGFeATeJPQvamSAWyEncPNcJtphTwF3i5fy/
	LCC2EFDN2dOrWCYw8i1gZFjFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcclpaOxj3
	rPqgd4iRiYPxEKMEB7OSCK9QRnKaEG9KYmVValF+fFFpTmrxIUZpDhYlcd5vr3tThATSE0tS
	s1NTC1KLYLJMHJxSDUziR5UijW599XU8Z1h4aKGC1Rd9q7Alx13sFG8vzHKaLS+mdskrYta2
	73qua4Ln/W2fvqc07MIK/beOdQnfGQ8FFDfGbQiSaJ73r7W1T/NLw4eiSxWCYQcf1Unvq0tV
	/vc+8rJijDhDQI/byfmqR4ukzno77Xu3Ijv70rzUbNmCa4/W/3d5r1fwrdHHy1343ZyaOyU2
	6evUq3a9nNGSxT9n/cWrnqqP36lan3u0r2u5e6Ptp8R1wTpFv/07F0f5bc+J0GnQy3O8l3La
	y+vcq/P6viYdWoxhXqWsdTfCVS/XFtyZXRHDdPJiW878/3O1Jma/DO1Q4f07SdrXx2jmvcpP
	v3d7tltYmdxKmJ25VYmlOCPRUIu5qDgRADl8s6qoAgAA
X-CMS-MailID: 20240610113849epcas2p4a61cf754aeb74e62fbcc305f3e5dac59
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240610113849epcas2p4a61cf754aeb74e62fbcc305f3e5dac59
References: <1718019553-111939-1-git-send-email-dh10.jung@samsung.com>
	<CGME20240610113849epcas2p4a61cf754aeb74e62fbcc305f3e5dac59@epcas2p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

xHCI specification 5.1 "Register Conventions" states that 64 bit
registers should be written in low-high order. All writing operations
in xhci is done low-high order following the spec.

Add a new quirk to support workaround for high-low order.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
v1 -> v2:
- this patch is added newly in the patchset
- add setting the hi-lo quirk in xhci platform
v2 -> v3:
- add description in commit message.
---
 drivers/usb/host/xhci-plat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 3d071b8..31bdfa5 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -256,6 +256,9 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 		if (device_property_read_bool(tmpdev, "xhci-sg-trb-cache-size-quirk"))
 			xhci->quirks |= XHCI_SG_TRB_CACHE_SIZE_QUIRK;
 
+		if (device_property_read_bool(tmpdev, "write-64-hi-lo-quirk"))
+			xhci->quirks |= XHCI_WRITE_64_HI_LO;
+
 		device_property_read_u32(tmpdev, "imod-interval-ns",
 					 &xhci->imod_interval);
 	}
-- 
2.7.4


