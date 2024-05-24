Return-Path: <linux-kernel+bounces-188311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B55658CE062
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 06:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F361C20F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 04:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168A5383AE;
	Fri, 24 May 2024 04:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="MWOMhoam"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A7B36D
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 04:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716525504; cv=none; b=hO1sgkK+WAcCzJXVFUed6xoF/12skliNwxdXVLJKEg1YAZqVkOaA0VV23qf38fazxPoSTp9ekkhyn74y4mBJ6MQZ22pOsjojblSxS11ngZ7k+wEDtZ+OEkXCPGuLgJJTtPVcakfv26P2oaRcRU28zdaI0Vp5COUxDp8fq/+QnQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716525504; c=relaxed/simple;
	bh=8asbgzuqi2IPHz+nIBJ+jEPSi1W2RJZnqVIMDtB6pzo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HchIsZ+H+shlqlB+6ZhuR6j1HqJH9e3VIKRcjbYTz1i5fJk5UYIhvGMMLtUNb5yBknCvYCKFQ7eYrpkAiJJ+6QP0Pbe892HaswE6MdU7zaASR8oN3msv3EN+bs5V6WJ0hKdUfQUcz+sLQLwlsPkus+HqKAoT44BwOt0PQInE/VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=MWOMhoam; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id EA4F9240101
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 06:38:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1716525493; bh=8asbgzuqi2IPHz+nIBJ+jEPSi1W2RJZnqVIMDtB6pzo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:From;
	b=MWOMhoamHbB/kQzxQ7ZLK8BAR2l0++YWr0/D8yL7hdyiXAE/hdFgpov7uZeUWHV+8
	 VTSD6pxx1BKxjEKRK5m2F95IzPplUuWyQUv7Li59dt98fuc+MSuERs+FjQtAklFHe2
	 rqaTR+doaLhwzxo9guRaI0oh9RrS3zf6i6Tohkj46qUF3LIssy26FQV2qhnF63F0VT
	 +n3fYjIQyrNvaQ5fgvLUaCnOdzeRZdMPzkoCyQXzYOwX6wSAPJI+/4C5aq8HpltAgL
	 BheWosCO9QsX5yBkELutjAErEz+3wPvdo4VyUgGhG/MR7W/7BR45QTbYtxT9lkjRrG
	 P8NQ1Ry0oZ37w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Vlsjc4XQ7z9rxF;
	Fri, 24 May 2024 06:38:12 +0200 (CEST)
Date: Fri, 24 May 2024 04:38:11 +0000
From: Wilken Gottwalt <wilken.gottwalt@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: corsair-psu: add USB id of HX1200i Series 2023 psu
Message-ID: <ZlAZs4u0dU7JxtDf@monster.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add the usb id of the HX1200i Series 2023. Update the documentation
accordingly. Also fix the version comments, there are no Series 2022
products. That are legacy or first version products going back many
many years.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
 Documentation/hwmon/corsair-psu.rst | 6 +++---
 drivers/hwmon/corsair-psu.c         | 7 ++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
index 16db34d464dd..7ed794087f84 100644
--- a/Documentation/hwmon/corsair-psu.rst
+++ b/Documentation/hwmon/corsair-psu.rst
@@ -15,11 +15,11 @@ Supported devices:
 
   Corsair HX850i
 
-  Corsair HX1000i (Series 2022 and 2023)
+  Corsair HX1000i (Legacy and Series 2023)
 
-  Corsair HX1200i
+  Corsair HX1200i (Legacy and Series 2023)
 
-  Corsair HX1500i (Series 2022 and 2023)
+  Corsair HX1500i (Legacy and Series 2023)
 
   Corsair RM550i
 
diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
index 2c7c92272fe3..f8f22b8a67cd 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -875,15 +875,16 @@ static const struct hid_device_id corsairpsu_idtable[] = {
 	{ HID_USB_DEVICE(0x1b1c, 0x1c04) }, /* Corsair HX650i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c05) }, /* Corsair HX750i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c06) }, /* Corsair HX850i */
-	{ HID_USB_DEVICE(0x1b1c, 0x1c07) }, /* Corsair HX1000i Series 2022 */
-	{ HID_USB_DEVICE(0x1b1c, 0x1c08) }, /* Corsair HX1200i */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c07) }, /* Corsair HX1000i Legacy */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c08) }, /* Corsair HX1200i Legacy */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c09) }, /* Corsair RM550i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c0a) }, /* Corsair RM650i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c0b) }, /* Corsair RM750i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c0c) }, /* Corsair RM850i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c0d) }, /* Corsair RM1000i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c1e) }, /* Corsair HX1000i Series 2023 */
-	{ HID_USB_DEVICE(0x1b1c, 0x1c1f) }, /* Corsair HX1500i Series 2022 and 2023 */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c1f) }, /* Corsair HX1500i Legacy and Series 2023 */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c23) }, /* Corsair HX1200i Series 2023 */
 	{ },
 };
 MODULE_DEVICE_TABLE(hid, corsairpsu_idtable);
-- 
2.45.1


