Return-Path: <linux-kernel+bounces-533160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E7AA45642
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6C23A3BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D930F26B0B1;
	Wed, 26 Feb 2025 07:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAE/42cF"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A44526B082;
	Wed, 26 Feb 2025 07:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740553428; cv=none; b=VCdSI+Cu3N8zoYDrkqcOdb0SBt9EGVAdbASu7tnbkzhAjr0VdzW2t8Vjk6UHRBJyqYRa0DsMAppQzBquNOGf1sinfQFX15irRrTAKwxFng2Ju/LfVL93Ep3ugZIr+Nv0IQZ7G9l8P0uQi5xSbwSrjInCpIW2VSh2kvUh4UEaqSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740553428; c=relaxed/simple;
	bh=lg5xkInCCwHlj1b6qb13Q5pFBbFsY2hO58/hDsErG8E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmP6S+z6P9+BRx57KNidZQlBMQljPS8EcyuYJLx4TnXwX3ADsSHxXJfGU3TzbA+gP/j+o4ZQzjjnWdU1J1+uBWArErZgVkc3Av2e/fhFebvnX1vEgf/0FGlZb++jO9oFiL7+HVG+5mqls8KqdPtjeCCqZjGB9qJE9hv11Dyc9QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAE/42cF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb7a6ee2deso983153966b.0;
        Tue, 25 Feb 2025 23:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740553423; x=1741158223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/W3Ho66mSXM+hQEN++82iNqyLxgCXWfzOB2XZuQsdM8=;
        b=ZAE/42cFdv7b/g25uLXEuKbu9Tmg3Q0PNgoi9i/M3m7fnmU7L+bIAj2HrLF5h82rMn
         oLtkyfrA57NW5+CZ8J7DgQDblemMoDhjneA1+Jyfm3aeuVEyIiEwOLNlsIKGH21DTFOM
         WCe25I+QhV6HXQDrmTL/Ca9+zjr5q7osZ4+zftExaxmr9QagXyDf0TTQ+8rneAgmjH62
         4VWyZ2qQ0kOPD1QiiS8I/D+qz0y6QK3H69DAx7f4OK44roSUs04FbbFUHMb1gKPO6C+G
         wx6gm7kRsqtPGIBdgPG8OyXZLMlKJYtJy5012xY1Ph4HQcaQHcyexzaHMG0PAOcJ99Xq
         6p2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740553423; x=1741158223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/W3Ho66mSXM+hQEN++82iNqyLxgCXWfzOB2XZuQsdM8=;
        b=a8EC07zRfBD5GkF2F+dQ4E1TON+ZBjjk6XiN4BfQq4Ha0EmHCGvD8v5ldQEG9rbvrc
         90rvIxsjh4pEJ5LsZUKTvevt81rsOX5UaUAPXW3dJo29H3ufkSqO/PwjSU6fU+EKnG8M
         JAm22e9tmq+0E6nx45/McZfDy0Xg1MC9eXnTIS16k8gRHutqd/Q2ZkNBIG/qD7MeCMmN
         jL0LbggSkzFSS+nQfih7XX4v2rEB6OUN/e7IVJPBMlggENiW0rVRHc4nH4v1ayoio2s8
         pR8ahxudb6Pkerz1HsnH+1koyADYKhFKLcKL9Iw5CWezX5OKWlPjRfkZBKD84g3T6y88
         x0Wg==
X-Forwarded-Encrypted: i=1; AJvYcCU4CbQrmREVUG8V9ZAQwDO+gXvdWaenHulNOm6dL+ERDiyDGYbwHk7+rS0lXVAuCAE+vWftiyQMs5/x@vger.kernel.org, AJvYcCVBMg+qg+EqvhCohdStA9G9993vzSRtDN/BdnIYrIyIg8heI0XvzHvlGQci24c7Bngfi1knCwFSua1YcD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy66xgAWu3AWnKN69bzJU4m3Oo675GqDn8fT/Zl/i/G28uiuTWe
	u5ydojd1ryMyGUcvkYIfUhDJPTfowYEqkg22dnofgyy97Fy/lQBF8GOmeQ==
X-Gm-Gg: ASbGncsvZ2sSb1f+w0Ck78FlKkD7Gcai9lMgVgILt71YMmIovFG802sgyOfv2mbxw93
	yNXVFr2/0EcD2RTj6fIY/UowC/KgDlLy/+i/NGdMVpYVAIBN/GjpNtzRyi1N7fVw2TpFpfFKULi
	hPokHnp8JCN7jMn46yHcwx1HcPIyicIFotFACRU2/SlPNrk/uEgePtLZiYso/EF8QOBV7iiPtxi
	LKq8jSdvII8/TJLBCd9+cGLw9kz7ypVWpiQ5hGwH/0t7DsINH3irgih7a5BKlVITFiadNB6O0JK
	4jXBe9iVxiwq+nwVIQzZVTy/a8Um/+txGbLIG97p
X-Google-Smtp-Source: AGHT+IFVPawhbUD41Nr8VH4XWzPchWy5psMYaYGyyH6S9ZBAi4EnsR2RKOBAzRyL8sq2WTC0Mw0M6Q==
X-Received: by 2002:a17:906:689a:b0:abe:fa19:5a07 with SMTP id a640c23a62f3a-abefa196890mr46315266b.52.1740553422682;
        Tue, 25 Feb 2025 23:03:42 -0800 (PST)
Received: from foxbook (adqi59.neoplus.adsl.tpnet.pl. [79.185.142.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20b5985sm278546466b.172.2025.02.25.23.03.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Feb 2025 23:03:42 -0800 (PST)
Date: Wed, 26 Feb 2025 08:03:39 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] usb: xhci: Complete 'error mid TD' transfers when
 handling Missed Service
Message-ID: <20250226080339.3499c49e@foxbook>
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

Missed Service Error after an error mid TD means that the failed TD has
already been passed by the xHC without acknowledgment of the final TRB,
a known hardware bug. So don't wait any more and give back the TD.

Reproduced on NEC uPD720200 under conditions of ludicrously bad USB link
quality, confirmed to behave as expected using dynamic debug.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 96b90819aec7..5eaf4f9154b9 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2794,7 +2794,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		xhci_dbg(xhci,
 			 "Miss service interval error for slot %u ep %u, set skip flag\n",
 			 slot_id, ep_index);
-		return 0;
+		break;
 	case COMP_NO_PING_RESPONSE_ERROR:
 		ep->skip = true;
 		xhci_dbg(xhci,
@@ -2842,6 +2842,10 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		xhci_dequeue_td(xhci, td, ep_ring, td->status);
 	}
 
+	/* Missed TDs will be skipped on the next event */
+	if (trb_comp_code == COMP_MISSED_SERVICE_ERROR)
+		return 0;
+
 	if (list_empty(&ep_ring->td_list)) {
 		/*
 		 * Don't print wanings if ring is empty due to a stopped endpoint generating an
-- 
2.48.1

