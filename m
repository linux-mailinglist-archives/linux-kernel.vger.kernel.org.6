Return-Path: <linux-kernel+bounces-331625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE0097AF23
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24E4B2C6D2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DF7171E6E;
	Tue, 17 Sep 2024 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="HxvTBCmq"
Received: from mr85p00im-ztdg06021101.me.com (mr85p00im-ztdg06021101.me.com [17.58.23.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A41117107F
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569798; cv=none; b=FItcH84XErb8PvCAGGC0AME/JsevK1jOEeTtaOAmiZxmHCWKnXS2UVHbWkBluLvcRMud25iDUu3o2z3IkyxhaWtrqIRbHeBfs5kA/GkfY4JicYPLUjNOj9hEE97N2D1Rjz00id159KWVz0YjlfxuJubzl/MeK+cPCfmBB2xEC+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569798; c=relaxed/simple;
	bh=3rhLv1YSaVMZ5CVhEyNpYv6Ws6WbK/XFFVQbsLD94PU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FO657n4ecwEPZBxJjRbbjxZI/gQ10WsFhsXh28ZNOdGMfUwQs2qhdzdAw5j9HFhHA3/CDM+ZChkMskSPnMrhiCZcQy7MpB39kDAJkViPuhIovcjJfYrm+EPdK/WdOZiM+UwyxAnpw0y7VAcCxxxx8fTxx2vL8GS+96g3J7Bg14c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=HxvTBCmq; arc=none smtp.client-ip=17.58.23.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726569796;
	bh=1c8gaHLaVPQ6Fz2Kw16ZXf9HTSs4HHIMh8YMyG91Cc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=HxvTBCmqYa+Yc5nVrZVfbaYs0it7xpFP36JPFYUlillK5hS+k2WOBtf50mzMh9U+5
	 JAIMWx64k6dAEjK+9ioIibbt36Et3TB1BxqTI/ToEC2JiN1bjGVF72VR98V1+CUOmQ
	 qRmKkUWJLQe+rzGxi7BRVwmE/0bn8e/OKrYj/22116UTcB6/eJo459g3S2CsC2mkcF
	 Di5VE2wThRppdCrTWbLRYfwOKeubHsi7WIJD7CQ4ignRxlr+3Kln99kkrCronv7tMR
	 B/CSY9bDaM6TELQ1OStn3xUVe+IDfDqAUY0qwbC/3Yt2OsZY6M7S5YfHCOSmcmsGXI
	 Dk0iA1AkvPLNw==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021101.me.com (Postfix) with ESMTPSA id 1C713801D9;
	Tue, 17 Sep 2024 10:43:14 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 17 Sep 2024 18:42:56 +0800
Subject: [PATCH v2] list: Remove duplicated and unused macro
 list_for_each_reverse
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-fix_list-v2-1-d2914665e89f@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAC9d6WYC/0WMwQ7CIBAFf6XZsxhAsLUn/8M0RmCxmygoaKNp+
 HexifE4701mhoyJMEPfzJBwokwxVJCrBux4Cmdk5CqD5FLxndgyT6/jhfKDab2xSrXGIfdQ9Vv
 C+i2pw1B5rFJM76U8ie/6i7T/yCSYYJ03nUGjBGq3vz/JUrBrG68wlFI+c1leFaIAAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Ingo Molnar <mingo@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: BKyyF1OzodqNRbMiyEdtx3cnTsnAatCe
X-Proofpoint-ORIG-GUID: BKyyF1OzodqNRbMiyEdtx3cnTsnAatCe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_02,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=695 malwarescore=0
 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409170077
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Remove macro list_for_each_reverse due to below reasons:

- it is same as list_for_each_prev.
- it is not used by current kernel tree.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Remove both Fixes and Cc tags
- Link to v1: https://lore.kernel.org/r/20240917-fix_list-v1-1-8fb8beb41e5d@quicinc.com
---
 include/linux/list.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index 5f4b0a39cf46..29a375889fb8 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -686,14 +686,6 @@ static inline void list_splice_tail_init(struct list_head *list,
 #define list_for_each(pos, head) \
 	for (pos = (head)->next; !list_is_head(pos, (head)); pos = pos->next)
 
-/**
- * list_for_each_reverse - iterate backwards over a list
- * @pos:	the &struct list_head to use as a loop cursor.
- * @head:	the head for your list.
- */
-#define list_for_each_reverse(pos, head) \
-	for (pos = (head)->prev; pos != (head); pos = pos->prev)
-
 /**
  * list_for_each_rcu - Iterate over a list in an RCU-safe fashion
  * @pos:	the &struct list_head to use as a loop cursor.

---
base-commit: 6a36d828bdef0e02b1e6c12e2160f5b83be6aab5
change-id: 20240916-fix_list-553c447bde0f

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


