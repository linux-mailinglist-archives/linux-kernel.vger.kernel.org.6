Return-Path: <linux-kernel+bounces-264973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD29793EABD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B809281781
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54CF26AC3;
	Mon, 29 Jul 2024 01:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+H06bbu"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B31A78C92
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217685; cv=none; b=GISl5VDYEVtWQDeC0d0aQwCoARwa2qAC9K8u8QHmwUloBilvtE8DVBktHFWdEz3Oxo6wgi12LaQbmO80FIppm8CGbN2syplN8wTdroDMfgo/Tb8N06PvLajOOCw5KJS1Etx59iyq0V5fFo4idyelFxnuELj/VobY7AhrGTSWz7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217685; c=relaxed/simple;
	bh=pk7lkvsq4/q/7RRT0lSiVWoJpROHZT97tsR2QMOJt2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Gln8IVMkwRwsNH7YMDPt9STFpANotQyXf96Bx91adCzlT0qDdGs3clrdrbGjbOqD1gjyOm1gdqoXcS3m5Kh9kbbmwm3997Zt4IHyqk4OjmkK8T5WyhyzRNOQMfgelYgpRJ/LHCIJemQAQTVtHZQSU00j3yIL8ygsQT+wVtRQWSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+H06bbu; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso4849092a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 18:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722217682; x=1722822482; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MG9S6gbxwdSBJfdbb/Z4n1WtX6iDsEmG4mLp80lBudU=;
        b=G+H06bbuWUf34G4UN0d5hPTlA21AoAGNU324UAB5tuq7YxuyIcgSUaKQJ66NevZDkP
         2sFda7oHxNIQwc1wkccguNjBtY10fZdygHhLL8YyIS2vTqt696aAn5CIzvrbealHuI+j
         zDEiblwKtsIgfPAGxzYVFd6x1xHkI65szkwRv5Vbo7xgqCfc2MMQQFULh8rcr0rd+Cu+
         cKffBIX/8pklnOB0CWRPSzHK+CNbqNmkoHaUZgk1Jxc/O8Gr3hJ/dazeqGCAf5lzuZ6N
         Bc0dyxrdsIVBKnDpL3TYBE2CNx9u5gaN84hePjuUlfT4b5eYK6ELXztKBgwIhCLynKnb
         xh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722217682; x=1722822482;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MG9S6gbxwdSBJfdbb/Z4n1WtX6iDsEmG4mLp80lBudU=;
        b=VnSCGg3VqP9Omp17Hz7Yd2bPd9ajMO5GQwO7ZToe9eVmVILJszgVAj1FCgHSz5m9Uk
         okvJ1amDkQr8sxlB0X4qm8j2IOevqm/S3I9I/IlFJ7Hxu2wrS1vzyg/AOB+Qh4MbiGIB
         NCSQEU7fLinDxD9c5pofaqFUS//anVJhNoPkkHNwBOtjks9nFi9Zddom2VZjRS/WDqAV
         C2VsridH3MsN0XEK0/Q6ihyM9NxBgSZPtjiwKBe3ytC/z8F9f4h3Tiw0D3nI6yPE91Gm
         3nuyBAUfEudjN6+pGWFJZYLTBmHTN4NMg4mHs3ORU+ovJCgT7+Yr/VaR3ecpoA2NagT8
         W5Cw==
X-Gm-Message-State: AOJu0YwOLMfkMGU30gjCiux1kKLrAJ3GVziSMZ089uI1EW+n4IvAdxsv
	jsHBjdgN8EYI6yE0i8GbbXEMAJzHkUiWaRVNd0bRqSnc/RlCVa+UvmMyYA==
X-Google-Smtp-Source: AGHT+IFV5uloFEw3dLtZ5qdkRVEgAh3a5HblKniDcyE/0U3trOXnrt8hQKyxN8LuaZwFQOHz4VSW2g==
X-Received: by 2002:a50:cd9d:0:b0:5a2:fc48:db12 with SMTP id 4fb4d7f45d1cf-5b020cb9a13mr3615025a12.19.1722217681428;
        Sun, 28 Jul 2024 18:48:01 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac657836f9sm4949206a12.90.2024.07.28.18.48.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Jul 2024 18:48:01 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	richard.weiyang@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 5/5] memblock test: fix implicit declaration of function 'strscpy'
Date: Mon, 29 Jul 2024 01:47:25 +0000
Message-Id: <20240729014725.29839-5-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240729014725.29839-1-richard.weiyang@gmail.com>
References: <20240729014725.29839-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 1e4c64b71c9b ("mm/memblock: Add "reserve_mem" to reserved named
memory at boot up") introduce the usage of strscpy, which breaks the
memblock test.

Let's define it as strcpy in userspace to fix it.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 tools/include/linux/string.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
index fb8eda3019b5..41e7fa734922 100644
--- a/tools/include/linux/string.h
+++ b/tools/include/linux/string.h
@@ -12,6 +12,8 @@ void argv_free(char **argv);
 
 int strtobool(const char *s, bool *res);
 
+#define strscpy strcpy
+
 /*
  * glibc based builds needs the extern while uClibc doesn't.
  * However uClibc headers also define __GLIBC__ hence the hack below
-- 
2.34.1


