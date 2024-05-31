Return-Path: <linux-kernel+bounces-196324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DA28D5A3B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697221F220A0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664453F8FB;
	Fri, 31 May 2024 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vNhOn7LM"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A64D18756E
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717135654; cv=none; b=gU/zfgpjSTKtui7eUyX2nr69Sn1rJGhiG9tu+Q2CaWs4nL+hXmX4ZkEueUZkoe+UKZNzz+3/HjxCtaRGkAwMS5USPth8iOqadlRDOUSyDH5w1YGpw1F0HVN3yt+WrXo4q/+6w8ziraVeNs0ZkfrVA1DhN1cbfUIr34UIUlxf29U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717135654; c=relaxed/simple;
	bh=ztBD1+4ywqM0nXn1kAdyVLehSdMYI6JTkjbKqKWqqoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=TlN2Ojjm0B4khnr7t4+X+W46TCGAASc4u0S2hf23eucgPnYyl7amVOSskA6kUJffKgFvkqN5fVQCjksoyMMJfrq9ezWxIwxMHZwD9MMN+2nMRi1G972S03lAd7Z6x+6UTjLeeWUtUUo5fX6bzMI4LsC991+NPZZEjVW1Ai4UdKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vNhOn7LM; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240531060730epoutp039e05e987d9e9e92163c982afafe42a6b~UfcbQRj_k1004010040epoutp03U
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:07:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240531060730epoutp039e05e987d9e9e92163c982afafe42a6b~UfcbQRj_k1004010040epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717135650;
	bh=3V4t3/0ViKN3UkTN27Ig4BCruu4Zw1qFxlhky6SuapE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vNhOn7LMoghUVqMo+QUosmkUk+/Yogcl1MhcxwnIHiAz5hsAnSnQGg32DmGgpTTcf
	 xtImDonIGw5f+PuRxXIp9IsulqEdlPZoTQU/aGXKlkZDdpW8MKGeeEufcL5lk+ew9r
	 5PCIGk49UFQ9pgjgWFtiSNZf1yzIBhVHe5oijyyI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20240531060730epcas2p33fd374ae51704f064c2ea62e4e41f6dc~UfcayXOZC1346913469epcas2p3m;
	Fri, 31 May 2024 06:07:30 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VrCMP5Fmpz4x9Px; Fri, 31 May
	2024 06:07:29 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	18.FC.09806.12969566; Fri, 31 May 2024 15:07:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20240531060729epcas2p2d895a441b017f1797b1bc1e2558d9e1b~UfcZ13d9M0800108001epcas2p2V;
	Fri, 31 May 2024 06:07:29 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240531060729epsmtrp2601b90f299bcb9298ce4ad92243bff4b~UfcZ06qn13247032470epsmtrp24;
	Fri, 31 May 2024 06:07:29 +0000 (GMT)
X-AuditID: b6c32a47-ecbfa7000000264e-57-665969214e10
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1D.9F.08622.12969566; Fri, 31 May 2024 15:07:29 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240531060729epsmtip1c777a53131abaf67f0c939c1450f7604~UfcZnE_nt0034900349epsmtip1R;
	Fri, 31 May 2024 06:07:29 +0000 (GMT)
From: Daehwan Jung <dh10.jung@samsung.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Mathias
	Nyman <mathias.nyman@intel.com>, Felipe Balbi <balbi@kernel.org>
Cc: linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE
	TREE BINDINGS), linux-kernel@vger.kernel.org (open list), Daehwan Jung
	<dh10.jung@samsung.com>
