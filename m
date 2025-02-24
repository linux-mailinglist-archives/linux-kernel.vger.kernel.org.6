Return-Path: <linux-kernel+bounces-528102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1641DA41392
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30AE63B32D2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C201A840E;
	Mon, 24 Feb 2025 02:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="39Ac9zHp"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B447C1A3174
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740364010; cv=none; b=oyMTdhXYIPcBu5TMBN+fFuvwSF/3qwOyu1hEa5QFy/A0EDIPTpnm5Z2vHy7dgDTD/b4vRYXX9Q2OY7aH5k6kevN1RKn9jw1HVSydhnhyR6wcBVMgM0XGcbs5teBnVXp1817MfBHZEUzbJsYQ6SoLGd6tfmehAMJROIvhu4iSdyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740364010; c=relaxed/simple;
	bh=r3dI7WiEKrFqvpwa8Xutcga0Pq3D9iRGQ2iWtyXOVYM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AGgFyogzpdu3BwfwFNN4nyPP+2/9i2+PHmd1ska0ajZZx2xItEJRBlD/r1H7BqvIEsHKKGKChHMLGksMWQVNzy32LinqtPX3xPagLmeCGd2bqdmzXki+/6OmEl4myyJlFuUUKIHcZkvwuB3r+BqbdOy7yqTg/YfipI9SGZOnKvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=39Ac9zHp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220cb5924a4so3929535ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740364008; x=1740968808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LhuIV3j7oQrzKR61zcRCUAWXcpdxwySje2S75gCH1tg=;
        b=39Ac9zHpnAvwe/EUiw18MjzUCVHBH8XbGmx9dKlT+abcfCl6PryiyQgpDWM689rQku
         GFwGwIM+R4UTXcQSFXdd1NEstAyejHy1/XfT6JvE+sgTfJbPkwUP9iAMOMAjT4H8OXqr
         KCEZ+7M1TWZ+MN+k3/It4eFwqZp0Gi4gD6oifTmqE4aUxP+N3G+O3cCgn/KKyG8ILU+S
         aBsOXPY2tMq6bFeAIpkujfKcakYLt34D7PUkQ5T89oQX1jalZgTo5PPgHxKyalMchmS3
         vCwS+Noe4p2KgRnkeb4kNRdSnaQqzrREy3C1N5Z0YXJjyU3UBklPNCKtqoav1JF/2WHg
         yHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740364008; x=1740968808;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LhuIV3j7oQrzKR61zcRCUAWXcpdxwySje2S75gCH1tg=;
        b=pJ24BFQnVfCmrQDKhMjZJetFojkXBteSW7W6NGH2XMOZwSJyIbjNrelt8nArB1I7e/
         Wh2Zkt2oMUenz462oF8DOPhsyHF1aFBgP8y408zYNu+joANl/MurTokb+471XffeufZ0
         RPsncEmw9rZH3ABRZzKUuSRnUpjUPQIHQBpsuM0C35Ya8/Qn0K66nUjJxI1R6IVbLam7
         oUv/0J7PfgMULmDBglm7mjXKnRwdPhR0pag3iPZHmzAWZE+1g0eH6RVN0bTd09WYdq2+
         huiCGC8swdHjMzzkm5TF+iTYhPINuk9cty9dkeiPXIdyUAhb0od21IaynXFS4BR9w4fe
         An3w==
X-Forwarded-Encrypted: i=1; AJvYcCXCAHf28CPiTx4Mbsj1rA3OrIRVLJioikTsTZ85hgu2eHp/DFjZfd687LBuSelEr9RdGmz9h4zmOjiJ8bg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9YtwnALLMNVluvAHmEAykEZ7azdjsfqcBP4Ui4dAyAPZrXZJx
	3jC5+hZZfjUi1Ef+KgL1tCW3KRpHkgYAoZXQhN5Nsgwa9/eZDJPK7rzfwNlUzcPL07DG2fri9LT
	DAgRn+w==
X-Google-Smtp-Source: AGHT+IFZnn3FBdzh9D5B9RxsJfGUyqMzvkNo7PGV4SVPFh2QI3ZjakDkbKiu4nAUhfLmmp/1KDcEqC4BYEw2
X-Received: from plblc12.prod.google.com ([2002:a17:902:fa8c:b0:215:5322:d126])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5cc:b0:21f:1202:f2f5
 with SMTP id d9443c01a7336-2219ff3353bmr161316925ad.8.1740364007568; Sun, 23
 Feb 2025 18:26:47 -0800 (PST)
