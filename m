Return-Path: <linux-kernel+bounces-309937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBC2967219
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 16:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252FF1F228B9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 14:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7C93CF63;
	Sat, 31 Aug 2024 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4mdBa9F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F9742077
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725114074; cv=none; b=lUUCD/0YyOZgKPGmMGRijg+FaLChFAvjaNEysIJx8ybM36E6MLHKIiTyLmeI3KAurxU02XPDVv8dQbNqyb87nD3IWdE+wNplZDyGjcM1JSGI88JGIjY9b0gIW8BWvB/lyjDuYzhhOV7BtkvXWO5MSXCPRqQ619aoUEVh8oPX8gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725114074; c=relaxed/simple;
	bh=Q1ksihjpVfuP+VRWxZRsYugofz9jYU44EY/sBMoBMEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhLZGUUeyonZXs0K2Dx88WIc2tJd9qT3XgU4LQICxFtkEYijjbN+0vPwDCNR9CZwLfcKR8FAhtBmOnld1Rj0nU5413BbIu2exnosjw1l1/Fy9n88nv4aQFjxi8kRgI5eDxJNr+jf1QNiLp2WLcIm2Poyux7/kEfY3bT5l2zseRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d4mdBa9F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725114072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+YaXcuOLFlVp84HCFFSCXL1mJivlfEZlF6lzWx9g7c=;
	b=d4mdBa9FTPK31LbGYLEhmkKYySw8edlAkRYTcmhCqBvM7FL5vo+WsBbZRgehfEBcFDejA8
	LeImx47ytQ5pWSvfib7aQ6iwosfgOqLW6mHmHKcTkT+3hav3kWRmRWkYtWNLTMGCeuhc9g
	OkuJHQ3qy2IwVK8If2qJj5lkfz76CVc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-zT7G6qIhP6O32hWBOUjMtA-1; Sat,
 31 Aug 2024 10:21:07 -0400
X-MC-Unique: zT7G6qIhP6O32hWBOUjMtA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49E4A19560B7;
	Sat, 31 Aug 2024 14:21:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 323B13001FE8;
	Sat, 31 Aug 2024 14:21:00 +0000 (UTC)
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
Subject: [PATCH 3/6] power: supply: rt9467-charger: Remove "usb_type" property write support
Date: Sat, 31 Aug 2024 16:20:36 +0200
Message-ID: <20240831142039.28830-4-hdegoede@redhat.com>
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

The "usb_type" property must be read-only for charger power-supply devices,
see: Documentation/ABI/testing/sysfs-class-power.

But the rt9467 driver allows writing 0/1 to it to disable/enable charging.
Other charger drivers use the "status" property for this and the rt9467
code also allows writing 0/1 to its "status" property and this does
the exact same thing as writing 0/1 to its "usb_type" property.

Drop write support for the "usb_type" property making it readonly to match
the ABI documentation. If userspace wants to disable/enable charging it
can use the "status" property for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/rt9467-charger.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply/rt9467-charger.c
index fdfdc83ab045..f935bd761ac1 100644
--- a/drivers/power/supply/rt9467-charger.c
+++ b/drivers/power/supply/rt9467-charger.c
@@ -745,8 +745,6 @@ static int rt9467_psy_set_property(struct power_supply *psy,
 						    RT9467_RANGE_IPREC, val->intval);
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 		return rt9467_psy_set_ieoc(data, val->intval);
-	case POWER_SUPPLY_PROP_USB_TYPE:
-		return regmap_field_write(data->rm_field[F_USBCHGEN], val->intval);
 	default:
 		return -EINVAL;
 	}
@@ -764,7 +762,6 @@ static int rt9467_chg_prop_is_writeable(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
-	case POWER_SUPPLY_PROP_USB_TYPE:
 		return 1;
 	default:
 		return 0;
-- 
2.46.0


