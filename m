Return-Path: <linux-kernel+bounces-406168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32EA9C5FC2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF62BA0BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7F7200B95;
	Tue, 12 Nov 2024 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="03Zk0dHV"
Received: from pv50p00im-ztdg10011901.me.com (pv50p00im-ztdg10011901.me.com [17.58.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0FE2003D5
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424541; cv=none; b=OeC3IW/2hzjltvaFzCdVItug9RBDtKZESfdBr9bWSr9KnoSE6zDVENmXMzSx/I5zZ4UZL/UEpNzx//ZzedCHigTTxalDyEVgTEaTfUfDcOjlCjAiUfzSHetZyPB6T31HtxUbk+ipobdZ3K0/e2JQcvLTaahiFqeJ70GycFzAQBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424541; c=relaxed/simple;
	bh=duXZD9QtW+mKBSWDee8DW9mWFUvLKMU1YDAzy2Lu5oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQlXePHSpFai6h6AxOpxWxpfJWCkFAgw/MZFgDujiqrAjdtxzerVt1hEZ5jh4yRUoz6G1Vgi1YpZHNWBJDOoz+E8x8bkfc9uaJoz4Gi6hv5Yl1awYMMRo4fUv3B7EFWrJ2GYwqFRFuEQu1ER56sVgluy8DItmm5kPRZ8BKyKsPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=03Zk0dHV; arc=none smtp.client-ip=17.58.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1731424540;
	bh=5YXpd3WJ7ylu+cUkGGm1jfujKBmc+KiS9L0FsIucX40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=03Zk0dHVBkekTDS3QyHGDZieNyFlOklwW6+CAXLj6m8qqw/miyNN/yI+2doSDLOOr
	 QiNzvA28THAPiQJ7bxHE87SgF+0xrKetmQ9u9SxrmOtiXJLfiAWGPhaOKwo5nUWd/r
	 QmIITtz/xhVHmA7/xZ8wXrA97Lxop/JSHACwMn1GRVMzJW7t4oFkaWq9crM61XS+zg
	 eH1ZHzWDH1agM988OwXxfeChIh8WYozJATJhpJ6tG0QLM/VcBmj+fSCcGKRhe10gRb
	 hHUoyVqnX4BD3nbwye1Tb6NX18kk7DuXEg4q/dEqsV1vxiy8WMmLrhdjNS7jaZHABK
	 sG1gi1E/jfeOA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id F31973A03DC;
	Tue, 12 Nov 2024 15:15:35 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 12 Nov 2024 23:15:13 +0800
Subject: [PATCH v2 2/2] driver core: class: Correct WARN() message in APIs
 class_(for_each|find)_device()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-class_fix-v2-2-73d198d0a0d5@quicinc.com>
References: <20241112-class_fix-v2-0-73d198d0a0d5@quicinc.com>
In-Reply-To: <20241112-class_fix-v2-0-73d198d0a0d5@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: bCCukNZ5Qy4scceWcRB1kHmbB_zI-XLq
X-Proofpoint-GUID: bCCukNZ5Qy4scceWcRB1kHmbB_zI-XLq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_05,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=897
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411120122
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For both API class_for_each_device(const struct class *class, ...) and
class_find_device(const struct class *class, ...), their WARN() messages
prompt @class was not initialized when suffer class_to_subsys(@class)
error, but the error actually means @class was not registered, so these
warning messages are not accurate.

Fix by replacing term initialized with registered within these messages.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/class.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index b331dda002e3..e81da280af74 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -411,7 +411,7 @@ int class_for_each_device(const struct class *class, const struct device *start,
 	if (!class)
 		return -EINVAL;
 	if (!sp) {
-		WARN(1, "%s called for class '%s' before it was initialized",
+		WARN(1, "%s called for class '%s' before it was registered",
 		     __func__, class->name);
 		return -EINVAL;
 	}
@@ -459,7 +459,7 @@ struct device *class_find_device(const struct class *class, const struct device
 	if (!class)
 		return NULL;
 	if (!sp) {
-		WARN(1, "%s called for class '%s' before it was initialized",
+		WARN(1, "%s called for class '%s' before it was registered",
 		     __func__, class->name);
 		return NULL;
 	}

-- 
2.34.1


