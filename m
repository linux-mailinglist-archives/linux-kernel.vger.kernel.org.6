Return-Path: <linux-kernel+bounces-444690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0278D9F0B1A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62164188B5AF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D9A1DF27B;
	Fri, 13 Dec 2024 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RVgj51vX"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3F71DEFE1
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089509; cv=none; b=Iw6AP/h6SJVn80fpQnYTL7CMRXY8Hnv1hOwaT0BV17ciQCi2xx/2QfWoApNIfOe7QXQI9eoaiyhIt+iQzzw0vHV+Y1EFRyHaIN5WzZZfWFj6TBWCGfJ3PsyfxcBUdqB3lT2otN9c685gpxkFYClu3nZ6JypASExZgU8SjPbNZ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089509; c=relaxed/simple;
	bh=W5a6cB3UwDzqNZzNyudbL0vrce+OJhsWIXfqpLMWLp4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hqHKmgM5u846NjtdlFEY3cIK7reJxTwoITzbihXA9c6JoXWBzePN152D/HStTvbpqijn+0590zoNFpyABXjavt0DhYXtUWyoL9nJwE7PqUhKd48bzaomkB6yZqcoAtRud4iFg+ECO09ripz4u9C/agnZSwW75LxbrmUPKyPrM3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RVgj51vX; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-436248d1240so9624795e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734089505; x=1734694305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YYg3mLaT+yQeqG6suEsFLVIzOR+x8TvXmVVEyODmCqI=;
        b=RVgj51vX+BEe/H6ue0PjgZxpTsmN5DjjorSXFEoJxubXrU5RDp9VCZBqe4r+ImguQB
         56yejCXvfh77Z9yQY6NDsPzKS+xjLPPiLi1b7LFMDtrYIrWJuQC4/48IdNhZI/ETdvJC
         R5KMS7DLSVyD8NLuvNaJuCUIJ4XwavWE5mXwTgJbAHyZef91SuvNLW0XO4AblKqd7QKr
         nTd2RGC2oK5DqxXij2VlS8Vv8MRr2j2aD2peUvtJoEk0Ptlw1QAZHhh8ReKPDralAOjB
         PTPPGG4JFO8vYSf10G/djepglVQOggzLjj+ZYCzo6pZZtwAiCLJmkTCLSyW9hhTooQSk
         b7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734089505; x=1734694305;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YYg3mLaT+yQeqG6suEsFLVIzOR+x8TvXmVVEyODmCqI=;
        b=aYKV4r+55noIcrRbW7z76NuSSbu0zojV9t1FB1uM96gQ98T12CKkEsTsND9RqcudE/
         3GqPhRSBL9rv/Cwn490uOuOwndI6yWGjt2LT1GabW7YL28j+a86YpqX/vRIc1EgxD+qa
         vRGdHxOMKL0CEvgQfYH19DdUR4GMXmS+ViFqDHpKPWpVY+7GaAFfS7dNAi0cTaGclRZC
         Eqm0Gz73lPpXsaFwb9Bboj4lPOVZSCHUNuuorYIZsTszrK6zqcKNnemIBCSCbFBRFYrF
         PPoCZUwCT/ePv8RxA3qcAOUcbGZ5BSG3DJxsjr0GPpNKPlDLpbpqMT2Sghx851ryzV+d
         kw/g==
X-Gm-Message-State: AOJu0Yyka18Yq9G++b/+/AeWuaDNNCXQ8uilrq19bE4u6sOaEciDwdKL
	ZRadX2l6hO1ikflgGdfdk8jfp9zRpHRrrm4vHFOcWtkPMT/R8lb1LazXJfJayf5fb35uRWEGcuW
	nYuvpKx8OQg==
X-Google-Smtp-Source: AGHT+IEjuiLNGvyLP68ZBdiqZu95bXV2VW9PMTOSrerlRMjeGJtcFoJW1KVAmnQA4sURFOaBmw4QHXvsK+priQ==
X-Received: from wmbdx22.prod.google.com ([2002:a05:600c:63d6:b0:436:3ea:c491])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:378f:b0:436:1b7a:c0b4 with SMTP id 5b1f17b1804b1-4362aa1475cmr15538375e9.1.1734089505114;
 Fri, 13 Dec 2024 03:31:45 -0800 (PST)
Date: Fri, 13 Dec 2024 11:31:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABEbXGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDI0Nj3fykrJL8/Bzd4pKizOQS3eQky0SDRHNTQ2PLVCWgpoKi1LTMCrC B0bG1tQD+88SeYAAAAA==
X-Change-Id: 20241213-objtool-strict-cb9a0a75139e
X-Mailer: b4 0.15-dev
Message-ID: <20241213-objtool-strict-v1-0-fd388f9d971f@google.com>
Subject: [PATCH 0/2] objtool: Add option to fail build on vmlinux warnings
From: Brendan Jackman <jackmanb@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

This adds an option to objtool to exit with an error when it enounters
warnings.

Then, it adds a config to enable that flag on vmlinux. This enables you
to fail the build e.g. when noinstr is violated.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Brendan Jackman (2):
      objtool: Add --fail-on-warn
      kbuild: Add option to fail build on vmlinux objtool issues

 lib/Kconfig.debug                       | 11 +++++++++++
 scripts/Makefile.vmlinux_o              |  1 +
 tools/objtool/builtin-check.c           |  6 ++++++
 tools/objtool/check.c                   |  7 ++-----
 tools/objtool/include/objtool/builtin.h |  1 +
 5 files changed, 21 insertions(+), 5 deletions(-)
---
base-commit: f932fb9b40749d1c9a539d89bb3e288c077aafe5
change-id: 20241213-objtool-strict-cb9a0a75139e

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


