Return-Path: <linux-kernel+bounces-302814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8512A9603B4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81151C226FF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD4515884D;
	Tue, 27 Aug 2024 07:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="Hixc4zK4"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EA5156C5E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745344; cv=none; b=PdfJKePfwdbAzudiXgR7SMobojwz6s9qgHdvMpeVG1V+QTeSQ62glETE2FqHDiQh+okq9mCJy+h+aI0qLWl8/HeQQqYc++xVVrcapQXP8pFjY/h+gTuxdrgw3W5dwY8gJ6V7Uj7AXbfbxv6lDCf6jPKStK0f4lcu+++dRiXRpbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745344; c=relaxed/simple;
	bh=KLp66pXeCyQ/PBzH4Pg7bqSDB9W/oacAbiUakwYZg8s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G23GAy8RfWIvJCl3se2l5n9ZHhlwIzt+KpVR+KZlMB+WKrRVs2BEqCrbUsrg+uC8Fjm7l1krkrfNB2Rfo2/IkkveXwogQVxzdNP149QhB4Xa6t4IC8i9pGmwDF032HBtjzeP2/+mTn9BtpdnEwd+20VUC8sKbfLIXi5NMBdZ/V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=Hixc4zK4; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id DCF2A100003;
	Tue, 27 Aug 2024 10:48:01 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1724744881; bh=mZd5SxQ6/iSv3dYwCp9ZswLfTPzSCAOtFAA9bwTE6qg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Hixc4zK42W0PUvTNP9csFFw2LFvYIuqIMzPQX1Y1bcQCmeoKp9B5zMa8rCSQXUP5w
	 7T8WObj2M150zKldSafqzClsC6qIVPHrWJlKfk1NhjDYuHwIcAe1kLSuSnUGDGDG/2
	 M1XNTObdyJim11MTjV4B3RCCwlb01/Gg1l5rO0tTPDBXu807fR2GZ24SmWIOqdLyN/
	 FvQ7NWUTeOzz17A0T9qLAFnVJ59INvFmdse2c2Gz7dabfuRdPQG8joH8doFwj1ueLD
	 TJENQg1NtQ8DtHPIWkrYZO0WB5ycdOMJkJxMp9Kzn9DuZVftbVP9RXw7xz+jFOjl1p
	 EitMixoumK7Cg==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue, 27 Aug 2024 10:47:27 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 10:47:07 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Ian Abbott <abbotti@mev.co.uk>, H
 Hartley Sweeten <hsweeten@visionengravers.com>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] staging: comedi: Add driver register error handling in c6xdigio_attach()
Date: Tue, 27 Aug 2024 10:46:54 +0300
Message-ID: <20240827074654.14131-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 187352 [Aug 27 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 27 0.3.27 71302da218a62dcd84ac43314e19b5cc6b38e0b6, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mx1.t-argos.ru.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/08/27 07:21:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/08/27 03:57:00 #26440321
X-KSMG-AntiVirus-Status: Clean, skipped

In c6xdigio_attach() there is a pnp_register_driver() call without return
value check. But pnp_register_driver() can return error in some case
(e.q. kzalloc() error in bus_add_driver() etc.).

Add return value check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 2c89e159cd2f ("Staging: comedi: add c6xdigio driver")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/comedi/drivers/c6xdigio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/c6xdigio.c b/drivers/comedi/drivers/c6xdigio.c
index 14b90d1c64dc..3f507f53518d 100644
--- a/drivers/comedi/drivers/c6xdigio.c
+++ b/drivers/comedi/drivers/c6xdigio.c
@@ -250,7 +250,9 @@ static int c6xdigio_attach(struct comedi_device *dev,
 		return ret;
 
 	/*  Make sure that PnP ports get activated */
-	pnp_register_driver(&c6xdigio_pnp_driver);
+	ret = pnp_register_driver(&c6xdigio_pnp_driver);
+	if (ret)
+		return ret;
 
 	s = &dev->subdevices[0];
 	/* pwm output subdevice */
-- 
2.30.2


