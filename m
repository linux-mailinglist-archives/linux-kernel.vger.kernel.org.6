Return-Path: <linux-kernel+bounces-525015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0D4A3E9D3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE7897A6F48
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292BC158DD8;
	Fri, 21 Feb 2025 01:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adZDcVlX"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB96438F80;
	Fri, 21 Feb 2025 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100834; cv=none; b=jZWyVAbSxlGkNq2/cYsWRaxUOL+oqgg0I1j1r+WX7fLNYJPgzVEPtUMiiNNSvw6qqI6/FDehi9EBKOAXbcOWyj7qqs5dy50VBR9ii0bpF63ofzGA27X8ZXUQe8eh0FZDEQLsihZ4VPUVPsMxi/hcfxHUP8xa+P82t3VMghuVOxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100834; c=relaxed/simple;
	bh=2JP0fOOE6QK8ybzMtqOP6sxOWXhR9cgy9bGRHa9Rh+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHNSE0DpNsd+MTW9WGqE5a0DAhB5ppKp5zoxhrWxPH8zZb+zVnLvOQZTfKv+25Yv1jWQ9QANxFVq/9yrkGj8QWmioGQQpUJNm6sYyMRAJHbogouzON7gkV2765b3IkddBespEDj3OZXPJg3eUbg0LDXkqp+G9qt5azgVE1zD6bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adZDcVlX; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaec61d0f65so330289866b.1;
        Thu, 20 Feb 2025 17:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740100830; x=1740705630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBz1Nat0cY2w8r0Wbkva5eD9bF4XcQmPPZZcToCpqs8=;
        b=adZDcVlXAkkaWhMk8pw4nBybTDCyJ579jKPTxFiebg7qBJQDQcogtTF0wdRMwtGiAF
         EqU6yN/e+LfrUOAisH1dqWppIAh5C7hkMfUD6JZx03ok0K3DQ6LDg49LiWfJGEVN2M5h
         tozmmtwzUl/iDQHzKzK+KwI6fPV+OIDKgfbB9VTkaaJrwR+4A2AQjb8fJzpWd0wSihsj
         NzMClpK8wg7E0UzKKc5YYZvRuKDxpTgwoftaupauft1vWk2sB4Na1gaulx+bAkJIXM/U
         UU1jNMg6z62cZ7Eh3fDoj/+ZQZsmqwXoj0An/X4Nxbk2G5/H9XgucvZt1jnTartSyXNJ
         a+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740100830; x=1740705630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBz1Nat0cY2w8r0Wbkva5eD9bF4XcQmPPZZcToCpqs8=;
        b=jMdbNuhcMyb5D6B10L2F3H1ohRp4f3NPgoMly7DANmzxOXSuSfxCYA+E3UjHiBIeU0
         lDCKCN51hkgzPsFJIZh9XS01+m3YOK+FVnqZHNvJnt9dvNaPpSKVJE1+2VCUTCL59mSx
         olKWmnVYyfW9yCKGk+PwYi+6PpFjpzuXw/4HhShA42IJkLU2xWsWxyMUF6E4RwuIUzI8
         xj6Z3PhKpn0OFiQqZ+aIMVIba4Y0/qbg3aZutLMEhZZmYCGP4Ij1judyG853giJgDf1h
         GCYrbmYQk9wuEC3tbaV7uO4gSbG+PY9FFkaabzQleDV/dkvQ3F4nq6uST9mkxcH3cBTy
         FlOw==
X-Forwarded-Encrypted: i=1; AJvYcCV4vJbL0nJvytaURBbgTLjPClLTTR+IdUPv1Yx7CvNSIXQLBEe8OONm/oHfLHP24WoKopGYrpSMJESN@vger.kernel.org, AJvYcCXXN9SgkWnSR+WXSu8rZ18WTTvvNjlqc020C3GRFv1rzQa1xF96Fn1Vz4N7EYoz3lt1CNAGsfcZ3bbdrVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyidhuoZMd36iKWz/xoKK5FPU/1JB883kR+bQmAhYSCT4H2cvkn
	7sEyQTCXX8XQ8mMe8nrEURWAkad+8OTSnH1pppWSI6T4zuSIEuHI3P7DUw==
X-Gm-Gg: ASbGncss8/+1R/r/9JAEiY9ARotJ/txUvY6aXIDmO60gmppIk4HnMlvcyVbk1ohkXwf
	aJLUUSX4OytvRVgl169Od4H6c4fBCqZ7aCduSVUY5OgreBhqRZr42o82bXgoQewa2EC4JmVLqqQ
	x1VWqMSz7Z38fVJyW+PudxNezFhrUTN2AhbbUdwVPRN8lFetsp1VbSe7rZNlnBegiyW5ktl2W6j
	yhQIyrwo+RxBb63Xw3566Hi/MtxVnyLAlMrl61i0h98EoSXruQGrDG01ol4qV6OmwTCUWR9QMEK
	ht9+92SQdkKK9JJuYKlMulmFyv3QOo5/
X-Google-Smtp-Source: AGHT+IGhCNmlhVmncAuG0EIzWBlQb0si8e3VTZqB0vnq48A5uaUKGEMTJ5Haico04YVyErcknQyj+A==
X-Received: by 2002:a17:907:7fab:b0:ab7:9d30:3fea with SMTP id a640c23a62f3a-abc09aef73amr136512566b.29.1740100829828;
        Thu, 20 Feb 2025 17:20:29 -0800 (PST)
Received: from foxbook (adtt173.neoplus.adsl.tpnet.pl. [79.185.231.173])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5a4f4cb4sm1474755066b.118.2025.02.20.17.20.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Feb 2025 17:20:29 -0800 (PST)
Date: Fri, 21 Feb 2025 02:20:26 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Niklas Neronin
 <niklas.neronin@linux.intel.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] usb: xhci: Skip only one TD on Ring Underrun/Overrun
Message-ID: <20250221022026.65c8e7fb@foxbook>
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

If skipping is deferred to events other than Missed Service Error itsef,
it means we are running on an xHCI 1.0 host and don't know how many TDs
were missed until we reach some ordinary transfer completion event.

And in case of ring xrun, we can't know where the xrun happened either.

If we skip all pending TDs, we may prematurely give back TDs added after
the xrun had occurred, risking data loss or buffer UAF by the xHC.

If we skip none, a driver may become confused and stop working when all
its URBs are missed and appear to be "in flight" forever.

Skip exactly one TD on each xrun event - the first one that was missed,
as we can now be sure that the HC has finished processing it. Provided
that one more TD is queued before any subsequent doorbell ring, it will
become safe to skip another TD by the time we get an xrun again.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 167ae7dfca47..d78b7877f65f 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2844,8 +2844,21 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 
 			if (!ep_seg && usb_endpoint_xfer_isoc(&td->urb->ep->desc)) {
 				skip_isoc_td(xhci, td, ep, status);
-				if (!list_empty(&ep_ring->td_list))
+
+				if (!list_empty(&ep_ring->td_list)) {
+					if (ring_xrun_event) {
+						/*
+						 * If we are here, we are on xHCI 1.0 host with no
+						 * idea how many TDs were missed or where the xrun
+						 * occurred. New TDs may have been added after the
+						 * xrun, so skip only one TD to be safe.
+						 */
+						xhci_dbg(xhci, "Skipped one TD for slot %u ep %u",
+								slot_id, ep_index);
+						return 0;
+					}
 					continue;
+				}
 
 				xhci_dbg(xhci, "All TDs skipped for slot %u ep %u. Clear skip flag.\n",
 					 slot_id, ep_index);
-- 
2.48.1

