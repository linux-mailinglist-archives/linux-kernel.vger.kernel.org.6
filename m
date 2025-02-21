Return-Path: <linux-kernel+bounces-525011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23BCA3E9CA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CB7B7AAAAF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E421845009;
	Fri, 21 Feb 2025 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxRAiP5O"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9331B18A6B0;
	Fri, 21 Feb 2025 01:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100743; cv=none; b=jIPW9bfGPkYciXnNjXMxUEJPYEr43HPVUqwuGJlbOm3GLQfONDiOLUoX8WkrlGD1BUzeiPeATZfxurJc1O6trP8+bsQ87/IMb9QHJkzRUg85kOIq/siZu7KTHZ1OaGBF49p+amBLlFBZhTbt3/0p3dxA0//h00GBKc7S5/t+SCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100743; c=relaxed/simple;
	bh=ZLi32eHzVBzb0+S2Hyi563N7biVmoJrvni7xDdRZ/2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwXpMrJPQYn2Gq1fgT+QHHZXTcUj1NNrDnYnLk5Mv4UtQD1ZhXzwzb1Dfd4blY2UwcJ1fmEg1HkyWmf/Gss5BjB/CKQEj/8id4hq6yRW2hkkcrHX7XKTc0A8oCqhvxo113RfS+hxDF3PAV1PNRW451gAvxozLNW62SPS76C9QTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxRAiP5O; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e0939c6456so2687881a12.3;
        Thu, 20 Feb 2025 17:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740100740; x=1740705540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+iEG7L5f/jy2xV7Yyu1dhl1MhKYSR3nFi6wl+Gwc4I=;
        b=KxRAiP5OwrCFR7pCAYdk/X3bsypJGZQy+sfEzjz125JmS0/e2eY2HRbPRQlgb/k8Mw
         eGQPwLna72RinBfvKCs7mP/MKWvxMrzY8AXxMkXou2fq+Pj27Hg6cN+PhrLu1bM4cZLF
         F/a2H3vZCjogFVBVGXX67k7hxSIw/x7ynbut+YiXUh/TPClNy5etHE+mXEcx3UiXBJ3N
         PjBAb+/WZo3C3H5r5l8X8Awsas3YxWMheamJtfnZdF/ilynRgvqO+ZPe+hlrsbvLISz8
         F/bccv1oeV/tj0hWTXn7Gs2dRaLgo+xsJUxEE9nkUR2nSJOR8E9kTo5Yvi1C9NIo1K/K
         G0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740100740; x=1740705540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+iEG7L5f/jy2xV7Yyu1dhl1MhKYSR3nFi6wl+Gwc4I=;
        b=XAvBzSd8SvyI1CcL/HR+g5jSz/PClbFSwY0r1UmVJplBOcq8XnxrmIa2A0ZHT5Z3Ip
         D8JiVC5/bhAnNjOYEKMp7gA015J9Lgdn7/XOAX0UrseS45mHvo0vYPzy81ZGLbEKJZyj
         O6Jx/9PBl2VaqylLHFSeQxFcQSSdeKoXNCtzpLbl2WkavrUIk66zHLVs0iPPRi2uG2uz
         5pJBPTMUb2hdSF4OutgPoY3EdyQu+LqnGcz9RVdlxrdTWpCpjseCMNtSIipEO5uuYKbl
         agD4RF7VW0Pg037JMxyIryJnlpJ0qM7jHy10m0s+AHLTcNs6mEbrhOiykHhSjb4mdfe3
         Hnag==
X-Forwarded-Encrypted: i=1; AJvYcCWnp9Gd/ZPiInHNw7XpggZT6kmx7wUgJ9xle2gKuRMi1D5nGz6djevZdK9jQ81NiGYS/9oKIeIvUG3muZc=@vger.kernel.org, AJvYcCXVWAZyT3Um6nnvmNu3ZVIz6FbX9YeyTr743SfPMwdJnF38zU8t3Xu201GyDwlrZVCF6OJT6xBg/LSe@vger.kernel.org
X-Gm-Message-State: AOJu0YxR01eWKpy5hnhmo75HfSmSiT4rIGNyb4FfMeK7uZ28wnd/hTlg
	o+CyP/8NhIwJfYyzh7yw12OZ/tlEMkbaYTyzYbqsfGphTB5GgAdq