Date: Mon, 24 Feb 2025 10:24:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250224022447.1141413-1-chharry@google.com>
Subject: [PATCH] Bluetooth: btusb: Configure altsetting for USER_CHANNEL
From: Hsin-chen Chuang <chharry@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	gregkh@linuxfoundation.org
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

Automatically configure the altsetting for USER_CHANNEL when a SCO is
connected or disconnected. This adds support for the USER_CHANNEL to
transfer SCO data over USB transport.

Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

 drivers/bluetooth/btusb.c | 224 +++++++++++++++++++++++++++++++-------
 1 file changed, 186 insertions(+), 38 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index de3fa725d210..dfb0918dfe98 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -854,6 +854,11 @@ struct qca_dump_info {
 #define BTUSB_ALT6_CONTINUOUS_TX	16
 #define BTUSB_HW_SSR_ACTIVE	17
 
+struct sco_handle_list {
+	struct list_head list;
+	u16 handle;
+};
+
 struct btusb_data {
 	struct hci_dev       *hdev;
 	struct usb_device    *udev;
@@ -920,6 +925,9 @@ struct btusb_data {
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
 
 	struct qca_dump_info qca_dump;
+
+	/* Records the exsiting SCO handles for HCI_USER_CHANNEL */
+	struct list_head sco_handle_list;
 };
 
 static void btusb_reset(struct hci_dev *hdev)
@@ -1113,6 +1121,131 @@ static inline void btusb_free_frags(struct btusb_data *data)
 	spin_unlock_irqrestore(&data->rxlock, flags);
 }
 
+static void btusb_sco_handle_list_clear(struct list_head *list)
+{
+	struct sco_handle_list *entry, *n;
+
+	list_for_each_entry_safe(entry, n, list, list) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+}
+
+static struct sco_handle_list *btusb_sco_handle_list_find(
+	struct list_head *list,
+	u16 handle)
+{
+	struct sco_handle_list *entry;
+
+	list_for_each_entry(entry, list, list)
+		if (entry->handle == handle)
+			return entry;
+
+	return NULL;
+}
+
+static int btusb_sco_handle_list_add(struct list_head *list, u16 handle)
+{
+	struct sco_handle_list *entry;
+
+	if (btusb_sco_handle_list_find(list, handle))
+		return -EEXIST;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->handle = handle;
+	list_add(&entry->list, list);
+
+	return 0;
+}
+
+static int btusb_sco_handle_list_del(struct list_head *list, u16 handle)
+{
+	struct sco_handle_list *entry;
+
+	entry = btusb_sco_handle_list_find(list, handle);
+	if (!entry)
+		return -ENOENT;
+
+	list_del(&entry->list);
+	kfree(entry);
+
+	return 0;
+}
+
+static void btusb_sco_conn_change(struct btusb_data *data, struct sk_buff *skb)
+{
+	struct hci_event_hdr *hdr = (void *) skb->data;
+	struct hci_dev *hdev = data->hdev;
+
+	if (hci_skb_pkt_type(skb) != HCI_EVENT_PKT || skb->len < sizeof(*hdr))
+		return;
+
+	switch (hdr->evt) {
+	case HCI_EV_DISCONN_COMPLETE: {
+		struct hci_ev_disconn_complete *ev =
+			(void *) skb->data + sizeof(*hdr);
+		u16 handle;
+
+		if (skb->len != sizeof(*hdr) + sizeof(*ev) || ev->status)
+			return;
+
+		handle = __le16_to_cpu(ev->handle);
+		if (btusb_sco_handle_list_del(&data->sco_handle_list,
+					      handle) < 0)
+			return;
+
+		bt_dev_info(hdev, "disabling SCO");
+		data->sco_num--;
+		data->air_mode = HCI_NOTIFY_DISABLE_SCO;
+		schedule_work(&data->work);
+
+		break;
+	}
+	case HCI_EV_SYNC_CONN_COMPLETE: {
+		struct hci_ev_sync_conn_complete *ev =
+			(void *) skb->data + sizeof(*hdr);
+		unsigned int notify_air_mode;
+		u16 handle;
+
+		if (skb->len != sizeof(*hdr) + sizeof(*ev) || ev->status)
+			return;
+
+		switch (ev->air_mode) {
+		case BT_CODEC_CVSD:
+			notify_air_mode = HCI_NOTIFY_ENABLE_SCO_CVSD;
+			break;
+
+		case BT_CODEC_TRANSPARENT:
+			notify_air_mode = HCI_NOTIFY_ENABLE_SCO_TRANSP;
+			break;
+
+		default:
+			return;
+		}
+
+		handle = __le16_to_cpu(ev->handle);
+		if (btusb_sco_handle_list_add(&data->sco_handle_list,
+					      handle) < 0) {
+			bt_dev_err(hdev, "failed to add the new SCO handle");
+			return;
+		}
+
+		bt_dev_info(hdev, "enabling SCO with air mode %u",
+			    ev->air_mode);
+		data->sco_num++;
+		data->air_mode = notify_air_mode;
+		schedule_work(&data->work);
+
+		break;
+	}
+	default:
+		break;
+	}
+}
+
 static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
 {
 	if (data->intr_interval) {
@@ -1120,6 +1253,10 @@ static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
 		schedule_delayed_work(&data->rx_work, 0);
 	}
 
+	/* Configure altsetting for HCI_USER_CHANNEL on SCO dis/connected */
+	if (hci_dev_test_flag(data->hdev, HCI_USER_CHANNEL))
+		btusb_sco_conn_change(data, skb);
+
 	return data->recv_event(data->hdev, skb);
 }
 
@@ -1919,44 +2056,6 @@ static void btusb_stop_traffic(struct btusb_data *data)
 	usb_kill_anchored_urbs(&data->ctrl_anchor);
 }
 
