Return-Path: <linux-kernel+bounces-244615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E6D92A6E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3DF31C22116
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CD5145A05;
	Mon,  8 Jul 2024 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQFBJcmA"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E805F139D07
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454964; cv=none; b=cntK7Xt1SXHvoBw/RN5qV6vmnxK9RNBQEczVoXAISX459svDTCl0JCRXW6qLQ7AcqcSCEdLuTn4EiR7jO7LSxl0CFOyNth/kBA/qgmrm+OTrIlV3mWxtUpqAAVy/9/rvCQC6c5uksxYfPZAz25sum4TvNrj6wEKRTShpmPMl6lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454964; c=relaxed/simple;
	bh=1hyrMvUmTrLThb3BPu5SecNYjPVq4I35yMc98VTDyJI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MT+5f+O0+L4X8K8PV6vBGV0hq6Au6utQRTb/cCX1HVoR3J9wXUG5uUmeuXadDrA+zpEoZ6utk77N8aQTY4MriFyYq9SWgtvO/8V3dC6+TrTc2ELZ4O5RVUDI0qpbABhSqDmZacM9R6/yFHEp9mpiBFayv4G473yHNKddgX7NBqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQFBJcmA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fb3cf78ff3so24969015ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 09:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720454962; x=1721059762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qd9Dr+L7Fb98s7uPfWDn40nWo8gZpQe2KQvaLhVreGQ=;
        b=KQFBJcmAVigFfkL4nzwk374fvLKE6dZZQi9i369xrYndqzAgOCJ8mdPOv7exTX3xyH
         WMf+52lC9ygPSw1FSQqvU7C5TtbH6SnxLexpaFnoupnEYp4vi5+ygScITGHUhG7f7EUT
         YfyfVlBzFsu0exkedryV9mvEchwQ8QA00PcU2Fo127HZfvtwDGf5X7n1+zM2FitOKznf
         Z9OVcz1QseTigQgEkSPzaz1mrP6TeFe5E2AWXtOFELjHSZAMiZ33MFdhd/FM+GlXJGer
         WWF9eNJXytCNDX4RrnlDFEQZauLXEQOd2wuPO11M/VNLnYCfj2HXpnKqsvYHdiLrfxvf
         navQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720454962; x=1721059762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qd9Dr+L7Fb98s7uPfWDn40nWo8gZpQe2KQvaLhVreGQ=;
        b=ll9lXkwPVk2B0M52LJXSC5Kx1TQxVEmhPDw85TMMwBavjE/M2Cnu4hclPicWzk6zd5
         qjUDbh0tdLew/ekETXMtLVdKNu+ejAsvZLEk0gGj9JUj9URo+Y2GtUgWisQUVJEzmDUd
         OUl5Ubp/L/wA9ebuDwJ9F7zXl5K3BNFgTxXTdVtGow4ggfCmbzUsWsbbrcWnIcwaqNGb
         tiP9wDvO2m6OMul6VPlFVuHoLUSTcy2rrWU23MdUWUEqdbj5Vhv8qFAO7SV4Et56JIWp
         IviEA0wVT9vDU0pxd19bLRoeDI8crWr+4VABwypnwDPmYCOmYTyDrseOh1vJTetW2F99
         f5LQ==
X-Gm-Message-State: AOJu0YzpREsugFffbXLLk8xWuIDWwVmZeGsaEQxmW1KmA6il6JAque6i
	PlrU5oAdw/xjN+ChVPLR0lHfye1ogZn/3VxraSM9XSmAuaLQ+91Jckj8fw==
X-Google-Smtp-Source: AGHT+IEluhfAcYD0yesaKTDMbCVEB/FSh6VZTrk/LMlueM7BnoX1U4q0AUzwwm4iXrrHl8/4pyzFYQ==
X-Received: by 2002:a17:903:41cd:b0:1fb:58b8:2fbc with SMTP id d9443c01a7336-1fb58b8323amr53357385ad.29.1720454962057;
        Mon, 08 Jul 2024 09:09:22 -0700 (PDT)
Received: from cheng.localdomain (218-164-83-170.dynamic-ip.hinet.net. [218.164.83.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6acf3a3sm305305ad.245.2024.07.08.09.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 09:09:21 -0700 (PDT)
From: ChengChaoChun <abc21531050@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: ChengChaoChun <abc21531050@gmail.com>
Subject: [PATCH] linux/interrupt.h: fix struct irqaction comment order inconsistency
Date: Tue,  9 Jul 2024 00:06:51 +0800
Message-Id: <20240708160651.54239-1-abc21531050@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rearrange struct irqaction comment to match member order in the code.

Signed-off-by: ChengChaoChun <abc21531050@gmail.com>
---
 include/linux/interrupt.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 5c9bdd3ffccc..b405e181829b 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -104,19 +104,19 @@ typedef irqreturn_t (*irq_handler_t)(int, void *);
 
 /**
  * struct irqaction - per interrupt action descriptor
- * @handler:	interrupt handler function
- * @name:	name of the device
- * @dev_id:	cookie to identify the device
- * @percpu_dev_id:	cookie to identify the device
- * @next:	pointer to the next irqaction for shared interrupts
- * @irq:	interrupt number
- * @flags:	flags (see IRQF_* above)
- * @thread_fn:	interrupt handler function for threaded interrupts
- * @thread:	thread pointer for threaded interrupts
- * @secondary:	pointer to secondary irqaction (force threading)
- * @thread_flags:	flags related to @thread
- * @thread_mask:	bitmask for keeping track of @thread activity
- * @dir:	pointer to the proc/irq/NN/name entry
+ * @handler:    interrupt handler function
+ * @dev_id:     cookie to identify the device
+ * @percpu_dev_id:      cookie to identify the device
+ * @next:       pointer to the next irqaction for shared interrupts
+ * @thread_fn:  interrupt handler function for threaded interrupts
+ * @thread:     thread pointer for threaded interrupts
+ * @secondary:  pointer to secondary irqaction (force threading)
+ * @irq:        interrupt number
+ * @flags:      flags (see IRQF_* above)
+ * @thread_flags:       flags related to @thread
+ * @thread_mask:        bitmask for keeping track of @thread activity
+ * @name:       name of the device
+ * @dir:        pointer to the proc/irq/NN/name entry
  */
 struct irqaction {
 	irq_handler_t		handler;
-- 
2.34.1


