Return-Path: <linux-kernel+bounces-229210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DD2916CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8591C22B77
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23344170838;
	Tue, 25 Jun 2024 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcybOuCv"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCC016F903
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328810; cv=none; b=qM46vH7eQMLpLCRiiilrU/jE7vciuI3lG/Sz2/0pwZEZUBrNoCmHQyilc387THxCZqpC+rzjiX3elvdbJEFboOGYXtAGFA/BOkAvf9X2OiWfuGTNd+vx0NEdjLibEaljIM6HBIexIYO1Xi64v7iXtUpgHjLPTxyUvDyyztZ0uYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328810; c=relaxed/simple;
	bh=ro15qrG+2X7dzLSbBTP8U40hi2ii1P6THkENl0JJl0c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HDzktdCc1PPGZso3I/wHrDUoNoUjYYVrkcbnuB+KScdXNCq5QMH1nfEi6BbqwUVT1ETqo8vVtIbrI5ocWr1nUGnGLyjeJZUJ3r+Mylg4pugzWMpnQITOMAj3IZ/zDJ16EtPG1/DAhE+Vgr9rEGq0OOK7glqDzzZhXEJicp6ziQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcybOuCv; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebe785b234so62521561fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719328807; x=1719933607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M7My76Xx+peBaX7RrKQa/BxRrvIU630K8BNIFUaH3MQ=;
        b=XcybOuCvEKjjPYP9E27qY2XUxzKOuyRnKPEnPTduyrz+eu17Yz0c0ZAW6/8i2eNX/w
         O2wM+smmMp3ygiUIPJQxe8225CQORmShhtJmqbce5wG8URd5oN3AqgSRU+RBm1UbkZJx
         f7oAEmAHEfWgWso1Bz0xaK5lTKUPBtPCcbaaKTQI4hd1MutUJsXcech5gXXzpG6pMMBU
         fLQebUsVpBpZeTKKn37gCMy+jkMu/sFwNwM3b8QKbAFLaCZwXFf8L8MOCyFPhV5G1eCE
         jWGb0CIH6I7SjvTt1/yFXsy5OOVZyvsfr+D4hJUGCarr6Dcr/4JcGajvOKuOoC4mmHqF
         Xnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719328807; x=1719933607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7My76Xx+peBaX7RrKQa/BxRrvIU630K8BNIFUaH3MQ=;
        b=GXra20fKXZMBFD5880EfJU7Ftk0RPP0OvYg94pJGH3c8vjBkbrlRDLLgq+qy6M1Cyc
         dfj4Ga7N5TCAoRXYcm/esdqVAEo5SWrOWaysimJoXiXotaho+XtlS72/z4GtKuQ8emjn
         xCBHHbeANV/NilhYpkd0VS+zQiSSr3lMfrkvCo3go+lpCaEouh3rjUSE2YHsVeJ0tzrl
         9y2UyFM3me431TXH9t0Sb7qxbavXAFia9jjmxGSS4plP90nxYGVIDdLF0dYYUbqAw4R4
         7FdKXU9yd2sF3/3Se7q+KNcVZ5qvlXjc2VegWbzKyIS2JMXoVv0unoAXDN4FEHY8cvkT
         /y5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVqUx+HvU+yZCxyF/Zu34QYTOwk9w2JrFWcC7kglaASvJK171VuVk7AR+zjbyo7iCPPJvy4TeitTunuUTdxw7ay1gQO6EotPSE4hQt
X-Gm-Message-State: AOJu0YzIn0MKXy+KYjmIjiyBTS2I4soMQlZvvpReDKBzgxjzoc1GMczt
	OKHOKsm8RsMOD3L8VNbXM7pBV6VTRChR2/hETgI/xChshVwAzApa
X-Google-Smtp-Source: AGHT+IEKZTWwrSCXm10ss+29iQwj3R7hVZlF1h2E5+VfQHecxEUa538EMtLDLzdMAs6PdI0BLXe8Eg==
X-Received: by 2002:ac2:514f:0:b0:52c:a5cb:69e4 with SMTP id 2adb3069b0e04-52ce06415d6mr6089650e87.54.1719328806841;
        Tue, 25 Jun 2024 08:20:06 -0700 (PDT)
Received: from localhost.localdomain ([31.120.167.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b861bsm13110218f8f.29.2024.06.25.08.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 08:20:06 -0700 (PDT)
From: Teddy Engel <engel.teddy@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	oe-kbuild-all@lists.linux.dev,
	devel@driverdev.osuosl.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Teddy Engel <engel.teddy@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] staging: rtl8192e: Fix conflicting types error with net_device.
Date: Tue, 25 Jun 2024 16:19:18 +0100
Message-Id: <20240625151918.10839-1-engel.teddy@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a pre-declaration of struct net_device so the compiler is able to
use rtl_pci.h / rtl_cam.h.

Fix for commit: 7dff0b27d9c842f88149bf611cbc0b59be1dcd3c:
[34/59] staging: rtl89192e: Remove unnecessary pre-declaration of struct
net_device.

Signed-off-by: Teddy Engel <engel.teddy@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406250858.L8rJMHQm-lkp@intel.com/
---
v2: Add commit id that's being fixed.

 drivers/staging/rtl8192e/rtl8192e/rtl_cam.h | 2 ++
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
index 3a5635494385..9deffdf96072 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
@@ -12,6 +12,8 @@
 
 #include <linux/types.h>
 
+struct net_device;
+
 void rtl92e_cam_reset(struct net_device *dev);
 void rtl92e_enable_hw_security_config(struct net_device *dev);
 void rtl92e_set_key(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.h b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.h
index c645775b2150..3e39c4835ac8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.h
@@ -13,6 +13,8 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 
+struct net_device;
+
 bool rtl92e_check_adapter(struct pci_dev *pdev, struct net_device *dev);
 
 #endif
-- 
2.39.2


