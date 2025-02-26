Return-Path: <linux-kernel+bounces-533164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B7FA4564A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5782B188FBD1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B7A26B0A5;
	Wed, 26 Feb 2025 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcsBVOTo"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6312267B7C;
	Wed, 26 Feb 2025 07:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740553507; cv=none; b=rc5i8j833NTqf/N/EOILPRTmP2Fp+nS4DAw8W3/VhBlCUk9Ci6f4e/kTu6L5Ht9PkRKTund5AaYm0l5cuqcQk4EzgeRXOfqqDYqP3zsQSaChYpBglYoisvDVo7wFgMe3BVEwWPNHVrJb1mE2z1EjOqUZyjo4gSLeJw/eW2aWVbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740553507; c=relaxed/simple;
	bh=Mwe1Q6lK+MDpBCu+LDN9wvfYhowtWJBOsvWFBI5wg7M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UjxgV3eYzlQ7/dUWyNuaCyprbVDEQ+EvNFsQ51YcETX0r2BGkQllgxBFniFKiYd/QanFqhkRH6zAndR3Mf9tenivFhE3H58/n62trwNRpyL9AFkEeOSfRFxobaXb8OXVwHvpKbxy8RKGCeNNR5m/kVxMWgPI8SztPV98bFFLGnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcsBVOTo; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e0505275b7so10318040a12.3;
        Tue, 25 Feb 2025 23:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740553504; x=1741158304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZfqkUpDLwGIxh59vSygbGAq14kIWND9MVXfHaC/zN8=;
        b=PcsBVOTo42QkLeZRjNy9whJCopElgprKDpPN8UvaZNfmDI02FcLPWx1/blzolGAgsZ
         5JugOBjG4mkMEc9WBL0A//dWeVrfIyklJDONvTC+/chaMON7uS/J+9o/bPXr3DZ/momX
         mN+t3TchR9Hx+roEczgQDG/IeEJt9jKLLFRuUG3+1Vf0fQWZicqB4EqE4IASqLWzMvVW
         F0h3K5jetbMaRWqClKzbwEZl8upQZPmvUilOob6DKOASG5h83ytd/LMslWCJ/YKCx7aX
         woyWnTWaQdVAeaWa9szTBEL7QX5urNWIiNyqWCpLMwEnmNgn/JM+g2oJhp74v9LNMXpw
         pehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740553504; x=1741158304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZfqkUpDLwGIxh59vSygbGAq14kIWND9MVXfHaC/zN8=;
        b=oET+V6yayFO47LPD8hV8PvKUCFcT5SUwNJDUWcX+sN34wb1wthEAW9JW4YqZCd4N9F
         lgZLp+HRWBqCzyLe4IRktI1ghDe4kVOceCtZCsAtafMZEFFYxPpShrPxXMs7d/dgSF1S
         tKDOgYMSPfrQ9h2g6CPe+rtsKWuhiUhEnv+AZYD2Uy8GWYltgzq/cesEhTc6xn1fLnLA
         3faSn1uMnfyLvNx5+SbFDUptDqo85S5+qY4LFKuGn7PxqxbjeZ7ZQQTgEOtTGb7LSc5U
         IfGkiU6pKY6Wjst5AJGkyvIFLoyoy6DuTh09wzaoDrgancUFXiFhvl5MPB5fJVi2j43q
         rVDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVn5YnqfzT3IbT9NQkV/Lpv5QLCbc2Q78ey1F5yT5N/rIpHmlyUVFMqoP+HwiysyfNnsR5RvkWkDNUpiQ=@vger.kernel.org, AJvYcCWaVpyZqh/FMD/1qG5kT/pCovEOnT/WO1qUDNlxq6NJ5Q9RAzjfFdWJke/pF23C+kjHM6jaAQ/hsyIc@vger.kernel.org
X-Gm-Message-State: AOJu0YyyiLKY1Q2h73jm7ejOaH71MkvFohTZ53uTapTVshW07lM3NXHB
	ls5oKO0qNpHve/cKrYuQpdfw4T2oLgenY+fKQmfzscJd/qanvIFb
