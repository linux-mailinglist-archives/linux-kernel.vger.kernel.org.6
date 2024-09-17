Return-Path: <linux-kernel+bounces-332163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF9897B63B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 01:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1170D1C232E1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 23:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE4C174ED0;
	Tue, 17 Sep 2024 23:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASJ5Qech"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2231192B67
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 23:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726616242; cv=none; b=Aw40N1veHJvS7ebkX3eplxdASneudH3k+jNQoE1ZXokb0xKewzmXles3uW179aNd5e7QOlVIw/Mk0ZgeGl9aMUEncZyLnkmZNhNkXqSSTlJ0hH3EiT+yNI5JarxvJ1WMNU/viy1kXtzb2sYYKpE6KFSarPp6Q6n376RE1uqhfA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726616242; c=relaxed/simple;
	bh=Yh6b1rfZvza7i3KWslmDXs3gmXNNkw7ztRq9xhqYkkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sZM9fftUMOiX7hmu2LiJdXQvogwt2LKWm4Wd0ZEWkhh7g+/DjdtvNDXaoe5uQGNVQ65mw/3zTtTnt0dTvmEe1Ftib31xcqZeyod0GnwNmbnyH6ZevbZDYDdy8p0a3+EV6n1h4W1d75Z237VX46yzfPi2MZxyqUn3Ub6eYk/HiPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASJ5Qech; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fee6435a34so54842125ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 16:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726616240; x=1727221040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+4V/8APfhFDjK0TbP6vOe2EfVKeMMbKBRPhEv2aIfeI=;
        b=ASJ5Qech5LGhG9H4A1xGgDFb9+Y7gRgv+BA18AKyNDqiblM9c/kTuhlEkNNG6fIdB2
         oiyT3Ia30BSKzAaOdlML0eqVIaM7l1GrxHlN41AdXAs3FvZagIPbtbhEVPFcVXilkmFg
         1z/Z8Qa4uNIjbZr4wrryEg1VOL5WNDDAW/8IzzRHBEp9IYykAnJUQwHVFkTIY7/g4y0o
         q6U+HDtCumsMSSccrL5Le07jy5xm6egZEt0vzJso7tfvj7qGXf9ZOumyLP+/7kLVYFxl
         y2VbNs6iuYS1kmFgdFekHnPwC/aH+GWfQHAjCOkoOD6T/xxe1vGhgJ+4VyJnhcGP2dSV
         H6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726616240; x=1727221040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4V/8APfhFDjK0TbP6vOe2EfVKeMMbKBRPhEv2aIfeI=;
        b=tGmQ89vqAjWUk2riH9Q7t+SUrftEwG/ab65g6NlImekV1DfRY8Z9OLnyKrnqOC4WvE
         h4hLk4jv/GQC0sPjbmmfX1ydHcM04In7asq3FKXAqRdhmSlUG/mVod+Ang7vo3j5sDqd
         bN0/+r+dqJy+t5GkegI0HkypWhO7kZBlFSDpZ6f/epvWh7nQJGmict0aT6Am/D06OtR1
         iezFX0E808KTnmQDeY5papvM9/Ft/Uuj4dAFvjgWQKpL4GQ+ywq68e+f8Xmp6lDElFk1
         WmBRsKPKGYTVzSe5dXq+Dx14b23mq3upu+NOm1qUVyJKR6fXGXFxl00xh3NDru4fLRny
         bnqw==
X-Forwarded-Encrypted: i=1; AJvYcCUlTbCrDpW6RI/OrkWncylJshbijAWARLQxqqdKiD6q0YFLxAuEB/e0ZPTuv4xPhRbYKzN5Hq5EsEop2a0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt2yfwL1bk5/zurwNqSQqqP7ULLW/6rThpCdmPN/XtJ6K0oxMa
	+yUIXrN88WzeFm6U7nF0biRmTrlQkOCJU9usuS19gCbXdKTSAp2+
X-Google-Smtp-Source: AGHT+IHG+QKuoEXpiLZOezS6Ou+QNM1i+bhg/FChfpH3EGXD6kQ0RtkpjirogCLkckbdMU4O2+xsCQ==
X-Received: by 2002:a17:903:1112:b0:205:4531:54d with SMTP id d9443c01a7336-2076e37af96mr318957255ad.30.1726616240064;
        Tue, 17 Sep 2024 16:37:20 -0700 (PDT)
Received: from localhost.localdomain (111-240-85-119.dynamic-ip.hinet.net. [111.240.85.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946029c7sm54703325ad.113.2024.09.17.16.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 16:37:19 -0700 (PDT)
From: Min-Hua Chen <minhuadotchen@gmail.com>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: Min-Hua Chen <minhuadotchen@gmail.com>,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] xen/pciback: fix cast to restricted pci_ers_result_t and pci_power_t
Date: Wed, 18 Sep 2024 07:36:50 +0800
Message-ID: <20240917233653.61630-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fix the following sparse warning by applying
__force cast to pci_ers_result_t and pci_power_t.

drivers/xen/xen-pciback/pci_stub.c:760:16: sparse: warning: cast to restricted pci_ers_result_t
drivers/xen/xen-pciback/conf_space_capability.c:125:22: sparse: warning: cast to restricted pci_power_t

No functional changes intended.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 drivers/xen/xen-pciback/conf_space_capability.c | 2 +-
 drivers/xen/xen-pciback/pci_stub.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/xen-pciback/conf_space_capability.c b/drivers/xen/xen-pciback/conf_space_capability.c
index 1948a9700c8f..cf568e899ee2 100644
--- a/drivers/xen/xen-pciback/conf_space_capability.c
+++ b/drivers/xen/xen-pciback/conf_space_capability.c
@@ -122,7 +122,7 @@ static int pm_ctrl_write(struct pci_dev *dev, int offset, u16 new_value,
 	if (err)
 		goto out;
 
-	new_state = (pci_power_t)(new_value & PCI_PM_CTRL_STATE_MASK);
+	new_state = (__force pci_power_t)(new_value & PCI_PM_CTRL_STATE_MASK);
 
 	new_value &= PM_OK_BITS;
 	if ((old_value & PM_OK_BITS) != new_value) {
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 4faebbb84999..368738312696 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -757,7 +757,7 @@ static pci_ers_result_t common_process(struct pcistub_device *psdev,
 	}
 	clear_bit(_PCIB_op_pending, (unsigned long *)&pdev->flags);
 
-	res = (pci_ers_result_t)aer_op->err;
+	res = (__force pci_ers_result_t)aer_op->err;
 	return res;
 }
 
-- 
2.43.0


