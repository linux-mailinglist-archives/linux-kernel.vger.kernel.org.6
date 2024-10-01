Return-Path: <linux-kernel+bounces-346582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9855F98C633
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB85286089
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D3D1CDA19;
	Tue,  1 Oct 2024 19:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3CDukfH"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9051C6892;
	Tue,  1 Oct 2024 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727811949; cv=none; b=GaHtF4OqDoUe8mPp189mgz9LS2vXg92EIGLzUsGqqukQw6sZJCbKDWLDoFy48XD5R70PNJez+eKdsTk/VE/p90SDZcQs5PVCH0tYS8Capof2bqQI/5i+oZMzR/dxqIc43ODmbqz1kdbvL8dxnoJrFpDncClZ3/70h8k37i5pFCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727811949; c=relaxed/simple;
	bh=+HpMa8WMijC5174l2/PIU+MwujHEbEqXgwyWKZEsc7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PqvvFIX9z42sqyM7r4frYUBW2ACLV1u33MJtEam8CYG9vUY6cETmMwOk2Q3zqBWcAstM+6dTd1fEe4Yov0+FkrkXLBnwXDsI8+WcvEZBwBrS1Bb2nAtUGsmflALzy2zLtK3vbnMYDW0f8cWsaMlHUpfK2VkuHYRdusuD991fi0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3CDukfH; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71970655611so5509311b3a.0;
        Tue, 01 Oct 2024 12:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727811947; x=1728416747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wnQf33Rh6vs41QeO5fyQIMj8M2mfcNsGZPYhGkdUYD4=;
        b=Z3CDukfHEjdlRLMM3YAMx65etD3Xd3mqvrJYLrRJKzDaqWJkeYtQY8o5MvMnNVM+1x
         eMDkd1Y0wqnkc/mkJOOKufPDKs8HGUPELalReOuvLncSfWpFClP30J/KLEZFaWdE2HpY
         EouSovvt8/1MD8p9Fdqpv3hNxiOEbE2A+dYvUp8LjnIWSu9llIsgjd/YN3erUt8gld4/
         FJdvaBbI7Gu9bnVv/LTEXQ+sZLeRyVK/C7xV+wg75FxgoeDfslOeiWpzBm2LMZk6nyhE
         ddovoFxyILkUEZJ5UiRnamkr2V/GlRtqL3oLEk4siOATn4ngFSX6ebuJQXstRjSX/kPW
         EjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727811947; x=1728416747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wnQf33Rh6vs41QeO5fyQIMj8M2mfcNsGZPYhGkdUYD4=;
        b=ElpNYL60MZAtR2vhmR0K1pcNi6TWak7v7zQKXYfdgflVUfsTFnTqXOgcHk6eV8jdMk
         1jMCDBi/fjlGZU/ESr6BX/8pskTiGrWsHXAIjXKPS/N0gOUW78tXoHi8ZODshVkMH9s5
         4ybOa9laraq9Fslw4F1BBmDEUYfxpuMQFbmtIZdiB3yNozB/yM0Li05zj2OQFFx9mFJB
         d3QP7gm9OEUBzzmC6s4HIYhHiEmG6lO/dAi3Kk4HYnT/73IdZdgqhpkJLQdiUWYz0P56
         D1K/4MQCpR2C0l5GEA9O37rk4HZAzoNxMZTQgnSctuNKeWnQ0nU9dvxLYjL+m7ekEdb+
         Y5Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXSkDuGJ1eLJqBodFomgxco9iOy5H2En9UU4ArNrMboY7upjlIle0g85Y4uLGFaf/0KiBloE5fMklmQJdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySzGB1X/o4juxLsqfS4OCgNf2UFLxdjvAYMhxMcnSJOLpkquuO
	WNmMTr3QyKwzunuHj9j/BOMMVji89FCPf1r0exbKXLf+K1Hiz3N+
