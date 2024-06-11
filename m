Return-Path: <linux-kernel+bounces-209417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E63FD903451
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B2B1C216A1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68515172798;
	Tue, 11 Jun 2024 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ydZZW2oR"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27425130ADA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092243; cv=none; b=CYNErD/7cTrOrZ9JKEJQ0jF0sxDdc4bCvuJ7UNF3PWke49hD+WSvpxZ7EXCDmPLuKYRs4We5aW6ERlH3SuoI6635hK8lG+Ope3w1HSGNcfxhEw5V1XFQ/vCJUkHIUtkTj39YxDeZirSRsMybNphyyHO+ko9Bsbt/sLfM7oM0vto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092243; c=relaxed/simple;
	bh=9kS5Uofgz9pE3ajhh7ZndiNreDJxiZdrDGSyL6Ts7Ns=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=d+lqGwKU5RhIXvVu/yXuGpr4QrSeqY6db/sfnMU/pQSHUf2hHDILJUkmpJBDvGTti8HsC9bI8cM0H/8BBL2qOalH2eeBoTPkJKBmeoKY11gfQ3sHszeQUv+JXSlj5wbfL+Lf4a+y54yrOLFLXCUqc3O2b5XUOy8PoVLIjF2Tdgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ydZZW2oR; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-57c6979daf7so415911a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 00:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718092240; x=1718697040; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sOJq0SNxfCF/3ET8RSl5nDiW02JEujt8+S8ncUXlnV4=;
        b=ydZZW2oRuNtgK4DDQtBX78Rw0Tbs5ZP+Lf9AM0//BahFo7Id76VUEjs8MIgwykTozD
         esjDAfSiAoHzBTsZsabVAG3PhWz+PQ2DIqtUJrTUwEmcOHoR3VFaARrrmaTI0s41Dsah
         Uhuy91L4GfxDynUK+I1GE2jtDTOvUDry1W6CFRgsRo9PWiVphcaZRG/HYCpPqVZ2SgX+
         ZxyTJb1DpL8Qy9FDItZ9pu9H8pRH+kNEtck1WlOj43BP/KG6xADhnqtVjXh3v46JpEHB
         sYKGn/Qk2QepnSdDgxVnXw0a+wOIC1iP50ZMJcPRNszh599mEzqZ+drok7mAC+98gerT
         R4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718092240; x=1718697040;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sOJq0SNxfCF/3ET8RSl5nDiW02JEujt8+S8ncUXlnV4=;
        b=i0KgaFekwjsVvjYLmqvko13jbpxvo+O9O73fbn4xKLlc/F/qsjTCUWGaAigFjzfwnD
         5C56PutLJfyrQXSWUkd32HgyxSy+N3TZcEDEIsmAdQGcxHUHhVkWUnaXQD3o24JTX+UT
         kwUlPYD7MqC/ReusXuZK5EUrA4uzE3nhKh9vC9rRSgAt8Tn/fCa/AEhyVgbOjPq4/9Tv
         k1wysZwvAi5X9pOkRPRlcTSwbi4BEbTI9EB0a/YE/H8471a5xyNkCbexmbPyMSW5ZSwR
         aroVcH6rTbmY4RbNkjv4JrAuDI7TIfRMIV56DrsoGHFUW8TuUTXkWcHp3b8lNJO1FQfU
         I+lA==
X-Gm-Message-State: AOJu0Yx1zCYkrtG7D1/WMhw8deehk4SAZhynOU6PzEMIh8aXDRFahtnY
	hlJLZMdRfpo0xdkRoi4tVGHwStIP4AaUTIf6rej4Jb838PGKL968Sg4k8dwF5hY+ezhsF8ltuZp
	v6Tgyhg==
X-Google-Smtp-Source: AGHT+IErv6rLmt4s+gZnrQEdHCzuqotk0DcGGpQ1w+M3MZRAjUH6t0BNbskn5HJq98usgW4q46tMyDMXwWPd
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:9c:201:ecf:76a8:5d44:6e8b])
 (user=dvyukov job=sendgmr) by 2002:a05:6402:548c:b0:57a:8b21:a587 with SMTP
 id 4fb4d7f45d1cf-57c506bfe91mr13190a12.0.1718092240035; Tue, 11 Jun 2024
 00:50:40 -0700 (PDT)
Date: Tue, 11 Jun 2024 09:50:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <cover.1718092070.git.dvyukov@google.com>
Subject: [PATCH v2 0/4] KCOV fixes
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
 kernel/kcov.c                   | 31 +++++++++++++++++++++++++++++++
 kernel/module/Makefile          |  2 +-
 lib/Kconfig.debug               |  8 ++++++++
 6 files changed, 57 insertions(+), 6 deletions(-)


base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
-- 
2.45.2.505.gda0bf45e8d-goog


