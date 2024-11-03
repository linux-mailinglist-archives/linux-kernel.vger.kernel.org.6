Return-Path: <linux-kernel+bounces-393750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4689BA4AC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 09:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F063B217D1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D6E155392;
	Sun,  3 Nov 2024 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="CoaJrp3G"
Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch [185.70.40.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C938C13B5AE
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730622883; cv=none; b=a2xXk2nEO97dA0T7Tg56txwvPfwvTeUOgtWfgzYMsi4BZYu8XlMwIZ9AuRWEoWYXdBtKKB56Qk5SHT2B6OczIm/5Noqou5DqgpvcRBvVWjF0cOm8tpsvg6xfVYaR//3xfTwKhBmc5D7pHGjGo9FNVGbVPAUFPBf3suivr41SHGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730622883; c=relaxed/simple;
	bh=E5Ap82zgZMoj2TE1EVIHA3m2JDIY4KIBBBTbj5A3hM0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hRrhvk8FqOjWu4EIflBKpGPyHDSpdI4uaFDCV5NeqgUAlJq5bAmtfUgEqe4LkxMIe5A7U+IcuhncpvX4o0DJdYMLxhOqGPhrH4l11o922PJ8J6fbgsK+a9i06lP/dDq8Q1fmTBkZpTh41q/W03GP1IrIf/08obI4jk5jbYmfPso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=CoaJrp3G; arc=none smtp.client-ip=185.70.40.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1730622872; x=1730882072;
	bh=E5Ap82zgZMoj2TE1EVIHA3m2JDIY4KIBBBTbj5A3hM0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=CoaJrp3GlhtD/AgwoWQmad1P3snMIdobSPDg1dzr4O0HIVN8e8h5c/ZtYCkkM1BFZ
	 iZJNP8CmFqkbCtldEgzgwjv/JvuabFZB3Z4UyxDU6TVNIXEWjAEN1ucpNr8QJINMXL
	 P9j4Sj8I2cscGwOjKir7A4Z5JhcM+1nSWkUyJ0XKSjPIAiU9ZmZCcFM8y1u8BYp35Z
	 QAdVu8IOtd1TdlA9/6nCoRyFU0nHSBjQTZnKnF20OvSPQJvUL3G7Z+tFbyB9I4e+LJ
	 24ljpBbhcsG+aHFsDexsx83dshO14pZP1cEoBOD8jbAta8iZEwGlHPQLOsTdV6ydxl
	 1vY89mEXZ92lw==
Date: Sun, 03 Nov 2024 08:34:27 +0000
To: linux-kernel@vger.kernel.org
From: Raymond Hackley <raymondhackley@protonmail.com>
Cc: pavel@ucw.cz, lee@kernel.org, krzysztof.kozlowski@linaro.org, duje.mihanovic@skole.hr, daniel.thompson@linaro.org, linus.walleij@linaro.org, u.kleine-koenig@baylibre.com
Subject: [PATCH] leds: ktd2692: Set missing timing
Message-ID: <20241103083416.49629-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
X-Pm-Message-ID: 29c9930043f16417e53cfd82485177b223b4d69d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

props.timing is not set after b5a8c50e5c18. Set it with ktd2692_timing.

Fixes: b5a8c50e5c18 ("leds: ktd2692: Convert to use ExpressWire library")
Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
---
 drivers/leds/flash/leds-ktd2692.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/flash/leds-ktd2692.c b/drivers/leds/flash/leds-kt=
d2692.c
index 7bb0aa2753e3..0a8632b0da30 100644
--- a/drivers/leds/flash/leds-ktd2692.c
+++ b/drivers/leds/flash/leds-ktd2692.c
@@ -293,6 +293,7 @@ static int ktd2692_probe(struct platform_device *pdev)
=20
 =09fled_cdev =3D &led->fled_cdev;
 =09led_cdev =3D &fled_cdev->led_cdev;
+=09led->props.timing =3D ktd2692_timing;
=20
 =09ret =3D ktd2692_parse_dt(led, &pdev->dev, &led_cfg);
 =09if (ret)
--=20
2.39.5



