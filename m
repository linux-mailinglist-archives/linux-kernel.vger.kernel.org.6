Return-Path: <linux-kernel+bounces-553734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C64A58E43
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 198177A5A83
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB86223704;
	Mon, 10 Mar 2025 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR5L29Mv"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AD82046BF;
	Mon, 10 Mar 2025 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595774; cv=none; b=mR9Z4AKsvaJROg+uZxGMLCFaqK4CetuAC8+M6E5Rtri0eEvJk38lhBjOhl1AQDIMr4qxFAvKR/xc1lCMDJTPpH3QunlUvYQHqNMCHGWSXjusoPqzXUSw0yuFl0svtH1EwEA8znszrz1rxOQvn+FAh3YGYHP37B3jobKZ3nbpFxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595774; c=relaxed/simple;
	bh=70x8XkLycgWrFYAgVg/HC6VZfCutHxofMyMhELUtbSA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WB60plkCs+BSPRe5GWmdjjsNUT5bCjX/fKKZ5LLr5aDbUUceIvQ+76I0IcUcPN7zaPUAIon8Bv83rYipBT/A4mjUWEcYEgmDvFHm14VGPUXomy1+XAigkBZh6OHfjrPkXjNRBOeN1fz2Yk44o+RrRabkxl9reMnDHEZv7Wf0j/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HR5L29Mv; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so6087876a12.3;
        Mon, 10 Mar 2025 01:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741595771; x=1742200571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXvRsBo9IPZJTvBcVrBoO9ZQVOyjeuTDOmje8Pbw0GE=;
        b=HR5L29MvO89TTVN7neovS/FfCvMx40mfGntUXvCKdf69LIbCiqWKDO2yG88BET46hW
         qXupvrpGqVKivqNK4mo8HwAA/kuMqjITMpcgsJNoMOU6hCE+1YrQ6wRGmoinMgcRvtap
         il05AZ108MxasZsTpMzHwTdiYjxJQIVe0TUsTRq/uy8LKAadg6M55YJTAE2US/dhf12p
         S/Blaij0o2vgajN5/NZ11oztDYNtGGa6D6Uu1kEv3FVkOYGg8igTJIiSx/GANF12bqdW
         Uj6MMl9Ag8eoXAq7Qf7bJml7a6h4cRYLC0EuL9oA42O04NN/Nu2TO9ptSEpgIAP9U3Wp
         5hSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741595771; x=1742200571;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXvRsBo9IPZJTvBcVrBoO9ZQVOyjeuTDOmje8Pbw0GE=;
        b=gxT2c3/Ub0JE6ZVZ8U/n5APFTdHNzz3UgdSJnkpvDTYtJpXDRmpalcnK9dNsvRT/on
         O9RVi2kj3cDWGlG6Hy/HWAZ5EE+CSn0omSa2pWN4WceuxeJfmMoJlf8M17XKPJDhvV+K
         OF3PrGSKfC7TN84n6vW9OG33ohO4vPtGWtkMCkQTERlqD4te2RC0SfuVKOYAD89hBaQt
         rSpzWrnvhJSWxXgIgmAgq/UKNZNWET8CZTiiEaTSS0OyOrqM08lX7l2LFFpHaC8LaeCG
         oNFZfgWWLtEpzioFv/9MqhkN0aIVpWde0wv7mbAmia/fZLK4n8qyvQxtbkAys0NmuT84
         HMqw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ30tD8MFjKzws4kv0k13WgVw0OtW85eUJms0eMIpvJ1Hx81YCCN1Hxyn/avQsOSTLr8I6ylFOibIAU40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyray0Hbv9+SvQQOtrSNaoRAzKFqt2VO8/wu+plPCudR8xrF14
	sENc9i0ITgqan8w0nFwlMFtuztKhxXLd+H6RexGisbQ4vFPzpNZh
