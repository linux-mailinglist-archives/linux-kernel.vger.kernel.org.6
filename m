Return-Path: <linux-kernel+bounces-330391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07568979DC7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B3E5B22961
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FB51A28C;
	Mon, 16 Sep 2024 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="F/j5Xpck"
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3EE146D7E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726477439; cv=none; b=kyopgInTFJT6yVIZDBPRxUzciNY3p/aJpud8/I5dQ2KG6HCu5H2M64qndRuwJAiZUl7AcVgF13F0FV/uC+3gIF5BhITTPsNK0quD13NW+F6k7PXUtOuKg8pa+3WDxDvbB/p8ApimA7dcTZQg9ImF69lILvDAwjcWDe5dx27tTJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726477439; c=relaxed/simple;
	bh=5oPEPxx3btISiu2HKpOI8h4G0Mq5rcLQYI86wc46wgA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JauQBN/UW0uoR6s0VhzGH7B0TxRb6VZ4NCGiowm5CzYdGwmnU9Ic8nCcSlFhtIGmoEvflAS4MNs1BXL82kXvZdFZnwq40q0blncO8HqGX2S/OTBfEhzpPcUaPiG0GZWPOLder+vwOKEW8V6y24xhFIsLRK48dCQqgpPND77JMfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=F/j5Xpck; arc=none smtp.client-ip=170.10.133.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1726477436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gx4WAWn0gDdOn3D6kua7ErNP0JPsHujFHwToAOT0YXM=;
	b=F/j5Xpck4u6A+Oumay3OIbBf+iTLBwpYBynQi3BVMyIcudQQ8N6YZiiYFF1fLRWG+2hIW/
	ZaajR6IwogVRb8vFLeI2W+Pt/Rz4GI/y58QsZ2hV65f0miveooQsdfC2zGcO/sRAiOg4SC
	Jg34GERng49xAiyz8JIyWrPeIHeVTA8=
