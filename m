Return-Path: <linux-kernel+bounces-296288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5A795A8C1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98B7BB21A15
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA804C99;
	Thu, 22 Aug 2024 00:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzX3jAWg"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFC34C8C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286234; cv=none; b=Lx5jpALK77iC+xen3e7mc/R4FgIwSbZgTGTJ4TRV227honPeDFF1yhN114Xbyq8F+jED/esTcORLG7WI6GM543UzIWTNGjCGo/3kOhwmm7/H6F0KYHcaCpobDVo+m1VFgtTwHQG4EQIQIAfvC/anoDzTi6b7EpuJEvqQIGoDX5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286234; c=relaxed/simple;
	bh=57EgDO7wwW4Xp3hC/mZZxUMJUnSFIqSkyprXXtuhSu0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ZeZBJnI7ChyJ59QNi2OdLZldhkM4k07wi1+W3bYl6bFdwGnWps18MTHY/bg0zwLwDN/ejIL2e+DmuTJeQxHG1320QlMSVNjidg/xvE0h8dWl9DUEm7uW4TC+6vcE2KGYfdCcrLx/CYhYGZHC4BLCBPRZapO9fJBGBxOp6EKxDeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzX3jAWg; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d3d382de43so36820a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724286232; x=1724891032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nzb9QWjLKzYt8f0ePQ5wDYcjQayYXKrofKHMppqwv9Q=;
        b=VzX3jAWgQ4DaHb14hGvKaSpbBsV8Fu0eDEA1PNhJ2lestA0W8BEnL7kePceZWXN95X
         Pd6Z3so55ILK9zeoLFvwBsF8yTUruDr+EsL5WUA5RP+tKfBrCG/nJBS9SAEeqR6aihiR
         FwR+a5QsHncEqJ9d7FVy/x9m80u0vg0MFg7mh6tm2+0Lh0m+mxbeN6bRHInqdlfIClb3
         lTE2EmUna5JyINlJHid4j7LaPieFM2qt/Rpn5VLF5KKqdxRtDlkHm6wMVegVz1tK/XeJ
         3Op76ppZCJSOxHkGl3/sVzy6zcHmorFuPOYUsEyzAGUPjVZfRm6xQSA1e9rcQ0gYs9QI
         sBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724286232; x=1724891032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nzb9QWjLKzYt8f0ePQ5wDYcjQayYXKrofKHMppqwv9Q=;
        b=WwA99xH/qKlLFTTXUyik2eEGkgmQqnr0ZENxvmH1DBWihvUmsvPoOvUatXf3I0xyez
         shMQ5EZQNO9SzLuEnWvdtW+i8Wm8wn+VaL34qpIIZLCFrJKKsR3VYbYn6zYec1tywvS8
         iDtn9g73frfWBAYWCXPR8+3SYxud74Za0eceixv18nmu35RM7bjKqp03f8xaDg3nKq6o
         y1fEmxkFslY8S0IN5YsIPIJHffNoTNB3TgyQ4H2vqe1L87cpINPIsEY46h1LmS0/Ckoo
         hYm9hu/QZhSVy885D4BQjb6uBxDwutkGQlc4BQ6y6XML5J2eWjdZqmwbVheSVZBUgphg
         metw==
X-Forwarded-Encrypted: i=1; AJvYcCWYaFl6nDY+AIgJSnoZhku5EwwvdDCVWGaM24MXPcE8/5GXEbzcdSDIdNSM43uCjHpjPk4jGCvdJMWyWK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+jrxdR/fYJOeSRi8ChcUTDMpvL9zZT1H3GFkkoOfi+9E8ozku
	ApMor6b/KevhvQFyMT64WtNj8PNlgk/DPRaZcnPsWAajA79BcMq/aZO0DPtV
X-Google-Smtp-Source: AGHT+IFF6bQa7YQNk0jlJkvtj3uNu8uVNiBxONXhoFyf6hH+ZERnzxy2cbi9ZwggyNGcHF3qwCNrAQ==
X-Received: by 2002:a17:90b:3a8d:b0:2d3:cab7:f1dd with SMTP id 98e67ed59e1d1-2d5e99c5a06mr2608367a91.1.1724286232430;
        Wed, 21 Aug 2024 17:23:52 -0700 (PDT)
Received: from localhost.localdomain (erickge2c.fem.unicamp.br. [143.106.41.214])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eba25a32sm2547535a91.30.2024.08.21.17.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 17:23:52 -0700 (PDT)
From: Leonardo Kenji <leokk06@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] staging: rtl8192e: Fix parenthesis alignment
Date: Wed, 21 Aug 2024 21:25:43 -0300
Message-Id: <20240822002543.44835-1-leokk06@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix parenthesis alignment in _rtl92e_read_eeprom_info in order to
silence the following checkpatch warning:

CHECK: Alignment should match open parenthesis

Signed-off-by: Leonardo Kenji <leokk06@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index b3d4b3394284..dcd8650a3404 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -289,7 +289,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 
 		for (i = 0; i < 6; i += 2) {
 			usValue = rtl92e_eeprom_read(dev,
-				 (EEPROM_NODE_ADDRESS_BYTE_0 + i) >> 1);
+						     (EEPROM_NODE_ADDRESS_BYTE_0 + i) >> 1);
 			*(u16 *)(&addr[i]) = usValue;
 		}
 		eth_hw_addr_set(dev, addr);
-- 
2.34.1


