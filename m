Return-Path: <linux-kernel+bounces-204290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246A68FE6CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CBE2881BE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA5C195B15;
	Thu,  6 Jun 2024 12:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="El/h3GFP"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9895A190697
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717678108; cv=none; b=lQE/JZkkNlAGkNULd6Vxlwy1/2gFdlWttPgzXdjJo3JSbaH6m3aSlM6NR1mlPAYKnLvkAKQ+MKZUgXMf51jfjrdiULNg/YlQjTRBl98hZ18bZRL8+rDI9UTQBJS/wDRUilPRNSJKZJpr5yVgq4XcDvKHN/5xu8VNPw/FGLqllBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717678108; c=relaxed/simple;
	bh=3oqKquLKH/ZgB5QBObQnp+BCwHHnjC78blYNG39BwTk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Pm0hA1awXlTAaKrBUuAGoMwctSuvWKa0ZSwkSdQ91H8pfVxiuKMoHQiis/DFKn/lkXP6X3cW9kU9vNrSPByjEf5eMFvbNdl1+iVthtv/tCAjornkJ1XYF3ab69OhJgsgSiOHOZDZ81a+lUtovBZdrfJzl4xQ4OPt1syvWmPI1jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=El/h3GFP; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfa84f6a603so1495391276.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 05:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717678105; x=1718282905; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FNMGfW18oepz3ctHxT2v/fTJlvcIHvl0RqDaCUUXgSw=;
        b=El/h3GFPizpYGAJ4PQw6iId2lt2sU1KiOtyrp/kslniprdwvnOgF7knOoORdMRPg7Z
         lxHhqU/jpTwPhkXWUjXup+YI3F7Npk/iv9HR5dJ8fw5F0epaFCEQktqewmMZDxAiLktb
         xEnO7XK/Ks+LlJyhkZQsdLuFm00aLDD84f4MWnmaQ4umqUil42RI+m7PpDJt7RTHBU0/
         5UZhCeHbfFbDCwug+0dbJAlKO5CMclj6jgAfJY7nzpw6XdEGuFY+wWIW6cclJArCJACV
         v7v4XnuSPzIxKFW14BCHjb+TONjGlWPuAFcRWU5NPL324N9Ab9Lanu9H9R45MsUQ0Jzi
         RHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717678105; x=1718282905;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FNMGfW18oepz3ctHxT2v/fTJlvcIHvl0RqDaCUUXgSw=;
        b=F6j4dU1GAqVZbHTiuzmp/RGLGtjbKZTtGXBck/grcHN8CzMj/kA6+V7qMVsTD5OI4c
         8y3L4oREFj8FMavxkqL821Aj4IfbIiZEFc07wlUe0ekoCsW+XBQI93Hztp6wYLbVkjJu
         SLIWouwedxf2ESXfu66Xw9cX6hayVBqwrGclcnaa4turMTFX760T51ICbkjAb8SXMhvK
         wFUyuW/H/7YECH2BmKrKImRzJVOxcnq5CX+PhJ7ZsA5PeR3cuDZ5Mg+FZpO0zpGwKJEI
         pUVWQhVF0mFpN2lGVLx5ak1BzMocmJZLYfU+fTFMnkqfGUY9EeedOCcnckOvZP+RyPPt
         A/LA==
X-Forwarded-Encrypted: i=1; AJvYcCUAXivhyEH1MzXyAMPrpzt9Df+j7S6NDb0Y5WyImp4Pj5VIz63UNJ2Yc9kS7BXVK+NhlUZF83J2lkIWApvZ5FEFyLmLxvgE8EMxiO+P
X-Gm-Message-State: AOJu0YzEJkZCQrMK0b0DV8GsXogKmTesWIXSNdTKOla0knl6giFy4bwp
	N6lXmoEU7qJMI75mXf1+FUNYi6VyfdMDQt6WjiFuI/bxb7xWIK9ehlo+aIYClCaSZsfroyhn0mN
	nls4y9xLer4UV43avrwtgb/4/uA==
X-Google-Smtp-Source: AGHT+IGyFFTFa03GCHnZkv1BAA0sPoC1f/yGvtDNotGuIKgkWBUvrfNZqbo7e1nX4X50u55/G66XwMCRh6p0RnlOAn8=
X-Received: from aniketm.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3387])
 (user=aniketmaurya job=sendgmr) by 2002:a25:6851:0:b0:dfa:5cb2:fb1 with SMTP
 id 3f1490d57ef6-dfacab1f6cdmr189986276.2.1717678104783; Thu, 06 Jun 2024
 05:48:24 -0700 (PDT)
Date: Thu,  6 Jun 2024 12:48:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240606124816.723630-1-aniketmaurya@google.com>
Subject: [PATCH] i3c: dw: Fix IBI intr signal programming
From: Aniket <aniketmaurya@google.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Billy Tsai <billy_tsai@aspeedtech.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Aniket <aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"

IBI_SIR_REQ_REJECT register is not present if the IP
has IC_HAS_IBI_DATA = 1 set. So don't rely on this
register to program IBI intr signals.
Instead use a simple counter to do the job. The counter
is protected by spinlock.

Signed-off-by: Aniket <aniketmaurya@google.com>
---
 drivers/i3c/master/dw-i3c-master.c | 4 ++--
 drivers/i3c/master/dw-i3c-master.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 0ec00e644bd4..08f3ef000206 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1177,13 +1177,13 @@ static void dw_i3c_master_set_sir_enabled(struct dw_i3c_master *master,
 
 	reg = readl(master->regs + IBI_SIR_REQ_REJECT);
 	if (enable) {
-		global = reg == 0xffffffff;
+		global = !master->sir_en_cnt++;
 		reg &= ~BIT(idx);
 	} else {
 		bool hj_rejected = !!(readl(master->regs + DEVICE_CTRL) & DEV_CTRL_HOT_JOIN_NACK);
 
 		reg |= BIT(idx);
-		global = (reg == 0xffffffff) && hj_rejected;
+		global = (!--master->sir_en_cnt) && hj_rejected;
 	}
 	writel(reg, master->regs + IBI_SIR_REQ_REJECT);
 
diff --git a/drivers/i3c/master/dw-i3c-master.h b/drivers/i3c/master/dw-i3c-master.h
index 4ab94aa72252..44a5f045f007 100644
--- a/drivers/i3c/master/dw-i3c-master.h
+++ b/drivers/i3c/master/dw-i3c-master.h
@@ -39,7 +39,7 @@ struct dw_i3c_master {
 	char version[5];
 	char type[5];
 	bool ibi_capable;
-
+	u8 sir_en_cnt;
 	/*
 	 * Per-device hardware data, used to manage the device address table
 	 * (DAT)
-- 
2.45.1.467.gbab1589fc0-goog


