Return-Path: <linux-kernel+bounces-423771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1014B9DAC73
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AAD1167A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D5120125E;
	Wed, 27 Nov 2024 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPpN2yNl"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03978201260
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728622; cv=none; b=A3iaL0Tz1uq5mfTIyvWRG0AhZtxZoAjxmDQBdO4Wkj0YKiJWU7D0epnOv87+d+DnQmr9DCAFr1yeZuHtnOU+svuUd32BAf8pKuODJXk5xYUfV6H8WfoOTisTXP/VfTXzrtEBwX2pQaDKNeHyX0bpe3D+7yB9tiCDzjZcUVpbwc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728622; c=relaxed/simple;
	bh=iNMglRh9O0IJ5qhJoU/e7rnepKok46MiTR21I0SetwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ub8Xy6qraNl8coNB0zCjZS4URXbtOTk6m2ID2xxuou+6JHTGanIbzJWU+gh1WKHZ+8gZOZbrYxdZ30ARyPjPDjoapP4+zgc3PJKa0HVtK7+x0PAfWU9v7/FQtysJeWPYIdq7O5fxn9WrgCy++KNfH0ehb400WIXox7XWZX1jxrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPpN2yNl; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7f8b37edeb7so6122612a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 09:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732728620; x=1733333420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdAeGv9r70I9AKk6TiTHcOSKMA9eOfxpzpLIhOQV/Tg=;
        b=kPpN2yNlJ61Osc9Ut9V7R08/0KYcS8HT7ldUvI5EmqTdTO/Yk05ay0X6aZSOh/03/L
         RrE7IzLcYCIQcfHavlVnF25bgInL0nrILzI9J6xVO6LZbfg56JG9awhFUCZ+QcTPgLve
         vyZiM4sx2O+GLhj0YvidNRSbLwzXBOJ/1AEcdJb8cPrsySenetD35ZuqWirofl3seDmF
         XOWR10Bh4IiCWCGTXeyqfeBNhiqtX2TxoZ11Y022cnssVsiGuHJP1UX6lExEXbSGpdh4
         UQxzFIC3IKErPCxqhbHpBM1f/SxCyvub0xzPTPrv3fq4+3s7+Z2ikWbdi1wQ8pHWEbzE
         p+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732728620; x=1733333420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdAeGv9r70I9AKk6TiTHcOSKMA9eOfxpzpLIhOQV/Tg=;
        b=A4UNbqzUpoWjn0+kGuWUIJ0INjaGn1fw5+i7u0GZu7fil2kcL3ix//XypsPe28fnqT
         UrNxOe4f5XVAujFiRuhliIJUcTRgZEdueVH/f/y6Y3p2UBMzja7DOd9TLoroZRWDhliU
         u5vhTseTwoCxvwIvUvh7aHAn7oRi4ZgdFmnllLC93QJuy06hmKGASgT5JSsZDyC3KNLT
         Yvj9BMeUI5w2e5xEWQ6xMYmoTCkpxEtqyLnG6H4XofJPR2DKmY9wRK1f81vQit8HHv2X
         7OOVkJ0s6zdheD5Zm0wvR39Tphk2PqeyLBuH/Xw4xdmKBYHTfmrRKBdYhbdkpEwslCbZ
         K0sA==
X-Forwarded-Encrypted: i=1; AJvYcCVz0tyrwwI5Uo03W/pX3sAhze2944eDgsapDcPxRRihJyplAAupWqmEpo3as74zL1zNIr8xwYAVMs9zod4=@vger.kernel.org
X-Gm-Message-State: AOJu0YypWDtsQq2xOwiBmXGd8YMA/afHw+olVeSCA0hT3/UD9KfTle8T
	fp8e25F5qqCgnxIM10zSHzTvaWrGWFZJT56fbFZL6J6uM8G3TCqf
X-Gm-Gg: ASbGncvudseCwwYtb2odRYz5Dmw8djZf7V1RsYmhwF1Ijv2PA21QcMyUzrG1o0sr62C
	lAPXbPubkkuKawgdprudb/JhQt8yJwuidyT+al2prwi4qfcTffbphmqdo5NiuYEZwrbb7BGUafH
	OposEpZrG7c8YfMdUIO49JMY8uAzDiRNzFrKJ5K/4p0bLcb2q4qs3JQHqIlcIMefU14L2wPeVV/
	kLfV9+ElNmJcvBijYd/8t5TfPiO43A/TAJyjj8jQae7RNSiY2QBR+4MDDRrWd4CG36zSXgs07sP
	mvG4CABqs13Q9DQ+pbXsv22hi484
X-Google-Smtp-Source: AGHT+IFBuiAY3Y5+T9rXhE/jtMcxIwZT/PZK882Xa9jD4xmTITkIiWYoAEUJevk5le6u0m/B/dND3Q==
X-Received: by 2002:a05:6a20:6a09:b0:1e0:cb94:d3b4 with SMTP id adf61e73a8af0-1e0e0beb9b1mr7629311637.45.1732728620072;
        Wed, 27 Nov 2024 09:30:20 -0800 (PST)
Received: from localhost.localdomain (1-171-29-17.dynamic-ip.hinet.net. [1.171.29.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc1e3fdbsm9359582a12.30.2024.11.27.09.30.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 Nov 2024 09:30:19 -0800 (PST)
From: Andy Chiu <andybnac@gmail.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bjorn@rivosinc.com,
	puranjay12@gmail.com,
	alexghiti@rivosinc.com,
	yongxuan.wang@sifive.com,
	greentime.hu@sifive.com,
	nick.hu@sifive.com,
	nylon.chen@sifive.com,
	tommy.wu@sifive.com,
	eric.lin@sifive.com,
	viccent.chen@sifive.com,
	zong.li@sifive.com,
	samuel.holland@sifive.com
Subject: [PATCH v3 7/7] riscv: ftrace: support PREEMPT
Date: Thu, 28 Nov 2024 01:29:08 +0800
Message-Id: <20241127172908.17149-8-andybnac@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241127172908.17149-1-andybnac@gmail.com>
References: <20241127172908.17149-1-andybnac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Chiu <andy.chiu@sifive.com>

Now, we can safely enable dynamic ftrace with kernel preemption.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 75a5ebde4427..554e4e363c54 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -148,7 +148,7 @@ config RISCV
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
-	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
+	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
 	select HAVE_EBPF_JIT if MMU
 	select HAVE_GUP_FAST if MMU
 	select HAVE_FUNCTION_ARG_ACCESS_API
-- 
2.39.3 (Apple Git-145)


