Return-Path: <linux-kernel+bounces-528175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B538A4148D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 05:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CCA188E39C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 04:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8911C6FF2;
	Mon, 24 Feb 2025 04:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b3axEW/J"
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109647E0ED
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 04:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740372764; cv=none; b=sesl+o5vvvrdLa06ugPjtoNbeVYVOHoQ50GvFOyZ9aaR4ewMBRa6oLCTfhOoHjVoBugnTKXw0GCruqwrjfgSe9shpJ4dDspFODLkzUFq64QHiszU2lyvCavqt3qm9b+o1rr6YqM5/tnIB6wtomcyFsdjD34EhY0zgTZVtJDG1KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740372764; c=relaxed/simple;
	bh=4ewO9GEAjU8VymksNh1HeanRKAMGYkmUN6+pCWUNP5c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V+0pFoSiGHi2TfhkkkbK26Tv+VhCjI1gCb0sq+TYzZ/VUxmLPK6aeVCfleT2LY57YA8rX9yXfKE8hdXRKvgw35849XDGRGCc4jdJ8N4q548w6ac3nLm+k2bzgCRx6a9mOfi8di6TCJ5/YuJSe8L59SwL+mvVH6XzKqnzFa+LZE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b3axEW/J; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-5fd085097c1so3811546eaf.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 20:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740372762; x=1740977562; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PmxTTK1F7dSErgDaLhSxA9yRMfDUTL/Vj39jUnWN9Sk=;
        b=b3axEW/JLFdgMvZkjU57GTIXKLp0dMN6Jt5dCrBW+IyxCWIwWCBzzBLmh6bBkDNEUP
         bkg6n2JCrcX4Bw+yToRTWdWWC3AZeQo9BQxJOXMfzcjfrNSVmeEG6PLgHbM/VEh6Kcv3
         tYcUNStXEwlk8FfXXXEDhfQmO+qDDojFw3KPgWArxXjuoc1NJ6qMrl8olQjM/4LpYqKX
         YK3kUATljU9Luhp2/YZlVaRPMJUovbam9sc+DCOy5zf5HAcGZC0MuIsiKKRJ6ZaxEZVD
         +RxnOtCb8UNNLYp/MEI2XAgTWkpiNN6O3EUQ7gQIAL9IVIF5AMGL97mRfPSQndAqckCP
         Kv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740372762; x=1740977562;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PmxTTK1F7dSErgDaLhSxA9yRMfDUTL/Vj39jUnWN9Sk=;
        b=W3vO6leeKSiKY6FgEKIcfWOt+KJEKf1j/QSoMFn/vzOjW4bFrmDQsaP72UIycXr/Ga
         mbNcSP853AhfBV5F8pW3zqAMCuRQ6xHW8uFnbE/ClyGazCKE5lw3qQyF5E83h4/k/6/W
         5TvO84DPc/zbsEzVUf4UtLh6CUSNc80yyrNjByQA/1DV941Mz6tfgbq63DtIhtm1Jsep
         mB2KWCGmNP862FMuY4l1ZQOhxPAs5g+js1SlW7HAkFroIot1+V8trGZJivJPXQ1WOnkW
         I3E0sPB5rX6wY9QuAhWAzwx3eDCv2srSvO4U2ynuCSDjBUxsbIOTRTrjwjVc9tWlz0Eu
         NJQA==
X-Forwarded-Encrypted: i=1; AJvYcCVCsSzYx0G4xnct/IfxijbW4x0KI6i9hQtUEl8POyZta+gOlYC35MHn0TkpotC1VKYIqXgBhay0EOWw4ic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyl7KCI1dRcPPVHLQ9y4erNB34qDpRMoXd6FDUdRC5T9zHrrn6
	h6OSEax3mndPn5NsyDAMwjS64txjv1IJw5/JJtv/bfKfKAYmozTzeoe5jkeP/8pLndBNEK9gc4z
	gOOLq1g==
X-Google-Smtp-Source: AGHT+IHmiOE0rAabspT91c1Y+/mjCGIXjpQkKoKVT/U9XhPTUxj9X7kqSP/lBPacNY3NrXMdIjF2QpPcv5Z3
X-Received: from oachu5.prod.google.com ([2002:a05:6871:5285:b0:2bc:6ba1:58a4])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:8311:b0:288:18a0:e169
 with SMTP id 586e51a60fabf-2bd50d8a806mr9211022fac.19.1740372762058; Sun, 23
 Feb 2025 20:52:42 -0800 (PST)
Date: Mon, 24 Feb 2025 12:52:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250224045237.1290971-1-chharry@google.com>
Subject: [PATCH v2] Bluetooth: btusb: Configure altsetting for USER_CHANNEL
From: Hsin-chen Chuang <chharry@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	gregkh@linuxfoundation.org
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

Automatically configure the altsetting for USER_CHANNEL when a SCO is
connected. This adds support for the USER_CHANNEL to transfer SCO data
over USB transport.

Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

Changes in v2:
- Give up tracking the SCO handles. Only configure the altsetting when
  SCO connected.
- Put the change behind Kconfig/module parameter

 drivers/bluetooth/Kconfig | 11 ++++++++++
 drivers/bluetooth/btusb.c | 46 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 4ab32abf0f48..7c497f878732 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -56,6 +56,17 @@ config BT_HCIBTUSB_POLL_SYNC
 	  Say Y here to enable USB poll_sync for Bluetooth USB devices by
 	  default.
 
+config BT_HCIBTUSB_AUTO_SET_ISOC_ALT
+	bool "Auto set isoc_altsetting for USER_CHANNEL when SCO connected"
+	depends on BT_HCIBTUSB
+	default n
+	help
+	  Say Y here to enable auto set isoc_altsetting for USER_CHANNEL
+	  when SCO connected
+
+	  This can be overridden by passing btusb.auto_set_isoc_alt=[y|n]
+	  on the kernel commandline.
+
 config BT_HCIBTUSB_BCM
 	bool "Broadcom protocol support"
 	depends on BT_HCIBTUSB
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index de3fa725d210..af93d757911b 100644
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
 
@@ -4354,6 +4397,9 @@ MODULE_PARM_DESC(enable_autosuspend, "Enable USB autosuspend by default");
 module_param(reset, bool, 0644);
 MODULE_PARM_DESC(reset, "Send HCI reset command on initialization");
 
+module_param(auto_set_isoc_alt, bool, 0644);
+MODULE_PARM_DESC(auto_set_isoc_alt, "Auto set isoc_altsetting for USER_CHANNEL when SCO connected");
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Generic Bluetooth USB driver ver " VERSION);
 MODULE_VERSION(VERSION);
-- 
2.48.1.601.g30ceb7b040-goog


