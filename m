Return-Path: <linux-kernel+bounces-316334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B0C96CE15
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD8E1C22104
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 04:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D87153BF6;
	Thu,  5 Sep 2024 04:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b="Gnbn8lh2"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8D914F11E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 04:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725510884; cv=none; b=tZZEpGCB9Zr799iZJURr7hu/3cGUuy8Ew/Qvjlb+vHn8h77gkCBKI/bUJZQkAet9Dr3K26WHNQk5Kci6lcQ/Rgyquuurca5DyL0exEG7L08/EFaXCHNgW7+wjmxKP4jsq3cpY8rBCEsHUGr/kK+cJjbh0k/8bfFzNeEAsWz0Urw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725510884; c=relaxed/simple;
	bh=8IWvP1Qy4mBHGbKYw9Ffftawr3e2vV2Wls3M4VinXRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwAt5YryDvTdIgplqhhqx1o1l05m6MoovhQId1hT6QTaOBo+uFKbx+a7BZc3r/y7gUus1kS03RLUF9zUEMIxjFymO3SGpTHTzSQkP1T+p+OyVCUyP3i5y1Df22LVPwdYGsaxlSYRAxqR5a0kkT9YR8p2l5wb82+SM1Y9BUJJkgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b=Gnbn8lh2; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4568acc1ca8so2157761cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 21:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20230601.gappssmtp.com; s=20230601; t=1725510881; x=1726115681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJxcrlRpA7xjaDp1f7t4aVNh8eR9s342zQrnnOBKUEg=;
        b=Gnbn8lh2kuya9hMRYu87gr4Nv/2BiVveUixbwkiPBbQKMGPEAGHLItMUWSZadTIUp4
         qcOsFK5zuyTnISjiCXXxNL3KeI8C3+iaCEJbiYp/2hsoesRQgiykTB27vjzdT04A+Ad5
         T5Y9XHK4jmGf5emChyikukyjPgD+DD3rOx0tZACVPi1ajrvQfbsbZTVQDo7BBxYiBCtC
         +wZzRtyX8i4hnX8boxBShinjiuLAj5blbdmwdC+TpScXDet3/z51GyAm0Nb2xT/jwOVn
         ywEG2SwppiHDuZNQvpcCIrsjzLnizXOGkeorMlu3y15I8n+NRkgpN4jsAp8YISpAZhFp
         Ao0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725510881; x=1726115681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJxcrlRpA7xjaDp1f7t4aVNh8eR9s342zQrnnOBKUEg=;
        b=uTZ0VD34ZHYeIlF43c4FMQ0Qpx+lVej4kGCrAX9tdTlMmXLVL/zBE90JsPUg6ji8J1
         n/IXYG9rIV3jaIENwSbsA4N3WgbeQ28lXJt1chwToY3ulyOQ+6rd1jhv0YCFTR511I76
         OxQtKR8ZBXxTFhOjYx+CO6b+lQSQXdksVDPhAzYU3JjGkDFSM/66sA8NTkYW5gc+DgHr
         mawhM5NiUp/m5pzhsmKoBnqctICHbFAeNd5dAJ00a8z49AedMAnHGeZ8NdnvNwq/vgjX
         OxXk2gktXPPeqiDF26Cklz5TQqDvYX35Oq5ogtmrRtgaitpj/h/N9lRXtNV+xDG1eFwR
         ar7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWcETDqtrZE9JwAYXgbfCWJVeuPrU8h8iYw10ci8E8OZLFy6rgeAnWlOtQVViKB8G4ZyZeCoW52y9OjPMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXY83Csu62arnNDKznhkjnSVCE/lHicCmqHVoA4bLrXqzk4G9/
	qXXnGzF6cmlmFcki2tNLMRpffqvfGXMhwh9HjC9i7mtqelcC0ZQbF2s7Blw6sw==
X-Google-Smtp-Source: AGHT+IFj3a9cchP0/vieZqbkqznpCBKGRkfgZYOb8Jn2LlQ3lfAJzRpY8vMS81DOZGJeiUwzkUU8QQ==
X-Received: by 2002:a05:622a:993:b0:456:847d:47a5 with SMTP id d75a77b69052e-456fd7da328mr225326911cf.38.1725510881546;
        Wed, 04 Sep 2024 21:34:41 -0700 (PDT)
Received: from node0.kernel3.linux-mcdc-pg0.utah.cloudlab.us ([128.110.218.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b4cf4csm4182341cf.48.2024.09.04.21.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:34:41 -0700 (PDT)
From: Wentao Zhang <wentaoz5@illinois.edu>
To: wentaoz5@illinois.edu
Cc: Matt.Kelly2@boeing.com,
	akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com,
	anton.ivanov@cambridgegreys.com,
	ardb@kernel.org,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	chuck.wolber@boeing.com,
	dave.hansen@linux.intel.com,
	dvyukov@google.com,
	hpa@zytor.com,
	jinghao7@illinois.edu,
	johannes@sipsolutions.net,
	jpoimboe@kernel.org,
	justinstitt@google.com,
	kees@kernel.org,
	kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	luto@kernel.org,
	marinov@illinois.edu,
	masahiroy@kernel.org,
	maskray@google.com,
	mathieu.desnoyers@efficios.com,
	matthew.l.weber3@boeing.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	oberpar@linux.ibm.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	richard@nod.at,
	rostedt@goodmis.org,
	samitolvanen@google.com,
	samuel.sarkisian@boeing.com,
	steven.h.vanderleest@boeing.com,
	tglx@linutronix.de,
	tingxur@illinois.edu,
	tyxu@illinois.edu,
	x86@kernel.org
Subject: [PATCH v2 3/4] x86: disable llvm-cov instrumentation
Date: Wed,  4 Sep 2024 23:32:44 -0500
Message-ID: <20240905043245.1389509-4-wentaoz5@illinois.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240905043245.1389509-1-wentaoz5@illinois.edu>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
 <20240905043245.1389509-1-wentaoz5@illinois.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable instrumentation for arch/x86/crypto/curve25519-x86_64.c. Otherwise
compilation would fail with "error: inline assembly requires more registers
than available".

Similar behavior was reported with gcov as well. See c390c452ebeb ("crypto:
x86/curve25519 - disable gcov").

Signed-off-by: Wentao Zhang <wentaoz5@illinois.edu>
Reviewed-by: Chuck Wolber <chuck.wolber@boeing.com>
Tested-by: Chuck Wolber <chuck.wolber@boeing.com>
---
 arch/x86/crypto/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index 53b4a2778..57f3d4921 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -119,5 +119,6 @@ quiet_cmd_perlasm = PERLASM $@
 $(obj)/%.S: $(src)/%.pl FORCE
 	$(call if_changed,perlasm)
 
-# Disable GCOV in odd or sensitive code
+# Disable GCOV and llvm-cov in odd or sensitive code
 GCOV_PROFILE_curve25519-x86_64.o := n
+LLVM_COV_PROFILE_curve25519-x86_64.o := n
-- 
2.45.2


