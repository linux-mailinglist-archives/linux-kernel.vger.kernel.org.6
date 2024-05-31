Return-Path: <linux-kernel+bounces-196322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904568D5A32
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36381C244A2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897FB7D3EF;
	Fri, 31 May 2024 06:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="THz7IFy2"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813957CF3A
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717135636; cv=none; b=F4+PIM46cHWGO4ineVekGp/uTlW558Of0zLGi0uAOhT4bewYuoDCo+ZOnlEbMPVD5vcJTqhGjiDb+RDYB6Wz6EXwQ8T60JvU5MVH2AM9EGEDal/yy4bPRpZle2aWoLC8WSXqLuVNrut6uZE/7qQRQboBtALy2CL/fvZ7xieQ0nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717135636; c=relaxed/simple;
	bh=EEX5ulwwTova+mQNBy+545y80BMsjEFJJXYmtCRaVYY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=L73boiOPBQSmZ6QWZvAPMqkb+gMa1ZkCNCoWdr07MUvnAj4pYtQd/6IPMtDV6MhMI+uhbA8yu1LAAVzNVKx9Gm2HYjqSloYi7CPDHaEy9gtNnDUCm9NziZtXlIyAMMbT5JTnvOJiGNzhhRB5afMlrgTsg23lklAnuNTEyoygG/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=THz7IFy2; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240531060712epoutp010507fc947b5a6d30b57e086e5296df09~UfcKLBv7M2335923359epoutp01P
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:07:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240531060712epoutp010507fc947b5a6d30b57e086e5296df09~UfcKLBv7M2335923359epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717135632;
	bh=lKDV9Lg63LYuTqC7+tbrD7f1+q5993NJv6FjnUKs/Sw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=THz7IFy2nHYFFR3BTFB/TlS2FhJKHD5b6Cuk+1wxEtEUtpm2Lm0fd/Afm4UjYP250
	 N7vz+A+OPJer58UZ/v2rtzRyTWRhA6Z1Eaw4KRs47vhDiJlk2HGk02YNm03+tgJ7mq
	 Bls+MrQIMjUvqd6AKe4LfwIce8FqEAY0ABp1aQok=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240531060712epcas2p4a524da1faec7f49395981565053453f1~UfcJz23Rv0235002350epcas2p4i;
	Fri, 31 May 2024 06:07:12 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.98]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VrCM33HGPz4x9QG; Fri, 31 May
	2024 06:07:11 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	0B.DA.09848.F0969566; Fri, 31 May 2024 15:07:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240531060711epcas2p4ee3987a647f6a49b589b783d14ea25ae~UfcI87C_40235002350epcas2p4a;
	Fri, 31 May 2024 06:07:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240531060711epsmtrp2f1265052b4a1a10999a9ba9841fdb37e~UfcI8BjGk3234232342epsmtrp2T;
	Fri, 31 May 2024 06:07:11 +0000 (GMT)
X-AuditID: b6c32a45-447fe70000002678-18-6659690f1003
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8E.91.08336.E0969566; Fri, 31 May 2024 15:07:11 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240531060710epsmtip17a0a62a25928b2871d00720bde6c2a94~UfcIwL4pd0050400504epsmtip1z;
	Fri, 31 May 2024 06:07:10 +0000 (GMT)
From: Daehwan Jung <dh10.jung@samsung.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Mathias
	Nyman <mathias.nyman@intel.com>, Felipe Balbi <balbi@kernel.org>
Cc: linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE
	TREE BINDINGS), linux-kernel@vger.kernel.org (open list), Daehwan Jung
	<dh10.jung@samsung.com>
