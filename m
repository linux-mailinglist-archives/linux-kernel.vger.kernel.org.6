Return-Path: <linux-kernel+bounces-350758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0E6990924
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3974D1C20D5D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4145C1C8772;
	Fri,  4 Oct 2024 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="N5MAvhXP"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8079E1C8784
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059316; cv=none; b=D+o6Y04VGMW4EOiYcXFlMSrExM+uchC9H2dTLS/or4nFEogW83ul8B1n+xhxGaF9dIllC4jgQ4s6i9g52WRvY8Y+7ICC9R3vV2C2OzqQbQGaKDUHmJVHvT8wI3CoQaHkKYUcHTJluPEQVtBYqQ+X+zWMWB6sNbEaXOy+mXkYkyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059316; c=relaxed/simple;
	bh=l7+/OOnbPo59NRdHU4hf39heIHqnVwgUybEyl/BT7zY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=joJFhnxfbyS7EOhOYneywdUeM1BKXGTWDueYMifaY2JKvKHQTPtvO7gTOy36+Grjpzz7oVB8mXKeZjpTLfFRHl8xO1Y/5hV+ep6z7ks984IEJJX4xB8DPdk/q0NOVpAyXoJ0JXvO1lcYk4l5cTRBFpmlpGVSxfUViQxJLK8uwbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=N5MAvhXP; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cb2f344dbbso17642226d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1728059312; x=1728664112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g9cpx8Hyi6dy6qO2dUhiRIRpdrteVAK0AMuAZrMnAe0=;
        b=N5MAvhXPocpXL+3MRnLl6U8seb48TXhzIBXVAGF6Z5WylKzfg0PGkMinuwXG8cdnS/
         raQH7qudNAX3v1B/9Qy3c5Hzk1i75y3HHgpVLDnNWTzg9pKA9hI91i9zbS8fkvBRzbhL
         yDmknpHxL8IoHp+fne7pCvc5KTG7wzoc234m6tS2ePyNmurrsfezA97BnnePodjMbDWY
         FXAPzWSJx+qYyc2kLa/btg7cqB4xWXJuLy6/a2AXezMquOZah862dfX8qAHQ8YRHztEU
         MHoIpaiotQi/NjTH3AnQxWKN+5riQplWeni+ontCtxV05YncNV4ObPO8IopM6J3olyTJ
         I2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728059312; x=1728664112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9cpx8Hyi6dy6qO2dUhiRIRpdrteVAK0AMuAZrMnAe0=;
        b=cJLH4y9Kdd+3hlYKlijXRaSEH2eEUXzuzR4rKXtT+i1nVlj5H50XQmrsTZmGSzO+rw
         8er8OxsXYKHyu+C6ob0knGKBG+Hy5YW3qdVytes/6rHVvoJ+dEExIeDBpARZt4kpeLC3
         +A2jNhL6WQY2tHIWzocawWycKFFnYUyzP8NhU60U4ZKalcDTuhNpDeh5wWzM4QZxiEAm
         z65Ry/4PU7IUNXWlSctpmA6rqhuoh2NBeUVdEBQDCoYV0AuEaLYruRCb/A1U0HnoECUY
         REw+/P12lNiuPZEsbsK6XMh+uoZHakf6TO3kH33BpU6giuOp1634velhyQHkxGtOwU0r
         HKrg==
X-Forwarded-Encrypted: i=1; AJvYcCXwSbV4YjNXFByySEBCq807mBFpa1BecnEbkW8+PLDaxwW/ZPSgrCq57CrLPeSfcP5TduM25KYVm/ZT6kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ4wsc0bGPT1OTwQ4ZdjQTaJUjNjzpHa9nIsqCtH6YA5C+XFDA
	U4WX2zbm08WOGh+lP4ovgR9Z+wd1ys1MzdOzzjtbpu+mNKxwZ7kYdfkZWQcq8n8=
X-Google-Smtp-Source: AGHT+IHCGTgu+cqiGiiZGFp3IkE06rob+xgV+iZNNZ8TyR776du/mFsmvAe7H6wEvrhSrVYdAin9FQ==
X-Received: by 2002:a05:6214:5504:b0:6cb:4a84:e02a with SMTP id 6a1803df08f44-6cb9a32d338mr50523826d6.16.1728059312390;
        Fri, 04 Oct 2024 09:28:32 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba4751920sm573476d6.98.2024.10.04.09.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 09:28:31 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-pci@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	dan.j.williams@intel.com,
	bhelgaas@google.com,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	vishal.l.verma@intel.com,
	Jonathan.Cameron@Huawei.com
Subject: [PATCH] PCI/DOE: Poll DOE Busy bit for up to 1 second in pci_doe_send_req
Date: Fri,  4 Oct 2024 12:28:28 -0400
Message-ID: <20241004162828.314-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During initial device probe, the PCI DOE busy bit for some CXL
devices may be left set for a longer period than expected by the
current driver logic. Despite local comments stating DOE Busy is
unlikely to be detected, it appears commonly specifically during
boot when CXL devices are being probed.

This was observed on a single socket AMD platform with 2 CXL memory
expanders attached to the single socket. It was not the case that
concurrent accesses were being made, as validated by monitoring
mailbox commands on the device side.

This behavior has been observed with multiple CXL memory expanders
from different vendors - so it appears unrelated to the model.

In all observed tests, only a small period of the retry window is
actually used - typically only a handful of loop iterations.

Polling on the PCI DOE Busy Bit for (at max) one PCI DOE timeout
interval (1 second), resolves this issues cleanly.

Per PCIe r6.2 sec 6.30.3, the DOE Busy Bit being cleared does not
raise an interrupt, so polling is the best option in this scenario.

Subsqeuent code in doe_statemachine_work and abort paths also wait
for up to 1 PCI DOE timeout interval, so this order of (potential)
additional delay is presumed acceptable.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/pci/doe.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 652d63df9d22..27ba5d281384 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -149,14 +149,26 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
 	size_t length, remainder;
 	u32 val;
 	int i;
+	unsigned long timeout_jiffies;
 
 	/*
 	 * Check the DOE busy bit is not set. If it is set, this could indicate
 	 * someone other than Linux (e.g. firmware) is using the mailbox. Note
 	 * it is expected that firmware and OS will negotiate access rights via
 	 * an, as yet to be defined, method.
+	 *
+	 * Wait up to one PCI_DOE_TIMEOUT period to allow the prior command to
+	 * finish. Otherwise, simply error out as unable to field the request.
+	 *
+	 * PCIe r6.2 sec 6.30.3 states no interrupt is raised when the DOE Busy
+	 * bit is cleared, so polling here is our best option for the moment.
 	 */
-	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
+	timeout_jiffies = jiffies + PCI_DOE_TIMEOUT;
+	do {
+		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
+	} while (FIELD_GET(PCI_DOE_STATUS_BUSY, val) &&
+		 !time_after(jiffies, timeout_jiffies));
+
 	if (FIELD_GET(PCI_DOE_STATUS_BUSY, val))
 		return -EBUSY;
 
-- 
2.43.0


