Return-Path: <linux-kernel+bounces-379776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2182E9AE382
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87931F235E7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F75F1C303D;
	Thu, 24 Oct 2024 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xr4jviHd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C7F13B7BE
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729768534; cv=none; b=Hj7Uc3eTcccDn5njXBkS2WMjGpgvbVIozd9EQXwPFHcouxkxZ+LbD1VzOCRftU5atxOOUnPR2EhDi7igXNhCgKZnroSnAeUoKfO6JeWHYzI9aedee6IWeQF9UTqwWeXor/GczFi3Fx9fG+SQ/rMiJzfuK+LmUXdtv9dw5NSPAh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729768534; c=relaxed/simple;
	bh=LbyJrbFBQQwsnJhzlm2fAxSCJ5shFnzseaGpYCMyBdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DlPZJkW32HKQuvJZH5lI3+DbduMl/k3XR3hRK2UPLdd57EjiC8wNw5SDaes/kCxfAvP6y4DPOm1pmNlTkBauSmU4YfWNMppzl98KmPfn4uQnWGw1W9kBfkfkQ8cEFqappc849HuUBYiP0QcHbW2uQnf0XJiQ0Z036OW0BX8og7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xr4jviHd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729768531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZcD0uxvbX17gHxhLCYVZskTy/pTkc7ho3r1T0gSW30M=;
	b=Xr4jviHdl1K29mrJaxWsR6XyiCy++Q3QyqyeqNpZfpfDjBvlwipzV+tvvu/nhVmD97OCKt
	DDD4w+WEYZ3XPQoA3JervwiteDlOEZ02UWsWeCu03jJM7EButnxY7GpZArP4022h0kao4+
	9CNl6LKWIEyo3XuEw6gbWNAnccMJ9yc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-EFxm1OxcOO2CCJLl8p-ueQ-1; Thu, 24 Oct 2024 07:15:30 -0400
X-MC-Unique: EFxm1OxcOO2CCJLl8p-ueQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-431518e6d8fso6166535e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 04:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729768529; x=1730373329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcD0uxvbX17gHxhLCYVZskTy/pTkc7ho3r1T0gSW30M=;
        b=e3j/IKxLAAR9gBUiULeDy1gulJ61hVG4hnalwwBcbu3cJAtWckOsCb4ScXZ/Xtti7R
         c+j/x8AQCFj6JBA5EDDiwTlnK95fUChAvsnF84Vy65VyjIBjyHjh7EyG3gPsycpngqf/
         iZp2TezkXdlE/YC9ZBgkLeXe0XhYPM1xkeiJJhn1Cf+G+Swsi4m6U6zOhnOQdDqIWgrw
         6E4FpLzr5tZR1OexqLy30iFTN8i90XUA3i+/CYzml6HdLzKVZBpEoxevMrn067wB1ORu
         y1xiEQp4JwQuzZJSsD0XuFA3xyNLcai1LmW29gW0Xksu8l+4WS/e7ddhS/CvX9gKljAB
         FiOA==
X-Forwarded-Encrypted: i=1; AJvYcCWAYNBjeqRQInjDZ1044RdGGfl6jAQWUpn+UKhSkjqoIJIzYnCcY1JQN+P9WDDsN5LA2GTABWQ/TMedyzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YylV+kQGcRfb/7oX58YmuBR/wnFHXPO2KZfrXXufM53rjR4AsvO
	BD0OM1+SQWmOENWS2WYXYR9/XeMLIrd+deJiOrQE8ogUCSPyX50N+yZiAhp4m+2ayGpTFmBIxeE
	GOFuMOYE3KvNpXLunT24tpV9Emy2dm6PVLkB3Fm2qjoS1y+MFZv8bxtducxT3lw==
X-Received: by 2002:a05:600c:4f8a:b0:431:5c7b:e937 with SMTP id 5b1f17b1804b1-431842098d7mr54029625e9.17.1729768529105;
        Thu, 24 Oct 2024 04:15:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4lGBuiPVHcC5oJh2lUfp5HskjnJMUrYWLXg79bwTqyKfOsPQfJ6gH5Krl/n24cJflvqJeuA==
X-Received: by 2002:a05:600c:4f8a:b0:431:5c7b:e937 with SMTP id 5b1f17b1804b1-431842098d7mr54029395e9.17.1729768528776;
        Thu, 24 Oct 2024 04:15:28 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b567977sm14147105e9.27.2024.10.24.04.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 04:15:28 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] Bluetooth: btintel_pcie: Replace deprecated PCI functions
Date: Thu, 24 Oct 2024 13:15:10 +0200
Message-ID: <20241024111509.141884-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_regions() and pcim_iomap_table() have been deprecated in
commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()").

Replace these functions with pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/bluetooth/btintel_pcie.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 5252125b003f..d62a84bc1793 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -734,13 +734,9 @@ static int btintel_pcie_config_pcie(struct pci_dev *pdev,
 			return err;
 	}
 
-	err = pcim_iomap_regions(pdev, BIT(0), KBUILD_MODNAME);
-	if (err)
-		return err;
-
-	data->base_addr = pcim_iomap_table(pdev)[0];
-	if (!data->base_addr)
-		return -ENODEV;
+	data->base_addr = pcim_iomap_region(pdev, 0, KBUILD_MODNAME);
+	if (IS_ERR(data->base_addr))
+		return PTR_ERR(data->base_addr);
 
 	err = btintel_pcie_setup_irq(data);
 	if (err)
-- 
2.47.0


