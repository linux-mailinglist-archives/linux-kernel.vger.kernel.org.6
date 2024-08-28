Return-Path: <linux-kernel+bounces-304924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847AF9626C7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2732819CB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B795176248;
	Wed, 28 Aug 2024 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="sXSQcyjz"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11261741D4;
	Wed, 28 Aug 2024 12:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847571; cv=none; b=Hw8090bsoUJsFP2/MDvRhWcWIN2dAEwVv237jjuMBDueYSQFbDPw85VhVn+4buep6sha1ocIyAG9dhkixk64QK0+9P0seHEcH00EViARHNAeoT5/AZ2SNvPlaBmBUOiF6QrktieYCRpDE6m4weRhOwtyv0Q0PCB2JrOsT/2SVvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847571; c=relaxed/simple;
	bh=CwnZBKC1X2wPCwkS69iD9fyMDU/12RPaSxdm03Jn/5c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=asie1HYcwIanZbj+rC6/NlCFFEWcruewEwCTl3OdP7fGMXYCgkYogW2SPtrVVc9RenV349545IvnlOB+UYp1yabW7PqCgb2yMgrUfz63ZDDMTMt2E+7dg517yEN7aeLQld6qiaMFDNcsmG3mFSJfYA8jJVYNGaHNZI0lfKw0+zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=sXSQcyjz; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id A8837100004;
	Wed, 28 Aug 2024 15:18:59 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1724847539; bh=DrRwpn2bq8z3vglnELLkrF9iN1QLgF7EJB/6RaLqD4U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=sXSQcyjzBibVHYaH/xsQSKNhs4HIe+d+PquPI+3gF1slhwg3wqLq1hyNWA0JAJmKc
	 0uV0zyIXL0/Tf8sBVaEwTZk4BsyxrLD3aTB1SXTH/9m5/8QaynPlkl9P/GJ0fca8+j
	 5Hdnm10aJoM4PCB0CtPyy0T5+VFZ0AMy2v54rVDs0ORfFB6BBobnW089bN+ecI6aBB
	 aaTM+wT/AVkusjDZOglFU/h9kf9Bl0Q1rgxbtMTCuVunbbFvmRiR8i1K5P0a/xTQd9
	 P28N6hdM2w2Wkrj1+VHUigFl8AZ+MAFM6bStP1dhnvYrdD2nJv55ieB6HJmFzQ8Ak7
	 btg1tdnwBIoCA==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Wed, 28 Aug 2024 15:17:56 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Aug
 2024 15:17:22 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Mario Limonciello <mario.limonciello@dell.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Hans de Goede
	<hdegoede@redhat.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Lyndon Sanche <lsanche@lyndeno.ca>, Armin
 Wolf <W_Armin@gmx.de>, "Darren Hart (VMware)" <dvhart@infradead.org>, Edward
 O'Callaghan <quasisec@google.com>, <platform-driver-x86@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] platform/x86: dell-smbios: Fix error path in dell_smbios_init()
Date: Wed, 28 Aug 2024 15:17:03 +0300
Message-ID: <20240828121703.17470-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 187386 [Aug 28 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 27 0.3.27 71302da218a62dcd84ac43314e19b5cc6b38e0b6, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/08/28 08:19:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/08/28 11:49:00 #26453044
X-KSMG-AntiVirus-Status: Clean, skipped

In case of error in build_tokens_sysfs(), all the memory that has been
allocated is freed at end of this function. But then free_group() is
called which performs memory deallocation again.

Fix this issue by replacing free_group() call with exit_dell_smbios_wmi()
and exit_dell_smbios_smm().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 33b9ca1e53b4 ("platform/x86: dell-smbios: Add a sysfs interface for SMBIOS tokens")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/platform/x86/dell/dell-smbios-base.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
index 6565fac24cde..73e41eb69cb5 100644
--- a/drivers/platform/x86/dell/dell-smbios-base.c
+++ b/drivers/platform/x86/dell/dell-smbios-base.c
@@ -622,7 +622,10 @@ static int __init dell_smbios_init(void)
 	return 0;
 
 fail_sysfs:
-	free_group(platform_device);
+	if (!wmi)
+		exit_dell_smbios_wmi();
+	if (!smm)
+		exit_dell_smbios_smm();
 
 fail_create_group:
 	platform_device_del(platform_device);
-- 
2.30.2


