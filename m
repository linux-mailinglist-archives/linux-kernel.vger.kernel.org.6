Return-Path: <linux-kernel+bounces-323202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB0B973957
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABCF528857C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220D4194C8B;
	Tue, 10 Sep 2024 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gEsL2pKp"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154AF199231
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977082; cv=none; b=W2i+Ebs+pNirRsQOzrsbPhGbmtzmv1c1WG7p9/tDw1A7FJvf9udULOFzZ0Valf+46BNFLvlHv6YII0eAuPesd489Fr0uaHE0147SlevbGSNGUWWWohEcJsaVHkECIkfduqeJ+3iIebTpUi72Fa2L2q+LarQ8FWWhEfF8aLf8QK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977082; c=relaxed/simple;
	bh=OjtweS1q3V27F5fK6RgxbRa8U+kYLJ/fvAGK90ksCB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nzoYpxECsECWfNE6YV7EKU51BwBsuOrJ+B8L4uPWYJ+ymsCDNbuFrIy0MB+Vx1W3hIKqlq8urVWuZe+geguZbMk77TqNznVbe0s8LRXgnDW0dzCV0sq2Nr2fhXk/EJwPNU3I+HYXhfFbO/mNYc5o2oqbSxXOJWgseWwxvljo7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gEsL2pKp; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53661ac5ba1so887938e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725977078; x=1726581878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YS/maFmCMzAAa4s+MCdvfSFRa4peuXy1wJykcXIHmPk=;
        b=gEsL2pKptFzYFzlk4/YRhDLOOvxj76WgXwcVA3ciYClXow4Iu0pAet1Ne3qMa1V3gk
         IKKfropaemR4cyesZMZEFDut3xktIQp4yVJOzEhi23kPVXdE0N7gqsJA5srNUgVNImmv
         ROEt0vtlYwKTQ8c5Y7JelFa3G2sOdZsr5pppKi0Es+spf07Hc/uLWgWPclfW7xBoQqiO
         jm4IbpqRE/uMOn7X8cQDeufcJ7+Lr0tyog2rWFMY71qP5TfX/VM9jrBTjexjSIwUfS63
         RapVY2rOOWdfS1u15MQNVWrtooc5Hb8NXl6fgtqY5quRQJjEudEEL0Sah5kIZAR3hLHU
         tOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725977078; x=1726581878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YS/maFmCMzAAa4s+MCdvfSFRa4peuXy1wJykcXIHmPk=;
        b=uipcK5Cpp3AtSaUUGyPE1jACXG/r42gKxvFCY6+95hGeAjhqdFW1SNkSQmF7VI9Tiz
         PFvJMcJxDagGpdc2O3aXSPe+Pqxbuo4v6AVLLF7eWlqVKJpltq2SeEE+ywcc+YLh5YcW
         TWAvYgl7dcu6zIez3GvO8a37XfYd4DQCMrGKnHi2pI8T+41onQaWadHEOEeEHdQG9ORh
         76cEZyklhZuA/WD4JOTmhuCRDUALU13Grw7UDXV7k0fh66/xcS2HbSckswv+tF3frIsa
         CX8rFHjXgJgObT2BdDApgrRf7v6SeLdw+TfH2uqaWY5A1o6w2/qNN0yfpBkUHDQ/ydSX
         N8VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH3Bift6O7PSNrxasRcZK3bNLZDTUyrADKZSI8w21raEmm1vI7Itdbnm5HiLXtnArODUuwjoMSeDsMYJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPeLP51sUKRxgltGw2HoqxDEugqVL5LArQ9YeECOPH/ajZC6md
	C6RqYYVrwIyOa3xTrOHy9PmDU/IYC98l+yjFZRIhKurYPyqxA/x1Yah9ZJ/8KIY=
X-Google-Smtp-Source: AGHT+IHoK5woUUfrtzi8S8rwG8nObPbqRVcjsqfShnp3wADgkiTW2rnKUpQlo65zvgcisMPeXektZQ==
X-Received: by 2002:a05:6512:2523:b0:535:6795:301a with SMTP id 2adb3069b0e04-536587fce23mr9726515e87.47.1725977077413;
        Tue, 10 Sep 2024 07:04:37 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb8b7f1sm114787075e9.48.2024.09.10.07.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 07:04:37 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	sesse@google.com,
	acme@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Guilherme Amadio <amadio@gentoo.org>,
	Changbin Du <changbin.du@huawei.com>,
	Leo Yan <leo.yan@arm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Manu Bretelle <chantr4@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 2/2] perf build: Remove unused feature test target
Date: Tue, 10 Sep 2024 15:04:01 +0100
Message-Id: <20240910140405.568791-2-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910140405.568791-1-james.clark@linaro.org>
References: <20240910140405.568791-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

llvm-version was removed in commit 56b11a2126bf ("perf bpf: Remove
support for embedding clang for compiling BPF events (-e foo.c)") but
some parts were left in the Makefile so finish removing them.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/build/feature/Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index d6a98b3854f8..5938cf799dc6 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -74,7 +74,6 @@ FILES=                                          \
          test-clang.bin				\
          test-llvm.bin				\
          test-llvm-perf.bin   \
-         test-llvm-version.bin			\
          test-libaio.bin			\
          test-libzstd.bin			\
          test-clang-bpf-co-re.bin		\
@@ -397,11 +396,6 @@ $(OUTPUT)test-llvm-perf.bin:
 		$(shell $(LLVM_CONFIG) --system-libs)		\
 		> $(@:.bin=.make.output) 2>&1
 
-$(OUTPUT)test-llvm-version.bin:
-	$(BUILDXX) -std=gnu++17					\
-		-I$(shell $(LLVM_CONFIG) --includedir)		\
-		> $(@:.bin=.make.output) 2>&1
-
 $(OUTPUT)test-clang.bin:
 	$(BUILDXX) -std=gnu++17					\
 		-I$(shell $(LLVM_CONFIG) --includedir) 		\
-- 
2.34.1


