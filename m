Return-Path: <linux-kernel+bounces-196325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBA18D5A3C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56A51F22D7C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FF77D3E2;
	Fri, 31 May 2024 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EIjvHOTT"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BA47D3E3
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717135654; cv=none; b=RcorGOpMLhgQNvkERb+s9ZzT4WtOLahUOGCxDGUub35Kk7ig3xNPlGUV0cIMZeEopEcIH5x3FPl4CF9XVtIfBZhhKhb54dBtFlliGunwTC4zR4znp/JsK3c6580/Vx8/AEcOWLHXHflgmR087KvR6CtwL3iCYlTr9qt3RFyk0AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717135654; c=relaxed/simple;
	bh=B+HMoOSjpZ2Cd2n5g3X3jsppClYLzAV4iMVq8sBS/70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=Qcl5jHl4gbk5zMbc1ITL3k5nV/9OLfjchXP7207airtpI683GhgKrLuFLig7/oAV6chSQooKIYe6lzpi6mO8qpStJB+JZ6oSUqJt8NyCgMwaxYseaCEozhxBSM1Jnys04rgBwAzxZ3G5h7Xtp7wzheKnxdQ6z6Q3Jvx5fnGgDE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EIjvHOTT; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240531060731epoutp02680113f0e7ffff2f171dce27a0700db5~UfcbzSY4m1304313043epoutp02z
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:07:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240531060731epoutp02680113f0e7ffff2f171dce27a0700db5~UfcbzSY4m1304313043epoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717135651;
	bh=FKza/P/zEeDaPaOYo5ayIu0cB3aav5Gew0qnwy2epQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EIjvHOTTIesI5PLdU862zOm7bcCMk9TlZzF73o+HG7bxFsU23PCWm5XJBp0dzPmI1
	 cAo74YDtGpFKBE3qLV7vV9ruAvF2vfoM/kGfl2KqwrOy6ySalgqrZ5Al3he0eogWsv
	 Wd6UFZs3FTU3/FlrfUFxxDKIhAWT+DqzaMur8eAE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20240531060730epcas2p169b9046d9a796599d8ddf2f712fcd379~UfcbWizH50815908159epcas2p1B;
	Fri, 31 May 2024 06:07:30 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.70]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VrCMQ1JRdz4x9Q5; Fri, 31 May
	2024 06:07:30 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	62.56.08613.22969566; Fri, 31 May 2024 15:07:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20240531060729epcas2p1df12dd3b14c5fa2fa0716f72010b3dbd~UfcabB6en0815908159epcas2p1A;
	Fri, 31 May 2024 06:07:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240531060729epsmtrp2b55c2448305d8fe183a749804524f9b1~UfcaZ5-bD3252232522epsmtrp2E;
	Fri, 31 May 2024 06:07:29 +0000 (GMT)
X-AuditID: b6c32a43-d51fa700000021a5-f6-66596922e3a5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	69.A1.08336.12969566; Fri, 31 May 2024 15:07:29 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240531060729epsmtip1f97c9e7d3f461e3e70d20f23acfd54d6~UfcaMRun90051000510epsmtip1K;
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
Subject: [PATCH v2 3/5] dt-bindings: usb: xhci: Add 'write-64-hi-lo-quirk'
 quirk
