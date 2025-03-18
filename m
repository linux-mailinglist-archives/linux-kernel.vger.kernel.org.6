Return-Path: <linux-kernel+bounces-565808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC43A66F84
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1089B1891334
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE091206F2C;
	Tue, 18 Mar 2025 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpkjVPfA"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB5B148857;
	Tue, 18 Mar 2025 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742289520; cv=none; b=DNUKAcLHuiXoT3Hwr/3Jp3A3cJ6X+dw3sfPdT0wVdj3y93bS6+TbB6khsNcaSi9ZSNR4mDBaZRR4yqNcf7uvDQdQDINPezoRGbEmEMZ4QZF2y2Ot6emOatRsE7qWUIQWHsADGaBQdnG85L61stodk46ruzPWjT21SrWsHciIF0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742289520; c=relaxed/simple;
	bh=oyoXlL9IzzSXFl5qWJg2CSmmwr34k4pqXRJBoD9ptT8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ibm5f5KM5/WRP0bMjHqf593d6rLaBw10GCEpHQ6FkvnAHWdeOhBo4fUjQ/5AjXTQqTwcpuKvlgeE94o2YuxyY+dL6z8l6A09p/URLMWYArtb24+c7KLZMBl6QmIhjUqof6z9zzuvN4hyNzI9If79yalbPAuWl2cvONUoisjnmnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpkjVPfA; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5499659e669so5889442e87.3;
        Tue, 18 Mar 2025 02:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742289516; x=1742894316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iUTzmIuRjC2JAfNwka8eNB59m5yfPsonXucEEZCt/jc=;
        b=kpkjVPfAq8NV5J28ayEgJHPFLFKK0OE264IZWmEN62Euf7uDR8DqIJlzEYV0raxGYU
         USbsOcsNv6egFTAfvNEnpWVY32s+XIgpVjC6A2yq8yQKgA+r+qf3m4bI5rSvqgKt/NKl
         N/zQTjGuynqkrA70usqW+9GrH6PhejW3frMdUsNkAwmULZqeTmRPjlBV4cIpGj1usxwC
         6Xky4EseEz5uSQP4P8toORAXGqwcRnQngok/pbqHmksca5+M9K5EkfGZQogZADqX/FkH
         i4BiDrzjBBFnn0ByxPtSibx+Zgm9pG09omYxsP3rtFUGT4u0LHSnEDzwhgfBFC6GChu7
         gZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742289516; x=1742894316;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iUTzmIuRjC2JAfNwka8eNB59m5yfPsonXucEEZCt/jc=;
        b=vHSdoiY3ROiwEphk3VSkPAveND5gBHSoetFWCm7CwYKTySrxh5gLMXPH4wgQiSEH5J
         6TM7fDxI383vCkCzih8fspW8hhpwYZRgT0VO6XGizYpVEdMzC61NxhJfOIfMojG7SR/Z
         L9KW4PExTQaxWK+Wdw2m5SpJx8qCUykZPlGBHVgRKd6C3iJ8jCLpyX+6aPnE1c2AG/qT
         Z2llLcNx6ErnM/zBmx2ofW4uPKmGVnQmvTCmkReFfNpBledkuq7zVrOPVU6G07zcKF0E
         wL4nvqcGl9wamqi8zYEA4Ns2pd5XhuJkogqiem/WqtLg+zUqgU/BA6vE3qIMSFK+CbdB
         9xQw==
X-Forwarded-Encrypted: i=1; AJvYcCWZap+2VRis1P31LmYQlEPVxIfrlq8o5WEQDwIOnmWPHKoKpP7ClhZchtrqzj9DfgYaNWOgZykmXBoC2Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7+R1YP+JpfAp/bFQQF9yCJNmZA6l0H1lKME3BZfgfGjmVWWnS
	nVh/YoLi5A19IR2ImOl//Ouhpd+2HEyi46l/glAlzeexqlwiv8el
X-Gm-Gg: ASbGnctPtGs1fp8qp7V2M3xkNT5Penjzt3U1LmMLbHjQk/jpApw6bswSDUxEqCrFCZa
	EgJ0QZUXyPPEwji7NCD+VPZVvmi92MlTrZ6aGeZvflHmYAZpxMXtAzVZJVGfTxbXdiAN6FhNmlk
	u9s2v+otoqPxNhBYmC3uQ34MXpd+KV1ozwsgGqBqfQGqhBRKSujTQWSFbqogeteKTEZuvIvF5bn
	TsRYZVPT/GexkMN4tlewiG8oowhkupuHMN88BfImPxqyX7ImX93ab+QfR/NeENY3Het8n98hTDd
	POpneoGtHB/JoiSw1AXFveiFswm1kMhT1bTu/3Y1bDu5TaFE0d2Nj4wJgF8=
X-Google-Smtp-Source: AGHT+IGHwBr3z+X5KybLHAm4VLxQ6zBuSIuEK+aXOsN7Kzieot+b02V/4BG29JCWDwYNaB7fV6VFbw==
X-Received: by 2002:a05:6512:3da8:b0:549:490e:240d with SMTP id 2adb3069b0e04-549c391a8c8mr10131590e87.28.1742289516250;
        Tue, 18 Mar 2025 02:18:36 -0700 (PDT)
Received: from foxbook (adqh54.neoplus.adsl.tpnet.pl. [79.185.141.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7ce823sm1602244e87.105.2025.03.18.02.18.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Mar 2025 02:18:34 -0700 (PDT)
Date: Tue, 18 Mar 2025 10:18:30 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: xhci: Fix double newline in a debug message
Message-ID: <20250318101830.49e7a37a@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

xhci_dbg_trace() appends a newline to the format string,
don't call it with a newline terminated string - it only
adds a blank line to the log.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index dc674bc24a89..b565c9f7e036 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -789,7 +789,7 @@ static int xhci_move_dequeue_past_td(struct xhci_hcd *xhci,
 	ep->queued_deq_ptr = new_deq;
 
 	xhci_dbg_trace(xhci, trace_xhci_dbg_cancel_urb,
-		       "Set TR Deq ptr 0x%llx, cycle %u\n", addr, new_cycle);
+		       "Set TR Deq ptr 0x%llx, cycle %u", addr, new_cycle);
 
 	/* Stop the TD queueing code from ringing the doorbell until
 	 * this command completes.  The HC won't set the dequeue pointer
-- 
2.48.1

