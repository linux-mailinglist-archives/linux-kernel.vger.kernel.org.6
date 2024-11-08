Return-Path: <linux-kernel+bounces-400963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A17439C1476
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599A31F22838
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D42196C67;
	Fri,  8 Nov 2024 03:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeiPRGlY"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EC2126BF7;
	Fri,  8 Nov 2024 03:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731035469; cv=none; b=SwPXxwQ+f521cXj9wt/lZ1/CLrF8+zwVNY7qj0ezIUPe/6pWlG0YZc4FPdP+A8Pb8s+05Em9aN7lRjTrnkB8533VI0tVxhZ2CgOF25ElB9EwI+NcpkBBtuwe71BFuVnlbWAr1V1YNqX04jdYxmDC8zK+oVZFNIEK03wCHZQirnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731035469; c=relaxed/simple;
	bh=npe1jkvpMh4HvUoyz7ySyGRM6GfvyvBo4NnMRHnU2YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kavh1gmjeBEJbpryD28w8I+Xp1uR/+vYd6bkgd/P5nOE0FRIWaChzJX4Tx1xpfSPg7Au9q3QDGh8LLv2shXz/pZ+PMCiF2RejG3QyQ5VhKu1eG8ZFykwqgM8Mk7oomO7I62gppMUi9J5tXwQXazXUJ+aOF0OD0itMaCTN+99/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeiPRGlY; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7240fa50694so754302b3a.1;
        Thu, 07 Nov 2024 19:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731035467; x=1731640267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DI3J7NX+EFeBQ3/CmP6MkbNoUruh4iSKST6ssLs0YN8=;
        b=eeiPRGlYJcuAPqRsDA5/nmucK6yI7CrBrfDg279m+wciVix612nK39GekMQjJzG/Om
         VmROtR+VMlMrtxIvNdfuTWSNTfqOfv0y6ZzwZWT3mDQ/Lwk8HmG1d7wOUDr//v8uCg8p
         4wwdJfFiX7hdOHWrJraMQbDji+bfsjV9lEqqnJt+FTsfeuU0nng0+I1DTrOzeJPCcQtd
         g/7J27+FzEBXZUoJmuqTDsMMqjZs+yyNzq8ll1aW0IzyrPuFfgVyr2y4G5Ias3JyuDI3
         8oJJQlG/H8tgV7UHjAow7njV/zbKgWGqehtjW12sQDJq/zh30SWsEInSdohE2rLHJlyV
         x7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731035467; x=1731640267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DI3J7NX+EFeBQ3/CmP6MkbNoUruh4iSKST6ssLs0YN8=;
        b=o2+wbIiJc7Z704aOLuAaGJVgsk9KbPacB4ITwARzSVkV3cvR5ySO2uHLRcXkvzcjBv
         gNZOYUcoKEEKDTieSJMrWgTjso5wZC8TU0McAxYsWvCDd3LX2x6SfqNJVdPPl6LLbsaB
         yjcHumZfMbW+vWbsopBXTj21dz6LBo74uVf/M9k3oq7+zUSC29bwlz1qxXtcFkBCEiAo
         E78u9KtYXsaWxQPFzQR8sztVNKwHmG26EpG+Wmdv9krX1mZJw2sfa9LNsVeXacgE1SRr
         sXGWV91A1XQmgBTuOeuCT1BSlngB/vLH8eYZX3UHxOyJswMK1UrDNkKzzgJEvL6Tzfmi
         2iNA==
X-Forwarded-Encrypted: i=1; AJvYcCVnkdfYNjiXhVA/L8Q6528lcvGbOWiUS+G4oGgGHEUNmBfv36XgNy0tGPzINXI7urqj5CMS9ETn47jwXB8=@vger.kernel.org, AJvYcCXs2hV2IlFJlASTwkQBvh28wiEbNf0KgNEoX4NqdoyI9NDTeHbAx6DdQWxZc1js9B3rSKLcOEkQmPoqYgicqzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMWm/oxO6L3ipA5lUan9l3eYO/Dho11Zbzv6H6KHbMK5T2NrAn
	GMiWFc+1XQrBx/JrIarZTMtrzQ6LXsBHWmVQrbifMEfqLASMHFXWzduakV8u
X-Google-Smtp-Source: AGHT+IGq0+KeV64pPCqGG4gyGcqgysk3OwC/+7hJH+IcSmZWeZVVC2NAob+dfX8a9+fxohkQUY5PQg==
X-Received: by 2002:a05:6a20:3d89:b0:1db:d9fe:c442 with SMTP id adf61e73a8af0-1dc229df6c2mr1674477637.23.1731035466928;
        Thu, 07 Nov 2024 19:11:06 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aa86dsm2589816b3a.127.2024.11.07.19.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 19:11:06 -0800 (PST)
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
Subject: [PATCH v2 08/11] rust: helpers: Remove signal helper
Date: Fri,  8 Nov 2024 13:10:09 +1000
Message-ID: <20241108031012.335203-9-alistair.francis@wdc.com>
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
 rust/bindgen_static_functions   | 2 ++
 rust/bindings/bindings_helper.h | 1 +
 rust/helpers/helpers.c          | 1 -
 rust/helpers/signal.c           | 8 --------
 4 files changed, 3 insertions(+), 9 deletions(-)
 delete mode 100644 rust/helpers/signal.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 9c40a867a64d..407dd091ddec 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -18,3 +18,5 @@
 
 --allowlist-function refcount_inc
 --allowlist-function refcount_dec_and_test
+
+--allowlist-function signal_pending
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 2914bfba6bdf..ec26d18c5d88 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -20,6 +20,7 @@
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
+#include <linux/sched/signal.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 39adea78a647..ebe3a85c7210 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -13,7 +13,6 @@
 #include "mutex.c"
 #include "page.c"
 #include "refcount.c"
-#include "signal.c"
 #include "slab.c"
 #include "spinlock.c"
 #include "task.c"
diff --git a/rust/helpers/signal.c b/rust/helpers/signal.c
deleted file mode 100644
index 1a6bbe9438e2..000000000000
--- a/rust/helpers/signal.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/sched/signal.h>
-
-int rust_helper_signal_pending(struct task_struct *t)
-{
-	return signal_pending(t);
-}
-- 
2.47.0


