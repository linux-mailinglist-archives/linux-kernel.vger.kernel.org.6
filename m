Return-Path: <linux-kernel+bounces-250765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1121F92FC8F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C1F1C22190
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB610171E62;
	Fri, 12 Jul 2024 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="roNTJVle"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F5E171E49
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794564; cv=none; b=nB/FotVeCMhSGOD/+4wB98tYrlvzxq8R88bV8mnhzdgNhgtJqZjKdZ5EaEudIA8hVHPoDI+gRy3nFxtfKqe6qG4pcaKEhoA9qyR+Agp28IhQPG9+j2p7DtUuupYDF7RdUNE6hM1DaSePcpW6nQtkRy33ipY6kveGHw+pFlqRLgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794564; c=relaxed/simple;
	bh=LbTNChU8bTRD5sx7/n91xzehW9iyZBQZchWZoFuWKPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lVGpHKAUndv/pHhVCss19KE5A7D6TrLvtNDG0I0dkezsCKuTws1EZRyBQzffZaAsza7sSJlfI43T1OeffDuUZXFK59dEqFyE9EYwuf7a23c8bxZ9kF+HPUkzyARjeaa8gWzzIzEZx6iyUH7ckvBjnI06to8eoCO041LSXDrfdEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=roNTJVle; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so1381393a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720794562; x=1721399362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OfRcvqvyLWqqw4VZbdos3kGou0KYGp4KID6MEMi5E0s=;
        b=roNTJVlerqpbJkUY1MGAuKTk42El2peVPGbGYggrhIXI59s7T81VmDIyD6C7zRtuAy
         nIv6LPJykdimV0EhYa8UrncPzrEZXWH9SQQY46L2xj5rWvpNJzxdmf55JShgpH0tKxdF
         Khg8fs7MbGjD9sjckP7lRJJxBs+Tjsca7F4d06hMB6KvDxtZ9m8LyHJOt2qnd5FoFW3A
         DKLrDQmZ7nXxr4m8Nrki99Dbhhadr6D8nABdZCUiX33dpbEhSMR5nJKXRFpRq+gjUTGo
         YrDpLmhtvcn1Ow0wrp6aHAgfH9u/S5XaVqOZge09cXxTHh6XFAyQ6IZfERMu3XTmro88
         FeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720794562; x=1721399362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfRcvqvyLWqqw4VZbdos3kGou0KYGp4KID6MEMi5E0s=;
        b=pa8eqJ+6xfD+xrcBuvYwpuz0w4qpB/ruiH/fnF+8OMxZFdY0P30zF+2arOALEuU3tQ
         gP9pl/S95GjVGfLMP1a53WkEYy5heOiTALUvZg/7DUkJXCHpOWEU76BE9V3OtRytIlZb
         1664Z9CPoTO+wEDMLYyWdwm++/DuGl1xBwpcbeQuQ2IWEcl8avUfc0Rg+Sffrl18uHAO
         lmLM2/2UPUrWl2korBlrfrxFYktd/To4CYjPbgF0OUwSYLHXPL7glLU3gYLV3G0M6BAL
         2TFpY/Cfq97yEAUb044AogFAyekHplFDIWyfordZ3e1l5V1dFkvEzejbCiWvwkLzbFYW
         pGmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbyScT3KKwrxcIu4Gx87QOPslsPFthYXF3a+rR28Wp1PBbW8068jHFY0rHiaEyAGE5sYqq3mNI8iUuzz6TO1QmF3jkTONsbVUM15/V
X-Gm-Message-State: AOJu0YwKA1W7GCmDMC/nIGWlRCoB14/K1OkrIQZYHGU5KV7qnaI2X0U8
	0h4G/CrFuLYZQkCYmEvNKveBvZjMOke1tHei/K0nftNCnPVYAmcGWQIg2/Rbhg==
X-Google-Smtp-Source: AGHT+IHbEdR45IjDHcAMoLP6rDlFFdiSoFMz5LWcZABCTasJiEG5qGfVuq47Emz5imjJVxqZsw3w+A==
X-Received: by 2002:a05:6a20:cd0e:b0:1c2:8cc4:c361 with SMTP id adf61e73a8af0-1c2981fc191mr12859114637.10.1720794561783;
        Fri, 12 Jul 2024 07:29:21 -0700 (PDT)
