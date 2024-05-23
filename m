Return-Path: <linux-kernel+bounces-188265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8B08CDFD8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3AB1C22295
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1043376E4;
	Fri, 24 May 2024 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KHoiGwQs"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F4A3BBEB
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716521927; cv=none; b=h7TNHENGv7ZTCmhdJcF4OSHtvPULWdnOzwUTyV+/SWYaIBTxR7CUd3pGuqjlw7UUSI+Mpn7Ah8X3/Bl7PYM7OmkmWutPi2ahThuHIjeVqhmkNRDBd1BL8jbjDTWql9vjPKx1UuWy3XW5YYC0ArOjR2Z0iQAwzdg99eafV4gMit4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716521927; c=relaxed/simple;
	bh=wW8O7z9qSta8iJBZz+Yf7/g2CiXdzTnbWPgH1S5yp8w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=d3hfcs1Sg8dfnGochee6EPAx1Lg4OMQKUbfoOc7STToljsnoXX1A46lqK1ZHghmbT0hwHh4YSQB5Pvz5BZePfEkmrwVZfXHVG9DhEH2kGwSdi2aD8OFixDzdSPgenuCK11rBw0uFm+YbASBlGKNCEentyZF0O9X6DbCDXWc4QaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KHoiGwQs; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240524033842epoutp02b0de6370dea53f16d0c2077b821a1724~ST5fyXvj-1999019990epoutp02M
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:38:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240524033842epoutp02b0de6370dea53f16d0c2077b821a1724~ST5fyXvj-1999019990epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716521922;
	bh=XsRGoW8s9vJOipXIlr8NX6JmpQmQL952tUCYOjgPQ3A=;
	h=From:To:Cc:Subject:Date:References:From;
	b=KHoiGwQs3VPYiAx7kQd1vgtHl/tSoTQLaFbILNrszd6veU0xOhBQbsT7poK3bREPW
	 xIGqhtbp4ixLfFbdZgXV2LOqwlrTiDEq1UHp7TL+dP7U8dEd6a+iUowKOFVaGeR/NH
	 RQIap1dvDrY2hG7kEsf7uMil9FRjXOtm8e2AokqA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240524033841epcas5p2ea91080a8473a302b9f70ff390e17dc8~ST5e_7jEZ1803418034epcas5p2A;
	Fri, 24 May 2024 03:38:41 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VlrNv2m7Cz4x9Pw; Fri, 24 May
	2024 03:38:39 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	09.D1.09688.FBB00566; Fri, 24 May 2024 12:38:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240523113915epcas5p32626cec7fb138355e74415534a3ece36~SGzzKUYrE3035030350epcas5p3G;
	Thu, 23 May 2024 11:39:15 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240523113915epsmtrp2d6392fc0f682cae0dda45327d97e8922~SGzzJNpo40362203622epsmtrp2f;
	Thu, 23 May 2024 11:39:15 +0000 (GMT)
X-AuditID: b6c32a4a-837fa700000025d8-95-66500bbf5cde
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	C8.82.19234.3EA2F466; Thu, 23 May 2024 20:39:15 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240523113913epsmtip167f1d1e2c0aaccfa58070d62138619a4~SGzxXxFlK0320903209epsmtip1m;
	Thu, 23 May 2024 11:39:13 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	joshi.k@samsung.com, anuj20.g@samsung.com, nj.shetty@samsung.com,
	c.gameti@samsung.com, gost.dev@samsung.com, Kundan Kumar
	<kundan.kumar@samsung.com>
