Return-Path: <linux-kernel+bounces-560894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 209E2A60AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1A1189EF5D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9900819258E;
	Fri, 14 Mar 2025 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs8aineQ"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FC18635C;
	Fri, 14 Mar 2025 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939305; cv=none; b=N+T4fZiewZxx4VPl+vfPLdpDhHNUs2RkYyE/5vjhokj02UUJ4gzULDrAA5e4vj3RYubDq1m9RC6qCmY5wa0YtIe1cGj75xhvSdpUJ0M2itIrvcEfbBQTR6WysEB2N5FMpjkgJX2BZPzhD7dv1mIXkANoIGVAFAadCTX54ALkNv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939305; c=relaxed/simple;
	bh=JpGPRDc7nnVcoAJacMPhOc8NkDnRElCXTviLvnwRYaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hOeeIfNOp8NIA199UnR/7GDM0U8HiGo1Z6a93/cjiHyJ4E4TM1z1zTUj0Lk3X305C0qg2fmJz/ZoauCML8Pmsw1cAkBQdD74KTw0m8POe//1IWHzr0y1PBeezwsFHlvERgWwH5ocdwgptvrhPsxTWLF39L4kjLZuLWmg0UJO/v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bs8aineQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so340802866b.3;
        Fri, 14 Mar 2025 01:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741939301; x=1742544101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dtd6hqF4/E4JMFJ16QzaCVJ4wE2X+zxDo5+FAqtoRKc=;
        b=bs8aineQ8Nut0oyNnAR8OmZlE94j7L0OarDd1JEH81MXHc4OMPDJ53tmyuIFjt2OQp
         xfck5BqhwL0MfmRKEEkAt8k6AEzPy9fG2JdAvWrzS/pHgYTOxf/z9KavJSqS9r6qTccs
         qC2YLaET4xjeMK8q48OepVG3YEVRpFvnleGMJrfEVsf6b7M/mp5S+rdwFMp+iOSd5atZ
         f1ZVPKst05ezcMng7at0VFP3cII5f7lmlLm2SZNL7f1xNPcWHkAWHKdVXdiqDtTsv0Ug
         tR+JGxniWOIQLE7XT6HREk+4QyQEimP/susNNAbyQ3NiP0MdF/OFztkKmiQHD53Ga7iS
         MvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741939301; x=1742544101;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dtd6hqF4/E4JMFJ16QzaCVJ4wE2X+zxDo5+FAqtoRKc=;
        b=HfAy/6Tv6ne9CiP+TnW7fomE/ptpLRzMT0dCdLanFLqcRYm+dzVyVxoIUGEXpjxKwa
         VThZY+UDb525tpZ4oma2Q53Ia/MxI1hfehw/D+Uxnl+JhvZwLXuzWRpH1h/+G3hG7hlZ
         252GSK0nLFePyGKUnNBc7r3Pa8XuMuNhA+3ZhD1s5v2s3wsDL12MZEElRLNMsSQcmGzj
         rnQqRGtBzbU4aCV7SX0rsJHdfR3dc4kPZsk+dW7QGQz9Qg8GpTUDznFPu/ipxJ8AqOBH
         jjz+TnF+L2fhRyjfaFUlBsUBr7r1uw/Bq1yk7kvrQ5C/mj0vq2hm64S8skj02PcvCQcQ
         0IsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDhTIfygOJfZBAfYk+bAPTWjgeVp9J1qAYm/1xp36pR8NZ0xvoGNw78avjtDR4i/m0LO8eEQqd7PkW@vger.kernel.org, AJvYcCWWW3AmoRrZZsx2QpuAypfcJzZe57G+gkzyvxcoYBqGRUBsnm4i7QQGX0txzTRnFvp6wqfejNyAU5smcpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFjf7p81VOdUiN72itXxZyXDTSRPk/H/njnF33LgdpE7xySU1e
	aPP1t6eMk/tzvhcRmPDgU4btaHvD/xPnvTsTwI9juUBSEw9WQdyV
X-Gm-Gg: ASbGnctYioDbxpms2y7m0nJ9DAlzkD9Osy4F63xfAUYF5ApJ+c5TM1HYimVPXyw843L
	Bo9dxh/Tzuls4U5Ljk4Zwo233lBBNBz4eaIbT1Xdmpms/XjOoUEGQn2Bt4VJNNfH+wpWRAWZMWf
	MiKaBpv0ZgBvIjwWRkKXQ6EPnB0NtS5yWvgKagaDvyZtUzK8SIq7L3wBBWi+YmKJmgG+QnufpTY
	fiKMwDUMcMlQeSzhohuD/L5YH5HgxnmJftcsED0lHJPeIX9X5/APH+EiRfM1+/CwaKywqBnNz6R
	nh/ZmAF6JC1YRpSQg/tilTnxiBcFGt4gcCWL3zZnnxR9r7iwJPSYxn6+h2w=
X-Google-Smtp-Source: AGHT+IFNobPJFaed1+rR6hdGon196mZiYWLUxTSwQeUt8YADrztqOpZ/Ia+chgn1nwo6LSAllzH9xA==
X-Received: by 2002:a17:907:7e8e:b0:ab3:2b85:5d5 with SMTP id a640c23a62f3a-ac330401c0bmr175291666b.49.1741939301139;
        Fri, 14 Mar 2025 01:01:41 -0700 (PDT)
Received: from foxbook (adth23.neoplus.adsl.tpnet.pl. [79.185.219.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aea4csm188637566b.33.2025.03.14.01.01.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 14 Mar 2025 01:01:40 -0700 (PDT)
Date: Fri, 14 Mar 2025 09:01:35 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: xhci: Don't log transfer ring segment list on errors
Message-ID: <20250314090135.61f1f656@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The error message above used to span two lines, rarely more. A recent
cleanup concentrated useful information from it in one line, but then
it added printing the list of all ring segments, which is even longer
than before. It provides no new information in usual cases and little
in unusual ones, but adds noise to the log. Drop it.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 5d64c297721c..9e50cc3354cb 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2981,9 +2981,6 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		 (unsigned long long)xhci_trb_virt_to_dma(td->start_seg, td->start_trb),
 		 (unsigned long long)xhci_trb_virt_to_dma(td->end_seg, td->end_trb));
 
-	xhci_for_each_ring_seg(ep_ring->first_seg, ep_seg)
-		xhci_warn(xhci, "Ring seg %u dma %pad\n", ep_seg->num, &ep_seg->dma);
-
 	return -ESHUTDOWN;
 
 err_out:
-- 
2.48.1

