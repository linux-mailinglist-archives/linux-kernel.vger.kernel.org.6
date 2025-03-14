Return-Path: <linux-kernel+bounces-561054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D2AA60D07
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033A63B22CA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A761EC00B;
	Fri, 14 Mar 2025 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiNaDmH0"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FE41DD877;
	Fri, 14 Mar 2025 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943939; cv=none; b=tfSliXFCIleK4dtIGQpa0pANWmkh3KIEADGrctzfkyKAQRJc6QtS0Yy0W8WB0NM8FGSQrVJkTov0ML8crZWiJUDPJhZwhLI4AHms+yh6Mno4wI91jF89FoHezx20zd5428RdVds6+IuyChdotczjZgLiuBTVWTW2oVNBNz6cDIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943939; c=relaxed/simple;
	bh=bIn+zoQVbQkMA1Z1oVVhi1cYgFOhA1GtQSF9N2tFH9A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=k2BE4y88hkF/AaXWg/7xM3H1GJzwHPo5xqBoCpZ8eICZhDwsMXOQWVuylqslNCVjS4alg/xTG0zJkj7pwcuanma2NsueImB7PhTZxi1X4ejU9m6W7vyAjjnx2SND4wFn0HcRcN9Wp8yMNpgrS2ehdkfiRkh6vOqQR87AYRBFk1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiNaDmH0; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso389534866b.0;
        Fri, 14 Mar 2025 02:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741943935; x=1742548735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3M2JVYZKQcy2mFwCbcTw879hw71XW4FHz74Agqgk/rI=;
        b=AiNaDmH07T580BPCyTigIYQdxUtN9LXphWVUl+f+qj/eISYVXuRfxwY+vaaJDqlUUs
         M0iKp/1hiF0NxcEKTxHN1/XT+A4kb/FWKvrv01r5aeDqIY+86GO1syrHjxZo6Xlr/5DX
         Gv9H467bF+ZRcIlMpF7zdDaxo1NXu4EiLikAIeC1jx5wb/wiZpOI++CXwbYLQK5SiU3u
         Kn03Dc/xvTJ09+Y2pscWO+y6HaqEvkwwXej3QP4rKv3AzWocG56Gh8Oqluxkg4IkSrEm
         cjC6TCytdanb+gIjPD/KrEcq/5Txc3FX5uLyornhws2B7FRlfLXo1zPwOVIWWJjoprwu
         EcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741943935; x=1742548735;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3M2JVYZKQcy2mFwCbcTw879hw71XW4FHz74Agqgk/rI=;
        b=RlDmI8uxWa3VrF59uRrMvCCwmIRZ1df+IH42zsKGCXUEvF85UPXCb80fQAAPD9upU8
         jQMFy0H7/HtK/k/s+itFOmrXrUqkYz/gwAyGnH4c9unIrnassQ9jzt8n6VuFlz7rwSaw
         O8rO/JAPjgMKbMUPV4n5EV5XNe1R/KT2hE7YX5fNQG/9pR3SwRJvi0t1pc8XUz8vGKBB
         gebuix10OeCqxj7X7eDCSxXws1gQP3qA84OZyrlqbyCHfB/GDkW1sotyY39QPueMHIzu
         PO/p9ZsnkrZCRKs1BQN7GzVlqXnOR0g1Fp4nRL1hI57WoexFDlGNmYn6USfISXBza8rc
         uzTA==
X-Forwarded-Encrypted: i=1; AJvYcCW1r2Rvlzg7Zcfz8vP51TDm+4zfSXYZ8kiKnI5p3z2wTKS21uqzXYBeL4dHp0YLUmOSPG4OI5+ESynkdqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYSqyAiNbzcumXcUKJ6JE+zGeseT192L3FjKAov3V6BmL9+9Uc
	TZ0sOG9by4PkOSeeYrfFk6aDRpxwBEDwV8ObYLbJdHFbAsduqVrH
X-Gm-Gg: ASbGncvXJLazz5wTXI/vzC7tGZx1oMo640wnSJhs2mDo9l6RrRos1eGdt0odD87kWlb
	nG8ur3Hp2twMlkqXPOLCs2ykz9Y8MhCmcaS/70f5BHqtkXgT5QNenGt1DV5t7r71b+WrdIQYBkP
	uY+/J+bndcXOLjbM8zZyNGu14CLBHwP3za3Mm0M9kKmfAnER6xqGXvEX1k0sgDqx5MWa1lVt2+2
	OMc5eZvSfsWX+mfHqvctAxPTTa1vzTkvIwdXo++x/Tsf5FSo85kBBl+l6ItUtuXoL2T+fkLEQmp
	XQ1JVO/1Z9hV5278fFcVzHAPhS7etwUq8znh4IaBNo148tF2JffwYfB7LRY07nf6OSdTCA==
X-Google-Smtp-Source: AGHT+IH9sODuXmZ94FpEyYFL2cPgqj/5X/9ctoxA1MRwa2drLzcF03ffPzdi5CGueo/Jw8wThrUJ1A==
X-Received: by 2002:a17:906:d90:b0:ac3:3e45:44bc with SMTP id a640c23a62f3a-ac33e454790mr4952366b.9.1741943934839;
        Fri, 14 Mar 2025 02:18:54 -0700 (PDT)
Received: from foxbook (adth23.neoplus.adsl.tpnet.pl. [79.185.219.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147f1424sm196873066b.71.2025.03.14.02.18.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 14 Mar 2025 02:18:54 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:18:50 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: xhci: Fix Short Packet handling rework ignoring errors
Message-ID: <20250314101850.0160fc14@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

A Short Packet event before the last TRB of a TD is followed by another
event on the final TRB on spec-compliant HCs, which is most of them.

A 'last_td_was_short' flag was added to know if a TD has just completed
as Short Packet and another event is to come. The flag was cleared after
seeing the event (unless no TDs are pending, but that's a separate bug)
or seeing a new TD complete as something other than Short Packet.

A rework replaced the flag with an 'old_trb_comp_code' variable. When
an event doesn't match the pending TD and the previous event was Short
Packet, the new event is silently ignored.

To preserve old behavior, 'old_trb_comp_code' should be cleared at this
point, but instead it is being set to current comp code, which is often
Short Packet again. This can cause more events to be silently ignored,
even though they are no longer connected with the old TD that completed
short and indicate a serious problem with the driver or the xHC.

Common device classes like UAC in async mode, UVC, serial or the UAS
status pipe complete as Short Packet routinely and could be affected.

Clear 'old_trb_comp_code' to zero, which is an invalid completion code
and the same value the variable starts with. This restores original
behavior on Short Packet and also works for illegal Etron events, which
the code has been extended to cover too.

Fixes: b331a3d8097f ("xhci: Handle spurious events on Etron host isoc enpoints")
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 9e50cc3354cb..a35ad5489790 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2916,7 +2916,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 			if (xhci_spurious_success_tx_event(xhci, ep_ring)) {
 				xhci_dbg(xhci, "Spurious event dma %pad, comp_code %u after %u\n",
 					 &ep_trb_dma, trb_comp_code, ep_ring->old_trb_comp_code);
-				ep_ring->old_trb_comp_code = trb_comp_code;
+				ep_ring->old_trb_comp_code = 0;
 				return 0;
 			}
 
-- 
2.48.1

