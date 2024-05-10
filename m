Return-Path: <linux-kernel+bounces-175154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1999C8C1B72
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73EF2847D5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728F713E3E8;
	Fri, 10 May 2024 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cEPIyq+z"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5298C13E035
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299911; cv=none; b=sB0Hhab5CRX2QBMtRVzO9pU0+EeHynicKjkKXEHf3tmy15V+gRbwia0/VHk9LFHxXTy2uRlGroGv9XN/EH+PfbINkwnRiUA5uKo/sIubK8SpP5+zBjg9LErTdd/qsYgE09ey1AePqTerqIgX08kG4u5/lSFb4/K4Pn+h2wcSYno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299911; c=relaxed/simple;
	bh=RSI/JrDkqeLiFXbwGZXmlplREYE9MXWOTM+xIBMUD/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BgMTZOpZIKXo30BmQ6bG/eeaG4WDlt/mT0NAI+xH2wRSXUqEygLfqxmn9IsIq/2ioUhw18F/Hd8S6VVFpeRqEKPSfgeqNT6lmIyBJdxpwS1/MlxmX2bQfg0wpwTwljCJafoNu1RWPyHgtIwgVIdK6c6i+iGlmNLM/PnMd47Jalk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cEPIyq+z; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de61a10141fso2092389276.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 17:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299908; x=1715904708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GO1gcoPElveUSPvl43PtsRVjcacyZcZsNQYTuVuo160=;
        b=cEPIyq+z778gY3NHPMSB53kuYDT60IfQ5i+6Y+mHRJF0u4VfuYZZol4oiUQIeE4EfB
         MPldSRUBGd9mjoruDzOGo07j22I6zbNpEJaelnEtOpsEJhQE6JYPUt7VWygEoEfY1+8E
         H129w04PxpBdSjq0JHZpT56A91qhIPI2y5p2NiNDCyEa7zUkqxbehoG+vIAmIIZdMdCF
         IrSdyDCVialv7mcpUelVzm75hgIiRpJNwIrRDTnw0EbajtPDNKHzyIFqSHzuhu5KGe+d
         B/baRb7zUJdDLMQEyJTj0BsMsG+0MTXRUBef8ep9DYIaXFpBVp+c6qmoC2ptO2Zpo4qK
         cRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299908; x=1715904708;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GO1gcoPElveUSPvl43PtsRVjcacyZcZsNQYTuVuo160=;
        b=w2AyxoP1pO/3adR2eSjKOq6evfLIbK84u2LpInzGhVcChPT6nl9FK41I9pCZmY2n1o
         eQMfnw1NMAAI1G82dhIftlEECUm5Zogm9anbZatJFHrzMGomoiDeT2/7wQ+mDQwUnTw7
         NBHsX3RnuEu41hwo7AbE0BhwjaoKjqj1m9eKXkbUBamAWYY2sK7enlbXNNvz67fq7aKM
         7gstZHyDnRJ9fY4Yu/pEf5Bq7afXppM4stE6jOJIqjthUq7zwy89O58cIZnnX5Bjo+AU
         8y3RIvlME8nKgyeWts19mOb4ziAObJJ2w6xddf0k/ckA3a/YMIF+UIcwGB/28zvsGCwu
         QWdg==
X-Gm-Message-State: AOJu0YxZLQrchoA029Zdkk8c8aGi8JaAWZ6s7iqqCd4EXHA3VYm7ejOG
	0Lq8Uo7Yy5zhvIT9RoyFEh+vPgjj81NBJV+5tX17rOma4mt2GbGM+vc6Xibww2Fw4i80Nls6aI+
	WaA==
X-Google-Smtp-Source: AGHT+IFqVM7jCc9e9vcxx6yDQfRIV94q7wlSc89OLSLIs1UwhsdSZiFockGfx7o6DTxJG5odCLelmrAmBDU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:1982:0:b0:dcd:2f3e:4d18 with SMTP id
 3f1490d57ef6-dee4f364f84mr105630276.12.1715299908304; Thu, 09 May 2024
 17:11:48 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:14 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-58-edliaw@google.com>
Subject: [PATCH v4 57/66] selftests/splice: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

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


