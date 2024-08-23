Return-Path: <linux-kernel+bounces-298822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BF495CBE8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A909B20E77
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B602184520;
	Fri, 23 Aug 2024 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="QE3iWVki"
Received: from ms11p00im-qufo17291601.me.com (ms11p00im-qufo17291601.me.com [17.58.38.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DD5183CCB
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 12:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.38.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414451; cv=none; b=UL9SDb1x5xQV5PMlbPEXoVkqYMp60/FTiVT00rHHpPV4qmC/jmOQRxxqeSLWjvnlh3GBmeowCHtIJzpJ8PWR79TL6+ExFa5onfz+YBYE6R6Mc23DnjErT+/MzcnkkHzyKiFa7fHD3cBjhQ1knGT34Kj6uiGwkYgh/m51vkqEwqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414451; c=relaxed/simple;
	bh=ihJl2T4szNiGlkfRGvcFms2GN7nRy6jUyPjj4h7nxqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rXtq9LkIwy2PUaZ0AgHaDub1ai7XhWxkT/BXEhi7/S43zOLlEynd2kRzOPEFlro8suQhd2Z2PbItdXbK682qrvOE8M21qUZgnxiUKyeHquqZvB8bk/LlXpZNMucWnwYYoxe83Fl8xiUAiG8ECEBtT38CrwsRJYPuvnF0Zec1+yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=QE3iWVki; arc=none smtp.client-ip=17.58.38.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724414449;
	bh=IDkE8juXFbdUf6c43DEcrUFF7oF41us3ySr7r561+Nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=QE3iWVkixFuiB2PoGSFr8h5MEx/uScsbXk/dcgWr9GmqzroBFDvjGK6rs7ULv+8Ov
	 otKqlE2BBdn+9WoHocyEDm+ZV+Yem9cFXCSdkqDtd4sQCN52XikZdrpKVam+mvGOj3
	 f63kO611u0wD02bvPudQDmcq/MPkQ1ZwOGy/CzjBR2llqDRxTg4J/v2pUpGNu00riz
	 6lRMt+NeUaCqdTZpMVuDbAPcF5VNw66fY7sLJ7LS8y0kGuJsimMU1BbYO8P8nMPrCV
	 7JUPZSek2GcNbALUsj/iha9hUUdwFvZpdHWxWbPzegBFkQmt2OybjLkFx9mo7eL0gq
	 /hVd/TYEXv4SQ==
Received: from [192.168.1.26] (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
	by ms11p00im-qufo17291601.me.com (Postfix) with ESMTPSA id 5E3F83A0242;
	Fri, 23 Aug 2024 12:00:45 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 23 Aug 2024 20:00:14 +0800
Subject: [PATCH v2] driver core: Explicitly initialize struct member
 @data.have_async in __device_attach()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-fix_have_async-v2-1-ed1039527365@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAM15yGYC/3WMwQ7CIBAFf6XZs5guUFI9+R+maYCi7EFaQYlNw
 7+LvXuclzezQXKRXIJzs0F0mRLNoQI/NGC9DnfHaKoMvOWy7blgN/qMXmc36rQGy4RG0SnspxM
 aqNISXX3swetQ2VN6zXHd+xl/699URoZMCi06aZRCaS7PN1kK9mjnBwyllC8ueeEIrgAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: Rbn4VpEl-3YLvM48shNQjtPh0ELEZ0ZR
X-Proofpoint-ORIG-GUID: Rbn4VpEl-3YLvM48shNQjtPh0ELEZ0ZR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_08,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 mlxlogscore=796 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2408230087
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

__device_attach() relies on compiler to implicitly initialize struct
member @data.have_async to avoid the member is used before initialization
but readers may not understand that, solved by explicitly initializing
@data.have_async as well as existing @data.want_async.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Remove both fix and stable tag
- Correct both title and commit messages
- Link to v1: https://lore.kernel.org/r/20240823-fix_have_async-v1-1-43a354b6614b@quicinc.com
---
 drivers/base/dd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9b745ba54de1..b0c44b0846aa 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1021,6 +1021,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 			.dev = dev,
 			.check_async = allow_async,
 			.want_async = false,
+			.have_async = false,
 		};
 
 		if (dev->parent)

---
base-commit: 87ee9981d1f86ee9b1623a46c7f9e4ac24461fe4
change-id: 20240823-fix_have_async-3a135618d91b

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


