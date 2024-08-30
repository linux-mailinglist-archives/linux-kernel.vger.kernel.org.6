Return-Path: <linux-kernel+bounces-308150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A96919657DE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36F61B20EED
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914901531D9;
	Fri, 30 Aug 2024 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="DCNNiMtS"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFBF14D2B5;
	Fri, 30 Aug 2024 06:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725001000; cv=none; b=NNizduDw9fWS4QIoug0CcuE2SOEnZhlOgNujgjNhUryFkNSZma/GzWtHnsXWwi46d4VXTShIdV3pRdJ0xcASGTCwsTYW1MEEBOOFW3OR/wXekNYAVcoT77I9US8Ux5KcEyJ+xDAsMudyemU+OAg1XPj6+0zkrJvwegIs5DGafKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725001000; c=relaxed/simple;
	bh=I1v12oO8jAdq+XSah46MrvbcNgo16FjjVPUQehwdTL8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSQoCncYBWai4/HCU0et209WCpjlX/6sIyutSqLQ+Lgbo5NhCROEZPed7zIn4B1l9ZH9KILt+llc3FW5MRccf6XKwKGRbaPgYnFxqho9UdOJCvIp6dk83MFzscOwQr3ins6MQtmsXLeFgDYB3HcvPhlJNe+R1l9/PedneAZ3zYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=DCNNiMtS; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 35632100002;
	Fri, 30 Aug 2024 09:56:10 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1725000970; bh=HsBMCWugpsXJfa3UUQxtCjkXUM+sOQcgRdRG1BDdCSU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=DCNNiMtSHbu0cpQG6eJr96gOpz/qWCvA9+V49ZrTHHm7x2xKFnsSBSSSzRkjBIHx/
	 6URgQVqO8CnNn7L903dgG8OM1KwUJI7IDP1lYAqoYcwsdZKBzD/DDmkDPGtg+1QiV1
	 ebbSD9wKuR4akrYIh7ZXQSG8NybXRvfHrOh77uBwYfkHmR4yXWNB/Xr2Yck2Yp1Uid
	 Ano4ckgSGfxPmgK66b29TArCuqQh8EoodfgefXtccmA4akfDh9UIGVvVJlu6y4Q8qv
	 DaCB72PYbO0/34j6tTjZxlmUefNiMgaLhlr/y8/xL2PdR7oTYXJ8XGYDXm3yaUd5u1
	 Uhe+qcjlh4bPw==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Fri, 30 Aug 2024 09:55:06 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 09:54:46 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Mario Limonciello <mario.limonciello@dell.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Hans de Goede
	<hdegoede@redhat.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Lyndon Sanche <lsanche@lyndeno.ca>, Armin
 Wolf <W_Armin@gmx.de>, "Darren Hart (VMware)" <dvhart@infradead.org>, Edward
 O'Callaghan <quasisec@google.com>, <platform-driver-x86@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2] platform/x86: dell-smbios: Fix error path in dell_smbios_init()
Date: Fri, 30 Aug 2024 09:54:28 +0300
Message-ID: <20240830065428.9544-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240828121703.17470-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 187424 [Aug 30 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 27 0.3.27 71302da218a62dcd84ac43314e19b5cc6b38e0b6, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/08/30 05:11:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/08/30 05:02:00 #26476423
X-KSMG-AntiVirus-Status: Clean, skipped

In case of error in build_tokens_sysfs(), all the memory that has been
allocated is freed at end of this function. But then free_group() is
called which performs memory deallocation again.

Also, instead of free_group() call, there should be exit_dell_smbios_smm()
and exit_dell_smbios_wmi() calls, since there is initialization, but there
is no release of resources in case of an error.

Fix this issue by replacing free_group() call with exit_dell_smbios_wmi()
and exit_dell_smbios_smm().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 33b9ca1e53b4 ("platform/x86: dell-smbios: Add a sysfs interface for SMBIOS tokens")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
v2: Update comment message for a more detailed description of issues

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


