Return-Path: <linux-kernel+bounces-444717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A25729F0B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E721641BD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390361DF73D;
	Fri, 13 Dec 2024 11:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZKrhVxWc"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A381DF279
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734090170; cv=none; b=fILmRQobN8g5/IVVJGz3nCJyTj1/SLiWsJgKHheKIEXpzG2SzkuFszcoCa9F3FKWuP41dk5kUbbl+jyObX6v9TGkDmIoAQwQwU/1vrrOtyBh+lr2Kk8uO/m89uE7V6/cHoxaSwzZpHFl6slytisIh5JdFhTtLLQSaALCkx2Qvc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734090170; c=relaxed/simple;
	bh=Uuj/H0UG/EJdiv2ODIr/5rKQ+AHjzW+e4hnjuT5aqFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=okgWAx6AEoFKhtgqk2XHAgj+0nVBhyXqkRIN4AtDm+esKS463mvVfB8I8ocMVCq+iV41V3LLRUGpoWO0uUZ/0/KPdIgMtgPdesbfY2MT822f32vXgMlEMJ9d/j6U8G/zYfZRm9DyovHG+DOKQY7MKOVgF4N4WFyZly3mIkeDdhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZKrhVxWc; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-728f337a921so1786032b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734090168; x=1734694968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nzXBeY/zx1suskgdf8fbpsAzoYK9okK//XYDozr9/c=;
        b=ZKrhVxWc7xrJb5RnxH2LnvcCb0T7v4dAJ/y3BSlpC0UuKP5I1HyQis2jTSzA1oTEeG
         cxyBo8qWyx7fUSiAaToZ2pAwBpmkIgIgI5tUdQoNvLa+2wTGXWnbCaKRGWrrT3UL7fij
         OkvclpX+0+9B73fTaQD6JtsXi4lr/GUpqCpgAGVyi466XxEvuGz5deQ0gUU7frEpxyza
         sdw1qUSUCym8aIpfppfwqRoKCs1ecHXbI1rTtZXZzLfyFn31arBITz/aDKWpsWMPfgni
         dnQS2NuIMzHGUHSDc/7ooeyz+MkBWKpaJEk2r7C9bx7bkcZsw+/fSjMtEwTpEZYvUMwg
         cazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734090168; x=1734694968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nzXBeY/zx1suskgdf8fbpsAzoYK9okK//XYDozr9/c=;
        b=stBK1v3BZRQDSAwrKeof8Q2gMbj6ph2aIyU8KZChVqlFehY6xPhR4tqYlN2D5sJTN+
         On4rc6UWC+kxPMgjf2N1LejKxiP4bS9qxcmNzZQIUATwa5k34KA/MqeZMuwvGumHHdV+
         QX23LtrdWKULktjp3Dr36b4L/C+57QyX2e8ygTu+13urb4jQf5a/9uichWRDGunOxH5/
         ETsveMC0XKzWOfmLL4AeSUyz3p2mGibyI4mXLPItOP7hPlm3/Q9tL1VrWDPQe0fPzZTO
         NRttK02G1CaC8oPpYiy3CnqAYvDbO5uClSvxXgP7g+nxlikXRts2kRFUuBa3jeLkBCp5
         kQmw==
X-Forwarded-Encrypted: i=1; AJvYcCVBaMy8w60UIrKmpR5JTyjp2vweZGwEhBIW/SB0OOHNAksOWhFYKpUBzAy+riil6ow/5ahXQnOZthgZfqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7DJJKrFj0XMKxRMsGxlTMSglYAJAV0hMRuXwRZlE3z/VURTn/
	b7lx7Vjlw96bnYJ68k34GTJaXLvgZdsDhj1glt7XBSYsikQFg4PrvIFVu+OLAPA=
X-Gm-Gg: ASbGncvtCw8qYxdFJ3m6RfXTX9eYkCBTSiWJhw29jS4WpQCYUPib4+IV5Z/BicA9IAp
	qixpwAgp2FFiylGyeDPcJ3FryiYzdr2AdvzrPIMW3eAofd6Fu11BDQXPrIs9+knK7lJCRZUo4LM
	nbqD2ApRTijlNIp30VpfQtsxGWK0RnIUpHlvRUbdAXYY+dCKMM9/4Vi3I8MgN5gbAmScfz79tgW
	aYGckbjk6oDQ7MZZB5XX2rIiwZIUgrmHd0s2mp16orwu2KC58V4NPLyek2ftkjNdYzaxlu4C2KF
	05I7zXnJeHFbkFtEdukpbRyt88R3l37Dw0CbLFo=
X-Google-Smtp-Source: AGHT+IHchEZVi5a6A4EscQE7riigGZANnu99XJHe62AE6HVH8l0CdHEKKzwg+sAunEM97R10zLGscQ==
X-Received: by 2002:a05:6a20:2446:b0:1db:ec3e:c959 with SMTP id adf61e73a8af0-1e1dfd3d5c8mr4085521637.10.1734090168101;
        Fri, 13 Dec 2024 03:42:48 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4b961f1asm8666340a12.30.2024.12.13.03.42.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Dec 2024 03:42:47 -0800 (PST)
