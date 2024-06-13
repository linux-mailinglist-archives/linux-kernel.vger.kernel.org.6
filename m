Return-Path: <linux-kernel+bounces-212711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72627906532
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0D7289FB2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8C013CAB8;
	Thu, 13 Jun 2024 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="etP/LdQK"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CD213C9D5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263969; cv=none; b=riBfeXTLvnvABACODMUqwKSgSH9plsff6x+6jMBIcPj7QYXYuyTx7hnV13IwVBfKQVQ0Zr7Ua3WnJqpTfBokq+6g71SgC7103eWAQ9euuyAqVtPozGl6cq/zuejnmcI54qwcc6bFHxH55N0jkUS1/rfmtNX9833QreI3PSGGaB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263969; c=relaxed/simple;
	bh=vgghTaDxluToi5kVZZlG6AV2uIZ41UbFwSgx4K8n064=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DYflUeXAooeKX4ixWzLOYA4DkJUhB9rtyPjSUH+2yUBNfm+YX7cNX4Ss6ZZENrFA1OJaVadzu8BGJqVP4FT6ohCsvpw0aMGeHY+i5SEnOO5Odi1bcWgaJngwVdkKjEqWY7cBpQytTxAA1H+xrIGOeH+I6mVvWdoQhPXRhXuXC3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=etP/LdQK; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-705959a2dfbso497663b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718263967; x=1718868767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQsuZ21+9cGptdlB0BPgeEv8WU9oI426BLaNkf2S+w0=;
        b=etP/LdQKyC3qb2zXfttY13aPyp4lbQJSHThwPFHEZQmKBlrzDRfA1y6lR4uMZYATe6
         V+OCUa/8NMQONuM38CD388H5XUH/WZa6pTNxoYx2wKr9j3+RQkjchGBgInGwMxnGtzmd
         cbbUU1FD8S5KoyaGrqyKIMWY/4i5vQr5fUM3mn1JduSSaptEMQqIj4AfFJhxWPzry+MV
         huaa4WT5nzwFIDPP4/06hjQrXtThG/37yjeUIBNdr7Lu/rJxC8ucf88tLFTeRj/VH+/O
         m0jR20ArNZH4xunC6yqvVdkLzewbY37UM3hMzfgLirBtsKzsHIrPk01ozwGKRywAwOo1
         l4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718263967; x=1718868767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQsuZ21+9cGptdlB0BPgeEv8WU9oI426BLaNkf2S+w0=;
        b=RcjCun++5YxKGHblOS9FBjfR7xEuYYjq2F/voy+PlN3yOjh00YNxASCeacHKNDp6Lp
         ZbKQxID1jd5dqQizHa9iuewcCv/FTCru1Se9oaq4WpG0MTDLeJm9xvGRXVUylVPFRLAE
         ht+47hA1LykKtwsM5o1BOlW+0vRMPgJltwbG6avAUcVnaqBCttDx10bT9ksi60zMz9js
         A5eyUzCezklqbQ7JmrqGi1bIWBKaTW8LOPNKSy9z7gssntYN0TLnuMWZ9LWbaRVvB8jA
         XjggA8gHJuQDWkPYYfxacAcX/DVA/RDIg4y/QhkyjR0dQQH+YFAUfm2XH1NQRsBbiJ4b
         7FGA==
X-Forwarded-Encrypted: i=1; AJvYcCW81atqxBZil8fvF3PCKTxc9o6Gl6Qo0NEA8hXKG0abu6JdV2S5LEL/QFHmM6RPF0HWI3vQyj3xPnzRvfMo2aceG8W2q56Br6aMg39x
X-Gm-Message-State: AOJu0YzpFNf/JSJox8TIr/CT9r9opVyZy9hHf7lV39EcubxUdfjCrZJy
	7SkBaHrL31DxAVYUNw+awj1DWHQFnC1fIkdTArEsLndVb+xSRIxycKMRFI8UHho=
X-Google-Smtp-Source: AGHT+IGkMW8dM0M3dwKshtF1f8Z+mSNjVPk7wRBBSBrIqzVVkpK0qMV/aHa7vJh7XzX910Gr5qBw7Q==
X-Received: by 2002:a62:ab02:0:b0:705:d101:90ff with SMTP id d2e1a72fcca58-705d101919bmr283959b3a.16.1718263967547;
        Thu, 13 Jun 2024 00:32:47 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc78a1a0sm730028b3a.0.2024.06.13.00.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 00:32:47 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Thu, 13 Jun 2024 15:11:07 +0800
Subject: [PATCH 2/8] tracing: do not trace kernel_text_address()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-dev-andyc-dyn-ftrace-v4-v1-2-1a538e12c01e@sifive.com>
References: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
In-Reply-To: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, Zong Li <zong.li@sifive.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Andy Chiu <andy.chiu@sifive.com>
X-Mailer: b4 0.12.4

kernel_text_address() and __kernel_text_address() are called in
arch_stack_walk() of riscv. This results in excess amount of un-related
traces when the kernel is compiled with CONFIG_TRACE_IRQFLAGS. The
situation worsens when function_graph is active, as it calls
local_irq_save/restore in each function's entry/exit. This patch adds
both functions to notrace, so they won't show up on the trace records.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 kernel/extable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/extable.c b/kernel/extable.c
index 71f482581cab..d03fa462fa8b 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -74,7 +74,7 @@ int notrace core_kernel_text(unsigned long addr)
 	return 0;
 }
 
-int __kernel_text_address(unsigned long addr)
+int notrace __kernel_text_address(unsigned long addr)
 {
 	if (kernel_text_address(addr))
 		return 1;
@@ -91,7 +91,7 @@ int __kernel_text_address(unsigned long addr)
 	return 0;
 }
 
-int kernel_text_address(unsigned long addr)
+int notrace kernel_text_address(unsigned long addr)
 {
 	bool no_rcu;
 	int ret = 1;

-- 
2.43.0


