Return-Path: <linux-kernel+bounces-432984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBA29E5295
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1381167564
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83391DC1AB;
	Thu,  5 Dec 2024 10:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HvWVmKQU"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9EF204081
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395126; cv=none; b=mBszGmbiptRwQnI8YDnq5Y4Tb4qlD2jmwn6BJV11mPlaXlKGyI38M0VbvRWQ7hUmXH/0VEkVMbF23x2EqBiy5nuPKB+SGwg4ngylGE/JNTsa+p7HHbfvMxBEbh3mEbx/5BQfhU/5NHD4wsvxFXs4Wq5RY+iAN3waRN6DgS7ltbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395126; c=relaxed/simple;
	bh=xOye6TxZfYFU7+9BNB2Cblh+Egvr/wPlyq7m0ZZN5eI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K7hZEZJQaXDKfxVQ1PIvat05lqYxTkvG3/7jcvzjdqzH9Lq8Le49AQLpszc8rQRSHpwwArJKQjuqL8CEPCUFOX9bhDziobrYEGtkstP+lr4BnzqqKptmTR9GwD+m7UcJLN+CwBk6hV1dIo5xr/Ad72B91gUpx2QtAGiBj1T0CKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HvWVmKQU; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7fcf8406d8bso1533801a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733395124; x=1733999924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAxAI+FpEZPqeOtAYXtXd/fFddvtrgZvKhcRJUP9sTk=;
        b=HvWVmKQUJpYWhYTVansiNsXRmrZn4PiaXHWREuvBBNo3UY2XvRTNbS7OW3/jCdUGdS
         I4P4QG81O51gLnVVmivRc1P3w6YW5vZ6X92VY+12ZXyMc6r1xmqVFF9aql9sGmRhptC2
         z17DOcRNNex5KqOR7xohjNqc3HVBiVdY+A/y6FGxdbClEkRkh94/qYNiw9qa+t+7Wyzy
         sOFMFlOhp8qcHbsiYStgNNCMN+X1V+LzAfFlFjYQLjkUrwmnP3K+CipO54+/t+U6iFy2
         zflZXKVH7U09faBHDQCxXcjXVlnYMcVjUSO5DLsHSEYGFp4te7Pp+I9MGqR6q/KdbjFT
         xLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395124; x=1733999924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAxAI+FpEZPqeOtAYXtXd/fFddvtrgZvKhcRJUP9sTk=;
        b=byWyaVFDm8OYo1jdE3DIcjnt/cR6Sqo0yZuFc0+jdSGUbUkhod6TAuXnLOJ3f792Sg
         55+MRHXZtMvc/OTh37GYb/E6XrGxEMGTXKhIVCmj2p1oe9omtbAwwD9kVYFLLdj0dbD5
         cIEf5KJ3r6SYVtYbxMGWHiInaYSz5SJpsbEhHScOh9W5Nc50ZMi5YLlZ696n+CJw1yfN
         yn0Dorp+yKSDAtZHfLj2zJCUvzizd3IRsZJNlAz/Mqt3OcWI2MNE48UPYBWKAS0hQA1S
         sRcUQKGkOZT6MgNqkMh4mUb+OFvl8BbxQ17cFwWautAhKqFopzxqQWQ2evvxUKKE5il/
         gYQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTqnzPP1JHNHDLX1OzUNhK1LRPYY/GCn/xJ25nSAzGqZKKMFdqUDSWHMCRI5uDaulgRoieuumzU9PQ7dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw67N/ehlT488G+uEPqWNXHYsPuCIvuM7QrgnenzMQCvsTFNz3I
	cUlR99XlIBxVtEG/TjfvJpsRfAt4gV5OUsr97KY0GCXqsu5G8Z8ckQDbf6NgJXU=
X-Gm-Gg: ASbGnctBGbJ1H/2FHJTtSP2VX1LiWm6xJ0IQwxnMV+gaB/cm5TN28ZG94YvZUyVSkjL
	wxPr5cu4qlmb8eYn/MTGnv0ikISADl0GwUkyh2XDYMbOxKwBuUmsGW9VC3COhMRDB3xABV7xGd7
	8Q1ikpTPdFiQtohdTzq7u51THzmM2w9UlYnptcy830qVt67ZjJnkSvjznrdyK9QLgPZluds8hXD
	Xle5+fUa7/P84SbxNvrdW5/5NFcs/7ToZ9ZNxyP1O0QAUm6uB7NQZ/XogHLq68WoPsk8oMXkuZc
	yFbTTO/jBUnvaS5dav0QZ4Zu7qKy0LLV
X-Google-Smtp-Source: AGHT+IE8309GuNeyZxITDQ1e0WzOIa0uJDO0sUbGSJz89pLUWjkP1vS9Smp96TCW7bxn3tkgM30nOA==
X-Received: by 2002:a05:6a20:a128:b0:1e0:ea70:7494 with SMTP id adf61e73a8af0-1e17d38c18dmr4437406637.9.1733395123986;
        Thu, 05 Dec 2024 02:38:43 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156f048csm886826a12.39.2024.12.05.02.38.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 02:38:43 -0800 (PST)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	anup@brainfault.org,
	atishp@atishpatra.org
Cc: xieyongji@bytedance.com,
	lihangjing@bytedance.com,
	punit.agrawal@bytedance.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH v2 16/21] riscv: mm: Adjust FIX_FDT_SIZE for variable PMD_SIZE
Date: Thu,  5 Dec 2024 18:37:24 +0800
Message-Id: <20241205103729.14798-17-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241205103729.14798-1-luxu.kernel@bytedance.com>
References: <20241205103729.14798-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 07d557bc8b39..5b2ca92ad833 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -108,10 +108,10 @@
 #define PCI_IO_END       VMEMMAP_START
 #define PCI_IO_START     (PCI_IO_END - PCI_IO_SIZE)
 
-#define FIXADDR_TOP      PCI_IO_START
+#define FIXADDR_TOP	 (PCI_IO_START & PMD_MASK)
 #ifdef CONFIG_64BIT
 #define MAX_FDT_SIZE	 PMD_SIZE
-#define FIX_FDT_SIZE	 (MAX_FDT_SIZE + SZ_2M)
+#define FIX_FDT_SIZE	 (MAX_FDT_SIZE + PMD_SIZE)
 #define FIXADDR_SIZE     (PMD_SIZE + FIX_FDT_SIZE)
 #else
 #define MAX_FDT_SIZE	 PGDIR_SIZE
-- 
2.20.1