Subject: [PATCH v2 0/5] usb: Add quirk for writing high-low order
Date: Fri, 31 May 2024 15:07:32 +0900
Message-Id: <1717135657-120818-1-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7bCmmS5/ZmSawd0FkhbH2p6wW6zZe47J
	Yv6Rc6wWdxZMY7JoXryezeLlrHtsFpd3zWGzWLSsldmiedMUVov/e3awW6xacIDdgdtj8Z6X
	TB6bVnWyeeyfu4bdo2/LKkaPLfs/M3p83iQXwBaVbZORmpiSWqSQmpecn5KZl26r5B0c7xxv
	amZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdJ+SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYp
	tSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITvjY+Nj1oLFfBUHtveyNzC+5Opi5OSQEDCR
	mLh4O0sXIxeHkMAORolpX9ewQjifGCWe33zBDOF8Y5To//mOGaZl3vcnjBCJvYwSsx4fZ4Nw
	fjBKLJ55GmgYBwebgJbE94VgRSICs5gkHs25C+YwCzxjlFj/5zwTyChhAUeJybsms4HYLAKq
	Et9edrKA2LwCbhL3/+5lhFgnJ3HzXCfYHRIC19gl+g79Z4VIuEgcX7iCBcIWlnh1fAs7hC0l
	8fndXjYIu1ji1vNnUM0tjBIrXrVAPWEsMetZOyPIqcwCmhLrd+mDmBICyhJHboGNZBbgk+g4
	/JcdIswr0dEmBNGoLDH98gSoCyQlDr4+BzXQQ+L3oQ9grUICsRL/zp9nnMAoOwth/gJGxlWM
	YqkFxbnpqcVGBYbwaErOz93ECE50Wq47GCe//aB3iJGJg/EQowQHs5II76/0iDQh3pTEyqrU
	ovz4otKc1OJDjKbA8JrILCWanA9MtXkl8YYmlgYmZmaG5kamBuZK4rz3WuemCAmkJ5akZqem
	FqQWwfQxcXBKNTCp5q7Lz7jBU32zQVrgg3zCEx6JP3kcSlber6YoCB9ozC3d+81xW/Zv1f8x
	i8OddVM5NvvfDe424svgKf32I8Rh6scDcUmvbf6tMXsuMXGOqCLvUYmcNTVxc19G3Wp8kVbm
	flalnFn6QMsFv7opW+t/L+Vxdvj60qOhJuFa0urHuV83fDhz8m/p4rn1u5N/OX4SPr00gmfL
	rzOqXKca7p57Mc1Ui+XD5DcHZxe4eqTsOvPmhAFbyIEmuSvmKifd6k7PPX5oLfuBbTtf7dvU
	yt45M/bxpA17m5Xdpvw6aCL5qdC66VbvloaFHwPOJgtusegTuCbDOFc5jM+JI3d903GL609e
	umxVuSzyY+G7/P9nlFiKMxINtZiLihMBOdnhX/0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBLMWRmVeSWpSXmKPExsWy7bCSnC5/ZmSaweqFTBbH2p6wW6zZe47J
	Yv6Rc6wWdxZMY7JoXryezeLlrHtsFpd3zWGzWLSsldmiedMUVov/e3awW6xacIDdgdtj8Z6X
	TB6bVnWyeeyfu4bdo2/LKkaPLfs/M3p83iQXwBbFZZOSmpNZllqkb5fAlfGx8TFrwWK+igPb
	e9kbGF9ydTFyckgImEjM+/6EsYuRi0NIYDejxI7ZE5ghEpISS+feYIewhSXutxxhBbGFBL4x
	SnxqTu9i5OBgE9CS+L4QrFdEYAGTxLVpt9lBHGaBZ4wS9x60gDUICzhKTN41mQ3EZhFQlfj2
	spMFxOYVcJO4/3cvI8QCOYmb5zqZJzDyLGBkWMUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpec
	n7uJERx4Wpo7GLev+qB3iJGJg/EQowQHs5II76/0iDQh3pTEyqrUovz4otKc1OJDjNIcLEri
	vOIvelOEBNITS1KzU1MLUotgskwcnFINTM5r9k8WP/57g8qvbxuK6s3cKgVib7w56WnD7qL1
	MGev7tvwQuUIn2mbha9H7pn4SU/12tkgdqUkB4+nJ2++KJ50R2burIq9YXJ3Wdm4db51pHTL
	RL//a/sk8/rjhh+16X/Yn0RtKX+5jrdouUiARFNEeNSJ5SLmi7wZduut+vQg1+xIk/m+i0bS
	HEc+XbzPpLbf40CZY8Kc2mWqHC+ql2yocmqp8D4t3XX5bct3nmnHpMLM15mcyztgnPOXXYp5
	qpzHj8OvfWOSfIqSG7M4naWCZ+xN8t5zoCuw/sMnTwcZsdDDnz/Pmr1w4rNXr9QevZjL1//r
	Zvrm8hidLYZ3o5KMdbW9t4VeMWVI7/JUU2Ipzkg01GIuKk4EAIf3qmCrAgAA
X-CMS-MailID: 20240531060711epcas2p4ee3987a647f6a49b589b783d14ea25ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240531060711epcas2p4ee3987a647f6a49b589b783d14ea25ae
References: <CGME20240531060711epcas2p4ee3987a647f6a49b589b783d14ea25ae@epcas2p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

There's the limitation of Synopsys dwc3 controller with ERST programming in
supporting separate ERSTBA_HI and ERSTBA_LO programming. It's supported when
the ERSTBA is programmed ERSTBA_HI before ERSTBA_LO. But, writing operations
in xHCI is done low-high order following xHCI spec. xHCI specification 5.1
"Register Conventions" states that 64 bit registers should be written in
low-high order. Synopsys dwc3 needs workaround for high-low order. That's why
I add new quirk to support this.

---
Changes in v2:
- add a quirk in dwc3
- add dt-bindings of dwc3/xhci
- set the quirk in xhci-plat from dwc3
Link to v1: https://lore.kernel.org/r/1716875836-186791-1-git-send-email-dh10.jung@samsung.com/

Changes in v1:
- add a quirk in xhci
- use the quirk for programming ERST high-low order
Link to RFC: https://lore.kernel.org/r/1716339839-44022-1-git-send-email-dh10.jung@samsung.com/

---

Daehwan Jung (5):
  dt-bindings: usb: snps,dwc3: Add 'snps,xhci-write-64-hi-lo-quirk'
    quirk
  usb: dwc3: Support quirk for writing high-low order
  dt-bindings: usb: xhci: Add 'write-64-hi-lo-quirk' quirk
  xhci: Add a quirk for writing ERST in high-low order
  usb: host: xhci-plat: Add support for XHCI_WRITE_64_HI_LO_QUIRK

 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
 Documentation/devicetree/bindings/usb/usb-xhci.yaml  | 4 ++++
 drivers/usb/dwc3/core.c                              | 3 +++
 drivers/usb/dwc3/core.h                              | 2 ++
 drivers/usb/dwc3/host.c                              | 5 ++++-
 drivers/usb/host/xhci-mem.c                          | 5 ++++-
 drivers/usb/host/xhci-plat.c                         | 3 +++
 drivers/usb/host/xhci.h                              | 2 ++
 8 files changed, 27 insertions(+), 2 deletions(-)

-- 
2.7.4


