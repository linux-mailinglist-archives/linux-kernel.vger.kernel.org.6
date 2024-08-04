Return-Path: <linux-kernel+bounces-273863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B130946EF4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C461C20993
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E973987B;
	Sun,  4 Aug 2024 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="V7ObOGz+"
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD2324B29
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722777072; cv=none; b=em4zC5nrMa4Kw7EQCIzvLhkarh8M+e1wTrwwqgS5wRtJefyCMcIJlcl6u7v0+LEcXvB0RmHkWZHFe7fFsBTgvRYwpddBPrLxOnXWMmMYy1LtAeQj7lnhLyvrkKRtKQSr1RN6q7eGeB3ozO2gpbmvwcCt2jw2n67PbRmNcIKMRUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722777072; c=relaxed/simple;
	bh=d3S2S0C9KEIh3WM04ZpBoyQkWx9f3ZvcnogNTzASYlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WE0WBsB5IkPghaXGUZW2eR4lEcogj1pn9Sd7yw5SBvGc2oFwFP+dN7TWelC3KULLVbjPewQxS7gNxtm05s4CiahGDbjcAINBU1xQFwbWgX2Xb9zWBISyP/VBUzRsxggQMFUjMxmWTflUptdGTfvRgCbtQmaxuRu1kZd+3dk5nRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=V7ObOGz+; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 44F3CDFA1DCB3;
	Sun,  4 Aug 2024 16:10:53 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 0eud0SZ1XvJs; Sun,  4 Aug 2024 16:10:53 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 1692ADFA1DD29;
	Sun,  4 Aug 2024 16:10:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 1692ADFA1DD29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1722777053;
	bh=+M572IgoRhMvQh82LcQnI9Tv8ahflEZGNEiMSsU0WbM=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=V7ObOGz+lMhXAEd2aObUSYkB1oHkUQRU004pQiWmnztuWdwC7Lue/BwC4TT5C0/4/
	 NZletP9S6fXilWvR93oc/yreS0KAoFJW9NLR+Z3MwYWwhLPmgjlOS0xYV3zLSVxh8P
	 cECWKyo13qxEgFUsXqNpbWosGnWofO98BziIPmu2+OhkDTHli6+5pqdso/zHqcgJBK
	 Z6+w/FnUDZiKv0GVvQyWBytfwck5ZnBn4zixYDL/Jp5JSDJHQE1WciuFdC19CJiYEd
	 z/nH7capiWdsjP08iVFvMUB8pq7+8rrDkSrl4ln60aJu2HBCtd9XnJrIqEcyrNdDGX
	 Y0VbP7mLySWGg==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bnamjc5YUQIE; Sun,  4 Aug 2024 16:10:53 +0300 (MSK)
Received: from localhost.localdomain (unknown [89.169.48.235])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id CB21BDFA1DCB3;
	Sun,  4 Aug 2024 16:10:52 +0300 (MSK)
From: Mikhail Lobanov <m.lobanov@rosalinux.ru>
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Mikhail Lobanov <m.lobanov@rosalinux.ru>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] extcon: checking the function return code
Date: Sun,  4 Aug 2024 09:08:50 -0400
Message-ID: <20240804130916.37153-1-m.lobanov@rosalinux.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds error handling for the return value of the max77693_muic_=
set_path function within
the max77693_muic_probe function. The return value is checked to ensure t=
hat any error returned by
max77693_muic_set_path is properly handled. If the function call fails, a=
n error message is logged=20
and the probe function returns the error code.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 2b75799f5ae9 ("extcon: max77693: Set default uart/usb path by usin=
g platform data")
Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
---
 drivers/extcon/extcon-max77693.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max=
77693.c
index 2c567e0b7b7f..6a2fec47f2f1 100644
--- a/drivers/extcon/extcon-max77693.c
+++ b/drivers/extcon/extcon-max77693.c
@@ -1228,9 +1228,13 @@ static int max77693_muic_probe(struct platform_dev=
ice *pdev)
 	cable_type =3D max77693_muic_get_cable_type(info,
 					   MAX77693_CABLE_GROUP_ADC, &attached);
 	if (attached && (cable_type =3D=3D MAX77693_MUIC_ADC_FACTORY_MODE_UART_=
ON ||
-			 cable_type =3D=3D MAX77693_MUIC_ADC_FACTORY_MODE_UART_OFF))
-		max77693_muic_set_path(info, info->path_uart, true);
-
+			 cable_type =3D=3D MAX77693_MUIC_ADC_FACTORY_MODE_UART_OFF)) {
+		ret =3D max77693_muic_set_path(info, info->path_uart, true);
+                if (ret < 0) {
+			dev_err(&pdev->dev, "failed to set path for UART: %d\n", ret);
+			return ret;
+                }
+        }
 	/* Check revision number of MUIC device*/
 	ret =3D regmap_read(info->max77693->regmap_muic,
 			MAX77693_MUIC_REG_ID, &id);
--=20
2.43.0


