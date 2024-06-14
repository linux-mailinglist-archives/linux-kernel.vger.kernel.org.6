Return-Path: <linux-kernel+bounces-215531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 019FB909432
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 00:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 918F8B22B2E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 22:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680B1186E25;
	Fri, 14 Jun 2024 22:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2n+gqY4"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689781836DE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 22:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718404985; cv=none; b=KVG/w0aJbD8DG6E4dJKOJrqUaM4OJtO15jQuPFfhFF8a3XniYlDZPzldFil98/1MCypFLRgU1UCSe1qLSoPmJffoZ0XFWpoRMh7BVYAPTGA5dF9tGmmy34MjAmnQZu0K7Y6LN5TZ9Aa6x2SkCAacfB15tFsRLIEu53Pz8e1obNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718404985; c=relaxed/simple;
	bh=wWdFBUq0TBR/kJG1+KtHv5R1dV46yPZU/UdOMCSFTF8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NjNQty3Jnwvlv50Yp0w8OqcV6E7xZe3pSQSlxN8X56L/kxWClQ44EfT/MVzkG6H0WqR+GDsQfzMZoUgTkxrbg1u05Zi8kXInpIVuIxhRIPoc7029phhcr31XO6ik2sWW28sIRSnmOORWgyg887rUwLoPm87Ydpz3WR8/8UXX6hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2n+gqY4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-701b0b0be38so2477464b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718404984; x=1719009784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8GcWMEEnmsQAzRTqgdUci961+09Yzh7hz6iGBCWj82U=;
        b=R2n+gqY4RPJn6a5ktlWM4KcyiSkmS/juk+liwgEfGqEBfymfQax08SjkHwWLvUfyF7
         Jetyl09wKyNfn6UvJtrflmXnQDruJ6TXa5OBR+OoSAtjMCUij2YoTQW4xQRv/qhp6BrV
         T6Lt3zPqf2bUzSxqduLkfn8azdTU8UsttKGdESCCutc0yKTv9d60RIVt/6tisDg/Dnai
         FIas84XDXbkz1vBBaENDbyEYpeQaRiYYM57+EQbpGCj4hGD0gzrNyTOCAX/9415r0h9i
         PYuZZq/6kB4iD1k4D5NdfbXt+VQhIGe10kLAX/4Mkx6oTxgYRunONz/1lV+gnVKZcnNp
         cujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718404984; x=1719009784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8GcWMEEnmsQAzRTqgdUci961+09Yzh7hz6iGBCWj82U=;
        b=v6/9zhqa6PznhDzQWgng83BxB2cbk4G/NeLe0TSGtEXMbCkL0nxFmnZykR1dFoFLBm
         hTY8sZHef0hW0OuGrqY7HxQGfhwYQ1nmMKeomQGP0d6FhwvrRIxIEl6ap7lE50cfoRI8
         StaV9Uu9B3CTuPRyOlFXz6tO4FJublh0yzrLDxsLgohH1q+lbv7P09ReSwc+rFRs1B0N
         2tpovMFbKSYRi8j5ImEyUiYI08dK1z633b8Uc4AXxS/nO7NE9uwKNimpF7QfgaesksRs
         NyNTY9Wpb+BNyW4mjZkT8tBW2yzwBQaEdBNWL2R0Bczx2czt4ldgNm/hsCAPwwuHOp2T
         Md4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0YlfPsv7YoSyfvKhBxhwkPFKI/2Es6th1zt67YUuwbvlfn9gjDFLD44r2JlMW5bkAGlzd3KiZkiJwpYeBslfxLf5d4Pp9jIL18y0V
X-Gm-Message-State: AOJu0YzVJ2rb8LkjRFiDkmIcfOUDX86rcVO/1nkeOY8Bw1aF7jAW3lPn
	XjPcEI9T4AcUz03kFPHBktTkkYdhj0zPkMm+Vrrl7FifAvis9JS8
X-Google-Smtp-Source: AGHT+IFM0F0/bOk0DJfja+1mE+6TE/gRUmvfKw4aRn9mm4gX2wZL/rWQeKh15CN9keQfbWwTGZAaUQ==
X-Received: by 2002:a05:6a20:6a0e:b0:1b8:9d79:7839 with SMTP id adf61e73a8af0-1bae7effc98mr5065056637.29.1718404983654;
        Fri, 14 Jun 2024 15:43:03 -0700 (PDT)
Received: from dev0.. ([49.43.162.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a75f0053sm6910600a91.13.2024.06.14.15.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 15:43:03 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	jain.abhinav177@gmail.com
Subject: [PATCH] staging: rtl8723bs: Align address to 4-byte boundary
Date: Fri, 14 Jun 2024 22:42:56 +0000
Message-Id: <20240614224256.43131-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add address alignment in sdio_local_read, _sdio_local_read &
sdio_local_write functions as per the TODO.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index 107f427ee4aa..caee2d2043b3 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -478,9 +478,6 @@ void sdio_set_intf_ops(struct adapter *adapter, struct _io_ops *ops)
 	ops->_write_port = &sdio_write_port;
 }
 
-/*
- * Todo: align address to 4 bytes.
- */
 static s32 _sdio_local_read(
 	struct adapter *adapter,
 	u32 addr,
@@ -494,6 +491,7 @@ static s32 _sdio_local_read(
 	u8 *tmpbuf;
 	u32 n;
 
+	addr = addr & ~3;
 	intfhdl = &adapter->iopriv.intf;
 
 	hal_sdio_get_cmd_addr_8723b(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);
@@ -516,9 +514,6 @@ static s32 _sdio_local_read(
 	return err;
 }
 
-/*
- * Todo: align address to 4 bytes.
- */
 s32 sdio_local_read(
 	struct adapter *adapter,
 	u32 addr,
@@ -532,6 +527,7 @@ s32 sdio_local_read(
 	u8 *tmpbuf;
 	u32 n;
 
+	addr = addr & ~3;
 	intfhdl = &adapter->iopriv.intf;
 
 	hal_sdio_get_cmd_addr_8723b(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);
@@ -557,9 +553,6 @@ s32 sdio_local_read(
 	return err;
 }
 
-/*
- * Todo: align address to 4 bytes.
- */
 s32 sdio_local_write(
 	struct adapter *adapter,
 	u32 addr,
@@ -572,6 +565,7 @@ s32 sdio_local_write(
 	s32 err;
 	u8 *tmpbuf;
 
+	addr = addr & ~3;
 	intfhdl = &adapter->iopriv.intf;
 
 	hal_sdio_get_cmd_addr_8723b(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);
-- 
2.34.1


