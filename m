Return-Path: <linux-kernel+bounces-543419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8839A4D55E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2150C171D58
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4331F8922;
	Tue,  4 Mar 2025 07:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZyU+aaq"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0411E2847;
	Tue,  4 Mar 2025 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074707; cv=none; b=NYD11xwUnkteZKpz5tBp+KfPKBQPKMQ4BIEGKWrIXd8HoJDtOrrZhxkdWF6fbT9NL1OJ8O5VwB1zcwqUOnYISGuvKdh40zifhFfzcA6ahggHZ/c4+7eRjVXPKLCRH8mzu9BpPZGUZqQwW/FoNm96uxC9X6KwZSXOGCV961mEK4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074707; c=relaxed/simple;
	bh=3TpNgotXXXws56CMvycct3iSNi0ygaBLcIYxqa2zBRM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dVzyC36olOUMHCXTUu/QKftTJMJ5FE25P8fcuP1y84YHOSgaEcmOGNUNEnaJtarg7rMN7kyoN2Db1Ka+1Pe8rU3v+BwBm9+uNlI5cvv0QEWavqyg99eh3b+c/FXX/C6KxHEv0u0JOfFec1lDp0Kuc7P3rwc6mwEoNYkNM9noUyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZyU+aaq; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaec111762bso973016966b.2;
        Mon, 03 Mar 2025 23:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741074704; x=1741679504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ejFSo8OEvE0ZO3UcRk2jROT18Sr7YS00DdCsHMeAq4U=;
        b=IZyU+aaqNkFkc/lMJInMBpBN0PP9CYW4NARoci/QGuvo/UMJGol+ogzh9r2H/w8GZN
         SKRoGTsSth6Lm/XvHb0Y6qOt29nj0gcJLw5mdvxZLiVIx0qTZfdBvS08WWCYMzGyBlkc
         sLEBdgX9zuKh91wrEWAyl4cdyUQPPRMZIw432s44goFF4T5LFgtT8gubBCqHAC48cMmu
         2n4v6Z2HNX/8dGM1y9eDNAB6bRaeJTXi3NkkShsFPpU3oXexSzBLhS0SnSHhP702I6bM
         9S5Tb4vPmqyWDtTa0URq522QgWiM8g77eLdt9FWyEYRmQFoOGfrGJ070lPdxRQfUUWyE
         +82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741074704; x=1741679504;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejFSo8OEvE0ZO3UcRk2jROT18Sr7YS00DdCsHMeAq4U=;
        b=guZZCq2Gw3XEtTPDGXyVLQMCve5w+HEYz+CcdEDU77CVJTlrhDd8K6DkCj42G4MRLF
         CL2JsKzZWh40taFzU5Lc5401yp/Qo1WNx/8fAjzQf6m77Uk00Xmb0isSrRTWXftjwz0N
         En7MFjeO+0RAgCvKGeejEidP96K87los2Ph8t/zX9ReY+4/XFjmM+XVewwJtRRKO1aoK
         QD331aU+2b4Lgwcg1tTbbWiLyuUx4X3W38dkYH8LMw/Eh2O3O75jEfGYa32gAhVWEAzq
         WRo3rIpn81Qd8Mjt/FLV9NbF6TrmrDl4GhoCAQw0RDR2lUMnfncJLy4ZOgJoU+Y55Vvn
         vfHA==
X-Forwarded-Encrypted: i=1; AJvYcCXcD6wQAfB8k3RXFSmR5XGx4YNhbY24lsXI657eXCul8Y+ZTcK1FlUBtln0pB4teK5TSQvhrWcAiWDdMto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLNKOxZPGji3JJNPzJUt8mllsNdHtnUcYGTJb6IrjhY88iohYo
	vJ8hlQKlbFPWa0PgrVr7ZP+PjnNEBvVMzKqKuzNZFY+QY8opYfdu
