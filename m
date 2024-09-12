Return-Path: <linux-kernel+bounces-326234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 244F497654A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1151F22F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004AB1A28D;
	Thu, 12 Sep 2024 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttsande.rs header.i=@ttsande.rs header.b="aKp9M5ip"
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E303188A01
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726132470; cv=none; b=LQyVgVi6RzVw5xUYm0lF+S+AON4+fup3opFXXPU0hSSHmbsED8Fm86UqDStG7YqWpk6B9NWZqiAPIv6ETOoEUV2R0EygB/XZGi65ANtUM6Y50SzPNLr1Uo9LtbWzKbD3BaEwOTe0qz9jyRaPdwlLjo4F5XWip5eu1xSVskmN0as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726132470; c=relaxed/simple;
	bh=wR7KyTTlrcBgeT3DEYjx1z7krjjOgwV0BSM23Gt8to4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kz/EjjOFMtgCvbYCTyNa4cs69KktJVqZaMhNaBOpPhQulW95mtmxe64xbNQubJeKHFafAqU3ScEjM5BYjP0CLOPjdBZlyaUd4JbwLdnmfwtIarXbk/pyb/E4vpb41pbkeFttmFZl97L4rs6WZntMrRuhiXUoQXVVC5dYfXS1QCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttsande.rs; spf=pass smtp.mailfrom=ttsande.rs; dkim=pass (2048-bit key) header.d=ttsande.rs header.i=@ttsande.rs header.b=aKp9M5ip; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttsande.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttsande.rs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ttsande.rs;
	s=protonmail; t=1726132460; x=1726391660;
	bh=UasRgKsHucgEdP6i8Yd5Stdu2vUTHCovW7vAHe0aNJE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=aKp9M5ipcoDu6di/KOLeBIATKsg2Qk+gOJPTIGN8FGZmwvP1K+X5mTWu7Qc2QR/1n
	 1wClzjDgMVslm9fdJsvwiyRgJzo5q3IcBwXmImj7DBs5C+3B2lqBLR1v2e/u2euaTC
	 WWFIvhcGz4I0t4Ue6GXi0LoiQhLL1WKJufIZxBWGChh0S+5d5T2eY8lOsnn5MnmZL2
	 KWfZfwA7B1g2vq+GYkH1SOIgGvtpfl/BoUtAWZURotOKzrdoYbifwZrY7ePKdU26z+
	 ISPsRCUpMdOpqcge3iEhcVxiG9/EkspAy9+W9JSWPF/lqERxKNs8hBRF9F5M8+DqTv
	 Mu++rb614/uDA==
Date: Thu, 12 Sep 2024 09:14:14 +0000
To: jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org
From: Matthew Sanders <m@ttsande.rs>
Cc: linux-kernel@vger.kernel.org, ppwaskie@kernel.org
Subject: [PATCH] hwmon: Fix WARN_ON() always called from devm_hwmon_device_unregister()
Message-ID: <20240912091401.4101-1-m@ttsande.rs>
Feedback-ID: 116677769:user:proton
X-Pm-Message-ID: 43e44de0c65e9b70e98738a0aad12dd0e65fcde2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

devm_hwmon_device_unregister() only takes parent of a devres-managed
hwmon device as an argument. This always fails, as devres can't find
the hwmon device it needs to unregister with the parent device alone.
Without this patch, the WARN_ON() in devm_hwmon_device_unregister() will
always be displayed unconditionally:

[    7.969746] WARNING: CPU: 1 PID: 224 at drivers/hwmon/hwmon.c:1205 devm_=
hwmon_device_unregister+0x28/0x30

This patch adds an extra argument to devm_hwmon_device_unregister(), a
pointer to a hwmon device which was previously registered to the
parent using devres.

There aren't any drivers which currently make use of this function, so
any existing users of devm_hwmon_* shouldn't require any changes as a
result of this patch.
---
 drivers/hwmon/hwmon.c | 6 ++++--
 include/linux/hwmon.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index a362080d41fa..84945a276320 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -1199,10 +1199,12 @@ static int devm_hwmon_match(struct device *dev, voi=
d *res, void *data)
  * devm_hwmon_device_unregister - removes a previously registered hwmon de=
vice
  *
  * @dev: the parent device of the device to unregister
+ * @hwdev: the hwmon device to unregister
  */
-void devm_hwmon_device_unregister(struct device *dev)
+void devm_hwmon_device_unregister(struct device *dev, struct device *hwdev=
)
 {
-=09WARN_ON(devres_release(dev, devm_hwmon_release, devm_hwmon_match, dev))=
;
+=09WARN_ON(devres_release(dev, devm_hwmon_release, devm_hwmon_match,
+=09=09=09       hwdev));
 }
 EXPORT_SYMBOL_GPL(devm_hwmon_device_unregister);
=20
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index e94314760aab..2434c6fc17a7 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -481,7 +481,7 @@ devm_hwmon_device_register_with_info(struct device *dev=
,
 =09=09=09=09const struct attribute_group **extra_groups);
=20
 void hwmon_device_unregister(struct device *dev);
-void devm_hwmon_device_unregister(struct device *dev);
+void devm_hwmon_device_unregister(struct device *dev, struct device *hwdev=
);
=20
 int hwmon_notify_event(struct device *dev, enum hwmon_sensor_types type,
 =09=09       u32 attr, int channel);
--=20
2.46.0



