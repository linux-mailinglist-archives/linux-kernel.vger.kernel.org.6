Return-Path: <linux-kernel+bounces-332345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA78597B89E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948581F22F31
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 07:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC1B15B57F;
	Wed, 18 Sep 2024 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="TPu67KD9"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02C1273DC
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 07:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726645083; cv=none; b=cGgnVId3ekU+SLCrhiyb7/ZYvLxyZD5mgXbNHq6/z7gXts0Flgpe5g4MiK09KZ6W95kmn2ak+sKsb/tVh7+JDG7LpaiGiOWxQQAdyk4oZRPSSHrjr7wkAsnpaZ+hZ4UT6fLzkP1tVfbGQNxtzLKjGkJukWfaksBs/+XrH9LTSpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726645083; c=relaxed/simple;
	bh=qPm+rFl/FP+L5F6hYohFFICPu/cj8U/1S6QadsdIgX8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpMUo8sJmaheGRBU4WuWexYqeUrhRb5QCRzrb3492jhsiF2xd+gvnVDGEkmvMhaNH7VbPZGqYxKmRgEfAso65WE/2Wx4/PoIy8+nI6U/ipw5xwPdV/nQ4ntkDSh6LrB6KGPsSjL2PwkFR40s/q9B+xdESIBoKBLUw60khfeG7CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=TPu67KD9; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id AF544100002;
	Wed, 18 Sep 2024 10:37:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1726645052; bh=Am0GqfIy7aLA25+RQYp9gbDE2Gt2aMR5SYKzTiCdjN4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=TPu67KD9kAAzzd5YLdaj2F2oah2P5l+XfA0WkNvlVjYsKfMFCxlBLgw2cwF4PtENI
	 dvBOjhJEKJ6/qZMKebI2RB9jqZ78cBMhP/eg14bE2RiLdVkfPYbE9bsCftfTTQAoze
	 eOBk20bfE6YSQG+W5Usxm6krgROaJevmhoar/+zj89iL43qOX6DRaxLm77Es3HOaHu
	 E8XJwplkn5uL/PEHGXxOCrtpF51nKJPCQxqjUo0xQY+f8YR2SGsxdvmT7oE7Z8568L
	 z5Uxj17TWPN1HrQrGf5BjfhNxhnKHzKb2aKs0qq4zYFVCa+tpVZ9RRHM2B0vpBVASG
	 zg1TG3HwvNpkQ==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Wed, 18 Sep 2024 10:36:54 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 18 Sep
 2024 10:36:34 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: H Hartley Sweeten <hsweeten@visionengravers.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2] comedi: ni_tio: Adjust clock period calculation in ni_tio_set_clock_src()
Date: Wed, 18 Sep 2024 10:36:02 +0300
Message-ID: <20240918073602.10152-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240917062317.13516-1-amishin@t-argos.ru>
References: 
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
X-KSMG-AntiSpam-Lua-Profiles: 187815 [Sep 18 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;t-argos.ru:7.1.1;mx1.t-argos.ru.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/18 06:55:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/09/18 06:30:00 #26614577
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
v1->v2: Remove "staging:" from the title,
 add "Reviewed-by: Ian Abbott <abbotti@mev.co.uk>"
 (https://lore.kernel.org/all/5c3172d8-517f-4d23-a713-fc41406c00d8@mev.co.uk/)

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


