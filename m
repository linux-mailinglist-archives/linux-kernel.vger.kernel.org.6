Return-Path: <linux-kernel+bounces-264972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDAD93EABC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667321F21B7A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76C07C097;
	Mon, 29 Jul 2024 01:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECS0hsLj"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944AB78291
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217684; cv=none; b=thJJpCke9vMzJjlCTFRTiuufO2JomCjYJMo/VH3zgX1i8MEbjpMhgAhapbJrbjJLH2omtSi/G/4CohtfXlmxJZnqiq/PKd1xA/AUVxWB/20T8nuk7eGwMF2RWdR+caRY32WHPI8CzDTa4GW2vQSwZmW8PnKEjAys+C48WlLk5yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217684; c=relaxed/simple;
	bh=maHef5ggs1ts45wIzJE7VDz5VzmJJUpzw7iq/Ex4uNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bmMWmhGrlic2V5IIUx7tgL1s2yxcv8DUaZ8EbVwYR2Ipl9N0Dpy/SbiUUD+TKWYMKhql8kC67CwrM3ARfaMfONe23bv9e3EqFYhLHSrN1Lj+y3URVcsNvp2PXyy9aRe0J597CgqZn6a80gcm0fI59mVm4YUyXEwdVh4Qc/fxKhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECS0hsLj; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5ab2baf13d9so4663807a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 18:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722217681; x=1722822481; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3+JPYPQt1yTaGk3WXPjbRRDMHWDKLDoRYgnwrc901qQ=;
        b=ECS0hsLjkd24gskXZM5s+5E9wh9AdLrubDVRJnbP99VQ1FYCKxjBiQDdrKbvnVcXt3
         h1we4Y4rJoo48BDvQeQoRlTrSpa21JVT+mQZc/s0myWZvPePtjbFQsFl3aw4sOeewn2t
         JhKBSB0iF6gYM69fOtlBWMq6Pgl7rD37z98y7QL53PYlPQ4V+43v65mZ7O2ehQALdIXW
         ZuVVrsSh3AjBpzamF+h5it42AFCBUMcmN9BCPAezLgJK4rzS+dR9pvShsrVs9cLQEwoH
         Z61ePi0/HPvAqwcXEdnf00gXe8vJzOOz61Og6tj6U12PNb8x8T/Iz6CoO+4nyw/jFv2b
         g3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722217681; x=1722822481;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+JPYPQt1yTaGk3WXPjbRRDMHWDKLDoRYgnwrc901qQ=;
        b=GjgYOKnxkkig6WJhR/fS53QY7ZwmR5pxWwMzK3b80yMOkfj8jbGjuMIrLe95WaHK7U
         wlbr5eFuZ7lpYQSgiUDxxWkETXa5+Yp//2JkHiy/H0Ll/BTi30+EX50LziQjx3GZ8LmP
         MyNwaPP/9Zk4hyi2/ImOV0TyB+sYzkRTQGZxxNVZT3DFBe/r82o5vVyICtOOrmbYho/B
         BKUIGlVMAziqrlvbFmafbQt1TpOCZyOHCNTlaJUtye2CKDlQHyaWqOTMaKjw5dHy2rVX
         0aViPOMVQo5X+I+BYeLXl2x6FYPnEK/c+rYVMA9LGjKGd0krIGjY79UXFYE2+S9IeBqs
         4+fA==
X-Gm-Message-State: AOJu0YxYbH+hWXh1GAPzBqwLMO6YljHqmsGSJ32koryOE/lxy4fZuq4B
	RwFLE1yAUSZsQ/nBs+3viKCiiKTHaMIUdPjkFrHML8oteaP9gECFr0tAIA==
X-Google-Smtp-Source: AGHT+IEFJ6tmkCvSL23OSnviSOViPBwZPbf4kVXdAQwudZZrtBsj2eqZoqbLQEvM6RBTWkHdxZvgUw==
X-Received: by 2002:a17:907:1c19:b0:a7a:a5ae:11bd with SMTP id a640c23a62f3a-a7d4019b3e7mr468705966b.67.1722217680572;
        Sun, 28 Jul 2024 18:48:00 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acac615c0sm444792066b.97.2024.07.28.18.47.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Jul 2024 18:48:00 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	richard.weiyang@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 4/5] memblock test: fix implicit declaration of function 'isspace'
Date: Mon, 29 Jul 2024 01:47:24 +0000
Message-Id: <20240729014725.29839-4-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240729014725.29839-1-richard.weiyang@gmail.com>
References: <20240729014725.29839-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 1e4c64b71c9b ("mm/memblock: Add "reserve_mem" to reserved named
memory at boot up") introduce usage of isspace().

Let's include <linux/ctype.h> in kernel.h to fix this.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

---
v2: include ctype.h in kernel.h
---
 tools/testing/memblock/linux/kernel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/memblock/linux/kernel.h b/tools/testing/memblock/linux/kernel.h
index c16d9cd2d1ae..4d1012d5be6e 100644
--- a/tools/testing/memblock/linux/kernel.h
+++ b/tools/testing/memblock/linux/kernel.h
@@ -9,5 +9,6 @@
 #include <linux/linkage.h>
 #include <linux/kconfig.h>
 #include <linux/string.h>
+#include <linux/ctype.h>
 
 #endif
-- 
2.34.1


