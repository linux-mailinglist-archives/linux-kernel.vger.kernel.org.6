Return-Path: <linux-kernel+bounces-208086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCDA90207A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC231C219C2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78627E576;
	Mon, 10 Jun 2024 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nVSdMfSR"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38BF2594
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718019534; cv=none; b=K49Wu4bWObq03eBC2W/SJdyZSdiVD/fjWhiHFjXRPW8WFC5LEL5jHqSDgIxTWAIpmuzUl7cvMYIdTKxS54iXPK/ZuubxOTz4CZqVvJ4tY3hCyxcL++S+saTMh3k0kjG0Qg4OqthikgxMyu0pk3ygefYoP8R9uU4dqyfFv8m+jV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718019534; c=relaxed/simple;
	bh=pBG0UlM50yZg5Bbse3Cohd5B0E6o8sQa9JGojhr4uco=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=QkzsHXORS0veM2VyftLZcBEnmfbJlXs49J2KsFWvqqrTJoR9vchmx2ouEknrdFmHU2jpgCJQ20S7eaplBTNlfOPvnv78iic5rjtCZDsoLE+4dhQjn3cfxgCjQARO27rxnPjO+m7UCUJa9R3cvv0EjFAUaOqZn30eIgON+9m95pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nVSdMfSR; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240610113849epoutp01a8d070eeccf5fa6b5de4f2c93c0d451e~XoajH6taH2119921199epoutp01Z
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:38:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240610113849epoutp01a8d070eeccf5fa6b5de4f2c93c0d451e~XoajH6taH2119921199epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718019529;
	bh=o1CDSyOoTgCiZY7HyEcJEnwcOy53MJY9SBw9n/FUbIo=;
	h=From:To:Cc:Subject:Date:References:From;
	b=nVSdMfSROTNgWDGUnZ1btxtKgOQkA/nmSlX5FHuqfe1oEg6nt4c9T3cFDTJqSLyhl
	 6ekvqxv8YKB1lS3YN/e55WZBeCli8rcRaRh3NXz6Vw+M2c/sPB8Dst0LYYl3zrKVm1
	 IN63CU377VqlPDFR6Z8GswYdWKdNDtDY85UwveO8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20240610113848epcas2p115eb5f2774f3926b39c5f0823d857f4d~XoaixYbxk3199331993epcas2p1_;
	Mon, 10 Jun 2024 11:38:48 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.90]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VyVF41cbJz4x9Pv; Mon, 10 Jun
	2024 11:38:48 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	22.F3.09485.8C5E6666; Mon, 10 Jun 2024 20:38:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20240610113847epcas2p15182d509cb4b46b2cda6f781748264b8~XoahyYIik1532215322epcas2p1W;
	Mon, 10 Jun 2024 11:38:47 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240610113847epsmtrp1dbe65cb1a60e24e79a2e23a287c5c557~XoahxuDJp2171421714epsmtrp1O;
	Mon, 10 Jun 2024 11:38:47 +0000 (GMT)
X-AuditID: b6c32a46-19bfa7000000250d-52-6666e5c85e6f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	76.12.07412.7C5E6666; Mon, 10 Jun 2024 20:38:47 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240610113847epsmtip2b0e4b7d7c89004c907ae5db8b890ba67~XoahlL2I11349813498epsmtip2c;
	Mon, 10 Jun 2024 11:38:47 +0000 (GMT)
From: Daehwan Jung <dh10.jung@samsung.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>, Mathias Nyman <mathias.nyman@intel.com>
Cc: linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list), h10.kim@samsung.com, Daehwan Jung
	<dh10.jung@samsung.com>
