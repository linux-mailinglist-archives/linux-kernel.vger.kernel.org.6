Return-Path: <linux-kernel+bounces-400965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECFB9C1478
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD8A1F230A5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63C81991D3;
	Fri,  8 Nov 2024 03:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa3ZGQpT"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70A113A24A;
	Fri,  8 Nov 2024 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731035480; cv=none; b=SgxTtkLhfC2J4TzlXPVJ+aLdgD35+IdhdVvxoAgM2eJaHICeiLwZLgkbgyXz1RRGph+9smol1hCFQKUlU2R4tKqlsTCs26nPwNBuVyfEwwIuPhkt6/UFoHLnekhyBmzJC6wdPjseO0eN/cen5A6fgQd3fvORHILf0iYFmKggrNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731035480; c=relaxed/simple;
	bh=SO0ihzkyb/8u5w8iQc3Yi8QNQKkH80XypPcmX383Vsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muoFhX8WUd9bRkworaxu46knpdJqr63m2Tn8mdZczq19YBVaSKsRNMZCohXq2trL/L3JSfCUOpLDW/2I6cQoZT4xmt+zN578krwgqrP0nn202GRWpaLY2nn2t/QX9VQFAPr5SS0mru2LZWbMmYqZF1a/ut0w9OmZGMB/VcBg2Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aa3ZGQpT; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so1228755a12.2;
        Thu, 07 Nov 2024 19:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731035478; x=1731640278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuJaxUrBc7TRYuZFnJWfuScCYx5fEJD+n5myQuS5ElU=;
        b=Aa3ZGQpTWc+ytSA8FU0Ms2f1++twf4jI7+FE6FLGOX/9H8z+eEEcyS5LbgHfTzAbNJ
         b2uyRQ/w0MNDlUqDxsIIQfJooNelu/EbhDOwPKo0/JS/6Bk1s8kaof8+v+z3717DzjQZ
         iGbP5W9vVWCLUIi9OKUjwMOXoSHB7Mtu46e2qZ8BdkuBjz/TWBOxnCDlXLWiwP2mobGA
         7SlpSzxywf0rtU0J6zlDGvuZsBIYmVzeiz/g+Kp2wPi7wYVBwdtY17xiTeEj85m498sY
         iRfDQlNIJduH1xQM4A64XLiLLaj3gxbaZ1WkUHGcawjmZtRwgU/VNU2otjKS5fY/G2Ih
         be6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731035478; x=1731640278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuJaxUrBc7TRYuZFnJWfuScCYx5fEJD+n5myQuS5ElU=;
        b=U8ihCGR3x+zysFuUuYL6QkxxU63yFA3nMw3DasCAiNmVsXmdoEt+/O7TB1+W1YcyGx
         bnCzFL1h3fF6Qn5RZlxw7ZexSVLDW8jUbhr/bb1W1ZCxduuRaY+Vva1rAq5Cvkm0rTJU
         vLwPbxvhc1p79uqu7BdxVYPlD5n3FVotYxgGH7q2v0VbYZeMrHTC0rwJwUrDsyl5ezKk
         VbUyKEUdRcIhPrE3yBzGEDso8IEkUCx5tKRUtIG9YbV6TKDXvOcQ6KfwQPOcOehLcxwK
         SEa7JDJzF8kLcJ9uUQIQHo3woQvDHvBelnAH1sDYhmZC3zu4fZ2ATC7r89hiqxCb2Atv
         CI6g==
X-Forwarded-Encrypted: i=1; AJvYcCXDBDtxiRYO13Wbo+eIxp7scFhAu8uPMfrLILXQ+L8cqMfSg5wTDSXh8zw8X2gXxHeRxxyl3dbGNdmbVAE=@vger.kernel.org, AJvYcCXR7mIUhKZu6GPSDzDJCpFmREXz1H72Ha/gHKqY2FL9pCR8nWw620dU+kkaMaO5Zzx516u8kPq8Adl9BIaI34w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiyRXFKBoi2jzzjTd7UX/2xgUbW5TLRrtiYfAOfap553TgOVjJ
	fZrou7SqcazIFSO9toqXHtqTRX0+Xtfx18jIGfH96YKQT1ehXAT0
X-Google-Smtp-Source: AGHT+IGgC+6I7Emn1GjiFWxF10vSSuDCH8uOSU2KcXANEDn34Q3cV0UJql0OiWOnDN/V3SkB+T7hpQ==
X-Received: by 2002:a05:6a21:3418:b0:1d9:261c:5943 with SMTP id adf61e73a8af0-1dc2296b919mr1723644637.10.1731035478006;
        Thu, 07 Nov 2024 19:11:18 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aa86dsm2589816b3a.127.2024.11.07.19.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 19:11:17 -0800 (PST)
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
Subject: [PATCH v2 10/11] rust: helpers: Remove some task helpers
Date: Fri,  8 Nov 2024 13:10:11 +1000
Message-ID: <20241108031012.335203-11-alistair.francis@wdc.com>
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

Now that we support wrap-static-fns we no longer need the custom helpers.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindgen_static_functions   |  3 +++
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/task.c             | 10 ----------
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 9d6c44e277b5..8bc291a7a799 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -24,3 +24,6 @@
 --allowlist-function spin_lock
 --allowlist-function spin_unlock
 --allowlist-function spin_trylock
+
+--allowlist-function get_task_struct
+--allowlist-function put_task_struct
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ec26d18c5d88..eec195a21fb8 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -21,6 +21,7 @@
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/sched/signal.h>
+#include <linux/sched/task.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
diff --git a/rust/helpers/task.c b/rust/helpers/task.c
index 190fdb2c8e2f..788865464134 100644
--- a/rust/helpers/task.c
+++ b/rust/helpers/task.c
@@ -6,13 +6,3 @@ struct task_struct *rust_helper_get_current(void)
 {
 	return current;
 }
-
-void rust_helper_get_task_struct(struct task_struct *t)
-{
-	get_task_struct(t);
-}
-
-void rust_helper_put_task_struct(struct task_struct *t)
-{
-	put_task_struct(t);
-}
-- 
2.47.0