X-Gm-Gg: ASbGncu7RI6vUkATuh3jqCSLcQOO08SE/50weFtmEdn+SN5cDESw0InXebFZToq6Lry
	1eDAmnCYpcPfL3Fe1UqjSuh3JMDdU43SxT/baJriImV2WJ2bAxLNMGQzP0+Sx8YCno4jE+nTwbw
	60J1JZO+tjJsnXt7IWAxWJar2kAkW5Rn3PFd7/ETmNu3FEKCVdodtaYXhOGyHkX9/1IWol/SSoA
	QqHc5XZD0BDUk119oUH7AZppX6JlBXYORsaJVQE0CZVLwXo8c/kiXM4TZm9eGMY+sW2CxiCC8Rq
	gby2mK4KSieqnGPG03EAuZPUqQblaiUW
X-Google-Smtp-Source: AGHT+IFMEv+hXN3BMjMZTmOB8KI/HxEtm63PLVWUj3GnEV/M7NqMcgdBcB/JZ6vNL3QoQNNJ5LiPXw==
X-Received: by 2002:a17:907:7eaa:b0:ab7:c00c:680f with SMTP id a640c23a62f3a-abc0de4f6f8mr79472366b.53.1740100739565;
        Thu, 20 Feb 2025 17:18:59 -0800 (PST)
Received: from foxbook (adtt173.neoplus.adsl.tpnet.pl. [79.185.231.173])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbb860fc11sm624441066b.124.2025.02.20.17.18.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Feb 2025 17:18:59 -0800 (PST)
Date: Fri, 21 Feb 2025 02:18:55 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Niklas Neronin
 <niklas.neronin@linux.intel.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] usb: xhci: Fix isochronous Ring Underrun/Overrun
 event handling
Message-ID: <20250221021855.0f188018@foxbook>
In-Reply-To: <20250221021712.48c07fe0@foxbook>
References: <20250210083718.2dd337c3@foxbook>
	<20250210084220.3e5414e9@foxbook>
	<7bb25848-c80e-4ba8-8790-8628951806b3@linux.intel.com>
	<20250221021712.48c07fe0@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The TRB pointer of these events points at enqueue at the time of error
occurrence on xHCI 1.1+ HCs or it's NULL on older ones. By the time we
are handling the event, a new TD may be queued at this ring position.

I can trigger this race by rising interrupt moderation to increase IRQ
handling delay. Similar delay may occur naturally due to system load.

If this ever happens after a Missed Service Error, missed TDs will be
skipped and the new TD processed as if it matched the event. It could
be given back prematurely, risking data loss or buffer UAF by the xHC.

Don't complete TDs on xrun events and don't warn if queued TDs don't
match the event's TRB pointer, which can be NULL or a link/no-op TRB.

Now that it's safe, also handle xrun events if the skip flag is clear.
This ensures completion of any TD stuck in 'error mid TD' state right
before the xrun event, which could happen if a driver submits a finite
number of URBs to a buggy HC and then an error occurs on the last TD.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index a278f284f4c0..4cf17801a233 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2632,6 +2632,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	int status = -EINPROGRESS;
 	struct xhci_ep_ctx *ep_ctx;
 	u32 trb_comp_code;
+	bool ring_xrun_event = false;
 
 	slot_id = TRB_TO_SLOT_ID(le32_to_cpu(event->flags));
 	ep_index = TRB_TO_EP_ID(le32_to_cpu(event->flags)) - 1;
@@ -2738,14 +2739,12 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		 * Underrun Event for OUT Isoch endpoint.
 		 */
 		xhci_dbg(xhci, "Underrun event on slot %u ep %u\n", slot_id, ep_index);
-		if (ep->skip)
-			break;
-		return 0;
+		ring_xrun_event = true;
+		break;
 	case COMP_RING_OVERRUN:
 		xhci_dbg(xhci, "Overrun event on slot %u ep %u\n", slot_id, ep_index);
-		if (ep->skip)
-			break;
-		return 0;
+		ring_xrun_event = true;
+		break;
 	case COMP_MISSED_SERVICE_ERROR:
 		/*
 		 * When encounter missed service error, one or more isoc tds
@@ -2818,6 +2817,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		 */
 		if (trb_comp_code != COMP_STOPPED &&
 		    trb_comp_code != COMP_STOPPED_LENGTH_INVALID &&
+		    !ring_xrun_event &&
 		    !ep_ring->last_td_was_short) {
 			xhci_warn(xhci, "Event TRB for slot %u ep %u with no TDs queued\n",
 				  slot_id, ep_index);
@@ -2862,6 +2862,9 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	 */
 	} while (ep->skip);
 
+	if (ring_xrun_event)
+		return 0;	/* don't warn or complete any TDs */
+
 	if (!ep_seg) {
 		/*
 		 * Skip the Force Stopped Event. The 'ep_trb' of FSE is not in the current
-- 
2.48.1