From: Xu Lu <luxu.kernel@bytedance.com>
To: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org
Cc: lihangjing@bytedance.com,
	xieyongji@bytedance.com,
	guojinhui.liam@bytedance.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH 2/2] iommu/riscv: Add shutdown function for iommu driver
Date: Fri, 13 Dec 2024 19:42:33 +0800
Message-Id: <20241213114233.12388-3-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213114233.12388-1-luxu.kernel@bytedance.com>
References: <20241213114233.12388-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit supplies shutdown callback for iommu pmu driver. The shutdown
callback resets necessary registers so that newly booted kernel can pass
riscv_iommu_init_check() after kexec. Also, the shutdown callback resets
iommu mode to bare instead of off so that new kernel can still use PCIE
devices even when CONFIG_RISCV_IOMMU is not enabled.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 drivers/iommu/riscv/iommu-pci.c      | 8 ++++++++
 drivers/iommu/riscv/iommu-platform.c | 6 ++++++
 drivers/iommu/riscv/iommu.c          | 6 ++++--
 drivers/iommu/riscv/iommu.h          | 1 +
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-pci.c
index c7a89143014c..d82d2b00904c 100644
--- a/drivers/iommu/riscv/iommu-pci.c
+++ b/drivers/iommu/riscv/iommu-pci.c
@@ -101,6 +101,13 @@ static void riscv_iommu_pci_remove(struct pci_dev *pdev)
 	riscv_iommu_remove(iommu);
 }
 
+static void riscv_iommu_pci_shutdown(struct pci_dev *pdev)
+{
+	struct riscv_iommu_device *iommu = dev_get_drvdata(&pdev->dev);
+
+	riscv_iommu_disable(iommu);
+}
+
 static const struct pci_device_id riscv_iommu_pci_tbl[] = {
 	{PCI_VDEVICE(REDHAT, PCI_DEVICE_ID_REDHAT_RISCV_IOMMU), 0},
 	{PCI_VDEVICE(RIVOS, PCI_DEVICE_ID_RIVOS_RISCV_IOMMU_GA), 0},
@@ -112,6 +119,7 @@ static struct pci_driver riscv_iommu_pci_driver = {
 	.id_table = riscv_iommu_pci_tbl,
 	.probe = riscv_iommu_pci_probe,
 	.remove = riscv_iommu_pci_remove,
+	.shutdown = riscv_iommu_pci_shutdown,
 	.driver = {
 		.suppress_bind_attrs = true,
 	},
diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
index 382ba2841849..62c40b99cf62 100644
--- a/drivers/iommu/riscv/iommu-platform.c
+++ b/drivers/iommu/riscv/iommu-platform.c
@@ -74,6 +74,11 @@ static void riscv_iommu_platform_remove(struct platform_device *pdev)
 	riscv_iommu_remove(dev_get_drvdata(&pdev->dev));
 };
 
+static void riscv_iommu_platform_shutdown(struct platform_device *pdev)
+{
+	riscv_iommu_disable(dev_get_drvdata(&pdev->dev));
+};
+
 static const struct of_device_id riscv_iommu_of_match[] = {
 	{.compatible = "riscv,iommu",},
 	{},
@@ -82,6 +87,7 @@ static const struct of_device_id riscv_iommu_of_match[] = {
 static struct platform_driver riscv_iommu_platform_driver = {
 	.probe = riscv_iommu_platform_probe,
 	.remove = riscv_iommu_platform_remove,
+	.shutdown = riscv_iommu_platform_shutdown,
 	.driver = {
 		.name = "riscv,iommu",
 		.of_match_table = riscv_iommu_of_match,
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 84806724f568..670b4302aca8 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -651,9 +651,11 @@ static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iomm
  * This is best effort IOMMU translation shutdown flow.
  * Disable IOMMU without waiting for hardware response.
  */
-static void riscv_iommu_disable(struct riscv_iommu_device *iommu)
+void riscv_iommu_disable(struct riscv_iommu_device *iommu)
 {
-	riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_DDTP, 0);
+	riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_DDTP,
+			   FIELD_PREP(RISCV_IOMMU_DDTP_IOMMU_MODE,
+				      RISCV_IOMMU_DDTP_IOMMU_MODE_BARE));
 	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_CQCSR, 0);
 	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FQCSR, 0);
 	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_PQCSR, 0);
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index b1c4664542b4..46df79dd5495 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -64,6 +64,7 @@ struct riscv_iommu_device {
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu);
 void riscv_iommu_remove(struct riscv_iommu_device *iommu);
+void riscv_iommu_disable(struct riscv_iommu_device *iommu);
 
 #define riscv_iommu_readl(iommu, addr) \
 	readl_relaxed((iommu)->reg + (addr))
-- 
2.20.1


