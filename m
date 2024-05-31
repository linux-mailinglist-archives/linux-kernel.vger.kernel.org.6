Return-Path: <linux-kernel+bounces-196323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DDC8D5A39
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F193C287905
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A037E56B;
	Fri, 31 May 2024 06:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tVugJo3g"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4B07D096
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717135654; cv=none; b=mgUJP4FJ9WvZfd6K2DLe3r7AN0aUl+9pefiUiltmixDZ3ujS8wf30TGyYO58kRKSNTEau+eX7FtBx6C0q/I8/8PTAagbb0J4kPvn//oB4NMdnxY1z6kswK9kREggJi5Wp9s6SmOtKi2JEZt0De04hDTov3eAAlOmxItAFXLNWAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717135654; c=relaxed/simple;
	bh=I7vfVl5cZX8mwhyn2ZbfmSpzKlDYcXY5xhoL6ChVS5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=NwSE6VZWe8raOwW1yVznk7x0cZqZ3EuyDUgD8DVs2KgiHp9lK04uo+EFMw1Jz03iZ8WKUtgCvzmhcbVD11M0W/XVj7qTjdliT5TElfWRZ8QG96j5qjv2LaCg0OjtZfnu6nD2kw/YQQLKRCmhamjdEDxa2E0mioF/pJFpytXlZg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tVugJo3g; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240531060730epoutp0320389135fcb510c4b9abe68927045787~UfcbQEqmS0908109081epoutp035
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:07:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240531060730epoutp0320389135fcb510c4b9abe68927045787~UfcbQEqmS0908109081epoutp035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717135650;
	bh=siIMXjb9LgyGuhIYgE0DvvrWpGOftbUpZD76ktjUGMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tVugJo3g6AKTYVcwUbdaIykV7aLj40X3PKnEm5J7Mvec63VUX7kd+nAMOC2USBpQR
	 xV+3w8tej797LvdOvKl67RSBoKtVDGtPj/S6+w1cXrpqFelJNl4KpNkbjQYCCK1Y8M
	 /3Qwx9n9jH0DSRAksFuJforQ3Z9PBVcfGGIjHN28=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240531060729epcas2p48391ad7a161fa4e3ba7a9be40ae1489d~UfcahJH3y0345403454epcas2p4Q;
	Fri, 31 May 2024 06:07:29 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.98]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VrCMP4cv3z4x9Pv; Fri, 31 May
	2024 06:07:29 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4B.C2.18956.12969566; Fri, 31 May 2024 15:07:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20240531060728epcas2p358edd115ee217a50712f1ca3b3b22bd7~UfcY8QEf60843108431epcas2p3P;
	Fri, 31 May 2024 06:07:28 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240531060728epsmtrp22ec0d075b4063059a8dce96bdcbc482d~UfcY7d6UQ3247032470epsmtrp2y;
	Fri, 31 May 2024 06:07:28 +0000 (GMT)
X-AuditID: b6c32a4d-f95ff70000004a0c-41-66596921033e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C1.6F.07412.02969566; Fri, 31 May 2024 15:07:28 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240531060727epsmtip1f8d8ff2367d46a75dbba6461bc97e506~UfcYqLghN0174601746epsmtip1J;
	Fri, 31 May 2024 06:07:27 +0000 (GMT)
From: Daehwan Jung <dh10.jung@samsung.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Mathias
	Nyman <mathias.nyman@intel.com>, Felipe Balbi <balbi@kernel.org>
Cc: linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE
	TREE BINDINGS), linux-kernel@vger.kernel.org (open list), Daehwan Jung
	<dh10.jung@samsung.com>
Subject: [PATCH v2 1/5] dt-bindings: usb: snps,dwc3: Add
 'snps,xhci-write-64-hi-lo-quirk' quirk
