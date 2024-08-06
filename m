Return-Path: <linux-kernel+bounces-276050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867E6948DBB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A336281C4D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E204F1C3F21;
	Tue,  6 Aug 2024 11:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D2Ul20yW"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DA81C37AF
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943955; cv=none; b=R//2ZxJNh2gwBZUm262XjnZ/GDmtRs8RXkdCH1LU09IpV2J1kpOV/HApbc9IbxUi9ru0TPIKPdLrmjP6volBn3tjqWmMQRTEdqEF6rRkbJezCm+UvYgvadL3a+4PKbAOhqsdJk990nW2SGJZ1uZZ1en4I8rSVzDJfgYZgBJk6Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943955; c=relaxed/simple;
	bh=qIjEnSp/JD5JYvreiYWkbvBNFQ5Bxx+6BfLNwZTCc7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VYcM47vnhhLDJkH/CNvpkGG+IVGNanlfr3v8ZtuRW4LPfeYrECz2YEapM5ec+W0ttNQkKy425Lfn5yka8OMSOJWw/5jruIFpbgDdLL3JUN9FyLFNFPjrqPLDJD04q+ee90RHtuZsbwkHPwlkBH063a4hgSFmeEri0XUJjEqT/w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D2Ul20yW; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7105043330aso415645b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 04:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722943953; x=1723548753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAh5UOxYiMS3JZXwzAnpcBRKJRQgjrownZOetlAThLM=;
        b=D2Ul20yWvyrX0ZpDxGjW1oFrz1CNqh4TeVwOxMzQTeapL4y5lxFs+rIDTzHyrH1GU/
         F9/6ybVUICer9d6B0Nnq1CDc2h1Hu8su/48T08+bq0EiiWnVaVA1g5BwLDivNNiTtse5
         EMqXX9hClaXpmDNhJ+DAtxGxhxTYWK/wfGObc8QImQCk5HQl6be43hmmAZ+HHw1iigCP
         4kAmiF8HPqjXpQ0QtSh1CvAIIybN4bHTlj2NUwA0vj3zShqXachO3FNn+iUvTWPCgTa1
         FkubmOOAfc1K6qbygZhkFYNLqURRBKpJK27ryFSYp468q/pImLupLPhnoYb3/tuA8goF
         uT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722943953; x=1723548753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAh5UOxYiMS3JZXwzAnpcBRKJRQgjrownZOetlAThLM=;
        b=uXBDF1rU4HevavAC/nMQ2aY50JikxGbB1NbEs28+mIM9kaAKx80VRCLoHreDuQR5qd
         kP1NumTrvYVyqJw3y8vgGjrKiM4h56v9J8prMhhG4YC1DWrj+ofsP4TtrRr+D4jeyXVb
         Ieedh9yOvRmvC32ndRvwMYzWvzmEf9rfPlZrryJECgsBgsnEJTG2d43fS1RR2mLn8Q8A
         usPB6ozIaprD5nNSFYG//HYwDqJ23H9lkZqFjfSPWTSsjIuO6S6X4Kf+P8+PU3hr95/Z
         ktp4s3QGOwFVB66df2C5HjTNqfxcCS+Sqh1l242Dn4X9n3nBYuDg0GEBBsRy0vL9FkV6
         xFdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfghN4EEDUfmwaA54rN6Vy/cEK0soO8n26dMEsv7BdnAC/jG73+NrOl1oVCZWp3bfOiwfoJJPzs7vRBBtknXaVk6/xwdF0vmjKNjPp
X-Gm-Message-State: AOJu0Yxnpy9z00yNWK7AD7nHzIFDcNSs8Omprp4Fr7qApw8Q6SNsoYtD
	ZChHk39/kpCoyJnMjCX0Cani+irDk8dDGs74xFCb8VZNAAPRLxMqVusJtRJxI0Y=
X-Google-Smtp-Source: AGHT+IFLkMm1nd2fsBj1xrh3zpLNwTqpqzJAdGAu26eIbMgvxuF4IME8khxZS1c42atzcqMwOFNk0g==
X-Received: by 2002:a05:6a00:1253:b0:70d:3587:c665 with SMTP id d2e1a72fcca58-7106cfa14damr15822735b3a.2.1722943953092;
        Tue, 06 Aug 2024 04:32:33 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec010a9sm7037636b3a.10.2024.08.06.04.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:32:32 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH 2/3] perf: build: Fix build feature-dwarf_getlocations fail for old libdw
Date: Tue,  6 Aug 2024 19:32:09 +0800
Message-Id: <20240806113210.1649909-3-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240806113210.1649909-1-yangjihong@bytedance.com>
References: <20240806113210.1649909-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For libdw versions below 0.177, need to link libdl.a in addition to
libbebl.a during static compilation, otherwise feature-dwarf_getlocations
compilation will fail.

Before:

  $ make LDFLAGS=-static
    BUILD:   Doing 'make -j20' parallel build
  <SNIP>
  Makefile.config:483: Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.157
  <SNIP>

  $ cat ../build/feature/test-dwarf_getlocations.make.output
  /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/9/../../../x86_64-linux-gnu/libebl.a(eblclosebackend.o): in function `ebl_closebackend':
  (.text+0x20): undefined reference to `dlclose'
  collect2: error: ld returned 1 exit status

After:

  $ make LDFLAGS=-static
  <SNIP>
    Auto-detecting system features:
  ...                                   dwarf: [ on  ]
  <SNIP>

    $ ./perf probe
   Usage: perf probe [<options>] 'PROBEDEF' ['PROBEDEF' ...]
      or: perf probe [<options>] --add 'PROBEDEF' [--add 'PROBEDEF' ...]
      or: perf probe [<options>] --del '[GROUP:]EVENT' ...
      or: perf probe --list [GROUP:]EVENT ...
  <SNIP>

Fixes: 536661da6ea1 ("perf: build: Only link libebl.a for old libdw")
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/build/feature/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index b18513ec4da6..1fc651cae9e5 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -179,7 +179,7 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
   # Elfutils merged libebl.a into libdw.a starting from version 0.177,
   # Link libebl.a only if libdw is older than this version.
   ifeq ($(shell test $(LIBDW_VERSION_2)0 -lt 1770; echo $$?),0)
-    DWARFLIBS += -lebl
+    DWARFLIBS += -lebl -ldl
   endif
 endif
 
-- 
2.25.1


