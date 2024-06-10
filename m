Return-Path: <linux-kernel+bounces-207944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC277901E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4447C1F24BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050327B3E5;
	Mon, 10 Jun 2024 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVqkiSpH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7AF77F1B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011933; cv=none; b=JBsnfuBw+TYIrxAXCPHzJKy7HHjcvzm1vUnjeUcL6u2Y2CA3ZrQjfqSlQiqwSB3lv/DC3XxrouGj4mYBGw38zloIfzVR6Ox0MN4q0igFXdbfJtZRAEtafKcb1WxmtHjEim3oLWp64PxlBe24Iri9QkBReDIxrj/lwX2zw/qTRh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011933; c=relaxed/simple;
	bh=i/wwwpIUQNPto8+tty9E05yTd9y0taZqALuDGbqx1SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7pmGTXXVN2Ym/Ltc4vt8KubgWXhaHtsoSjCQqw15lcvd5sS+DhlPj5kh2EYACMLWUpDPo+RfaJMz+R6zbrlM4OfVhsn5vJwMKbNoWok09pdunVs5R6+W61gU+MLItdgDg4YWGXytzjau5akLn0eUEcRoObgUELAv4fQC8dJ1oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cVqkiSpH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h8U3rxW1s1YIVMSUu9ZuPsxLMiEiJVd/mP29b/0kZtc=;
	b=cVqkiSpH3AghjZkuWssN/RhXHQaFQgku5swbzO34OtcNGRDsrS60ITKP3yJcM5JnMCRkLH
	RrxVb8yCFO1vxwRutBYrrCBNddZuMHjteIHlYuClWO4AtTeRIKgC0Ylyc9CIm67hlLiEdU
	Jw+ggabYXWBXfhWoZYrGPO2lApqiWpE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-9J6jWQKxOT-JkKM9iOoWCw-1; Mon, 10 Jun 2024 05:32:08 -0400
X-MC-Unique: 9J6jWQKxOT-JkKM9iOoWCw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4218118d1efso1915215e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 02:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011927; x=1718616727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8U3rxW1s1YIVMSUu9ZuPsxLMiEiJVd/mP29b/0kZtc=;
        b=OxEd4vg3oMxzitC/wWwx+jv+JnFkv1KxrLdUtjR8qWAIfiC4c9xwgDOkIJt5Srj4sd
         35gEGU+PfWWpvd2lu91MIwKamYMu9HNZBaFRVezkSSIzXIRfW9U2N4l2hgHSqkPNcbfU
         lhfh1Lgld4SZ3PkkLrrHGcN5hELXe0bQCLirs2JSSYbhqNfB0mWRefgfmRjwo+CD7/bk
         PKdzRDb4jaEOKFDnAUgD+aY3bCKx+As/YM9XmqZVutjPv5tcImRc1PWRa729xGKdzG3r
         y5m0dBPtDbsOVAPDUNjcM3XIDYCdYYAc+lD/LK+0FlIbKjT10o9daJb/ATakAgzOKGSW
         JGhg==
X-Forwarded-Encrypted: i=1; AJvYcCUKxVM8HH+/3B0l2BFICZ4IDw//P8q5kzhBC1oIRF1QoMwA2qgfoV3r9g/cNoaiPe2cVWXkP90oV/f9Bk9Mh/WFC7ScgI0823ohKd1J
X-Gm-Message-State: AOJu0Yxtm7uF1WllJjRV5IdEW+i5uVd3PIkxlwRIYMXZjZxO94OLC5ux
	EeubC+CzB17naFH5HWIqyoIwOYBGjbnm6R/KnzQSxCLy1ycm4QWopPlEXVLKedlMXRs2ABHwiX6
	84vJRxQyW3zd5vnxQxdAF9DhSnPKSEiSDy6qEVTkE/UK28m3ngM9G7KuvZlkEqg==
X-Received: by 2002:a5d:5988:0:b0:35f:1b2f:8697 with SMTP id ffacd0b85a97d-35f1b2f890amr3471332f8f.1.1718011927086;
        Mon, 10 Jun 2024 02:32:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqdCkgAR+1q+z4vuNJAhn568KdHv5oS6P7/Q9rNnLG+Le3g8tuihyGLjdodx7ImjfadRMULg==
X-Received: by 2002:a5d:5988:0:b0:35f:1b2f:8697 with SMTP id ffacd0b85a97d-35f1b2f890amr3471320f8f.1.1718011926842;
        Mon, 10 Jun 2024 02:32:06 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0ce4b62fsm7257545f8f.80.2024.06.10.02.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:32:06 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v8 07/13] PCI: Remove enabled status bit from pci_devres
Date: Mon, 10 Jun 2024 11:31:29 +0200
Message-ID: <20240610093149.20640-8-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240610093149.20640-1-pstanner@redhat.com>
References: <20240610093149.20640-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI devres implementation has a separate boolean to track whether a
device is enabled. However, that can easily be tracked through the
function pci_is_enabled() which is agnostic.

Using it allows for simplifying the PCI devres implementation.

Replace the separate 'enabled' status bit from struct pci_devres with
calls to pci_is_enabled() at the appropriate places.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 11 ++++-------
 drivers/pci/pci.c    |  6 ------
 drivers/pci/pci.h    |  1 -
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index f2a1250c0679..9d25940ce260 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -403,7 +403,7 @@ static void pcim_release(struct device *gendev, void *res)
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
-	if (this->enabled && !this->pinned)
+	if (pci_is_enabled(dev) && !this->pinned)
 		pci_disable_device(dev);
 }
 
@@ -446,14 +446,11 @@ int pcim_enable_device(struct pci_dev *pdev)
 	dr = get_pci_dr(pdev);
 	if (unlikely(!dr))
 		return -ENOMEM;
-	if (dr->enabled)
-		return 0;
 
 	rc = pci_enable_device(pdev);
-	if (!rc) {
+	if (!rc)
 		pdev->is_managed = 1;
-		dr->enabled = 1;
-	}
+
 	return rc;
 }
 EXPORT_SYMBOL(pcim_enable_device);
@@ -471,7 +468,7 @@ void pcim_pin_device(struct pci_dev *pdev)
 	struct pci_devres *dr;
 
 	dr = find_pci_dr(pdev);
-	WARN_ON(!dr || !dr->enabled);
+	WARN_ON(!dr || !pci_is_enabled(pdev));
 	if (dr)
 		dr->pinned = 1;
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5e4f377411ec..db2cc48f3d63 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2218,12 +2218,6 @@ void pci_disable_enabled_device(struct pci_dev *dev)
  */
 void pci_disable_device(struct pci_dev *dev)
 {
-	struct pci_devres *dr;
-
-	dr = find_pci_dr(dev);
-	if (dr)
-		dr->enabled = 0;
-
 	dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <= 0,
 		      "disabling already-disabled device");
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2403c5a0ff7a..d7f00b43b098 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -821,7 +821,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * then remove them from here.
  */
 struct pci_devres {
-	unsigned int enabled:1;
 	unsigned int pinned:1;
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
-- 
2.45.0