Date: Fri, 31 May 2024 15:07:35 +0900
Message-Id: <1717135657-120818-4-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1717135657-120818-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmha5SZmSawaQPbBbH2p6wW6zZe47J
	Yv6Rc6wWdxZMY7JoXryezeLlrHtsFpd3zWGzWLSsldmiedMUVov/e3awW6xacIDdgdtj8Z6X
	TB6bVnWyeeyfu4bdo2/LKkaPLfs/M3p83iQXwBaVbZORmpiSWqSQmpecn5KZl26r5B0c7xxv
	amZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdJ+SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYp
	tSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj4dqJrAV9HBVXfvaxNjDeZ+ti5OSQEDCR
	2P3hHWMXIxeHkMAORon+SRvYIZxPjBINH88zQzjfGCUuvn3NCtNy49A2qMReRomek2+gWn4w
	Sky+fxIow8HBJqAl8X0h2FwRgVlMEo/m3AVzmAWeMUqs/3OeCWSUsECQxPZLnUwgDSwCqhKL
	Z2eAmLwCbhI3LohDLJOTuHmukxnE5hRwl3gw5xwLyBgJgY/sEm9e9LJAFLlI7G9+AHWdsMSr
	41vYIWwpic/v9kI9Wixx6/kzZojmFkaJFa9amCESxhKznrUzgixmFtCUWL9LH8SUEFCWOHIL
	bDyzAJ9Ex+G/7BBhXomONiGIRmWJ6ZcnQG2VlDj4+hzUQA+J5k0NLJAgmcUocXXCOtYJjHKz
	EBYsYGRcxSiWWlCcm56abFRgCI+x5PzcTYzg9KflvIPxyvx/eocYmTgYDzFKcDArifD+So9I
	E+JNSaysSi3Kjy8qzUktPsRoCgy6icxSosn5wAScVxJvaGJpYGJmZmhuZGpgriTOe691boqQ
	QHpiSWp2ampBahFMHxMHp1QDk8eMI3s6fm+X0OJ5k/43eF3/4u4VbV3/k2xfTJfaGbIky0In
	v8Nyj1tH24PZRTrnLJ4xtf56ZtRcuM1mGef8sxsdS5n5JN8dWrqQPbfhyNX0FyrBm7+Hu6ba
	sr9ZUfyNbYGVv/GXzwV5E/63NPf1yYqa9jvnTuSZMKuZ9c6G2m8f5yQt9a17PM39xL/l7vKZ
	c3ab/ZU99rTquMQOJWFJ3sk5l/xCimavLyzRezht5uWM2nWCr83Wx52M+Xmh2iS4rMn+eO6U
	7RXPtF+m3wtYnLp6ktfGLGGppzt/vPhkqB/fsHWzoFJOzccV195ka1xkvzyFfdGJUAGuZTcq
	LppcWzA59M6KL9ve/Q+6e9FtPoMSS3FGoqEWc1FxIgAwJuJrCAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHLMWRmVeSWpSXmKPExsWy7bCSnK5iZmSawe1eA4tjbU/YLdbsPcdk
	Mf/IOVaLOwumMVk0L17PZvFy1j02i8u75rBZLFrWymzRvGkKq8X/PTvYLVYtOMDuwO2xeM9L
	Jo9NqzrZPPbPXcPu0bdlFaPHlv2fGT0+b5ILYIvisklJzcksSy3St0vgyli4diJrQR9HxZWf
	fawNjPfZuhg5OSQETCRuHNrG3MXIxSEksJtR4s/7dewQCUmJpXNvQNnCEvdbjrCC2EIC3xgl
	/v+o62Lk4GAT0JL4vpARpFdEYAGTxLVpt9lBHGaBZ4wS9x60gDUICwRIfG17yArSwCKgKrF4
	dgaIySvgJnHjgjjEeDmJm+c6mUFsTgF3iQdzzrFArHKT2HXpAPsERr4FjAyrGCVTC4pz03OL
	DQsM81LL9YoTc4tL89L1kvNzNzGCg1RLcwfj9lUf9A4xMnEwHmKU4GBWEuH9lR6RJsSbklhZ
	lVqUH19UmpNafIhRmoNFSZxX/EVvipBAemJJanZqakFqEUyWiYNTqoEpVb1q+9ct/9tsJrXb
	+Hj+fnn2Mf+hLDmlPX+qfE9V6J75KHXOxOLOoVePY7V0Jm6T5zPvSf/ZHWhnFbHz0NRjlcuV
	og/KL/8eYSXV79XbMv3HsoOzitcs3JA9/VTzPxbGH3GOcofO7dsVlzn9+2fG+1d2zJufkNm0
	52HNs+7yxbkGsyXem3N6dHzam/VAYXbq9bB1F6SfXG5PVBP68jN/sYDc8hWCa9JKX6aZXLlU
	tkUt/OlUqRMWeqW3KmRFPwSeVfF8/uu457KCeWE1G4q6tsrufNNinH3s0Ipew4P6pQtX6hyx
	W7D7slrbvtkqDSkb0q+IOCsfXLLCVD5wfQajfG9Uib23Q+AD1UsyoclvlFiKMxINtZiLihMB
	6V4TOsECAAA=
X-CMS-MailID: 20240531060729epcas2p1df12dd3b14c5fa2fa0716f72010b3dbd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240531060729epcas2p1df12dd3b14c5fa2fa0716f72010b3dbd
References: <1717135657-120818-1-git-send-email-dh10.jung@samsung.com>
	<CGME20240531060729epcas2p1df12dd3b14c5fa2fa0716f72010b3dbd@epcas2p1.samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

xHCI specification 5.1 "Register Conventions" states that 64 bit
registers should be written in low-high order. All writing operations
in xhci is done low-high order following the spec.

Add a new quirk to support workaround for high-low order.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 Documentation/devicetree/bindings/usb/usb-xhci.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.yaml b/Documentation/devicetree/bindings/usb/usb-xhci.yaml
index 4238ae8..447d331 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.yaml
@@ -25,6 +25,10 @@ properties:
     description: Set if the controller has broken port disable mechanism
     type: boolean
 
+  write-64-hi-lo-quirk:
+    description: Set if the controller has a limitation of high-low order
+    type: boolean
+
   imod-interval-ns:
     description: Interrupt moderation interval
     default: 5000
-- 
2.7.4


