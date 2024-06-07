Return-Path: <linux-kernel+bounces-205521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A458FFD08
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A16A1F216E8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA4C155353;
	Fri,  7 Jun 2024 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="20fFVcbW"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B70153804
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717744840; cv=none; b=fTCON5yExuE3K7L5pZB96oHtDLEtr9QgMaV5ROJjEHJUHr/0HWzTeP4Q6q9Bbu1aqJyXAxo/zs5diD5CAA0umAm17Mx8kmllvs1lXkMkND3V6wEDsP0aRDSRneN2YDusmrQwndI0VrApPKbrpd0+4VOeFMXsTsddVertTL3zZB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717744840; c=relaxed/simple;
	bh=CAI0bM8rG6POsucCMyxOkFXXF8uuXq2WEeot1L1RFpY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MhGeZVEX+Z4F0sa2E1zO43GNUQABirOZSFaKm3tXt/9mGrGAoVPpfqcd+0NtctUZzzyBCeHJRVIibh0SjoBwoGT/2PByjeOoQGkBMh+TG1jk5hmIysTChn0KxUe4AD/w6D63Z69FbRsrtF1iUnhzNKUPZBXWtuUM+1ZAoc3XTqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=20fFVcbW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-629f8a92145so28114177b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 00:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717744838; x=1718349638; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LPMd0YveQHyYq4holtAZQwo//xyVvbIej/9hDc6mCbE=;
        b=20fFVcbWwwLz2QEG9ZaGyBrwpO7skDGJROCp6cPamJOLglNTQ+2F/+MTAbMxDeVkGU
         d4u4Fnp1fPy9HmRRlSqWJvoGgJhDQj2MT5w/WYA064ORbW4XA+JEXVlR63bxu04QnQg0
         mBFKdQczMSy8jnDeM5hw0nH9NCpmbO+0T/Ipyo23907F8U2/4kJIRfzoIC8NFK5FYQJv
         JfWDl7BsrnleIgm9Wc4RfDPhfxiI9q+eki6y1BRCtzQkhmlHXhULITzJf1lFrF0XEvuF
         PSL2XtVkD9ViawCJXQq8pC45akHkJL/x90xHbsdd2BKxaAcESMFeB2Re3py+ZM/v4Qhd
         fsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717744838; x=1718349638;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPMd0YveQHyYq4holtAZQwo//xyVvbIej/9hDc6mCbE=;
        b=jcdPVQ4wSHj8anAbIWFNO0DWWnZEyu888u9cBr+M7X2Zw2exeiUmjUUYyx2EESe7mT
         b/U+3qpHlEywRhYTdlQcxSmJB87CiVT7buqQdHLcIlcRI8PsrS0UT8MoBjDvd0ngth3w
         ffjD3230epaqSjAFSQsKbjyZqDnlUXLCo8JqYKrsV4+70tJsCggGUWXgA0+7ltCQx5Rw
         t8rsXQPRqSesCOXFaMLEoGUMtsVeWQx79HbAdQotHnY/OcTykadcLMQNyalsR97zHNBE
         NCEP17zy3lx5TYE5TSKcKgMjYPu7RLy2G+mY6wXDnSnnDSpi7Bs2NwS8fxQxJ3UKLVtF
         4yTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6F9EAxFZKVVl2W9PAvWlWm6XM2CR3Atjt4yxJEKDOkZj8rIfjcWiqIIru/uuwE8z3aY3814f1XsZNUCxZGN1Gbk0kTprfHhbAXA/t
X-Gm-Message-State: AOJu0YzvB1Mmw+vxLdvOagqnDw54u83vV9Hwjzq7z/OYX+nFsEC3Nrwd
	kAtCWg7mDbs32DbCT8/dFQ3kVITiU9fyr86CnKmmQDpCdKdAKfERYzYrorvJAmAlaodSdWOPJU/
	3BK0JLpB4Zamev5srWnStXzX+OA==
