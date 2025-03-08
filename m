Return-Path: <linux-kernel+bounces-552294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268B4A57807
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 04:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F50D3B641E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 03:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4374214A0A8;
	Sat,  8 Mar 2025 03:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MxMdGLHZ"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5F51C36
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 03:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405584; cv=none; b=UoQFEwjlEsgTUJ+RukSkkoWAUKiOec8ufQIVI97XfpdWPI2gFxg8l90wyKOllBQ6CP/W3RxeL2+20bycy0Km6FnedQDfGrEZBkNpTcrgLrpwvB9R8QQvj/DmYXK5hw7nuQV1k6vnR8Y3jdwM0+vdTMAE0/YChArP9i04BmKE+/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405584; c=relaxed/simple;
	bh=X06PB3T3m5fg4A+Qjq0ItNARSzcDwsDKDNPLQ22yi04=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mMWdk7/6cFylQ6dsz/GzuzjOM+9JRnpSjgrFf0SpW5alknTa1RQHWCdNObyj2gIESVudL5IPxHu/0aHi1kPlu3tsrpEitShl4DX/oWfAJpDjskm8V8VOLqbsVlIqXNcbA+nuS9TG1r9gpr8UG6Ajs1Yf0BTan7pR0IabLNr6kUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--liumartin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MxMdGLHZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--liumartin.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff78dd28ecso4844621a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 19:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741405583; x=1742010383; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GA6M0g+rvKz91pMPmDBO89woKCgOmvhJSGNhdL2Qrhw=;
        b=MxMdGLHZD3AAN7n4JIvpRins5I3McRJUXBKO4l8a+Na04W3Sxbie1mSUyD7XIYNrAY
         TTQskrzA4P/+tv1U9NqFXl0kkJt/YSmv0+Ue85oXb+Fth2IWrahBSUbqzF0ww6bBS8o6
         D1J/a+1SnPZ7Qfa2fgfgwIl3ZMKt3MEcC4qkH72WvTVkTRGfPdTohZJNGHik3nP0ehwc
         Wgg1O96lHgzOW8e3dgAkHuPpUwZ2o0pa8qLbCJJ3YRuVugJuvAGauvyHyKTwcEdjveYv
         M+zljtbRtSvdMYftfhJbRFgQjd5rN2l9d1bnB23NfwYw8SoN1jBs/240H5Z8Gnfs7QNn
         CBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741405583; x=1742010383;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GA6M0g+rvKz91pMPmDBO89woKCgOmvhJSGNhdL2Qrhw=;
        b=ZVD5nC1p/yse0YKX+afSiEZ0ATRbTGRVSKE37XE5IOXIrRoVQQULr9Qr+GNIrOzHro
         tPPdEy8DM86vdU2xcEmtgAObZRffO6V3NzcS1IAn0eTuBtcjCkdm9CmKOVF5shRbl73i
         xbUkpphpRLTBn8SdYz+hG2Ob0+hhJuatHwctQahplTCrI+UNVjqGCv0GbPfUwvygGTv1
         Q/OplkYHgGzTlJN4M0leehdyllSN2TfOURDcL1Cyh/Tw7E1joe9eP05GpI/upAAJvnQJ
         bfbCTlY7W1VCf8lgdqYVX/MxJNEedWdmvvmYLMRbcwRWKLuYJqcc6ohMbH0FpODin3B9
         XGOA==
X-Forwarded-Encrypted: i=1; AJvYcCVapsklfQICdVEkyjPyDfFNTrazQ9e70k/y+ENcYwIA16eXu8A642foBJcaHFzlg68+6LdTXMZHCuTXRNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf1/ICDhUEO3yUa3XwwyAXhoX0GnfIRhgrzuY7B9ppRD8BXWLh
	+LiR+5sJTZksunNEy6mFA6vQ6tsxnXlsgFrImw7Y7f9Mo6z+G6Etl2u5x9tFDGxF++lhkYYmZw7
	o8B4V7Htyxaym0Q==
X-Google-Smtp-Source: AGHT+IFyfo1BUqJAhhHtjvCd7JQ6sFBCeGHbyX297O85/jRc8vXv2lLZ9VO7j8vZyQ9dp834rWXS6pRG9yvO51Y=
X-Received: from pgbdq25.prod.google.com ([2002:a05:6a02:f99:b0:af2:4e8c:1cc0])
 (user=liumartin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:1594:b0:1f3:48d5:7306 with SMTP id adf61e73a8af0-1f544c663camr12188527637.31.1741405582722;
 Fri, 07 Mar 2025 19:46:22 -0800 (PST)
Date: Sat,  8 Mar 2025 03:45:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250308034606.2036033-1-liumartin@google.com>
Subject: [PATCH v2 0/3] Add tracepoints for lowmem reserves, watermarks and totalreserve_pages
From: Martin Liu <liumartin@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Martin Liu <liumartin@google.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

This patchset introduces tracepoints to track changes in the lowmem
reserves, watermarks and totalreserve_pages. This helps to track
the exact timing of such changes and understand their relation to
reclaim activities.

The tracepoints added are:

mm_setup_per_zone_lowmem_reserve
mm_setup_per_zone_wmarks
mm_calculate_totalreserve_pagesi

Changes in V2:
  Fix coding format error. Feedback from kaleshsingh@google.com.

Martin Liu (3):
  mm/page_alloc: Add trace event for per-zone watermark setup
  mm/page_alloc: Add trace event for per-zone lowmem reserve setup
  mm/page_alloc: Add trace event for totalreserve_pages calculation

 include/trace/events/kmem.h | 78 +++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c             |  4 ++
 2 files changed, 82 insertions(+)

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


