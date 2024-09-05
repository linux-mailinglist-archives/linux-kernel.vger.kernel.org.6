Return-Path: <linux-kernel+bounces-317019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514F196D853
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0EB28C283
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA51B19F109;
	Thu,  5 Sep 2024 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Byfed/BW"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6900B19DF99
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538841; cv=none; b=Ceq0gPcxPwfxdRdhbErlZtHWzS24f65KcHR3mDVroryw/zmB8QbjlAsqFEeIq/HMIydG2aD4mrnkE6YG0PlnJrD8mKDwhkoZ5zAknu4Fzgs9b6SiOpf5B5P09iSZvkQ2fzrJwLP+SyXvO+YebMIvenQjlmvF6St7j2+0MAL2m5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538841; c=relaxed/simple;
	bh=x0WXOnHpURYZmVW1Xd3AlkdJWFuu81kWoIQNi8fRgJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMqZydi4PmiNV52dUL9sIoblqhpDQR9EpTCgmAbjAA6fxPc1eB+1HxdIBB+CxSv3Ro1R1XfNpDE0RAmupF88wV2aVmazrVbYes+x6W6fjP7bLljjUOrUNgqEr16sCNGTC0IoZ4zQtLIdJIbI/lAWnQv9kihggWjTZKN29q1LaIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Byfed/BW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42bfb50e4e6so5373495e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725538837; x=1726143637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAchU8X3FtVU2HZXYK45dhOtULBussLCsS4H+uYcfQo=;
        b=Byfed/BWlGNEDdqEPZJdW/xgzuSo3CDPXmZUEiDui9/6663cm9cGSVHl1ODAWu3s0d
         6ilrFEgMHF78pYHUU4fIOoHUDqp/6qP1Ed8NUU6JSLyzSQtG2vTdj6adoHR+aEIhGlYb
         1dPyR4EuLEfYDVm6EiPnZvSfE8Roac1KFAGfDf56fpTWOJ2YurjPPZJMwZ+7V+gs70y/
         QvPRGnViV/UIiO2LdR9vJyDgpd4fIFQnGxz0QyBQ8gHWJoCgnIWhdcZocmZtU4xolN/r
         91i/PFNdeN6BGSGsYt8nHZvOXYObqaIPCaWxdOKz8CXZ22MqdcJ2HhWt1A03DQFTr+Mv
         Woow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538837; x=1726143637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAchU8X3FtVU2HZXYK45dhOtULBussLCsS4H+uYcfQo=;
        b=w5U+JXQxpvBpBNdqPRI+/JX4s6cl2NOk8JVKx/W6xO8Mwj1dXfga6tid2wWtL9B6SZ
         H9ZZ58Ni0e4kH+D16VduCsDAredbv6Y+FoXzyynLpLdWXKpwoIJs7PYLIIChGD1uAsJq
         Cvap5OmN0PFgJ6wGkYuw2u/EZRkURpDwefnxinmjzYC7/a4cwX2Uymb5OCVXLlIyZPJb
         6WH2418J2n5nqSKdWSEBtGgIvoHPJi9p4aEawlBzX0zGusHBUP1tm2c6hmwFFNmcmi2i
         N5kUrSPaquJrUFaHuFQ9ujB8/JZlK6aM266PTwnMoaGvCbYS7ECChWe7MqkSybreb0Im
         3SuA==
X-Gm-Message-State: AOJu0Yzmpt2bVbDzSxnW41BxCgbitPZ0XaN+WhjMGGCskndsJ91XVyha
	gdcC9bsV4MEzEb706kUCQh9ONPIQXCZ7DY7jMTiUZAl7YqopMNmxGaFydYOFfW0=
X-Google-Smtp-Source: AGHT+IEZzGmNxpNnyUljhgZrl0lLyWsdYNNu+WGS+5pGCy7W7IPFSzHJejtHKBg5REsLlp5Cp0gxfA==
X-Received: by 2002:a05:600c:5110:b0:42b:afe3:e9f4 with SMTP id 5b1f17b1804b1-42bb02c10b2mr184548515e9.3.1725538837155;
        Thu, 05 Sep 2024 05:20:37 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e27364sm230390515e9.34.2024.09.05.05.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:20:36 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 09/18] lib/interval_tree_test.c: Include <linux/prandom.h> instead of <linux/random.h>
Date: Thu,  5 Sep 2024 14:17:17 +0200
Message-ID: <20240905122020.872466-10-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905122020.872466-1-ubizjak@gmail.com>
References: <20240905122020.872466-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Usage of pseudo-random functions requires inclusion of
<linux/prandom.h> header instead of <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/interval_tree_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/interval_tree_test.c b/lib/interval_tree_test.c
index f37f4d44faa9..837064b83a6c 100644
--- a/lib/interval_tree_test.c
+++ b/lib/interval_tree_test.c
@@ -2,7 +2,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/interval_tree.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/slab.h>
 #include <asm/timex.h>
 
-- 
2.46.0


