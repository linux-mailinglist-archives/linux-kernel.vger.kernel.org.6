Return-Path: <linux-kernel+bounces-382858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694E99B1414
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 03:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B49AAB21A21
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 01:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E195FDA7;
	Sat, 26 Oct 2024 01:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2OqoXFDX"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBCD217F2E
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 01:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729906994; cv=none; b=RlWjTGNu6lnFALyawfltwvuztONhKH9YoxSvuOMAqdsr5fB83ejhLaAsNobVHpHgL4yX3jvPt27fd/u9WJ7a79f2WW9PYx/DmzcJR0EyAznUGsyMjyh/KPvsroKyVUeDLML2OtSG9S7Img2AJfvkS5XEfaAeZ1cnSdKf9lZqqUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729906994; c=relaxed/simple;
	bh=kaNuRtju45HeRlSVWLhtnnC7/03sbNNUitldMnHJZuU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=tS6eB33DgU4eAY775LMZn1l8YOr7rFUb+MJBpB8I76VPRMn5X5fuiY6thDgbTM+blKoAHOTLOXX3RVVUX3ZP2dA8rxHR9HIRXx/QXEXawnF/tQ80hPEuKK3ZeJxOZHl8h12WbYggRC2xdHneZyG6U73CAOlcQDe5bnuMvhyK/GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2OqoXFDX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e59dc7df64so32684537b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729906991; x=1730511791; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ABCkax6iBr4pBLmb70Y7jnkGOHiVbYsTcs7q2+JUIpw=;
        b=2OqoXFDXevverhddh/vJlMPiieUOad+0cP35oLOClLeuTCBrHhMRU9hUesr+bBH3/O
         EPshfn28H+Om2c3TLBXauOU1MUfq9wBq5Xn1/FX7MbeXRT9B44mw1xridOl8c+JzFL7a
         DBX32rC6ChUyaaIW2YEMKjIJyQ/MWwnfQYrLIy1634xcKHAnnaqliv3FJrDYpepLm6Il
         oHHdXVegU8b+ivbFQ1vou6IaonlLYM8lQo4o3A48cFHCYpR4aCz5irtHCgJ7puYt9xIt
         rCiUqZe4jXkV+OkV8ZV0ylrODUvwz6oWGuhytgReUC/R0RqnmxJYTGeBQuF0KX5T23a2
         3dLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729906991; x=1730511791;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ABCkax6iBr4pBLmb70Y7jnkGOHiVbYsTcs7q2+JUIpw=;
        b=vSXbe5L7B7iPdTlOvmNXejiP0ZneJjw8b+ZoDkVRfsn+xdDwsktImllmEMArt0X5iW
         W6smJlNBxx4CO9C5HR8lttAz2S8SIB+3JD+cwealjAANA1GmwoVO70y/ffYgRlzTmoru
         6F0apBcPEvjlf8fY/LuNdPd3Ix3h0puLBYhr+LB3DnqLcwMEs/LmjHUSk7nKvuGNDsTn
         WYKnCG/LnyViRio4zuZ81F8URO+hmme7AVsffK+72vehKuAGML1zVTsoMDSoauITFI3N
         l0ApiVdr+K7Y223x8bP0hScRLMXzhHRCw2vTSnp/lmtGiXJMYJ8AIpYeTrl6MX9b7bPy
         qzsw==
X-Forwarded-Encrypted: i=1; AJvYcCU0Y9JWGEgGDDizFqiRzUlT22DZL7Z1oZv0dUot5Axs7axk3WGRPA304scJiNfb7d9DLdhugCd6SIrYAmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ/JIaiGv4RfM3ftfFYwKen308xUwFKRcBQrD2fE5XDh6UCEGX
	XsCbG2SHNwyJXtOr5hUQbmRThTRwttbS6iIEW+3uWXDG2I4rxIEex2XNYD27JqdJh7Uz4okaUXr
	t7nfa8g==
X-Google-Smtp-Source: AGHT+IFC/3+jcs19xorWhazJ28pT2ZwiS7jv9Z0M4w9hLSmjXpSVQtSWbTSfm4DDeXysKp74cIhI6koSA1gQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a05:690c:82c:b0:620:32ea:e1d4 with SMTP id
 00721157ae682-6e9d870c0e4mr213647b3.0.1729906991231; Fri, 25 Oct 2024
 18:43:11 -0700 (PDT)
Date: Fri, 25 Oct 2024 18:43:05 -0700
Message-Id: <20241026014305.233607-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v1] perf build: Make libunwind opt-in rather than opt-out
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Having multiple unwinding libraries makes the perf code harder to
understand and we have unused/untested code paths.

Perf made BPF support an opt-out rather than opt-in feature. As libbpf
has a libelf dependency, elfutils that provides libelf will also
provide libdw. When libdw is present perf will use libdw unwinding
rather than libunwind unwinding even if libunwind support is compiled
in.

Rather than have libunwind built into perf and never used, explicitly
disable the support and make it opt-in.

Signed-off-by: Ian Rogers <irogers@google.com>
Closes: https://lore.kernel.org/linux-perf-users/CAP-5=fUXkp-d7gkzX4eF+nbjb2978dZsiHZ9abGHN=BN1qAcbg@mail.gmail.com/
---
I think, once libunwind support has been disabled over multiple
releases we can look to remove the associated code. We should look to
do similar for libbfd and other support that is no longer really
tested.
---
 tools/perf/Makefile.config | 4 ++++
 tools/perf/Makefile.perf   | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b93ed2b7623f..707d7355ff18 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -91,6 +91,10 @@ ifneq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc s390 csky riscv loon
   NO_LIBDW_DWARF_UNWIND := 1
 endif
 
+ifneq ($(LIBUNWIND),1)
+  NO_LIBUNWIND := 1
+endif
+
 ifeq ($(LIBUNWIND_LIBS),)
   NO_LIBUNWIND := 1
 endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b4dee7c20ed1..d74241a15131 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -52,7 +52,7 @@ include ../scripts/utilities.mak
 #
 # Define NO_LIBELF if you do not want libelf dependency (e.g. cross-builds)
 #
-# Define NO_LIBUNWIND if you do not want libunwind dependency for dwarf
+# Define LIBUNWIND if you do not want libunwind dependency for dwarf
 # backtrace post unwind.
 #
 # Define NO_BACKTRACE if you do not want stack backtrace debug feature
-- 
2.47.0.163.g1226f6d8fa-goog


