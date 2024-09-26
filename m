Return-Path: <linux-kernel+bounces-340499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8398987433
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEE71C2125B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8B929D19;
	Thu, 26 Sep 2024 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="r46eVRZP"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CB1EAD5
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727356177; cv=none; b=KU3mqSEoQDRWiKww56+1PFtwrAonaz4o6J547f9vFO9gVky/OnUQsMA8SAZTlQargsYXo874tzpJekyuNy1QO0quzhzp9+/Z3yHmnKbNJJFOh81vfWmQzGtqQ87QZ2NRmXrdTfJ2qAJV8mYHCwSdrQVTaf1ctqODxkOnHx/UyFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727356177; c=relaxed/simple;
	bh=CaUFkRJKWaaKqA9MSqRJEqe3VnRZ8CyqyyW3qoMkx9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZpHh0vjzlA1PGBL5cEXYKOvFo9v31EQHYiiQqQs4autdIzlQielBFV7xZww2Twp9AKvhGiTwyrAgKmqIxIGWANExu3q44T21rXlkFdoBnHYxmbbX6Zp0f8D86nDAACKh03TMZjeWmAWs6fP7h/fssYeLip3HG6q06DHRRwrEOX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=r46eVRZP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso9203485e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727356173; x=1727960973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LGV+BX5NNyCiftaKgnNecXWQwtjbfWYcYZF3fnBBXYk=;
        b=r46eVRZP3dSKFfC8I2tP1G1kCOAIpGgNE7xIYmXacLhNTHMSoon0Nwania1x+M0b1r
         IH1wmWGY3wqwoB55rSmrRsMWOWjqWbFt1iQDBy6i6wnpg7ATs4p+FBhQ0E6Hfy768bCh
         5E3WVfX+k7CIcHhWleeuIYxyq3XEF9kVtJjiFi3Ai3kz0YecNYkzh4tVwuH0Bz1YzjiN
         7Gkd+9bgpPaXNTZhaarKxgNCOL219cmFIeQN3pYVJ0H2afQyRzuk0hC6YmfCM8g18DEh
         X1G6oc8Tj6KDJqJdqQj5yYifqRabeT5U7mboBg53ZJ13IT08ocPZAgpYxKnuvPyFZVNI
         Ek4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727356173; x=1727960973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LGV+BX5NNyCiftaKgnNecXWQwtjbfWYcYZF3fnBBXYk=;
        b=m1auFLft6FixZIsM1PB9r5X20NwfeS4o4RnA7wQKMQhRpDHNQC8EcL69fePXE8IhaM
         JpE4z2CmIU4SxnxZTJ1WyOhfqpA0OksHh1XX1yeeKpfk25j3GLimTkju/+QbeYSxt53+
         pFTtA2RoPzOSaYLKNs3rFvrFjixHnSW8G+Bx2J1LfjjCnQWPhZaCeIm5s/7KRJli0mRd
         oZq1WKq5OBMtqPU6wmjy/RUe4xwQE+D3CiVvvEq+O6KyQZuLDFdfJgsHuYlbU0Ka4Zzt
         dZ35X8xx+FzUYDhRcZJUx7kM9+vXwnghbntEeMGu21E93kIBBM3raS9QcHyS0GchGSVe
         GQKw==
X-Forwarded-Encrypted: i=1; AJvYcCX221viTpgYYtXRpoyIhG9jSAl9yyB2+PXvM4712vDGhcSLfbZn51se+NWFWLWMLi1tOogp7EXn2sZAZDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv1Oy4IZ5ur7FUDlZpk2bUY6kzDNnp3mJgF78UrTk/lCooFezD
	smfhpCv8P7h28wNdWWxZuDF1JgnNCeIvZF6PyHDrxUmdQHDCxdR2eW4jptfxjWM=
X-Google-Smtp-Source: AGHT+IEf86LLRp+GATfILRTa306z4YTyHtaIGF70cZQgBAcZdmzLeKQViClJ8kYsw67Qe/redspdrA==
X-Received: by 2002:a05:600c:35c3:b0:42c:b309:8d1a with SMTP id 5b1f17b1804b1-42e9610ba91mr40959295e9.13.1727356173028;
        Thu, 26 Sep 2024 06:09:33 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3ea0:4f4d:3a9f:2951])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a36760sm47109335e9.30.2024.09.26.06.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 06:09:32 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH] PCI: take the rescan lock when adding devices during host probe
Date: Thu, 26 Sep 2024 15:09:23 +0200
Message-ID: <20240926130924.36409-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Since adding the PCI power control code, we may end up with a race
between the pwrctl platform device rescanning the bus and the host
controller probe function. The latter needs to take the rescan lock when
adding devices or may crash.

Reported-by: Konrad Dybcio <konradybcio@kernel.org>
Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/probe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4f68414c3086..f1615805f5b0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3105,7 +3105,9 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 	list_for_each_entry(child, &bus->children, node)
 		pcie_bus_configure_settings(child);
 
+	pci_lock_rescan_remove();
 	pci_bus_add_devices(bus);
+	pci_unlock_rescan_remove();
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_host_probe);
-- 
2.30.2


