Return-Path: <linux-kernel+bounces-397976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E916F9BE353
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9802845A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A380A1DBB03;
	Wed,  6 Nov 2024 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkTk7VCB"
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0BC1D7E37
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 09:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730887113; cv=none; b=dDjBIes40Q6RROkcrd+0LqOOL/ShP4gTpZwXxuwQPwvmrVG21e5OXcLxcAq/XjeMot7lXBxnX7qAbVEaEKhu4xL82OUkouHp33zfE0kMD2hkHn0LWrQxS1RxS0svbWg8NfaIZc5zKzzbm2ICfR+6fZ+er2SJgoP+v4L0qZxAmAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730887113; c=relaxed/simple;
	bh=r8tGsCoG9wLufbOZ5M5/PI/FbmgjucQ6I3ohVntAYNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hxLz8UhQROEaodQRTXZuc3xG3+6SgciS66c1lvk2O7nsXh0q+/WhCZEVDh9kev0V/IS5ZYYg5snoJJ6Mq1P9BX/8vAwN5SbTroiR7HSAlSaCtf5ZHkLGuy5VBtBsQ8Rhrc68KdAZM+nkpykk/yV9A6fndUkc5uSOV29mYDoV0YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkTk7VCB; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-7ea12e0dc7aso4412817a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 01:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730887110; x=1731491910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IL+yWlh9vw0jY8HppITDLAmrvaCxhRoxikmmdyKh+y8=;
        b=NkTk7VCB/1Ai886uEdELttQXq3Zm33AWCbme+MmSw3EaC9yfFYhlV+ysXTd4mexmsf
         jO+ZweJ0+wEVu6vPB5Ky6MW9RvExx711n85ENkcc/j9RezlTHjNNITB7oomGHlSWLp80
         WJof/ciet3HumYg137VdeZPYBTIsNj5x19NWpyWzfNmghy+Dq3YjWRPiiJyscWBtKPqm
         dm+uqxYhXgNSmzjmv2dTdYAQAdGXh74Qr/mzonvH1ZE56e4m7rz1w3/x4Ck9CRDYGumZ
         I0nFOYvnN/Za9+igGGNsg2q29q0KYwh0J8Y1ICoSbJvkQnzoCfszRPUcK1UDH2LmPWNg
         cjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730887110; x=1731491910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IL+yWlh9vw0jY8HppITDLAmrvaCxhRoxikmmdyKh+y8=;
        b=G4as6OvLoZE9ZNeWGgx5lvrDWfxsHCIVgqcCJU48S2KstPClccHOZlwrtN7ZK31ZEZ
         VMkQsk3kGhShNz8eLrKt2nYg78SKIiGESSRgupQaqUS/BvWd4nMTZN/XlbtZ8uZW/Dul
         vI9cE6056Ks9KFcyKAANSUyg1GfhdcZxWem6kNeobbKTLCJBYmVf09q5+Md8UCUk4ONZ
         lrR3s5V+UyrefUEg5T2W9TZQIs0vi7XNMF4OnLva1Agovax1BhHwGCJoevHxp0kDQ1qD
         8G5wAx3odDLIFuQGXiSJutOyOvWJ6dsVdSPnjXQyuHzYwa9GDQlghUkZ3oM+6oE6Edeu
         co/w==
X-Forwarded-Encrypted: i=1; AJvYcCX6Nj1Ty+WYgxwyzjzx8vQLNC+r6Axr/qvohH5eW56vtk2cSogYyWh7PYU8QZ/hD0xPk9cukRXfqDmpSVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyov3Pb4wtfkA1iq4wzxEMF7xbnfpAFz42tSl5sL6Rslqe7ljOC
	9/SK64p5Koh0IWaAY4x40rbw4YN89IOEuuJKM0j20bQieQGiK2qk
X-Google-Smtp-Source: AGHT+IG2tBOEv1SQ+V34aw/3CB9NObTGsM/TPaYr68DvAKudhuXE3dzD2HjurZOP4mEoNNYPZUQJwQ==
X-Received: by 2002:a05:6a20:12d2:b0:1db:e425:c8a2 with SMTP id adf61e73a8af0-1dbe4263443mr12310020637.19.1730887109882;
        Wed, 06 Nov 2024 01:58:29 -0800 (PST)
Received: from tom-QiTianM540-A739.. ([106.39.42.118])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c3db8sm11229287b3a.131.2024.11.06.01.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:58:29 -0800 (PST)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: dtwlin@gmail.com,
	johan@kernel.org,
	elder@kernel.org,
	gregkh@linuxfoundation.org
Cc: greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>
Subject: [PATCH v2] greybus/uart: Fix atomicity violation in get_serial_info()
Date: Wed,  6 Nov 2024 17:58:19 +0800
Message-Id: <20241106095819.15194-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our static checker found a bug where set_serial_info() uses a mutex, but 
get_serial_info() does not. Fortunately, the impact of this is relatively 
minor. It doesn't cause a crash or any other serious issues. However, if a 
race condition occurs between set_serial_info() and get_serial_info(), 
there is a chance that the data returned by get_serial_info() will be 
meaningless.

Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
Fixes: 0aad5ad563c8 ("greybus/uart: switch to ->[sg]et_serial()")
---
V2:
Modified the patch description to make it more concise and easier to understand.
Changed the fix code to ensure the logic is correct.
Thanks to Johan Hovold and Dan Carpenter for helpful suggestion.
---
 drivers/staging/greybus/uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index cdf4ebb93b10..8eab94cb06fa 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -596,11 +596,13 @@ static int get_serial_info(struct tty_struct *tty,
 	struct gb_tty *gb_tty = tty->driver_data;
 
 	ss->line = gb_tty->minor;
+	mutex_lock(&gb_tty->port.mutex);
 	ss->close_delay = jiffies_to_msecs(gb_tty->port.close_delay) / 10;
 	ss->closing_wait =
 		gb_tty->port.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
 		ASYNC_CLOSING_WAIT_NONE :
 		jiffies_to_msecs(gb_tty->port.closing_wait) / 10;
+	mutex_unlock(&gb_tty->port.mutex);
 
 	return 0;
 }
-- 
2.34.1


