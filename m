Return-Path: <linux-kernel+bounces-185579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E5C8CB70B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D21AB23628
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBAD25753;
	Wed, 22 May 2024 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WdJ+w+pl"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FF128F7
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 00:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339581; cv=none; b=Zq4eD+ziz9R6C7xTuUAgY0Jjln0Ax5y39TNULjTaRw2+brXoXFOjWThIpllIvgJasXHrxjOt8jQQJaMBu4hmboNqzbsEQ5viidHrd8K2DfgOPx3nmJI4H0Ng3yvRAWaZgVGC9xltbwEsYbwCepaQ7FLkOfQzP2Q02aN0ELpjG2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339581; c=relaxed/simple;
	bh=wyS7Ki/mejf0xhJNUDsmkKI4TXOY7lCcp6nK2TM+yu0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MAwbhfj5wpwtIB68kRb4CRbO2TTqDYlfZhVM421JRXHX478eYAao28tuSu9cyPKZ0JZ31HGW2PHk+tcfB0kmRERmmc02BP6D0W6Y7N1sploWA857xqS1yCm0JFTO/CTVrR0s0g3l98Vh2k/jGNi3Lq6AgW0tOF8byNY4lTqIkbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WdJ+w+pl; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf216080f5so22939243276.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 17:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339577; x=1716944377; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h2+Rsi36vwtZnongYaIBJsOunisSLXoKXt6dmQkzkok=;
        b=WdJ+w+plvIuy7Tx8/uGH43uxlebvq3HgzvfeKhzEZOHeGMyom8Xb02KjGX9UO5FMay
         MXlBD5cxMvBH5NL5CTOWUuo+D+6rYLELOraGg+GKs80reJpdSVHDXO2pkbFBduDiDOWt
         H/OUfKXbqnL5fkKef7waOxfGoVR9Cx4/qg7lFIGaw/WJH8bMMXyA5J3FLGtLAHnYAD6u
         mCu7JMbYK43Ui8enl4ViXH7MCu36gAPq0pII9nsbyPpaPNW8pkG2Z4WOfh7ed9RuS8nq
         0Y26ZZJpOMIaEf2Zk05puCS4Xzr6p5zw9egRJSUsb77XJQXrXD8tjcO+mUxY/rpb5GMT
         G4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339577; x=1716944377;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2+Rsi36vwtZnongYaIBJsOunisSLXoKXt6dmQkzkok=;
        b=hqVOCj257mhv+HI1ijVsMMB8wCPioscCBnYkOOaM/t0eVvol+hOZNXTG9Tx9VrQDWO
         KD+RB9QLZPDizwDMxTFmWQB9zzHr7L9WyUgBZi8AaoIQkqb8syp3io2/erzRY0S2a4Yw
         kSXvc9ddyIbTfmfVwV65v4oo2xB1vpU9+nKv5RAvIsBNOKHjZq1I9Bk9EagP7s45vNUt
         BlEHMfxtXkMIIFxGtyV7s/pIEHKgZbMCLgdIqIRn5cQPOGhgBpMA+7WrH8+I1JwkACoP
         fdSj0JH+6p8yk5alCDYcFSaiGgWj+74dG3Hd4iFPlPTJgsivSN1Jhvy42LPSKlkU2cKu
         BBGw==
X-Gm-Message-State: AOJu0YxGEAc1YLZs8L4fTcSGFlSQuuPXjnr6u/ZgFTdFXInLJw6tOP/1
	oq1+6YWLE9tqpsDhh5g9my3P8gNUs9ZcNzT1UX20xfPvGHutoB/LpCSZlRP6eqamSchtbzawu77
	z0A==
X-Google-Smtp-Source: AGHT+IG/3Zpx7l7joTN4k4AeREX+mCmSb7fgmrUn7wwa4Tb4B4bmk+1v4oGre9mjMvzUs+OvPiRE3jsBfVg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:2b8b:b0:de5:2b18:3b74 with SMTP id
 3f1490d57ef6-df4e0a4dee9mr216829276.2.1716339577258; Tue, 21 May 2024
 17:59:37 -0700 (PDT)
Date: Wed, 22 May 2024 00:56:50 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-5-edliaw@google.com>
Subject: [PATCH v5 04/68] selftests/arm64: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/arm64/signal/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/Makefile b/tools/testing/selftests/arm64/signal/Makefile
index 8f5febaf1a9a..37c8207b99cf 100644
--- a/tools/testing/selftests/arm64/signal/Makefile
+++ b/tools/testing/selftests/arm64/signal/Makefile
@@ -2,7 +2,7 @@
 # Copyright (C) 2019 ARM Limited
 
 # Additional include paths needed by kselftest.h and local headers
-CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
+CFLAGS += -std=gnu99 -I.
 
 SRCS := $(filter-out testcases/testcases.c,$(wildcard testcases/*.c))
 PROGS := $(patsubst %.c,%,$(SRCS))
-- 
2.45.1.288.g0e0cd299f1-goog