X-Gm-Gg: ASbGnctzZuPGp1VRkm37VHLLR2chvs9AAYWPjCC26JLtwefbci2Yo+n5WN4uYwjsFtJ
	ABuTRUSyaPV4wbq4xbsoNXnr2xC3a9OchROOD/OKiWMWrfJE/vwi3yaML4xtS0Ev0ajsHAqDK1z
	DhOjXmVYggrhFYSJwTcitVcoSlzM9jJN3zSOMGI6PTktUAAbHhvdhLRU4ro2WwFUGGH0GhZBPqD
	9KYGBzxkgCFLAfWmraOP/uAzXBPQthiEG+muR6l2EOS6nnJy8CmFDqXsSZ9JS/IqRjXWeaHi7f9
	31elt30GLMulNDi/lgBuEWs4VaULwSA2T3Bwb1SK
X-Google-Smtp-Source: AGHT+IHYcwYNitr6Qg5vYK1r+V82tKKkgntkWLDcD3tpc23zc0lbhcAIrXViLxi0Yu1694jE3mP9ew==
X-Received: by 2002:a05:6402:354c:b0:5dc:c531:e5c0 with SMTP id 4fb4d7f45d1cf-5e4a0e19b0fmr2269918a12.27.1740553503845;
        Tue, 25 Feb 2025 23:05:03 -0800 (PST)
Received: from foxbook (adqi59.neoplus.adsl.tpnet.pl. [79.185.142.59])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4a6353eb6sm540138a12.48.2025.02.25.23.05.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Feb 2025 23:05:03 -0800 (PST)
Date: Wed, 26 Feb 2025 08:05:00 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] usb: xhci: Expedite skipping missed isoch TDs on
 modern HCs
Message-ID: <20250226080500.4299ff8a@foxbook>
In-Reply-To: <20250226080202.7eb5e142@foxbook>
References: <20250226080202.7eb5e142@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

xHCI spec rev. 1.0 allowed the TRB pointer of Missed Service events
to be NULL. Having no idea which of the queued TDs were missed and
which are waiting, we can only set a flag to skip missed TDs later.

But HCs are also allowed to give us pointer to the last missed TRB,
and this became mandatory in spec rev. 1.1 and later.

Use this pointer, if available, to immediately skip all missed TDs.
This reduces latency and risk of skipping-related bugs, because we
can now leave the skip flag cleared for future events.

Handle Missed Service Error events as 'error mid TD', if applicable,
because rev. 1.0 spec excplicitly says so in notes to 4.10.3.2 and
later revs in 4.10.3.2 and 4.11.2.5.2. Notes to 4.9.1 seem to apply.

Tested on ASM1142 and ASM3142 v1.1 xHCs which provide TRB pointers.
Tested on AMD, Etron, Renesas v1.0 xHCs which provide TRB pointers.
Tested on NEC v0.96 and VIA v1.0 xHCs which send a NULL pointer.

Change inspired by a discussion about realtime USB audio.

Link: https://lore.kernel.org/linux-usb/76e1a191-020d-4a76-97f6-237f9bd0ede0@gmx.net/T/
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 995f8a9b5b53..ad5f0e439200 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2481,6 +2481,12 @@ static void process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		if (ep_trb != td->end_trb)
 			td->error_mid_td = true;
 		break;
+	case COMP_MISSED_SERVICE_ERROR:
+		frame->status = -EXDEV;
+		sum_trbs_for_length = true;
+		if (ep_trb != td->end_trb)
+			td->error_mid_td = true;
+		break;
 	case COMP_INCOMPATIBLE_DEVICE_ERROR:
 	case COMP_STALL_ERROR:
 		frame->status = -EPROTO;
@@ -2791,8 +2797,8 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		 */
 		ep->skip = true;
 		xhci_dbg(xhci,
-			 "Miss service interval error for slot %u ep %u, set skip flag\n",
-			 slot_id, ep_index);
+			 "Miss service interval error for slot %u ep %u, set skip flag%s\n",
+			 slot_id, ep_index, ep_trb_dma ? ", skip now" : "");
 		break;
 	case COMP_NO_PING_RESPONSE_ERROR:
 		ep->skip = true;
@@ -2841,8 +2847,8 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		xhci_dequeue_td(xhci, td, ep_ring, td->status);
 	}
 
-	/* Missed TDs will be skipped on the next event */
-	if (trb_comp_code == COMP_MISSED_SERVICE_ERROR)
+	/* If the TRB pointer is NULL, missed TDs will be skipped on the next event */
+	if (trb_comp_code == COMP_MISSED_SERVICE_ERROR && !ep_trb_dma)
 		return 0;
 
 	if (list_empty(&ep_ring->td_list)) {
-- 
2.48.1

