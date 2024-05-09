Return-Path: <linux-kernel+bounces-174912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561C28C172D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3F02864DA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA4A148FE3;
	Thu,  9 May 2024 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pe5LzmXl"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644001487F4
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285036; cv=none; b=XZ8iddKVshbDhj0ubtX3QuFdSAly3P4w1VgHV/MPlv5QgLX3F1ZcOzSUbZsa2vLctmbrvtcpuG0iGXtcW9XjGLXpMxJQYjF+m57asSs6Qbn1wFckCH5DRletY5g5b7QrQp+4DuoIT5P5ZOlIEjLEK1vUbcQmMFXxDszODCeTX7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285036; c=relaxed/simple;
	bh=ZEp2hCOhRfZV1MvzcY8wQBy7akJNvFUYRtoEP2ESOPg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rvkwPNizZzDOg9lzUT1Oq0KrfKzc4uIiANFOfus2afCl4FmKK0kms2/xrdMUtfKIbRmDJvCD0zl+YdH6X0Mv8uc5dhNjbNqReesbRjrccY4aC6dpwFNUDQB7BCo2tYyF84R53keH5vPd9CGiHajNivPVFdj/84oGwqqSd+ib9lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pe5LzmXl; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6efef492e79so1330117b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 13:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285035; x=1715889835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WC7D8aH0v4uQUEV7LLGnAs38/YjV1LtGmErWE1cbhiE=;
        b=Pe5LzmXl1/IMTW2B2qwkxlRyYG0WgdLdt9wnksTnwQ6GJtoUmYvEfwwI1oTFzJwtTa
         0adZo9PbtCoousN0mlg78joAg2ZGIdrjbYBS3j2te7D/yjdGfEKaUUVhyNE3Wa0Z0Isg
         ksKEVY1CSXoJ95rvJPFatPAQ3oQFnjw7zylc87inP2s9bxyfl/pT6/i27dwY/SzKwI2O
         1PPgFPCEsHaA7ojLJ/b//gBMSupeFdzFw9voVO3QYd1ef/mZkBji46QqeIZBsdOcwovc
         ylbCkbnq8gJQkOdRUuevajcMjjzxiy6ue9HCObZZeeQn2u5xooUpH2ZoMsJI3QeAgTiK
         Ub/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285035; x=1715889835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WC7D8aH0v4uQUEV7LLGnAs38/YjV1LtGmErWE1cbhiE=;
        b=Ixg28Io+Xc5PxW1nBfQKp0EvtoHhxiyRvQT9j03cYK+ymxxyi8UfzMPt88bq9JtcFq
         5RLUmeJMa1a1HY9FuW69vp613vmiqk706kluvBdbBPAL5A04ZhUEbwj1Z9XKUKZFd7Ws
         ePJPH1kGpKo5TUaSxM9pnpjQHZk47A8Wp+okYKYqcDZZWKH+768wO8rOi8yJ1CSW1StX
         JklifTBuTyQIRvPl2IJa3oci2nryebB3gIhDICbOYlS1esVsDd+W0FPOjTmy02QIx1uH
         8IcceseRFhP8bVYXpbYSyW8MXwRGgg4Tqr1tRA4visJNgCkdohaBKQtPvBdFSkl99+qg
         u77w==
X-Gm-Message-State: AOJu0YwT32SfGQ4rfrmbCjFcXS5gjDzIFvTaTvMtuAEq2LthcqwAo/1V
	TvgtlXKUgsWdWzsTlTJOwpJ0WbH9mapGN9YNrt2QMf573IKaXI8TD7FJJiSp5e8etVGCVFsBy4A
	UeQ==
X-Google-Smtp-Source: AGHT+IH2SbJN822nfl37wycvsXND96WvS/1faYgMHWYRV6m5iJpfeL+wLm1M6pioafAmOBMqwtyFIThDOZ8=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3c91:b0:6ea:aafa:815c with SMTP id
 d2e1a72fcca58-6f4e0263dd0mr25176b3a.1.1715285034729; Thu, 09 May 2024
 13:03:54 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:57 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-66-edliaw@google.com>
Subject: [PATCH v3 65/68] selftests/user_events: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Edward Liaw <edliaw@google.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/user_events/abi_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index 7288a05136ba..a1f156dbbd56 100644
--- a/tools/testing/selftests/user_events/abi_test.c
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -4,8 +4,6 @@
  *
  * Copyright (c) 2022 Beau Belgrave <beaub@linux.microsoft.com>
  */
-
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <errno.h>
-- 
2.45.0.118.g7fe29c98d7-goog


