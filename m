Return-Path: <linux-kernel+bounces-200738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B948FB436
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA871F26C84
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1225E9454;
	Tue,  4 Jun 2024 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E4O6QBD8"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ACD611B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508714; cv=none; b=LZL+OfCHiplJ6TeuaGkjlG8aYQJeooIfaxJ7+b4zS8D1Z16/LlUytRUquy1XUTkSEz30G3GevmndiygBoFNKj0u9Bz0yj+Xt/zpTXcWIocl8/FvSXCVB/v+6DKeSeqwc4BwgMpO/EXeThcTPSm3zo4rD5+MmCY4AHMuRkY2trzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508714; c=relaxed/simple;
	bh=V6baFyI7eWKSCx93YqBqSqN2+lbj/PoQOIXvInZ+K9s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Pd6aWh04OWBYL9BduBOj2AOVQKTkQIOs5s/0qSucrG6ecgh7fXRhRbpZ+07lx2H7HxpJ3frJAheitz44CDsW9Ca4WHV2DM/1zOvjFuuK92KBTKjVp8WxqvqGn/vRFFHYvMrmwTGpJsStiqv94j+td9Kg8fXDOyvAsQ+5wlqKcrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E4O6QBD8; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df7a6530373so10214835276.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717508712; x=1718113512; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ysn/x5eb/iqS/OE0/vRfAMkSS92EL4B/+sHDcpJssag=;
        b=E4O6QBD8Fg5hJwPUryzcLTGYoRYxXYc1H08Br5kDx3Jx0FELvyVv5trSRft6UHLHC+
         vhj+xIuqJ3OQ0cljP62QtoS4IOKWp1rl6AIKCfbrR+utF4q6+NJJofIoa1Ts2/fW341s
         PnFGNnUK3JcWJwe3CWR6tncFNw3x2S9lnA/0zIEvkAhlS8NyJ9zUTXEf6N7rQwMKun8R
         eCgaJLkPRFIwHOEekLqkPU2ufvH6Vt8cVX+Ytcod9Bg5k9ZjsQOvGk15eS2M8SOjM9H1
         ek19Id/MOFre7ifsN49lTb2X3k4saQ/eccEhgREtj9njtU22MUJEHQp3nokeH2BKOorL
         JE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717508712; x=1718113512;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ysn/x5eb/iqS/OE0/vRfAMkSS92EL4B/+sHDcpJssag=;
        b=j8vVdvKxnJJ0UUZwOHAqOKIZjU+iqwK8B+Or1Irjpcpqn6fWvxO+B4gXzdHQPgITjD
         Bh+STnoPYKakvn10rH4qu31GMyCFw8XfeJJ30oxZZ86stivecrxl6pALfq8UH3CUnf9t
         cAE1Qvk1LF4XdH9FJtQN0itTlJn2VG545sKxgrIJc58cRAtHkLJhosQrmeM1e2/LHuMT
         uGAxudO3cGnoJC8rCao5hK5LkX9pnhoq12qpbnY4KF/+1r3e95n3vEeUEiDWp1ad/PCW
         LZg/ABoFa8xDDcjcJm2ayTjdv9C29mLgiav+oyyRe+YdapIGDL5SNxRP0N07khUWjzfB
         c0hQ==
X-Gm-Message-State: AOJu0Yx3Qc4mVf5BP1nyvog5GnWcg3io3PLFrHdvNjxKl7ID4mNQ9C8y
	THaHVsq/2/AMDwv/FNMzgv07vgtzJE9iYgV6xclY65ckni7t2UvKHdOMU8hWWdvMCaKeD2X2NIE
	HP2746A==
X-Google-Smtp-Source: AGHT+IGE3aIMqCMl77xV5JyfEMVS9c5cPiCupVvpp4uyyh2kAJCFgsMsLDR/Zw6qdoakZuHR9ttBTAcrC2rV
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:9c:201:789f:7f5b:3f40:46c8])
 (user=dvyukov job=sendgmr) by 2002:a25:68cf:0:b0:dfa:79ab:d5b6 with SMTP id
 3f1490d57ef6-dfab8508b1bmr532613276.1.1717508711982; Tue, 04 Jun 2024
 06:45:11 -0700 (PDT)
Date: Tue,  4 Jun 2024 15:45:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <cover.1717506403.git.dvyukov@google.com>
Subject: [PATCH 0/4] KCOV fixes
From: Dmitry Vyukov <dvyukov@google.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, elver@google.com, 
	glider@google.com, nogikh@google.com, tarasmadan@google.com, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix spurious KCOV coverage from interrupts and add a test.
Ignore some additional files that lead to large amounts
of uninteresting coverage.
As a reference point, tracing a simple open system call
produces ~10K PCs with these changes instead of ~45K PCs.

Dmitry Vyukov (4):
  x86/entry: Remove unwanted instrumentation in common_interrupt()
  kcov: add interrupt handling self test
  module: Fix KCOV-ignored file name
  x86: Ignore stack unwinding in KCOV

 arch/x86/include/asm/hardirq.h  |  8 ++++++--
 arch/x86/include/asm/idtentry.h |  6 +++---
 arch/x86/kernel/Makefile        |  8 ++++++++
 kernel/kcov.c                   | 28 ++++++++++++++++++++++++++++
 kernel/module/Makefile          |  2 +-
 lib/Kconfig.debug               |  8 ++++++++
 6 files changed, 54 insertions(+), 6 deletions(-)


base-commit: 2ab79514109578fc4b6df90633d500cf281eb689
-- 
2.45.1.467.gbab1589fc0-goog


