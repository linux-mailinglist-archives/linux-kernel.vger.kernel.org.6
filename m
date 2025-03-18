Return-Path: <linux-kernel+bounces-566838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFE3A67D26
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D64C17689F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192051DFDAE;
	Tue, 18 Mar 2025 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="cqAATSHo"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD8E1C07C4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742326281; cv=none; b=uRgzYpvdb3kGNkGBpDzl0XcTTY0kULg2lm3WVEazZ43eGy3h2s5d0GfppOwKdeImwG53PsVc9BoGkioBci0c2r6kAJGYybrdxOKyKVOXlPBs0WFE5ax1t3gnZHamOshXu9QTiqQt6FMZM7ZAZpMTGStwMOyleCRA8CBYOmrFbsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742326281; c=relaxed/simple;
	bh=8R6ZQnF5TaGduHp9FkjQSdRTu3vXK+o2LlA8IQPT0EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CZ3AH9wI31HnZgzpSuGtyeeluobq06miNXEJsoxRw+FUzC8r72d8Vt7uVqjMmri6p6aZeZ06s9X7YRy9c4YAwHk9qvDtuO6+bHWjqtL7dKznMaxASsNzvSyWB3MczvCqmuQgqvchXQq9/88KhTNNKbVXuZDTBk2a8l5c/RlQ8mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=cqAATSHo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2239c066347so129855455ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1742326279; x=1742931079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=19z1Kk5mXf9SmqNPxTrWbr2dcMvFexRCx2f5g7HF46k=;
        b=cqAATSHo2mupXdxRugyRdtSNgr8lQTJSMzgWMIIc/G66+FYwQjRstz82ZJV5S6kXLS
         FFBwq+tPFCdJfJAmHHqydTPArvlftSGiKvodQFBSaDpjq8dAQeLnxw0UnutvtgCxMob8
         fOQ4ihPcDQN0kvfXIFmNmf5moPFjRQ0oaGjY5mx1LV7MB21XOxW9GH1oGLxCgPfsv9/d
         OzeCJ+eeLEdp4eoYVtgwY92tzecX67B+xCXd+OHeDtlYQ89AI0Hagdul80pj4Qz7BO0L
         aVBhlWIwWwsHL8PkzCR9UusYx/T/7td0rCA2yWfH9wIJk2u/u/NAgLpCfVaoh731kT9Z
         +WgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742326279; x=1742931079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19z1Kk5mXf9SmqNPxTrWbr2dcMvFexRCx2f5g7HF46k=;
        b=A/dU/BM3ZfgIdeezWzwwgbgZ03tyRuIReogMFwaS2XrIJXYM91xuvFt/6iP3n0Jiqh
         +6N3L233Ed49kIrpJYMbHY2hsM+etzFdKsCnwRpdTVhYk+7pFxK1x75E4U90yflGnaq+
         XtH6JlNgapgq4AH3XTvZOPswoZ5+vNQMS74BLuzYhXM1uyiridMB3W+dxi33DuASRx/K
         heUizpCsGwhMIrGncjOh6dYYO/+NIfbWqyn9LfOnH8zlTH1LlUESuPynY1UthMoJy0IH
         9QmqK7259o0XrYWSQjU8rUVluwMXlCbHUoUvEfM3hVbZG8Z8YHyWBrafC5uc5m9zSFvt
         v1/Q==
X-Gm-Message-State: AOJu0Ywq5f/nk2nGN23ONaI0WEJ+XbX1NFMNuGCTsR7/Ve7wHKzbYqji
	vtw33JN3I0Zbww+q/2skmeJN32+RpsvzIoZJ1bDn1F15OfqyjWFXRIi+pvJslYFUDNQzr+ZHC0J
	cMzs=
