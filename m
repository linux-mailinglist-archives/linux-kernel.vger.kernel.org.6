Return-Path: <linux-kernel+bounces-196327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C080B8D5A42
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779F928792F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FD780046;
	Fri, 31 May 2024 06:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oisY3DK8"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14677F47F
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717135657; cv=none; b=FCNFP72zYoBA75KSQSrKKcDHkuZ2xPEnzrQWX0nYAfbXFWnLs7smM0T4RAbx/yyGTBb3pFZCQUeVQU2cM9RIVvVhWkUzKqAnCo+ThqK2kYFTN9WmMsCs4jQf3BA1cFhF64UAGHB+dFnmf8TRxa0P3OMrGpP9l3C6m3hMClLTvl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717135657; c=relaxed/simple;
	bh=+3BZx419ZAMcAUTTU97c9t/HNAedUfsPXdqO69drvVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=or7qMLkZwTew2gU5Ja17EGAf/8CzIbyIpOci3D6fkWtsplwafyVHuXae3sqeCpF4ur8nsM952OKgi9WJIVO8+LL6cQHocNPcb+Pfle+9x5h9dhj3EB77wZwbd+hRXNqFpwjHETS2NyFus/Ks/NxiJCyFpNFFjGb9EygZgUxtuCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oisY3DK8; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240531060732epoutp03e687b0fb3c778e743b169cfce2f39553~UfcdTgk6M1007410074epoutp03M
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:07:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240531060732epoutp03e687b0fb3c778e743b169cfce2f39553~UfcdTgk6M1007410074epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717135653;
	bh=PRvIg4Zw3iG8OrJ9EiBqGy+QtBxM3pliyzg3yqVWZb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oisY3DK8MZQnFDBaRa0VYOlt6PTRwybsl0A2KNSL36KyWhNjBxC8Fa4Z4YDIa8O9I
	 lM5+mnvYBi/RvW0Eyt57BS04BGUeoKMq5IZEhsXNXWaBqeguwMCLS9VEsX3PW8CTL/
	 pv+0G7xOr5AyylcKsxG/HOxyfIrbzk36CiKQzp8Q=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20240531060732epcas2p302e1af9507bd5af4044a1f27fb2a2d58~Ufcc9On681346913469epcas2p3t;
	Fri, 31 May 2024 06:07:32 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.99]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VrCMS1fw8z4x9QJ; Fri, 31 May
	2024 06:07:32 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	D2.C2.09479.42969566; Fri, 31 May 2024 15:07:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240531060731epcas2p4f14afae9f00a7e71e6bd3863f0a51441~UfccICfaO0345403454epcas2p4V;
	Fri, 31 May 2024 06:07:31 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240531060731epsmtrp2715f377978b120b5f5025b1fa85798e0~UfccHQ3GS3247032470epsmtrp2G;
	Fri, 31 May 2024 06:07:31 +0000 (GMT)
X-AuditID: b6c32a48-ea7ff70000002507-e4-665969248bf9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	54.6F.07412.32969566; Fri, 31 May 2024 15:07:31 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240531060731epsmtip15254132b4de1938a865da1396dad6bdd~Ufcb7193e0186201862epsmtip1L;
	Fri, 31 May 2024 06:07:31 +0000 (GMT)
From: Daehwan Jung <dh10.jung@samsung.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Mathias
	Nyman <mathias.nyman@intel.com>, Felipe Balbi <balbi@kernel.org>
Cc: linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE
	TREE BINDINGS), linux-kernel@vger.kernel.org (open list), Daehwan Jung
	<dh10.jung@samsung.com>
Subject: [PATCH v2 5/5] usb: host: xhci-plat: Add support for
 XHCI_WRITE_64_HI_LO_QUIRK
