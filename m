Return-Path: <linux-kernel+bounces-315385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDFD96C1F6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5821C229AD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D93C1DCB02;
	Wed,  4 Sep 2024 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMJ+7bdC"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F93B1EC017
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462924; cv=none; b=FzpEhFIFdM27xTcEGp8rABo6XtjZMfuRjql9DF6gypKKaiLMlo0Vzt+zRB+vblv6f2Omg9jR+yLaTzzYKxyoM/9wSUhtoW3qSJ12/O3Xfwz/WBX4HzxZ0AhtbHEGZnIU6vwe3NNbwQ6wOpOGKDu7LYe+/95kVN4TRSYJCrvCVcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462924; c=relaxed/simple;
	bh=GvANVESAepCxBX9K+Wx1h4gON8fPCZilNiLIiJ+wFXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V+eQ/tV4k9Y68VLsVvKBgU71Vn2rzIiNamWcC+6c5sWszh/EJgEKhfBlV8ju5v2WzKgNlDiTThGQcucLcTDG17qlykV81vhRIAeW8qTzsl9oqzfI/BdbTgs4UdB4dsOhFVEgGXgjMYY4+Hqz0LtBqI+o128wu66pPRDeBlf/h8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMJ+7bdC; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-715e64ea7d1so5645345b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 08:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725462922; x=1726067722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7alryj2QRham+4+mog4UfLUrtU9/gcdbfUvdQj1l5TM=;
        b=TMJ+7bdCKPyMarq59oPGz3FO798iiKJJ8anPtwtKotaKA/aM6lXDlBi8DZiUmvt1lL
         gO+p4wpNgFRyeyL8Oy2+QQD92JB2B2GN5NEo+cCMitZk+SykpMMcaHsYbtypZJYiloJU
         WVN3eHi4gOfSULfxFNsRf5zu/IlIgxcQ7uNMBL7jIjXvjMcS2KL6fgWwOSBVrdONIlmj
         K9ixBUM7UfGeG3+BnzyPJFSSzT5D89iq+I5cnmOL7dGBm6G1iKzjowl2/ZMfEM2uCKzj
         u1czLPLw2EYb5QisyKHHmj2YHSF0o5eRTD/k0KuUa/hO/gEn1qQAViZyzVBvVvRWm1Xj
         iRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725462922; x=1726067722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7alryj2QRham+4+mog4UfLUrtU9/gcdbfUvdQj1l5TM=;
        b=I9FcNINI4yIYOhCXYkEtGmjN2Wmskmdf9rTXh5HC96dSst0WNXBdvbOyscGPg4lTN3
         wACMpjI8uQWBlPQIDgzqY+htp9fN0gRn5Ul66eTCRb3BUIYg4nbaxj2MC4LngY77jVc+
         hYwbg3OnVeJ4EXSsK5p03bjjRfgCXXh62aqGuyXOo9IykeMGRdR69TzPqiO9qS7tjI45
         MdSzAiFIro0W8j+dbmhvb0zEUQPzl2oFmLIwcAh+HNR8j9J0bQ8AwRzX7/q6QxZP1PBv
         zjLu1AD8IBT3HimawgJsA3VWzp/dFt7VzYl7FESftWp2OGdZxSJHGHW6u7sCEKYzweDp
         BkHA==
X-Gm-Message-State: AOJu0Yz0FLkN7+x1F+yaxHJ4O/UHT5HaMZARpprt/kQspZxFAfd/a2sP
	F/SvjukSFAIv+TPi6zElTzGf4bN9vjsaRLNe2ndxREe0kjwcyj+f4tXEVaKhzbw=
X-Google-Smtp-Source: AGHT+IEEu9l2F5Mf7z117qiH/fiRGfp5++/ssaDPPBd2SYt91AllGkexmkCsAeLWVOMf7U6DzMD7LA==
X-Received: by 2002:a05:6a21:118a:b0:1cc:e43f:1fc9 with SMTP id adf61e73a8af0-1cecdf31e5amr17462361637.30.1725462921936;
        Wed, 04 Sep 2024 08:15:21 -0700 (PDT)
Received: from fedora.. ([106.219.166.153])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbdaf089sm1783672a12.86.2024.09.04.08.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:15:21 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] edd: Add null checks for edev and info in edd_get_pci_dev
Date: Wed,  4 Sep 2024 20:45:14 +0530
Message-ID: <20240904151514.8962-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add null check for edev in the edd_get_pci_dev function
to prevent potential null pointer dereference. This check ensure
that the function safely handles cases where edev might be NULL,
avoiding possible crashes.

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
 drivers/firmware/edd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
index 55dec4eb2c00..6964e528bf35 100644
--- a/drivers/firmware/edd.c
+++ b/drivers/firmware/edd.c
@@ -648,7 +648,10 @@ edd_dev_is_type(struct edd_device *edev, const char *type)
 static struct pci_dev *
 edd_get_pci_dev(struct edd_device *edev)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
+	struct edd_info *info;
+	if(!edev)
+		return NULL;
+	info = edd_dev_get_info(edev);
 
 	if (edd_dev_is_type(edev, "PCI") || edd_dev_is_type(edev, "XPRS")) {
 		return pci_get_domain_bus_and_slot(0,
-- 
2.46.0


