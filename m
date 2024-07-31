Return-Path: <linux-kernel+bounces-269848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F9F943776
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DBF7B23457
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A0016C689;
	Wed, 31 Jul 2024 20:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Os33bYZC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0BE1684A7;
	Wed, 31 Jul 2024 20:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722459556; cv=none; b=f+wwJb5n2r2CJTES+3hYbuuFWkXtUoEVU65p7AYm+qiAhbyUjC1L+wcAdhkdmzX5gtMecML5AiIh2dV5Fs/2ia6caiWdMgZhLpMNvyYCqaRd6MH+1NuXrZcGWnpbJ4IdCm/HYOEmTiPalip0xXJp/tMp5MC+/z+aQlO/1FL0WKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722459556; c=relaxed/simple;
	bh=0VFVovUWiKyGr+ZpPTlc/w3FnYuRud1fQaL+qzHy/Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t6I60fOzqiOSidESC1IawWobIJ8lQTIEr+S0DEEGb451X+VUG7iyIZ7dM9XnEJ4SUEYUuB8DSFev8ecDy5iQmKmxRZPGFwRXu9Vg+7akLzDp36ybFVEIK60N/xWbh0DSgJloofb7vkVq6vHg30MDqvzxVgadZ7TcQYfbxkR9RN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Os33bYZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32895C116B1;
	Wed, 31 Jul 2024 20:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722459556;
	bh=0VFVovUWiKyGr+ZpPTlc/w3FnYuRud1fQaL+qzHy/Uc=;
	h=From:To:Cc:Subject:Date:From;
	b=Os33bYZCw6H6Mue7Gd6lIbSbseYXcrd/HYJhvOSutjEyHky0nW7Dyw2CQi85+lUma
	 OnQDJ2nBZE3NA5Wh9sPzBjY+aDuwX8wGuKw9+4ySdeBMUYZUxaWm/SckN9uAa2Ktba
	 oI0S0KIQGpqtnkzmPsFVaxZpc6Uko7i/eLBrEh9j1oWPEH7SLjhZ5udez01TmshTKw
	 O7m5gQfOEwbXbC4Jip6G94Y6njWZ1/ifQxlCj8TuVJ/z9oWSSxTbGO3hXnN4HofXvx
	 QI70z+v+ri/REvpz0XWLSTc5+Beu1iZWZmD6MEFyb3CbSvRbzR5dc8bt/BhYS1ghSJ
	 Le7Y6FawrQyVw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sZGPi-00H7em-8I;
	Wed, 31 Jul 2024 21:59:14 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] usb: xhci: Check for xhci->interrupters being allocated in xhci_mem_clearup()
Date: Wed, 31 Jul 2024 21:59:10 +0100
Message-Id: <20240731205910.2060752-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, mathias.nyman@linux.intel.com, quic_wcheng@quicinc.com, gregkh@linuxfoundation.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

If xhci_mem_init() fails, it calls into xhci_mem_cleanup() to mop
up the damage. If it fails early enough, before xhci->interrupters
is allocated but after xhci->max_interrupters has been set, which
happens in most (all?) cases, things get uglier, as xhci_mem_cleanup()
unconditionally derefences xhci->interrupters. With prejudice.

Gate the interrupt freeing loop with a check on xhci->interrupters
being non-NULL.

Found while debugging a DMA allocation issue that led the XHCI driver
on this exact path.

Fixes: c99b38c41234 ("xhci: add support to allocate several interrupters")
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/usb/host/xhci-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index d7654f475daf..937ce5fd5809 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1872,7 +1872,7 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
 
 	cancel_delayed_work_sync(&xhci->cmd_timer);
 
-	for (i = 0; i < xhci->max_interrupters; i++) {
+	for (i = 0; xhci->interrupters && i < xhci->max_interrupters; i++) {
 		if (xhci->interrupters[i]) {
 			xhci_remove_interrupter(xhci, xhci->interrupters[i]);
 			xhci_free_interrupter(xhci, xhci->interrupters[i]);
-- 
2.39.2