X-Gm-Gg: ASbGncuRneqRLe8gqK7bxaT4EozwImoylOpIRC0ajun/5ymaiHIG9WveCQ9nwsI40sk
	H1CrMDsbX9K2OXI/qi8HHBSivhbbYjsdSMLmTt6Gi7LnJSVogAb9k9MWMhC+4nMPTs9sMbCzCj9
	rymgGzIrhPfpmmnafMVmmo+dS9hpX8OpuEjIUnkQkzCFJ4NXsU+wVipiaWZblmXOk8ikc5u3n66
	Kn97ioXsUvu7Rk2iBIreEQ6fMP4jri4pkXN+W68XoC1OhOl9041mU84TBY47R+W/8kj7bPvouv7
	xYiBXeicJCVhduzld1IkCLgtK11rHomizfGl6WJnVG6XI98+/CbDbTREGeebmIShs3XieSI0
X-Google-Smtp-Source: AGHT+IF9iSDHSo1SwBY2XtqSKoMWqyfDy/788QmqA4lDx5PAEuFwmN9tuLzZW1bUII7c8/MmEndg1w==
X-Received: by 2002:a05:6402:268d:b0:5e6:1caf:e70e with SMTP id 4fb4d7f45d1cf-5e61cafe74fmr8517620a12.28.1741595770727;
        Mon, 10 Mar 2025 01:36:10 -0700 (PDT)
Received: from foxbook (adts246.neoplus.adsl.tpnet.pl. [79.185.230.246])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c7669ef7sm6487671a12.54.2025.03.10.01.36.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Mar 2025 01:36:10 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:36:05 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] xHCI: endpoint state maintainability and small fixes
Message-ID: <20250310093605.2b3d0425@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

These patches are mostly independent, except
- 2/6 depends on 1/6
- 6/6 depends on 4/5 and 5/6

It is assumed that issues with EP_STALLED are resolved like below.

They document assumptions currently made by xhci_urb_dequeue() and
xhci_handle_cmd_stop_ep() and clean up this code a little to make it
more maintainable.

Some potential issues with no known significant impact are fixed.
I haven't tagged them for stable. Maybe 5/6 could go, just in case?

Michal

--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1770,7 +1770,7 @@ static int xhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 	}
 
 	/* In this case no commands are pending but the endpoint is stopped */
-	if (ep->ep_state & EP_CLEARING_TT) {
+	if (ep->ep_state & (EP_CLEARING_TT | EP_STALLED)) {
 		/* and cancelled TDs can be given back right away */
 		xhci_dbg(xhci, "Invalidating TDs instantly on slot %d ep %d in state 0x%x\n",
 				urb->dev->slot_id, ep_index, ep->ep_state);
@@ -3207,10 +3207,14 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 		return;
 
 	ep = &vdev->eps[ep_index];
+
+	spin_lock_irqsave(&xhci->lock, flags);
+
+	/* Unblock the endpoint as device side is unstalled now */
 	ep->ep_state &= ~EP_STALLED;
+	xhci_ring_doorbell_for_active_rings(xhci, udev->slot_id, ep_index);
 
 	/* Bail out if toggle is already being cleared by a endpoint reset */
-	spin_lock_irqsave(&xhci->lock, flags);
 	if (ep->ep_state & EP_HARD_CLEAR_TOGGLE) {
 		ep->ep_state &= ~EP_HARD_CLEAR_TOGGLE;
 		spin_unlock_irqrestore(&xhci->lock, flags);

Michal Pecio (6):
  usb: xhci: Document endpoint state management
  usb: xhci: Deduplicate some endpoint state flag lists
  usb: xhci: Only set EP_HARD_CLEAR_TOGGLE after queuing Reset Endpoint
  usb: xhci: Don't change the status of stalled TDs on failed Stop EP
  usb: xhci: Avoid Stop Endpoint retry loop if the endpoint seems
    Running
  usb: xhci: Update comments about Stop Endpoint races

 drivers/usb/host/xhci-ring.c | 102 ++++++++++++++++++++---------------
 drivers/usb/host/xhci.c      |  16 ++++--
 drivers/usb/host/xhci.h      |  58 +++++++++++++++-----
 3 files changed, 115 insertions(+), 61 deletions(-)

-- 
2.48.1

