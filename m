Return-Path: <linux-kernel+bounces-229312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 036E4916E35
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3572D1C21E98
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3597174EE1;
	Tue, 25 Jun 2024 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT3zY1lz"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7923414A0B8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333302; cv=none; b=I4atnKDd8HkMucbrk5T1XKvajhx1vNZi/qhlFMqYnHTCTbZX3iAoX63eHkOp7jqwqRc3j5/plK+3jJ6WWwDNanb+oHc0LnNHff2FufR4UtkOEjyMKLvkIQ1YgqB2BQx8u6tjm2IUE/gqLyaErf3CxjBFfszwoxkXQdRKjXxIGQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333302; c=relaxed/simple;
	bh=bAsxVx0UvzMzKlZe2Vcp9z6yB46BDlBPDqTLhsJySag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ShZQKZzfe5CaL4TRSXkILXeYwAFdPjOW6EiF4cLYf5vPV9IUSBIesTQKyMdOQrKR9vHS27WNDU5q8OVECO+xgUWmMmTmfVE7Wz4spmHBcD95WiyvL0zCyDDbUR3dfW2SYRT8SonWZ8L/ePUUYNUYEIYsQDNvfGhaW9WUI9rWdcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZT3zY1lz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42198492353so47828555e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719333299; x=1719938099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f2D5WnbI6hoDNtONP1hohTOtNAD6BEhzID8lJ1CZtes=;
        b=ZT3zY1lzwVSpLGlRCMKoe9UAYph1+/DVkHVD6fh/D06zScHksldA4nQhaEE22aqkTM
         170RqSht/nRkXZPEtphiOax8MIQlR59P7EqxDi2fLiWPccZHPG3UT5SF4HAglIgMJf7K
         +Ing5DtGude3bqojzx2z3jmTOmGEEw+4iryShXYZ4YfVE1Vtzat4JXN1QluS/FoXrM2+
         NZYgRsPP0u7dZWSH7CTSokPfZYeL/3+LRjdDPEU+7rLm11Za4ZjCFtcOJbr7q9qxLCdL
         dXXeGcautEynhkx5ZVtCXEPK2GqzOEr1BEyWhamshAu3lo++wOBV51BbHk8SJdd/2jfk
         XUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719333299; x=1719938099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2D5WnbI6hoDNtONP1hohTOtNAD6BEhzID8lJ1CZtes=;
        b=af3Jat+PmLn4FoXn7MH69I3Xt9r+Lo5rdEO4SXd4xJf7Pjx1uol94argy5iHbj8PJw
         +EZPIqKnMGt4AJQCsCWiIxIIoBKudmaMmJZtR0GkITtJM2gTC/gpxQ/lt+GThKjMu6rY
         Dlkhu1w2gj/5/CX/h7cr/aCZJrgMknSgXzgXt/2n0Ngj9Z5+EM40eQtMtpHgJm+YCy8D
         Dx7PVC+5bI1l9EMN7NrRr7yPSe8jlV8yaBts1h3y1keg5jOV5Pj1sMYIgq52+fgGLT7C
         ox187dPVygV0Ov29x+5K8/XvaMeyTeGxvrNJnpIaAn9OdjbjFG2fjWDN6qPKDDIsy3RF
         T7vA==
X-Forwarded-Encrypted: i=1; AJvYcCXG22yuUEnBvhRTefRSVEqOlC0afjhmISt5STiddSJz+i+GfMVit36AL3Udis5nEyt1zpFp4Dwqjm4fV/nI/mj9Fp/PugH6JdHwa1to
X-Gm-Message-State: AOJu0Yx/EQAUh46CwBqMzstaWN1RPnFLVcx3q6xQ0eUQPUcu5tc6qzP5
	9PueCXnwTEpo74XcWsKZkydAaoAjwqfIDFvLw5n0ye8rXN9zegLr
X-Google-Smtp-Source: AGHT+IGGyhODIpXfM2MCK3HCTtKZDoIwysdpuC9axXxzoGpIKWMr3flaE2pWWJ9AT7H/BxuHIv/ECg==
X-Received: by 2002:a05:600c:2d55:b0:424:a319:6b46 with SMTP id 5b1f17b1804b1-424a3196b9fmr14603165e9.18.1719333298504;
        Tue, 25 Jun 2024 09:34:58 -0700 (PDT)
Received: from localhost.localdomain ([31.120.167.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208e4dsm217457415e9.33.2024.06.25.09.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:34:57 -0700 (PDT)
From: Teddy Engel <engel.teddy@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	oe-kbuild-all@lists.linux.dev,
	devel@driverdev.osuosl.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Teddy Engel <engel.teddy@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3] staging: rtl8192e: Fix conflicting types error with net_device.
Date: Tue, 25 Jun 2024 17:33:34 +0100
Message-Id: <20240625163334.11117-1-engel.teddy@gmail.com>
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

Signed-off-by: Teddy Engel <engel.teddy@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406250858.L8rJMHQm-lkp@intel.com/
Fixes: 7dff0b27d9c8 ("staging: rtl8192e: Remove unnecessary pre-declaration of struct net_device")
---
v3: Replace ad-hoc commit id / subject by expected Fixes tag.
v2: Add commit id / commit subject  under description.

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