Received: from g7t16454g.inc.hp.com (hpifallback.mail.core.hp.com
 [15.73.128.143]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-dfc8iAKPMvqdM8G5pCHtmg-1; Mon, 16 Sep 2024 05:03:49 -0400
X-MC-Unique: dfc8iAKPMvqdM8G5pCHtmg-1
Received: from g8t13021g.inc.hpicorp.net (g8t13021g.inc.hpicorp.net [15.60.27.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by g7t16454g.inc.hp.com (Postfix) with ESMTPS id ECD0E60010EF;
	Mon, 16 Sep 2024 09:03:48 +0000 (UTC)
Received: from mail.hp.com (unknown [15.32.134.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by g8t13021g.inc.hpicorp.net (Postfix) with ESMTPS id 3DB4260000B6;
	Mon, 16 Sep 2024 09:03:47 +0000 (UTC)
Received: from cdc-linux-buildsrv17.. (localhost [127.0.0.1])
	by mail.hp.com (Postfix) with ESMTP id 2ACAFA401C6;
	Mon, 16 Sep 2024 16:56:03 +0800 (CST)
From: Wade Wang <wade.wang@hp.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wade.wang@hp.com
Cc: stable@vger.kernel.org
Subject: [PATCH] HID: plantronics: Workaround for an unexcepted opposite volume key
Date: Mon, 16 Sep 2024 16:56:00 +0800
Message-Id: <20240916085600.1387418-1-wade.wang@hp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true

Some Plantronics headset as the below send an unexcept opposite
volume key's HID report for each volume key press after 200ms, like
unecepted Volume Up Key following Volume Down key pressed by user.
This patch adds a quirk to hid-plantronics for these devices, which
will ignore the second unexcepted opposite volume key if it happens
within 220ms from the last one that was handled.
    Plantronics EncorePro 500 Series  (047f:431e)
    Plantronics Blackwire_3325 Series (047f:430c)

The patch was tested on the mentioned model, it shouldn't affect
other models, however, this quirk might be needed for them too.
Auto-repeat (when a key is held pressed) is not affected per test
result.

Cc: stable@vger.kernel.org
Signed-off-by: Wade Wang <wade.wang@hp.com>
---
 drivers/hid/hid-ids.h         |  2 ++
 drivers/hid/hid-plantronics.c | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 781c5aa29859..b72d70bc5628 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1050,6 +1050,8 @@
 #define USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3220_SERIES=090xc056
 #define USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3215_SERIES=090xc057
 #define USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3225_SERIES=090xc058
+#define USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3325_SERIES=090x430c
+#define USB_DEVICE_ID_PLANTRONICS_ENCOREPRO_500_SERIES=09=090x431e
=20
 #define USB_VENDOR_ID_PANASONIC=09=090x04da
 #define USB_DEVICE_ID_PANABOARD_UBT780=090x1044
diff --git a/drivers/hid/hid-plantronics.c b/drivers/hid/hid-plantronics.c
index 3d414ae194ac..25cfd964dc25 100644
--- a/drivers/hid/hid-plantronics.c
+++ b/drivers/hid/hid-plantronics.c
@@ -38,8 +38,10 @@
 =09=09=09    (usage->hid & HID_USAGE_PAGE) =3D=3D HID_UP_CONSUMER)
=20
 #define PLT_QUIRK_DOUBLE_VOLUME_KEYS BIT(0)
+#define PLT_QUIRK_FOLLOWED_OPPOSITE_VOLUME_KEYS BIT(1)
=20
 #define PLT_DOUBLE_KEY_TIMEOUT 5 /* ms */
+#define PLT_FOLLOWED_OPPOSITE_KEY_TIMEOUT 220 /* ms */
=20
 struct plt_drv_data {
 =09unsigned long device_type;
@@ -137,6 +139,21 @@ static int plantronics_event(struct hid_device *hdev, =
struct hid_field *field,
=20
 =09=09drv_data->last_volume_key_ts =3D cur_ts;
 =09}
+=09if (drv_data->quirks & PLT_QUIRK_FOLLOWED_OPPOSITE_VOLUME_KEYS) {
+=09=09unsigned long prev_ts, cur_ts;
+
+=09=09/* Usages are filtered in plantronics_usages. */
+
+=09=09if (!value) /* Handle key presses only. */
+=09=09=09return 0;
+
+=09=09prev_ts =3D drv_data->last_volume_key_ts;
+=09=09cur_ts =3D jiffies;
+=09=09if (jiffies_to_msecs(cur_ts - prev_ts) <=3D PLT_FOLLOWED_OPPOSITE_KE=
Y_TIMEOUT)
+=09=09=09return 1; /* Ignore the followed opposite volume key. */
+
+=09=09drv_data->last_volume_key_ts =3D cur_ts;
+=09}
=20
 =09return 0;
 }
@@ -210,6 +227,12 @@ static const struct hid_device_id plantronics_devices[=
] =3D {
 =09{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS,
 =09=09=09=09=09 USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3225_SERIES),
 =09=09.driver_data =3D PLT_QUIRK_DOUBLE_VOLUME_KEYS },
+=09{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS,
+=09=09=09=09=09 USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3325_SERIES),
+=09=09.driver_data =3D PLT_QUIRK_FOLLOWED_OPPOSITE_VOLUME_KEYS },
+=09{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS,
+=09=09=09=09=09 USB_DEVICE_ID_PLANTRONICS_ENCOREPRO_500_SERIES),
+=09=09.driver_data =3D PLT_QUIRK_FOLLOWED_OPPOSITE_VOLUME_KEYS },
 =09{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS, HID_ANY_ID) },
 =09{ }
 };
--=20
Change log:
1. 2nd patch submission:
   Add one Cc mail aoount in patch comment, per kernel test robot
   required
2. 3rd patch submission:
   Code and comment change to Separate this patch with previous patch
   'commit f567d6ef8606 ("HID: plantronics: Workaround for double
   volume key presses")'
2.34.1


