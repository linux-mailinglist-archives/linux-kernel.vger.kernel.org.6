Return-Path: <linux-kernel+bounces-209734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE45E903A09
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F7B1F234B5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F56117B50A;
	Tue, 11 Jun 2024 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yR3r7+xn"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D2617B41F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718105218; cv=none; b=SYuNhF4Orr/d6pLH0L++zwuYy8lnZMRD0MrYRLXI6HCFprUOu4IROrszXaat2jj2zC80gl5pdVB5HORGU+es4+lu9Rm6dBpP3M2cUA7IUxdZrgfvhhUXBHgKgjJIzwcXFhD60Vrb++z6aejZjPiGltQ1ywdE0V9CtiTTmDeSOpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718105218; c=relaxed/simple;
	bh=pbRlDuabOT8nyBwfQKvsyClHBBDYEiD147x9jPMMr+U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mMf0Jm9ScN6Mf1kXhUBWQEmgeo8FMhkvnekMxUjKHZ5JiXGLQyZ1rE0B/2QZE4pjD8RijZcZCVbpAKnz8hzKJEuLwbk+6mnCKsgU9/u5lW360VcSP+NuANbQztfyl9GUgXM1L0G0/D6kkMlCtCJE1TEUaCveQa+ZqXXmoSCMvsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yR3r7+xn; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df79945652eso1573270276.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 04:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718105216; x=1718710016; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MaYjj3o2ALLcKToV9N4PUJjf27yiK1Wwgvm7Ar9oqEc=;
        b=yR3r7+xnQupdgaB2CRM4lXzCHNaZHTIEVMtnl0RyeygmeL7hGLoIpFyY6HeRFCsyZq
         eYxfhcLuRtstCNHxBU4uOzGNzEOiuJtfQETZJkXJKH+sJh9BSI6hjL/8A5mGstUwpjzA
         63A5pD4quU03JG0VjFIdkNUGxMr31KYz5LS7DrXKMmWxg6HFQDR4a5n3i//2EWG+tZin
         lICeEkS4MUmWOndQZKr1C6dCsvxCwux9hq9O0OEZnpuNt0gcEqLk9sbfB3UuWwRtoVbx
         F+BlbA7XkwhghU96Z4Vcyz90huO5qnu+s+5829KFABrJDuZRF9dq1xjp61RxxiN6JmUY
         zIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718105216; x=1718710016;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MaYjj3o2ALLcKToV9N4PUJjf27yiK1Wwgvm7Ar9oqEc=;
        b=JD0a/E3+bYbwg8KsvgegBf20HAjA/hC7B1Y4iwl/FAN7pW/Za3QLG44k03sDiVjVZj
         /vlP/mZ1GtOxJsc1RsSB/TykbswQYWNzJIyGuGtDbvyH1KKG13/pxA11vaBvgEHQIs7/
         o61M8wOg2LGWtkTHawdd2LJKgkUUgP393X03BiCQeaE+eLmnInJ5YuitziI5rdTHvxXl
         QK6TEge0sFNXArFYiK185W3om3jTnLbdf6dnv6a/VOGrHfr7XSvenHHTqYl7wmfo0Uyx
         g1OO5sb0/U+NFUu8ecXO/Fw32b6csFM0TNUpVcVcTLLUT/siiC1j71RcUPzAOBWUJ0HV
         kkqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaRFzPaMTrWVCOtp22iv0Xxcxk6DlTkO1IiZO1N/MYvCFi2JM9+Q6nM/L4KAKAkWz3RsydNgE++5ZIo+ORDTErhlq7N+hRh3ck/skD
X-Gm-Message-State: AOJu0Yx/o0UJZ4qGgxNbryLiMSN70P9MUe4sMO/KvRGyQijhflHYFLpO
	BC8mX8cCb4wOpGbgBCWhM+uRSpJk1KaF6c7/i1BrTnKpfsVsea/Mo6GYabDQ3S3wb/kBfCQJ7G+
	cjb4BEyN54LRijmtVXSmMkFakAg==
X-Google-Smtp-Source: AGHT+IElcMdi3wlvSVhWoNYrNzkONnlxS4SEerVIJykNzoKLbDz1/mE4KxfpG2CZvaHhQRvKrrqTLgiDAqi33MqtNN8=
X-Received: from aniketm.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3387])
 (user=aniketmaurya job=sendgmr) by 2002:a05:6902:2b8b:b0:dfa:849d:3a59 with
 SMTP id 3f1490d57ef6-dfaf667471bmr4157407276.13.1718105216433; Tue, 11 Jun
 2024 04:26:56 -0700 (PDT)
Date: Tue, 11 Jun 2024 11:26:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240611112650.411214-1-aniketmaurya@google.com>
Subject: [PATCH] i3c: dw: Fix clearing queue thld
From: Aniket <aniketmaurya@google.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Billy Tsai <billy_tsai@aspeedtech.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Aniket <aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"

QUEUE_THLD_CTRL_IBI_STAT_MASK is repeated twice.
Replace with QUEUE_THLD_CTRL_IBI_DATA_MASK.

Signed-off-by: Aniket <aniketmaurya@google.com>
---
 drivers/i3c/master/dw-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 03911a5c0264..77a2a1c3fd1d 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -631,7 +631,7 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 	thld_ctrl = readl(master->regs + QUEUE_THLD_CTRL);
 	thld_ctrl &= ~(QUEUE_THLD_CTRL_RESP_BUF_MASK |
 		       QUEUE_THLD_CTRL_IBI_STAT_MASK |
-		       QUEUE_THLD_CTRL_IBI_STAT_MASK);
+		       QUEUE_THLD_CTRL_IBI_DATA_MASK);
 	thld_ctrl |= QUEUE_THLD_CTRL_IBI_STAT(1) |
 		QUEUE_THLD_CTRL_IBI_DATA(31);
 	writel(thld_ctrl, master->regs + QUEUE_THLD_CTRL);
-- 
2.45.2.505.gda0bf45e8d-goog


