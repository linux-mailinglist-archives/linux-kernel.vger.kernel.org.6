Return-Path: <linux-kernel+bounces-335323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E5897E41C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 00:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D907E2812A1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 22:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027697347E;
	Sun, 22 Sep 2024 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6omWkX5"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A852576F
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727045446; cv=none; b=H8FxJZYur5jI3imiDVqtUiMJsgNgdienNnT5kOGUiW+0WJGfqAiNajcOb36p5heCgraKHJBHAoLI2Agk1Q/AeuUYBFvsEHph6/KY5OrfMMZvoEmhwuEX1akAdaiZ2t6JH7Zp1/kSdfGvejDDqDJ1owsV4Cg+nRygBAEaClbGnj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727045446; c=relaxed/simple;
	bh=8LGXTDwinNibFmXBnGmW/BehSv6FmYe0U5txD7PxTqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UIXA27EqcVqy8r684U+7iLn53Mgvd1osL/sXWdzv+kXjjlYNBR8L0/+WDqraXnjJ6KqkzD29eQ473J/2iKdMD+LYKaDlREChlu+i+bEEzbTQvvHRlVJoJR4L451WsYstSFawlO0MktpPHm2Kaj1dzYLdJb3t7Ebf9Nk0RE/Iwzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6omWkX5; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so3062558a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 15:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727045444; x=1727650244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=evzGl8uzkkF6Z8ZPOLxJr88+fFCholgWD2WVWd/Pyk4=;
        b=G6omWkX5sXFnjoxGJzqWDByem4aAczU90pxIsPgpvCe9b6nncEseihSME7Dp9mRu01
         aDMSp8t4lfGh3zTbXaCagbWXx6PeaQ0tWxTJukkZGJJmgUnt/JzaO7n1AOntVhsN/F2J
         MiUUxlFoeJiQg5/aDKm+RC4SYszNWTCmkNRMZZ8zo1Jofssus9TgiGvmguotI829simz
         /ypu3A80Zts4HlDEWow+QW+843rLQuM+GzEgquGJYYgX9iYTHTO5vvMmuRMSjyeqIjsc
         NsAiKwUmdn0Gj0S9bbJlNpMwr5VNRB1wsiMm4Ys3odX4ZOzpBlnXt7QcLyvcl4LF0aPo
         fgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727045444; x=1727650244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evzGl8uzkkF6Z8ZPOLxJr88+fFCholgWD2WVWd/Pyk4=;
        b=CW65WU/+0bPM5XXfch5/oovLl/hFMJ3hhka6sQNO6BhWOwz7g8qbQ510An0T8n2Q7G
         CuIPF0EBLy/f6UoEqaykchQU1oYmxXBtXmwc5bkp4FrgI11nLM7qJopNvRrwZyDPwu1s
         NZIUVf93X8q4+7bgBME+Rl4ffwE39KHs9dqQKr4KTVyxze80exGMiFq+e3+M3bSA+HPM
         km1aAGkdQm/l4/N5rOHxt4XQ9gtxsyresFVxzRw1ioAwVq3XE2mRxvBnRjdM0K5ykxvF
         bTtiOzbxDxa9AhZI01jScAAoHjhHOWAS4cjStIki/0dhXGoFei5pnfuNIar+z3Fpi0PF
         dB3A==
X-Gm-Message-State: AOJu0Yz3C3STJiRh7CAZ5+As838c78A1I725n3cxbHwrvT7rFhVJGIBp
	Y65Zv1QCuWW6bRLGOAvy/0udY1ZemfmOuTAT+xy+YHBeQ2IJe8rR
X-Google-Smtp-Source: AGHT+IH3DGatcC/vW3zVDuqzQuR/K8bbe8zAiuq+7oCVJudmHp0v+DyC9IdaXInKc7bu2f40GoFToA==
X-Received: by 2002:a05:6a21:2d86:b0:1cc:e101:ee64 with SMTP id adf61e73a8af0-1d30a8a653fmr15411761637.1.1727045444196;
        Sun, 22 Sep 2024 15:50:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4999cfb7sm14386680a12.79.2024.09.22.15.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 15:50:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Huang Ying <ying.huang@intel.com>
Subject: [PATCH] resource, kunit: add dependency on SPARSEMEM
Date: Sun, 22 Sep 2024 15:50:41 -0700
Message-ID: <20240922225041.603186-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building allmodconfig images on systems with SPARSEMEM=n results in
the following message.

WARNING: unmet direct dependencies detected for GET_FREE_REGION
  Depends on [n]: SPARSEMEM [=n]
  Selected by [m]:
  - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]

and the build ultimately fails.

GET_FREE_REGION depends on SPARSEMEM, so any configuration selecting it
also depends on SPARSEMEM. Add the missing dependency.

Effectively that means that RESOURCE_KUNIT_TEST is now restricted to
systems with SPARSEMEM=y, but that can not be helped.

Fixes: 99185c10d5d9 ("resource, kunit: add test case for region_intersects()")
Cc: Huang Ying <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index bc8faa4509e1..52184c51b6dc 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2635,7 +2635,7 @@ config HASH_KUNIT_TEST
 
 config RESOURCE_KUNIT_TEST
 	tristate "KUnit test for resource API" if !KUNIT_ALL_TESTS
-	depends on KUNIT
+	depends on KUNIT && SPARSEMEM
 	default KUNIT_ALL_TESTS
 	select GET_FREE_REGION
 	help
-- 
2.45.2