X-Gm-Gg: ASbGncvh+8AIFrVvPKxH6ussBhKq8GzovnmPxcZUsa+ft05Kbie1LM8FycWvuQaHApe
	0rxKwkuEbCeHmn/IoJx7ebxDT/kDrVCxq/1+w4NdhNJMc7VLkZ78+xCHS+Sd5p+j8QFaxAOL5vm
	SA5zHs6MBFyplhkHt7AiaSqjcK1QmJ011jzOPzbp4omCZv1w26SdemETPgVY/+MgmtBvzzJ4q3K
	zM7FlYjYpW+GzEzAQGNwNlHlV53ogfk4nHsK1IdrBVLn3Rokmidoxawd48h++c5bg8hM39JE7g4
	2zPs0w3B7qoI7n2gp551+djNtbEy4a9ye8hE/HxJKzOAWuY=
X-Google-Smtp-Source: AGHT+IGtg/Gus/fPA/C0wTqoGIQvSoUpP0NE5t1Cbk1OIUeB6Lmwk6dhW0m3CZ42u0xM6Wx6yXDp7A==
X-Received: by 2002:a17:90b:4c45:b0:2ee:d63f:d73 with SMTP id 98e67ed59e1d1-301b9fcbbc1mr589133a91.11.1742326278694;
        Tue, 18 Mar 2025 12:31:18 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:4680:a100:1c4a:720d:c0fa:efac])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3015363217dsm8638407a91.32.2025.03.18.12.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 12:31:18 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Neeraj Kale <neeraj.sanjaykale@nxp.com>,
	linux-bluetooth@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH][QUESTION] bluetooth: Remove duplicated h4_recv_buf() in header
Date: Tue, 18 Mar 2025 12:31:12 -0700
Message-ID: <2b612e2c1f4fa697b47b5dd9b72f1949d7c206f5.1742324401.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello all,

In the course of other debugging, I've discovered that h4_recv_buf() is
almost completely duplicated in an inline header definiton, and I don't
understand why.

I'd like to clean this up: see the patch below for an explanation.

Does anybody who was around at the time remember any more details about
this? Or failing that, perhaps somebody with access to the bpa10x
hardware can test it with the core function?

Thanks,
Calvin

---8<---
From: Calvin Owens <calvin@wbinvd.org>
Subject: [PATCH] bluetooth: Remove duplicated h4_recv_buf() in header

The "h4_recv.h" header contains a duplicate h4_recv_buf() that is nearly
but not quite identical to the h4_recv_buf() in hci_h4.c.

