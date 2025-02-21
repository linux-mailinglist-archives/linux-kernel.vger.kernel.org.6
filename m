Return-Path: <linux-kernel+bounces-526333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B912BA3FD56
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52DA4188C732
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385EE2505BC;
	Fri, 21 Feb 2025 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+K7QubG"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E9D2500CE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158604; cv=none; b=GhVWVLlUxx18hDmL/9MDSHJAlgD9J6YM1CLLbC+iLVixGWNE12gwEnSUCj0gXpg70jMKBV6UbLdLDVl08MEEqWdCUOVHIMMuWLYuaSRJP6/FdjrSuE3y1GCZPOJsHZmwoUOXWmDiN/3PBxF2bHNVhuqMuBt2P+2mV3JuKFZP+gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158604; c=relaxed/simple;
	bh=TvvuaEdFtU9UqfsZC6JoSCudSB2FfcZqsrRdClTssfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z6RjuANmVugDsIF3fOeA+wCNpN2WhZWandur7tVea+XK4C6s7PyQTDHKTOVgUAQPENX4JRztiQ71z9yL+xFQU2aZOh8Rqb1K/gbo7mw4u/mLWxrEgFqGTu2kKvF1ScVubdiYaZYyNsG1DPLxTn3dL3cutUjxI/A1rx++fwwcArY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P+K7QubG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220d132f16dso38811635ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740158602; x=1740763402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ob+IAIS3PcMsuG9oa1uTykNVP/mdisbkDjZEDx6eRLA=;
        b=P+K7QubGh6OsSxzeCkvWAJZSp/HffcG1JJSkpNWSJ+NP1AObC42IkEc50p4O7o23Fv
         1Un+21FJHXOopihnDlEVCgGTxLDv6yFiSIrV43zFYfSQ9h5l7QxkJiMR8437V7OsfViI
         u1RvSxKsDtj5RjlmT7XuSmRsy7Uab0sx3ZDjdSkfZgbhO5nHvRGXWX2ZeL1YgHc/79J5
         cmb6QFSdmT5q5v6JDbhJLrXKgmyQ1yEYlHIC8VBbpBJbYEvEWVn+NX/48DC12YHeWepz
         cdWio32VJ8SRFl+YsS7RMmVAi2EIgbqwOVETKfI1jtw6BUwaTDKhulGk+fcQly+ewci1
         8XjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740158602; x=1740763402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ob+IAIS3PcMsuG9oa1uTykNVP/mdisbkDjZEDx6eRLA=;
        b=XchiZcDOnXrfn9PdSSr63jAUr/quOSecyIudFReKsXfDSqzrfa/vwaf+fhu2jcZym5
         HJFly3s6Ut/yAuZ9LHreVndd/mIlqWpn2UwJDgfW7+YWF3Q+xItAka5H163aAgUncppA
         t5DttnQBZY/wXBUHaGCoygNvMqccm5FUYonVLfNgdU0Zge2uoK5HLLyYgQJRKycqt9wV
         tieosAfYp/Yv7sdt0TKQeRX9zuYQyKXhijPlTh5ur16RPWABde8hIf7F5wBpz6B1m4hz
         PrCY/vDpDUV1xJb7EMUbRzhf1n8AT2Ps4sR5XbiLtpXUt4DDPs8Ff2DnFa1mQZf56Z2g
         Y4Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWXZi+HbQLNxy/VvfUD9kbjkLTleRgOsyasKIfEsJjnTEjThBsTk6M1psLDWmR87mqnonHZ2I0c3nqms+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVC7KdB/CJUCNOl587+frdpMYMSYs0nhhgJnoITECJtO3MDuWt
	n8d9ONRpkIBdOIyPDqyUXzmB0Lki1o2Zdb5XyCOsz/gHpY0m/Db2ndnREn5BxPzDawrvV3fephM
	=