Received: from localhost.localdomain ([120.60.61.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad141fsm67508075ad.277.2024.07.12.07.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:29:21 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: mst@redhat.com,
	jasowang@redhat.co
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	mie@igel.co.jp,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] virtio-pci: Add MSI support
Date: Fri, 12 Jul 2024 19:59:14 +0530
Message-Id: <20240712142914.16979-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Virtio spec has so far only supported MSI-X and INTX for receiving the
interrupts from the virtio device on PCI transport. But this becomes a
limiting factor for devices supporting only MSI (plus INTX emulation) as
they have to use the legacy INTX emulation which is limited to one IRQ per
PCIe function.

But this now addressed with the help of a proposal to the Virtio spec
adding MSI support [1]. Based on that, let's implement MSI support in the
virtio-pci driver.

The Virtio spec proposal reuses the existing MSI-X infrastructure, like the
config_msix_vector/queue_msix_vector fields of the Virito common config
structure. Following that, MSI support in virtio-pci driver is also added
on top of the existing MSI-X implementation and it mostly reuses the MSI-X
code base. The existing vp_find_vqs_msix() API is modified to support MSI
along with MSI-X.

The preference for interrupt allocation is still given to MSI-X as per the
spec. The driver will try to allocate MSI only if both of the MSI-X
allocations (one vector for each queue and 2 vectors) fails. As like MSI-X,
driver will try to allocate one MSI vector for each queue first, and if
that fails, it will try to allocate 2 vectors (one for config queue and one
shared for queues). If both of them fails, driver will fallback to the
legacy INTX as usual.

For keeping the changes minimal, existing 'virtio_pci_device::msix_enabled'
flag is used to indicate the status of MSI and MSI-X. Rest of the MSI-X
functionalities such as IRQ affinity are also reused for MSI (but the
affinity setting really depends on the underlying IRQCHIP controller).

[1] https://lore.kernel.org/virtio-comment/20240712140144.12066-1-manivannan.sadhasivam@linaro.org/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/virtio/virtio_pci_common.c | 24 ++++++++++++++++++------
 drivers/virtio/virtio_pci_common.h |  2 +-
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index f6b0b00e4599..6f80b0c46c5f 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -100,11 +100,11 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
 }
 
 static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
-				   bool per_vq_vectors, struct irq_affinity *desc)
+				   bool per_vq_vectors, struct irq_affinity *desc,
+				   unsigned int flags)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	const char *name = dev_name(&vp_dev->vdev.dev);
-	unsigned int flags = PCI_IRQ_MSIX;
 	unsigned int i, v;
 	int err = -ENOMEM;
 
@@ -288,7 +288,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 		struct virtqueue *vqs[], vq_callback_t *callbacks[],
 		const char * const names[], bool per_vq_vectors,
 		const bool *ctx,
-		struct irq_affinity *desc)
+		struct irq_affinity *desc, unsigned int flags)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	u16 msix_vec;
@@ -310,7 +310,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 	}
 
 	err = vp_request_msix_vectors(vdev, nvectors, per_vq_vectors,
-				      per_vq_vectors ? desc : NULL);
+				      per_vq_vectors ? desc : NULL, flags);
 	if (err)
 		goto error_find;
 
@@ -407,11 +407,23 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	int err;
 
 	/* Try MSI-X with one vector per queue. */
-	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx, desc);
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx,
+			       desc, PCI_IRQ_MSIX);
 	if (!err)
 		return 0;
 	/* Fallback: MSI-X with one vector for config, one shared for queues. */
-	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx,
+			       desc, PCI_IRQ_MSIX);
+	if (!err)
+		return 0;
+	/* Try MSI with one vector per queue. */
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx,
+			       desc, PCI_IRQ_MSI);
+	if (!err)
+		return 0;
+	/* Fallback: MSI with one vector for config, one shared for queues. */
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx,
+			       desc, PCI_IRQ_MSI);
 	if (!err)
 		return 0;
 	/* Is there an interrupt? If not give up. */
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 7fef52bee455..a5062ca85f3b 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -77,7 +77,7 @@ struct virtio_pci_device {
 
 	struct virtio_pci_admin_vq admin_vq;
 
-	/* MSI-X support */
+	/* MSI/MSI-X support */
 	int msix_enabled;
 	int intx_enabled;
 	cpumask_var_t *msix_affinity_masks;
-- 
2.25.1


