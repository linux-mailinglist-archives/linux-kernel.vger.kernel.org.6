Return-Path: <linux-kernel+bounces-518278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492A9A38CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6ADC171159
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98149236437;
	Mon, 17 Feb 2025 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBuFN/UL"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1E02376EA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739821880; cv=none; b=VP1QQ3nqmeVEqbx+6lAZhdnNuHrI+hS4ORLcQuq/2MuydnCtJG5Oa6lW3CGy0vR1i+RuMKEFDdVw92kQjjqU+eYhnwrbYzkkcp6X2bGvDlgItuhcz1CH8tMfYFKHtSXlxKaCOmTO11satM3ryphbs3QUx2j61LigjDJQv7J1y5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739821880; c=relaxed/simple;
	bh=5JCtn3HaQ2Y42IOCz0vVF5B+3fj19u+R4j7L/gr3zkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsRh8ROHUQcitVzKH9dIoqSRYW5oq4x7Bk6xaooQFho8Q6YZP2fDmyaQGh+knZrctMDCuJQQPa3t6uclrbtck6Lx1xih5yQtWWYtCinV6k5Tosaiwc+fAC/2KeL5M9+oSb9Onn8uwMH0dB2uznV2smqxU+s4u+ZGyouxpOWT51M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBuFN/UL; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-21c2f1b610dso118812505ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739821877; x=1740426677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+OA47VmynX7pepNmjGGlDQZM/5yLns+ASpEva8XVu8=;
        b=UBuFN/ULn8me4XBC7IVnNisuhjVmJAZPiXgMT9RUww0JuZ6LN7iHryLuC09+f0Nz7P
         ZncgiEvjqlOrNNq4Epfme4Bowfbsc7ZR0xX2dTIen35DkRf+yffZhwO9dYXtNZvtBZdK
         qhbbZux6nEPBOk/87r52bs1TxwE2NVWddSlGxvI5ki1WPIMZwj6yo3DVz7RnVmPUEiv9
         D7s1pa5E96+Oew0gaPDTXD4aTNIC9BfFtnmyGcCFM5kCJGRmcjcX2p+g9NgQpVYzCWMg
         T4IjpeQeUyracRzrNlr2I6H4RVhpeezyn2FtVR1UeCfdW5ft6UgOI1qgB28aZaUvUBtA
         fDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739821877; x=1740426677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+OA47VmynX7pepNmjGGlDQZM/5yLns+ASpEva8XVu8=;
        b=Nsg3+w1TtnasXpS3GvAI7UUqEO94Y4DcvTLWF3AolSttMaDJJakYftbapTpP8VyFIu
         T+4gRbyiwmLkqWn5ZpP5iFBErQKJVmwlZWtgN1ZvfaAofWy6x8UswEeFEutrZ4vCguhy
         /y/B4AwDmSoo9nHUYGOSATXIJGUGhx4NOxAjGL6CmppgPsVaCp4vw2lY1ifNv6liqfIu
         ziWdKDzC9AM0Kc4X/AxsY4LNLBUtUwuzNdHdxr8xC9KXUlJhJ2IBVOHodFAU8coOSDSa
         02Bi5z6hG487uH/pZjVRB9HIPp/A71e84YYkpYIxvYiZZkiTTdAswOkeTPKRWEIGN413
         Fqxw==
X-Forwarded-Encrypted: i=1; AJvYcCWFOxkj51uPcdNfSW4DCNAPxK/rtuUZeXS0d0CrtKan8HrljCmBtivqzWZ9C1AOJNxGTfPvtspDYEbjGN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv19YpHW6kblMIRUZJgSKVM9+ZXQFZ+YvlaB++/J1m+zOMJ445
	6YTrIxdbOPFqCT5aVcW5dLlFglFAFvkhX6YVXhCkYmAbgUlld20A
X-Gm-Gg: ASbGnctjaaQpV2lHuAscrwVNc9ehLnAllBMsRTvrY/B2nOjLGzD2Q3j9B+MeBqumR2I
	a5yk9YH2+C8omAhPHBOIMe6qOGXCSxg5sh5QFSV0zHszjhnDYAFyZSRnUv9i5TLK6OPxrjZ9T2z
	eESqhm01kp24i6OmmNpMQb1zb0APXj2yoxVfZcCY+b1IonHfTlaxXrP7eKmlegz1osMMlmBOR53
	0rR3JY9jTx9ha65yq7na6DIKwIs4JMU8PhXjLZps2keXRZ/yYVyW55AbuZHWAFsGYXemUM5V6Iq
	YOzwuY+CP2HNhELup7Wp
X-Google-Smtp-Source: AGHT+IGX/PqH4IdF45LylRY13MTSCdLLYKcQkYQNdNSp6Anjsr80DZAfOnbZoTKi4sYfhLlThW8VjA==
X-Received: by 2002:a05:6a00:1256:b0:730:91fc:f9c9 with SMTP id d2e1a72fcca58-732618b0b1dmr18138986b3a.16.1739821876633;
        Mon, 17 Feb 2025 11:51:16 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:1d76:db25:b6bf:4f52])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73278d09228sm2811898b3a.117.2025.02.17.11.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:51:16 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	kuba@kernel.org,
	dan.carpenter@linaro.org,
	rmk+kernel@armlinux.org.uk,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH v5 3/3] staging:gpib:agilent_82350b.c: removed braces from a single if statement
Date: Tue, 18 Feb 2025 01:20:50 +0530
Message-ID: <20250217195050.117167-4-kumarkairiravi@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217195050.117167-1-kumarkairiravi@gmail.com>
References: <20250217195050.117167-1-kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>

removed brances from a single line od 'if' block

Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
---
 drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
index af1bf6e893..0c07745649 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
@@ -205,9 +205,8 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 		}
 		writeb(ENABLE_TI_TO_SRAM, a_priv->gpib_base + SRAM_ACCESS_CONTROL_REG);
 
-		if (agilent_82350b_fifo_is_halted(a_priv)) {
+		if (agilent_82350b_fifo_is_halted(a_priv))
 			writeb(RESTART_STREAM_BIT, a_priv->gpib_base + STREAM_STATUS_REG);
-		}
 
 		retval = wait_event_interruptible(board->wait,
 						  ((event_status =
-- 
2.48.1


