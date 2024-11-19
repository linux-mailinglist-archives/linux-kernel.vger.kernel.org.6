Return-Path: <linux-kernel+bounces-413790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BD89D1EBD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 04:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701DE1F2248D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9927C143723;
	Tue, 19 Nov 2024 03:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CkcS5hAi"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE4E5A79B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 03:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731986280; cv=none; b=NJwGO9Up2/oH8DaNqOEgWutPvmRKDKkPvAghSMFpm/JGpO+4FGKNo1YhdTVjmRu2xWwbksdOdrN4xz6whyaCjn99icR3h1XIR3fpieu4/d3phjRXgn7LORAA4Mio1Rai8MFP3Ee53YwtWBRuKrp+GlCR7HxWinG0d6NMolsAJT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731986280; c=relaxed/simple;
	bh=j6j/QSrHuZ9HgIm5nspdgUSPYCy/jyVLxft6qIl05Sg=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=j0NRQPeDygP0vFh03f9KM8mMj3LDF4VhJkHYXl6exk08C/A0CtUcE6X6c4NFKsQd0Xpdg66gua8V5GM1XPJD42trVF6W16juIt4/YUy211DFXwwhe/LkZrtKrCJG2G5YWofH7ihtqqEeMFzhMlmJMsbtpZXXcegcF34YRo2pO/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CkcS5hAi; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30b8fd4ca1so6609773276.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731986277; x=1732591077; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1RCuIlrxYD8lSNZlNv4U8SFaDpGnr+ycFJLytVXPQ34=;
        b=CkcS5hAiskQBZnoQ929cgRtSP18GyCR7ePAG3s4yEqhswtlVr0MckwApgXSygmoAWm
         wsvgD3XnAnZkt4ECRBCVd+ytK3EC9XcpksbB2Rk4lLM+g/4qO2NHg6iFR1ekyNTg51g9
         or03GdL1gjzjJwE1uRTrEMErNNcJ4ffJ+7pxIKf3mslElrhM13FcV6p4pYxLC2vlB9A6
         1/9YcOAxZ1PcDbgDQDNkXGts3VEtvg4nCbYb2QJn7LcJUsdjwo5Zo2BnDw7+Fry9CWZD
         oxUgp7G1psR6bS9TwRSJE32aVBAzYV24JuAOOK+Vz4sYCQuzdHAKFaix5V6eSU3JO0fn
         qdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731986277; x=1732591077;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1RCuIlrxYD8lSNZlNv4U8SFaDpGnr+ycFJLytVXPQ34=;
        b=M6F5DKoM2wHCFCQmtXF+Lrq0necuMStQcqscjfo404waCHJZ/tQ6SqsYJdeyxsX8uK
         McpzoW2Z5QbV4l0J83u+dg+9mr6zLFYqS769kmzf7DLWfKReHVzJvjK7GOOkddPgaali
         saICVqvWNsTiMZXaRedvJvu/3MBmF+8/Ixwvi2tPLWXqebuWiizlOSqcXO6P4jZNCq1f
         fddYNqMbZUHAOphuU4d+kPezzPWfDxs04X8OzB0X4l/ncE2xUTD9usDRedIcKmLqeqC8
         F9eO9uXF/DwewSYAl0GeBCm83A6+zrXQdCkOKnHu0P7p0RY6QDVxB5e8YZ0fAjbp6rOG
         3xSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDShQe52SyeHki3DIp1ELAiPnf2YdGzFxX6oYV6PuWlzIntUTTMzv9fV/WF+u09gUtLKUVNRHVTJm4bqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpxAgXcdyK6KDpjAe1gl/kBVlxZl3boL6JnuLjgLv5ABg4O5sv
	kqnfj2I8/MhFiRsTo8ipl22krrehvFYgQ6F6ok3s6zGjgtSyj+4r5OWDJYgk9v8o9ae7e9VV7Zn
	zJlCCCA==
X-Google-Smtp-Source: AGHT+IEGdsKxODGCbPwfMgUpN0LavElnl1I0LvvCVh1DqytQ5PcbMn6WRMgJN2ZuWmUjHZqKx/WA+JUBzKF1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a05:6902:1346:b0:e38:b45e:b192 with SMTP
 id 3f1490d57ef6-e38b45ec2f1mr1265276.8.1731986277572; Mon, 18 Nov 2024
 19:17:57 -0800 (PST)
Date: Mon, 18 Nov 2024 19:17:54 -0800
Message-Id: <20241119031754.1021858-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1] perf symbol-elf: Avoid a weak cxx_demangle_sym function
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

cxx_demangle_sym is weak in case demangle-cxx.c replaces the
definition in symbol-elf.c. When demangle-cxx.c is built
HAVE_CXA_DEMANGLE_SUPPORT is defined, as such the define can be used
to avoid a weak symbol. As weak symbols are outside of the C standard
their use can lead to strange behaviors, in particular with LTO, as
well as causing issues to be hidden at link time.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol-elf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index e398abfd13a0..66fd1249660a 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -287,8 +287,9 @@ static bool want_demangle(bool is_kernel_sym)
  * Demangle C++ function signature, typically replaced by demangle-cxx.cpp
  * version.
  */
-__weak char *cxx_demangle_sym(const char *str __maybe_unused, bool params __maybe_unused,
-			      bool modifiers __maybe_unused)
+#ifndef HAVE_CXA_DEMANGLE_SUPPORT
+char *cxx_demangle_sym(const char *str __maybe_unused, bool params __maybe_unused,
+		       bool modifiers __maybe_unused)
 {
 #ifdef HAVE_LIBBFD_SUPPORT
 	int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
@@ -302,6 +303,7 @@ __weak char *cxx_demangle_sym(const char *str __maybe_unused, bool params __mayb
 	return NULL;
 #endif
 }
+#endif /* !HAVE_CXA_DEMANGLE_SUPPORT */
 
 static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
 {
-- 
2.47.0.338.g60cca15819-goog