Subject: [PATCH] nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in offset
Date: Thu, 23 May 2024 17:01:49 +0530
Message-Id: <20240523113149.29174-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmhu5+7oA0g/49ghZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldXi8q45bBbzlz1lt9j2ez6zxbrX71kc
	eDzO39vI4nH5bKnHplWdbB6bl9R77L7ZwObRt2UVo8fnTXIB7FHZNhmpiSmpRQqpecn5KZl5
	6bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAdyoplCXmlAKFAhKLi5X07WyK8ktL
	UhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxMgQoTsjOmLHnFVjCbs+LRJKEGxmPs
	XYycHBICJhKrjr9k7GLk4hAS2M0o8bxxHhOE84lR4u+5j4xwztQlb9i6GDnAWk6tsoCI72SU
	OLJnP1THZ0aJP6u+sIAUsQnoSvxoCgVZISLgInFp5Tc2EJtZ4C6jxMtPWiAlwgIeEo2PakDC
	LAKqEhdegFzBwcErYCuxdoswxHHyEjMvfQc7lFdAUOLkzCcsEFPkJZq3zmYG2Soh0Mghcbn9
	K9Q3LhL7HpxhhrCFJV4d3wIVl5L4/G4vG4SdLXGocQMThF0isfNIA1SNvUTrqX5mkBuYBTQl
	1u/ShwjLSkw9tY4JYi+fRO/vJ1CtvBI75sHYahJz3k1lgbBlJBZemgEV95C4dHM32HghgViJ
	dVtnME1glJ+F5J1ZSN6ZhbB5ASPzKkbJ1ILi3PTUYtMCo7zUcnikJufnbmIEJ1Utrx2MDx98
	0DvEyMTBeIhRgoNZSYQ3eqVvmhBvSmJlVWpRfnxRaU5q8SFGU2AQT2SWEk3OB6b1vJJ4QxNL
	AxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamLh2SBzQehljY3aKsWXijPdp
	gbt+Zfitu+h8V/xdjeuEqV18piU+3/7+t3Ep7tqp3XfTmit+13FH1v07L6icuhT/1u/FNpsD
	TfbNL7/tXbK0Q0hQUrd818zTrzy/7H8z+8HzuHl7H73kzjRc1Xd2+/fF79ZN6Li3bOX1f78S
	jk4W3hBRr5I/TetwxXHn58ks5+5/M6z3OvVdd87t9HMvyv/GbTjO015kr317AW+4qMqHSbdu
	578V/Nl26qrCwar1t/7c/imRvGKO0jPH8NY+1dWbtuWWbEypmDCbUzV4bUqN3yaufZ8CC/xy
	IhWktRfWn3wwXTM5Ve+X7T+O6faG3xRefJvhdChp75/cF/nF0af+K7EUZyQaajEXFScCANYt
	7vAzBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSnO5jLf80g69H9SyaJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF5V1z2CzmL3vKbrHt93xmi3Wv37M4
	8Hicv7eRxePy2VKPTas62Tw2L6n32H2zgc2jb8sqRo/Pm+QC2KO4bFJSczLLUov07RK4MqYs
	ecVWMJuz4tEkoQbGY+xdjBwcEgImEqdWWXQxcnEICWxnlDi8cQJjFyMnUFxGYvfdnawQtrDE
	yn/P2SGKPjJKPNo6jQ2kmU1AV+JHUyhIjYiAl8SZPa+YQWqYBZ4ySryb0c8KUiMs4CHR+KgG
	pIZFQFXiwouXjCBhXgFbibVbhCHGy0vMvPSdHcTmFRCUODnzCQuIzQwUb946m3kCI98sJKlZ
	SFILGJlWMYqmFhTnpucmFxjqFSfmFpfmpesl5+duYgQHtlbQDsZl6//qHWJk4mA8xCjBwawk
	whu90jdNiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9yTmeKkEB6YklqdmpqQWoRTJaJg1Oqgamx
	9LyUX/gkmxt7WgVmfXp0IWq74dUHkx/uqf/xJydxkmnwNuHE47ecPY/Pnm8wd7n4x4xXr8wl
	O+YYTzLz+nL0kNuXvXMXVPZmng6qyhSYLsVsXJ7BfPPTw5lX/22w6l0fyb7dbbbBr63hS20M
	ir7UHO/9oJf6wOx885pX1/quzeu+7lMVEVZ0gqFGpmGed6pAhOHp/YuO+W09leL3xk2xsOrz
	wTc5IuUqSVpNE75bTRPOuydYc7FRwURJ1/ud1ZJMFcl+ntUuHp0p/Td4eKM/vW0MPGtRuPTY
	n0kvt0zYsTn+q4Pvxxdx7ncjbvkanzmYM9eU46aCwc9TN9zlPj5ZW3QxYuv03j3qd36+LzRQ
	YinOSDTUYi4qTgQA2FO3pNsCAAA=
X-CMS-MailID: 20240523113915epcas5p32626cec7fb138355e74415534a3ece36
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240523113915epcas5p32626cec7fb138355e74415534a3ece36
References: <CGME20240523113915epcas5p32626cec7fb138355e74415534a3ece36@epcas5p3.samsung.com>

bio_vec start offset may be relatively large particularly when large
folio gets added to the bio. A bigger offset will result in avoiding the
single-segment mapping optimization and end up using expensive
mempool_alloc further.

Rather than using absolute value, adjust bv_offset by
NVME_CTRL_PAGE_SIZE while checking if segment can be fitted into one/two
PRP entries.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 710043086dff..102a9fb0c65f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -778,7 +778,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
-			if (bv.bv_offset + bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
+			if ((bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) +
+			     bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
 
-- 
2.25.1


