Return-Path: <linux-kernel+bounces-186120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6EB8CC006
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2FBA1F20ACA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB82D84A3C;
	Wed, 22 May 2024 11:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dUYe7QLH"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F1380020
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376307; cv=none; b=U8BakMlAAI6FUG3Gq9UnTpIiG32R4jDWHFBiIlAEXM126h3Z0HOhToQjKPmV8kSBO1FvvDwSySLsoX8rLPquD1KIrakkFb2jmkkLXUvQT5+CtNNrBYfMc2RsRfnG5xBidngcJfDM28zQ/tF5gBAGR05iHOg7sik7udnNofA//Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376307; c=relaxed/simple;
	bh=Ow3Tprf5J79b5FpVc2oISMYxIiNACP/jJXhyCs7qoh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eGrkCLTT0pHBlH8OyJH8cOyJmMe2nVT2IrE0tcC37jxm3gD0fZ+6qzZIsMGQ2nFmj03JG6kRTwnRjkexR7Ej/X61zR/FPqjIqHR1i9koAf91GixE26RuHXMFuZyyRXFSCvX9kRaWgKfMc2S5t6guagc4XbYhIUhe4YYxwA+BkLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dUYe7QLH; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7e21742025aso292945239f.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 04:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716376305; x=1716981105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HGIbu+ypr2d0LLOENVoxzZcXEUbFgFGUeiK4yxl8U00=;
        b=dUYe7QLH5abdjotnhf7Or3sbvFrG0V+mcfblmSJ/1voWuzRVdRzRcDu9NLKehJ2dJf
         L2K9uA423Hfekul6+zhyeNL9ZP96lNchp6V57P9SBD9jcDtDTpKazd6CH2Ewt1smXfR+
         IzH4dVP5LZFk7JDA5PMwvo+fQFj0p1MIAAe7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716376305; x=1716981105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGIbu+ypr2d0LLOENVoxzZcXEUbFgFGUeiK4yxl8U00=;
        b=cumpBdkmUgMsm5co/gnknhCcfkdAdXmaql4OULLKvBVTMn97j0smX5g6jfvVz791Ta
         Cwc5tIW14BR/1bpH4C078hup/so0LjdjGzip6oxOuKKPSQlt0kel0yV+AUmyUgiO0Sei
         XW6Xq6G/aRK2qLaIBAA/9Ec4La47sa0s8oKNAWG1kCLbPT4ilTonIdR+/s/EWX5sOyhH
         kwWAAMnDG0Ra8dNByzwo0uf7Y1Wkg5g5APiSmCJS10tNNC+cw880S39EaVfAQoZNsi5h
         vvZv7XKmXilXzd9J8GoL6A3KaZIv6cXA6AdNym0kC+PE/ycxXdhhmtzX1lS/PZLR797e
         5JYw==
X-Forwarded-Encrypted: i=1; AJvYcCUj/bMpnuipNeLWGD+Ucd7Hka6CEDXzRXR2zmcjEhzFl2cL+EQ5ZHUvxbp9FFwJuUaGtKceAQGn93oD1ze22CxC9oKrWvHlOYKrkZPX
X-Gm-Message-State: AOJu0Yxv/0VNhN2cDnHVopiycBljMG3zdH2EvLqjS9tEOFVczgt/hEIl
	MjA4tHBHjGuzzs+eIGw70Swz4UsfRG18Pr1arHmRzGhz9PRtZPO7uIk1T23JuA==
X-Google-Smtp-Source: AGHT+IFN6Nvak7Dqx/xB9Ivk+mj+bG1LJIAMXGSVPgcr9zqCUjXNVQ2gq65QJFSQbInD3nIzG+3+Pg==
X-Received: by 2002:a05:6602:4b86:b0:7e1:542d:7b09 with SMTP id ca18e2360f4ac-7e360c1566amr175674139f.0.1716376305249;
        Wed, 22 May 2024 04:11:45 -0700 (PDT)
Received: from localhost (60.252.199.104.bc.googleusercontent.com. [104.199.252.60])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-6f4d2b2de1csm23189037b3a.204.2024.05.22.04.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 04:11:44 -0700 (PDT)
From: Ying Hsu <yinghsu@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: chromeos-bluetooth-upstreaming@chromium.org,
	Ying Hsu <yinghsu@chromium.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: vendor specific ISO data packet identification by handle
Date: Wed, 22 May 2024 11:11:37 +0000
Message-ID: <20240522111139.2612601-1-yinghsu@chromium.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When HCI raw sockets are opened, the Bluetooth kernel module doesn't
track CIS/BIS connections. User-space applications have to identify
ISO data by maintaining connection information and look up the mapping
for each ACL data packet received. Besides, btsnoop log catpured in
kernel would couldn't tell ISO data from ACL data in this case.

By differentiating ISO data from ACL data earlier in btusb, we can
eliminate unnecessary lookups and improve btsnoop log clarity.
This patch enables vendor-specific differentiation between ISO and
ACL data packets.

Signed-off-by: Ying Hsu <yinghsu@chromium.org>
---
Tested LE unicast recording on a ChromeOS device with Intel AX211

 drivers/bluetooth/btusb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 79aefdb3324d..543961b6c671 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -889,6 +889,8 @@ struct btusb_data {
 	int (*recv_acl)(struct hci_dev *hdev, struct sk_buff *skb);
 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
 
+	int (*is_iso_data_pkt)(struct sk_buff *skb);
+
 	int (*setup_on_usb)(struct hci_dev *hdev);
 
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
@@ -1229,6 +1231,8 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 
 		if (!hci_skb_expect(skb)) {
 			/* Complete frame */
+			if (data->is_iso_data_pkt && data->is_iso_data_pkt(skb))
+				hci_skb_pkt_type(skb) = HCI_ISODATA_PKT;
 			btusb_recv_acl(data, skb);
 			skb = NULL;
 		}
@@ -2539,6 +2543,13 @@ static int btusb_recv_bulk_intel(struct btusb_data *data, void *buffer,
 	return btusb_recv_bulk(data, buffer, count);
 }
 
+static int btusb_is_iso_data_pkt_intel(struct sk_buff *skb)
+{
+	__u16 handle = (__le16_to_cpu(hci_acl_hdr(skb)->handle) & 0xfff);
+
+	return (handle >= 0x900);
+}
+
 static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct urb *urb;
@@ -4361,6 +4372,9 @@ static int btusb_probe(struct usb_interface *intf,
 		/* Override the rx handlers */
 		data->recv_event = btintel_recv_event;
 		data->recv_bulk = btusb_recv_bulk_intel;
+
+		/* Override for ISO data packet*/
+		data->is_iso_data_pkt = btusb_is_iso_data_pkt_intel;
 	} else if (id->driver_info & BTUSB_REALTEK) {
 		/* Allocate extra space for Realtek device */
 		priv_size += sizeof(struct btrealtek_data);
-- 
2.45.1.288.g0e0cd299f1-goog


