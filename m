Return-Path: <linux-kernel+bounces-282108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 489A594DFB5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A8D285AF8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349B713633A;
	Sun, 11 Aug 2024 02:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="sOkkr34h"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571C4136336
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343194; cv=none; b=fbsZJHFQ3cRXPOuv451Y5ADJ1J/RtWJspjWil/6Ee7P50MoSAfLprZ9uqntwbs1boWPmZBXTATaEP8D27snchNnfzuZFiSffZLODlYeSYxgt5G1tT39A3+yww+WnSlUXdMihbmHQ0ey6Y3k9SbYfCR6o03HP2KkA1eUT9vqN6RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343194; c=relaxed/simple;
	bh=J4fQvC0s6zKzcic2mO3PYtak7Er4Mup0LfaXw3zI3zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SYJK4cCo+P/ABxOfgp1xrP2wYA7bv4z7EMN3OzVTw9gVH0BLgc31LryrtKNhMc/GlizqmLDMao+woWhThgRZ1fp3/TNg+3+AesVX20FyV8rXFaI4gvdYZHjL+kLysbg8w/w4mwg0x9E0uE6Di+iE1Kp8tDgGUDaHVAjufBPxJps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=sOkkr34h; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343193;
	bh=IOL502w3mqg/fG9UkazI7L/aGgkHfm0/8vZ1l3MD7S4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=sOkkr34hBpr+mxN5hKLRJnhKMKAGliQNqJXymDEIY/C44g5FzymHoI1u/mcjyc4g7
	 TAJQ05+tfnepyKHBS/KCirG4E1kxxMRicCFbpsoE6a97sDh09bgqRYQuzelqRf94B9
	 fcLICZHUZPBk8puQrMCKJUMqezeOwh2XdxsbOBXA5MOus3gCiBeZx8bf0YFHCPDOOG
	 yRbCxPw8uPRBPjYU8AffWe4XE30LWk/LyuH8B1uyZ13hnwuNrltSay37sw0PViv3AQ
	 1WU/Yn4lvqdq6MV/ypW4OcOFvVTJGVyXf32kgSABX0U7l6K045kufrm9k4eKCZWD9I
	 fwSJKvQVa3R2w==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id A36711349C32;
	Sun, 11 Aug 2024 02:26:29 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:25:11 +0800
Subject: [PATCH 20/27] efi: dev-path-parser: Make device_find_child()'s
 match function take a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-20-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: faDzaudgEzMJxyiY8wIsD_QST4Ml0zyS
X-Proofpoint-ORIG-GUID: faDzaudgEzMJxyiY8wIsD_QST4Ml0zyS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=970
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In order to adapt for constified device_find_child(), make
match_pci_dev() as its match function take a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/firmware/efi/dev-path-parser.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/efi/dev-path-parser.c
index 937be269fee8..13ea141c0def 100644
--- a/drivers/firmware/efi/dev-path-parser.c
+++ b/drivers/firmware/efi/dev-path-parser.c
@@ -47,9 +47,9 @@ static long __init parse_acpi_path(const struct efi_dev_path *node,
 	return 0;
 }
 
-static int __init match_pci_dev(struct device *dev, void *data)
+static int __init match_pci_dev(struct device *dev, const void *data)
 {
-	unsigned int devfn = *(unsigned int *)data;
+	unsigned int devfn = *(const unsigned int *)data;
 
 	return dev_is_pci(dev) && to_pci_dev(dev)->devfn == devfn;
 }

-- 
2.34.1


