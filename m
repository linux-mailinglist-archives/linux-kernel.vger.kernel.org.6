Return-Path: <linux-kernel+bounces-571601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F18A6BF97
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC521B61CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F143622836C;
	Fri, 21 Mar 2025 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRS2Kd/2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB3E1DEFC5
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573783; cv=none; b=EVEny0C7d7IR0TLxwGbs0OMsuQJxPtZWeevKliBDxgixzJs5erauJ0i82eoQ1hx1hoNBm5v0J00JX2iPCXsu1a/kYqCAr73XaflbGhsVWTUoaIltfhjTsZmbF51rpybsPpnSxle+/D8jvuG/rHp8znwv0R5C3y1Cq+zNNc4R+ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573783; c=relaxed/simple;
	bh=pFeQIM0elSHXudDzaZqSa3sSLY7KBkvo9aowDlPa0tY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XyLHhKx6c3awzf3C/yvF/+JNDO14vj023TpS8gML7l8epGkurGRUzIH641lkYZ9aT2TqguY6GU+QJx68N4HPab6bSCezF7fYK1uTGSpF4A9I+Nxdp3yPd9TVTQhnLHbwF6lgjQnXG5C2AVsuiCpNbcEOlvsTYE7m1AWspaKIQzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TRS2Kd/2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742573781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mC48yAiQls1tllwqU0y43QmgvHaHdh/HKhHrXStRZ/Q=;
	b=TRS2Kd/2tcXJN1gFVKY79supQq6/2shlYtetOKIGyl+Ydzw8VRHhNy2eQMK8FcMBaW7Obh
	yNHUuM6N95K90NTkQ/dhW2nibZihtI34Kuq5n5oFSlD+45aEMph5gdEbYz+ZnclDO6pj8t
	skgRFvVwBNZjAcWkNe+gUeIZxvuvuus=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-N9C-eFN8PcyB-SoiNJS0Tw-1; Fri, 21 Mar 2025 12:16:19 -0400
X-MC-Unique: N9C-eFN8PcyB-SoiNJS0Tw-1
X-Mimecast-MFC-AGG-ID: N9C-eFN8PcyB-SoiNJS0Tw_1742573779
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85e15e32366so220662539f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742573779; x=1743178579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mC48yAiQls1tllwqU0y43QmgvHaHdh/HKhHrXStRZ/Q=;
        b=kjeaAmYTIlJAq2NhJ1kquzKgZztrvZdUl9emmaSyWr4FwhKVlHzBqH9suJt4gCtc3w
         PwO1/2d3TI3cYW14ryJGttXyjdjCAKtKS+Z5j2we6SOsaxXaBmJD0N+oDeHmYggRwhmR
         +VF6Jp1bGjRL58UWWosUKve4QHTfYCyPml3ISRQwDzezLc+u7XIXuNKxjvqSQ3O4aa2N
         GN9+qVYdphTE/okBv/rdlfs+puvH02GkvQFU1BnFVKl//J7x3VCW9uUAR6eoBVDEvTr5
         z3FvzBOk1SYKy9K/MJfUEAFXHggpwiB0d+XyVGfM7TQDaP2ollgOo7Gm5Ji8yx5w/M4F
         sRNA==
X-Forwarded-Encrypted: i=1; AJvYcCV+kNAgBpYg84Q3fEbTPWLJJDLwRW6dM711QKHGzNfvjZbBbDuCQ2BSat8+5Fj18T3gkaKIxBUzzVrKGf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUlP6/9Qa8UWFi0S6+hEtyopPySHNIcNm5oqxbfhnbQHvIy8Pw
	Kam2dE6I2u3wnA9+g5NXDnE+Czj7+QJGztpTo+qMU9UiVlTCqzHxEXDCdDSB2PYo/Nud/3/n/oG
	4Zxy1Up1KYRPVZRUJxnw+OD1HFTMBU3zoIkd3gi56gNvth2/snWCWIaKFyKlzWQ==
