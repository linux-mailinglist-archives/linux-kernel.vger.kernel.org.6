Return-Path: <linux-kernel+bounces-208124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEBF902114
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B63D28645C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1062F7F466;
	Mon, 10 Jun 2024 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="nD1aEVXk"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F5C77113
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020860; cv=none; b=OJ42J07kFYTChe9gp0zdJZA+FwRV9VeE+0cANu9wwKG/zHBBexq+lHJy9HX8n+MuVzRyqQq036CSoL9RJkSru6fwQDxjuGcpcrCGvuggmqpd98cixt0CmQVtlG/ptppEHUfCQyOt37nkobLFjrh482njjvz9xJFHi/LuwxpgPlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020860; c=relaxed/simple;
	bh=S87b0AoCg4zTupdBjkHp463O4Vqz7rMJKPouOx5ONS0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JPZwpLShdxhaH3hgqXxMcyq85D3ZU/0gL+lQQP7EtAWAhJddt0K41+5JrbT10pLJFKAqswcV4DSqkqaPhYTA0OupgWz9cJjYpg+5v+q0rm31QsDDwv+XeaQ3nCFFn9jGlSFoidNWlzQ52yGRN396MRC+i6JrofmHVnNwJFdXIIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=nD1aEVXk; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 06D6E120011;
	Mon, 10 Jun 2024 15:00:56 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 06D6E120011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1718020856;
	bh=hdDozi5lsGbUD6cyN4ZLmx54z1ydzCykUd3pd8uPLHM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=nD1aEVXkwLz16U2BYjwWe1b5PbwbDmmcOEiMFH1kpAEtTrpSB/azqpCEv1vM06Xbh
	 TxgKK+BgE0nac8Wvo6yKmnZJGN2sHDi9SHFld5HV+o2TsrHzs0whCIGEn6XDDs54Fp
	 Qvu5wUuFLDJ+fJ4slxOdCgNoV5GdCesh2HbW/ysHyKhaPdn1ZZOLEMycScJDIwBAYL
	 q5SBQJaPNb9OGpGlzj1UTEPzmVIiKZKnExgKd5oUXDvZuHfElGMjAz0ZuUJ5lsPCN2
	 IhD10D2NYUyQ/vKLFedIrVRLaYAus53BAIohwDDCtYo4NASVnx23Z4OLkiXQJ/IgB2
	 EYGFJMZ1TbtLA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 10 Jun 2024 15:00:55 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 10 Jun 2024 15:00:55 +0300
From: George Stark <gnstark@salutedevices.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>
Subject: [PATCH 0/1] pwm-regulator with voltage table problem
Date: Mon, 10 Jun 2024 15:00:24 +0300
Message-ID: <20240610120025.405062-1-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
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
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/06/10 11:09:00 #25535815
X-KSMG-AntiVirus-Status: Clean, skipped

Here is the situation we've met on an ARM SoC:

We have an ARM SoC with dedicated power input for CPU core and supports different
CPU clocks. CPU core power is supplied by external regulator, it's controlled by
PWM channel from the SoC. DTS has node for pwm-regulator with voltage table
(voltage table is used instead of range apparently to use only fine-tuned
duty-cycle values) and with boot-on and always-on properties. This regulator is
bound to cpu node. The pwm-regulator is inited at very early stage before bootloader
in vendor closed-source code.

When a pwm-regulator is probed in the kernel it gets pwm current state and search
voltage table by dutycycle to figure out the current voltage. If that search failed
then the regulator goes to notrecoverbale state and the core sets the minimal power
for the regulator.

The situation: bootloader sets mean cpu power and mean cpu clock.
but that cpu power is not found in the voltage table (value is between table items)
due to different versions of bootloader and kernel and the regulator core sets
the minimal power but cpu clock stays the same. CPU hangs somewhere during boot.

The core problem as I see it is if regulator is bound to CPU (or some other
complex consumer) it can't be changed except by the consumer at any stage. So
the regulator driver (core part) should wait for the own consumer to init
it properly but regulator can't be in unknown state after probing.

What you think? The least should be done is to report about the situation.

George Stark (1):
  regulator: core: add warning for not-recoverable state

 drivers/regulator/core.c | 4 ++++
 1 file changed, 4 insertions(+)

--
2.25.1


