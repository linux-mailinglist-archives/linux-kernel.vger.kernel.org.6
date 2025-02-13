Return-Path: <linux-kernel+bounces-512281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 920BEA33703
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 05:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9860188B346
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 04:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B57711CAF;
	Thu, 13 Feb 2025 04:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nOCFxsqG"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BEC4A01
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 04:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739422212; cv=none; b=npQrhMDDJxyYPHxXmaiUZhNc8n8bpzXswmu72nANyCwdcVBVprcHl98XbBGXvA/YMXeSO+dKQ/aYIQOtj+G3QKQgYHo7zclcTJEg6f+mOfeU5IRb1LabUBJCEDlV3/ZEwxjIB6hOOts3n9GkNvIjZZyd6wXBouNohrAn1N7A0nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739422212; c=relaxed/simple;
	bh=1qutgmmCyzqh7lmkL8B2/VZyPUL+g3Ct4p0UPt0iBTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=Qgs1QyAk8qdMZAvbQYxnJcHm2LiYqdcq142W3srokKJ1cN5Dx/+akxYBJbU7th+VEKTnhcLPQiEsw2R1gGsyjTFp9pX/EQ1huoRVViEIUS2lAlHEnkO7+hvi8hmlUWj3vv1q+w39XsJ5p+D4BXjO/C22NMoqP1J/69E8a7DryEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nOCFxsqG; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250213045007epoutp0373b91095f5e19cfe6a0105b0ce9f250e~jq0giOusX2434824348epoutp03R
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 04:50:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250213045007epoutp0373b91095f5e19cfe6a0105b0ce9f250e~jq0giOusX2434824348epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739422207;
	bh=UjyVcvuqR69NF8lFY3Le8i9E2SxNIAgCWkUw1oNQ8B8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=nOCFxsqG0848DmnQKYeS8caRhTKhwSfNgwI+fdnxNnqWjpCKW+XXfhQWtveTdlcuh
	 XEOOHISNo9vSYqiXRD/VN+Q7CGlhJFPIchLZOYsFUd4i3y86S4fCCob6grR2SOEiQA
	 03lJbX+rWr8fyUsAuyo1itql6SlyLHEbiHdUCeCI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250213045006epcas5p139ff638558a7d10b1d42ec1598da5137~jq0gKpJ_j2465824658epcas5p1Y;
	Thu, 13 Feb 2025 04:50:06 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YtjR26s69z4x9Q7; Thu, 13 Feb
	2025 04:50:06 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250213042208epcas5p2f9dd1305a647d26d6ee55d15dd1967dc~jqcFXN5Dj1925619256epcas5p2r;
	Thu, 13 Feb 2025 04:22:08 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250213042208epsmtrp214b24b092a4717951d8084915dc91119~jqcFWYbCy2954629546epsmtrp2H;
	Thu, 13 Feb 2025 04:22:08 +0000 (GMT)
X-AuditID: b6c32a52-205fe700000083ab-a5-67ad73700fe2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	11.BD.33707.0737DA76; Thu, 13 Feb 2025 13:22:08 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250213042206epsmtip1b37fb1abdb2f33eab02cb87e26605067~jqcC6j9-J3201432014epsmtip1b;
	Thu, 13 Feb 2025 04:22:06 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
	WeitaoWang-oc@zhaoxin.com, Thinh.Nguyen@synopsys.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, h10.kim@samsung.com, eomji.oh@samsung.com,
	alim.akhtar@samsung.com, thiagu.r@samsung.com, muhammed.ali@samsung.com,
	pritam.sutar@samsung.com, cpgs@samsung.com, Selvarasu Ganesan
	<selvarasu.g@samsung.com>
Subject: [PATCH v2 0/2] Fix unassigned variables in xhci driver
Date: Thu, 13 Feb 2025 09:51:24 +0530
Message-ID: <1279309678.121739422206958.JavaMail.epsvc@epcpadp1new>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSnG5B8dp0g/U7jCzeXF3FavFg3jY2
	i5eHNC3uLJjGZHFq+UImi+bF69ks/t6+yGpx9+EPFovLu+awWSxa1sps0bxpCqvF+RddrBaf
	jv5ntXh2bwWbxZHlH5ksVjQDZVctOMBu8ejnXCYHIY/Fe14yeeyfu4bdo2/LKkaPLfs/M3p8
	3iTn8evWLZYAtigum5TUnMyy1CJ9uwSujOuPfjIXvGStuPLjK3MD40eWLkZODgkBE4lj7ZPY
	uxi5OIQEtjNKPD85mQkiIS3xelYXI4QtLLHy33Oooq+MEk9fbWTuYuTgYBMwlHh2wgYkLiKw
	gVHi6pnZrCANzAIHmCTmX1EHsYUF7CW+nL3LCFLPIqAqcXinNUiYV8BK4smvI1DzNSXW7t3D
	BBEXlDg58wkLxBh5ieats5knMPLNQpKahSS1gJFpFaNoakFxbnpucoGhXnFibnFpXrpecn7u
	JkZwTGgF7WBctv6v3iFGJg7GQ4wSHMxKIrwS09akC/GmJFZWpRblxxeV5qQWH2KU5mBREudV
	zulMERJITyxJzU5NLUgtgskycXBKNTApLf71knnrtAObMy/nXDw+r/9G2KoFs2OLvn/ardjc
	4aGYaViiJVe0VrDnLGfa+nvfHs33kr+g7Pq9bDZ/Y8aX+9mKVa4HTij7q0eW8B8vTL+hs7j/
	+SuPXXZ7C/keW7s8zz0SMHu6+NSs9Pnfb6senFooFmJc8P9hV633B85q7k0TtkddaQgNO5G0
	r75hWYqh9Z/3zOYnvsu5/nTLUhbvn3pqTTCXi987657k5du+PY5wq19u9No4SN9Sf9Uli3Wr
	ndyDVecsX5m50uHVNhv7REmH6HrNNZzTAzeebLyxb4ea0pP2u9z1H0xOLnx759Dx6mlsET0K
	Ll+DHfpCDXfNUnKdbTTtUIMT31vFo0eUWIozEg21mIuKEwFnuVP3+AIAAA==
X-CMS-MailID: 20250213042208epcas5p2f9dd1305a647d26d6ee55d15dd1967dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250213042208epcas5p2f9dd1305a647d26d6ee55d15dd1967dc
References: <CGME20250213042208epcas5p2f9dd1305a647d26d6ee55d15dd1967dc@epcas5p2.samsung.com>

This series of patches to fix the following smatch errors from
xhci driver:

drivers/usb/host/xhci-mem.c:2060 xhci_add_in_port() error: unassigned variable 'tmp_minor_revision'
drivers/usb/host/xhci-hub.c:71 xhci_create_usb3x_bos_desc() error: unassigned variable 'bcdUSB'

Change in v2: 
 - Fix bot error from Greg
 - https://lore.kernel.org/linux-usb/2025021234-reaction-womankind-1c0b@gregkh/

Selvarasu Ganesan (2):
  usb: xhci: Fix unassigned variable 'tmp_minor_revision' in
    xhci_add_in_port()
  usb: xhci: Fix unassigned variable 'bcdUSB' in
    xhci_create_usb3x_bos_desc()

 drivers/usb/host/xhci-hub.c | 2 +-
 drivers/usb/host/xhci-mem.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1



