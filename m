Return-Path: <linux-kernel+bounces-400959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D24B49C1472
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89BC71F2329D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65AA192B79;
	Fri,  8 Nov 2024 03:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0jfPCmS"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE08914012;
	Fri,  8 Nov 2024 03:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731035447; cv=none; b=TrKDbCxqAv7CjyOXtVH1bctuUmkSBJjyd9LTgNcjp6UvPlnguaflg2Oaw5M9kSC6JWCOjQARAzeKU1uLPQlDtCjPWe4xn/x2nOfeCeXZP7FjScJMBTDFsuYaRIJIK171tMoEhHyYmIGFIdqLX6MOeZn3rNCnwrXm+d73Pa88ADk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731035447; c=relaxed/simple;
	bh=yP+w2bIbx0jpu3IgHoJIbwZnAFDYB4H/m+UNc/5sQys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4WwZPYnal08KwCOrfdkI/V70uLJyIzfx/Txnn1hBwZBkOJG59N8lE4gqJ8CEm0AD4ZZFUGzY1WbbrHuxU53a112pX3CPW6D9YagvNwEBv/JG9YNTnZMyQYTcZT6eB45+c2ISLc6jZaLuH8+MeALWI44wOSi0kuHYtOCP56kj2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0jfPCmS; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so1251226a12.1;
        Thu, 07 Nov 2024 19:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731035445; x=1731640245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dak959r0naMwShkPeyiVoRPjJUPhzBzMV2GYLTEL2tg=;
        b=V0jfPCmSv2/SqXBsBQpjQ6UetM5OBaal3f24waafw/Hnrko0IlsBSNTG4XGdNjh0eK
         OXynQcCVsnICD/OOGhZ4CSbqyYz9a5wOo7+avs9HqsRLDG5+Q1X0HZSF6ifMtEmENpwI
         kRTWh/6CdIG2uTjza3e16p1kcFdMujFAouzVctDtYgq3tgryNHd51bWGMf09/rNzCrn6
         nUXegEBW1YwOFR8UxmCPEo7o71miCA45BPApFnjesl+EBOqpevYgkeVd8hnmY+97qjWY
         RkpjBEL+wNKp+hxzgNQZ9lk5hHY3lL3YKX8vk91b0Sr4zZJX49w8qRCrYumhGvf7BG0+
         ECUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731035445; x=1731640245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dak959r0naMwShkPeyiVoRPjJUPhzBzMV2GYLTEL2tg=;
        b=Cd7YuxAUqPqTSdgIbr9o5cgWJdsGSiy8Fd1Qh3GUDuLtfyrfTvfKpQQOMlH8uYakp5
         O0gFKxADcBtjHcouFCRYq3cOcA+t1OBFvjEbAFIWVa9CuZwIi0IQHO8fgdEN5EVMnHkh
         QXKFS9fSO+IbjcNRWk6sQPfPYzObUN+mW3qDiKt7NwuVeRpDPfqUurm2qakvRScXrCA5
         NEVs0W6RTZNoyknpjxL1/1jUTS5rLOP3NvqxhWmJVKvgSXYdECL9XXXFADx1un7JT5BE
         lOpMMSBFi0IXqngmdRxXV4IS1BgE+SFrIYo1SVbza3vp4hfSOhCZbcmUbRgwuAIw+FWl
         QI5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHgj66iTWgOAqnHeU360BIMfVpfDxoWVJR6OIfWq66kgiKnNoK6YkZXf6NJkJmcbXWo7P9ue4QVt1tzZ0=@vger.kernel.org, AJvYcCVoQdf84BEOhjXi8PJv7JBaOdgXGQTYtoEQVakiXV2tduEY/wPCD38ySuMtEjDPaTX5Duz3U7+keSVP7NgNmDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiwZ780ghG1xPYvGpBPYg+USHZWdkZQlmYqYaj7KLC/FBC6xpL
	fxtbBubXLkGgQBNS1AyIDqoiR3AF50MCzcX/zo4wqCRMcs8+xOVf
X-Google-Smtp-Source: AGHT+IFcUIT0POr5B7JfJVlZ++rskg3e/7kDof73MLNDtDVSQL1dQP1NYRW0zA0ObwGbPjIiDaoiyw==
X-Received: by 2002:a05:6a20:a12a:b0:1db:e4c3:99f0 with SMTP id adf61e73a8af0-1dc22b597c2mr1910362637.32.1731035444881;
        Thu, 07 Nov 2024 19:10:44 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aa86dsm2589816b3a.127.2024.11.07.19.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 19:10:44 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: a.hindborg@kernel.org,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	alistair.francis@wdc.com,
	rust-for-linux@vger.kernel.org,
	me@kloenk.dev,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	tmgross@umich.edu,
	linux-kernel@vger.kernel.org,
	alex.gaynor@gmail.com,
	ojeda@kernel.org,
	gary@garyguo.net
Cc: alistair23@gmail.com
Subject: [PATCH v2 04/11] rust: helpers: Remove kunit helper
Date: Fri,  8 Nov 2024 13:10:05 +1000
Message-ID: <20241108031012.335203-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108031012.335203-1-alistair.francis@wdc.com>
References: <20241108031012.335203-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we support wrap-static-fns we no longer need the custom helper.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindgen_static_functions | 2 ++
 rust/helpers/helpers.c        | 1 -
 rust/helpers/kunit.c          | 8 --------
 3 files changed, 2 insertions(+), 9 deletions(-)
 delete mode 100644 rust/helpers/kunit.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 0269efa83c61..b4032d277e72 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -9,3 +9,5 @@
 --allowlist-function ERR_PTR
 --allowlist-function IS_ERR
 --allowlist-function PTR_ERR
+
+--allowlist-function kunit_get_current_test
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index e089ecdf091f..60b3fdc5c2de 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -10,7 +10,6 @@
 #include "bug.c"
 #include "build_assert.c"
 #include "build_bug.c"
-#include "kunit.c"
 #include "mutex.c"
 #include "page.c"
 #include "rbtree.c"
diff --git a/rust/helpers/kunit.c b/rust/helpers/kunit.c
deleted file mode 100644
index b85a4d394c11..000000000000
--- a/rust/helpers/kunit.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <kunit/test-bug.h>
-
-struct kunit *rust_helper_kunit_get_current_test(void)
-{
-	return kunit_get_current_test();
-}
-- 
2.47.0


