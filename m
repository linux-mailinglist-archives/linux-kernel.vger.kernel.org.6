Return-Path: <linux-kernel+bounces-349589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E0298F8BF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77C47B215E9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED8C1AD3E5;
	Thu,  3 Oct 2024 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3cKKd8VO"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017151A0708
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990248; cv=none; b=at5u7b/kndFS6pbrf2rgFvIY5J9+j6DHH6RAp0Vn3B4b0mOriMVyMmlP7PMBO/3oumbGrBE1XQOKb41lFpDIZu7NjM4VCNcG9e/utfzTVpk71/yJYIgcpPB7BmbkFjUCwxDb4/jgZwyRlrF4K/5vm1TefxaEk7dKB+ELy2QGTv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990248; c=relaxed/simple;
	bh=5CxlFKBNAnY0L5cms+ig50SKqjgs7CYRL21hDw0X7ec=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iLHZAGAIBHayGJFZGyD5d4+rGeyTGreDT2/efT7k/wpgZ+hh3+jJy9pr8Z/uQtjsbaovCy0AsgwrEdePn5DehErYpTg9Wydy9nEubUB+RrxuK3ymiqv/Gc/2b5jdqwNn1LFAj7oLTwHKXO20z59ljOKTcbTS4dy6X/0i92Z2v00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3cKKd8VO; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7e6c40a5795so833820a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727990246; x=1728595046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UcHV8WURcnYuTep7jYDWQX5sxa0kfFCRTwwcajmItvQ=;
        b=3cKKd8VOZOl5qCUCnhamcDI9ihqDnDqEsrPVaJktdB8tnIMJbrzROxNsf14bon6t3s
         XsbDshKOVW8IAdFePMozQE61e2uElWxbGBUTkjAtnTDNBiW9PSVYdQJ8FtDZHbWafRMm
         S1GXn+oiwCS24i4shsrjZnVzXU24kSvwrQ9XUcRtXNRchITJ6RSmHDLZUhHEwZfl/zyl
         5I//Su7jz+tKRTQlcreCT7HSAiQzVr56a1ePhPS29moRQ0b7tIodg2/yEJlL34YqCp5n
         fq2nqiWzYK3r6SbiZYErVTon5qP1tPjKHE1Cu9zpyfwoi1ZWqIWUmntRVuV4hEAuUm4d
         pMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727990246; x=1728595046;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UcHV8WURcnYuTep7jYDWQX5sxa0kfFCRTwwcajmItvQ=;
        b=S1NkAh2K4xeT2z6Mrm6rKXhW/EM3Rb23sKLfbl8lY347j5NC4n4DZVZjkgLxOBIrpQ
         1X2Qn3OsfaUISyY/ZTfRa5dJo2Gkhi1gCNnwjWQ2Cdae7vWxWi6885bNaOuTK204VbHb
         U6/EQinWkt+H6S/svfbrXEZM9+Pt7/5xhQkZYOA+WrZypjPMuzFqZ7YKVRkd8uZ4EN1z
         5Me+wGSy0yByiQTdAi5rAHTx6n0vFj8WZfAO4Y5OMzSP1qs9jRSGF0AhKNC9mhu7Z7oE
         rme0T2bu1knG23ZeI9K581yoxo62ckS85FYzLzdDBfbLlu9dg58BwPmYtxT053slhGiO
         1ewQ==
X-Gm-Message-State: AOJu0Yxr5rfbpJbZBLjtCBNBEkIpbDZ2jj1cWRwxptu7m+LSHhIL4Pl0
	70I0qn8pCaK5saFuAsk/xVhWbE4PF6acxxdKehHYDjwS7JOiVeRxiNzkKTeSDWYOBRkfaRi6wFJ
	JZw==
X-Google-Smtp-Source: AGHT+IG5hVqNff98quNB5O4IO0Yjm/qlW0YAQSi7ApmuRiktThVtGG3FOUNL8wWJTpELBRqtrcCttJhelDY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:fc1d:0:b0:7cd:8b5f:2567 with SMTP id
 41be03b00d2f7-7e9e59bb2ccmr1656a12.4.1727990245571; Thu, 03 Oct 2024 14:17:25
 -0700 (PDT)
Date: Thu,  3 Oct 2024 21:17:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241003211716.371786-1-edliaw@google.com>
Subject: [PATCH 0/2] selftests/mm: fix deadlock after pthread_create
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Lokesh Gidra <lokeshgidra@google.com>, 
	Edward Liaw <edliaw@google.com>, Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Android arm, pthread_create followed by a fork caused a deadlock in
the case where the fork required work to be completed by the created
thread.

Updated the synchronization primitive to use pthread_barrier instead of
atomic_bool.

Applied the same fix to the wp-fork-with-event test.

Edward Liaw (2):
  selftests/mm: replace atomic_bool with pthread_barrier_t
  selftests/mm: fix deadlock for fork after pthread_create on ARM

 tools/testing/selftests/mm/uffd-common.c     |  5 +++--
 tools/testing/selftests/mm/uffd-common.h     |  3 +--
 tools/testing/selftests/mm/uffd-unit-tests.c | 21 ++++++++++++++------
 3 files changed, 19 insertions(+), 10 deletions(-)

--
2.46.1.824.gd892dcdcdd-goog


