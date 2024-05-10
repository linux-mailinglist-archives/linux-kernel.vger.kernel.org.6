Return-Path: <linux-kernel+bounces-175110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4D38C1A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126CB1F22009
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A881E537F8;
	Fri, 10 May 2024 00:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nDPkNFH4"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5E651C54
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299788; cv=none; b=s4xDYUCZyd1MmUVXpOQ61NYgUmeyulTqlBBwwv2bPYXFM4Iis3QUE4KQFyDb3PdB3H0xkr2ncynL7d7ay6Nis0AeqDgMU7K/Az0gm6JUu/0HMH2aoyRh6m8M3xaDq+3uo9zqhHO4DllawmgwDZUS9l1/dmi9WakvM/d2qLv/RJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299788; c=relaxed/simple;
	bh=VJMdzYkkWNobVas7QA48PzMgvlHzpsjOh24f/lA6Juc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BeSb/0dVsS2Cw/WMm339RMfpAPd7F/mKnT2v0C3csPZAr+ZTi5ba/2nZ3Ffj5zAeXIAd0cvddtZrdU+4+CWX1Wm1yF9TmrUQ/6IGCnnVPaKpzRgMWF+aDYSbkBce6aO2qYWC+9Fzleb2AAfKUpWjUfqC4PwN+U+71iyynhD8KGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nDPkNFH4; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ec6de5fff5so13634045ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 17:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299786; x=1715904586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F6pzUPfc9dzXnDgIcrAO1vEqFEJkqCnVb2h/9OrkRu8=;
        b=nDPkNFH4kqkTWQo6t7Vzz4yumSsflMvN2UQHNrPA5AnyZGF/ULVPBtqytFviIzmjsO
         Gfq6mFRg4bVFG1nfPNls3xWaQ6/BazVAkObg4//yGL4r3ur20M7ck4S2AakCjPosefHq
         j6Y8UTLZmk4QhKN3OXYxf6p/EOHSa9SlG2L9Ipf5BZQ6W8c4m+Ykh28Q0dKeSKWJdbiy
         g9vI5+zSrVLu0CnfGVx3x/pXxQxjhahU5FyljdA6DFJKd5yZ0Nfw4j0qXJtly3hZonLx
         mWQpQI/PVSqwKl9P17SVX2yIGt9Vm24fpWmPeMY1Cvyiz7St4vUobnAoFsXLK2e83KOR
         /G6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299786; x=1715904586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6pzUPfc9dzXnDgIcrAO1vEqFEJkqCnVb2h/9OrkRu8=;
        b=VnAuy0gMPQmHNdBDyis+CFMlz/dSi0Uj4ZRGUabtQVDIcrMdtzbyCsmfUqLrVuYAA0
         KFKNamFwWZGMsWGRvpMy68cR2yXXH6zgsJ4gyIXPohKxsjdEGocz8ohV8ViDriDJYHQk
         NMLZNBR4vEYPEYq78inwwsqPfWILMqImPmHKUsD3AvmefxS9x020d7UlMZCIFoONVfMQ
         MwbtbF0a2LkJPmS5xjNCzmAH+ZZhTTQyoa5ANnTDBZgQF4dhjJJbyCvVALj0RYQgtKPY
         PcmR3uTepPyTFER4l+5LUgsoeFF5xGRsryGiZVEjOvNJWAQhST6DdbPCcjc93NF9ZlZp
         KNIA==
X-Gm-Message-State: AOJu0YybCv+G9RqDUcSypa2i2xtV4M0HE5P/YY41xvgat0DtPyvq1pEq
	ErxVkBDSj/+rqv+7MH6eP9ALXAn9D53sBQ8323iIaDbin3i4jZvIgEEXAlHwNQbzmS6kBQOPsZt
	D+w==
X-Google-Smtp-Source: AGHT+IFRiEIaxUZf+B09qoF4C7spnjmBUeOfByi8Z7hCbfbBT+bOyMsubD1CDFgj4SuGnEmEdt3tFwdeaFk=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:f201:b0:1eb:51a3:75ee with SMTP id
 d9443c01a7336-1ef43d17fb2mr26315ad.4.1715299785832; Thu, 09 May 2024 17:09:45
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:31 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-15-edliaw@google.com>
Subject: [PATCH v4 14/66] selftests/fchmodat2: Drop define _GNU_SOURCE
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
 tools/testing/selftests/fchmodat2/fchmodat2_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/fchmodat2/fchmodat2_test.c b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
index e0319417124d..6b411859c2cd 100644
--- a/tools/testing/selftests/fchmodat2/fchmodat2_test.c
+++ b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-
-#define _GNU_SOURCE
 #include <fcntl.h>
 #include <sys/stat.h>
 #include <sys/types.h>
-- 
2.45.0.118.g7fe29c98d7-goog


