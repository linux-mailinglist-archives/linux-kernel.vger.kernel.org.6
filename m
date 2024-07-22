Return-Path: <linux-kernel+bounces-259225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE349392E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF192B21D15
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2516D16EC1B;
	Mon, 22 Jul 2024 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="I6IWtWxw"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3B416EC11
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721667553; cv=none; b=JY8ayccsPIuj0hfHv4jqh1WnwEskVc+DwaY0ojgNOGIMzWNbHJkGFUJzOru+w7CeGFFUSvKrfecDzS8h+8di3P/H/zBswqJpPl7MD6K+oYDlULMt7fM4Zjr258AEu03QTNBh6pxMpKdCdaGed3xchVlzSavxuPWHVEVxQKFEa3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721667553; c=relaxed/simple;
	bh=Hl160DELcfUJEMLYmH3MiMDfdMOe+YcPvKAceU+mZZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=eC3Uj1uCqxyPJW8LHylx47sH7iC942hZAzAYwgln3164kPR/DKdg00Ocv/ixit4mma5sqhnobx+VELm+jRJuVFDNkv8ZGvKZn5FT4zz+h+FYfx0oJaOdp8P5y5V7ZlzmK0/JYvX3zakRH/t/xzyd7HSW6GIRLXzp8whJOlhsYCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=I6IWtWxw; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240722165901epoutp040cf131bbab98fa4b5a5a68c35e7dff52~kl4H0y43f1067010670epoutp04F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 16:59:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240722165901epoutp040cf131bbab98fa4b5a5a68c35e7dff52~kl4H0y43f1067010670epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721667542;
	bh=ZPVHrwf5yEWr0C7HjWIjCbt24ZYiSE/6yR1KmtOSSR4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=I6IWtWxwy+Gaf5jZcOc7gfJI9+Yyr/nZVvJ/U/QQz9v9X1wF9fy4nLYCeQTAa0QPF
	 ZqYsjWrbNSKYcgaVVaF+nYQrAFybtoRKxwVoZ+LPQvWrl8S11V3lj1S2WjO88eryh5
	 QbcqOuDdiGpXqekiJ1O7JVo9aYch6Z7B+1ZZVAO0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240722165900epcas5p1df85433a84fd194e6df9a77c10e3251c~kl4GiL7BG1862018620epcas5p1F;
	Mon, 22 Jul 2024 16:59:00 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WSRM65K3Jz4x9Pp; Mon, 22 Jul
	2024 16:58:58 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7C.E0.09642.2DF8E966; Tue, 23 Jul 2024 01:58:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240722145728epcas5p38f8ecf57278b4a89c0b09430518c8599~kkN-kLqeV3092130921epcas5p31;
	Mon, 22 Jul 2024 14:57:28 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240722145728epsmtrp2a58776e0d6700da884b32054091e25dd~kkN-jZWFR3128031280epsmtrp2a;
	Mon, 22 Jul 2024 14:57:28 +0000 (GMT)
X-AuditID: b6c32a4b-613ff700000025aa-a9-669e8fd23886
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	09.DE.19367.8537E966; Mon, 22 Jul 2024 23:57:28 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240722145726epsmtip2d6aa1846f9d2ae5955431a91ef56fb52~kkN9e6Mo20575605756epsmtip2E;
	Mon, 22 Jul 2024 14:57:26 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com, shijie.cai@samsung.com,
	Selvarasu Ganesan <selvarasu.g@samsung.com>
Subject: [PATCH] usb: dwc3: core: Prevent USB core invalid event buffer
 address access
