Return-Path: <linux-kernel+bounces-331330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD8E97AB62
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B0D1F22ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 06:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B9B60DCF;
	Tue, 17 Sep 2024 06:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="TgJLmBVq"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0562EAEA
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 06:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726554290; cv=none; b=CL1dyf/c85R90CkW8uJ/eRtMdFE6reBkb+07eXSc4+EApz+34Y3ipkmzwAXOZ5efELmyzetqg/RpKWEPIGC/mCA8zu8TttvFVeAIGKZRa0tIB0m4cw6Uu4vYSwIIDqdoZZxSPr/YRAfNIu8cZZbaAGrG7BD7LAK1V0TQovarego=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726554290; c=relaxed/simple;
	bh=mlDLqVNyCvZ/vFOKfM7nRSeSFkRvEEJotPsaO1/6w/M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u8PIHJoEDCqccekBAJ+g0dVC/Tmu645b51mI+XdZaqSn7wldTRlVtHuy0ZXe6xJTY6+FWk8yZTH3BnCsDBBfsL/uzcaR2W93Z40OMK5cUlezjUKKe1g/iI4EtDHshF4l8RDWCXsvBOFtRj2ZrOyWmSuk4Osgx10HAv74MYRn130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=TgJLmBVq; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id A407E100003;
	Tue, 17 Sep 2024 09:24:20 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1726554260; bh=2umEi2JxmwKzV7yDqu9QlyjgI+BGHxSiEgIHomw3HFI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=TgJLmBVq1vCdopKecQbLy4IWocujNAKRY3fj0QL5SGxAO4RaTSy3D2WTqDmup2vxO
	 oCzFFCiJlW+ZZAgkpIPP0Mq8jxJwne9Ryo0g0FiHTGq31e2fJ844K9LF/LAbq0zvW0
	 3zkRf+hODweAqWvmODJq/35mhbSe/x1yyKGihhLFzUvLEF5fktJ6TgQr5r+o0BEi4d
	 zmC3bo96SCY6ERIJ8SpvvSaTfOM/bWDFiIZ4XCHNpnd/xyIps4E86KI9yq3yNR0QrO
	 5yHimoXVn5Stj9Hf/IW0L++AjTyg1LrSl7mTXApZbn890L5QtNSsn3c/TnQHKdCXle
	 yCmJGyuDuNe7w==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue, 17 Sep 2024 09:23:52 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Sep
 2024 09:23:32 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: H Hartley Sweeten <hsweeten@visionengravers.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] staging: comedi: ni_tio: Adjust clock period calculation in ni_tio_set_clock_src()
Date: Tue, 17 Sep 2024 09:23:17 +0300
Message-ID: <20240917062317.13516-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 187783 [Sep 17 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1;mx1.t-argos.ru.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/17 01:07:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/09/17 03:42:00 #26600672
X-KSMG-AntiVirus-Status: Clean, skipped

In ni_tio_set_clock_src() clock period is a subject to overflow because
'period_ns' (which comes from user, may have any value and is not
validated anywhere) is not cast to a larger data type before performing
arithmetic.

Cast 'period_ns' to u64 to prevent overflow.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 3e90b1c7ebe9 ("staging: comedi: ni_tio: tidy up ni_tio_set_clock_src() and helpers")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/comedi/drivers/ni_tio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/ni_tio.c b/drivers/comedi/drivers/ni_tio.c
index da6826d77e60..98b5b44416cf 100644
--- a/drivers/comedi/drivers/ni_tio.c
+++ b/drivers/comedi/drivers/ni_tio.c
@@ -800,7 +800,7 @@ static int ni_tio_set_clock_src(struct ni_gpct *counter,
 				GI_PRESCALE_X2(counter_dev->variant) |
 				GI_PRESCALE_X8(counter_dev->variant), bits);
 	}
-	counter->clock_period_ps = period_ns * 1000;
+	counter->clock_period_ps = (u64)period_ns * 1000;
 	ni_tio_set_sync_mode(counter);
 	return 0;
 }
-- 
2.30.2


