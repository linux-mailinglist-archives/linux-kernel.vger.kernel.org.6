Return-Path: <linux-kernel+bounces-354472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 568B3993DFF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 06:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5809B20CFB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BF84779D;
	Tue,  8 Oct 2024 04:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b="X9xPEK23"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3752AE90
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 04:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361079; cv=none; b=aB5INmq86Fol/7OipO04aFzbwardGQBbOOS8e/1lLsM2ZWBfP0rKZE2kttUJt9bt4zpirUghEDRfO8S6mVZOAKd7PrZ18psUJalsVorkEFPLE/SLIFs3RtB16fzFQpnvjEk7mjXAGthNrvVaCfHfNIyhdUgq0RlfmfqOHZF9l+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361079; c=relaxed/simple;
	bh=6HfLF08HYL3p3XfIceMe4VbK2ifsfg79xObxJmr0sVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A+xEmWB4gI+wuR+ZshGsm+QsXR4Ed9fnLuCUMcxJdKW9xV1hck440ESe8MWG7cgMxaeM2gJHTD6KdkAe6MLpFpKe59VAxCt3VVteil75BZd3jnUN9NnlO7s5toS6+rNGbMePtvhvZWd4b3USWmpF1yovjwz1REPzW5Rk16sZ7A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b=X9xPEK23; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20bb610be6aso57945925ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 21:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20230601.gappssmtp.com; s=20230601; t=1728361076; x=1728965876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qwcy1Q3TMls1bnUmrpkwAG4GSqExbl+rH8vmvD0fjhY=;
        b=X9xPEK23SW43+dcrRSn+rF4DTvv2wzUX5KsgQgMghvXn9IDox+9c+5in4u5f3Q90hb
         aSiE8tCCtPcDXlUs9OTKpy2OjfqzIjxupPlK9d7IH2L/k6O+H16T4McTZgm8cume1DNZ
         zLYhaEbp0Kc4KSvrAsleLrTVx5pbE0USuvDoc/TUGsomB1gJHbJpPC448C8jEXGW9PM6
         OkxfrRyJDE8anTF+LB94gSbKY1nFsGW3S3AVeU10otGrda7C0Y2sroULBtdcvFbREcmN
         nH2Ppjz6RWPt/bEWrizUNtOveVFGzBkfTh4kh0ZF73Mg3FCRqiVrzLi3+tCx7huZxqBb
         tyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728361076; x=1728965876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwcy1Q3TMls1bnUmrpkwAG4GSqExbl+rH8vmvD0fjhY=;
        b=hEmUSww9RsVn+nk6AxaaPgEjk/87O5quPjnuLDMS6Ip8G8y+if6nySfnqG+IblKzmn
         H3A6vPFvg0AVur2k7jsLQaacIqE9oW+iNQCOQ+TLw1/AG+Ngx1CpfJCzzWfCIlMNelQP
         sSzSzgSO7FD1b6zryUwRoYdra/PUlhVTOv7A4/ois+CRbsK+6p23MFS0cgR6Kw8MmEt2
         zMS7azhxoeSN8/GLry1+9M1xSlbpJX5jxaEJSvdDpp42nkbBp+YDe14ZqQKa8q7+SQVM
         SDVZ4UdalhI1S8OUMkD4Mahs29joT0I6oAdGnAL8fVlmv/cQvMBPs+xKDOqWpCQFcAMd
         J5ig==
X-Forwarded-Encrypted: i=1; AJvYcCWk+orGvy6q2/e3aG7uZirxDFhnoU+ttWQJEITcD0fc4KpON6vx8jCCSst8nlRzGn7/CrFxIzSgYpWzL7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMxQL5Jp0xRAKIoO9bOLq7jXBP+0jXN5P2XKMSxv1sT/SDWrh4
	DyHyyc9ihY27TUarNTPeHxpjV9TTINjR9gZMrK5Nf8khq8pMEq45e9ZUi9IwjrNE9JSuStqmwA=
	=
X-Google-Smtp-Source: AGHT+IEh8+JdOX8UEHE73IwMV3DO/pt3CS+IqKhGFGP7T+L5b5Z16aHIMvyypjInsvw7o9r7iTWVIg==
X-Received: by 2002:a17:902:e80c:b0:205:5d12:3f24 with SMTP id d9443c01a7336-20bfdfc0557mr191055685ad.20.1728361075664;
        Mon, 07 Oct 2024 21:17:55 -0700 (PDT)
Received: from localhost ([2405:6581:5360:1800:5cd1:adf7:7fbd:8a98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cec9dsm47168085ad.103.2024.10.07.21.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 21:17:55 -0700 (PDT)
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To: alexandre.belloni@bootlin.com,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
	Jeremy Gebben <jgebben@sweptlaser.com>
Subject: [PATCH] rtc: abx80x: Fix WDT bit position of the status register
Date: Tue,  8 Oct 2024 13:17:37 +0900
Message-ID: <20241008041737.1640633-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WDT bit in the status register is 5, not 6. This fixes from 6 to 5.

Link: https://abracon.com/Support/AppsManuals/Precisiontiming/AB08XX-Application-Manual.pdf
Link: https://www.microcrystal.com/fileadmin/Media/Products/RTC/App.Manual/RV-1805-C3_App-Manual.pdf
Fixes: 749e36d0a0d7 ("rtc: abx80x: add basic watchdog support")
Cc: Jeremy Gebben <jgebben@sweptlaser.com>
Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 drivers/rtc/rtc-abx80x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 1298962402ff47..3fee27914ba805 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -39,7 +39,7 @@
 #define ABX8XX_REG_STATUS	0x0f
 #define ABX8XX_STATUS_AF	BIT(2)
 #define ABX8XX_STATUS_BLF	BIT(4)
-#define ABX8XX_STATUS_WDT	BIT(6)
+#define ABX8XX_STATUS_WDT	BIT(5)
 
 #define ABX8XX_REG_CTRL1	0x10
 #define ABX8XX_CTRL_WRITE	BIT(0)
-- 
2.45.2


