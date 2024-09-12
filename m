Return-Path: <linux-kernel+bounces-326584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FDD976A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970101C23604
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E2B1AC893;
	Thu, 12 Sep 2024 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXC0VMQf"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4B1A3020;
	Thu, 12 Sep 2024 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147430; cv=none; b=MD+KgqltJ77POvsRi0bjkoVRLdXC31ip9LyJHcnLSP2hehf/ufYQ+9tPyUaUAK4JtpvI1EssBeAUyA3+Hi2rr3U0/dhUBJCIJoAZJsmsYB6GgRiRDKaQqhQ5U9OgE/1MyUENFQHtmnDpLZPlHgwyAj2NezMMJPyxuL+oNxvXTV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147430; c=relaxed/simple;
	bh=x3S1sO0l8njj0fSFrAdm5px0sv/Dv/YtzRu/1KedvbY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lUZmUGFFlvqKY3S44eN1hC1vHFcc40pp+Eztrwu5Jw3AN1MyQOOwXwPZOno5iREW1eVe3pqsGuIcEymtlg6F2zIDXy/dyK14TkqN8oI/vUpns6ifGEFBy3ymh7t5w4E6z1jHqBb0Y7lMqlpyWnOkWkN9QnitAkWqheS4AFB0Um0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXC0VMQf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso7598955e9.2;
        Thu, 12 Sep 2024 06:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726147427; x=1726752227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0/NwzYB3SF0Z5AmHdcUQtPyFCfD5iGuJxHqZ94F8XUw=;
        b=ZXC0VMQfAM8cmNdNiPsOH7TaIlQEJLI4bm17F4AzZ2MPZBn8lCBBbdzvVKDKZ8Thlr
         LH9B4oiT1J2ngfhXtvyCVDTduyE0vT7QzKxBJ4AbhcVYjNfeQS/Gy3+E0aVmaYy+pyjw
         XKZlQKPIHPG/NVZsGKj2OTam01HIGIMVHHk1Af9pmuu565c3irscdJAA212bmsUo4rdG
         yuJESUU543I8tyyb/Wvdh4A8D1UVgAcfbPmHTI5PFIkF/0hm31JQ8uaT8w+Ky68xVIOX
         LOXM3Bf/r6+JNXYMoiHjDXFjfp96PwgYlEV0u/kIfjavnBLHqnnigs2kAUEVAaBI7xB2
         Sr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726147427; x=1726752227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/NwzYB3SF0Z5AmHdcUQtPyFCfD5iGuJxHqZ94F8XUw=;
        b=D5Y1ukBWfAHuN/9iqOIw5t3zs0mfbt/VMVVPmLeq35aUNCg8/dVx6c7apykVCWwonG
         rRyb0c8RW2SEUmmYiWfuxXIf7XxmTkHQW46zfnjzzUfPvE4KavyZrERDwhQ6DTmAVd0D
         E3y+7zQfnI3wIkMPooLY8tym5aECdgUn2ic82IKdI+xr9qarrv3zNKRnrqJrMv9chJmj
         JjmstmxF0wepbIt1F1KZ9iG0qj/e0CrO1/10Na9C7v/RBbwqsQN3LRTNcTZGZxCvDhQq
         1F5yOnWeylMvAEb8gkEUso9Jnt39tC2lALjmcUNFBlFgxnBb4Oux7sltNnBkxPr3GQ4p
         hL4g==
X-Forwarded-Encrypted: i=1; AJvYcCVi4v5BM2OZj5H2nWHdl2XoDgzSxBPbtSbEr8in8IHKZ7Fkk9bXkiqMBnkORjZil8v/fyAwF2MZ270x@vger.kernel.org, AJvYcCXyMTF7H9wwuEi4NLpS2JGwcctWE/B1X+r0XmhzGic9rhnAT+A6unBMNySNvyATQVjeYoalbmu7kNu3ErM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Bm/CP6AoXbaq5CjYllzk1l1s/jzqP4aRHAIDjnllQfQL3Vrb
	o5Cqz7jI0PN6WPcgnyLxDW/fE/mKDY8w65v/h5/8e5ZBUyNVMxLA
X-Google-Smtp-Source: AGHT+IGCDqNanapoix0wJXAikhMoad+NFreHvO5Zq++Stza6xZr60keOslTAT1Ly6TvqT+WMZeWiXg==
X-Received: by 2002:a05:600c:4e94:b0:42b:a88f:f872 with SMTP id 5b1f17b1804b1-42cdb572296mr20053035e9.32.1726147426750;
        Thu, 12 Sep 2024 06:23:46 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb116f44esm165968675e9.45.2024.09.12.06.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 06:23:45 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] usb: r8a66597-hcd: make read-only const arrays static
Date: Thu, 12 Sep 2024 14:23:45 +0100
Message-Id: <20240912132345.589397-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only const arrays fifoaddr, fifosel and fifoctr
on the stack at run time, instead make them static.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/host/r8a66597-hcd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index 9f4bf8c5f8a5..6576515a29cd 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -297,9 +297,9 @@ static void put_child_connect_map(struct r8a66597 *r8a66597, int address)
 static void set_pipe_reg_addr(struct r8a66597_pipe *pipe, u8 dma_ch)
 {
 	u16 pipenum = pipe->info.pipenum;
-	const unsigned long fifoaddr[] = {D0FIFO, D1FIFO, CFIFO};
-	const unsigned long fifosel[] = {D0FIFOSEL, D1FIFOSEL, CFIFOSEL};
-	const unsigned long fifoctr[] = {D0FIFOCTR, D1FIFOCTR, CFIFOCTR};
+	static const unsigned long fifoaddr[] = {D0FIFO, D1FIFO, CFIFO};
+	static const unsigned long fifosel[] = {D0FIFOSEL, D1FIFOSEL, CFIFOSEL};
+	static const unsigned long fifoctr[] = {D0FIFOCTR, D1FIFOCTR, CFIFOCTR};
 
 	if (dma_ch > R8A66597_PIPE_NO_DMA)	/* dma fifo not use? */
 		dma_ch = R8A66597_PIPE_NO_DMA;
-- 
2.39.2


