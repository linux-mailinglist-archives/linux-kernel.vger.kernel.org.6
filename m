Return-Path: <linux-kernel+bounces-264969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A6A93EAB9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43E71C213C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88083A1BF;
	Mon, 29 Jul 2024 01:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOQxbU4n"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661A914293
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217681; cv=none; b=b0d/V+DAxs1CAbGBGbO7vBLELp9N0hNAl0WIirEmOfM64fEpU8d6nTgOYKKuKk+j3a7gFEO4FpgskdFDbc+cgygJJdOm29+xgb1Xce9comj42JBqoaJTMH8omDa56OPKaVUjtQuGg3emAw12y32MGZR9Of/BC4quglz6qmDlLsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217681; c=relaxed/simple;
	bh=wHnOUoFokTBN1Jd6o1eEhkLC4+RFMapyylKfcddXvFI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=QCdrW6Pt00wMQGQHyac5BOMUtiFHijhyhMRzUcNxvrDEemC1enUIZKUL6eKx1ps5Khy9S9UTXcxN0fSOjNv8097vBuVoF0SxHxqau34TJpyM5uZBEMmMXjVUyH222LAq8EoGkcBLgFTD8F/aw2vSlHu3nLsTYAJwlJO+2+mlsj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOQxbU4n; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52f00ad303aso4665730e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 18:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722217677; x=1722822477; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8kkYcJa59kQZUgKarOlDxJXHcnI7ps1B8yQUjcTF1s=;
        b=VOQxbU4nU77dlYyIbb3RPAfWZkYuWN6jMkHvc4kkqwpizpp7ruBgXXkOK96499c7fc
         nJxLJOqBJJAMfFFE68oD+RcEnFK0PoV+ZadOjiW51nnJ5djd1IY0ANSxo9hFVAYcX0b4
         E8MMigJV944Ip1DlGBvKbtZHxS0xB4TKqcXTDEMWBI1DflJVy2tN3YM0sthzRk2UgI2y
         ho6KZiIxwdMECIjIjamlQ7mvpMn5d6kwmueKgSaR66Tib63YgzyEmHeU6KuADp4WeXb0
         Btgo+J779uyLvlYP0VzaYBHqk+dBMnFK5IPo/HHnv3Xtgx1jg6JcdBUerQavynrBznum
         GlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722217677; x=1722822477;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8kkYcJa59kQZUgKarOlDxJXHcnI7ps1B8yQUjcTF1s=;
        b=QtC1ucQPFyTGeVS2PKn2iPkoVQzmYhGuMfx9yIhfxFvY67cdp3FlnBwrdPdfeuyNA3
         7xUnPs4jqVXLkCS894UwvxD+Cy5HVFPmOj+OJAJTHNsd/Aq0l2KhZ+BzGhgD1ChQLuG1
         waKFw2JxXpBd9vwkYxhHsdGO3JIgdk+O8QgX8Fz+JYuMfu46LEKpPyqSe48Lz41CMyFs
         XcdDO8D6pLqB9YpHrgM0UnjT3fL/5FnvttLRYZEaYJFrCEO46Vx2eUDG6XfKhMcOYMPQ
         uOQ7N1eCqu84nGgcMpz7g5GfSooNihJSgxk5VHPssaw23F/f4y8DH6ze1w3NLomWz3Wz
         K6TA==
X-Gm-Message-State: AOJu0YzI/AH6JR2iIx5GRAE4Mfe1UjdNKERUtoi4UzIvI0IC5dliuslj
	6NHa638C+gy72tmXIwTkg+D29ZIE8ymQCvXoaJQP5HRlLMVJm+zYniQ72g==
X-Google-Smtp-Source: AGHT+IESUw+4w3oWeHrCw8KQxsl+nRkSsjjtNX7KBs4B1idaR3MyPaPXaloqUBplFPAHIcgYSmvDnQ==
X-Received: by 2002:ac2:4c56:0:b0:52e:9b74:120 with SMTP id 2adb3069b0e04-5309b26b690mr5086361e87.19.1722217677030;
        Sun, 28 Jul 2024 18:47:57 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb8072sm441807966b.196.2024.07.28.18.47.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Jul 2024 18:47:56 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	richard.weiyang@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 1/5] memblock test: fix implicit declaration of function 'virt_to_phys'
Date: Mon, 29 Jul 2024 01:47:21 +0000
Message-Id: <20240729014725.29839-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 94ff46de4a73 ("memblock: Move late alloc warning down to phys
alloc") introduce the usage of virt_to_phys(), which is not defined in
memblock tests.

Define it in mm.h to fix the build error.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

---
v2: move definition to mm.h
---
 tools/include/linux/mm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
index cad4f2927983..9db45c5d00fc 100644
--- a/tools/include/linux/mm.h
+++ b/tools/include/linux/mm.h
@@ -20,6 +20,8 @@
 #define pfn_to_page(pfn) ((void *)((pfn) * PAGE_SIZE))
 
 #define phys_to_virt phys_to_virt
+#define virt_to_phys(p) ((unsigned long)p)
+
 static inline void *phys_to_virt(unsigned long address)
 {
 	return __va(address);
-- 
2.34.1