X-Gm-Gg: ASbGncs9inAc+wbPn7NxACZ0Dm/2645luUZxulNvD63TrB9dP4x+EvP6NtkypZjiZQZ
	+ToaeCDUEXVjkeiulp/EMs+9yGtnAH5ABENmvYMegr8upjDo+HG66lEQeyUyNOEcgiS6bNayrfv
	vGdAqMVWCRDH2uGkjGIUv5njNcCiHMgXsGMrbkU7BiUG5t3187D2bK9Z1esWwc56rX+M9BxRYAG
	dUhnIIZGPU5HB+P/mwIrZbIOEJf7ChugZcSHte7SuwMLzrw65EehPP7xQg0bZa4uQC9Wo90+Ysa
	ajk/zdIHO7bVSp7j1LMnSh/gNTCY8dFmsBMxg0mBHIgLDpQWr6PY0z8xnDC4PQ==
X-Google-Smtp-Source: AGHT+IEU6uOxnBzRpc2rr8JL/GPBOrFpD7dFy2K738H0sIbKWD7Az+d9BbDPL4ebRRymRAZugOLWcQ==
X-Received: by 2002:a17:907:7b8c:b0:ac1:d878:f87d with SMTP id a640c23a62f3a-ac1d878fbbemr501062666b.56.1741074703641;
        Mon, 03 Mar 2025 23:51:43 -0800 (PST)
Received: from foxbook (adts246.neoplus.adsl.tpnet.pl. [79.185.230.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf58fe64f5sm525816466b.133.2025.03.03.23.51.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Mar 2025 23:51:43 -0800 (PST)
Date: Tue, 4 Mar 2025 08:51:39 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: xhci: Fix host controllers "dying" after suspend and
 resume
Message-ID: <20250304085139.4610e8ff@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

A recent cleanup went a bit too far and dropped clearing the cycle bit
of link TRBs, so it stays different from the rest of the ring half of
the time. Then a race occurs: if the xHC reaches such link TRB before
more commands are queued, the link's cycle bit uintentionally matches
the xHC's cycle so it follows the link and waits for further commands.
If more commands are queued before the xHC gets there, inc_enq() flips
the bit so the xHC later sees a mismatch and stops executing commands.

This function is called before suspend and 50% of times after resuming
the xHC is doomed to get stuck sooner or later. Then some Stop Endpoint
command fails to complete in 5 seconds and this shows up

xhci_hcd 0000:00:10.0: xHCI host not responding to stop endpoint command
xhci_hcd 0000:00:10.0: xHCI host controller not responding, assume dead
xhci_hcd 0000:00:10.0: HC died; cleaning up

followed by loss of all USB decives on the affected bus. That's if you
are lucky, because if Set Deq gets stuck instead, the failure is silent. 

Likely responsible for kernel bug 219824. I found this while searching
for possible causes of that regression and reproduced it locally before
hearing back from the reporter. To repro, simply wait for link cycle to
become set (debugfs), then suspend, resume and wait. To accelerate the
failure I used a script which repeatedly starts and stops a UVC camera.

Some HCs get fully reinitialized on resume and they are not affected.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219824
Fixes: 36b972d4b7ce ("usb: xhci: improve xhci_clear_command_ring()")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 45653114ccd7..0099f504c86a 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -780,8 +780,12 @@ static void xhci_clear_command_ring(struct xhci_hcd *xhci)
 	struct xhci_segment *seg;
 
 	ring = xhci->cmd_ring;
-	xhci_for_each_ring_seg(ring->first_seg, seg)
+	xhci_for_each_ring_seg(ring->first_seg, seg) {
+		/* erase all TRBs before the link */
 		memset(seg->trbs, 0, sizeof(union xhci_trb) * (TRBS_PER_SEGMENT - 1));
+		/* clear link cycle bit */
+		seg->trbs[TRBS_PER_SEGMENT - 1].link.control &= cpu_to_le32(~TRB_CYCLE);
+	}
 
 	xhci_initialize_ring_info(ring);
 	/*
-- 
2.48.1

