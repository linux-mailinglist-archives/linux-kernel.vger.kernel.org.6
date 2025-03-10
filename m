Return-Path: <linux-kernel+bounces-553740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE67A58E51
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98BA93AD919
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D475D22370D;
	Mon, 10 Mar 2025 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsRYYhbj"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA2F22331C;
	Mon, 10 Mar 2025 08:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595931; cv=none; b=NWf/vUpGHGj2bQ8hixDLA/iF4QRxhEPEfeil//A69Nle5bJ3rDNmFGhZ4doh8u7nAbxFmDv0EbeA0M7P6CH+o3bybkrLyIjCZ3DxWFyb//pfK+lmElVGHo2Fl9DnK0fxDdVgugx/q7KvBjkGLfFRmIxz4SBgMnYIJXZ4g8NLjJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595931; c=relaxed/simple;
	bh=X/GmOW/hNTjDdVCoJzXZunwFoXnbdmHANH3kWmdFLtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4Wqvs1fahCewj1SetNKxVlR/bv/YSkZ5vPso65Yy+0JY5q+cEetm/HfA0jTtiAfRqDG0zny01+fv8uj2HNgugKQjAPdXTEDHcBtyev0xuQubOywwu8I+YUY7obsR9LJ16mDMcemrRs1JftYkM7byhvJAdzSPHMhqO74WG4gBDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsRYYhbj; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so690560066b.3;
        Mon, 10 Mar 2025 01:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741595928; x=1742200728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mc4o3nge4FTwi3uakH4SDvIBS7mKNo+if4JgTye23cA=;
        b=MsRYYhbjr6++41TqfLsUQMaOKmWdCUTT9BsNWIMDAt91jRlIbdcgDIUJVrMoTjHdqc
         rNfzJsyxTKdlbQTxo63pE6RZc4A5lJjKIIEKg2NXzpNY8DSMxDCrB2hDnL8LsfM4I2eu
         mKDsf6usYy7rbTJXbUaSMmOJCgmbTknVmSHSJQ/aUdjVIedMzRqlH4DhSiuOr/74MesB
         iMYQQvqwv6iHTqtsiMvNdbNKTTjmRV2jeocjl15i1+/A+lpBEsEER0sryDtVO+vUiddp
         8L75rhpgfBGeXidytc0FOHL8JKRg9/zolxfNJho779PQrskMeP1M5et0eXUEphLXixFH
         lROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741595928; x=1742200728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mc4o3nge4FTwi3uakH4SDvIBS7mKNo+if4JgTye23cA=;
        b=Rrjq6K5ALfN/BxeYS8CSEor7YGEBSN24m6sJYdYOGXiAVzfV90t3zzHVP33/ninges
         r75f2x3bVypGVi2qRBk/p0zJzwZpQzHUxGOz4L/5ZbNJuGOvMfPOPDtfPg9GvFP+oXt3
         9gKFLCVhtGNr6b5WrucY3d8Wd8lRStLj958MJcXnAGUSrEoNNgd//zjMa3wlGYoa38Mg
         JLNpEJ/r09qBEqcHsf8TUahdIov1qLBsjayj2J8lR05XNJhjATGlToc9C4iiQ+YYWA0G
         kvlvN3E7AmcofWTM96IDad06A73GI3UPBSlvFw0K93gEaxF9S6CuRKZKayHnRDtp0skB
         oozg==
X-Forwarded-Encrypted: i=1; AJvYcCUzJKpU8pYEnw5geYW1VjvytpgGOCjP40WFgd4zmMCC4xczwf2GW+0/qbeYsjsD5pnYAOLhKGx70ctLVLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwMoIEAiHtUJuMMFNkc6Y0GyTqsF/19viOOfrrQQolg0sYHbHV
	QcYqe2Hvnn428D5rCoGmlMFHYlIy0bkeY/Z26HE7sXTTpva4cxOWz6lyWQ==
X-Gm-Gg: ASbGncuvkqgCY99koP81/b3w9uJaCtp76mJNr7g0SpoKpA81ox+rql7d7lz5FNqMmhB
	FI97RINcOAfGCOcausSdifsIBbYl8oiEBGQ8h3m9DxyZky1DJp1JVUJ7hE+PyXZZzz+1GlxaX/P
	MvvcOaPzT5bki5VHk9vsKzAg3DY7AtTU70yVxVmWcy+ioOyc7+vIjRxHarRkbPi66iUgJGPcEnG
	Bh6OgKzjYQXoGJ5oa3aBf1XWaiR4Uv6PW18rXh8xw1HTOkPJJHI8sFdmCaJ63Gj6A6ZkLfcRx5T
	sCCzAiuH4WaUg4Zhy61ho9rgz9njOTtDNiRuhTtiRH2az6KKblvz/LzvXANAxQ==
X-Google-Smtp-Source: AGHT+IEc16nb0VGL5o8sirLNt5/Ky3SosovsNBGOGfy/haFuQaDfONZlrOGAj3TmCCvKy8gZcDROWA==
X-Received: by 2002:a17:907:3f96:b0:abf:62a4:14ef with SMTP id a640c23a62f3a-ac25274a051mr1533256066b.9.1741595927450;
        Mon, 10 Mar 2025 01:38:47 -0700 (PDT)
Received: from foxbook (adts246.neoplus.adsl.tpnet.pl. [79.185.230.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2a4541360sm111134466b.6.2025.03.10.01.38.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Mar 2025 01:38:46 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:38:44 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] usb: xhci: Only set EP_HARD_CLEAR_TOGGLE after queuing
 Reset Endpoint
Message-ID: <20250310093844.19e0dbdd@foxbook>
In-Reply-To: <20250310093605.2b3d0425@foxbook>
References: <20250310093605.2b3d0425@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The flag tells xhci_endpoint_reset() that toggle/sequence state
is being cleared or has been cleared by Reset Endpoint.

This only works if we actually queue the Reset Endpoint command.

Impact should be minimal, because the endpoint can't start running
with wrong toggle state if it's still halted, and class driver is
unlikely to usb_clear_halt() if the halted TD isn't given back (it
should normally unlink all URBs first before calling that).

But it looks wrong and could cause problems if the code changes.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 8aab077d6183..9e4940220252 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -988,7 +988,6 @@ static int xhci_handle_halted_endpoint(struct xhci_hcd *xhci,
 
 	/* add td to cancelled list and let reset ep handler take care of it */
 	if (reset_type == EP_HARD_RESET) {
-		ep->ep_state |= EP_HARD_CLEAR_TOGGLE;
 		if (td && list_empty(&td->cancelled_td_list)) {
 			list_add_tail(&td->cancelled_td_list, &ep->cancelled_td_list);
 			td->cancel_status = TD_HALTED;
@@ -1006,6 +1005,8 @@ static int xhci_handle_halted_endpoint(struct xhci_hcd *xhci,
 		return err;
 
 	ep->ep_state |= EP_HALTED;
+	if (reset_type == EP_HARD_RESET)
+		ep->ep_state |= EP_HARD_CLEAR_TOGGLE;
 
 	xhci_ring_cmd_db(xhci);
 
-- 
2.48.1

