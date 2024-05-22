Return-Path: <linux-kernel+bounces-185619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEA48CB7D7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E55FB24896
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9530153814;
	Wed, 22 May 2024 01:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M749ZcAA"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50CA2940B
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339699; cv=none; b=C1HdjoclcYljzewYl1Kc/07K5DGQqmjW1kVThQ7G9BQWDWpAcNZRjK9VIkgUbZlFIlPCpiS+aPdzgPkQXoLVnUU7HDq9BIcYBLto4u33LYvoa3f+CYYcVMfG331LYgrB4be7+J47eo83c7qIW1/dWJrDe9UZmVljNtTM+JeivMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339699; c=relaxed/simple;
	bh=5HwaigB++GvyNQzZfOX3IT/xGcxYHjiLCiVX8SmJdZ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b2dSKZhO0UWsqsxTn7qRui6lwQMkv2cIMTMqgC3XW53dnDRkD3hvuWkRtjBCzQWZMDKTZOX9IHnSx2JqELLRqTzrB05Lo0L/m2XhNEhWidalbjeZ6hIqDRdBixHtC+Ufmk4jNYWOwrsdG/MfiUY7h1f0PPL6DgLuhFvgRFAubkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M749ZcAA; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f68523fda2so3717487b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339697; x=1716944497; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+hOshFmf6G7zEK9XyWMlNtDhU83mdpWiA8UPY2QVI6c=;
        b=M749ZcAA5xq7A3+Tuwt4nS1nmkCwG1KujGuwQN0ysupV2FApOkscbgCJzqctSaSzCb
         h60rUj5SKdU4GTmiHIHtCCuSOuefMN843XzFZUDFpQVVfqXcp9lkw/K1ZZAsw+QylMq8
         iQbm8E9aBzGZhmfXeg1sElT0CS7jUlZaxRBP8lz1L9lout/mqHahuAsaO0LOTD6ECv5j
         NaZE5DTy0TlYFOXAqaDjXuK8BzC8To5JeDkNd48Mx/WXL/aa5h7kxpPoTDrCoKNOJEvN
         REhVgJ/HrBvOGavUvOGkIUy9Ck7eEFDx1EaPf7GZ8csf/Jf0je2eiozvvWTnuEh7VJPk
         dwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339697; x=1716944497;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hOshFmf6G7zEK9XyWMlNtDhU83mdpWiA8UPY2QVI6c=;
        b=Sg3WcK6p9T7fQydwLJlJeuihEFxXEv/zZ3XgQD+FMZyXH2vzWtnlwruiReN1X085UQ
         ONSKSUADkXKEDtSIoETVLCocvoumQOZzh1oogDq5+JEV0YxzLtjaG0ZHHTff9RoWxbLu
         QrXCHewY4sfuB/Pdfmm8wDsZ9TngYN0DVBvA/bYhpxsSQC6L7ESg9mI9nuprZKV9bT89
         hTdJdpa+wGUNFs+iFoljXPvKrkfmWgWMox3ijt2QnAxJOEEjXcS+4n2l7CMljbgiZsdQ
         yJEBOipdAt0sEHkFu4AQN+wdVsTmGtTrteKDfmZvqkMMD9s65W9bqhoUmxUlJ8bwUdOE
         2itA==
X-Gm-Message-State: AOJu0Yz+cn3spMFpfceHTtzhl+QlJZFYGd6e+z6ZnbQUaPMFANcwZwbi
	ZJ+j3/iBIsolmKwkKUjRb6IVudmywl0PzeutJ0RyId3nXNnmFymTCR6kQYchkzywD8da+kFftVr
	Zig==
X-Google-Smtp-Source: AGHT+IHysubaIzqInuZoraBMn6KY3/zhAPfwf/Xk9cMSLEOs6DDr4Qj7OXFhv9O7YBXKJiOesYtWd3F2Ac8=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:2e17:b0:6f3:eeda:a844 with SMTP id
 d2e1a72fcca58-6f6d5fdba7fmr15269b3a.1.1716339697132; Tue, 21 May 2024
 18:01:37 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:29 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-44-edliaw@google.com>
Subject: [PATCH v5 43/68] selftests/ptrace: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/ptrace/get_set_sud.c | 1 -
 tools/testing/selftests/ptrace/peeksiginfo.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/ptrace/get_set_sud.c b/tools/testing/selftests/ptrace/get_set_sud.c
index 5297b10d25c3..054a78ebe8b5 100644
--- a/tools/testing/selftests/ptrace/get_set_sud.c
+++ b/tools/testing/selftests/ptrace/get_set_sud.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include "../kselftest_harness.h"
 #include <stdio.h>
 #include <string.h>
diff --git a/tools/testing/selftests/ptrace/peeksiginfo.c b/tools/testing/selftests/ptrace/peeksiginfo.c
index a6884f66dc01..1b7b77190f72 100644
--- a/tools/testing/selftests/ptrace/peeksiginfo.c
+++ b/tools/testing/selftests/ptrace/peeksiginfo.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <signal.h>
 #include <unistd.h>
-- 
2.45.1.288.g0e0cd299f1-goog


