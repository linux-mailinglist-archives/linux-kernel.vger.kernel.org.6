Return-Path: <linux-kernel+bounces-188386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A97B28CE160
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49741C2139F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06117128826;
	Fri, 24 May 2024 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="Bld0O95j"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C708F5A;
	Fri, 24 May 2024 07:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716534812; cv=none; b=XMj3iDrsgnpeHNaZhkuKhvJJQR/ZZgk9l5d9VZcIWxXGa8DV5PFiTQd837y9ZNdMMoAtLt/hSQ5VdepuMwgTW9TSnCF2s9vgJR4+E6mm6K1tMuoexvGJbvnERwSTVs0tOPztdjtUI+9+6Sk/p0ECVaHmF2/dSPhzKc5IZZ4tw+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716534812; c=relaxed/simple;
	bh=qSjCs6Ul6ojhpPYSK0ZQVIJa3AR8PdI5qM0Fn+3yBdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VlCg+D22/pvB510b0um0iizybXV6itcNo3xRPaxrs/QlLhlFuryKPsDrYWGVTOJDFMdMMGKCX7GEY58ONSC6t0YOUj/boTFMTiSlbSHeHwJh+GBl1AQ2lip/1yZOb7J8y0C6tgBVLF0MobfzjBDR6u6APP6rVolLjLqR2030R+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=Bld0O95j; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 7BE133FA37;
	Fri, 24 May 2024 07:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1716534472; bh=qSjCs6Ul6ojhpPYSK0ZQVIJa3AR8PdI5qM0Fn+3yBdU=;
	h=From:Date:Subject:To:Cc;
	b=Bld0O95jSq1Wc3K3MI5TbwrffzqDn4V+xD9E2GiHUPJE6lrFoElBw1qcIGPR7csxN
	 Lt/BtFCfPlCkEC99p5O4OnRNUXu8/c3s+NQBAlOdlYSssSp3Dd/qGi+8RrWfMfEksq
	 iQBtFjUYxORbu1MvGr3hqJPz6YtZ+pAipWcGizSgCYGUZNZ2afEmFgHI6GquO9eacy
	 EqryhqHvwKYHvbUWJiQyhFCIeQib6G8xxhYU4Nr/NaJY9qVxpWRjI0FrxUQQMsquDZ
	 k1KJfYE8ZwiQG25vPjMelz88bsGPD3qDUU3+D/8WetfKCei07CWYYYflX8I2QWO8JQ
	 eF4dBuFEw/EyA==
From: Hector Martin <marcan@marcan.st>
Date: Fri, 24 May 2024 16:07:41 +0900
Subject: [PATCH] xhci: Remove dead code in xhci_move_dequeue_past_td()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-xhci-deadcode-v1-1-a4453a756e0f@marcan.st>
X-B4-Tracking: v=1; b=H4sIALw8UGYC/x3MSwqAIBRG4a3IHSeY2HMr0aC8f3UnGQohRHtPG
 n6Dcx5KiIJEo3oo4pYk4SyoK0X+WM4dWriYrLHONNbpfHjRjIV9YOh+3SxWdK0ZmEpzRWyS/98
 0v+8HZXcjt18AAAA=
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1605; i=marcan@marcan.st;
 h=from:subject:message-id; bh=qSjCs6Ul6ojhpPYSK0ZQVIJa3AR8PdI5qM0Fn+3yBdU=;
 b=owGbwMvMwCUm+yP4NEe/cRLjabUkhrQAm6PiYb88WX9VGif+VN/wLtr6ybOMaW4+n8+nrVsmv
 nD2q7m9HaUsDGJcDLJiiiyNJ3pPdXtOP6eumjIdZg4rE8gQBi5OAZhI91VGhiu2Knc3+J97d8n+
 u9utJhGtqQnF/WePJO6qmlx1VrSnSILhD+/VtEMXAhylhdReH7SzuPJ3uX3owkXF/3PqFTRXffy
 1lQEA
X-Developer-Key: i=marcan@marcan.st; a=openpgp;
 fpr=FC18F00317968B7BE86201CBE22A629A4C515DD5

This codepath is trivially dead, since the function is never called with
a non-NULL td (the only callsite is immediately preceded by a NULL guard).

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/usb/host/xhci-ring.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 575f0fd9c9f1..f1ed728d9f8c 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -656,25 +656,6 @@ static int xhci_move_dequeue_past_td(struct xhci_hcd *xhci,
 			  stream_id);
 		return -ENODEV;
 	}
-	/*
-	 * A cancelled TD can complete with a stall if HW cached the trb.
-	 * In this case driver can't find td, but if the ring is empty we
-	 * can move the dequeue pointer to the current enqueue position.
-	 * We shouldn't hit this anymore as cached cancelled TRBs are given back
-	 * after clearing the cache, but be on the safe side and keep it anyway
-	 */
-	if (!td) {
-		if (list_empty(&ep_ring->td_list)) {
-			new_seg = ep_ring->enq_seg;
-			new_deq = ep_ring->enqueue;
-			new_cycle = ep_ring->cycle_state;
-			xhci_dbg(xhci, "ep ring empty, Set new dequeue = enqueue");
-			goto deq_found;
-		} else {
-			xhci_warn(xhci, "Can't find new dequeue state, missing td\n");
-			return -EINVAL;
-		}
-	}
 
 	hw_dequeue = xhci_get_hw_deq(xhci, dev, ep_index, stream_id);
 	new_seg = ep_ring->deq_seg;

---
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240524-xhci-deadcode-8bf2ebe7609d

Best regards,
-- 
Hector Martin <marcan@marcan.st>