X-Google-Smtp-Source: AGHT+IHUG1TkmKj0XidS2kJaY5u/jWXEV45MSeqH1d1RNuGh9PvPBtSHCr0zKEXMgGOpve/jlyIaIMUK569tO1UZDKI=
X-Received: from aniketm.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3387])
 (user=aniketmaurya job=sendgmr) by 2002:a25:a3c3:0:b0:de5:bc2f:72bb with SMTP
 id 3f1490d57ef6-dfaf66800f7mr100083276.12.1717744838152; Fri, 07 Jun 2024
 00:20:38 -0700 (PDT)
Date: Fri,  7 Jun 2024 07:20:30 +0000
In-Reply-To: <CAMmmMt2guEx1jajb2NC0iBnMGpkd2vaSiXg_BqgZhwrA=FARLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAMmmMt2guEx1jajb2NC0iBnMGpkd2vaSiXg_BqgZhwrA=FARLQ@mail.gmail.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240607072030.2618428-1-aniketmaurya@google.com>
Subject: [PATCH v2] i3c: dw: Fix IBI intr programming
From: Aniket <aniketmaurya@google.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Billy Tsai <billy_tsai@aspeedtech.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Aniket <aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"

IBI_SIR_REQ_REJECT register is not present if the IP has
IC_HAS_IBI_DATA = 1 set. So don't rely on doing read-
modify-write op on this register.
Instead maintain a variable to store the sir reject mask
and use it to set IBI_SIR_REQ_REJECT.

Signed-off-by: Aniket <aniketmaurya@google.com>
---
 changed from v1 to v2
	- replaced counter with the mask
 drivers/i3c/master/dw-i3c-master.c | 15 ++++++++-------
 drivers/i3c/master/dw-i3c-master.h |  2 +-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 0ec00e644bd4..03911a5c0264 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -658,7 +658,9 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 	if (ret)
 		return ret;
 
-	writel(IBI_REQ_REJECT_ALL, master->regs + IBI_SIR_REQ_REJECT);
+	master->sir_rej_mask = IBI_REQ_REJECT_ALL;
+	writel(master->sir_rej_mask, master->regs + IBI_SIR_REQ_REJECT);
+
 	writel(IBI_REQ_REJECT_ALL, master->regs + IBI_MR_REQ_REJECT);
 
 	/* For now don't support Hot-Join */
@@ -1175,17 +1177,16 @@ static void dw_i3c_master_set_sir_enabled(struct dw_i3c_master *master,
 	master->platform_ops->set_dat_ibi(master, dev, enable, &reg);
 	writel(reg, master->regs + dat_entry);
 
-	reg = readl(master->regs + IBI_SIR_REQ_REJECT);
 	if (enable) {
-		global = reg == 0xffffffff;
-		reg &= ~BIT(idx);
+		global = (master->sir_rej_mask == IBI_REQ_REJECT_ALL);
+		master->sir_rej_mask &= ~BIT(idx);
 	} else {
 		bool hj_rejected = !!(readl(master->regs + DEVICE_CTRL) & DEV_CTRL_HOT_JOIN_NACK);
 
-		reg |= BIT(idx);
-		global = (reg == 0xffffffff) && hj_rejected;
+		master->sir_rej_mask |= BIT(idx);
+		global = (master->sir_rej_mask == IBI_REQ_REJECT_ALL) && hj_rejected;
 	}
-	writel(reg, master->regs + IBI_SIR_REQ_REJECT);
+	writel(master->sir_rej_mask, master->regs + IBI_SIR_REQ_REJECT);
 
 	if (global)
 		dw_i3c_master_enable_sir_signal(master, enable);
diff --git a/drivers/i3c/master/dw-i3c-master.h b/drivers/i3c/master/dw-i3c-master.h
index 4ab94aa72252..8cb617b8147e 100644
--- a/drivers/i3c/master/dw-i3c-master.h
+++ b/drivers/i3c/master/dw-i3c-master.h
@@ -39,7 +39,7 @@ struct dw_i3c_master {
 	char version[5];
 	char type[5];
 	bool ibi_capable;
-
+	u32 sir_rej_mask;
 	/*
 	 * Per-device hardware data, used to manage the device address table
 	 * (DAT)
-- 
2.45.2.505.gda0bf45e8d-goog