Date: Mon, 22 Jul 2024 20:26:09 +0530
Message-ID: <20240722145617.537-1-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmhu6l/nlpBrtmqFu8ubqK1eLOgmlM
	FqeWL2SyaF68ns1i0p6tLBZ3H/5gsbi8aw6bxaJlrcwWn47+Z7VY1TmHxeLI8o9MFpe/72S2
	mHRQ1GLVggPsDnwe++euYffo27KK0WPL/s+MHp83yQWwRGXbZKQmpqQWKaTmJeenZOal2yp5
	B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDdqKRQlphTChQKSCwuVtK3synKLy1JVcjI
	Ly6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIzpjxMrrgEHfF300JDYxbObsYOTkk
	BEwkdjcfZexi5OIQEtjNKPF/1z4mkISQwCdGiQMXC+HsbUeFYRo2d12CatjJKHHywF0o5zuj
	xKk7z9i7GDk42AQMJZ6dsAFpEBEokbj0diMTSA2zQAeTROeyB6wgCWGBCIlXs76B2SwCqhLP
	jjxmBLF5Bawk/t16zA6xTVPiz4q9LBBxQYmTM5+A2cwC8hLNW2czgwyVEPjILjHvUi9Ug4tE
	x+r5ULawxKvjW6BsKYnP7/ayQdjVEqvvfGSDaG5hlDj85BtUkb3E46OPmEE+YAbavH6XPkRY
	VmLqqXVMEIv5JHp/P2GCiPNK7JgHY6tKnGq8DDVfWuLekmusELaHxMrlx1kgwRgr8e/oa5YJ
	jPKzkPwzC8k/sxA2L2BkXsUomVpQnJueWmxaYJyXWg6P1uT83E2M4ISq5b2D8dGDD3qHGJk4
	GA8xSnAwK4nwPnk1N02INyWxsiq1KD++qDQntfgQoykwkCcyS4km5wNTel5JvKGJpYGJmZmZ
	iaWxmaGSOO/r1rkpQgLpiSWp2ampBalFMH1MHJxSDUznpv1M+7v3ocjhB1IyEkdyfY9+DKhn
	b/6oPnWPwYkrCm9dXa4836zPd6tO0788te+hx3y2s+0uxy00vsyf+EollYsjW3T3Bf1n885o
	W0y/wK0cuVctqotfef537Vs7362c+Zzt9OoXNiujLH+pZWgc5BT6fVk4tF5NyyPNPVXf8bfO
	q2zhkLCAT1K//or9uuscG9MdsrzFN/h+e6TPMeEf6Tv4m7p+XT8rwPv511+Dzgxbf/XaFVl3
	P6wx0ffiYIzuVril47vB0PqYPevqjak8TovFq7fe5z67r0FFSK5hjvG2cKV5fct+zPjOw27L
	oT5PaVlKp6aStuvxzVnVUxycDn6QYeltCUr4/6D5oRJLcUaioRZzUXEiAHUKVjcxBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsWy7bCSvG5E8bw0g1WTtC3eXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pzDYnFk+Ucmi8vfdzJb
	TDooarFqwQF2Bz6P/XPXsHv0bVnF6LFl/2dGj8+b5AJYorhsUlJzMstSi/TtErgyZryMLjjE
	XfF3U0ID41bOLkZODgkBE4nNXZcYuxi5OIQEtjNK3Nr0ixEiIS3xelYXlC0ssfLfc3aIoq+M
	Eje6OoEcDg42AUOJZydsQGpEBCokHi+cwQJSwywwhUliwbSDLCAJYYEwiZ1bIAaxCKhKPDvy
	GMzmFbCS+HfrMTvEAk2JPyv2skDEBSVOznwCZjMLyEs0b53NPIGRbxaS1CwkqQWMTKsYRVML
	inPTc5MLDPWKE3OLS/PS9ZLzczcxgoNaK2gH47L1f/UOMTJxMB5ilOBgVhLhffJqbpoQb0pi
	ZVVqUX58UWlOavEhRmkOFiVxXuWczhQhgfTEktTs1NSC1CKYLBMHp1QDU/jtuW+DtNvsjKbM
	d5wq+lXIWyuNt8LCrt60yivzfYnAx9uO8nIciw4nx3+8+Gt2+e/4GTP/CP5is++bvVbQe+Lb
	aw8m8XepTfIKfXagfn/Npo6GwjU/L5barZKed/5CYZ/DykmXvr56vGj9zBspzN4nXzresEmw
	kbVrPDU9qM330nSPZva6lSp/gra/CvxlI7a1/MMRd9OnV/iL3r2+MeWRaunBb8EG4lycLGLJ
	nbM1NGVyGFSXerucsf9oaiqQ/oStdnq/yebS71/8Hp4Sa7OzSqksN599+sTu2l2RCnoZRu8j
	mBw599vK1D4oNb7Quj1k2sZFa3y4liuue5BQ87WsfNq31TnPXkd5mW6NV2Ipzkg01GIuKk4E
	ANPHnL7ZAgAA
X-CMS-MailID: 20240722145728epcas5p38f8ecf57278b4a89c0b09430518c8599
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240722145728epcas5p38f8ecf57278b4a89c0b09430518c8599
References: <CGME20240722145728epcas5p38f8ecf57278b4a89c0b09430518c8599@epcas5p3.samsung.com>

This commit addresses an issue where the USB core could access an
invalid event buffer address during runtime suspend, potentially causing
SMMU faults and other memory issues. The problem arises from the
following sequence.
	1. In dwc3_gadget_suspend, there is a chance of a timeout when
	moving the USB core to the halt state after clearing the
	run/stop bit by software.
	2. In dwc3_core_exit, the event buffer is cleared regardless of
	the USB core's status, which may lead to an SMMU faults and
	other memory issues. if the USB core tries to access the event
	buffer address.

To prevent this issue, this commit ensures that the event buffer address
is not cleared by software  when the USB core is active during runtime
suspend by checking its status before clearing the buffer address.

Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---
 drivers/usb/dwc3/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index cb82557678dd..c7c1a253862e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -559,8 +559,10 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
 void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
+	u32				reg;
 
-	if (!dwc->ev_buf)
+	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
+	if (!dwc->ev_buf || !(reg & DWC3_DSTS_DEVCTRLHLT))
 		return;
 
 	evt = dwc->ev_buf;
-- 
2.17.1


