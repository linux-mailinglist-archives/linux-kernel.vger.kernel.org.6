Return-Path: <linux-kernel+bounces-190497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEAC8CFF41
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8721F22B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E2F15DBB5;
	Mon, 27 May 2024 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UovBtMHy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4816F1581E2
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810472; cv=none; b=CFL6HkCbX9k6oA41wa6JQZ3pA1JdRpXNRZcOiDL0BKvhdubKIF7jbxGTCGjQznLZDkgaEQCuoiwY+boXOIMx0YA6xxfqZ0/dSqCMkBBtWlp/YgKHgh51s/9LMSYNi1hufahJi6ayf+vSk9FDxfYbXiWhSz/l9lUiS4CJbxNbZ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810472; c=relaxed/simple;
	bh=sRmVMUWEsGd3JiARjxDS9+4xUJi2FEDCmK4BeqEOf/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iv23Xk577dHRNXOP8nGyXsDJz8A9IzNdC3kxOPwliu9SzHnn/tYpJnIjkocf/aDxGzWc0uO7ZwXoiIP0Y2PFPcnVCTVn0Cfm9kapiU76UPgXGyyGiF6Pxfjm/FoTLi8eg3aRXjb2eJhaF9pyeAJSzZ8tE+692wrPeBlMNeUCk2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UovBtMHy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716810470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HdRZ8PJH5vkD9TGX7r4B8NiG3gmtbnkvy1NOwKAXBr8=;
	b=UovBtMHyhkD4qHSrmmzu9jYSvkiI5gNlLBJnCvfYS7vpgpqGVOBv9wLJY+sipTBE22yr7C
	5TX1xlXdnrApBh7/mjkw5LDcCb5g6Gl4J/CLY3w7F2fbAx8IsIQGpDz3ZP4ki2n27InBtK
	+HE5OW2n1oFwMC6//cCvbwEbzYsrnmM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-rO7QlqMwOFWkDCJDZuiSoA-1; Mon,
 27 May 2024 07:47:45 -0400
X-MC-Unique: rO7QlqMwOFWkDCJDZuiSoA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6834629AA39D;
	Mon, 27 May 2024 11:47:45 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.78])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 79B6E200A610;
	Mon, 27 May 2024 11:47:44 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee.jones@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jani Nikula <jani.nikula@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mfd: intel_soc_pmic_crc: Use PWM_LOOKUP_WITH_MODULE() for the PWM lookup
Date: Mon, 27 May 2024 13:47:43 +0200
Message-ID: <20240527114743.326482-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

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
pwm_get() as needed allowing the pwm-crc driver to be safely built as
module.

This has been successfully tested on an Asus T100TAM with pwm-crc
build as a module.

Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/11081
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Some small commit message tweaks
- Add Andy's Reviewed-by
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


