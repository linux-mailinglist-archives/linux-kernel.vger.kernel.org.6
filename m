Return-Path: <linux-kernel+bounces-553735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 055E3A58E46
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FF0188EA4F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B4C223704;
	Mon, 10 Mar 2025 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXlv9ctn"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370F5E545;
	Mon, 10 Mar 2025 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595825; cv=none; b=PVAr+p5aDCoI97iZLluXQiODHv+YxSS3K2VcohXjpd+yDhfSP8HQfhB2pvt0LT9O22LENcTqHSafcl3d0StE5jrjaFjvUa3lTaI0xVQLeVJMhoC/yw/MHNaFEc/P4lZbdM94LTdHolCHT9llstDKIZkYpvFNisqTZ1DIUAw+B8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595825; c=relaxed/simple;
	bh=tpAaiAtCdaamxXM04C4iQNK1HkFBf7XzgFPkCYxU8IY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eREbeccTTOdVzIELnkuKzz6yQZB7noi0GLm7cQRgBZHflF90MS1WCkZTntA4nVF06k/tvnZl3Zeu94NurmW1Z+60Bckr1125DV32tBXV6h9x7jCXwumCA6YlnyzjCJLYjNNdqDXznEdniBs36IMoS4yj9jfNyV8Jry+domXFOlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXlv9ctn; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abbd96bef64so633829066b.3;
        Mon, 10 Mar 2025 01:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741595822; x=1742200622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iac6UoWKVrOdOtUS/jSWoBYCwqGBA+BOqutr7ei4GnQ=;
        b=ZXlv9ctn/qRL3X5ST/pezluQQ8lsdk9fK4PQwFiS6P45KeQbZUv7NkNJk9NpLeXkDk
         WMMo9oImmn3DBuefgZMLIpWHxo9o16IS80N8rPKQZVJZIZNlZA9AD7sm1vLJ+1CxlfwR
         NCshHP3+n4k5BqETn4GaC6HAkIYwg5YpP+VtoMKVm5t9TaS/HSvlM2BlXTj8cF8lOOBj
         6xlEfZVGIgoMOtkMGo9ZdvZQ7tspm/DB3CGyQDzLbGZgt4TNzUxeMsO6E1kesjVsQC/i
         EyCGVxd4+bIkdtRjTvO/JPMT/4VRnySTYdZALN2v0jSVxLwRnvwEJksVThlf+8bpsokM
         ra2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741595822; x=1742200622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iac6UoWKVrOdOtUS/jSWoBYCwqGBA+BOqutr7ei4GnQ=;
        b=X79/3gXTo4+cCeb4fSblyuIhoJgrx9tuupPylc+3l2kYEhWP1RJ0ZhMFaGSw2XLhuG
         lYLHrqHaoLzV21hOkdh6AfqNuSzsTePuUiG7iKC4OwJHj+nwa5h5dPM8iMCnrDBREgY+
         uRl+HxGOP5J+NNuscm9e5rS2iKsqGnyrnkK/+1+9EABNJaxbq+29vj0HhClCKBeQRYk2
         kQAF4owgdMDyftSrE5a//JFULyVfMTo8Js+VBBcxuvTGMo07lBJJ8eUQfe/Gm1Y3lHWx
         BlTYuK3Mxd31oZM2D0N6XVCJXj5xMFrivg2f7UTa4tqZ3Ed7zm5UKQtzl22o8qudl9qt
         3N8w==
X-Forwarded-Encrypted: i=1; AJvYcCU1etMTlvqDzMmJoLie3m7IaakrdPmHfZ/3+n1vnSxgfzk17QPL01cVRIR5GcJTu4CdoCrNhYHPWLa+VUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7L/3vTtxhR0XHJVR/ugDCNgHVtQBMfIFyRHpJzZQrEe/Hl+A7
	X7iwGs0HnG8N0UQrrzcY0zFkyk2SKEnWe32kkxzDFo6vhhJ7gElA
X-Gm-Gg: ASbGncskTOt6ZDi7X0qC2Qc5pics/o23nf1dfgFTRSKSM3zhorYSKNpjSDRE8zVr5IA
	+dB18zmTI8Mz5+WQypEzQak3SSIgCyfYM0+HiK5DBH5E7YUtxr0fUUqYZyfE9REpOipNyDEU137
	SfNzzHrW824dzNuzdSV5CpDGOxUVekVeNTv8D3TriZoN3wYqavJz1BWHmhnq6p48hhYVHkFYDL1
	m9bX46U++4bTADIt616hyQ9L7ZUAOZV9VDveu+dMf8SWxGj8Yg09CvMcfcEGJvepy0eIpQ0W2bf
	5n7daGKQ1h68+95OFjx3zPwFHIUx4ludt9PWcRfS4uw2ROx6/q4E6L/U8lAwNQ==
