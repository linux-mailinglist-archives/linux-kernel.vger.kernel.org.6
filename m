Return-Path: <linux-kernel+bounces-536962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54753A48658
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397B23A8710
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180131DDA2F;
	Thu, 27 Feb 2025 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DTdh0MwG"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF6A1D5AB7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676470; cv=none; b=P+/hGRjCCknGAXp6Mt02mKWgD7SFSheNkmd1N6P/BX3wu/mvJqiU+KrBML/ir4S6+ichjyzdBSGAAz5xAjoyL3gBxYFBNNoHtHJQvsxUCBEFhPzEOb8Fcaf3G4yQ/3WjhEWNwlz5DdqRYY0+uZzA5+QB0MeNVb3GzTLUzmaSGs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676470; c=relaxed/simple;
	bh=Mr065aLwDPpMSXCkDJTHsX4MEpWPWczv3U763+DNdoQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RpXyBVH8uLa05K2YXoaI18gq7jp0/3YnEok0lsbUgu00KekVg0jvFoFdfBj8gq9ei8ypyJnvF9+pTAY4Q4mZ+N1fiAPpsXHgyXbqjkhdkP6SqssYi1kI8FniloMF5KiB4OkEbPaZk8F3CiCGL7IR1z4taMm1nMpE2dlIl3CrtS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DTdh0MwG; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2233b154004so24802745ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740676468; x=1741281268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/2doYlt7bdzob5FlYQ016oVEDcO5UET56vlV29hWHmI=;
        b=DTdh0MwGLHjrVkppqF/Qz+w7YimlbWOePcp4QiQP75dIi1p6x39AKzqE08ZIUgCMXT
         JlxcvflbRK1rYu131NUESDc2bfibofz/kdAViut9FAyJ2f2iZvPIB+MGPraMg2Wb8TA8
         JC4bGSMkoMpIUBymJtFWNL/hU+c6orfq61N2zbxrOXF27S3axv50ohA0X023Wa79erw7
         XPLjHaSoTVX5yLXBmX/llypW4610YD1/FJahiTcGCdZMI19FkwRFA2KemkiwA396mnZm
         awYsGjksuixt8wTAe/LDmNe5yGNMe37iJZK7TUWAjXbxm9/Ku9OuDklGOtFANUzYiDta
         iPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740676468; x=1741281268;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/2doYlt7bdzob5FlYQ016oVEDcO5UET56vlV29hWHmI=;
        b=ZwNuN+dBHewmjbN8RPWSGkgU3KN2Vmd9lhX9SPuYs98qY8nIsZXg0pWa6QGzt98wEN
         GRY1c6otVfL1KVOrbCXl61oIXHL0jfGxzhFCzorMRxqMW1wsqb7M5L7RVEqdbRrzdI2y
         V/wOFjSZAeTvfc3pE5fIlga7ZGNODajBA9F4UELTqHUaoPh766i5TRzPxKimmQ6EaJBC
         x3YjNvaJldzWHaIC4OeHvpX5aV3mO01RncWw4KjywSwONzXrWt+uykh/A/2axyCvYv+L
         +piBgALy9dPAMgIUrfV0Tkbfz6HAfwh82cOg3CCmiP9kpvAJgQjGdJGxl9Vs4jRoxJOv
         scVw==
X-Forwarded-Encrypted: i=1; AJvYcCVPq3Z5dXkfN1tRfk7CaACdxFpUbbrX6JwMGoOOrPdjUuLyMumA04NlC9h2PTbsy4UooSqEQL/vEgcOLjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAANE1Nvv5VPY/OJ24H3622Udqjgo5HlCE6rH72ucqnxdtMBF/
	5831MGQmOZa7y6D5O/NaShqPc1Am5VVzIM1VYdNi17To4BffamLmhNLWMkFbyD4kZnMwBS+QSDk
	xwUDe0Q==
X-Google-Smtp-Source: AGHT+IEwv6PJSeFsIMmL862DeYroyv7Jeis8fMjb6uMUYkKB3jKARQbyNLzawIVamN5xRdF2vx6HN6J/jvUL
X-Received: from pfgt7.prod.google.com ([2002:a05:6a00:1387:b0:730:7d23:bc34])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:986:b0:730:8a0a:9f06
 with SMTP id d2e1a72fcca58-734ac419af8mr295236b3a.16.1740676468192; Thu, 27
 Feb 2025 09:14:28 -0800 (PST)
Date: Fri, 28 Feb 2025 01:14:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227171417.4023415-1-chharry@google.com>
Subject: [PATCH v3] Bluetooth: btusb: Configure altsetting for HCI_USER_CHANNEL
From: Hsin-chen Chuang <chharry@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	gregkh@linuxfoundation.org, pmenzel@molgen.mpg.de
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

