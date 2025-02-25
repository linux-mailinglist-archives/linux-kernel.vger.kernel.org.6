Return-Path: <linux-kernel+bounces-531523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FCBA4417C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ABF416E055
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C54826FA40;
	Tue, 25 Feb 2025 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGxEevVB"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3D026AAAF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491645; cv=none; b=YMGRVHfgg+nGevliDR9HGiLtvPfHwH1Zj6U3+nYS3o01FE1rNadTPhlj99xSYj6Ye0iDPNziOD53u4USP9jQL3XEIdccNYyTEl6ZPk+VW0sOttDxffKttvbymBNAmhk+Ikb9XFb5LQaDBjCjHfKTJaVsJnDE7PJnAUiQ9TEVUqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491645; c=relaxed/simple;
	bh=7T+woGzLt/Dv7H8qjIXUZwcKiN3Lqtq8hr6b5QK6/L0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mo3hC1/MbEGoX+wk1qbd5np6owAgAwVhRmRMJPmdpeRYiKCFOWmcrMo0yGXBby/vL3LOaKSlKzzA015rPGuyR2+lwg/kVOVvPjILmrr2hEqV1fAQTrUIEbw3ttEEGOVQmNn4CK3pNr5KvU6RUr5hfD1lsbEq6bOaPZCgJqxqgQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nGxEevVB; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5df498f31ccso6219048a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740491642; x=1741096442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rRu6yyYSzh917fLY2aJ+R7v2o4C7OnB3uc3vDaSHhDU=;
        b=nGxEevVB246OEifrrlDBHH2kj1JgPnMz3izYijs/DD5cKTHgRqR12RBGBvMsI6Wz1Q
         I7qmkc2m9hDcDx9UB21bjlmBddo/E33Is+Y7oBkXiCUDi+KJeoUji9jLyU1VlvXzXjaK
         UQNsXKlc2UcPgzBmD+3bF6kXe1BoZ9TtsaJcZg/5b0w20Q4DagodD6y62QoSwFCW0AnW
         cYIjovg4I6KHbvRNlBOabkQkUR2FBTLrrcT7gbpY5cczSwY5VDu7kPfR2zgnGf/uRgiX
         bvmtKavKEHVcyWEgKIHMkQN8Z7/lbT/FwjnukqkBpoDENoi0/ypnRuIEzFxV++5Iq8Ck
         VVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740491642; x=1741096442;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rRu6yyYSzh917fLY2aJ+R7v2o4C7OnB3uc3vDaSHhDU=;
        b=NomLKbgCWJHZ0RLh65TZ0s2hkqCBxaRbsEob0kwnK90XidyGfnoviezVXZF7gSD9/L
         x4qRDcX1fFqZK9iqX0Sa+/CYiI4J8vbP/PA2IyV+CmbWYAx6AJG2PDOkv+DxSpbHQm3O
         6Cshj/sfXeK10C9a7/gp+dQfyZ6E2/e25/+oqQZ68YO62Pbc+z4EDIg6vrxFzK9+OZ3f
         xvZ4CyOui5aiqv7nXw0uN4PzMfjAmkxmalSP6ycnhOmNgqo+uy2aTztObsYb06Cpi/kQ
         f325y+DOwv11oRaDUXC6szijwCTNkbou4B6dDipzuFpB48XkupJi+/GrixvE527AEbX9
         rDSg==
X-Forwarded-Encrypted: i=1; AJvYcCWn8JZBP3L4lfnoKFSMD63nMIG2pnzjGns7grbKhstBJjuY0kzfp7inv2VyHGa+aYUDolR9Ci6zxy+KCPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo1p1ikhPvMumgV8LNctxbZwPbsE2tzGW3YTRiP6LsKdMweBf6
	9XBfvdXWH89McoD6SyLr0yJrvi6SH4Ry0mPBimVIdFLyyVPmTYbs5j0FK2fIGDMAsOx2W+1XyNe
	hxY+BpQ==
X-Google-Smtp-Source: AGHT+IEDITYRYzNpXEF0E49ruJ89SeBOs3d9GOHmcVGxOQS0ID8RBHnr9ungUCVtCuj3RBnyfqZjrPFafwNt
X-Received: from edc8.prod.google.com ([2002:a05:6402:4608:b0:5e0:5324:1331])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:2347:b0:5e0:8064:b42e
 with SMTP id 4fb4d7f45d1cf-5e0b7223106mr17105321a12.25.1740491642547; Tue, 25
 Feb 2025 05:54:02 -0800 (PST)
Date: Tue, 25 Feb 2025 14:53:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <cover.1740491413.git.dvyukov@google.com>
Subject: [PATCH v5 0/4] rseq: Make rseq work with protection keys
From: Dmitry Vyukov <dvyukov@google.com>
To: mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com, 
	elver@google.com
Cc: Dmitry Vyukov <dvyukov@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If an application registers rseq, and ever switches to another pkey
protection (such that the rseq becomes inaccessible), then any
context switch will cause failure in __rseq_handle_notify_resume()
attempting to read/write struct rseq and/or rseq_cs. Since context
switches are asynchronous and are outside of the application control
(not part of the restricted code scope), temporarily enable access
to 0 (default) PKEY to read/write rseq/rseq_cs.
0 is the only PKEY supported for rseq for now.
Theoretically other PKEYs can be supported, but it's unclear
how/if that can work. So for now we don't support that to simplify
code.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org

Dmitry Vyukov (4):
  pkeys: add API to switch to permissive/zero pkey register
  x86/signal: Use write_permissive_pkey_val() helper
  rseq: Make rseq work with protection keys
  selftests/rseq: Add test for rseq+pkeys

 arch/x86/Kconfig                         |  1 +
 arch/x86/include/asm/pkeys.h             | 30 ++++++++
 arch/x86/include/asm/pkru.h              | 10 ++-
 arch/x86/kernel/signal.c                 |  6 +-
 include/linux/pkeys.h                    | 31 ++++++++
 kernel/rseq.c                            | 11 +++
 mm/Kconfig                               |  2 +
 tools/testing/selftests/rseq/Makefile    |  2 +-
 tools/testing/selftests/rseq/pkey_test.c | 98 ++++++++++++++++++++++++
 tools/testing/selftests/rseq/rseq.h      |  1 +
 10 files changed, 184 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/pkey_test.c


base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
-- 
2.48.1.658.g4767266eb4-goog


