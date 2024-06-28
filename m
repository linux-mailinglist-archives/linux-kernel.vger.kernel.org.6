Return-Path: <linux-kernel+bounces-233824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C260F91BDC8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49820B2328F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A975A158DAC;
	Fri, 28 Jun 2024 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KS5YUiOC"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733C1158DA7
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575322; cv=none; b=Ez6+Wfc+vJmcv8HelSxx+hZEcOA/1gwXZ9vIORfLnJaARs4h1tmlOBoznpIR28BzdYg94kaFp8Nch/VPOL+10AqWd0ljkrQKGFlNc4sGJMUyj+xh+YRAp3hLBKtDDQWD27EFgrq3pu2CN9AendwxLPinoD8782CfakbLTXLFQKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575322; c=relaxed/simple;
	bh=EqvmK9erXdF03YXwNF5KKlTIlFwBGkwfT2afCjCPw2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R65fKqcQBYBatf+WT3dryKiALxiV0UJ2j3t3leAnEjEOIgXIxuq3tTG4IdjWJ0lhkR6E727hMCJlZIjbW8dMr561WQZq73jgmKJF+Ix8gg0WAzKHJneQbOp6aVDyRORMisTBMLzncW1x96obS1uZjNMtYfo8ERUUyZvPqLgXN2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KS5YUiOC; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-25c9786835eso264150fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 04:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719575318; x=1720180118; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cVz6x8zHD2e0o5+zukG3kv+msINNXHhJ2RLc+xaoywE=;
        b=KS5YUiOCKXmH6/KkTDKyoiJiK90z3pggHKwTtomy/mC+J6ijlWoqmiXDSULgcFxxHY
         vr7BJcihIHYFX1yEfRbHhvpa6VgYTdfvfC55Vz93rX9Ia6PLjFuwC8Vj4XXnCAFza5Ux
         McEvf8AyafLDP11tseDn5HLZpoxDhkOuEQKUiQ/xCMfpzyWmyY1ZCGDePcESY6NNjF5N
         7lTrp2oOzD4nU0jJd3zHFaONbENRO5o3ZV8jTUQZQU070ANwknf35uj6mPp7GETQbrwf
         YEW8nwxxCYif/1FkHYQ1W5BhXZge+zT0emFrj1v1doTOM4wy23saXNPnEjdoAx6pM2vu
         jS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719575318; x=1720180118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVz6x8zHD2e0o5+zukG3kv+msINNXHhJ2RLc+xaoywE=;
        b=qPLfOITwFBr41hiV6iMyi09rbpggpTY2tcl4e8JdYjnMv7usoCNg6IrdnhAfTVLOXY
         JX4JDmYKVzbLqS9fv4W30qybhT46O5ef5IZu0+eI2MxgEimI2qOcBQqew+JhVRA4RQkK
         DM5fAXwtt5u/Ccv9b8fKRFdJd880pI+vS4AEikVrKYOoViO2Z82yycOaTa2FlhxYFr3e
         JWM2nx6HKufXkwX/DHeWHsZ7yU7hJJsYBIc1HW1G/g58sXlyAutzEafC83AyghFKEGER
         mkppJfhczLHJufSmHZBHO8SrzXHeImihpOOgVE58QPJaMEkEGWlN5XPSJusVXyjMx/fh
         9yMw==
X-Forwarded-Encrypted: i=1; AJvYcCUfl6XSdRv0DUxmonVPhUFSIyqRAYHaFlPzhhPU2vTHwgaQEOfalw5yFt8PetnusQmtwoPvKcwTTHIFKklV6Wz80x88x2PlAwv8yW8f
X-Gm-Message-State: AOJu0YxjhxurEb53gI/DYGzjCHtToS3NZ+wFUSKKO4cLJO55Jmf07VTe
	oS0J/xKoV2AbBFrjDSI9rb2G5mb13UXiNd1Wa3e2QWj4tI5W41UKIxK8nvS2Kvk=
X-Google-Smtp-Source: AGHT+IFOBKDdLVvGH5/U1B4nvMFkuWHQzKcK9o5xnO1lPmAh4a3+NRC7pmcUXvg9Bib/B2yboEQX6w==
X-Received: by 2002:a05:6871:3a11:b0:259:8671:2530 with SMTP id 586e51a60fabf-25d06c5118bmr17606779fac.25.1719575318592;
        Fri, 28 Jun 2024 04:48:38 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecfb90sm1377775b3a.139.2024.06.28.04.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:48:38 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 28 Jun 2024 19:47:49 +0800
Subject: [PATCH v2 6/6] riscv: ftrace: support PREEMPT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-dev-andyc-dyn-ftrace-v4-v2-6-1e5f4cb1f049@sifive.com>
References: <20240628-dev-andyc-dyn-ftrace-v4-v2-0-1e5f4cb1f049@sifive.com>
In-Reply-To: <20240628-dev-andyc-dyn-ftrace-v4-v2-0-1e5f4cb1f049@sifive.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, Zong Li <zong.li@sifive.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Andy Chiu <andy.chiu@sifive.com>
X-Mailer: b4 0.12.4

Now, we can safely enable dynamic ftrace with kernel preemption.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 55c70efbad0a..881ea466ff52 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -139,7 +139,7 @@ config RISCV
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
-	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
+	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
 	select HAVE_EBPF_JIT if MMU
 	select HAVE_GUP_FAST if MMU
 	select HAVE_FUNCTION_ARG_ACCESS_API

-- 
2.43.0


