Return-Path: <linux-kernel+bounces-514833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7997BA35C53
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38551189161E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE1C25D539;
	Fri, 14 Feb 2025 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PqwHWiSY"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7615A22837F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739531839; cv=none; b=QW/Gc7M8IR4xBHj/hmCmWTeYrjtzjN+HBbd9Y+h8G7gciP1X4ZEyRgD6gEBSfkohDsK4KSLye9lFVasHDOHQyrGk7Iu+xuLYs12l+eMvtoFeAoqkxt9pN4FfRh4eGjI3O8/Ak1wL1nUssqlKPH2aeMWBXTmjU+6g2CsO6GrLSC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739531839; c=relaxed/simple;
	bh=TTra3h9T0Q3NSgH3cSLC7VMf+o3j5WRDFH3X3lNLLQE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kAyOvzSfOW97JXopI2zdG+Dre7j7wAtrrHiv9K0JNRKT5gKEMsYzWZRwwpoRYpxMuf2z/kpgepD+zl13RDk4shYVN76saZL8e9ouVUYItG9fYCR3ZBlPeFWFwKW3SiLH0IxfU0II8nPZojWnmCBDAs9QKHlNwQtVHDCiF1l55AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PqwHWiSY; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220cb5924a4so65487115ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739531838; x=1740136638; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vyd6VZvnLXfIOMtoaeKKTr15aT2gyb+Vo6m831IpGOI=;
        b=PqwHWiSY8xe6zv3Tafq/1oNzaIH9AJuLMomrj7JQqefQOk4Frjpv8Mf63yBRoKtTJC
         w5/cBgXVaH2NPGrsXEz4P5HSJv6upFMhvAEb7JxikgmMSm0cu/koxk90lo4pdG+9add4
         A/o9DL8qorzReRWLdPj9adz+Af6ntW1kQFh6OHjYfAH4X5gNXVLnmg0wxCIQpXxMtxEp
         sjIS1IdAIx01kY9kaubB877ZVuIJU4WpUumDekN+ra1tShTyyPj9WfHDijnOY8qhFO1g
         GuSSMgLP9L4a8xP1otdpHwxrYoHfKvrFAJGOktQVB2K76DmDagL7z639xwEBNBzA5YRs
         n1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739531838; x=1740136638;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vyd6VZvnLXfIOMtoaeKKTr15aT2gyb+Vo6m831IpGOI=;
        b=jke2fP3hdZM8Flnume4pZfSG6I8Fdv5e+CDk0Co4Opv3ujC3Jzr2Orgwj20bkeGQGv
         vpDWGZFEwfKCUXnoSl8tOwNS8uaCarrt+JbK6Y/Xjfbai1cwviW1dJJU0a6Xxdz63Cwc
         wF3FNf8wLcp6v87OZcdEgWvYu8zWIu9gMvZKIXwVL67hDJlIFAQS5duOA5Pw75MUmPPD
         cULVhk/99z7oJ4xbPghidex3DdHD4tUIiN1cmuMSpVXJIKT3hTs77bIHdPVpZv2eEIVm
         fMKtFqeiKWzs639bTQhhadOTr1fM4wAcMnf41CZAUjC48SwwulvM/Ru5Z2uBskF8vi3x
         skXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd+Hmrq85pDOmK92wSZMCQL5tota/o/mWwndtTOJKdwLnWwrUrwSHusy4S6JqMsJm4iXA096KRYUBICQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNy4LTjOBGMR5dhKC6GS6byivX7b8pvQtZeIvik8mN07rXoftk
	uclg2V00/axFYnK52MGh6Viuq2SXuRVPlqqd5IVWWpe9IlcrdzCpBEP6pPNZ2VaPI4unwaycx0L
	gl2TGXg==
X-Google-Smtp-Source: AGHT+IFghr9P0HMIUaxBFgnQoWhw1CWBSpSlNf5DupB1nwEy99TDbtwc4wIvagfrECbSa84ztB7qdtZJJYLN
X-Received: from pgbbw41.prod.google.com ([2002:a05:6a02:4a9:b0:ad5:5920:367])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:8c6:b0:21f:617a:f1b2
 with SMTP id d9443c01a7336-220d21616famr121726985ad.46.1739531838030; Fri, 14
 Feb 2025 03:17:18 -0800 (PST)
Date: Fri, 14 Feb 2025 19:17:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250214191709.1.I6e9e94dcded65e4a9ed42ad23ca8a5d81f680382@changeid>
Subject: [PATCH] Bluetooth: Always allow SCO packets for user channel
From: Hsin-chen Chuang <chharry@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

The SCO packets from Bluetooth raw socket are now rejected because
hci_conn_num is left 0. This patch allows such the usecase to enable
the userspace SCO support.

Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

 drivers/bluetooth/btusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1caf7a071a73..de3fa725d210 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2130,7 +2130,8 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 		return submit_or_queue_tx_urb(hdev, urb);
 
 	case HCI_SCODATA_PKT:
-		if (hci_conn_num(hdev, SCO_LINK) < 1)
+		if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
+		    hci_conn_num(hdev, SCO_LINK) < 1)
 			return -ENODEV;
 
 		urb = alloc_isoc_urb(hdev, skb);
@@ -2604,7 +2605,8 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 		return submit_or_queue_tx_urb(hdev, urb);
 
 	case HCI_SCODATA_PKT:
-		if (hci_conn_num(hdev, SCO_LINK) < 1)
+		if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
+		    hci_conn_num(hdev, SCO_LINK) < 1)
 			return -ENODEV;
 
 		urb = alloc_isoc_urb(hdev, skb);
-- 
2.48.1.601.g30ceb7b040-goog


