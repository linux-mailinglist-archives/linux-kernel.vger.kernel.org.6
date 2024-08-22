Return-Path: <linux-kernel+bounces-296666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE98E95AD73
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3161F22951
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239151369B6;
	Thu, 22 Aug 2024 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9daXHKy"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243A4137C2A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308082; cv=none; b=KZhA4Kfaid4sksoTIJLJ/GPeoIzVGsxw9XE+uvidGbAX/7hQRQFD+7cVpFEtahrt+yQzi+zh/JVfIIGU422WQv2G4wm0tX4aVGAjPvqEdvz/eeKBIhFNILKYGs+k+rXWsxAtLe5ATpmt2bwQoc5ZQkreZTc4HQsSjnJvTuwm5rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308082; c=relaxed/simple;
	bh=LJ4dyjvNwZaiwd/8aLWsHy+giYvGugJKxWY9tm5RjOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BOi/rEejTY86MnE1Xz7yWf/pwTp9XzyZ77Ab0xM05erujeo8u6E7PR2j8Ys3ktmfcjD0Llp27O6pQHqUbiDXD3+b8zYMc/bY+1CLKptG9AQAVRq9Z5YnTMmrPNhJ1RSU/a2oOVq+Hrx4dRxuyd2YxwbUeBFn3V13Csp9yK161Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9daXHKy; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d3dacaccfaso317890a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724308080; x=1724912880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tcegQ5LLDtxve0FpkI1VDAxYi55e9yjJyF3N9IONl9U=;
        b=c9daXHKyJ5hjZZbuFozpBw8pkqTpKECJdySgFDu55OKN/qb0Jyka22AYFhmfaq46+U
         W5q6GjxuDcq+SOzu0dF59vcjP1dZ3LpCQnkI3sV3ZUU2UAX9G/ssLSU6gEkWskUaIPTB
         t8Rh8XjEN78h6WrrhBzSoEAXbS5FJbkxITOyjp1dE5LaVKniFCnZpZfi3wKdA3YwdvCe
         U2X5NBUy3fmLIRkw7541o/ZCzMbkU66oDMJaQXTXADSyE8TFWJxY1PDr+m/kd6TCd3Ub
         34RjiPgKzoCObXv33ki6+A0dNejcrqlO5zKE0/00AC7f4hJhUr1S14q9wQkz4X+f84go
         4Big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724308080; x=1724912880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcegQ5LLDtxve0FpkI1VDAxYi55e9yjJyF3N9IONl9U=;
        b=suA7ALWc7pWRGjgQqtsDkGaSdzhTOTAKG5OPjqJQNldyaeHIl8BbwRLpmf7kbhO6ge
         P9IATuSdj65vraw+hbQivILSm1wLvTy1XFWN6Y/9Fg97OeeXF21J/ijAyLxhliKXBjjV
         vtD45UNHIC2iqFFSz98NPkz3bxfh6mHSNegnzTna2+8/COoSNjaIOz0OqVRXugYPltdA
         1mf7LCil+UgbMJSHd3ZqvbZUiur0Blv356MUjNB1iBCUXJzYUhy0DDU5LdPGC9Nfs0Qz
         tQR8pBAHzsMRnUH0xx4yQjbkDI8Tb5tQEDZJ1DXCNiaeYpGPHZq5/174yMTFoDeQ105g
         NVSA==
X-Forwarded-Encrypted: i=1; AJvYcCWpQMqJlJjXlfBiZ5IibmzWruLHzfTTd7CMTg2M3RQV+6e20GeBZnEcQOVsws86wKI1H8xy0I4eRwoP6fE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0aG2SuZalNTeIKK2X4Sgu49X2td4p21bIg5dnjGri/dCycFco
	kVWr7z3jKC98p3yrkRfNjLZkwCSk/1ZB2UVYvpRRyms8dCoPGgLo
X-Google-Smtp-Source: AGHT+IHCI5vCN/67al2Tnidlyb6v/FI5ftalotWYxeMsIJ9e48XVWNG8KMJ19aJgFvP2G+Hzr3o9CQ==
X-Received: by 2002:a17:90a:8914:b0:2c9:e0d3:1100 with SMTP id 98e67ed59e1d1-2d616b284edmr913222a91.19.1724308080228;
        Wed, 21 Aug 2024 23:28:00 -0700 (PDT)
Received: from mi.mioffice.cn ([2408:8607:1b00:8:8eec:4bff:fe94:a95d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebbb0598sm3114486a91.36.2024.08.21.23.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 23:27:59 -0700 (PDT)
From: liujinbao1 <jinbaoliu365@gmail.com>
To: xiang@kernel.org
Cc: chao@kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	liujinbao1 <liujinbao1@xiaomi.com>
Subject: [PATCH] Prevent entering an infinite loop when i is 0
Date: Thu, 22 Aug 2024 14:27:49 +0800
Message-Id: <20240822062749.4012080-1-jinbaoliu365@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: liujinbao1 <liujinbao1@xiaomi.com>

When i=0 and err is not equal to 0,
the while(-1) loop will enter into an
infinite loop. This patch avoids this issue.
---
 fs/erofs/decompressor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index c2253b6a5416..1b2b8cc7911c 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -539,6 +539,8 @@ int __init z_erofs_init_decompressor(void)
 	for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
 		err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
 		if (err) {
+			if (!i)
+				return err;
 			while (--i)
 				if (z_erofs_decomp[i])
 					z_erofs_decomp[i]->exit();
-- 
2.25.1


