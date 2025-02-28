Return-Path: <linux-kernel+bounces-539005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EA8A49FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E59F188E5A8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520811EF38D;
	Fri, 28 Feb 2025 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7k6Q8PS"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E291F09BE;
	Fri, 28 Feb 2025 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762353; cv=none; b=mBzV3AwykwRCz4lpC3esL9RiDD9EXrwusUz59Wxx8pSQus3IrcAVrLOBLZg/FCmdUv0Zx2OleJxasBCU+aVf/3AlC1Us1/5M2Tgo0esFf0vFUt9Ugha6t5Za4XFb+ux4txF8nKrwhDvDhpMBcz9R8qyiZJV1fcfOKwLj54ja7zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762353; c=relaxed/simple;
	bh=TNW79YSK3OsEeNu/vaEkL5Qb4FBUwBYlOvorcB5fdTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uMjqZR867h/bhTRPKIGb3Zb70SvdvlRZyuk/Z+Q5PnHiNk7CdOtJgXaeF3wjKk4tPoEZ+fHzx4PW0EIhajKsh5qIbSzI3dByNTtV30ijJ8dlVtkP2JAKdcQziJj6gZHhwa8Fl59+XgO9a5gI3Bxtndx1b1R69Q/JZS0hUIln2Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7k6Q8PS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so15869445e9.3;
        Fri, 28 Feb 2025 09:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740762350; x=1741367150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uGOz2Vyc9zMleLzstXLRoTeuJutk5JNx48VhwbfM3EA=;
        b=d7k6Q8PSeZ/GSIsCqXwOaEZwx+MSW+bFckGWLWXTDLQTdGS9eE83KlsQ3YVgfLyAE3
         WooQFA3vlI1M1qyjvM6xpvCX9Htc4YOpxw1vw/soxzxAyuqJPbIsudqfCvh5cgQWl4aQ
         p6USzY75H8ej2w83TT6c7Ou2WGQPw11Dsc4MtOZLB38uusyfiq29UBaICqUNJMU1YuIy
         KEXiRyIyN5xQdD4M2s+epwCwKQS7NRHkv/JN2G4LvZbh8tFT1I1xBTJOl53ZXRxsFhMr
         fvzRZB0o6WKJ5s8IFZHepHgzmnQxn0s8aheWXkulgC90HD/5Lnws1lAGrhf2Ti553gZ2
         H0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762350; x=1741367150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGOz2Vyc9zMleLzstXLRoTeuJutk5JNx48VhwbfM3EA=;
        b=JW2QK3YGRah8p4Kdhpd6fJJIU2kcxDYHZOlbkg4vIAnjeu+DucOO+fhU6Yq7nOObk6
         VmhlggCt/LTCkc8ibld+7FNvrL712D4yzJTgLGXDcMv52H6H2uDhLefJjxOjj/arHtXO
         eNZdR306GwYCXvI1QF2d7W1MPZCTAJOhREDi8fgpLzfKQ7Vx6Meez05QjZC8MFQBatAz
         eIFVqJs5shtoYknmiyoK9cwOZe+ihXrm194K+OJwRcdk/VYXJoQOD79ei69f/8W6RFlg
         sDFDLkEOlQkdkL5THnAbTZNt3QM65ZfemLce+0GagjqY/mD++8H0VTwH4cLUwlND/lk+
         C9SQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3hts2+lwDa6ljxkOu2zawWkYO8k51fMZXJ6Gciievz79yt11oie9W+0uvopnpI6KZ+huAl0aLnkQD2K4=@vger.kernel.org, AJvYcCWhiq5htnTKpThsoOsogIF0IqoPlKU/E4clhErc21H0cmcfj2YuOaFSmFUA9G0hISh0fToegXNS66QOuGXyNTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyPTWcBFZs9Q4RWkzRZBjuE/pqRemOpkXpqU6FXFj1fJ36uY7u
	O2Kwt/e2vw+MFKzTS0SOONM73fCTy5e+TbfdWFohFnE3j0Kg7OuOpPHkNHne
X-Gm-Gg: ASbGncthro9HQWkLnwbUP4/ScLkect+YNVSuFW+jL6CWMLEAaWj6ZA09Z989VQREvhB
	nnIOpreE6KtNC/4quuf2ONxAELprhTV/AXYfTw6+DqYwqaSvyhu/RXaECL+dcac/D3PRdfbcrVM
	LcxC9VdqMGQ1lycs1r6O9Zk+RpBW609s+CGvMSnlz8dFMqVlY3Gt0WaZe+s/y3jHJq4xGLd4kbX
	2TXKO8QPeuE6L/+luz4oU4rtEreom1l6SKqdxj0owhPtw4e83HjG9i/Di8XLZd/NpdnbIMA1Nd1
	QvKdbLcHVAe8bO0XZYcze3GnEfjN0Q==
X-Google-Smtp-Source: AGHT+IETFuS4lsDWiG19zxA+TORXRJGy+FoK8y/hVYewKpq3ENo43gzsPdsqGRnorNfRSBt99lXnxA==
X-Received: by 2002:a05:600c:1387:b0:439:91dd:cfa3 with SMTP id 5b1f17b1804b1-43ba6760305mr36262855e9.29.1740762349946;
        Fri, 28 Feb 2025 09:05:49 -0800 (PST)
Received: from fedora.. ([82.67.147.186])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba53945bsm94990965e9.23.2025.02.28.09.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:05:49 -0800 (PST)
From: Guillaume Gomez <guillaume1.gomez@gmail.com>
To: ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guillaume Gomez <guillaume1.gomez@gmail.com>
Subject: [PATCH 1/1] Improve error message in case the original file name from which the doctest was generated from to mention the doctest file path.
Date: Fri, 28 Feb 2025 18:05:31 +0100
Message-ID: <20250228170530.950268-2-guillaume1.gomez@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case the conversion fail, it will allow to get directly the file name
triggering this bug, making the bug fixing process faster.

Signed-off-by: Guillaume Gomez <guillaume1.gomez@gmail.com>
---
 scripts/rustdoc_test_gen.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index 5ebd42ae4..12115979e 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -87,8 +87,8 @@ fn find_candidates(
 
     assert!(
         valid_paths.len() > 0,
-        "No path candidates found. This is likely a bug in the build system, or some files went \
-        away while compiling."
+        "No path candidates found for `{file}`. This is likely a bug in the build system, or some \
+        files went away while compiling.",
     );
 
     if valid_paths.len() > 1 {
@@ -97,8 +97,8 @@ fn find_candidates(
             eprintln!("    {path:?}");
         }
         panic!(
-            "Several path candidates found, please resolve the ambiguity by renaming a file or \
-            folder."
+            "Several path candidates found for `{file}`, please resolve the ambiguity by renaming \
+            a file or folder."
         );
     }
 
-- 
2.48.1


