Return-Path: <linux-kernel+bounces-523038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5354A3D13D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9BD73BAFFB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E643B1E7C28;
	Thu, 20 Feb 2025 06:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKRkiXa9"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF811E7C2B;
	Thu, 20 Feb 2025 06:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740031885; cv=none; b=WLp47ZJFZo32bgah1L5/V2KX3ndi/mqoxgo+CAg9n9tmWN2h1TnzzMV8oKkzv3d+cKEgjr1QGrNb6BstZr8JWT/i/3jtRmI8i01Ek51dNx87+5oWx4iTj9Y8lIW3liUusoPQpi/Fq2EfbpfuVnM7+q/rg4PQa7ptaF22clYBMEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740031885; c=relaxed/simple;
	bh=oDtfLOKXKtd44spu9QiApYNaOcjTEDF9JU5iQyvi0ek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bvt3DTHhwa2xV3Y2JTy4qx1Q3FMaO6HZ0IeRaElA8JFD0LGRJ0BNrtktE2GxraGlVdpB2whPNAKjKSoxKemqdbAFnCbaVMNULgOkGlxGDEb/7pLk0P/l/dLyfimok1K4Ndy3Y8gPwK4Zr6RIwUEGplMxNi3r53zHWd/0PhnAdxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKRkiXa9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220e6028214so10330445ad.0;
        Wed, 19 Feb 2025 22:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740031883; x=1740636683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxPtDSmF5toWDiVEva1QGdhBkil/x42rbDTCJ7UnPbk=;
        b=EKRkiXa9/yzgtyqsohTpT5G2EREEoSTvM8fr8UgifOWS/OvTffrTE8tJFw0oJxQdmx
         5zK/diAfcEbcHCq/L6l8ZN9it7LLGQ6W4iNSt9AHy63h2xQnsRKqutzKycSR9FXun/QN
         W3UYtY4bxQOQeUFft5aGHsE+8+sKawXRZxtjcTiOxtPRiJQM6PO1zxPsiJ0yF7A5gob9
         sFm+8bExh8fhNssU5+a2Kma1v2iXM4tHBLW7bjW3DILJ5kBhxlTZvgAU6ok2CXbFZy17
         xdWnR4UAR/jWyKZlJKtA7qL/Obyp6gCRwXlLD+gvV/NegnDHXI1GTnwlQi5sP+M0EmIf
         H9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740031883; x=1740636683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxPtDSmF5toWDiVEva1QGdhBkil/x42rbDTCJ7UnPbk=;
        b=uyaJ8phR6pE7UqUk2wpjbVHzcUQH+K29P/J48k7iIO8HTDu9BshdnK45PAExWSgq3G
         4nccldjrYn0QvbdQZY62DrlNa3oOeEnaO2Fzc8+x+059zfJmIqeRPV4rqfl3/djwldFG
         0OIootm8upqFuNFTbtJjJ8ZFmZWCXVz6pdRXBWTntjNJGmE2sclwXLa6cangGN33KHiq
         dxYpST7u/4qcLT8pNn6tovxdnJ1js8100fcEVShiUUFf/jumcoVakSsSSONWznn6K3Oj
         s5B8h8mz0MhjMDjMQCbcQJ/VjKunNDb5tksvQeD1+948Td9EmbYAX//1Uv4sQoI7Z/0L
         bVQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1uFgxZ7K9Ont97Aeqa0umwu+XOhHqCwe6Wc+pWQkEhkzu75MZNfCTQ0rM4lBaCpEVLF2vO2Q05QSP@vger.kernel.org
X-Gm-Message-State: AOJu0YzUQXrSXq23IiFg3ijQnl3bUvBT4qmJu9nFYbeQg58zkuHBSDB6
	YLtZ3ENvV5OWdi3v7enxfQdrV5OQLiWBmnUNan+U3XsLmy6Kf+ds
X-Gm-Gg: ASbGncss37SrFYumqsZgIL9Qei5kALh2gv6Y8CPgHsFSjrCAthXm0noVph/WmOUmaSe
	gHy0ai/N7r/wBnLvODmgA7MeIFM89ywhzpalrqQl5c8LmjZMIjl0MRdhHwV/Z1U2pGjT/r2RvHu
	BVRZ9s4jKVi0XdRb5l021g09dIEOJpAkIC0aPh3dgIFG+JOusxpqrrx4a47qJKJARaexfK+PwMI
	BjcgwbzlpUvbUcB+Xx1v+TKgVAvyiu5ISY5jg1s93RoAf2ZgvY+/eXzsBkRD2EA3Ad0zjfol9mv
	Nazh4CW3lCOrckdqwAljdwfFpQ==
X-Google-Smtp-Source: AGHT+IEAbZsipXfJW+8zXBKzNEmPmaeBGZCutp5H7G84Z/naDOUlLTeWukt0d3jIBgxqJG5RWZh0VQ==
X-Received: by 2002:a05:6a00:17a3:b0:730:9659:ff4b with SMTP id d2e1a72fcca58-7341734f098mr2122693b3a.19.1740031882957;
        Wed, 19 Feb 2025 22:11:22 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:dc0a:4fe5:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73271a02648sm8226823b3a.107.2025.02.19.22.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 22:11:22 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH RESEND v2 4/4] i3c: master: svc: Fix npcm845 invalid slvstart event
Date: Thu, 20 Feb 2025 14:11:07 +0800
Message-Id: <20250220061107.1718239-5-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220061107.1718239-1-yschu@nuvoton.com>
References: <20250220061107.1718239-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

I3C HW may generate an invalid SlvStart event when emitting a STOP.
If it is a true SlvStart, the MSTATUS state should be SLVREQ. Check
the MSTATUS state to ignore the false event.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 2140da3f5187..5861358eb9e5 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -58,6 +58,7 @@
 #define SVC_I3C_MSTATUS      0x088
 #define   SVC_I3C_MSTATUS_STATE(x) FIELD_GET(GENMASK(2, 0), (x))
 #define   SVC_I3C_MSTATUS_STATE_DAA(x) (SVC_I3C_MSTATUS_STATE(x) == 5)
+#define   SVC_I3C_MSTATUS_STATE_SLVREQ(x) (SVC_I3C_MSTATUS_STATE(x) == 1)
 #define   SVC_I3C_MSTATUS_STATE_IDLE(x) (SVC_I3C_MSTATUS_STATE(x) == 0)
 #define   SVC_I3C_MSTATUS_BETWEEN(x) FIELD_GET(BIT(4), (x))
 #define   SVC_I3C_MSTATUS_NACKED(x) FIELD_GET(BIT(5), (x))
@@ -589,6 +590,11 @@ static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
 	/* Clear the interrupt status */
 	writel(SVC_I3C_MINT_SLVSTART, master->regs + SVC_I3C_MSTATUS);
 
+	/* Ignore the false event */
+	if ((master->quirks & SVC_I3C_QUIRK_FALSE_SLVSTART) &&
+	    !SVC_I3C_MSTATUS_STATE_SLVREQ(active))
+		return IRQ_HANDLED;
+
 	svc_i3c_master_disable_interrupts(master);
 
 	/* Handle the interrupt in a non atomic context */
-- 
2.34.1