Date: Fri, 31 May 2024 15:07:33 +0900
Message-Id: <1717135657-120818-2-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1717135657-120818-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmua5iZmSawe7JKhbH2p6wW6zZe47J
	Yv6Rc6wWdxZMY7JoXryezeLlrHtsFpd3zWGzWLSsldmiedMUVov/e3awW6xacIDdgdtj8Z6X
	TB6bVnWyeeyfu4bdo2/LKkaPLfs/M3p83iQXwBaVbZORmpiSWqSQmpecn5KZl26r5B0c7xxv
	amZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdJ+SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYp
	tSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITtjw7P7jAVN7BWT+pYyNTA+Ye1i5OSQEDCR
	eLfhHksXIxeHkMAeRonjd/vYIZxPjBK/1u2Fcr4xSnS0tDLDtFycegeqZS+jxOSb98ESQgI/
	gFp+1nQxcnCwCWhJfF/ICFIjIjCLSeLRnLtgDrPAM0aJ9X/OM4EUCQskSnQ/ywPpZRFQlbj1
	/zgLiM0r4CbxY+ondohlchI3z3WCzecUcJd4MOccC0T8I7vE8WNpELaLxK/HXVD/CEu8Or4F
	qldK4vO7vWwQdrHErefPmEFukBBoYZRY8aoF6htjiVnP2hlB7mEW0JRYv0sfxJQQUJY4cgts
	FbMAn0TH4b/sEGFeiY42IYhGZYnplydAbZWUOPj6HNRAD4klh1eyQYJnFqNE650zrBMY5WYh
	LFjAyLiKUSq1oDg3PTXZqMBQNy+1HB5pyfm5mxjBSVDLdwfj6/V/9Q4xMnEwHmKU4GBWEuH9
	lR6RJsSbklhZlVqUH19UmpNafIjRFBh+E5mlRJPzgWk4ryTe0MTSwMTMzNDcyNTAXEmc917r
	3BQhgfTEktTs1NSC1CKYPiYOTqkGpq7t5zao6bf6FMm1nTA4cuXGLvOTGa5HWO8urLp8Y82D
	nucthyavzo9PMprVZb+TuZU9g7U4V+heZlyDdH7u1oh5nb0num6GTha6st7+XPMF1VPaBQ63
	Pgj1m6UubatnOWjEbbN//ZRUN/MzG98elrp7Z+Ot66J/qrqfiVXaKXRsunO4Ryv2WfPBA9V5
	X2dzSsiwKT5qETg2Myb3eevS09O++O+pFTcPW/sndn568b8lBqlL3O58M9u0N/7+Bs4XVRb7
	GaczBRt0zrJ8VOfOIXk8OHf6/qcvtrmFPNz2luf/9vdrfLY2Po/JZ3g/YcrTpWvqrK8daHy8
	1fGg+fQvnA/3vDCqf1m/acr8uFtbf+9TYinOSDTUYi4qTgQAX/f+KAsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSnK5CZmSawcpVXBbH2p6wW6zZe47J
	Yv6Rc6wWdxZMY7JoXryezeLlrHtsFpd3zWGzWLSsldmiedMUVov/e3awW6xacIDdgdtj8Z6X
	TB6bVnWyeeyfu4bdo2/LKkaPLfs/M3p83iQXwBbFZZOSmpNZllqkb5fAlbHh2X3Ggib2ikl9
	S5kaGJ+wdjFyckgImEhcnHqHpYuRi0NIYDejRP/5H2wQCUmJpXNvsEPYwhL3W46wQhR9Y5RY
	ufYYYxcjBwebgJbE94WMIHERgQVMEtem3WYHcZgFnjFK3HvQArZCWCBeYvbEnUwgNouAqsSt
	/8dZQGxeATeJH1M/QW2Qk7h5rpMZxOYUcJd4MOccWI0QUM2uSwfYJzDyLWBkWMUomVpQnJue
	m2xYYJiXWq5XnJhbXJqXrpecn7uJERyqWho7GO/N/6d3iJGJg/EQowQHs5II76/0iDQh3pTE
	yqrUovz4otKc1OJDjNIcLErivIYzZqcICaQnlqRmp6YWpBbBZJk4OKUamPQnz1rwOqOw9qSZ
	Wiijt3e7b5sO15Lv0p1y26tmOXJarP/ksGwFw2v1hJ9HCsUWaorHze5Mzr/nbWRl/4Npu/Kf
	pPS17VJsC1+qHNUtczDKmHPNf1LR8+UnuUokVARTpm98y2vNOEOzoq74p/eMcOlWadFmMev9
	6Un2VgeXNuyRbLfkWmQ+R7zWcLPb6TN2l32rjqadPNdwR/C7F+/nVn7V5/a9Lx26lLr4rN8p
	N04q0F61VMjuyjmzvu7H2xjMjj9d9zP26MxftW8CfzYKbxUoC7/hsmfl1q7bSzZccm9heqUR
	cHbP/v//xfKCeu3yTxVMdRbrOWCwN+LH3/InOT46n1c4Pf9x5N++tc4uSizFGYmGWsxFxYkA
	W8ojEMQCAAA=
X-CMS-MailID: 20240531060728epcas2p358edd115ee217a50712f1ca3b3b22bd7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240531060728epcas2p358edd115ee217a50712f1ca3b3b22bd7
References: <1717135657-120818-1-git-send-email-dh10.jung@samsung.com>
	<CGME20240531060728epcas2p358edd115ee217a50712f1ca3b3b22bd7@epcas2p3.samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add a new quirk for dwc3 core to support writing high-low order.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 1cd0ca9..56091f4 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -254,6 +254,11 @@ properties:
       avoid -EPROTO errors with usbhid on some devices (Hikey 970).
     type: boolean
 
+  snps,xhci-write-64-hi-lo-quirk:
+    description:
+      When set, enable quirk for writing in high-low order.
+    type: boolean
+
   snps,gfladj-refclk-lpm-sel-quirk:
     description:
       When set, run the SOF/ITP counter based on ref_clk.
-- 
2.7.4