Subject: [PATCH v3 0/3] usb: Add quirk for writing high-low order
Date: Mon, 10 Jun 2024 20:39:10 +0900
Message-Id: <1718019553-111939-1-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsWy7bCmme6Jp2lpBuvusVrcWTCNyaJ58Xo2
	i7+3L7JaXN41h81i0bJWZovmTVNYLVYtOMDuwO6xeM9LJo/9c9ewe/RtWcXosWX/Z0aPz5vk
	Alijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgM5Q
	UihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIV
	JmRnTHvTx1ywk6ei7VIvUwPjUq4uRk4OCQETiU/HnjJ1MXJxCAnsYJTY9OEBlPOJUaL961Fm
	COcbo8TSUw+ZYFo+TrnLApHYyyjxsO8jO0hCSOAHo0Rzd2gXIwcHm4CWxPeFjCA1IgIdjBJH
	n59mA3GYBRYwSjw4uYgRpEFYwFFi7oW3YM0sAqoS8w9cZgOxeQXcJL5OOc0IsU1O4ua5TrAz
	JAQ2sUtM+LUY6gwXifkXDkDZwhKvjm9hh7ClJF72t0HZxRK3nj+Dam5hlFjxqoUZImEsMetZ
	OyPIqcwCmhLrd+mDmBICyhJHbrGAVDAL8El0HP7LDhHmlehoE4JoVJaYfnkCK4QtKXHw9Tmo
	gR4SX3f8gYZDrMS7v2dYJzDKzkKYv4CRcRWjWGpBcW56arFRgRE8lpLzczcxgpOWltsOxilv
	P+gdYmTiYDzEKMHBrCTCK5SRnCbEm5JYWZValB9fVJqTWnyI0RQYXhOZpUST84FpM68k3tDE
	0sDEzMzQ3MjUwFxJnPde69wUIYH0xJLU7NTUgtQimD4mDk6pBqacfd5JnzQvzRKqa9EViyl7
	/NPru8RSS7u6fe6C9y2cHl8v2JIfNklnTerFn4wviozfmD8NVlRvFl5XnPzCr/1WQ+ZNhp3Z
	wv0TBUJ+NpfvflX5oDpS62+sb6CC6MGTkXK8LZWStu5xwW0hs/R2fd5yasl8v7yZQXycR76d
	1K8wbGhv1vT/GLXog3syF0vdPo5bxfZy7xnm9l/+0Gj4ZmetpvakssMK3AHPlq3arMgiV1ah
	9MzlndtSk/o1x+1fPv/y9Ocm3Vuh1apXPyvVHhHblHWJp/Aw54WsGW1X5tjHH/Q5nXPOze6o
	2sE5+5W5756t3XQ4XeH7wu9b454zPq05P+XBtZhbWqfyr52cWq/EUpyRaKjFXFScCAA7ajIt
	4wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgluLIzCtJLcpLzFFi42LZdlhJXvf407Q0g0OPlC3uLJjGZNG8eD2b
	xd/bF1ktLu+aw2axaFkrs0XzpimsFqsWHGB3YPdYvOclk8f+uWvYPfq2rGL02LL/M6PH501y
	AaxRXDYpqTmZZalF+nYJXBnT3vQxF+zkqWi71MvUwLiUq4uRk0NCwETi45S7LF2MXBxCArsZ
	Ja49vMoOkZCUWDr3BpQtLHG/5QgrRNE3RomVLQfZuhg5ONgEtCS+L2QEiYsIdDFKPNh0B2wS
	s8AiRok3vXcYQbqFBRwl5l54CzaJRUBVYv6By2wgNq+Am8TXKacZITbISdw818k8gZFnASPD
	KkbJ1ILi3PTcZMMCw7zUcr3ixNzi0rx0veT83E2M4EDS0tjBeG/+P71DjEwcjIcYJTiYlUR4
	hTKS04R4UxIrq1KL8uOLSnNSiw8xSnOwKInzGs6YnSIkkJ5YkpqdmlqQWgSTZeLglGpgOt29
	oO+HgujvtvMxzWxPXF97x2ycEbasj/mbbKW8XVZvgPvWhxteqxrosXv16PHVuShdcThoIsPV
	enh1gKHSZvaUV0kz5t5rWJ0iJN///V1FilPvkoLn79dNba7582lB4tEKn52FQi9roqL1f83+
	sGAi0w5rbsk7zw6phn0Jq1n72iojqn26WGCa/tSvi1JywkK71F4sWDor4uwvz9IHBv/djhlr
	G15Q7ux+qftdMVj3v53ap6oFaXaT79nbpR3Mlmf/oHC4xHVmiI5w8LONDPt1u5bO2c6SFPLd
	8i5n9gN+x9gaxdWVuqE2n7azta/6P4Px2uLq5dPVDWw+pWcIGlp23Q27zGxSv8vOh1WJpTgj
	0VCLuag4EQDFi9aKkwIAAA==
X-CMS-MailID: 20240610113847epcas2p15182d509cb4b46b2cda6f781748264b8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240610113847epcas2p15182d509cb4b46b2cda6f781748264b8
References: <CGME20240610113847epcas2p15182d509cb4b46b2cda6f781748264b8@epcas2p1.samsung.com>
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
Changes in v3:
- remove dt-bindings of dwc3/xhci
- pass quirk property unconditionally from dwc3 to xhci platform
- add description and change note in each patch
Link to v2: https://lore.kernel.org/r/1717135657-120818-1-git-send-email-dh10.jung@samsung.com/

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

Daehwan Jung (3):
  usb: dwc3: Support quirk for writing high-low order
  xhci: Add a quirk for writing ERST in high-low order
  usb: host: xhci-plat: Add support for XHCI_WRITE_64_HI_LO

 drivers/usb/dwc3/host.c      | 4 +++-
 drivers/usb/host/xhci-mem.c  | 5 ++++-
 drivers/usb/host/xhci-plat.c | 3 +++
 drivers/usb/host/xhci.h      | 2 ++
 4 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.7.4


