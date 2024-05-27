Return-Path: <linux-kernel+bounces-190513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 040748CFF5B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3BF4285608
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EC915DBD8;
	Mon, 27 May 2024 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yte9w9Zj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D331B15D5CC
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810600; cv=none; b=j7rFTIjQH9GwTgQnWZB1uMekEXMutOTYPJjMhtM1UyTxwDz2rLkRVjV0KTQvhBjuNdFfeMHeXHJjBO3J3gW0xFyw4EYIk3JgnKZ6hK/fZk2NrrhrSj9AMBvDDp/HpWi0ZSXlvoUeWhLcX536MtavFXRNAk6IvSC63dMNCZlAMYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810600; c=relaxed/simple;
	bh=sRmVMUWEsGd3JiARjxDS9+4xUJi2FEDCmK4BeqEOf/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VGxLtnSxaa1kCo3q6aLAiLcQr/M2AsBoESK8bwl6VtUOOEmUWDomqb0WXZLepIyuQIzRQJy1OciwMHxqnNVncpE23P3/E9WgLD/Qzseihhpx/Vh7xwJibXJyl+w1j0BGD8HWbc53O9PBTg2leyGX7VEjMuyTN2hsuUpoWIPgZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yte9w9Zj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716810597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HdRZ8PJH5vkD9TGX7r4B8NiG3gmtbnkvy1NOwKAXBr8=;
	b=Yte9w9ZjMnqc922d1AtddtDloupnfpNArSgnFw7KnxyXFbGr5q4zvRUEGc6nsYlBpfMQd5
	njwKScQmgMWO1md9HxCLW86yLWt69dTl1o/qS+PPvw2STFiSNX+MEKjrr2mgErepxL0iPb
	rsqOvOxmZVovrg0sDVqbvN310KltEjE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-NF8o59KrPkyA8BluyXJZ7g-1; Mon,
 27 May 2024 07:49:52 -0400
X-MC-Unique: NF8o59KrPkyA8BluyXJZ7g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAB963C025BE;
	Mon, 27 May 2024 11:49:51 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.78])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 09B331C00A8E;
	Mon, 27 May 2024 11:49:50 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jani Nikula <jani.nikula@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mfd: intel_soc_pmic_crc: Use PWM_LOOKUP_WITH_MODULE() for the PWM lookup
Date: Mon, 27 May 2024 13:49:50 +0200
Message-ID: <20240527114950.326659-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

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


