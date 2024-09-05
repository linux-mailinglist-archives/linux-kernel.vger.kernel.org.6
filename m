Return-Path: <linux-kernel+bounces-317026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 240EE96D862
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85B54B24225
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6301A0BC7;
	Thu,  5 Sep 2024 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZI4rdEIa"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8D31A08A3
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538848; cv=none; b=PVmwrkmsiXIz7+SjEAeWlUHBStqK1GIFlOiniY5eUQ5zVpljuOVNe88VpxfE2Y32o7iSzIcXEzubaPEPEOBMzUdrzvz4Yzh+2jgUgdGqdIMMUrsOwu//5v/rn93K9zLXJQ3XgzGSskBc5AnPYup2Jc2yq16ACtHUaLY5kwqbGtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538848; c=relaxed/simple;
	bh=hET4q7Pc1X6kxt2OPecQo7E9Q79ENlS55Gg64qnHS8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSFxnHBklfNxhbIOJa2T1qX8wxzwT5taGf38+vwHIlOVMtZ8K0N2CQ96AcyGVOji4ia9b83XUE5Ic08uMJsQ4HcatWyuamB8ALBOajpYNzQa7j29acFoeMYdBVdt+M4DS9j4p92rV7oYaRPa8ZRayrw5zdOmdXWhPBWysjQm/0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZI4rdEIa; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428e0d18666so5524215e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725538845; x=1726143645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aSCIcfy9s48VexFQa9Ehe2ha0vbZStedxECIq4Zj+M=;
        b=ZI4rdEIaDxcsgxMSNwN02KNpCK2GkHs/eqjjcuEOGOsPD++s/LOAPQSugD0kQnCvEj
         JCIaiFM8jD4V7rqwxpwX87ccbqEOn9ERV7kIws8grIFY3TI0gMjS22CbjHBlJZvuJuhF
         +GoB7OcQL67Y7f2M4S9BI39f/zuhtrhmHcwFlFn5oDiYQ1P9C6dJ+n0kZui0nCqGibD6
         ULb0cM3L1SashRbg8ocTiZ8C4zN7WrLDiGpQQNoT/MxMg/auwvWT2D44GygDFwG1wULH
         udXTIoXRUQgFQpZKNPv964hU/e25DsUW7ZWJzhsiAxDu3QLatO2Mjqzf5ozs7FLiOEmg
         8keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538845; x=1726143645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aSCIcfy9s48VexFQa9Ehe2ha0vbZStedxECIq4Zj+M=;
        b=Ui0CPp7BptTbIoHPvTiZZsqMOX1UDZ1TWD82KaI8xSpihjOOiH+VfZQcRkIxG6eqGH
         Hf+MSktNC7zq2QumlQFh6z1XNNnFlzjN3c0dr/K8Ge9XGEF89J5b1kwsxOJ9JL6at1K9
         rtAiyruGh1uOj3i62O5avjq3Tqi505Jswj+gg7BfecwjqNEthB3pJQ2NN2lFmLSZ1Ng+
         1kpFmXZ2NB3ob2o9DVHVEFC8yRbwAsaVtC8RTVQrlhXi0A2pPVyOPudVTVmQBvcVe9oE
         7PNdczlAcz7hLCZGfpD+F3tYb5ukQhh3D0huBiSNoWrLvKLdSKfy5Pz7suMXgd9RqgXx
         OScQ==
X-Gm-Message-State: AOJu0YyGdAq83VrbcqBxfwKYjBwZjGZI/q8Au5WGi2zP2ZgKghqnPp0r
	sgp02zxZ5IUDaTa72muXiv0u/xb4NOs88Ue/ELDqy6q6nZpcTj1ZFT2dgVE7cqI=
X-Google-Smtp-Source: AGHT+IHJ/wLBdECXGqmS6XLIfSqk4k7f2LkbCwawrfHEWpPAZTazY8Pr/jWEGsDOf33d6AI0tc0kIg==
X-Received: by 2002:a05:600c:1e09:b0:425:7974:2266 with SMTP id 5b1f17b1804b1-42bbb436e04mr140731795e9.24.1725538844915;
        Thu, 05 Sep 2024 05:20:44 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e27364sm230390515e9.34.2024.09.05.05.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:20:43 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 15/18] lib/test_scanf: Include <linux/prandom.h> instead of <linux/random.h>
Date: Thu,  5 Sep 2024 14:17:23 +0200
Message-ID: <20240905122020.872466-16-ubizjak@gmail.com>
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
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/test_scanf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_scanf.c b/lib/test_scanf.c
index 7257b1768545..44f8508c9d88 100644
--- a/lib/test_scanf.c
+++ b/lib/test_scanf.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/overflow.h>
 #include <linux/printk.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 
-- 
2.46.0


