Return-Path: <linux-kernel+bounces-382262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B58E9B0B98
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152A91F2869F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024AC214427;
	Fri, 25 Oct 2024 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fqy2/QMt"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63900212163
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876992; cv=none; b=E45jdfqXR3u0YMPIs3/uzSPxpJmlkDAg6gpUau6NrbObm/PzLCJBgEWzJDrZFuTT+CIem981JAyucStP8FPzVpOAJ1LpzdmLyDCV9Z3SJ3vArMMZhWB1cfwnxY3wB3/Mz+JuQ+VpP9Ffe/AMGOqudElRnVuP8Eoq1hX8ByzDBEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876992; c=relaxed/simple;
	bh=4yySnYzLZn+T4Oh14Unm00EmZJ7xqCsYNG3mY4KLftw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=uNI4esfjsf+leu3s1TcF1jrJre1Zr0V+wuZc3ybojTph8ulWogL9hs7+ypewbe/GOSun3GzqjuGEDhOgLRo3ePoVeh4xC0pqeLBV7ssiH/t7ZfTWVCkXA4rVoC8gEbquVAHtMROg03WDJnStg+b6LsyP2Cb65+XfTUMVyoklYEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fqy2/QMt; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e0082c1dd0so47667477b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729876989; x=1730481789; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UfqlArFfChSnPcH7RDY8Nm7G762SilyEqA0ClwBRXCc=;
        b=fqy2/QMtOs4O48lAtMQBDydd1a7ZKtI5hj3IEG3IyNlxg2vDz27hIeg9Lr3FEpURau
         hqbaJLou/8lXwQnB6PLnfSkPRLwSWtpy+YaofuyaenezajhkLnjOc+6iZebpeV3nrIyA
         dY2Jci40gVwua4EvF7SH03sU/m21HZkk9MX+kq2gOuVMAqEU9eWsZcixPrWMiYcMgqCV
         cNP8uXO0bU7RbdEXmuf6LDIwQ4tJ4xSe3YqEjRT4Dx7DLrTWuuhje1vVfwdRHbriM8+P
         QQOJaG4tvP0wfyg9rcBYVCu/EP0ciDW+OeiEL9UanV614RxxOmh6d4vBaLu1Nkcvob84
         jtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876989; x=1730481789;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UfqlArFfChSnPcH7RDY8Nm7G762SilyEqA0ClwBRXCc=;
        b=Mbyoee4E9drCGcULwrVkReL+BOBf9SkTmvqz+Ei9nm/BiDzo2Xrhrw7yqmhvIW/6aC
         JE3cZl3pyVSZ+hWrWxhk15s9syFKgLSw2CFMu8kbyNUD4auFQejPtUxsDTP9VWEJyXsW
         LKtEhHF+X1arr8B5bZgEqxiTbKeVt/R7HP3T1Ahs3jzVdUvi2cTGDN/7fYJjeOneper2
         ugtCjaSefxTblPQnfkXVQk22gZKR8K57Xa0zcdrSnRB4uSWDiung+RND3k2Wnmyd4GcI
         n+U/CrQ/CKFpfU6BUyfM+qOUq0vUtvMCsHDiaBQxNl/117qeNg/TUHRYPK/NLnIyyxO0
         hlTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGGVfxqfZVTe0Gmd2OxwkCu+460T3sXxy1wukez554C5AALNiLK1H0pDK9A6bYnkBkvXN1lW/xI2NZwv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPnO8jTEZk+Tvr3rTUN1lNNgFqXKFUamVwFlxJnTF62n3R9MOA
	iU/8AaPdMU/R/vRGRdq8beSbKS8v2rsWBMRtRnaYu93lgqn+0mSSM1sQong1neqG+p/3eNS03y+
	9jxt1Sg==
X-Google-Smtp-Source: AGHT+IG0c8i0XzuFis0iYKAoQK1TYB3CJRJkBJ8l77PX7pZ8iakR5a/MycTRXZhjDL4y0M6goqFQhuWFXLTX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a05:6902:686:b0:e28:ef6f:3624 with SMTP id
 3f1490d57ef6-e3087b82cecmr97276.5.1729876989257; Fri, 25 Oct 2024 10:23:09
 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:22:58 -0700
In-Reply-To: <20241025172303.77538-1-irogers@google.com>
Message-Id: <20241025172303.77538-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241025172303.77538-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v1 1/6] tools/build: Don't pass test log files to linker
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Separate test log files from object files. Depend on test log output
but don't pass to the linker.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index 5fb3fb3d97e0..ffe988867703 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -149,6 +149,10 @@ objprefix    := $(subst ./,,$(OUTPUT)$(dir)/)
 obj-y        := $(addprefix $(objprefix),$(obj-y))
 subdir-obj-y := $(addprefix $(objprefix),$(subdir-obj-y))
 
+# Separate out test log files from real build objects.
+test-y       := $(filter %_log, $(obj-y))
+obj-y        := $(filter-out %_log, $(obj-y))
+
 # Final '$(obj)-in.o' object
 in-target := $(objprefix)$(obj)-in.o
 
@@ -159,7 +163,7 @@ $(subdir-y):
 
 $(sort $(subdir-obj-y)): $(subdir-y) ;
 
-$(in-target): $(obj-y) FORCE
+$(in-target): $(obj-y) $(test-y) FORCE
 	$(call rule_mkdir)
 	$(call if_changed,$(host)ld_multi)
 
-- 
2.47.0.163.g1226f6d8fa-goog