X-Gm-Gg: ASbGncu7S6v82DoHHQ0fl8D8980d0fbD3jJtYzWcCmsA7xRcgY70dwoWWiuCzdovzeh
	NJEbXwJmZXJaCpAUB9HL5XCNv+NqoannAcjXqRntmb3y9c7bC20HzMAKeQcohKQbqnCVeAEucnC
	/tl17lX6hZVJNfNU9r0mSNPyg6beuTy6PqB4aV39QuvHnTqKf5EFc+m2b6tWHVyNgFl2K4qpkjJ
	/jDtU6qi40MBrCvSKjfakRodK74lkyCtKSSwmNgxyAxJ7d+HCXGNShW27L64DTgOGspA6jIkuqk
	T2ebrJiHfuwzeldcEdwvMlTtlafqjftIEzM/KCuHa/vRfZhrmzel
X-Google-Smtp-Source: AGHT+IGzsgGWotdM0GJDHccBXJBXwgMMkAjpIS/G4maCwqsIVpwHx6wNGdibYi4vAESSIt/Gd8cCYQ==
X-Received: by 2002:a17:902:f712:b0:221:7e36:b13e with SMTP id d9443c01a7336-2219ff50d62mr80161515ad.12.1740158602264;
        Fri, 21 Feb 2025 09:23:22 -0800 (PST)
Received: from localhost.localdomain ([120.60.73.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c814sm141243405ad.148.2025.02.21.09.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:23:21 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dingwei@marvell.com,
	cassel@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] PCI: Add pci_host_bridge_handle_link_down() API to handle the PCI link down event
Date: Fri, 21 Feb 2025 22:53:08 +0530
Message-Id: <20250221172309.120009-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250221172309.120009-1-manivannan.sadhasivam@linaro.org>
References: <20250221172309.120009-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI link, when down, needs to be retrained to bring it back. But that
cannot be done in a generic way as link retrain procedure is specific to
host bridges. So add a new API pci_host_bridge_handle_link_down() that
could be called by the host bridge drivers when the link goes down.

The API will remove all the devices from the root bus since there is no way
the PCI core/drivers can access them and then calls the bus specific
'retrain_link()' callback if available. This callback is supposed to be
implemented by the host bridge drivers to retrain the link in a platform
specific way. Once that succeeds, the API will rescan the bus to bring the
devices back.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/probe.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/pci.h |  2 ++
 2 files changed, 36 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b6536ed599c3..36ffcd2a44a5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -706,6 +706,40 @@ void pci_free_host_bridge(struct pci_host_bridge *bridge)
 }
 EXPORT_SYMBOL(pci_free_host_bridge);
 
+void pci_host_bridge_handle_link_down(struct pci_host_bridge *bridge)
+{
+	struct pci_bus *bus = bridge->bus;
+	struct device *dev = &bridge->dev;
+	struct pci_dev *child, *tmp;
+	int ret;
+
+	pci_lock_rescan_remove();
+
+	/* Knock the devices off root bus since we cannot access them */
+	dev_warn(dev, "Removing devices from root bus due to link down\n");
+	list_for_each_entry_safe(child, tmp, &bus->devices, bus_list)
+		pci_stop_and_remove_bus_device(child);
+
+	/* Now retrain the link in a vendor specific way to bring it back */
+	if (bus->ops->retrain_link) {
+		dev_info(dev, "Starting link retraining\n");
+		ret = bus->ops->retrain_link(bus);
+		if (ret) {
+			dev_err(dev, "Failed to retrain the link\n");
+			pci_unlock_rescan_remove();
+			return;
+		}
+		dev_info(dev, "Link retraining completed\n");
+	} else {
+		dev_warn(dev, "retrain_link() callback not implemented!\n");
+	}
+
+	/* Finally, rescan the bus to bring the devices back */
+	pci_rescan_bus(bus);
+	pci_unlock_rescan_remove();
+}
+EXPORT_SYMBOL(pci_host_bridge_handle_link_down);
+
 /* Indexed by PCI_X_SSTATUS_FREQ (secondary bus mode and frequency) */
 static const unsigned char pcix_bus_speed[] = {
 	PCI_SPEED_UNKNOWN,		/* 0 */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..1c6f18a51bdd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -637,6 +637,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv);
 struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
 						   size_t priv);
 void pci_free_host_bridge(struct pci_host_bridge *bridge);
+void pci_host_bridge_handle_link_down(struct pci_host_bridge *bridge);
 struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
 
 void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
@@ -804,6 +805,7 @@ struct pci_ops {
 	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
+	int (*retrain_link)(struct pci_bus *bus);
 };
 
 /*
-- 
2.25.1


