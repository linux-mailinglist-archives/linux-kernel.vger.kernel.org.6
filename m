Return-Path: <linux-kernel+bounces-447531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5437C9F33D5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BCFB18869CA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF9014265F;
	Mon, 16 Dec 2024 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hefring-com.20230601.gappssmtp.com header.i=@hefring-com.20230601.gappssmtp.com header.b="khiFj1hZ"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B05113DBBE
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360855; cv=none; b=HdiLKQHdne9kQTXCgcQM8WH00D/MnQ6cIESsin2c3dEW7st50cbTeOyiKiwlivNULCNLuJu0cOdgBtHayehTrYxTM+CV6cAmAIBjkunv1ehC6pj12w1clhysu2l3aWg+Tk532AxiVAdcR/Gc3dvq+uS1I86LeBmxw/HnC1wgs7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360855; c=relaxed/simple;
	bh=bn3iJLzlKSMWMJtRrej6vZqzCfJ4v28p5CBRgpdTTFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O2Kif4/NrxGGuTdb3o+FEXFM4Y5m32LTE6C3oZXG04hm19PSDad57dTDHbyT8i5IYhWcZHjq1cXpDWkYmg6iDhnNIhmfAEbzqn8AlIlom7M5T2UAeGZYfhbPEyVREtrW2LAdYY7xq70F6JcIuo4IqTiYbaDM81RdZUncEMpQtdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hefring.com; spf=none smtp.mailfrom=hefring.com; dkim=pass (2048-bit key) header.d=hefring-com.20230601.gappssmtp.com header.i=@hefring-com.20230601.gappssmtp.com header.b=khiFj1hZ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hefring.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hefring.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b6e9586b82so320632185a.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 06:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1734360851; x=1734965651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xrDI54RrtTH587z61yGqvhuIg5ioNpJ5JcTwNcL7S14=;
        b=khiFj1hZMQfNWK+ChbH/E99KZuHkO5g4IZLGAdgr4R83qQJjPqDjs6FffVn3Zo1Ll5
         wk+hvB2UlOlbhckPaUAGiuBBuT6AHhqv8YlDYPXqpmuBImzA3cUBxYa9he4GOXKe2EOX
         5aHWLX2anL8xlKdEuSnYeBxEJwfX59rDXorKOprZIEaJvOpkkAyvyGiqATgSQu43Fa+C
         DueWVt1evD4LhcOfyVCz8ETEOoDL6E1vFRQCEGPWB66mWgGvt7ctQoBXkulyc4b81321
         0zEXD0z6UiH1B2qUbaJR/0SuKpf7o2mf0pknQReTy4i0IimI+BmY39IWhEwAUzsQs0NH
         5W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734360851; x=1734965651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrDI54RrtTH587z61yGqvhuIg5ioNpJ5JcTwNcL7S14=;
        b=oaJZiSusY2A5unNb3Ss6fYAU6KifyPCAaWmiYr5bIUkxvdwceVln819XijpGYZ2D3M
         oeFUSfdN8y7WS8CFlVaRg1rSOp8M1HBEWt+wbUeqP2lrJTJjSr4tZ54X2ObR5WmH7QoR
         h2rLfZ9OxsQ96fOSdO5oSbV3fKQr82i8mxURZ1fsbKxJTWeVkVCLb/pBSnHEG+7E01Xf
         4OSNcn9I12tVvzRoN2G/g1mtsQDN45sYCuR9lGVOnawoj08tpvJ/hI0/NL33RH+AiuOe
         thJQwMG3vfJwEzpfHn7WZlWZ6kIH/T6dlVuOv0SKkY/9ngm4UR/94LqZeBQwCVSEXrJL
         YSCA==
X-Forwarded-Encrypted: i=1; AJvYcCUUmOlWtR61s3hLqNFGvkB1gamcLhD0P/kzPsJg4CotTUIWOpH+Hz4T0bxj4OjMJw94VNyOLOvs4C9c3Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHFFtwfZ9FneGffFV2Zv/XRseONtPb0mAKSoq/45Ug32VYH7ZM
	YNh2jhXFfwv/bE3xfu7mD8TwnwXizvKxoXfo7oaN5z2TrDXa81aT4vDcBof5HnY=
X-Gm-Gg: ASbGnctnebRzhFpQQZyM4pQ/zNCX2SaqiDbn8RU4gMXSere4lXldPw1wPO9oOst4wTr
	r7nVD/H1Yd9iDcPGMpEH6d7s+dWhB6OH/vGVdgG1JAJU9SsseseZKuDCOcuFg5VuzF1wLumuZER
	C4hAleVuhQiQaUkvO3sSyOtphcp772+sPA+KT2YbjQ4MlxuhPGO19RH34TCfD4qcxKfCK6FsZLl
	UWzpycItSrMQqsFefi+BcP2A6CIH2dmODNuiKXOARezZz1DdcgkPOj9QJUs6wWr2/HJPf8Tba5L
X-Google-Smtp-Source: AGHT+IEejh93L0FZI+AsvKAjo6R6QN8N65ppACXanwMRaMhjPpRdaO8GmKLrZ1p3hnkSIvCPYIc0vQ==
X-Received: by 2002:a05:620a:4889:b0:7b6:d939:f958 with SMTP id af79cd13be357-7b6fbee8df9mr2384495685a.25.1734360851084;
        Mon, 16 Dec 2024 06:54:11 -0800 (PST)
Received: from localhost.localdomain ([50.212.55.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047aa633sm230461085a.10.2024.12.16.06.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:54:10 -0800 (PST)
From: Ben Wolsieffer <ben.wolsieffer@hefring.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH] serial: stm32: use port lock wrappers for break control
Date: Mon, 16 Dec 2024 09:53:23 -0500
Message-ID: <20241216145323.111612-1-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 30e945861f3b ("serial: stm32: add support for break control")
added another usage of the port lock, but was merged on the same day as
c5d06662551c ("serial: stm32: Use port lock wrappers"), therefore the
latter did not update this usage to use the port lock wrappers.

Fixes: c5d06662551c ("serial: stm32: Use port lock wrappers")
Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 drivers/tty/serial/stm32-usart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 7dc254546075..1ec5d8c3aef8 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1051,14 +1051,14 @@ static void stm32_usart_break_ctl(struct uart_port *port, int break_state)
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	if (break_state)
 		stm32_usart_set_bits(port, ofs->rqr, USART_RQR_SBKRQ);
 	else
 		stm32_usart_clr_bits(port, ofs->rqr, USART_RQR_SBKRQ);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static int stm32_usart_startup(struct uart_port *port)
-- 
2.46.1


