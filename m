Return-Path: <linux-kernel+bounces-332652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBF597BC9A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1021284EEA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290B9189F43;
	Wed, 18 Sep 2024 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="ANFSxVDq"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566CF4409
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726664100; cv=none; b=XvQR2GA/JXTrfRKEozja3bdI3U71dNU9IZ3tk6mIBbHLk40pNeBkTexJV2mTLxcK9JbMz6Gq5loJHmMxUbFzq39nAKMuoFg1HU5UH9/rYnxf9o70Cl33QGvOVkUkyVDBThxRWhtvJuxopEfAiuPT4/NtCLR2Lf2432IQWYlI02Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726664100; c=relaxed/simple;
	bh=CJsMjJ9SSNkNbyIg61aQirT+ILrP1pvI/J/vQSMGH4I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJNoisjfBM6HjAmh+EabtlTviYotm9v4cnbMtbBrLGetvLcUYHUasGYvVkmyu0STNq+ed/qS6T9jfQO3S+GYUzQK0ccQj2BX9UIkJjjDnAIkZqPY416qKDAZydzqC7xmopwCw22b+DDi7tjeCqpPHJHOPYDxzcVnzAsVbqfOEE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=ANFSxVDq; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 7688E100002;
	Wed, 18 Sep 2024 15:54:36 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1726664076; bh=pdEQXQtdtzWCKVddTR7BJOhY5ihU3J1r9dacg0zbWiI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ANFSxVDqIiXvw2EIMY0rui3fiAF7J3+MsijuYyhIGDrny/YVtYY6GFHtlxr1vVATp
	 2ZZr/pFX+otLL0wTwRIVeObxESJb0gH1dlyd7QyOWA6Vx2JL9YZOjBV67WA9X3L6/5
	 QheRUf/xD4k8oZvSaDg020mPYHN+kFBHzm5s2uJl7Gp+uNS/93dwyrV6YVi991qaeB
	 8WOCrntc45qs6TgaV3vXwD/ljSezEWgwAt0+WAUaUGuKse1SVPOFHhZEAZDS53FI7a
	 UvSZb9cs2I7DtqSva8bof7DSOCsgSS2f84znSt1plY6dBVhhMCdKlId4FRFFuVUJ1y
	 d8B5NAtpPDlCA==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Wed, 18 Sep 2024 15:54:08 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 18 Sep
 2024 15:53:48 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: H Hartley Sweeten <hsweeten@visionengravers.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2] comedi: adl_pci9111: Fix possible division by zero in pci9111_ai_do_cmd_test()
Date: Wed, 18 Sep 2024 15:53:38 +0300
Message-ID: <20240918125338.16660-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240918104304.15772-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 187822 [Sep 18 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/18 12:02:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/09/18 11:02:00 #26615694
X-KSMG-AntiVirus-Status: Clean, skipped

Division by zero is possible in pci9111_ai_do_cmd_test() in case of scan
begin trigger source is TRIG_TIMER and 'chanlist_len' is zero.

Add zero value check to prevent division by zero.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: f1c51faabc4d ("staging: comedi: adl_pci9111: tidy up (*do_cmdtest) Step 4")
Suggested-by: Ian Abbott <abbotti@mev.co.uk>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
v1->v2: Update comment and fix as suggested by Ian,
 add "Reviewed-by: Ian Abbott <abbotti@mev.co.uk>"
 (https://lore.kernel.org/all/4f46343a-a1f9-4082-8ef2-50cdb3d74f31@mev.co.uk/)

 drivers/comedi/drivers/adl_pci9111.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/adl_pci9111.c b/drivers/comedi/drivers/adl_pci9111.c
index 086d93f40cb9..e5989d180650 100644
--- a/drivers/comedi/drivers/adl_pci9111.c
+++ b/drivers/comedi/drivers/adl_pci9111.c
@@ -310,7 +310,7 @@ static int pci9111_ai_do_cmd_test(struct comedi_device *dev,
 	 * There's only one timer on this card, so the scan_begin timer
 	 * must be a multiple of chanlist_len*convert_arg
 	 */
-	if (cmd->scan_begin_src == TRIG_TIMER) {
+	if (cmd->scan_begin_src == TRIG_TIMER && cmd->chanlist_len) {
 		arg = cmd->chanlist_len * cmd->convert_arg;
 
 		if (arg < cmd->scan_begin_arg)
-- 
2.30.2


