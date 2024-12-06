Return-Path: <linux-kernel+bounces-434180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CC09E62A1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A3B166B02
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C5C13C8FF;
	Fri,  6 Dec 2024 00:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="C52GUwAS"
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7350813C677
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446447; cv=none; b=Kq5OyPrTG8/BSYNyQH57XtODnkGNjVzh6tRdmLFZvIn0xwbJ4TlhaI6BvtIVFNSd+zhkptv4RzyOLKlBpLycxQTaHGyfrA5JzANZGejHKowtD9uVM9qrGgF/8FEeMCob1/DbNpu1kyZ1JCB5w4fvW3VDjuDzkRzRCFlOP3/yJac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446447; c=relaxed/simple;
	bh=p2uJy5wlhcAeH29QIKPJq4WBggZbGwCXj0DgoGtnco8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OoR0vLPwqdMD/51F/knFIgktbXhjLQiT2rlX9h9fpnDfVxFwyCmATtRrIxw1aeolPEJQNb07PC8a7kuJz6CUxlmKtupMXjYJODqq/04jaG+x2kajzEml2/GABHpmz29Gw8Wf/YHJUyFVHRXZcLEHXZQQAGb7qf9tensccMvagIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=C52GUwAS; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733446446;
	bh=v8GTvyAKaega/LEBXEiMnIjJ5Doyy9iyoBrZIPFUfM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=C52GUwASzYXmvwiAOuLkCT07bTBEy+zo30Uynnca1KTn+h5/hQLzmOwTQEY2r7Hnf
	 D3v7fnp/cF250qBRdelu10XQ1m0EEv9N/Sb4E1BfPLCKmRWfS5DjXCP2DzukuAFXXh
	 QpAmAXrmzEw2ZTHlnb9vWYYrchT0brh6gTu+j5UtULsK40gDCYij0wBfkIzf6csPrx
	 r7y+8s+nOU2Wiqzv9TVQFRqsDMmfkJDLjaJ8q0tCGHBGMU23BAILCZjAsl8RbjkdyC
	 taEp65XrsnhwrNYyWOROAOlOptEfEk7LX7OvpydQ7MpCokCAgnkse7VshHShWQR9oF
	 h0Ue6bNhI4tEQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 5F27AA029A;
	Fri,  6 Dec 2024 00:53:59 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 06 Dec 2024 08:52:35 +0800
Subject: [PATCH 09/10] of: property: Implement of_fwnode_property_present()
 by of_property_present()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-of_core_fix-v1-9-dc28ed56bec3@quicinc.com>
References: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
In-Reply-To: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Leif Lindholm <leif.lindholm@linaro.org>, 
 Stephen Boyd <stephen.boyd@linaro.org>, Maxime Ripard <mripard@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: y32qnoVcQ2pobTvnBj3XT4sfiocRSh8W
X-Proofpoint-ORIG-GUID: y32qnoVcQ2pobTvnBj3XT4sfiocRSh8W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_16,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=862
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412060006
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

of_property_read_bool() is deprecated for non-boolean property, but
of_fwnode_property_present() still uses it.

Fix by using of_property_present() instead of of_property_read_bool().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 519bf9229e613906547b57d8c68e7b8558eff327..dca1a3ebccae1093b2b11f51e8e692bca854d0e3 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -966,7 +966,7 @@ of_fwnode_device_get_dma_attr(const struct fwnode_handle *fwnode)
 static bool of_fwnode_property_present(const struct fwnode_handle *fwnode,
 				       const char *propname)
 {
-	return of_property_read_bool(to_of_node(fwnode), propname);
+	return of_property_present(to_of_node(fwnode), propname);
 }
 
 static int of_fwnode_property_read_int_array(const struct fwnode_handle *fwnode,

-- 
2.34.1