-static int btusb_close(struct hci_dev *hdev)
-{
-	struct btusb_data *data = hci_get_drvdata(hdev);
-	int err;
-
-	BT_DBG("%s", hdev->name);
-
-	cancel_delayed_work(&data->rx_work);
-	cancel_work_sync(&data->work);
-	cancel_work_sync(&data->waker);
-
-	skb_queue_purge(&data->acl_q);
-
-	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
-	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
-	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
-	clear_bit(BTUSB_DIAG_RUNNING, &data->flags);
-
-	btusb_stop_traffic(data);
-	btusb_free_frags(data);
-
-	err = usb_autopm_get_interface(data->intf);
-	if (err < 0)
-		goto failed;
-
-	data->intf->needs_remote_wakeup = 0;
-
-	/* Enable remote wake up for auto-suspend */
-	if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags))
-		data->intf->needs_remote_wakeup = 1;
-
-	usb_autopm_put_interface(data->intf);
-
-failed:
-	usb_scuttle_anchored_urbs(&data->deferred);
-	return 0;
-}
-
 static int btusb_flush(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -2327,6 +2426,51 @@ static void btusb_work(struct work_struct *work)
 	}
 }
 
+static int btusb_close(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
+		btusb_sco_handle_list_clear(&data->sco_handle_list);
+		data->sco_num = 0;
+		if (data->isoc_altsetting != 0)
+			btusb_switch_alt_setting(hdev, 0);
+	}
+
+	cancel_delayed_work(&data->rx_work);
+	cancel_work_sync(&data->work);
+	cancel_work_sync(&data->waker);
+
+	skb_queue_purge(&data->acl_q);
+
+	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
+	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
+	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
+	clear_bit(BTUSB_DIAG_RUNNING, &data->flags);
+
+	btusb_stop_traffic(data);
+	btusb_free_frags(data);
+
+	err = usb_autopm_get_interface(data->intf);
+	if (err < 0)
+		goto failed;
+
+	data->intf->needs_remote_wakeup = 0;
+
+	/* Enable remote wake up for auto-suspend */
+	if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags))
+		data->intf->needs_remote_wakeup = 1;
+
+	usb_autopm_put_interface(data->intf);
+
+failed:
+	usb_scuttle_anchored_urbs(&data->deferred);
+	return 0;
+}
+
 static void btusb_waker(struct work_struct *work)
 {
 	struct btusb_data *data = container_of(work, struct btusb_data, waker);
@@ -3782,6 +3926,8 @@ static int btusb_probe(struct usb_interface *intf,
 	data->udev = interface_to_usbdev(intf);
 	data->intf = intf;
 
+	INIT_LIST_HEAD(&data->sco_handle_list);
+
 	INIT_WORK(&data->work, btusb_work);
 	INIT_WORK(&data->waker, btusb_waker);
 	INIT_DELAYED_WORK(&data->rx_work, btusb_rx_work);
@@ -4117,6 +4263,8 @@ static void btusb_disconnect(struct usb_interface *intf)
 	hdev = data->hdev;
 	usb_set_intfdata(data->intf, NULL);
 
+	btusb_sco_handle_list_clear(&data->sco_handle_list);
+
 	if (data->isoc) {
 		device_remove_file(&intf->dev, &dev_attr_isoc_alt);
 		usb_set_intfdata(data->isoc, NULL);
-- 
2.48.1.601.g30ceb7b040-goog


