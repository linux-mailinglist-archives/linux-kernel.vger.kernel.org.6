Return-Path: <linux-kernel+bounces-447844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1ED9F37C8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C88167E13
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02568206F1A;
	Mon, 16 Dec 2024 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="I0GgU6FW"
Received: from ksmg02.maxima.ru (ksmg02.maxima.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D38206281;
	Mon, 16 Dec 2024 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371207; cv=none; b=lKeuuicG/3UUHnPLd0QSHB40qXFK34uTNzlvREOp8zxTjySX12AGcPiiSeXi7V7fpyqpuUptnQSnPRuCy3LdRJI18rVvEtfUAyoKp3BKqiYHsOxxO9yKjzPWcpa/vFns1yYwhrcEnwnHG/3KQC4CrQ20tqxsj39mE2Rnzo6Fpsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371207; c=relaxed/simple;
	bh=n5GrITLofBs3MhLhgri3ma6FpHw1Y8YCh65bccUSHMY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k8P/ydNYDaWSs+nsUvNHs44luHb+miBi+DDFwqUUowMrAEXDQTPFk2s0XDgxsjWQFfRtnNIwLa8H7MuPl+CiXJJ9MygwPrMvpOtPFLFVyLyi66tvzIgy4bvHtCNaEhAQPPnSSszuUq0XkpN3y3+yhoQejUcrBS711gZqt2FMo/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=I0GgU6FW; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id 9F8151E0008;
	Mon, 16 Dec 2024 20:37:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru 9F8151E0008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1734370631; bh=hUoK+bZxSqL9gvfRrWQBdNzp2e5n4XUHkuDaF9wc7g4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=I0GgU6FWMuDTpk9OT/7cElU3ota7MmgWQNZzyppGHyEj4WOc8NVKjWOEg+fTR22pL
	 6zTAFatwZkepYyt4OeNsGcXBY17O9PuSwqAZS/+A/fSm4bKiAmDYXpnc2aqiE5rHTC
	 WDiWZ9obnwDenRfHrw2sL3+qZB5MCIIQtbumXaNLd8Wu09bbI354MitPwIwPc8s6Fn
	 g3vTEDyKBCmCM70/FZwvJ4hAz+JtWbYpHWopmKFRlwz5nDJ+TT/bY3VN1NOlmFhi4d
	 pIxqrRbkyFaugMZmPhfxtOO4K9EV1yA3iWVsYo1wy11EXFiC90PlOfTJxDOjiZaY3r
	 RRzglXXX8xJ4Q==
Received: from ksmg02.maxima.ru (mail.maxima.ru [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Mon, 16 Dec 2024 20:37:11 +0300 (MSK)
Received: from GS-NOTE-190.mt.ru (10.0.246.113) by mmail-p-exch02.mt.ru
 (81.200.124.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Mon, 16 Dec
 2024 20:37:08 +0300
From: Murad Masimov <m.masimov@maxima.ru>
To: Eric Tremblay <etremblay@distech-controls.com>
CC: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	<linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Murad Masimov <m.masimov@maxima.ru>
Subject: [PATCH 0/3] hwmon: (tmp513) Fix interpretation of values of TMP513 registers
Date: Mon, 16 Dec 2024 20:36:45 +0300
Message-ID: <20241216173648.526-1-m.masimov@maxima.ru>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch02.mt.ru
 (81.200.124.62)
X-KSMG-Rule-ID: 7
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189867 [Dec 16 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: m.masimov@mt-integration.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dmarc=none header.from=maxima.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 47 0.3.47 57010b355d009055a5b6c34e0385c69b21a4e07f, {rep_avail}, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, 81.200.124.62:7.1.2;mt-integration.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;ksmg02.maxima.ru:7.1.1;maxima.ru:7.1.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, FromAlignment: n, ApMailHostAddress: 81.200.124.62
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/12/16 14:34:00 #26899616
X-KSMG-AntiVirus-Status: Clean, skipped

The function tmp51x_get_value returns processed values of the TMP513 device
registers. Raw register values are converted to signed integer values by sign
extension in accordance with the algorithm provided in the specification, but
due to the off-by-one error in the sign bit index, the result is incorrect.
There are also some other mistakes, such as incorrect cast.

Changes introduced by these patches are based on the TMP512/TMP513 datasheets
that are specified in Documentation/hwmon/tmp513.rst. They have not actually
been tested in any real or virtual environment. However the calculations have
been tested separately to make sure they work as expected.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Murad Masimov (3):
  hwmon: (tmp513) Fix interpretation of values of Shunt Voltage and
    Limit Registers
  hwmon: (tmp513) Fix Current Register value interpretation
  hwmon: (tmp513) Fix interpretation of values of Temperature Result and
    Limit Registers

 drivers/hwmon/tmp513.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--
2.39.2