X-Google-Smtp-Source: AGHT+IHgAv5xzeb8cRkFa/O/zvVoFskQAvbTymNVC4BMcPfX84wuEYnzvOya510I2qMDPO6nMSQrHw==
X-Received: by 2002:a05:6a00:4f90:b0:717:8deb:c195 with SMTP id d2e1a72fcca58-71dc5d429cbmr1165757b3a.21.1727811947200;
        Tue, 01 Oct 2024 12:45:47 -0700 (PDT)
Received: from feng.cse.unsw.EDU.AU (dyn-dhcp-166.cse.unsw.EDU.AU. [129.94.175.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26515f25sm8653846b3a.98.2024.10.01.12.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 12:45:46 -0700 (PDT)
From: Tuo Li <islituo@gmail.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH] usb: xhci: fix a possible null-pointer dereference in xhci_setup_device()
Date: Wed,  2 Oct 2024 05:45:26 +1000
Message-ID: <20241001194526.25757-1-islituo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a possible null-pointer dereference related to the wait-completion
synchronization mechanism in the function xhci_setup_device().

Consider the following execution scenario:

in drivers/usb/host/xhci-mem.c:
  xhci_mem_init()       // 2381
    if (!xhci->dcbaa)   // 2431  xhci->dcbaa can be NULL
    xhci_mem_cleanup()  // 2548
      xhci_cleanup_command_queue()        // 1888
in drivers/usb/host/xhci-ring.c
        xhci_complete_del_and_free_cmd()  // 1619
          complete(cmd->completion);      // 1608

The variable xhci->dcbaa is checked by an if statement at Line 2431. If
xhci->dcbaa is NULL, xhci_mem_cleanup() will be called at Line 2548, which
eventually leads to complete() at Line 1608 that wakes up the
wait_for_completion().

Consider the wait_for_completion() in drivers/usb/host/xhci.c
  xhci_setup_device()
    wait_for_completion(command->completion);       // 4179
    le64_to_cpu(xhci->dcbaa->dev_context_ptrs...)); // 4237

The variable xhci->dcbaa is dereferenced (without being rechecked) after 
the wait_for_completion(), which can introduce a possible null-pointer
dereference.

To address this issue, a NULL check is added to ensure the variable
xhci->dcbaa is not NULL when xhci_dbg_trace() is called.

This potential bug was discovered using an experimental static analysis
tool developed by our team. The tool deduces complete() and 
wait_for_completion() pairs using alias analysis. It then applies data
flow analysis to detect null-pointer dereferences across synchronization
points.

Fixes: 84a99f6fc5d4 ("xhci: add traces for debug messages in xhci_address_device()")
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/usb/host/xhci.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 899c0effb5d3..1c7322a4e301 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4229,12 +4229,14 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 	temp_64 = xhci_read_64(xhci, &xhci->op_regs->dcbaa_ptr);
 	xhci_dbg_trace(xhci, trace_xhci_dbg_address,
 			"Op regs DCBAA ptr = %#016llx", temp_64);
-	xhci_dbg_trace(xhci, trace_xhci_dbg_address,
-		"Slot ID %d dcbaa entry @%p = %#016llx",
-		udev->slot_id,
-		&xhci->dcbaa->dev_context_ptrs[udev->slot_id],
-		(unsigned long long)
-		le64_to_cpu(xhci->dcbaa->dev_context_ptrs[udev->slot_id]));
+	if (xhci->dcbaa) {
+		xhci_dbg_trace(xhci, trace_xhci_dbg_address,
+			"Slot ID %d dcbaa entry @%p = %#016llx",
+			udev->slot_id,
+			&xhci->dcbaa->dev_context_ptrs[udev->slot_id],
+			(unsigned long long)
+			le64_to_cpu(xhci->dcbaa->dev_context_ptrs[udev->slot_id]));
+	}
 	xhci_dbg_trace(xhci, trace_xhci_dbg_address,
 			"Output Context DMA address = %#08llx",
 			(unsigned long long)virt_dev->out_ctx->dma);
-- 
2.43.0


