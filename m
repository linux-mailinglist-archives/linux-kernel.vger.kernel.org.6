Return-Path: <linux-kernel+bounces-224463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4569122BF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D30289655
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29574171662;
	Fri, 21 Jun 2024 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="vcSaHJhz"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96A3172798
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966720; cv=none; b=Bsyta0v4O2xpjnaONvBh1TE9Kle1uKhKjMv8mu1JTqrAHQ2L3mxZJU+Lh7Jc/AfxacR+KO0xCWO4rgub4QRDmnUaT5sSGfL0X0wniPAKOfx9Ozyw1GCCvmLi7TI20PMmvb7eImWsI+ltF+b286UjnnjuPMzZDhZ/1FIsuk0ZF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966720; c=relaxed/simple;
	bh=usmDQv2pcLKB4hsZ9M8prCAudMM/VG2ozTfWHzTwlW0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n8XR5gEblnLw2EyqB4ltRcLqqJIPmUZtNtzuJy+Gqg8PpEHhoyPb/ZnsD0UmOdhcJa5pOtvHXT4v68HeUjm86Gi/3UDslys859mpGoSCB6UdSgTLHZlMTeOs8NKx64dzQMHBrNJnjBnm32SavE4pwLAwcMvkqCGeSck0GNnpFNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=vcSaHJhz; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 5379A100002;
	Fri, 21 Jun 2024 13:44:50 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1718966690; bh=CNC0JexCvUbC2AID9uwavUVu9I3SEDmP57rJWLvUIo8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=vcSaHJhz7lrWahrZOqZuw9X1ffwc+HIEV7mK7xuNG+cbmerGBMU8s92tG2CLHeprA
	 squiMrV8GC2YU/IybY/v8LJVWc4qe0TaH41l3ZPZfhW09MlAX00YEKq+5VBrYuUUbs
	 FXrXfktwOKqN36lnwXmKmKyml0xU6FRh1LY3sXyAX6Ir3JjlhEfctvfzjBsgFDqGkV
	 otG43Jw29uPjvcYo65kFGasMS6Z0b2vziHUGZid8HzRE4ypVX8eFBMTzUvqoH6nAvc
	 SAoWV8DtPzAF3j/L1VClO4igeVi0Vvs43twT1zX27GL6XpjFSas/PwRmhoPEpH8AIb
	 nS0SNfJnpYkag==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Fri, 21 Jun 2024 13:44:05 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.5) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 21 Jun
 2024 13:43:45 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Martyn Welch <martyn.welch@gefanuc.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Soumya Negi <soumya.negi97@gmail.com>, Michael
 Straube <straube.linux@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-staging@lists.linux.dev>, <lvc-project@linuxtesting.org>
Subject: [PATCH] staging: vme_user: Validate geoid used for VME window address
Date: Fri, 21 Jun 2024 13:42:46 +0300
Message-ID: <20240621104246.11292-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186049 [Jun 21 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/06/21 02:12:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/06/21 09:56:00 #25650115
X-KSMG-AntiVirus-Status: Clean, skipped

In tsi148_crcsr_init() value of vme_base used as 3rd parameter in
tsi148_master_set() call is calculated as 'vstat * 0x80000'. vstat value
can be set from module parameter "geoid" which can be any. In this case
the value of an arithmetic expression 'vstat * 0x80000' is a subject to
overflow because its operands are not cast to a larger data type before
performing arithmetic.

Add geoid validation to prevent overflow.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d22b8ed9a3b0 ("Staging: vme: add Tundra TSI148 VME-PCI Bridge driver")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/staging/vme_user/vme_tsi148.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index 2ec9c2904404..b601d2b20bed 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -2119,7 +2119,7 @@ static int tsi148_slot_get(struct vme_bridge *tsi148_bridge)
 		slot = ioread32be(bridge->base + TSI148_LCSR_VSTAT);
 		slot = slot & TSI148_LCSR_VSTAT_GA_M;
 	} else {
-		slot = geoid;
+		slot = geoid & TSI148_LCSR_VSTAT_GA_M;
 	}
 
 	return (int)slot;
-- 
2.30.2