Subject: [PATCH v2 2/5] usb: dwc3: Support quirk for writing high-low order
Date: Fri, 31 May 2024 15:07:34 +0900
Message-Id: <1717135657-120818-3-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1717135657-120818-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmua5iZmSawZ0NKhbH2p6wW6zZe47J
	Yv6Rc6wWdxZMY7JoXryezeLlrHtsFpd3zWGzWLSsldmiedMUVov/e3awW6xacIDdgdtj8Z6X
	TB6bVnWyeeyfu4bdo2/LKkaPLfs/M3p83iQXwBaVbZORmpiSWqSQmpecn5KZl26r5B0c7xxv
	amZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdJ+SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYp
	tSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj94JdrAVbhStaD0xnbWBcJ9DFyMkhIWAi
	MevBLZYuRi4OIYEdjBLNO24xQTifGCXmfZnCCOF8Y5T4u/0hI0zLnV1fWSESexkl5l54C1X1
	g1Fiy88OoH4ODjYBLYnvC8HiIgKzmCQezbkL5jALPGOUWP/nPBPIKGEBb4l1v5+ygtgsAqoS
	+9/sAovzCrhJTFi/kRVinZzEzXOdzCA2p4C7xIM558CulRD4yA50xzImiCIXiUOb77JD2MIS
	r45vgbKlJD6/28sGYRdL3Hr+jBmiuYVRYsWrFmaIhLHErGftjCBnMwtoSqzfpQ9iSggoSxwB
	hQwnUJRPouPwX3aIMK9ER5sQRKOyxPTLE6DOlJQ4+Poc1EAPiYuTJkHDcRajxLq3e5gnMMrN
	QliwgJFxFaNYakFxbnpqsVGBMTzOkvNzNzGCU6CW+w7GGW8/6B1iZOJgPMQowcGsJML7Kz0i
	TYg3JbGyKrUoP76oNCe1+BCjKTDwJjJLiSbnA5NwXkm8oYmlgYmZmaG5kamBuZI4773WuSlC
	AumJJanZqakFqUUwfUwcnFINTExtv3aE7fQVPH3i2qPK9SXLjT05vI16PockcM86NZlD2/XH
	bX6los5VBybWrrqQ+c6A5VCfeXJ3SxXb//i4yyeWSKzzvG3exsL75XTBz61Xo5vFrR4b3UmS
	S7J2+5f9JGz+uvKPtY7XlBnj1+qfTHb2md/DqrJo5mYru5A9pz5cbZlX9WO3iNaO6O3eEs2f
	4z5te6Bwd4N6UvAFgxdti3ZVTf9XldHY4uh6bDIvm6jwglCf/dtWLZwyl9lXaZL2BQN+ka3n
	L3ucjlQQXXXSzOjy1yM+fS+9Tige1VDWi//3ZqFyiP2kXY93s5vqCZ6ofC3x6VbX0i9NGx56
	sH946xhZpxVQ9pv76QPdZDnXk0osxRmJhlrMRcWJAKMocOwKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSnK5iZmSawePFHBbH2p6wW6zZe47J
	Yv6Rc6wWdxZMY7JoXryezeLlrHtsFpd3zWGzWLSsldmiedMUVov/e3awW6xacIDdgdtj8Z6X
	TB6bVnWyeeyfu4bdo2/LKkaPLfs/M3p83iQXwBbFZZOSmpNZllqkb5fAlfF7wS7Wgq3CFa0H
	prM2MK4T6GLk5JAQMJG4s+sraxcjF4eQwG5GiSMrZjBDJCQlls69wQ5hC0vcbznCCmILCXxj
	lPjwl7OLkYODTUBL4vtCRpBeEYEFTBLXpt1mB3GYBZ4xStx70ALWICzgLbHu91Mwm0VAVWL/
	m11MIDavgJvEhPUbWSEWyEncPNcJtphTwF3iwZxzLBDL3CR2XTrAPoGRbwEjwypGydSC4tz0
	3GLDAqO81HK94sTc4tK8dL3k/NxNjOBA1dLawbhn1Qe9Q4xMHIyHGCU4mJVEeH+lR6QJ8aYk
	VlalFuXHF5XmpBYfYpTmYFES5/32ujdFSCA9sSQ1OzW1ILUIJsvEwSnVwKRg2aZoqe7XHNfz
	8kLr0xUpZ30FrHe/2G4hvUrd0X7yQrnvD77zCP/4suT/bgc2hS9s8TPa7OPvOeUxP73VaVIq
	m254+KBQ4SPtEzqf74am53/ba+o74ZKC1CnRxZat8wplXGZVCm5WPva7mGla8Ya3K9hv30jS
	3mtUbHE75oFVVPT9rQaOHpe5r3xeYWaY5PdL7bFw6Uret/z7E1nYjjDPD43TUJzK33nue6Fj
	RYWrXFNjctiqfSIW0e9+JzEkzpv1X+DfxMV/GoJ0n6ncCr/7K+LquZ1qZ5iSH05MeNoWtJf7
	nfRBBt9vpjl9F9+1r79mv7DgTsfPBx3p7eKhp7RVdnbV9UxfNin9qV1NmBJLcUaioRZzUXEi
	AKiaxm7DAgAA
X-CMS-MailID: 20240531060729epcas2p2d895a441b017f1797b1bc1e2558d9e1b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240531060729epcas2p2d895a441b017f1797b1bc1e2558d9e1b
References: <1717135657-120818-1-git-send-email-dh10.jung@samsung.com>
	<CGME20240531060729epcas2p2d895a441b017f1797b1bc1e2558d9e1b@epcas2p2.samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Set xhci "write-64-hi-lo-quirk" property via
"snps,xhci-write-64-hi-lo-quirk" property.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 drivers/usb/dwc3/core.c | 3 +++
 drivers/usb/dwc3/core.h | 2 ++
 drivers/usb/dwc3/host.c | 5 ++++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 7ee61a8..89985fd 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1716,6 +1716,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->dis_split_quirk = device_property_read_bool(dev,
 				"snps,dis-split-quirk");
 
+	dwc->xhci_write_64_hi_lo_quirk = device_property_read_bool(dev,
+				"snps,xhci-write-64-hi-lo-quirk");
+
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 3781c73..ab5913c 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1142,6 +1142,7 @@ struct dwc3_scratchpad_array {
  *	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
  * @dis_split_quirk: set to disable split boundary.
+ * @xhci_write_64_hi_lo_quirk: set if we enable quirk for writing in high-low order.
  * @sys_wakeup: set if the device may do system wakeup.
  * @wakeup_configured: set if the device is configured for remote wakeup.
  * @suspended: set to track suspend event due to U3/L2.
@@ -1369,6 +1370,7 @@ struct dwc3 {
 	unsigned		dis_metastability_quirk:1;
 
 	unsigned		dis_split_quirk:1;
+	unsigned		xhci_write_64_hi_lo_quirk:1;
 	unsigned		async_callbacks:1;
 	unsigned		sys_wakeup:1;
 	unsigned		wakeup_configured:1;
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index a171b27..8cc0def 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -126,7 +126,7 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
 
 int dwc3_host_init(struct dwc3 *dwc)
 {
-	struct property_entry	props[5];
+	struct property_entry	props[6];
 	struct platform_device	*xhci;
 	int			ret, irq;
 	int			prop_idx = 0;
@@ -162,6 +162,9 @@ int dwc3_host_init(struct dwc3 *dwc)
 
 	props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-sg-trb-cache-size-quirk");
 
+	if (dwc->xhci_write_64_hi_lo_quirk)
+		props[prop_idx++] = PROPERTY_ENTRY_BOOL("write-64-hi-lo-quirk");
+
 	if (dwc->usb3_lpm_capable)
 		props[prop_idx++] = PROPERTY_ENTRY_BOOL("usb3-lpm-capable");
 
-- 
2.7.4