Automatically configure the altsetting for HCI_USER_CHANNEL when a SCO
is connected.

The motivation is to enable the HCI_USER_CHANNEL user to send out SCO
data through USB Bluetooth chips, which is mainly used for bidirectional
audio transfer (voice call). This was not capable because:

- Per Bluetooth Core Spec v5, Vol 4, Part B, 2.1, the corresponding
  alternate setting should be set based on the air mode in order to
  transfer SCO data, but
- The Linux Bluetooth HCI_USER_CHANNEL exposes the Bluetooth Host
  Controller Interface to the user space, which is something above the
  USB layer. The user space is not able to configure the USB alt while
  keeping the channel open.

This patch intercepts the HCI_EV_SYNC_CONN_COMPLETE packets in btusb,
extracts the air mode, and configures the alt setting in btusb.

This patch is tested on ChromeOS devices. The USB Bluetooth models
(CVSD, TRANS alt3 and alt6) could work without a customized kernel.

Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

Changes in v3:
- Remove module parameter
- Set Kconfig to default y if CHROME_PLATFORMS

Changes in v2:
- Give up tracking the SCO handles. Only configure the altsetting when
  SCO connected.
- Put the change behind Kconfig/module parameter

 drivers/bluetooth/Kconfig | 11 ++++++++++
 drivers/bluetooth/btusb.c | 43 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 4ab32abf0f48..cdf7a5caa5c8 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -56,6 +56,17 @@ config BT_HCIBTUSB_POLL_SYNC
 	  Say Y here to enable USB poll_sync for Bluetooth USB devices by
 	  default.
 
+config BT_HCIBTUSB_AUTO_SET_ISOC_ALT
+	bool "Auto set isoc_altsetting for HCI_USER_CHANNEL when SCO connected"
+	depends on BT_HCIBTUSB
+	default y if CHROME_PLATFORMS
+	help
+	  Say Y here to enable auto set isoc_altsetting for HCI_USER_CHANNEL
+	  when SCO connected
+
+	  When enabled, btusb intercepts the HCI_EV_SYNC_CONN_COMPLETE packets
+	  and configures isoc_altsetting automatically for HCI_USER_CHANNEL.
+
 config BT_HCIBTUSB_BCM
 	bool "Broadcom protocol support"
 	depends on BT_HCIBTUSB
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index de3fa725d210..2642d2ca885f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -34,6 +34,8 @@ static bool force_scofix;
 static bool enable_autosuspend = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUSPEND);
 static bool enable_poll_sync = IS_ENABLED(CONFIG_BT_HCIBTUSB_POLL_SYNC);
 static bool reset = true;
+static bool auto_set_isoc_alt =
+	IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTO_SET_ISOC_ALT);
 
 static struct usb_driver btusb_driver;
 
@@ -1113,6 +1115,42 @@ static inline void btusb_free_frags(struct btusb_data *data)
 	spin_unlock_irqrestore(&data->rxlock, flags);
 }
 
+static void btusb_sco_connected(struct btusb_data *data, struct sk_buff *skb)
+{
+	struct hci_event_hdr *hdr = (void *) skb->data;
+	struct hci_ev_sync_conn_complete *ev =
+		(void *) skb->data + sizeof(*hdr);
+	struct hci_dev *hdev = data->hdev;
+	unsigned int notify_air_mode;
+
+	if (hci_skb_pkt_type(skb) != HCI_EVENT_PKT)
+		return;
+
+	if (skb->len < sizeof(*hdr) || hdr->evt != HCI_EV_SYNC_CONN_COMPLETE)
+		return;
+
+	if (skb->len != sizeof(*hdr) + sizeof(*ev) || ev->status)
+		return;
+
+	switch (ev->air_mode) {
+	case BT_CODEC_CVSD:
+		notify_air_mode = HCI_NOTIFY_ENABLE_SCO_CVSD;
+		break;
+
+	case BT_CODEC_TRANSPARENT:
+		notify_air_mode = HCI_NOTIFY_ENABLE_SCO_TRANSP;
+		break;
+
+	default:
+		return;
+	}
+
+	bt_dev_info(hdev, "enabling SCO with air mode %u", ev->air_mode);
+	data->sco_num = 1;
+	data->air_mode = notify_air_mode;
+	schedule_work(&data->work);
+}
+
 static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
 {
 	if (data->intr_interval) {
@@ -1120,6 +1158,11 @@ static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
 		schedule_delayed_work(&data->rx_work, 0);
 	}
 
+	/* Configure altsetting for HCI_USER_CHANNEL on SCO connected */
+	if (auto_set_isoc_alt &&
+	    hci_dev_test_flag(data->hdev, HCI_USER_CHANNEL))
+		btusb_sco_connected(data, skb);
+
 	return data->recv_event(data->hdev, skb);
 }
 
-- 
2.48.1.658.g4767266eb4-goog


