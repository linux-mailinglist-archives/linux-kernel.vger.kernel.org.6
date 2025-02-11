Return-Path: <linux-kernel+bounces-510312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E84E1A31B09
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035DB3A90D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1EF45009;
	Wed, 12 Feb 2025 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A+u//1L9"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9402AD13
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 01:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739322609; cv=none; b=pmCYwY0YGFzSDxiI7+hWDEE8EZlVKXpqDzVTfwXSLU4EW6Lr1vU1dod1pw9nXR4B2dX3iOlr88CtCiFiwk9VNNPkBk0eo1YNK34J1DGpme1BzCm7FrjO4skrzZdBW6LwIQgDpeV5jF+d2BgF58TbK+eXQlBZWHoWUwiHAxtNxRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739322609; c=relaxed/simple;
	bh=0NC9eQg1/ezpsGypnlF/+A5luIQO0j9naVw0aEb0Lrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=IucjTyJXZLcFIHWl+6NRomw66N4s/WWFNwULgti9d/vrLJ9vYKGnWKCRKRu8q8LLpwzOSapcNkDkLXdmBHPRarnVJbdCtFlndAgRvIFjo2pu5uQJ4WTwrIGAL6Xav+Ajjspo1O1qXeqeqWL4D8862GzPXIeHSoYtIzR4rXzm7B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=A+u//1L9; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250212011003epoutp02e87b4cf24a4110bfe13a382e12b3f1e4~jULE3UB9L3212832128epoutp02I
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 01:10:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250212011003epoutp02e87b4cf24a4110bfe13a382e12b3f1e4~jULE3UB9L3212832128epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739322603;
	bh=i/T3MssO3zuJsAFBm0D9MFgbnCcZlsizNue9wNsfWjc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=A+u//1L9BxjNUjMX8tzI4+62T6U5cIpfJm3DNBNLH2vX07J4MSbfMHiMKHLdicTwB
	 uknE8HEjHv7FZ37NScCsrExLIU8r7LoaOUAUsWjgSC/g1Ie7BWf25zqiRJV6SRjJkt
	 9IHsUJzfkvyMixIe+9P9DIRxqVrE4zkfzys6Sb9Y=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250212011002epcas5p223e650e314b88574d9ec7082861b82d5~jULEe5ERB0927509275epcas5p2a;
	Wed, 12 Feb 2025 01:10:02 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Yt0bZ530lz4x9Q8; Wed, 12 Feb
	2025 01:10:02 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250211115704epcas5p4140a490572fb9c4ac71a82abcb61f291~jJWuFl15F0222102221epcas5p4N;
	Tue, 11 Feb 2025 11:57:04 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250211115704epsmtrp1f8ab2434ccdb302167d3c97f242767ad~jJWuEpWQm1464114641epsmtrp12;
	Tue, 11 Feb 2025 11:57:04 +0000 (GMT)
X-AuditID: b6c32a2a-bca3124000004a05-88-67ab3b106bad
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6B.96.18949.01B3BA76; Tue, 11 Feb 2025 20:57:04 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250211115701epsmtip12d20d2ba4e1a9d9722615664c9c3f98c~jJWrFIDCe2052820528epsmtip1i;
	Tue, 11 Feb 2025 11:57:01 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
	WeitaoWang-oc@zhaoxin.com, Thinh.Nguyen@synopsys.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, h10.kim@samsung.com, eomji.oh@samsung.com,
	alim.akhtar@samsung.com, thiagu.r@samsung.com, muhammed.ali@samsung.com,
	pritam.sutar@samsung.com, cpgs@samsung.com, Selvarasu Ganesan
	<selvarasu.g@samsung.com>
Subject: [PATCH 0/2] Fix unassigned variables in xhci driver
Date: Tue, 11 Feb 2025 17:26:28 +0530
Message-ID: <1296674576.21739322602698.JavaMail.epsvc@epcpadp1new>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSnK6A9ep0gz0rNS3eXF3FavFg3jY2
	i5eHNC3uLJjGZHFq+UImi+bF69ks/t6+yGpx9+EPFovLu+awWSxa1sps0bxpCqvF+RddrBaf
	jv5ntXh2bwWbxZHlH5ksVjQDZVctOMBu8ejnXCYHIY/Fe14yeeyfu4bdo2/LKkaPLfs/M3p8
	3iTn8evWLZYAtigum5TUnMyy1CJ9uwSujBnts9gK3rNUTD7xha2BsYOli5GTQ0LAROLMnsWM
	ILaQwG5GiZU73CHi0hKvZ3UxQtjCEiv/PWfvYuQCqvnKKDFzZSOQw8HBJmAo8eyEDUhcRGAD
	o8TVM7NZQRqYBQ4wScy/og5iCwvYSExYso0NxGYRUJXY9HQZWA2vgJXE45M/oRZoSqzdu4cJ
	Ii4ocXLmExaIOfISzVtnM09g5JuFJDULSWoBI9MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS9
	5PzcTYzg2NDS2sG4Z9UHvUOMTByMhxglOJiVRHhNFq5IF+JNSaysSi3Kjy8qzUktPsQozcGi
	JM777XVvipBAemJJanZqakFqEUyWiYNTqoFp3l4n2Qd7DOYsaYxp3ZuUJ7OiefEDzhqj6pzU
	gyd9Axbwt1U+nPH6AYuBcu6mmojJ7nbTt1apNW3ZL9tl/f+06d/5/mXpSWvY2+s2Kz3ss9sm
	Gyt9hK3baued/useedmbs1WmfDvyylBN3+HLvhzzkGWsFveS6jyrnCy1d1+68OXj8yPBmwUz
	jtVNnpNV9+PkOefdwfkXPy+9Ee3lq/D+8cQbxz51mM9pc5rEVRiVahu1Xi3m1O2zyw51mb53
	WBldWDf94h2hub9LtthWhu2z3DLzSJPcky7WG62vNFvqdsbuW/34Ud6GMG2JouDPCqxXT/8s
	PaeQkZJ2/tb99sOlpicl5fpfirSKFVZ+dH6txFKckWioxVxUnAgAgqe++fwCAAA=
X-CMS-MailID: 20250211115704epcas5p4140a490572fb9c4ac71a82abcb61f291
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250211115704epcas5p4140a490572fb9c4ac71a82abcb61f291
References: <CGME20250211115704epcas5p4140a490572fb9c4ac71a82abcb61f291@epcas5p4.samsung.com>

This series of patches to fix the following smatch errors from
xhci driver:

drivers/usb/host/xhci-mem.c:2060 xhci_add_in_port() error: unassigned variable 'tmp_minor_revision'
drivers/usb/host/xhci-hub.c:71 xhci_create_usb3x_bos_desc() error: unassigned variable 'bcdUSB'

---
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