This duplicated header was added in commit 07eb96a5a7b0 ("Bluetooth:
bpa10x: Use separate h4_recv_buf helper"). Unfortunately, there was no
discussion about it on the list at the time:

    https://lore.kernel.org/all/20180320181855.37297-1-marcel@holtmann.org/
    https://lore.kernel.org/all/20180324091954.73229-2-marcel@holtmann.org/

This is the diff between the two implementations as they exist today:

    --- /home/calvinow/orig.c	2025-03-10 14:43:18.383882623 -0700
    +++ /home/calvinow/copy.c	2025-03-10 14:42:57.109953576 -0700
    @@ -1,117 +1,100 @@
     {
    -	struct hci_uart *hu = hci_get_drvdata(hdev);
    -	u8 alignment = hu->alignment ? hu->alignment : 1;
    -
     	/* Check for error from previous call */
     	if (IS_ERR(skb))
     		skb = NULL;

     	while (count) {
     		int i, len;

    -		/* remove padding bytes from buffer */
    -		for (; hu->padding && count > 0; hu->padding--) {
    -			count--;
    -			buffer++;
    -		}
    -		if (!count)
    -			break;
    -
     		if (!skb) {
     			for (i = 0; i < pkts_count; i++) {
     				if (buffer[0] != (&pkts[i])->type)
     					continue;

     				skb = bt_skb_alloc((&pkts[i])->maxlen,
     						   GFP_ATOMIC);
     				if (!skb)
     					return ERR_PTR(-ENOMEM);

     				hci_skb_pkt_type(skb) = (&pkts[i])->type;
     				hci_skb_expect(skb) = (&pkts[i])->hlen;
     				break;
     			}

     			/* Check for invalid packet type */
     			if (!skb)
     				return ERR_PTR(-EILSEQ);

     			count -= 1;
     			buffer += 1;
     		}

     		len = min_t(uint, hci_skb_expect(skb) - skb->len, count);
     		skb_put_data(skb, buffer, len);

     		count -= len;
     		buffer += len;

     		/* Check for partial packet */
     		if (skb->len < hci_skb_expect(skb))
     			continue;

     		for (i = 0; i < pkts_count; i++) {
     			if (hci_skb_pkt_type(skb) == (&pkts[i])->type)
     				break;
     		}

     		if (i >= pkts_count) {
     			kfree_skb(skb);
     			return ERR_PTR(-EILSEQ);
     		}

     		if (skb->len == (&pkts[i])->hlen) {
     			u16 dlen;

     			switch ((&pkts[i])->lsize) {
     			case 0:
     				/* No variable data length */
     				dlen = 0;
     				break;
     			case 1:
     				/* Single octet variable length */
     				dlen = skb->data[(&pkts[i])->loff];
     				hci_skb_expect(skb) += dlen;

     				if (skb_tailroom(skb) < dlen) {
     					kfree_skb(skb);
     					return ERR_PTR(-EMSGSIZE);
     				}
     				break;
     			case 2:
     				/* Double octet variable length */
     				dlen = get_unaligned_le16(skb->data +
     							  (&pkts[i])->loff);
     				hci_skb_expect(skb) += dlen;

     				if (skb_tailroom(skb) < dlen) {
     					kfree_skb(skb);
     					return ERR_PTR(-EMSGSIZE);
     				}
     				break;
     			default:
     				/* Unsupported variable length */
     				kfree_skb(skb);
     				return ERR_PTR(-EILSEQ);
     			}

     			if (!dlen) {
    -				hu->padding = (skb->len + 1) % alignment;
    -				hu->padding = (alignment - hu->padding) % alignment;
    -
     				/* No more data, complete frame */
     				(&pkts[i])->recv(hdev, skb);
     				skb = NULL;
     			}
     		} else {
    -			hu->padding = (skb->len + 1) % alignment;
    -			hu->padding = (alignment - hu->padding) % alignment;
    -
     			/* Complete frame */
     			(&pkts[i])->recv(hdev, skb);
     			skb = NULL;
     		}
     	}

     	return skb;
     }

It seems fairly obvious from the above that, if alignment is one,
hu->padding is always zero, and in that case the two functions behave
strictly identically.

Since that is the case for every driver except hci_nokia, clean this up
and let them use the core function. I've done some light testing on
btnxpuart, so far everything seems to work.

I would love to eliminate the duplicate function entirely, but I don't
have access to hardware for bpa10x. Since bpa10x breaking was the
original justification for the change, I've left it there for now. I'm
hoping somebody else can shed more light on this.

Cc: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 drivers/bluetooth/btmtksdio.c | 2 +-
 drivers/bluetooth/btmtkuart.c | 2 +-
 drivers/bluetooth/btnxpuart.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index bd5464bde174..47d1073fb4a4 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -29,7 +29,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-#include "h4_recv.h"
+#include "hci_uart.h"
 #include "btmtk.h"
 
 #define VERSION "0.1"
diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index c97e260fcb0c..aeb111a0f242 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -27,7 +27,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-#include "h4_recv.h"
+#include "hci_uart.h"
 #include "btmtk.h"
 
 #define VERSION "0.2"
diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index aa5ec1d444a9..e6db563088cb 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -21,7 +21,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-#include "h4_recv.h"
+#include "hci_uart.h"
 
 #define MANUFACTURER_NXP		37
 
-- 
2.47.2


