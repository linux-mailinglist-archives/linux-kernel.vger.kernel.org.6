Return-Path: <linux-kernel+bounces-401095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F84A9C15E8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C311F24204
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBBA1C3F01;
	Fri,  8 Nov 2024 05:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uNwzCuRS"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9197196C86
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 05:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731042645; cv=none; b=TyWuJrI7O7sCDxwvfTxi7f4ms8ayd9C4/tftnm2WwX3nEbHJzpaNPuZYWpMxFLljZuImMJcFt/1z+AUhxJb9WqBtBF/uga5VCvNNUaKom4+rNpV6ZEizBFIOIERrjYuR6gxCtvV/9lnbe1ln43nFh1qUfFg3aX4P36Bx/Jy8dZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731042645; c=relaxed/simple;
	bh=Yq1YwQgYCpmlssJrskTFSgD3vH6McUCJKDtujoaa7YM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=efvyp8XHvhXAExWV8RVuDqZfhmhdpl1Aw/DBC07U8PXYQvEUQkkUx+dO7YXnZqXKnaX6oIBKK9tpgrkl5cyQDfNk4/bA5UXRqYJiHP9TxcCuxNeIgN6gWTE+V74aOA/qFGPmlQ2ojsuyLexhN74i8osNzFN4YRu8YvF33E29gM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uNwzCuRS; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e32e8436adso25116347b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 21:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731042643; x=1731647443; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7tQ1L3QpbUskwFQP7JuUlt5UgFJLV/ai+rpO7iRmQ00=;
        b=uNwzCuRStaR+5Szet0B/KXfT0qks/Wuoo/31FEEVl7Y9yZd0cNlpp+T19mCXSx6C9R
         IxmzjA2ZRujGLhoo6ueMYqAHGALlirrYKbl2ApogSwLwUc5IDrWozdaTtIaJsGdjvsL8
         69rwLqgXgy2XhyccTKQ9M7DydKamGj9whGR9caYdeFqg50nRgSTYc8GS6liyXrk+w4Cx
         +q91QtJKGMCjG9YtPdGbeDpavEH3V94K7CefUDIr0dN6hgXuelL1bGhfLbNSt7vAE7Qf
         VqIfheLiJs5A3nxJnqfWjKM5KYZSK5yunzrBP5sEQzkFJRNQ1aoq/gxXcbwE87xWTpNE
         FWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731042643; x=1731647443;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7tQ1L3QpbUskwFQP7JuUlt5UgFJLV/ai+rpO7iRmQ00=;
        b=rhXDQORFllx8SBav3olTWH9WzkrWamPV77ZwX96j1IZxZOudadkuJ+H2vJwa9yOJrX
         NGFBPXNH6FEzCy/3Qd9eMqnuqnlwE7mU5gwKyP6A+JwUrOB2+DsaZGdDMLMXOkLm+OEo
         dnjr3h6qTgIwXINCclvUHcUgwOQn4S5cLu41vqW2wfTzkpBfQ9D2GYX6lTamFza9x9hv
         g6w/Bzj63EGphEMPkP1inO14O5iADoqv9s5xAGn0/jOvM4DsaZ7K751CSbh+HTkH7BZb
         /R2Pw/dx3YelZGNSV9NXx9fAlM9+O77ERk2mmmlm9BVR+qImdY0zFcKLHLwyp5Wdl5uA
         K0dw==
X-Forwarded-Encrypted: i=1; AJvYcCVgVWFknARg2X4ZjvLabLRXWwCOdBRcAVG5DqXEhQttIneH/vKNJCjkfKKMLczNU8kmkEWr81iYWENBk9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx4fw6+msy923CrxL0cw2SAIZnZcVq3LAJeQF+srM1nJiKfljE
	E6HUc+D+ST6dDrEfFdHuEZyZQ3DSUnivgcXRxiEgSWa+pYY0LoZYjxgN1Zk8y5zQcQ==
X-Google-Smtp-Source: AGHT+IHaHqfWXbqtq7zwFlKahwo2sjCXng6SVwY/38LfDsmjxFvxkfhDNrVTdIO2OlZ20Ep93DJFQow=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a05:690c:3505:b0:69b:c01:82a5 with SMTP id
 00721157ae682-6eaddff0e00mr262967b3.7.1731042642840; Thu, 07 Nov 2024
 21:10:42 -0800 (PST)
Date: Thu,  7 Nov 2024 21:10:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241108051030.2918950-1-xur@google.com>
Subject: [PATCH] kbuild: Fix Propeller build option
From: Rong Xu <xur@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The '-fbasic-block-sections=labels' option has been deprecated with
the following llvm patch:
https://github.com/llvm/llvm-project/pull/110039

The old option still works, but with a warning like
  clang: warning: argument '-fbasic-block-sections=labels' \
  is deprecated, use '-fbasic-block-address-map' instead [-Wdeprecated]

Currently, the option change is only in the ToT clang (v20) and not yet
released in v19.

This patch adds a check to the Makefile to set the proper option.

If the option change is later integrated in v19.x, we need to update the
check accordingly.

Signed-off-by: Rong Xu <xur@google.com>
Reported-by: Nathan Chancellor <nathan@kernel.org>
---
 scripts/Makefile.propeller | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.propeller b/scripts/Makefile.propeller
index 344190717e47..1a68ea0d1fe4 100644
--- a/scripts/Makefile.propeller
+++ b/scripts/Makefile.propeller
@@ -5,7 +5,13 @@ ifdef CLANG_PROPELLER_PROFILE_PREFIX
   CFLAGS_PROPELLER_CLANG := -fbasic-block-sections=list=$(CLANG_PROPELLER_PROFILE_PREFIX)_cc_profile.txt -ffunction-sections
   KBUILD_LDFLAGS += --symbol-ordering-file=$(CLANG_PROPELLER_PROFILE_PREFIX)_ld_profile.txt --no-warn-symbol-ordering
 else
-  CFLAGS_PROPELLER_CLANG := -fbasic-block-sections=labels
+  # Staring with clang v20, the '-fbasic-block-sections=labels' option is
+  # deprecated. Use the recommended '-fbasic-block-address-map' option.
+  ifeq ($(call clang-min-version, 200000),y)
+    CFLAGS_PROPELLER_CLANG := -fbasic-block-address-map
+  else
+    CFLAGS_PROPELLER_CLANG := -fbasic-block-sections=labels
+  endif
 endif
 
 # Propeller requires debug information to embed module names in the profiles.
@@ -21,7 +27,11 @@ ifdef CONFIG_LTO_CLANG_THIN
   ifdef CLANG_PROPELLER_PROFILE_PREFIX
     KBUILD_LDFLAGS += --lto-basic-block-sections=$(CLANG_PROPELLER_PROFILE_PREFIX)_cc_profile.txt
   else
-    KBUILD_LDFLAGS += --lto-basic-block-sections=labels
+    ifeq ($(call clang-min-version, 200000),y)
+       KBUILD_LDFLAGS += --lto-basic-block-address-map
+    else
+       KBUILD_LDFLAGS += --lto-basic-block-sections=labels
+    endif
   endif
 endif
 

base-commit: 0dcc2d1066150787017a71f035145c566597dec7
-- 
2.47.0.277.g8800431eea-goog


