Return-Path: <linux-kernel+bounces-187819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA4D8CD8F9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2BC81F2321F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845CD6EB74;
	Thu, 23 May 2024 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXZs3O21"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A608AD2C
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716484074; cv=none; b=pv+AYxYQnMH9ASjJU55SO43OdRg6n09rJsg3LQoOnEBwo7eerl00pDE+6Ihc7Bo12g/sVxsPucpPlIXJ7xJV5+89yamzedk/+qZwTyhffGAsfazw2AzTIhFfhZ3nyeOitguq7EkU6q3OogSC5hffiN8mAucsuKub+c1ecRCraoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716484074; c=relaxed/simple;
	bh=LgdFMV3pwxfUlloQIhIUMD+jd5nlRZUYHb2VjgHE3PU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X2DCCn5f9Ac2Lt0Unt3iCK+x9KZp/+zHZ+TVIItJanPJpH747zcr8y/fIi0SfUIKudSzr95HdmYuO1Fyj69ntlgd2eqCrF3xWP1WPfuXeK5ySeEG+6xthJd1fI1xY/NxpGXHsBBBtXk5kFa39aC7u5xFXQ60qKfUAm3VBJR4ZJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GXZs3O21; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716484071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pNKN9QPxUfTkYzMYoD5TJ5z2UvASg+iEgjNAxXTL0Ss=;
	b=GXZs3O216pPAMNbEq5fbJrIBPxOa0/wMZ54fVcuSLy+35llskZOKdVOQZOhddHBj1HkDLc
	gFG4T10/FlCTHVceDckaPoNsweHM5L7lYM0bQCEQfCQ4FyQf+XWgNVwD4sdsP6l3GH0N9v
	RuRVSHhxwJO1kCV2ISRk13+6AhwMsWE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-V7-Bz9f5O2SBRyKb_L7eyA-1; Thu,
 23 May 2024 13:07:46 -0400
X-MC-Unique: V7-Bz9f5O2SBRyKb_L7eyA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A1103803909;
	Thu, 23 May 2024 17:07:46 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.88])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C6111C15BF3;
	Thu, 23 May 2024 17:07:45 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jani Nikula <jani.nikula@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: intel_soc_pmic_crc: Use PWM_LOOKUP_WITH_MODULE() for the PWM lookup
Date: Thu, 23 May 2024 19:07:45 +0200
Message-ID: <20240523170745.92166-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

The primary use of the CRC PMIC's PWM is for LCD panel backlight
control by the i915 driver.

Due to its complexity the probe() function of the i915 driver does not
support -EPROBE_DEFER handling. So far the pwm-crc driver must be built
into the kernel to ensure that the pwm_get() done by the i915 driver
succeeds at once (rather then returning -EPROBE_DEFER).

But the PWM core can load the module from pwm_get() if a module-name is
provided in the pwm_lookup associated with the consumer device.

Switch to using PWM_LOOKUP_WITH_MODULE() for the lookup added for
the Intel integrated GPU, so that the PWM core can load the module from
pwm_get() as needed allowing the pwm-crc driver to be safely build as
module.

This has been successfully tested on an Asus T100TAM with pwm-crc
build as module.

Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/11081
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/intel_soc_pmic_crc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index 581f81cbaa24..876d017f74fe 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -137,7 +137,9 @@ static const struct regmap_irq_chip crystal_cove_irq_chip = {
 
 /* PWM consumed by the Intel GFX */
 static struct pwm_lookup crc_pwm_lookup[] = {
-	PWM_LOOKUP("crystal_cove_pwm", 0, "0000:00:02.0", "pwm_pmic_backlight", 0, PWM_POLARITY_NORMAL),
+	PWM_LOOKUP_WITH_MODULE("crystal_cove_pwm", 0, "0000:00:02.0",
+			       "pwm_pmic_backlight", 0, PWM_POLARITY_NORMAL,
+			       "pwm-crc"),
 };
 
 struct crystal_cove_config {
-- 
2.45.1


