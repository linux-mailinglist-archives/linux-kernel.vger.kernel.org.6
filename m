Return-Path: <linux-kernel+bounces-282101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58FA94DFAE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1611C20F54
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EAA47F6C;
	Sun, 11 Aug 2024 02:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="VXw9hXx7"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E2C4AED7
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343166; cv=none; b=DgXPsKzUn8TxsGFI3VXqYSWeit1hJ0r73+DYiEsLioD3RfaMJClKaIEJzl9+HMyq4JTOLf8yPqFUWy4tZa70TPT3d39sJ2X08j7nSG8r4mnlQkHQFwmPAh0hH2TFk0K/oCArJN3daZGk44SEAc9i3BsqTKmkOV9NNpPg75Cf34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343166; c=relaxed/simple;
	bh=YcSgl56iD1tgmBVG/kSesqPHhTzPX4WS7I24IHCc1aM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iSZ9s9WRO9MRWv2aEtuQpKs1KBXddOgeHQAkpjzxCt/cF8V8FvDomlQNO5BhnlXbGb+/HGXbzlcq3Qv0AiQxhs4icb4PiXIsdI9M4e1bDy5VsmuIR1/MX5yl+6G63mRGeeWppFs365KHVzybwCtJiN41bTeIa7DEil9x31SzoPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=VXw9hXx7; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343164;
	bh=0L55O7aqukEghYl9HBMo8etm0FVHQLfLFvZRHhSmOD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=VXw9hXx7WRW6f/eHTDBgMr3NhKGSmYhF8Pvrx1ilzlIWVy7i4fjNUQFO3EsIpjZEB
	 XQ+OCxvo6eLJNRLjifiQ2Cmu9u2TpD+KUfWPFnQT4AXIWRKEsJIxXvW9W0FiY751XL
	 M+cmgZrzmETDGjs8YMvX6uAwJ7PsErnzAxUtSJXwwylCbXdwn1eNDAkM46JmXhJFDf
	 awtgKXWJK9okXC5JBAXhZXsgjH0sbobZWj14aV055ruoLREpBAnLJtR1tWRVUwkEEw
	 9jqQxulaCHhTsZF3yUlIudBSJWk08iG7bX/pMeXkfwu4WNhBbX3OBueZROaJRo+Ruq
	 5MIHW6SM7xI8Q==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id 7597A1349B23;
	Sun, 11 Aug 2024 02:26:00 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:25:04 +0800
Subject: [PATCH 13/27] cxl/region: Make device_find_child()'s match
 function take a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-13-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: gFj9oZWNnALjctzZNtoEVJ0d1anWM9n6
X-Proofpoint-ORIG-GUID: gFj9oZWNnALjctzZNtoEVJ0d1anWM9n6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=959
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In order to adapt for constified device_find_child(), make its match
functions take a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/cxl/core/region.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 266231d69dff..b5ac52959f5c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -816,9 +816,9 @@ static int match_free_decoder(struct device *dev, void *data)
 	return 0;
 }
 
-static int match_auto_decoder(struct device *dev, void *data)
+static int match_auto_decoder(struct device *dev, const void *data)
 {
-	struct cxl_region_params *p = data;
+	const struct cxl_region_params *p = data;
 	struct cxl_decoder *cxld;
 	struct range *r;
 
@@ -1716,10 +1716,12 @@ static struct cxl_port *next_port(struct cxl_port *port)
 	return port->parent_dport->port;
 }
 
-static int match_switch_decoder_by_range(struct device *dev, void *data)
+static int match_switch_decoder_by_range(struct device *dev,
+					 const void *data)
 {
 	struct cxl_switch_decoder *cxlsd;
-	struct range *r1, *r2 = data;
+	const struct range *r1, *r2 = data;
+
 
 	if (!is_switch_decoder(dev))
 		return 0;
@@ -3193,9 +3195,10 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	return rc;
 }
 
-static int match_root_decoder_by_range(struct device *dev, void *data)
+static int match_root_decoder_by_range(struct device *dev,
+				       const void *data)
 {
-	struct range *r1, *r2 = data;
+	const struct range *r1, *r2 = data;
 	struct cxl_root_decoder *cxlrd;
 
 	if (!is_root_decoder(dev))
@@ -3206,11 +3209,11 @@ static int match_root_decoder_by_range(struct device *dev, void *data)
 	return range_contains(r1, r2);
 }
 
-static int match_region_by_range(struct device *dev, void *data)
+static int match_region_by_range(struct device *dev, const void *data)
 {
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
-	struct range *r = data;
+	const struct range *r = data;
 	int rc = 0;
 
 	if (!is_cxl_region(dev))

-- 
2.34.1


