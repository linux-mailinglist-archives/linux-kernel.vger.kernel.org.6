Return-Path: <linux-kernel+bounces-208123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F61902113
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D6C286917
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F1D7E0E8;
	Mon, 10 Jun 2024 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="VH0U79Tt"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702B654278
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020860; cv=none; b=lvjl9Xtjw8H1dWnNc8dwr9IjPXZJ2mrDC4lRuIPPL7zKG3vxqf/GFI1crbB6jMJbePNGcQnNoToD31ryU2gzsKeIlsY2hK9BSPXSqk/oNO/x0doEO2gbot0gLGAc+92pONn9tYLcGJyHQ4z4E8BAXlzeSyEAA/Nn9s6i7X/EDBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020860; c=relaxed/simple;
	bh=/6vUsmpk7/TqfDzdEJtv3EbJoaVxWAY8JQp84ckw0jo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hY1kn3klLmR5GK9cDLGbJ3TxwWQvyUKdCaCKI8LgmrW54VwE4NFlNXQrgRtegzLIHpzOWNdMRwB1JJ7wPYCKbg9Ztx9xWETbQTIdLUb/Fiofy9NLRxOcePdZ4+7NxiohhAlKnlKKh9GjSrVOOh2xEj+ChKQQaisVuwyxcHFLmSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=VH0U79Tt; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 38638100013;
	Mon, 10 Jun 2024 15:00:56 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 38638100013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1718020856;
	bh=lUgcMPonW7fs8S5+j+e0kMT4WgrUym+0v+G5zwFl4yk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=VH0U79TtOl83X0lOWHSiVAHOUFCzzPe1toQmQf13IPdHWUE0r3EvRreKNfKVhn7ny
	 mcFQSzViIBVK4Uz823plcLeSbF4No9MHeB7exMADWSWriLprIj0GRDLFQUlCHmlabp
	 cbhCTZP9RCQienuai+RjTU3Tkz5+O1cv1524u05YEuVvNf7oi8wizYy5aGrYLs5RCZ
	 5zteaq/+6dI+WAW46+/rqJljNR4wcbWoZmVSZLJ0v2km0hTTbJ/oHJOICZcM/a1RWc
	 eQWq/9UndGmCfFkr6K3lZ7ZykUeD+XlBpe0ZEclGOCKmydfJH5pBdFZ/z0vJPDRVjK
	 GITsVhu5aU+bg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 10 Jun 2024 15:00:56 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 10 Jun 2024 15:00:55 +0300
From: George Stark <gnstark@salutedevices.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>
Subject: [PATCH 1/1] regulator: core: add warning for not-recoverable state
Date: Mon, 10 Jun 2024 15:00:25 +0300
Message-ID: <20240610120025.405062-2-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240610120025.405062-1-gnstark@salutedevices.com>
References: <20240610120025.405062-1-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185831 [Jun 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/06/10 11:09:00 #25535815
X-KSMG-AntiVirus-Status: Clean, skipped

If regulator is always-on or boot-on then it's expected to be on while
being probed so add warning if such a regulator is in not-recoverable
state during initialization.

Signed-off-by: George Stark <gnstark@salutedevices.com>
---
 drivers/regulator/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a968dabb48f5..133789eb3d71 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1251,6 +1251,10 @@ static int machine_constraints_voltage(struct regulator_dev *rdev,
 		int current_uV = regulator_get_voltage_rdev(rdev);

 		if (current_uV == -ENOTRECOVERABLE) {
+			if (rdev->constraints->always_on || rdev->constraints->boot_on)
+				rdev_warn(rdev,
+					  "boot-on / always-on regulator is in not-recoverable state\n");
+
 			/* This regulator can't be read and must be initialized */
 			rdev_info(rdev, "Setting %d-%duV\n",
 				  rdev->constraints->min_uV,
--
2.25.1


