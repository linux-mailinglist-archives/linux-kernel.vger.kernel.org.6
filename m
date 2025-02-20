Return-Path: <linux-kernel+bounces-523630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16858A3D970
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4123B976D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13391F4628;
	Thu, 20 Feb 2025 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="i55lugV0"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D91C831A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740053009; cv=none; b=N/+uuh7Nz4ZlM2Il35K/nh+sZ71y2qLLUUARJOB0BUkS6AvaI/IPQmiRR+BTVYE2P8QPnQ8gW88OHYKRXaECvrSTt6u+NWaqp+LZ4/8h6aDu6VxImG5SotcsDnaBIP28fmjKofR31334mERI+PaHI8oZy6Ad7edfkaSIzqeRdvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740053009; c=relaxed/simple;
	bh=xrXi1BEIwwUk3QOhc7jbuwBDDuPQ9qm48rVXDOkkeQA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=UaJTBXtszbnBUWelHsDNUTsbRbzko26RpeC/9ze/ZUsxjdotfDs9r2THZj5HzZuFtbkcKChN9l327xfCt/Un81RuK2gBDQ6Z9+nQNfibaLQCKfd57cPoZElKr1hZXXJgqQ4VT6xlttFknw2oO2vRgYUIGG3KWMaDXKXHdQrTDgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=i55lugV0; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250220120326euoutp0277ba3cd79fd233565d42afcc3b006f2a~l6P1jkW6u2350223502euoutp02v
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:03:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250220120326euoutp0277ba3cd79fd233565d42afcc3b006f2a~l6P1jkW6u2350223502euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740053006;
	bh=L7kc5j6jOawDyb59+pR+w+pb7xiFSSDMTgJLWkagQFs=;
	h=From:To:Cc:Subject:Date:References:From;
	b=i55lugV0E2OhwNAYRALl3iU4Ahji/Xv0s6O6HjPQiQk4UxgRU8Zmhlqp15AKYFxVr
	 g8yF7O+bk47FM3yaSAZZZzf2GtC3zgsG6ol9gR0MMdeBIEa7wYnbOwwdw9JAu4XUYi
	 txw/Egp/XMMTx//BAAuzHNPJBpTs7dQHiu7b9yC8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250220120325eucas1p20ba7f206ca4074a61274ccfd7e13cd80~l6P1UoDt_0195301953eucas1p2t;
	Thu, 20 Feb 2025 12:03:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id C3.86.20409.D0A17B76; Thu, 20
	Feb 2025 12:03:25 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250220120325eucas1p10b21797839d1700bc413dd6cb5c63ad8~l6P0-tvcc2401724017eucas1p1_;
	Thu, 20 Feb 2025 12:03:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250220120325eusmtrp1f80221998ca530f4499977143d65a312~l6P0-PRIs3233932339eusmtrp1W;
	Thu, 20 Feb 2025 12:03:25 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-21-67b71a0daeb6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id D1.35.19920.D0A17B76; Thu, 20
	Feb 2025 12:03:25 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250220120324eusmtip2035cf5638b0a6831f60aa7a477b7613e~l6P0h-zYF0049700497eusmtip2E;
	Thu, 20 Feb 2025 12:03:24 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Prashanth K <prashanth.k@oss.qualcomm.com>,
	stable <stable@kernel.org>
