Return-Path: <linux-kernel+bounces-412748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DE59D0E97
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906E21F22511
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CB0192D95;
	Mon, 18 Nov 2024 10:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n/N+bMQC"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0547198E9E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925893; cv=none; b=beXInYwinQQx6+J1ZwqY2RigokoKxZVAo1hdOYKZFe8fkFHQUzJ/GwZjEJ1F3D2TSRiBA6HC/qqOhGjJ+GTtS7fUHLGY3upD2FIAHIGMCEQAonC3UWFiqC0B43nHk5WmOJukYNnFzx7JKGyiwde+71fS9I1ubFdGRqENbjuwdnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925893; c=relaxed/simple;
	bh=xVzGpsMG9LnU1tZySVmIfVy5ZCYPebEJXiildOSUkyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8cJMoUuEx5zlWc+Tv0V3na385tVZa0brvgSX1sdkN2JwB0acc802pkncHvZwYIy5U2KlWuI2Y0rOdhIk0tu2L1Kwh/SKYDfkqNQfPw6f5/3ikRiB7coGQvsl3WFDOthBJ34bMKR4/O74xqfvC3Sjdx3YA0YPSKiLLaY0aYzOtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n/N+bMQC; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea8de14848so1447721a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731925890; x=1732530690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzBs8nZr7t4qyXsSXVR6Mvnn4ykaCUyDwpEIlMiVaNs=;
        b=n/N+bMQCYZtkta5/l9hPnLQZ87TgfOHKbhujL2DPkwyvh0gz6DxTiDlD/KUoK7TQny
         111mWDiHJjWfobdv2vvsH7fQkZHgqL3YvuB0zg2EkkJWxSILOR/hG6Mo+jrReAcoPY7/
         aPY6VClOcuOWUVUahFZvCtk4Ro02H6PCqirJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731925890; x=1732530690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzBs8nZr7t4qyXsSXVR6Mvnn4ykaCUyDwpEIlMiVaNs=;
        b=C63MRCcmwNGYMgzWP4FRxwbhsozzF6l+l/fg+zQQUGWzo98KDLdz7/nqbO7V0RsgK8
         yy5D40pzGwrVYrU2y2vnaCS/5UvwT1/3S5umZXW634Uvj8sozdvedcPId45gg+RA8o3a
         PWcxxS9CdDR8sKxJZcM/m86adHsGtZu4F/f3ECDQEs8w1klber3jBwnP8PbmNmpx9Fvi
         MpT0J6Sfa8UwpXhOLRCrE9IJsVR9tUQEYEBKborU+KYabh4R0c7Mz0yeAFM+c79Ip347
         d8k7G1obijbIAD/As0nS13so8PIU3T/GQR1UMqsRFALHbgPooEeLSmP0kkApl9l2sYv0
         njEw==
X-Gm-Message-State: AOJu0YwNKsvzpsOEo/L80XYC7uH5v/xcGiDh8GxGaBIGkixzwbC9+Vmm
	pIb+JidbDTQIpDAiszbdOyAsvX8PwS1L8PKWFtXRbKbN4tfzwXenvzWn+1ArW0mKq4sujH+7+7o
	=
X-Google-Smtp-Source: AGHT+IFGhf9MPrSPXzUeQ74KTVU1NoLTG/jtQEg9tsUyi5MjDWNEBL8DjEi9nzYhqML2jb9KUmH1bQ==
X-Received: by 2002:a05:6a20:258f:b0:1db:d998:513e with SMTP id adf61e73a8af0-1dc90b55109mr19012107637.22.1731925890544;
        Mon, 18 Nov 2024 02:31:30 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:8826:78b8:a8fe:1066])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7f8c1afa67bsm5703029a12.0.2024.11.18.02.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 02:31:30 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCH 7/8] zsmalloc: move ZS_HANDLE_SIZE to zmslloc header
Date: Mon, 18 Nov 2024 19:30:38 +0900
Message-ID: <20241118103054.3191944-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241118103054.3191944-1-senozhatsky@chromium.org>
References: <20241118103054.3191944-1-senozhatsky@chromium.org>
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
2.47.0.338.g60cca15819-goog


