Return-Path: <linux-kernel+bounces-309938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 968E396721C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 16:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C121F2280D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 14:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E102355E48;
	Sat, 31 Aug 2024 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUboylTP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AE44D9FB
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725114079; cv=none; b=CAsuuYA83D/DVSMnvRuibJe4wsmYvvTRiq6RxRGfkDLqz2lJJqE0Vo6aQpYGzF7Ki0vF0JUnaFZsGLzn37GbqIiGH70PM0fl/yCjNpdLM0lj2fkze0alDsf+o20Nk16lOLf9XNdxQLcgcFOAxNFZe8+WRwG7hr05GSSovl7cuMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725114079; c=relaxed/simple;
	bh=ZqS5hmbkX87g2QZf8WNV6gJzNhOiPZ8vLhBTDyNoaZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXExeQf+5WNwyfVmAVnRjFHk59uLh5obi6Sy5JB/tuxFlyg32WyNQHibON6dAbRLAqMaXU/cSRjMhPm+6p32q9VCdZprVy4hInclq9zjg8RAJpadK513NE5Nq5sPzM35tjuVuyyiw3/cAZdrG+rujOFRAEWNk1Er8dc1IYfuGC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EUboylTP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725114076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FF++cKBP8Z5pJxXGjkdRcYsFMQ1dJi1+OYKZbD3H9KE=;
	b=EUboylTPAo1YyDXwZtH/Jq+v65DTMBc8QEQfbVKkntkt9jIxMzf5JMEOD1vI/SuGLo6tgp
	5rD7IvCZf/3Gio43ne9izHj7TixyXhedmbIio1kxkbTepGIZ0xWGdtiXrl6ARDM36gUHaZ
	JsmdBdv3ABjxFz7D8J/htjdwHD9KBYw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-w9ZPOsfIMLit7EGphexvFg-1; Sat,
 31 Aug 2024 10:21:12 -0400
X-MC-Unique: w9ZPOsfIMLit7EGphexvFg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B79BD1955D50;
	Sat, 31 Aug 2024 14:21:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A30230001A4;
	Sat, 31 Aug 2024 14:21:05 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Enric Balletbo Serra <enric.balletbo@collabora.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: [PATCH 4/6] power: supply: sysfs: Add power_supply_show_enum_with_available() helper
Date: Sat, 31 Aug 2024 16:20:37 +0200
Message-ID: <20240831142039.28830-5-hdegoede@redhat.com>
In-Reply-To: <20240831142039.28830-1-hdegoede@redhat.com>
References: <20240831142039.28830-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Turn power_supply_charge_behaviour_show() into a generic function for
showing enum values with their available (for writing) values shown
and the current value shown surrounded by sqaure-brackets like
the show() output for "usb_type" and "charge_behaviour".

This is a preparation patch for refactoring the "usb_type" property
handling to use a bitmask indicating available usb-types + this new
generic function.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/power_supply_sysfs.c | 32 ++++++++++++++---------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index ff7e423edd57..9f21b0b54caf 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -518,31 +518,28 @@ int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return ret;
 }
 
-ssize_t power_supply_charge_behaviour_show(struct device *dev,
-					   unsigned int available_behaviours,
-					   enum power_supply_charge_behaviour current_behaviour,
-					   char *buf)
+static ssize_t power_supply_show_enum_with_available(
+			struct device *dev, const char * const labels[], int label_count,
+			unsigned int available_values, int value, char *buf)
 {
 	bool match = false, available, active;
 	ssize_t count = 0;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT); i++) {
-		available = available_behaviours & BIT(i);
-		active = i == current_behaviour;
+	for (i = 0; i < label_count; i++) {
+		available = available_values & BIT(i);
+		active = i == value;
 
 		if (available && active) {
-			count += sysfs_emit_at(buf, count, "[%s] ",
-					       POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[i]);
+			count += sysfs_emit_at(buf, count, "[%s] ", labels[i]);
 			match = true;
 		} else if (available) {
-			count += sysfs_emit_at(buf, count, "%s ",
-					       POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[i]);
+			count += sysfs_emit_at(buf, count, "%s ", labels[i]);
 		}
 	}
 
 	if (!match) {
-		dev_warn(dev, "driver reporting unsupported charge behaviour\n");
+		dev_warn(dev, "driver reporting unavailable enum value %d\n", value);
 		return -EINVAL;
 	}
 
@@ -551,6 +548,17 @@ ssize_t power_supply_charge_behaviour_show(struct device *dev,
 
 	return count;
 }
+
+ssize_t power_supply_charge_behaviour_show(struct device *dev,
+					   unsigned int available_behaviours,
+					   enum power_supply_charge_behaviour current_behaviour,
+					   char *buf)
+{
+	return power_supply_show_enum_with_available(
+				dev, POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT,
+				ARRAY_SIZE(POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT),
+				available_behaviours, current_behaviour, buf);
+}
 EXPORT_SYMBOL_GPL(power_supply_charge_behaviour_show);
 
 int power_supply_charge_behaviour_parse(unsigned int available_behaviours, const char *buf)
-- 
2.46.0