X-Google-Smtp-Source: AGHT+IEe1+RUwbFp++B+BlmoIf71yYL2vv7OX/QVFzIa2N4mUXSJMiqcnjqOOWMXxM/K0VCsS7sDzw==
X-Received: by 2002:a17:906:f587:b0:ac2:50fd:bbb5 with SMTP id a640c23a62f3a-ac2526264f0mr1128342866b.16.1741595822293;
        Mon, 10 Mar 2025 01:37:02 -0700 (PDT)
Received: from foxbook (adts246.neoplus.adsl.tpnet.pl. [79.185.230.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac29dd5a75bsm162910866b.8.2025.03.10.01.37.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Mar 2025 01:37:01 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:36:59 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] usb: xhci: Document endpoint state management
Message-ID: <20250310093659.04b082e3@foxbook>
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

Add systematic comments describing xhci_virt_ep.ep_state flags and
their relation to xHC endpoint state.

Add a few paragraphs about how they are used to track and manage the
state of endpoints.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci.h | 44 +++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 56ed1b817f91..46bbdc97cc4b 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -662,20 +662,18 @@ struct xhci_virt_ep {
 	 */
 	struct xhci_ring		*new_ring;
 	unsigned int			err_count;
+	/* Endpoint state, state transitions, pending operations. See also notes below. */
 	unsigned int			ep_state;
-#define SET_DEQ_PENDING		(1 << 0)
-#define EP_HALTED		(1 << 1)	/* Halted host ep handling */
-#define EP_STOP_CMD_PENDING	(1 << 2)	/* For URB cancellation */
-/* Transitioning the endpoint to using streams, don't enqueue URBs */
-#define EP_GETTING_STREAMS	(1 << 3)
-#define EP_HAS_STREAMS		(1 << 4)
-/* Transitioning the endpoint to not using streams, don't enqueue URBs */
-#define EP_GETTING_NO_STREAMS	(1 << 5)
-#define EP_HARD_CLEAR_TOGGLE	(1 << 6)
-#define EP_SOFT_CLEAR_TOGGLE	(1 << 7)
-/* usb_hub_clear_tt_buffer is in progress */
-#define EP_CLEARING_TT		(1 << 8)
-#define EP_STALLED		(1 << 9)	/* For stall handling */
+#define SET_DEQ_PENDING		BIT(0)	/* EP Stopped, Set TR Dequeue pending */
+#define EP_HALTED		BIT(1)	/* EP Halted -> Stopped, Reset Endpoint pending */
+#define EP_STOP_CMD_PENDING	BIT(2)	/* EP Running -> Stopped, Stop Endpoint pending */
+#define EP_GETTING_STREAMS	BIT(3)	/* Transitioning to streams, no URBs allowed */
+#define EP_HAS_STREAMS		BIT(4)	/* Streams are enabled */
+#define EP_GETTING_NO_STREAMS	BIT(5)	/* Transitioning to no streams, no URBs allowed */
+#define EP_HARD_CLEAR_TOGGLE	BIT(6)	/* Toggle is being or has been cleared by reset */
+#define EP_SOFT_CLEAR_TOGGLE	BIT(7)	/* Software toggle clearing, no URBs allowed */
+#define EP_CLEARING_TT		BIT(8)	/* EP not Running, Transaction Translator reset */
+#define EP_STALLED		BIT(9)	/* EP not Running, waiting for usb_clear_halt() */
 	/* ----  Related to URB cancellation ---- */
 	struct list_head	cancelled_td_list;
 	struct xhci_hcd		*xhci;
@@ -703,6 +701,26 @@ struct xhci_virt_ep {
 	bool			use_extended_tbc;
 };
 
+/*
+ * Endpoint state notes.
+ * xHCI 4.8.3 defines three basic states of an enabled endpoint: Running, Halted, Stopped.
+ * The fourth Error state is avoided by not queuing invalid TRBs. This seems to work so far.
+ *
+ * 4.8.3 warns that Endpoint Context EP State field may be stale, and it doesn't indicate ongoing
+ * transitions anyway. Some xhci_virt_ep.ep_state flags are used to keep track of known transitions
+ * and various operations which imply or require the endpoint to be in a particular state.
+ *
+ * Notably missing is the Stopped -> Running transition started by a doorbell ring. 4.8.3 suggests
+ * that it is instantenous, but on some common HCs it may not be. There is no universal way to know
+ * when it completes. Transfer events imply completion, but don't arrive if the device NAKs/NRDYs.
+ * Stop Endpoint fails if the transition isn't complete. Polling the Endpoint Context is an option.
+ *
+ * xhci_ring_ep_doorbell() inspects the flags to decide if the endpoint can be restarted. Another
+ * user is xhci_urb_dequeue(), which must not attempt to stop a Stopped endpoint, due to HW bugs.
+ * An endpoint with pending URBs and no flags preventing restart must be Running for this to work.
+ * Call xhci_ring_doorbell_for_active_rings() or similar after clearing any such flag.
+ */
+
 enum xhci_overhead_type {
 	LS_OVERHEAD_TYPE = 0,
 	FS_OVERHEAD_TYPE,
-- 
2.48.1

