Return-Path: <linux-kernel+bounces-405531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E149C5298
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D38CB26982
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4F020E329;
	Tue, 12 Nov 2024 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLM+QhvL"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503EF1E4AD;
	Tue, 12 Nov 2024 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731405293; cv=none; b=B3Pm/8Y/fQYYlYfww8SaeWW0Nhd1Qblsgh/yVfJM2YtopNMi4saMBNS1a3kIC5NhPBYTdP5CJ5u1rL5Sy+W2FXBhRODi5n3S4bQXXESb55LLtwc34tY24reZza2ZlpNUiZ2v9DZva9VipeltaK0aPTa1KOHCXqIraRFSSQEEeq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731405293; c=relaxed/simple;
	bh=/UP/yZkPRx3ksy8REvHcWTGDFGN+/6SFJSjOIYISfGA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UOHBhaRwQmPVfT1Ymfvs41vYj8EmuWkcH+LJ3U3kjCwpUjhFFrYqqJd+To+KGBXnvRwisuiEzXH4gNOByGgoER9lYBz8ypuUPHwe2b+d/cr296Q7/8YHGa3WLCrhYPK/K+4+abxdl4d18mdbK1oPxBA+EHuW6+c73qRmXIiUdlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLM+QhvL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315eac969aso30971735e9.1;
        Tue, 12 Nov 2024 01:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731405290; x=1732010090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qaivvDChRb0InDJ8FMMWKeFE9ZD3AcLndPDWrjVqzRQ=;
        b=NLM+QhvLEahbKphah1oF5eKJ75uI99agV+cNz4Fz4SL+La2V14YpgU0MTPwQRDRc76
         f0LAm3ORrtngRRMu0cLdN3yBM9AjwEC1F4kLKiJO+DKQfYgaGWI0xyFT/OaMd2ZN8wBi
         369h3rYeYZ3J5UZPqm5kvOi1VHMaDjTcUQgRAUcYDNjccFMfV7OxtUv5NctnONxMjGJZ
         qSsf6J//8iZzXL5RbNUSTHixCWrDP4F3kMhQuRfZl8pSZyExOZbN9RdJOhxpcSaPSWjP
         NWYpaz2ihLUKvUKIhoAUKSxUDe3HJqCSVVR0795sTRnD7Yl4vUn9G6zBOTNQhQciT0VK
         r/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731405290; x=1732010090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qaivvDChRb0InDJ8FMMWKeFE9ZD3AcLndPDWrjVqzRQ=;
        b=pKva1J8B1hptmgvjWmbYReMYUNvSB9EzTp7ClgBNbXnATuwHQrjwZOSS3B2zSYIOY7
         db03JhC0bzBNmX1/WDzZp55lGWfbWNx+HTPaHP54YfZu94JwmarTeNE0/gW8CHd+1Ctc
         rLiLNWSR3pkUgYyQAdR2ooQPzZe8CcyDK2ssuVnzru4lWODCaCKO2RnpgFV9HW6TqjCA
         nCDQy/E6+8+Vfq2serwcT1HxgLgZbM5Kzea86UFhPWgj3aXEPVeze977epMvISrR0YxE
         tP1Io+ua0NOSaVMPb2qgPkTzPz3hkh2MeNWmmLtSUb1UaFvbB6KIvGbx96ZIR8ss7x/2
         JzPw==
X-Forwarded-Encrypted: i=1; AJvYcCX9F3i3n1loBjYRKk+BPO33CQPlyuDQbyXP/ZaR9RirdcQZmFH/BwWQuDWdqoHj96Lz/O+r7Nodval3E6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ0SPnvthe8Anj4Dufbt6ky6UgVpZrf8Xo86sKoUd0l4KoCYET
	Sm3KFvT0gZWJbRIlR34hFFYpaft0Zb+L8ffwiORsBekwcRrdJ9kVt+Tn3vmTf6+yjw==
X-Google-Smtp-Source: AGHT+IH6q+2c0ZvH4Mqyc5GpFUfzI4kxFJ9JrF8Pz4fdBojwceABr9m8BAiE7+L6NGf3ItAa2jqiGA==
X-Received: by 2002:a05:600c:3ba9:b0:431:47e7:9f45 with SMTP id 5b1f17b1804b1-432b686ec45mr142761445e9.11.1731405290361;
        Tue, 12 Nov 2024 01:54:50 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa74bab3sm238757095e9.43.2024.11.12.01.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 01:54:50 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Gabriel Krisman Bertazi <gabriel@krisman.be>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	linux-mm@kvack.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] mm: shmem: Fix error checking on utf8_parse_version failures
Date: Tue, 12 Nov 2024 09:54:49 +0000
Message-Id: <20241112095449.461196-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently the error check on the call to utf8_parse_version is always
false because version is an unsigned int and this can never be less
than zero. Because version is required to be an unsigned int, fix the
issue by casting it to int just for the error check.

Fixes: 58e55efd6c72 ("tmpfs: Add casefold lookup support")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 7987deb2be9b..b69e1d8816fa 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4377,7 +4377,7 @@ static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *
 				       "in the format: utf8-<version number>");
 
 		version = utf8_parse_version(version_str);
-		if (version < 0)
+		if ((int)version < 0)
 			return invalfc(fc, "Invalid UTF-8 version: %s", version_str);
 	}
 
-- 
2.39.5


