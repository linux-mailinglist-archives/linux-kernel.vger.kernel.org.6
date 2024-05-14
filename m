Return-Path: <linux-kernel+bounces-179237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302858C5DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 00:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85191F22728
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFFB182C84;
	Tue, 14 May 2024 22:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vwFFVZNp"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5238D181D08
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715726799; cv=none; b=T+vsBjWhJAIdAGU6IdfKU2DSLJlDGTeJXRoKEgZp4DwC4gugLC2zvBOScpt3PcKcgBx0kg7BA9NdFomfMxhRXIbuRcavIHZqVzSjlGt/r3hUqwd9i4303+MtIYztAjgyMPyg6joBS846FCFyC9RxsdFRiFLR8uja4Gk3191okDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715726799; c=relaxed/simple;
	bh=aAYVOEV+rUoRQ++ZhGlIi98s2QA8IsgUrzjBcW8dEIA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uey0RWoB0nb7A+jtczpp/5prK1yaJ2iA9WN+Gtot3LsQjsUvmzTjoby/FQrCTWSHxfSyIxHkHlHVH4pv99D4LkpO+nY/HVwobYPk/q+3dKOyTHILLNB2J1Pse9lNuljDYLy91olVwyZGMCrTnJSWBq6nhXGfhKiAZrmKkUn6Ogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vwFFVZNp; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be25000a4so118218607b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715726797; x=1716331597; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r09sNlqyfMtvZsX2rZ+OdLweqNYAcheUEw4dxFcOJ6w=;
        b=vwFFVZNp76KJcq26kjEH9ZGtE3rrdB1qpkQMlOv9xW5LcWNKsKexz2Mn9nqLNUp6kQ
         XpP3c7kO60VvyBcBxAe2AuQdbH9YbtgPxBgm8/oJYonq2AyMCvj5/pd5EUZQ9+YqtH4H
         H1Yte/UtGRwUaYNfIiDCpXQi6TCKe8K0uOwQOAZjno8LJMjW/mMlG7qWxlnaOpbGtU/F
         Z1fYpN8i8i/BwtiPQbaOkaaekhzLZ+q2deJ5o218HgIQUe1YREbZnGMPShVNO52/peJG
         GMkmQJDPGtNYWfgQpIrx3bw4OLpQxy0Y/nhDFJ48EhbZHYjx7tR25XoY2GB2VFDlh7kn
         r9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715726797; x=1716331597;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r09sNlqyfMtvZsX2rZ+OdLweqNYAcheUEw4dxFcOJ6w=;
        b=rR8m3XjlSddVjmv14CcDtLV4d3DB3IMV5fZA0lLC8MLiRJeLJuwcbo8pMP2UJX0sJA
         rKr/l2VxrWWJcXqlUK2xvS2uOK8QwGoAqNK0Z7RYp/FkPuVLbmACggn9GzZYeGiQNvt7
         RS+YQiIYsY7U+VrqCyHQlgs4fnvPA95Mlm3EovCXdd2UkbBg597uJ+SOLyFdKICzm6x8
         dXxl3v/HofA00wGXainxzoBci3+FHz0EcCtW8ea0F6O9E4geNVWBKJvEvVG0U1F327j5
         CG+rKVUgIrnyAVaaylIHRlc5h361KuNHEjclnl9fXLpXnkyC9r5gSD/LQc8YOIS79XGE
         iYVw==
X-Gm-Message-State: AOJu0YwWIvoaQNg1JwjL208PD3f7DAt2lyEvekBWkcLZFvFDfe5DdfO4
	TQIt3pidWJmxlBzUBTXbXW4xTz0aBBnoO+qmHjkEpSvFSFm87j+HcPKNBMKXXdGEu07YJqyxff3
	EM/FWRYcing==
X-Google-Smtp-Source: AGHT+IEgwEh4FRIW62GfVaIxkCCTMMoQRrAiBVPp3ojlCpnrOENNsyILNjVksqXCK51brnnELH5RirP8hwLuww==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6902:2b0d:b0:dd9:1702:4837 with SMTP
 id 3f1490d57ef6-dee4f2c6b6dmr3521458276.3.1715726797280; Tue, 14 May 2024
 15:46:37 -0700 (PDT)
Date: Tue, 14 May 2024 22:46:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240514224625.3280818-1-cmllamas@google.com>
Subject: [PATCH] locking/atomic: fix trivial typo in comment
From: Carlos Llamas <cmllamas@google.com>
To: Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Kees Cook <keescook@chromium.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Carlos Llamas <cmllamas@google.com>, Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

For atomic_sub_and_test() the @i parameter is the value to subtract, not
add. Fix the kerneldoc comment accordingly.

Fixes: ad8110706f38 ("locking/atomic: scripts: generate kerneldoc comments")
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 include/linux/atomic/atomic-instrumented.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
index debd487fe971..12b558c05384 100644
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -1349,7 +1349,7 @@ atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 
 /**
  * atomic_sub_and_test() - atomic subtract and test if zero with full ordering
- * @i: int value to add
+ * @i: int value to subtract
  * @v: pointer to atomic_t
  *
  * Atomically updates @v to (@v - @i) with full ordering.
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


