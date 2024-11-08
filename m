Return-Path: <linux-kernel+bounces-401842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25059C200E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 071A9B21195
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75731F6660;
	Fri,  8 Nov 2024 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z/FABgFZ"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B9A1F4726;
	Fri,  8 Nov 2024 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078541; cv=none; b=cmF538fONxVMXpj5h3LbEiFkLZmYF6ixD8ri9e9mc4DFWPpLXWEvtCSCt8RgqEb0039h1ikHNgYL3eVxS5tddItjsOPSs1eEVXOHkzf+sn7+JH9MGvjAaDyEUFrE1OEJwDKZLu1e8Xzh7mETJErgMig2fhHBM+miaZJW3SLYAQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078541; c=relaxed/simple;
	bh=bggjSsff92I5nfqkHZKLXAtnYfyMCNcWpoDAFa1s/UY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=koMxLBoRtIS1uKdmoBMqDXqawdJo4XKsui4BQ5qGOBdYeSd7PPWxqy70z5eq2RmfoJhYKktBUaqF2Zla3OCDNwSF4KqzlqKLfYn5L3pRrPxuslsitLDJrLDp1wbA8B/P0oU5u0ffwLde8ZdTX61XUhkA6icwYT1FJd2IFooIeJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z/FABgFZ; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0973A2000B;
	Fri,  8 Nov 2024 15:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731078537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PWKzQLDi1P0e2NgDvgc4yHfOyzr35Ho5+wgbJLaL+w0=;
	b=Z/FABgFZGrlMG/98Zq26AlQlzIBBVIq/2EdpcVu7g3AORxbadgcf3MkMhgpsBH58FjO+az
	qXGzFF3XZdplVjzQsDrhA21rQvTnVJ5OXOLiMAwnm+6T6qNJbwVkEs4/NNL02SmAO2JreM
	u1VNLpQLaKjHqCjCaXQaDiQHbuoAzxBqVujy4Ld/+hiPpGT56Xgs2iMHFhgWZgVtY1kW76
	AH2BDPYsC7BgVHR5kJX0RArGSC9JH6hlPfI5ln2kofMCQ2+yE5pV/8CJTx1ZQ6pfwpeutb
	ulPqKQMibef/yQelK7yv3BQD4co4+eZKmoluZ+cRbYHsUgX0jtz8XkW9XWwnRA==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Fri, 08 Nov 2024 16:08:52 +0100
Subject: [PATCH v2 2/2] mfd: cgbc: add a hwmon cell
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-congatec-board-controller-hwmon-v2-2-16e337398527@bootlin.com>
References: <20241108-congatec-board-controller-hwmon-v2-0-16e337398527@bootlin.com>
In-Reply-To: <20241108-congatec-board-controller-hwmon-v2-0-16e337398527@bootlin.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, blake.vermeer@keysight.com, 
 Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: thomas.richard@bootlin.com

The Board Controller has some internal sensors.
Add a hwmon cell for the cgbc-hwmon driver which adds support for
temperature, voltage, current and fan sensors.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/mfd/cgbc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
index 93004a6b29c1..7cc2872235ac 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -236,6 +236,7 @@ static struct mfd_cell cgbc_devs[] = {
 	{ .name = "cgbc-gpio"	},
 	{ .name = "cgbc-i2c", .id = 1 },
 	{ .name = "cgbc-i2c", .id = 2 },
+	{ .name = "cgbc-hwmon"	},
 };
 
 static int cgbc_map(struct cgbc_device_data *cgbc)

-- 
2.39.5


