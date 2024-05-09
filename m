Return-Path: <linux-kernel+bounces-174906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 850FA8C1710
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B44F1F21352
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502E8145FE9;
	Thu,  9 May 2024 20:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3zFawOBx"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F816145FEE
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285020; cv=none; b=m+M4EKf8puKvkmlLU7QqkkyChxd1BHM1knNV1eUczPWKM4uVgcQbovbAM2r+AG13cVkVji3Sbf4sMlp5rK1rCN4pXRyj7cSHawQfT6nwa3FuOCqatHbw9cGh4SfrfIrcFW+U2PowaPfp4IHMyEIZs38CO/IO0hLROWe8PuX/fkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285020; c=relaxed/simple;
	bh=dV1o9stC96OSdaZmBc01Y9weXsxVFPyOQWHKjWEiAeU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EmpjfPtwZ0FQCAcdEXVNCyiSsMIxk1rnmMuvxaZOSBsQz9Q7cNYxev51lJknNS0mTczmFzdoWNtFS4+vBGYip5y98tYDFos/x1T7H5PWViXhw32Om8QeU3Ed33hh8bQtBtwQ25coWbbRut00juaUTG63bC8+Bff5bx/QB2obQ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3zFawOBx; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ed8876c40eso11958435ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 13:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285018; x=1715889818; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CVdUVqzWYmb3RWbqhYAX2sm5BvszkqdFATAvwhSxfi0=;
        b=3zFawOBxTotd4Jd7OPCvrqlkgD1t5aw8/tg8wsHqSbIdpCHIWizdPN3yQacIiotoE/
         oE4QH1lT6ovkp356Z5+8dF1Xgj4xFGP2R68nW1zDv2hFcL7JDbyK00TQumwD6tX0LP6n
         m/OzvsW4wa/lGIxkpIWMAw4LgmvOrSig87+nJg+U9rKvnvvGHgKqE96DIRsSRCTW8Grv
         Sbfwc8vVGBmbnYpgcQzU1VtikW93UYTC+QiL67yr5gDg264HZSw3LKygUPaEyEZWbVNI
         YpzViJosGGvGQDYRxIzDo0P1sPOBvxr6lIKadOYmSAbVWtX8n3GwBadB7TAGcTZkYuKs
         Utwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285018; x=1715889818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVdUVqzWYmb3RWbqhYAX2sm5BvszkqdFATAvwhSxfi0=;
        b=N1EVREPVlJNyEtcPtXXg17+vrRbs9dE2LtJoMmb9ZmeAd/mwYk0OCyUsbocCgKbcOS
         pt2YxlH7IWphS+2c0wJHQCi3UP05p3yjoFSQ2/oXxFYwTjv29eRA1LqPCAV5/Z653aoY
         AZDVKbgN48UERwGJXmmezmriu+RLos3XTpw5fxkDo1SIMbrOPfbHeLadWC6dxfV6Vj2R
         PnydniyLkI6iV5dyLfU5kRY8Y2KnzPqalYsDYkM65h4P+rupEc1ngKH79eTpm69BS1Vi
         lmDw08ZvCbgN4XyHW1yGPEA4sct7REJzsUx0JJm0dDLkVmXu1ACRDPeZYtBG2qatArCa
         Mxiw==
X-Gm-Message-State: AOJu0YzJT/decWxlB1ENbyrC4z181TnlZAu99m+qQLI51aedv2DfCNNJ
	OkMyvqZRuvkYePc3qW/ani4j1N/JhnnEom0wlhNUVpqqwCReUrnnE3HKQaalmyTXMzKmtc+EleN
	G2g==
X-Google-Smtp-Source: AGHT+IHg5VgFl0oWnKy9QZrL+pJvNw77NDmjf2svPyBwnniX7haHt8pz7giq5R8s6VnTC5gIYeXcCZMMI1M=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:ec84:b0:1e4:3299:519f with SMTP id
 d9443c01a7336-1ef433db6a2mr390305ad.0.1715285018542; Thu, 09 May 2024
 13:03:38 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:51 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-60-edliaw@google.com>
Subject: [PATCH v3 59/68] selftests/splice: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Edward Liaw <edliaw@google.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/splice/default_file_splice_read.c | 1 -
 tools/testing/selftests/splice/splice_read.c              | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/splice/default_file_splice_read.c b/tools/testing/selftests/splice/default_file_splice_read.c
index a3c6e5672e09..a46c5ffb573d 100644
--- a/tools/testing/selftests/splice/default_file_splice_read.c
+++ b/tools/testing/selftests/splice/default_file_splice_read.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <fcntl.h>
 
 int main(int argc, char **argv)
diff --git a/tools/testing/selftests/splice/splice_read.c b/tools/testing/selftests/splice/splice_read.c
index 46dae6a25cfb..418a03837938 100644
--- a/tools/testing/selftests/splice/splice_read.c
+++ b/tools/testing/selftests/splice/splice_read.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
-- 
2.45.0.118.g7fe29c98d7-goog