X-Gm-Gg: ASbGncu6lkTJsf5sJFq9UOUzquX+5yg+6+hZ6DUXoO5wGauAnOtln+DQPrKG6KLarRt
	JdqUB6BYlOUMsKYas8rnCoJzdKEdMv9Zfs7tQh6FfMJ7k72CFH8IE+Gj7P98ux8qfs7C0Nhl59W
	MS4N8iDi6GraqBglWTCJD5y6zC7WMa332Ivlh8v+P0M0fLmhpgSSfio/uomgOgJiVJ34PCK0jZh
	EBs9b1O6fNkocRagLxFoKD8fmCQg85mhdhbRGJ6Z7AiIjCFcpo4EGywesZj8d7nL5W2Og+6Tb4m
	nuK02NLEXZdYWvChUpKzuV4iXOkBvg1hVgvN7u63JG0x+d9+Ax+e2c4R8+sX8D8tHE4kpYqOgyQ
	=
X-Received: by 2002:a05:6602:4088:b0:85d:b054:6eb9 with SMTP id ca18e2360f4ac-85e2cb417c3mr499149739f.14.1742573778727;
        Fri, 21 Mar 2025 09:16:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbaQHrqE43XUvLxfY1cyZCTiEOWEjd8FXpM95Z7lNYACE/IjdXtXMvElMRWZlz02YAI2fshQ==
X-Received: by 2002:a05:6602:4088:b0:85d:b054:6eb9 with SMTP id ca18e2360f4ac-85e2cb417c3mr499145039f.14.1742573778344;
        Fri, 21 Mar 2025 09:16:18 -0700 (PDT)
Received: from rhdev.redhat.com (2603-9001-3d00-5353-0000-0000-0000-1422.inf6.spectrum.com. [2603:9001:3d00:5353::1422])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbeb565csm495653173.131.2025.03.21.09.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:16:17 -0700 (PDT)
From: Jennifer Berringer <jberring@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH v5] power: reset: nvmem-reboot-mode: support smaller magic
Date: Fri, 21 Mar 2025 12:14:49 -0400
Message-ID: <20250321161449.1175473-1-jberring@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices, such as Qualcomm sa8775p, have an nvmem reboot mode cell
that is only 1 byte, which resulted in nvmem_reboot_mode_write() failing
when it attempts to write a 4-byte magic. Checking the nvmem cell size
and writing only the lower bits of the reboot mode magic is needed for
these devices.

Signed-off-by: Jennifer Berringer <jberring@redhat.com>
---
This patch depends on [1].

[1] https://lore.kernel.org/all/20250318094716.3053546-5-o.rempel@pengutronix.de/

Changes v5:
- Switch to using nvmem_cell_get_size() from the above linked patch
  instead of introducing another function with the same purpose.
---
 drivers/power/reset/nvmem-reboot-mode.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
index 41530b70cfc4..6be178be4a58 100644
--- a/drivers/power/reset/nvmem-reboot-mode.c
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -20,11 +20,23 @@ static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
 				    unsigned int magic)
 {
 	int ret;
+	u8 *magic_ptr = (u8 *) &magic;
+	size_t cell_size;
 	struct nvmem_reboot_mode *nvmem_rbm;
 
 	nvmem_rbm = container_of(reboot, struct nvmem_reboot_mode, reboot);
 
-	ret = nvmem_cell_write(nvmem_rbm->cell, &magic, sizeof(magic));
+	ret = nvmem_cell_get_size(nvmem_rbm->cell, &cell_size, NULL);
+	if (ret < 0) {
+		dev_err(reboot->dev, "failed to get reboot mode nvmem cell size\n");
+		return ret;
+	}
+
+	/* Use magic's low-order bytes when writing to a smaller cell. */
+	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) && cell_size < sizeof(magic))
+		magic_ptr += sizeof(magic) - cell_size;
+
+	ret = nvmem_cell_write(nvmem_rbm->cell, magic_ptr, MIN(cell_size, sizeof(magic)));
 	if (ret < 0)
 		dev_err(reboot->dev, "update reboot mode bits failed\n");
 
-- 
2.48.1


