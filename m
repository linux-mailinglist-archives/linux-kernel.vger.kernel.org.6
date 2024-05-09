Return-Path: <linux-kernel+bounces-174877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEAE8C1677
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D471C2092D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A2313B7BE;
	Thu,  9 May 2024 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gH35k+fZ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE7113B59C
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284933; cv=none; b=UYfVhW3uNTzafvN31pfzDwr3XgC3ik6knd/2hNf0TF3232FPn8OadFvYVEwhtY54yzFy7Ww1N1GXOB6/vAIlWoI4kgVaRU6OnqtaRDWtSWjtGeki3V4c4c36/1e1sPHxhmCVVKlkst3vdoVhicBEshcfwgjygt67bj3KSUsAep4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284933; c=relaxed/simple;
	bh=1oD6rsCbKsoe54EZCuc1n9pRR8DgtE1IGKQNEvkXKtM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O1j43tOPwtFQ04t8Eb+UtLWlzJYJLCCUNvT/CW3GN506dgdqDXv0MLjXlJdv86crlj0TvJpBm6280pHaQTxpZHn9ks9svjZ4afI2sPwlIjvx8X3rRSm23J2h18IQHh6t2kzXko/kWOV8J/2YTA/xMxeRbsh9MbsTIUISck9w1sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gH35k+fZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be530d024so20254947b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 13:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284931; x=1715889731; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Di7Erv/XRsHV/bMQeC6cRhGef1PHcLc0ShAwyYHpOVU=;
        b=gH35k+fZ5X08AAt3ku0oVG4cOeN2lgs8ixLSce21it1ll/jZ6oJlEfFcrTFE2bxscI
         aIgShzwUdJh4B4fzU7FnnIlwVKsOBTLSXD3VduBbghfFhgigQeN34/AOJnGDv52GPfBp
         3UwPAmDBMeW1FgyqNfN9W6C+1qtBaWg1cJhZN59rQN9Qlzfpks+VGPHhaWYK1wNrcowg
         aRBQxtC7GVPNz+5sN1Pccfxu5ueBEyGFJb1XgpNIEJGUT2aue9Yeh8s2iecl3Xd9mY/x
         2ntoJjJ+xVGEhO5h/fWeFMz6UkdQ3qg7g/fJbfIS0mZ57qkkTNF2SPoy73ygO8F0+5Sf
         1RAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284931; x=1715889731;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Di7Erv/XRsHV/bMQeC6cRhGef1PHcLc0ShAwyYHpOVU=;
        b=B/V/jBBxLSrnhq6BSKAP+i+kxRffX9y8PAsyDI2s72KZH1GbpK+emTx2trvkwDo3Ha
         uc5l0GlSOq6Mu6bX/M+h1sLW1zguBDQxFsauWV1io6eXrUKvpfc9N26Mci42LuWcbI/T
         V8xvB8cf9lkw9RbO/iTlBVCZNgUXZjZayGM7Snhrw7xBOdU5KIOCQxQRlBDvMKRdy0cV
         sMPQvz+FlY6noRM4NsWe4WKcRpZ8Mh/Yx4+HAPZCqNLXhLb+a+42qtgxS/TxRYNwnL9c
         +MFAxoWljRnT7oLkYU2a3Ar6+8E3/ihkWjaxvyp4cU/CuLw4q2byEPYjkc9ulTGBv9zG
         HGkA==
X-Gm-Message-State: AOJu0YyB31OjHuPDcDm2YnBPPP8CR1/UOhPIEVLgoks965cNVL4yIPIb
	VBMnvai8ughqRf5gKCAII6U1QB1sUbsLHn+LbcIFCCeJML7dcmmA5ctTQ1otM0ck51Taj25v9Pk
	Hkw==
X-Google-Smtp-Source: AGHT+IGzNz2UjieyVL+13PppSOIoCCWtRL0jFRrJh3a18AgOw9IEjMhpDthMiXvHB10Rx4IrrNB28zpbHTM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:6d0c:b0:61b:e6a8:a8a with SMTP id
 00721157ae682-622affeb280mr1228217b3.6.1715284931252; Thu, 09 May 2024
 13:02:11 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:22 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-31-edliaw@google.com>
Subject: [PATCH v3 30/68] selftests/memfd: Drop define _GNU_SOURCE
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
 tools/testing/selftests/memfd/common.c     | 1 -
 tools/testing/selftests/memfd/fuse_test.c  | 2 --
 tools/testing/selftests/memfd/memfd_test.c | 1 -
 3 files changed, 4 deletions(-)

diff --git a/tools/testing/selftests/memfd/common.c b/tools/testing/selftests/memfd/common.c
index 8eb3d75f6e60..879d4f4c66fa 100644
--- a/tools/testing/selftests/memfd/common.c
+++ b/tools/testing/selftests/memfd/common.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #define __EXPORTED_HEADERS__
 
 #include <stdio.h>
diff --git a/tools/testing/selftests/memfd/fuse_test.c b/tools/testing/selftests/memfd/fuse_test.c
index dbc171a3806d..e35c6909f0bb 100644
--- a/tools/testing/selftests/memfd/fuse_test.c
+++ b/tools/testing/selftests/memfd/fuse_test.c
@@ -12,8 +12,6 @@
  * the read() syscall with our memory-mapped memfd object as receive buffer to
  * force the kernel to write into our memfd object.
  */
-
-#define _GNU_SOURCE
 #define __EXPORTED_HEADERS__
 
 #include <errno.h>
diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 95af2d78fd31..ee019b57bb98 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #define __EXPORTED_HEADERS__
 
 #include <errno.h>
-- 
2.45.0.118.g7fe29c98d7-goog