Subject: [PATCH] usb: gadget: Fix setting self-powered state on suspend
Date: Thu, 20 Feb 2025 13:03:14 +0100
Message-Id: <20250220120314.3614330-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduznOV1eqe3pBksPals0L17PZnF51xw2
	i0XLWpkt1h65y26x8skRdotP5y+wObB5bFrVyeaxf+4ado8Dr/4yevRtWcXo8XmTXABrFJdN
	SmpOZllqkb5dAlfGvjX32Qv6xCqOzexibmA8KtTFyMkhIWAi0TbnJnMXIxeHkMAKRon/X7tY
	IZwvjBKfzz1ignA+M0osOr6RFaZl75LvjBCJ5YwSLdM+McK1PP68gBGkik3AUKLrbRdbFyMH
	h4iAtUTfwSCQGmaBNYwSXyedYgOpERZwl1g/8Sw7iM0ioCrRtKCBBcTmFbCXmHNuExvENnmJ
	/QfPMkPEBSVOznwCVsMMFG/eOpsZomYqh8TdZWEQtotE87a5LBC2sMSr41vYIWwZidOTe1hA
	jpAQaGeUWPD7PhOEM4FRouH5LUaIKmuJO+d+gV3NLKApsX6XPkTYUaJl4wcWkLCEAJ/EjbeC
	EDfwSUzaNp0ZIswr0dEGDVM1iVnH18GtPXjhEtSZHhKrupeBLRISiJXoXPiRcQKjwiwkn81C
	8tkshBsWMDKvYhRPLS3OTU8tNspLLdcrTswtLs1L10vOz93ECEwxp/8d/7KDcfmrj3qHGJk4
	GA8xSnAwK4nwttVvSRfiTUmsrEotyo8vKs1JLT7EKM3BoiTOu2h/a7qQQHpiSWp2ampBahFM
	lomDU6qBKbtE9FxMddSkhfN/RBaGBkmv7HQJtDph8qT2RrDzzDtlS1+/du4V1FZgXFvbKTar
	cNaVMxei7J/z5mSpe9tzrC54wu2xa9GT42acz4W0OM5Pzm059sKN2+jovE1yzz4G1jfJe2sv
	TVDZyPW0Xep707ELr+yrVPPTt1pemiL5QnBWEktXeezfScwa7Tff/q4/8VbK7NDT3R6zQt+s
	i9+/Ljj/8tRpUQyrjVd5z/JuCzm0tEzkjWbjTr7lVk0fLJeW7C9+H16nqhUzqaDw5Irt//eq
	f7sme2Cf0S7h9A+KCkf5BVR2LOi4u3CLqtzPpzOf5k2ZM9Xq9LLlD94+ENo+fTXzkmPXf93r
	TzkSEtASX6vEUpyRaKjFXFScCAAUlhgeoAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsVy+t/xe7q8UtvTDXYtE7ZoXryezeLyrjls
	FouWtTJbrD1yl91i5ZMj7Bafzl9gc2Dz2LSqk81j/9w17B4HXv1l9OjbsorR4/MmuQDWKD2b
	ovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MfWvusxf0
	iVUcm9nF3MB4VKiLkZNDQsBEYu+S74xdjFwcQgJLGSU2bVvNCpGQkTg5rQHKFpb4c62LDcQW
	EvjEKLHgRBmIzSZgKNH1FiIuImArsezUXTaQQcwC6xgl/k2bwgySEBZwl1g/8Sw7iM0ioCrR
	tKCBBcTmFbCXmHNuExvEAnmJ/QfPMkPEBSVOznwCVsMMFG/eOpt5AiPfLCSpWUhSCxiZVjGK
	pJYW56bnFhvqFSfmFpfmpesl5+duYgSG9rZjPzfvYJz36qPeIUYmDsZDjBIczEoivG31W9KF
	eFMSK6tSi/Lji0pzUosPMZoC3TeRWUo0OR8YXXkl8YZmBqaGJmaWBqaWZsZK4rxul8+nCQmk
	J5akZqemFqQWwfQxcXBKNTAlPnUrs5MP+PrQMmdS8qQpX1X0zCWXu/Ne9/OIz4hxrG7WbLnM
	Nzfukqfu652NK0rFrkW8LNzrvm6D5deWAq6TSYkR3h8Vpumqrc9ye/Lf5b1f+JbaprKiwhWf
	pnyZwRv0duUU/6vON6W+Hj8lp7R0eTJHTaTw2wlTUvaYmrC9X/Snt2HBNSbp+ZaG/Bb154TO
	dgddNWU6ZO0V9K2j8rlAkl5L11E7nvsanR0ciW1LbJ1X5z4M2f17890KrWk1c9/oKkj2zQva
	8Vyt5ClPWWyL3UozXv2/Ni1u8lYyt+9MEJ+mtsHobf+dOsYJHvkSRh/sRf1ZTC9suG9essNY
	7uCpn+XSX24abHljrODlqMRSnJFoqMVcVJwIAHmOtxv2AgAA
X-CMS-MailID: 20250220120325eucas1p10b21797839d1700bc413dd6cb5c63ad8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250220120325eucas1p10b21797839d1700bc413dd6cb5c63ad8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250220120325eucas1p10b21797839d1700bc413dd6cb5c63ad8
References: <CGME20250220120325eucas1p10b21797839d1700bc413dd6cb5c63ad8@eucas1p1.samsung.com>

cdev->config might be NULL, so check it before dereferencing.

CC: stable <stable@kernel.org>
Fixes: 40e89ff5750f ("usb: gadget: Set self-powered based on MaxPower and bmAttributes")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---

This fixes the following kernel panic introduced by today's linux-next (next-20250220):

g_ether gadget.0: HOST MAC fa:78:4e:a7:95:93
g_ether gadget.0: MAC ee:49:25:cd:df:9f
g_ether gadget.0: Ethernet Gadget, version: Memorial Day 2008
g_ether gadget.0: g_ether ready
Unable to handle kernel NULL pointer dereference at virtual address 000000000000002a
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
dwmmc_exynos 12100000.mmc: Unexpected interrupt latency
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000887099000
[000000000000002a] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in: phy_exynos5_usbdrd typec ramoops reed_solomon fuse dm_mod ip_tables x_tables ipv6
CPU: 0 UID: 0 PID: 219 Comm: irq/91-dwc3 Not tainted 6.14.0-rc3-next-20250220+ #9824
Hardware name: WinLink E850-96 board (DT)
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : composite_suspend+0x88/0xd8
lr : dwc3_suspend_gadget+0x44/0x5c
...
Call trace:
 composite_suspend+0x88/0xd8 (P)
 dwc3_suspend_gadget+0x44/0x5c
 dwc3_thread_interrupt+0x934/0xbf0
 irq_thread_fn+0x2c/0xa8
 irq_thread+0x194/0x358
 kthread+0x13c/0x214
 ret_from_fork+0x10/0x20
Code: f9400e83 39450680 321f0000 39050680 (3940a860)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Oops: Fatal exception in interrupt
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x100,00000000,00801250,0200720b
Memory Limit: none
---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
---
 drivers/usb/gadget/composite.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 1fb28bbf6c45..4bcf73bae761 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -2616,7 +2616,8 @@ void composite_suspend(struct usb_gadget *gadget)
 
 	cdev->suspended = 1;
 
-	if (cdev->config->bmAttributes & USB_CONFIG_ATT_SELFPOWER)
+	if (cdev->config &&
+	    cdev->config->bmAttributes & USB_CONFIG_ATT_SELFPOWER)
 		usb_gadget_set_selfpowered(gadget);
 
 	usb_gadget_vbus_draw(gadget, 2);
-- 
2.34.1


