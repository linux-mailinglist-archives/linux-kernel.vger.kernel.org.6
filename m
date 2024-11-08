Return-Path: <linux-kernel+bounces-400961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEFF9C1474
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1A82855FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7325F19415E;
	Fri,  8 Nov 2024 03:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDm2s+mq"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D9884A4E;
	Fri,  8 Nov 2024 03:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731035457; cv=none; b=DBOL6euk88tU9TzcZo7RATRYeoaEn6mF0T52cvq3wINUHP4zg5PkCUvLC2FoprXg7DowFNZRIMWl5+BEiAuigUKvvnzxYxXyuWzyPKhA0Prq3LGyZRG9rPRUEnSo8pvcOHvU7MwghabzP+5GNP6qLJrLVjdY2d5TOcgSQ8VaUEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731035457; c=relaxed/simple;
	bh=XHU8/ODWMZ1NjzgXc7i9MMFi/+BqzU5+MPyr7GxXJq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmDjXutbOuHRnwpLAO3zubjOE1ASBtaZ80i03bTJkZVeCtBU4XkIvzQ3rq3CwPxA4x3KRFqKeMmmDpnkYpqYdKy3eubI8F5aaJ0gRLn04RFOiyFuUF/9drfKPP3A4PsHV40O2th7RI7cU0qEf2+4KCL98k2n0IR7CR8Ws/n3VzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDm2s+mq; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so1332069b3a.1;
        Thu, 07 Nov 2024 19:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731035456; x=1731640256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7W810QjWHqZypyHcMoY3+O2exDYtcEpIPUCTDvnWNXc=;
        b=CDm2s+mqQ7lasP7rLuJr33ZIkVE8zFRlWdCfCn24p/8Mx2Zxb8zEB/POwQUjnjvH0M
         m/7GIla2zC0lTKyVNcg8PvSqzp7a6lY9KtP3sbukWo7H5VfdR2W68JqybKSWWUQxnGRi
         j77VE6bQgMCwKHJxBSZB/5loix14b5PBG9lsT+2MDax60u+JfNw5h1xDbNnt419ItZDy
         AOVNqYYqdMzh0O75AH+GlVqyXvMyuoJR2tV2MCGLfy4vL9yS1vQ+B+N6HoCyj2IWKaGz
         0I6CEDcG+coo9wtye8zaQSJOvCSo96uh9nEFMI2yrxXXdgzjmFEkT04kjg3rNWmIuZZ5
         tfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731035456; x=1731640256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7W810QjWHqZypyHcMoY3+O2exDYtcEpIPUCTDvnWNXc=;
        b=IZT5leQ+eGjE0kiq4/S/KKdocZuyUfdefpj82Jh2UyGj+zNw2kg+YQuEDaCE8TUzPi
         lQI5N4c7t+w7tGEbEggW3o02R/Oq4X2ptA61OgLZFrvLivwAGIqTnqYI+HAyk1O8Pjpx
         yxqBHZXUgDOp+Kc5r056Q0Q7mktsOybH0ZTue6QkoOdpQKBdZk03hCWQ6T0S1/uZAZcM
         cY/S632C+KHgdtiNXzmTPpRow7HIHs+CXiTKPRUSlypcZXCk3HAzZkg7K//YF7k8NKco
         Qo0CCJuVkhFQkRCgo7x5xoKvMnwNcOTCRwTSgyrFhKhkCw5i8fVPb8cTVTtgoxBCkGeZ
         Momg==
X-Forwarded-Encrypted: i=1; AJvYcCVtS6aHKY2TkIKGu8k0cYUE6sB6itn2ZG6OGNhRTsXLcn6/yhylIJ/Gw+DMktWBTUmfRT2iJc07aQNzWzbtR7k=@vger.kernel.org, AJvYcCXV/pkRQIIf2RupnxIIZqZhsumQv7RGs7E+CyCbqcUmtx7DgaEmtrwS4ZBAZNIh22MRCMQsCGMFAlP1Uew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6C0lCNblFc0cAHkJJHMOrqxXVkLXbQOJHiMP+HFwrkrXkVhg6
	uXHVR5tBt0TRgxJbx7hU7G1kdssraVbTSxohXa20rieEaaWaoV35
X-Google-Smtp-Source: AGHT+IFKkh3pnwbDvEmRTuULYMe19zxAg+Z+o+UL6MzTj7bwWrPblcUCQr5KQqGXafEiUkiOOHMNIw==
X-Received: by 2002:a05:6a00:6caa:b0:71e:427a:68de with SMTP id d2e1a72fcca58-72413382fe6mr2090283b3a.24.1731035455806;
        Thu, 07 Nov 2024 19:10:55 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aa86dsm2589816b3a.127.2024.11.07.19.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 19:10:55 -0800 (PST)
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
Subject: [PATCH v2 06/11] rust: helpers: Remove rbtree helper
Date: Fri,  8 Nov 2024 13:10:07 +1000
Message-ID: <20241108031012.335203-7-alistair.francis@wdc.com>
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
 rust/helpers/rbtree.c           | 9 ---------
 4 files changed, 3 insertions(+), 10 deletions(-)
 delete mode 100644 rust/helpers/rbtree.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index ded5b816f304..e464dc1f5682 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -13,3 +13,5 @@
 --allowlist-function kunit_get_current_test
 
 --allowlist-function kmap_local_page
+
+--allowlist-function rb_link_node
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 791172b0ddeb..2914bfba6bdf 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -17,6 +17,7 @@
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
+#include <linux/rbtree.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 60b3fdc5c2de..39adea78a647 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -12,7 +12,6 @@
 #include "build_bug.c"
 #include "mutex.c"
 #include "page.c"
-#include "rbtree.c"
 #include "refcount.c"
 #include "signal.c"
 #include "slab.c"
diff --git a/rust/helpers/rbtree.c b/rust/helpers/rbtree.c
deleted file mode 100644
index 6d404b84a9b5..000000000000
--- a/rust/helpers/rbtree.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/rbtree.h>
-
-void rust_helper_rb_link_node(struct rb_node *node, struct rb_node *parent,
-			      struct rb_node **rb_link)
-{
-	rb_link_node(node, parent, rb_link);
-}
-- 
2.47.0


