Return-Path: <linux-kernel+bounces-203357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB88C8FD9EB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CCEB1F24892
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E89015FA89;
	Wed,  5 Jun 2024 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dgme9dCS"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E22136E1F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717627010; cv=none; b=pEDIIyw8aO0y4h9s1FktwSXsQM/dHpQNXY3s3GwsjTlyMd12L8ZbRkxZglNnvQjIIKmp0OxqQzo/O7usrRYnqEqT1Hq6GvtfvjlK1hvUzW86exB2fq9tPIrJXvy+FLLN9HLOpNjZmTI6llMJGWS6kNvkA03h5dSZ3+KMRXOAltA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717627010; c=relaxed/simple;
	bh=FAxq/WJA3jAwur4ufatkzAyl90jSZN079xQn1B8hIQo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sD61TkOrqrf/38R0xoGmHN4RnjDZy4BgSG8v4+WooUaiiBM7T0pmF4DX8bsRJ+2f1V3zFNYjypG+VZSGxwUhWWs+obvASGa69tWzt315KSQxnECLIfzcETROMQV4ej8PGWR/2zFV//olnROp9+PU2q8IfY0hFn9O9eEuqIYZFvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dgme9dCS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a08273919so4280147b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 15:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717627008; x=1718231808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UDMXqeIeVKqn4Qjsv0IGaXMAVsD6Gi7Ax4kHrxCoB1Q=;
        b=dgme9dCS7bxFo79XggJO1kNtpxaKsww73MwHScbgnSVRhbu+P6wHnFe5TJcY6QpNIt
         WMnNKSwrveL3ZNJC8WT5mIR5cBhzN/a7Z+wGiR7zRM+HuH5/0iRqJozcUUqnmrun6pPq
         FRjWM3YpziB1wzNcAjNbLqHf9/nHr7p74CNDogTCBWtX102Ui564OqPWNLz6lpP0+CIy
         XrWm0IdBAJTLMsAgE7suGqH+uFx270W26lQBjWR0mepLDJLdZArHw75hgZoD6xMuoNP5
         jgvWQM5SRNLxcBFgf7c5EmXcVR+csM2PMY4UmaOwz2ddwxxB5cHnYtHqvwDkwqmMjQin
         ceTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717627008; x=1718231808;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UDMXqeIeVKqn4Qjsv0IGaXMAVsD6Gi7Ax4kHrxCoB1Q=;
        b=h+TZxXT0JJMcugGzfWJ0o6nrgSR1Jf2RSGeM5UnH4OLdd3Euuh3uF/tmoXl2zSTyTj
         Uu4VqbZqAvWRBVQC6ZkHIPqOExgxHJMdjtBk6Rd/lhlo1GO/2842pAMjSC9OQ9C90v/E
         p6Q0OjDwnnN7wHi13RRp4ArWmSFKccugykgtPCgt2Uxu7aJIKKXKFu/12GdT3PcmpPqn
         FkEdSBwI4zYei8jc30oe59LUIosQIOS27vnMIPwTsMJbJcC6XofYxJWe+ilu6/gNGwuh
         YktHkK7U1zwOwUz7Rnp7timahlcNzD8WjYyAmnve6lFqtyif8C0deO3SkoQP6zjfD0/a
         wWRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP8GM/9CUAZKB7lfZUEodKGWDhK4Nai9+foOA9Bavxi3j5/78pAnJCGEhUWd0JrA/gFJJ8KEDL+gvUcu7OwnCNfcMZggoYtGHBciQO
X-Gm-Message-State: AOJu0Yx99fD+3WHBleL4Bq3lmdrhH0rRHWnuzBHolFLVcQt0y7CvSiFD
	+UY0ODrM3grE7U4AcI1T0MHl+810hWBscN3G/7ntO+BM4d2/tsadDtLlICtWlzKpGmBhNe90AxJ
	hiA==
X-Google-Smtp-Source: AGHT+IFVehH9WFewQGik+Dl0yz205/vF46via66nugJeD3HwTwVLDF4W27JfIYCAwQuhN1N8YQzQilb3Kio=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:38c:b0:627:a961:caee with SMTP id
 00721157ae682-62cbb4cd151mr5405207b3.4.1717627008528; Wed, 05 Jun 2024
 15:36:48 -0700 (PDT)
Date: Wed,  5 Jun 2024 22:36:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240605223637.1374969-1-edliaw@google.com>
Subject: [PATCH v1 0/2] selftests/mm: thuge-gen defines
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Cc: cmllamas@google.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

When compiling with Android bionic, the MAP_HUGE_* and SHM_HUGE_* macros
are redefined because they are included from the uapi by sys/mman.h and
sys/shm.h:

INFO: From Compiling common/tools/testing/selftests/mm/thuge-gen.c:
common/tools/testing/selftests/mm/thuge-gen.c:32:9: warning: 'MAP_HUGE_2MB' macro redefined [-Wmacro-redefined]
   32 | #define MAP_HUGE_2MB    (21 << MAP_HUGE_SHIFT)
      |         ^
external/_main~_repo_rules~prebuilt_ndk/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/linux/mman.h:38:9: note: previous definition is here
   38 | #define MAP_HUGE_2MB HUGETLB_FLAG_ENCODE_2MB
      |         ^
common/tools/testing/selftests/mm/thuge-gen.c:33:9: warning: 'MAP_HUGE_1GB' macro redefined [-Wmacro-redefined]
   33 | #define MAP_HUGE_1GB    (30 << MAP_HUGE_SHIFT)
      |         ^
external/_main~_repo_rules~prebuilt_ndk/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/linux/mman.h:44:9: note: previous definition is here

This test should probably use the uapi definitions instead of redefining
them.  However, glibc gets struct redefinitions when including sys/shm.h
and linux/shm.h together.  So, add guards for the SHM_HUGE_* macros
instead.

Edward Liaw (2):
  selftests/mm: Include linux/mman.h
  selftests/mm: Guard defines from shm

 tools/testing/selftests/mm/thuge-gen.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--
2.45.1.467.gbab1589fc0-goog