Date: Fri, 31 May 2024 15:07:37 +0900
Message-Id: <1717135657-120818-6-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1717135657-120818-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmua5KZmSawcrtnBbH2p6wW6zZe47J
	Yv6Rc6wWdxZMY7JoXryezeLlrHtsFpd3zWGzWLSsldmiedMUVov/e3awW6xacIDdgdtj8Z6X
	TB6bVnWyeeyfu4bdo2/LKkaPLfs/M3p83iQXwBaVbZORmpiSWqSQmpecn5KZl26r5B0c7xxv
	amZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdJ+SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYp
	tSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITtjwfQljAX72CqunXjJ2sB4kLWLkZNDQsBE
	4sTHaWxdjFwcQgI7GCUm3PvADpIQEvjEKHH5LzeE/Y1R4mJ7AkzDjllHWSEa9jJK3F+7ixnC
	+cEoMeXgWaYuRg4ONgEtie8LGUHiIgKzmCQezbkL5jALPGOUWP/nPBPIKGGBSInZ7yYwgtgs
	AqoSJz+1MoPYvAJuEquf/YO6T07i5rlOsDingLvEgznnWEAGSQh8ZJfYde0lVJGLxKP1i5gg
	bGGJV8e3sEPYUhKf3+1lg7CLJW49f8YM0dzCKLHiVQszRMJYYtazdkaQs5kFNCXW79IHMSUE
	lCWO3GIBqWAW4JPoOPyXHSLMK9HRJgTRqCwx/fIEqAskJQ6+Pgc10EPi0vXZ0CCdxSgx6+Jd
	xgmMcrMQFixgZFzFKJZaUJybnlpsVGACj7Hk/NxNjOD0p+Wxg3H22w96hxiZOBgPMUpwMCuJ
	8P5Kj0gT4k1JrKxKLcqPLyrNSS0+xGgKDLyJzFKiyfnABJxXEm9oYmlgYmZmaG5kamCuJM57
	r3VuipBAemJJanZqakFqEUwfEwenVANTa9Yzh8BZzq8dLu/8efjB7h28lfLvH+2c4lL8c/Lu
	C83Mxr1PeH//C4jgWZq25P7h9wdLxA432ExduzPZSKpI9unl7Xstvv4q7d561XpT/LOSY+cn
	7djF3NJ0c8L/3elfJOdMupp1aQbTvrvxDmrXUr762hx7s8H5kSWz9NJH9yv9i/YJehoGyx2T
	TVs8Q93vtJlzG4P3o/7oe0+XVLBJx00odG4KCn36dcdyFs93Rf+fZ6qrn9C5JKibFne0mttN
	5bvPwqoK7/+Mc82WPVnMtlmszXUHW3beVdaPE/1eFZw6PKvcgCshu8DhwEPV7MTALI4la9+p
	FieaSXqXJu7m229lHN7n2vzj4Dyftm1cSizFGYmGWsxFxYkAkSrJhAgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSnK5yZmSaQUeXhsWxtifsFmv2nmOy
	mH/kHKvFnQXTmCyaF69ns3g56x6bxeVdc9gsFi1rZbZo3jSF1eL/nh3sFqsWHGB34PZYvOcl
	k8emVZ1sHvvnrmH36NuyitFjy/7PjB6fN8kFsEVx2aSk5mSWpRbp2yVwZSyYvoSxYB9bxbUT
	L1kbGA+ydjFyckgImEjsmHUUyObiEBLYzSjxsH89I0RCUmLp3BvsELawxP2WI1BF3xgl+r5P
	Zeli5OBgE9CS+L6QESQuIrCASeLatNvsIA6zwDNGiXsPWlhBioQFwiU+H40HGcQioCpx8lMr
	M4jNK+AmsfrZP6gr5CRunusEi3MKuEs8mHOOBcQWAqrZdekA+wRGvgWMDKsYJVMLinPTc5MN
	CwzzUsv1ihNzi0vz0vWS83M3MYIDVUtjB+O9+f/0DjEycTAeYpTgYFYS4f2VHpEmxJuSWFmV
	WpQfX1Sak1p8iFGag0VJnNdwxuwUIYH0xJLU7NTUgtQimCwTB6dUA5PXxzWxQsr7NT6LPe2J
	WGtgEFpxjOXpZObfnu/Or6xNeM4odFRWUC8nROTdLX3TCBeNzIPiC3pTcsriVzSzL36kmWnM
	GC17WK3flOWgnVru0dWHe1anX3Qos5jPvc/l9C6BZxttJop7zph47+2fjg1h3TtSZdgOrd+y
	0+aFVugFpRORP6NDjD9Ufzqm06hsu2GKTKue1qk/2gf169acuXbqbkIfY13uRZ/XWkrsd5YF
	Stn7qLrv6xEwP6Nhf+vC/MCXx9jm7l6meOsGK1fPd8HVjY1FHeHMNdN3HjoVdEvhiZu1y4vT
	6zcaOutJMe4/NeWjh3RM8uevwVOtjoguSDPbXXTzwLz9k/cxiazz/KvEUpyRaKjFXFScCAA+
	KGNdwwIAAA==
X-CMS-MailID: 20240531060731epcas2p4f14afae9f00a7e71e6bd3863f0a51441
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240531060731epcas2p4f14afae9f00a7e71e6bd3863f0a51441
References: <1717135657-120818-1-git-send-email-dh10.jung@samsung.com>
	<CGME20240531060731epcas2p4f14afae9f00a7e71e6bd3863f0a51441@epcas2p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is set by dwc3 parent node to support writing high-low order.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
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


