Return-Path: <linux-kernel+bounces-174847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8D28C15DD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E2D1C20BEB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F56811E9;
	Thu,  9 May 2024 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cB5RPkAb"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32B881204
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284849; cv=none; b=WFAiuCExvwHjxTK/Gbot2cwl66KLDeZ6UI41AKq4AZdcykXaLdnHlwKfU2DFxEQCNTISLCjLHMiMgos03I85EXxBDlu27J1qfzDPAlLqnX+b1wFC/qHflf6VlnP0rjG+kMVQIHVw2fTKlD4uBVD30f7sFA8Ue2ig+XU+U6Gzlmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284849; c=relaxed/simple;
	bh=b4fP4UgoO6k1eMUU5vItAasjLHJoVD6U7tHRbCDPYZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gaT1Ii8KR1oDYN6c66s90kCAWfuAKfcQ7xQ4sMpLacVzs6HiVBu8nvkvmKwvk/3bkASos4OGhq9diFTtjDr5bDRcawC4lGIcorhtZ2AfGn0/L714OG0LDgLNFhy06SuMRp1EpLDLkfAiv52jLuy5A/RB56QQaQLUOiB1WBpHxPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cB5RPkAb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ed8876c40eso11925305ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 13:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284846; x=1715889646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HYbl9V+AVk19HnuKFt5pVD1HiMf/Dt0RSFiQIU6DF6Q=;
        b=cB5RPkAbJnObg8v0RnYHL9N3TI2TPZhEVtSxNZFhJR/bLNJEYBfDT15zhNB5XDpSA0
         4kMMVrYsf5cFk5FYOs5HZJUN6GkWVnNnvsz51c8jPoQqa3KpPlWkQqo/FmUR86CFtlla
         hbzrNRBsi7tKaysTvW/u+9eTTfnYgY7u8m8HCdTcuTXenVqvUukQ5VpLoSCkwMQX0Zub
         b3GS+Qax2r6tZHtv4BUK0q9Al7Ayic63i35iB+RmLGh1Ai3QWXJFeIiuMK6XiAydi3pd
         7qIW62hAv+8/6T3klJuCGAstRYgLdC5jxvsHKnOzDJ7+i3jg9RbUuzOp6RmFaFk0iRgx
         +OsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284846; x=1715889646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HYbl9V+AVk19HnuKFt5pVD1HiMf/Dt0RSFiQIU6DF6Q=;
        b=f9pUctH9LSK2YQY2jxRNFRmYSosjp+lzm9uGKpha5t1sQEMAqeb+Lc0uAmN/xQ0bWW
         /Lk56S2wV7mCmihGY2DuV6eqMH8u1itgbXxpKdtnH8c79ZAx09T4Pjlg2/ZFzuMW2Bnx
         e1CaANWZpwOIMMFmPrVzro5rzLZ7LwoAF+SOZpEN/4zn/LxOqqXXuRpQImxUW74NbfOz
         SvPjKnPq7dM6w3Ze1bPqrbVqaLk85uEvJsETGrJTxI4fhnNku6RHXOlDMXiDJ0UPaqI/
         t6WkNcACAXnyfKoCHvdB6eYZ8xrr5iR1OJPB6PAXnP15xyU50EIb+U26goBFs45FaJ3o
         ZnXA==
X-Gm-Message-State: AOJu0YxrS7KhhXMp77woIf5xZjTLIZC0aMU5XT36I842xQzwrsNynG45
	R/dglx/df6h7p4aVga2BiPzzm60umLkeKDZZghQJtxdLHaUvYW6ey9yLlxzAfva2xvohKP/X8/h
	Sdw==
X-Google-Smtp-Source: AGHT+IELAqSB8hYFZ34xlKzhfSzqUAYBmeLr7kRjV31DWmw0y95gSGc6MHY0BCLwKilkYBHcSHuLNxq+e3c=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:f68e:b0:1eb:6672:cbbc with SMTP id
 d9443c01a7336-1ef43e28196mr373325ad.7.1715284846073; Thu, 09 May 2024
 13:00:46 -0700 (PDT)
Date: Thu,  9 May 2024 19:57:54 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-3-edliaw@google.com>
Subject: [PATCH v3 02/68] selftests/sgx: Include KHDR_INCLUDES in Makefile
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>, John Hubbard <jhubbard@nvidia.com>, linux-sgx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add KHDR_INCLUDES to the CFLAGS to pull in the kselftest harness
dependencies (-D_GNU_SOURCE).

Also, remove redefinitions of _GNU_SOURCE in the source code.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202404301040.3bea5782-oliver.sang@intel.com
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/sgx/Makefile    | 2 +-
 tools/testing/selftests/sgx/sigstruct.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 867f88ce2570..26ea30fae23c 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -12,7 +12,7 @@ OBJCOPY := $(CROSS_COMPILE)objcopy
 endif
 
 INCLUDES := -I$(top_srcdir)/tools/include
-HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC
+HOST_CFLAGS := -Wall -Werror $(KHDR_INCLUDES) -g $(INCLUDES) -fPIC
 HOST_LDFLAGS := -z noexecstack -lcrypto
 ENCL_CFLAGS += -Wall -Werror -static-pie -nostdlib -ffreestanding -fPIE \
 	       -fno-stack-protector -mrdrnd $(INCLUDES)
diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
index d73b29becf5b..200034a0fee5 100644
--- a/tools/testing/selftests/sgx/sigstruct.c
+++ b/tools/testing/selftests/sgx/sigstruct.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*  Copyright(c) 2016-20 Intel Corporation. */
 
-#define _GNU_SOURCE
 #include <assert.h>
 #include <getopt.h>
 #include <stdbool.h>
-- 
2.45.0.118.g7fe29c98d7-goog


