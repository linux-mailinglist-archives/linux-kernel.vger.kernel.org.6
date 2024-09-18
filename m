Return-Path: <linux-kernel+bounces-332546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DE597BB0A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337CC1F21BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EBB17C9B8;
	Wed, 18 Sep 2024 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="n/sO5OvW"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD6E17A597
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726656272; cv=none; b=W1DKeEwczidy+c4ZEuVCMkVxbolsHNnd6LdWVENbm3LQkIIAZ6ticF2bIda2MoXczScNJSK9QRDeQ/yJ7A0PDqosJtlaHvP1I2nhBwhE1W1Bw2Z3yAviDE4P9wPVif5vAn7SO352nuKkV9MqHzMzPgOPm1Qcdhx4ur+Qpp55inQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726656272; c=relaxed/simple;
	bh=K+LQMJ7qJOU3k+VAzSN0VOR2Jr1VgiVwu4dJIhpclvE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vAMCatUPYMkmA0RziEbUjQ+uTjftS5CCxhdmIPuvBBXG1O4ljd3Ddu+PLvMlFqDlw3SIgPajEj+qwa0JLR6E+jZsywII/FEs2DPzLwyBRq0Tnc2cm+Aksfc15G0lXZVkKCSr5v4zbRFDYU/5wxbeCXrplter+hCDVsZus1RNE8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=n/sO5OvW; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 46A83100002;
	Wed, 18 Sep 2024 13:44:08 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1726656248; bh=uknRtrNx7YVrWwi+rWIEtfF6DVVkwQoskz2i90YW9nE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=n/sO5OvWKybsYechy+LXbR52YnULDWemhQ+/8NOvN/0PxK8GdFKlKvgnkVDXgLM4C
	 jhXyg4rv8kdwDoYIHk4X8EgOoElQQe8Z4knwL507I1+uQ03OCD+TcoB+4EqUkZrP5g
	 HHnDvHAGGBcqWLl3/u3RGNrk2Q+cl8V9W0wDLCtkmOtBh8Qdm7pUgobyO9kk0uedqr
	 Gdv7wOuOijb8zxjk3HpKFLSujUyaaZiya6N4/OazdKcdlnpVPYmMUZnVKLLvQ3LSNj
	 4CuR49Led+fUJ57PdncSJ6f0rawbXUp72AE/VbaqAVDuyFOFGbVZi1f0NLeXiDdN/s
	 jqOF+vI2qP0yA==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Wed, 18 Sep 2024 13:43:36 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 18 Sep
 2024 13:43:16 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: H Hartley Sweeten <hsweeten@visionengravers.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] comedi: adl_pci9111: Fix possible division by zero in pci9111_ai_do_cmd_test()
Date: Wed, 18 Sep 2024 13:43:04 +0300
Message-ID: <20240918104304.15772-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 187817 [Sep 18 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;127.0.0.199:7.1.2;t-argos.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/18 10:01:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/09/18 08:50:00 #26615196
X-KSMG-AntiVirus-Status: Clean, skipped

Division by zero is possible in pci9111_ai_do_cmd_test() in case of scan
begin trigger source is TRIG_TIMER and either 'chanlist_len' or
'convert_arg' is zero.

Add zero value check to prevent division by zero.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: f1c51faabc4d ("staging: comedi: adl_pci9111: tidy up (*do_cmdtest) Step 4")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/comedi/drivers/adl_pci9111.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/comedi/drivers/adl_pci9111.c b/drivers/comedi/drivers/adl_pci9111.c
index 086d93f40cb9..ec1fb570b98c 100644
--- a/drivers/comedi/drivers/adl_pci9111.c
+++ b/drivers/comedi/drivers/adl_pci9111.c
@@ -312,6 +312,8 @@ static int pci9111_ai_do_cmd_test(struct comedi_device *dev,
 	 */
 	if (cmd->scan_begin_src == TRIG_TIMER) {
 		arg = cmd->chanlist_len * cmd->convert_arg;
+		if (!arg)
+			return 4;
 
 		if (arg < cmd->scan_begin_arg)
 			arg *= (cmd->scan_begin_arg / arg);
-- 
2.30.2


