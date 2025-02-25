Return-Path: <linux-kernel+bounces-531549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F360A441E7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996303B1713
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36E026A091;
	Tue, 25 Feb 2025 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b="FBk6w/H2"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F0D2686A8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492322; cv=none; b=cnR9NTcbMWOAsH5pQRirjNpNVr7vcKdJN/5irv/gjYNmpZyH0v2M+m5jx+lFFNvoI6vLqdKrsVGwtJ9g8/osgfWwyoesiaeQDJJ6chg9kV8hBA8/Jk6HZI32RZrrZFBL1Amt2cqq9lK+6teqcNr4DYZX3it/gr1+JY2WZR7kymU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492322; c=relaxed/simple;
	bh=gpcDjd2ys+1/GXZMy58GrQmGAViqOhk10U5APZI1bwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q5T0gEtFrgKyCW+XCbC+KurmmTl5yu8pp6I7Zy0UGpxEY8x+9DGNvYXg9pDfBm8WvjZk13p3f5YI62Mr4xHrudp0ygdVMnSpXVJWpOyOKz2Xcm7vO/ybORe/SL2ihsj4z0mK6+NugoUf/kpiWTcFsqvUlEPg6m+Cyy7yo4zivmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b=FBk6w/H2; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so10152872a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1740492317; x=1741097117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6461ban+1g2qu9SgG0oSTcJISIZ7Z8nL0LN7J32hL00=;
        b=FBk6w/H2hfu2V57tLOxoATVhBm2/Rjh59E4qy5NseJ6liU/IeqGAg3aoYxgiZE+OiO
         0p0mS50pR7gSrox6nNft5kNIk+B3YoV0OJ3m6wmBC4u5ljfpYdFI9hVrL7SXZpeN3X6+
         +T3AuG6yYcqKnS6XBrLvKJ+H9KKsft/cVAwZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740492317; x=1741097117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6461ban+1g2qu9SgG0oSTcJISIZ7Z8nL0LN7J32hL00=;
        b=VG8R/bXamRtemp7nlsqn/FYtQWbKHJ8RrRexfCObd6rH33uL8d0/Zcro9WP9kRMSOu
         B6rYd91biUr83JlLci7FuIN8ZQ6VsLeX9eKI8AiMn0XEJmbiRrjHRDeIsjSBKuXiHwfO
         L5Ddf3T7iHFz4ZknwmDCZS9C5byTDUpllhFGCHvRfO93KzUj7lqfZwYXsxmy2SP2/4Y0
         oUh3khM89ETf0DxQ6zkrj2cvPx0Bcm65ERNcR5FMxpNoi9u5tZ6KLu+6zr2AoQLopRMS
         koGeVgvM/7RAKN/FAornR8T2Cs/3Ee/ELdiA1IXxd2NBoiDBYSv/J4n2W2TCTUHDt3X7
         mRgw==
X-Forwarded-Encrypted: i=1; AJvYcCUlkYj32fe5AEndL4h4QRmB91DhiZIVaUuKonoE08zTGMai4XxEQC6rlRiOTPrkkKlIfTMi2SZKagmF1TA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDSsKNoZ61rGmE7cATYWt460yomaHN22/yKCOH6iai1JCOKURw
	Tg7g0S/WNFaZ209bBb+HJJ14W9rJID3nsCZ+YFupqOl4hPH88tYqN38IHbXyY+c=
X-Gm-Gg: ASbGncshlfJ+r/ZaM8PcV8zg0H+yOq9qc0OsxtLaWDg1l6FjthAxtQNNf0Wn7bRwcTU
	JHdVicRnLpyVaUmcyqp3N14xEWy6eAbW4/j0Wj4WBCemikzcflD0RdOkY59UDdi1cmTii9TFbhO
	y5CPNISnJqFi2l0aGx0kWSrfuWI8mrtfb5WuT01F/wPICAhgO1K6bc2ay02Jx7RuWeIvSEv50Ry
	GGdI9EbP+jEadGPDhGXPbwtemFt/yV80Yu/56NEB380saE9FmbKMv9+BuMKysYx1gCV5D1meNqA
	EJm80yHxkGvQEFHp2kS/BSZl1wWUq2twG8BocMGJyMVKRRfY4zJx8QkGO0L2RFcdVQ==
X-Google-Smtp-Source: AGHT+IF9aVZ271pd7Rivr+4PMLzSxl4QN0DdFXBiXSE8kbbx+f24AkB2D93JM67HV9at4+50ibsh4g==
X-Received: by 2002:a17:906:7950:b0:ab7:63fa:e4ab with SMTP id a640c23a62f3a-abc0cd0b6bamr1855443966b.0.1740492317294;
        Tue, 25 Feb 2025 06:05:17 -0800 (PST)
Received: from fziglio-xenia-fedora.eng.citrite.net ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cdbef5sm149367966b.14.2025.02.25.06.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:05:16 -0800 (PST)
From: Frediano Ziglio <frediano.ziglio@cloud.com>
To: xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Frediano Ziglio <frediano.ziglio@cloud.com>,
	"Juergen Gross" <jgross@suse.com>,
	"Stefano Stabellini" <sstabellini@kernel.org>,
	"Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>
Subject: [PATCH] xen: Add support for XenServer 6.1 platform device
Date: Tue, 25 Feb 2025 14:03:53 +0000
Message-ID: <20250225140400.23992-1-frediano.ziglio@cloud.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On XenServer on Windows machine a platform device with ID 2 instead of
1 is used.
This device is mainly identical to device 1 but due to some Windows
update behaviour it was decided to use a device with a different ID.
This causes compatibility issues with Linux which expects, if Xen
is detected, to find a Xen platform device (5853:0001) otherwise code
will crash due to some missing initialization (specifically grant
tables).
The device 2 is presented by Xapi adding device specification to
Qemu command line.

Signed-off-by: Frediano Ziglio <frediano.ziglio@cloud.com>
---
 drivers/xen/platform-pci.c | 2 ++
 include/linux/pci_ids.h    | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
index 544d3f9010b9..9cefc7d6bcba 100644
--- a/drivers/xen/platform-pci.c
+++ b/drivers/xen/platform-pci.c
@@ -174,6 +174,8 @@ static int platform_pci_probe(struct pci_dev *pdev,
 static const struct pci_device_id platform_pci_tbl[] = {
 	{PCI_VENDOR_ID_XEN, PCI_DEVICE_ID_XEN_PLATFORM,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_XEN, PCI_DEVICE_ID_XEN_PLATFORM_XS61,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{0,}
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 1a2594a38199..e4791fd97ee0 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3241,6 +3241,7 @@
 
 #define PCI_VENDOR_ID_XEN		0x5853
 #define PCI_DEVICE_ID_XEN_PLATFORM	0x0001
+#define PCI_DEVICE_ID_XEN_PLATFORM_XS61	0x0002
 
 #define PCI_VENDOR_ID_OCZ		0x1b85
 
-- 
2.48.1


