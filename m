Return-Path: <linux-kernel+bounces-515601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6917EA36693
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA6A188E356
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FE31C84D3;
	Fri, 14 Feb 2025 19:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEsA8c0y"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D07B1C84C0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739563002; cv=none; b=DfT21kqHGTJ/QbzDlDLiA5KlaVlD3rfVBLnMcP6tgBMpQBsdLsQA1nDfbYw78TpHcbyXS4LzrsSOzFE8HyDsIa1FYuMT6wvsc12JFHgSA748P8FIJg25sLrzYGEGL1lI1obJM1clh/tj85bDI0nK2TxXUtL+lgrw0ZXkirFajEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739563002; c=relaxed/simple;
	bh=echjav+toUtLY8bX7ph9CHbII8dhqhEq8q/MKj+NGVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TcOPZNKH2uhRa+DNX7VNz6bp72Ev3BK3ZbwaZLJ/hrsMRJ7rB2Y5kfTTWozcV9LpFIBbwvIMPaQblV4Tt5eAdzXGz9NH8+eCk+vc2QmXaaqDNamXJdP4/M+lnQEarLGTjlBrEHy+dU7GvEGg+V0CWb4ReI6LLLaMPGQM892H53g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEsA8c0y; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f9b8ef4261so534017a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739563000; x=1740167800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wx473TxCM555Yxh01S9xtHDPkAuBmTyv1sHlXyhK+8=;
        b=aEsA8c0ypjOWns1rVoB2FrWShpiL8CXBbWCpKD0bbr6VCrk887cz+QdtqKImy32um9
         gvc/i3nPMN2/XWAvTzOkzSl/eoMwmSd0Hi1Bh5xClawzshX59TONZMKE9fdNvzRIXVc9
         Q4yi6v+5U+gQGlxAfwXPXmNylVT4Snll2rm5owRzaUGhKdS4MnROXC47OMSds9xgvoAl
         cJ3MJja26WsTm1ANTl89dLQqNVKZVfWmhPjZajo0CEBWeIAkO36kasQVr9rKTDfvWeLM
         dfopgJqmxO4/k1RAPHk4/FlRk1+OP8P0fffpv3ACdvjnqG4IX1wDoBuC56YN8V10Kzvn
         K/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739563000; x=1740167800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wx473TxCM555Yxh01S9xtHDPkAuBmTyv1sHlXyhK+8=;
        b=t0V4e+HivEPCczFcvkaVg0pAVfYlX8gyfX+x2NOshP4YxB1727/5SRfMNiOoE5ZmAZ
         Y9CftszbLMt2Zso7ppjd0fhMPZGWgmhaDq+SskflCQuanc5jQaDkcSsvjYgOEyoHR0rz
         CyvmDIGnGgIHsgIxqtwJF2X0fVgtTnVznOeVegdiI9JNXNGsuJ/1XcYUad+LDetcM9zT
         NF1Or6p0rjMEpXZAgZuMdoZzrY6GGwKvBSG0JqCpgDaA0BEvHO5RHEQ5EetELkl4L4Ql
         JYqVpb8evvY1T9ZIF00r0nnWAe6s+DtkInrYsRFCLsa8VEfpG9utZ4AZAthAxX3QccjF
         k4bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKWTVHGeWuhqBHu6H0PiX2eRBAbFbFpo5YUv5PtMshLs714TYggue/zGHi371W15murqHyz+EFf+a+tFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Na+ZPYqOX9p3jyr4aWS7/4ZdDMwFQ0iN6OoyZe04tX228DG+
	fkqoRkgu9Jeu/X9QJdQe0yQhiYb/cS5AAuqvK0Vp1Vmm35eAyD/N
X-Gm-Gg: ASbGncthu92K/cdsiDXuWJ2v5YTzEoyeK2BPni3EogSnI8bHS0AIzL+JLFMhyj1juWV
	7QHopgx2muoI455YJleCaZbZiKkgnune4lrEuTg4k1SdGAs72KI75VKYy7dRfnqk70LJFz/U5Vu
	AAAIi1gg/6iyd8zC8wVMWDOKkYdE29WbF4OnmaZ/Iu4de6REbh+jdG1xYWPZyPuej/anCJRghXp
	RlwQL1iGh23yCsZdGBsr/8H2EVaL2Q2EHWvcB6CMRbf1guMfJKEtG610+Y5AMgXv/KwA23lVwQ6
	U2qpzls5MxO2V+OoXb4qjc239gLFrVk=
X-Google-Smtp-Source: AGHT+IH8byrqt7eq9hY+C/QRNXxcZ9q+AeahMXsTlX/kzcus3VCl/XbmWsIev1W1My1h0CgwErORZQ==
X-Received: by 2002:a05:6a00:ccc:b0:730:96fa:bdb5 with SMTP id d2e1a72fcca58-732619416acmr391931b3a.6.1739563000043;
        Fri, 14 Feb 2025 11:56:40 -0800 (PST)
Received: from localhost.lp.veng.com.ar ([200.10.125.114])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73249fe96b4sm2670530b3a.75.2025.02.14.11.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 11:56:39 -0800 (PST)
From: Gaston Gonzalez <gascoar@gmail.com>
To: linux-staging@lists.linux.dev
Cc: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	ajithpv.linux@gmail.com,
	roheetchavan@gmail.com,
	niharchaithanya@gmail.com,
	eleanor15x@gmail.com,
	everestkc@everestkc.com.np,
	kees@ijzerbout.nl,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	gascoar@gmail.com
Subject: [PATCH v2 4/5] staging: gpib: tnt4882: remove unused variable
Date: Fri, 14 Feb 2025 16:54:46 -0300
Message-ID: <20250214195456.104075-9-gascoar@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214195456.104075-1-gascoar@gmail.com>
References: <20250214195456.104075-1-gascoar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove unused variable 'retval' in function 'tnt4882_update_status'.

A call to nec7210_update_status_nolock() is added as the status bits are written
to board->status in that function.

This change removes the following warning:

warning: variable ‘retval’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
v2: add call to nec7210_update_status_nolock() function.

 drivers/staging/gpib/tnt4882/tnt4882_gpib.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
index 2e1c3cbebaca..19f6d798f09c 100644
--- a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
+++ b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
@@ -704,12 +704,11 @@ static unsigned int tnt4882_update_status(gpib_board_t *board, unsigned int clea
 {
 	unsigned long flags;
 	u8 line_status;
-	unsigned int retval;
 	struct tnt4882_priv *priv = board->private_data;
 
 	spin_lock_irqsave(&board->spinlock, flags);
 	board->status &= ~clear_mask;
-	retval = nec7210_update_status_nolock(board, &priv->nec7210_priv);
+	nec7210_update_status_nolock(board, &priv->nec7210_priv);
 	/* set / clear SRQ state since it is not cleared by interrupt */
 	line_status = tnt_readb(priv, BSR);
 	if (line_status & BCSR_SRQ_BIT)
-- 
2.48.1


