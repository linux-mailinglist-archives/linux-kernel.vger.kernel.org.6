Return-Path: <linux-kernel+bounces-413931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DB49D20AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B455B23028
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA051AC43E;
	Tue, 19 Nov 2024 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HfPqts38"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6611A705C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732000888; cv=none; b=A/RXouLWyTd6IlJhZtMaYEPcG0PlqbDdAZsGM1ar8zSnFvOvH7rABpQCn+aZwI9V9pB0yFY0sJtKWfPcsKNTbWt5+7gWKfD6038ri3rzsHYVmgqoxr6yAVJjYnKdpDixZ4MIHNDfrya/rj2Nq1b8Bd+G8rr2hC/bDMKshFTS00E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732000888; c=relaxed/simple;
	bh=mrGv2qtF8ssBe0q/fGE8zoRY695b00OVbv4wzk1hbVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0hY4mZaXu7WKmiMlq3et/8RxqdnlmHrHI6Uve8rigC6qW2izxytANf60RvaYnd9OCnFjgwm+FrNhraol1WtwzzimDnG4Mo3+WWqBDm4T1ndpvJEpCU/OA+nueihOhKMfD/NsQqqyyr4/dhTVV+ysAKpMZ5azH6L5XYVXXnsWGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HfPqts38; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7f8b37edeb7so3838127a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 23:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732000887; x=1732605687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztq1HCHe5F7VoTpmdbLU74q1rBToVI1HubuTv8LWLRg=;
        b=HfPqts38K9E5NqA8CX8SSM2oO3rxQ8g9AYIUm14Nk7Hydxy+8oxFfGyl4/lv+aufEI
         5Byde4tHTytfc8HCvPrk0Xlao9Vyyx0F9Zg+XHUT/3rxho1j0KxNaodSeefBcWJv10OG
         FLzp/KoKhrKzuvoopQgdNnaXwoN0hbaojg3iA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732000887; x=1732605687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztq1HCHe5F7VoTpmdbLU74q1rBToVI1HubuTv8LWLRg=;
        b=pLni+qzUaRpVOSZr90YvQIKHkRy1EbcrfvvASQLDWx8CIevHlo8JY+ZvG7OeEaNKWU
         Z7VtV/B3R5uGnTwTQDy5MQwacMd1/pPYtLGVhBg7k6IeT1RIW99Ipoe4adBwWQeEoBj9
         WMrEHQzdtzLt9MumfQp9Q/2TAXaHF0KfAYKTcxAGTTYs+zFhevjeagVUuoXqlletkInl
         i4JS3GuAtuHK5F09q2J3KW8wdSaVvixivxeXXydi95sJ8CeMAOjoUq0Uev+oO5FFtIYc
         dXHPDNWLnBr9DX5qhr/D/tc/w6Pl87bwdYDLIE55DMiIkGjYmp/T2qc67F6A/KOZRbwI
         P2Ig==
X-Gm-Message-State: AOJu0Yz+Pqf/MAQ3A7OUFD/Q4wEFu5rwIXFFzA7968gAZZh79l3Vssga
	BGUhXA1+Sh4nO9UUoqE/wORChwRLwwT/MC/J9z1OoL9IJ3RjLq7UfAAuC/4AGA==
X-Google-Smtp-Source: AGHT+IEgP0EdrJqNTLy/8qzn8Xs6Cj/FSp6/avrRE0kupevO3+it/G9+ostYbtoLlvUYVSzCeYQBDQ==
X-Received: by 2002:a05:6a21:32a6:b0:1d9:78c:dcf2 with SMTP id adf61e73a8af0-1dc90c1b16bmr23377806637.43.1732000886863;
        Mon, 18 Nov 2024 23:21:26 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5534:f54c:1465:9438])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ea777193b5sm3038784a91.45.2024.11.18.23.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 23:21:26 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv1 7/8] zsmalloc: move ZS_HANDLE_SIZE to zsmalloc header
Date: Tue, 19 Nov 2024 16:20:45 +0900
Message-ID: <20241119072057.3440039-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
In-Reply-To: <20241119072057.3440039-1-senozhatsky@chromium.org>
References: <20241119072057.3440039-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It will be used in object's split size calculations.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/zsmalloc.h | 2 ++
 mm/zsmalloc.c            | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index a48cd0ffe57d..c17803da7f18 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -16,6 +16,8 @@
 
 #include <linux/types.h>
 
+#define ZS_HANDLE_SIZE (sizeof(unsigned long))
+
 /*
  * zsmalloc mapping modes
  *
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 64b66a4d3e6e..466d5f49eb91 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -78,8 +78,6 @@
  */
 #define ZS_ALIGN		8
 
-#define ZS_HANDLE_SIZE (sizeof(unsigned long))
-
 /*
  * Object location (<PFN>, <obj_idx>) is encoded as
  * a single (unsigned long) handle value.
-- 
2.47.0.371.ga323438b13-goog


