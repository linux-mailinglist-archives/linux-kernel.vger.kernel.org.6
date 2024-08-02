Return-Path: <linux-kernel+bounces-272014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4A39455E1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 03:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED79DB22CCA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 01:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD50C1DFEA;
	Fri,  2 Aug 2024 01:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuPh57a8"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BED717C95
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 01:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722560982; cv=none; b=NBVdrGSML8zRRE9GniqUifuioYltTW07bX4bHyEvi6Zpv+tTFo0c1DEr7MOaO3tULRIsL5E7pgi8zRKpmROyROU1hiyRHzSk1JHi4VVMX2hy8IP4/jaJj1KiO/YpRemnXbgLZhgyj3l4SPUma3UtWjjqi/2+rAI11nXo5C79xA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722560982; c=relaxed/simple;
	bh=pk7lkvsq4/q/7RRT0lSiVWoJpROHZT97tsR2QMOJt2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cWRFeZZoH6ovh2u+ohQJQa8rqEVY6gl92roWf3t2zoJNBfGO+9YqhhyldWkgl1byrPZSPEl2ZDQ9cgrP82dxjX03iyxnVNABwghyQwECq/NiC0MZYSLcjemCyDknqZWWHs7l29I4g0ZJppW6RUu/lNnwEIG5jqjvCvqjJ8bBjlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuPh57a8; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58f9874aeb4so9774783a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 18:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722560979; x=1723165779; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MG9S6gbxwdSBJfdbb/Z4n1WtX6iDsEmG4mLp80lBudU=;
        b=UuPh57a8a1ouDzoUomVR3Yi65jAXb1IoDCQRUcWPDVnB+sl25b2h0Ffibu+tHNeF6K
         OJDgKwdQhshb+yRLaeQ2/QHrvHTDT91GitPQBhyIyGMBLetDQ2Uxy39wTHJA5XWhb7ev
         XzLwZGUeF4CjJqEyWWc2d4FB/0SV50Uoqp5Iufz4GpYo34Aeq+auk2TVz67KriND5GKt
         v3BrzCC76uXWIPhxH1dQM1xFRHpM5Hgg/pF2KsqUsxjYBS7qSihHRdavqdlKGmZjQ3yW
         dQ5qW105jaNLyxZK8nQqUE0S8k0l5QTZtx2fH6M2TZ7WKf7DiJ+4ez3MlT3O5u5WUB0j
         TNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722560979; x=1723165779;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MG9S6gbxwdSBJfdbb/Z4n1WtX6iDsEmG4mLp80lBudU=;
        b=Fp6J6Zx77DxUJkzFXUfH4nG26c3hy0JzKszMUzWOuFpvwVaoCcJ/8wDb3x7NahIf6N
         83UlqBZRcB9MEnxe9N7gJ/s94Bou+qE1ieMPR+zyXC7b7+pRe/P7yBd5hBeVtPNlPIWd
         n/mOtUPAoW5KBX+2SMY6i2rGNxrrNfBSespJ/gQMCcVQZ9fGpO6xdSnFEWYcY1+1UkJ8
         aB4ZFZ+B98QqYA/KiHjbqsYOLZf74CCZJeR8FG+40ay8twDGnWxET8tIKg1ThfInZ8AS
         3V1fYAe7yV4bsSz0RCjkvzwpiIr3cQXnSsJEXT5Ue6MNHpgUKFlcYloPkoukBH4sfML0
         V+oQ==
X-Gm-Message-State: AOJu0Yz+Mso20195s6L+Be4IMbdQ/JaJ8/rGX4paVgtGq/8LFDIrFYg4
	3lSTSq8f0zz7Y+U+mWsQV5Ufzbpm1ON/P0lBnwUE/jQ+h4f6erJ9
X-Google-Smtp-Source: AGHT+IE5ShbfZbDdd2LTvz66bL2KLfOUkM9NClobxGX5rHyYVvmXyG6VbQdGvzCZl64uSWIFNbkDuQ==
X-Received: by 2002:a05:6402:8c7:b0:5a1:83c4:c5a8 with SMTP id 4fb4d7f45d1cf-5b7f3cc54f2mr1247625a12.14.1722560978637;
        Thu, 01 Aug 2024 18:09:38 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839705d44sm408708a12.11.2024.08.01.18.09.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Aug 2024 18:09:37 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	richard.weiyang@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 5/5] memblock test: fix implicit declaration of function 'strscpy'
Date: Fri,  2 Aug 2024 01:09:23 +0000
Message-Id: <20240802010923.15577-5-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240802010923.15577-1-richard.weiyang@gmail.com>
References: <20240802010923.15577-1-richard.weiyang@gmail.com>
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


