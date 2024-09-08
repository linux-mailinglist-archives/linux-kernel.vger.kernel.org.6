Return-Path: <linux-kernel+bounces-320455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0EF970AA4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14B63B211F1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 23:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F4317A922;
	Sun,  8 Sep 2024 23:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Eg/YXkhF"
Received: from mr85p00im-zteg06023901.me.com (mr85p00im-zteg06023901.me.com [17.58.23.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061A817BB03
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 23:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725838707; cv=none; b=oeLqOY61tRta3NqYOAcr3egqJayYl9aAYQIHIWfMcGjdELFu3p4Q+5SuJ6fiHH9mQ2rQkBeWgRJjQ6LEHtq3v8Vhq5t3rnKBW0vtGKL0oEe5DBcm4ztOXLKk+J0P24gCAjfF7jJhnXy3WwZvaHuV+jr3M1/zT9fZ7Xp26Xx7k+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725838707; c=relaxed/simple;
	bh=dUab2JS0CGPKtdcnME1D1uf/v+Yi40tRx4iJ1c+MM28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kuuATHSI5RyJ7UDMpzIYXqpyWpz+Bm8ZRl8sekBnuOgaNXKUVTT4sygmlXuX2Kd1qTaO+/6jwu8G0nWVBR6py9gYaRLcL5XHjrz6p3kso4Ls4ayfwNuYsL39ieNTpZJ9aBJJB+WxqlFnKrfWHJOy3DU7rpJa8B6A6wzqmx2v1iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Eg/YXkhF; arc=none smtp.client-ip=17.58.23.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725838705;
	bh=7aHm4jYsJ5MTExFzsQS3IUhNT8SYgir310bkZpfTpac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=Eg/YXkhFgU9pGARG+0BDmylmbvvGZzAIK/OJqMEXzrcW1uAr0S1l7uB3cOnRxri65
	 KNkHea4CHCnWP+KIzTjXGB8WwTr08JKSRlOpJMpgF+xKfuTuGpqrlZeyoQ0lLTDqQh
	 HKAMiPv57ITpU7gkKOAVhTlN+rLng3dgYkO5RbjZyEJxw4v1P7vVRBYOTfce2dm3QA
	 yorGOi/T7OjhKi5CqoL7R/neZ9yOziCwvFwtC5DFxjyt4Uu0RalkYNlLNATjCkNo/B
	 QG9etFyLoIFd4NQd0daNMyj+OnG0JvHXkuHuwC1ONOvs+/SPX/2VzEA8EcYfkLwnhO
	 vZZ7e7t920cCQ==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06023901.me.com (Postfix) with ESMTPSA id D4BF26E02C1;
	Sun,  8 Sep 2024 23:38:21 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 09 Sep 2024 07:37:32 +0800
Subject: [PATCH RFC 1/3] amba: bus: Warn on adding an AMBA device without
 valid periphid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-fix_amba-v1-1-4658eed26906@quicinc.com>
References: <20240909-fix_amba-v1-0-4658eed26906@quicinc.com>
In-Reply-To: <20240909-fix_amba-v1-0-4658eed26906@quicinc.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Saravana Kannan <saravanak@google.com>, 
 Isaac Manjarres <isaacmanjarres@google.com>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Zijun Hu <zijun_hu@icloud.com>, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: n9pltrmYgwNHzXq8HVDduhPjbIoOhPWK
X-Proofpoint-ORIG-GUID: n9pltrmYgwNHzXq8HVDduhPjbIoOhPWK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-08_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=736 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409080205
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In order to handle rare case that an AMBA device is added without valid
periphid, it is costly for @amba_bustype's match() to try to read periphid
from hardware, so remind user to configure periphid via DT|ACPI as far as
possible by warning message.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/amba/bus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 34bc880ca20b..cc3c57f83798 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -560,6 +560,9 @@ int amba_device_add(struct amba_device *dev, struct resource *parent)
 
 	/* If primecell ID isn't hard-coded, figure it out */
 	if (!dev->periphid) {
+		dev_warn(&dev->dev,
+			 "Periphid of AMBA device '%s' is not configured, please fix it\n",
+			 dev_name(&dev->dev));
 		/*
 		 * AMBA device uevents require reading its pid and cid
 		 * registers.  To do this, the device must be on, clocked and

-- 
2.34.1


