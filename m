Return-Path: <linux-kernel+bounces-444691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C119F0B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18325283309
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E731B1DF739;
	Fri, 13 Dec 2024 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ciiw3bD+"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7838E1DF271
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089510; cv=none; b=bOVuldiwoV4fXhHW+BOVU7xD97Tjb+T7u+gb3ng8tmQH5HsuOmJMk1iCSEnxOgfEFWmnLGDdJzY4nXsMLvYobnq/9LwuIgOLfx16kGFgJd/kaYbuetL+NE2RnatmxYt6x8BXPmOsn62v23JG0ITaTEp/1sAhu8WYAAb3RlnoaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089510; c=relaxed/simple;
	bh=RL2+sa7FqlB5keLFzemHFNSTwj0vyUQXIodq1LlTmxg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vDnfzhtIfpAK6OgMnJi33gWZ2ZYOqEKYictvYezPFkZMr5vsblJqRqa5zSh88mErJ/r964nYtVujmTo2W7bUDNuPhoCri5aIahNwKNcdz55gqAkdCoUjgfMxReL1DP/iTJ2wNuQisfdfQWTS2ew8KFiP9ld9vby3Seuu281PL58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ciiw3bD+; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43623bf2a83so15325425e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734089507; x=1734694307; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A/liT58PKYw7HwtStWEUG+08/cDBkM9nfVGzjd6G6SU=;
        b=ciiw3bD+HUhNW8rAO8St0Zexrb7QFz3QeKpShEz/GzF8uyLrab0p/S0AIuraQEF8mP
         bVo3TKDKUvkOMAg15dNPWsGbMBcPx75YOBKHIL0H4bYXIx/zq+O2EBL62EWGcSYL6VDK
         sMTtsh5xkBIiEruINv6X0tf33lEkZFKBuH5/HVCWfQFQRJirsIoDT534/tKLmvmVSENI
         dl1DEMLZ79qd3W0A9Mgab5iwB7Ej+gsShnP2AOy+gL/eEeiiuH0FFqDV5N/FjcUwRkDa
         H57XjidmIQbSLnrVdl6m9WjONeCMeayTh8XEz2o+0h5oe/MQI0xzp6kjpneYdWHuzELu
         PaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734089507; x=1734694307;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/liT58PKYw7HwtStWEUG+08/cDBkM9nfVGzjd6G6SU=;
        b=HTH2KUxDky9UbZ1wEI11TOVOfKmX8BHBBv+tlzSWf8SlP6itkUta2isjUeGyk12I6M
         SSY5aiImmhTsQARCj5ZDuEQYzotTvqFp0teSrJp4zSdMiX5Zbc7/9Rk5Qa8gU3hrLS95
         QUumvVtEJjnAQnDBXep0ds4sDQrHqImOKHxH8AQMVoDY0a9BmcvvK1mQzBZtjIyp8v8N
         8+mBwnexKxYS+h1IDmTGHagFJVSFcxLG5iEsP6Jo5iPWvHTkH82T7ruUUfvjfce5tu7T
         0/bObosUAOEGtf92Pv1z7xZiXHRpXcKKkyJVt+UuFuqI/SkXKgWhcdOkAGZROQyAaZSU
         Qy4A==
X-Gm-Message-State: AOJu0YxHsVYjtS3EQA+NM8n6DJbrAQYPzfqADkiRRk7UDAgNGhBRSx6T
	8ZILL9P1ee9YRO0XarN1ASSxalsG393uUZJu945IXFWIvbJzSn4Ywlwk1bFU7Cq7fFIAQ11M8gf
	LOC6yoc2bqg==
X-Google-Smtp-Source: AGHT+IH7cHlQeRy1xZRu5M7RBxGpX53bIPU0Rj1rBgppyxRggT+ne4NlBEvps3MOKD7DTPzL3SAILj1cLz/mhA==
X-Received: from wmbd13.prod.google.com ([2002:a05:600c:58cd:b0:434:9dec:7cc5])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:154c:b0:434:ff30:a159 with SMTP id 5b1f17b1804b1-4362a982c34mr20114835e9.0.1734089506939;
 Fri, 13 Dec 2024 03:31:46 -0800 (PST)
Date: Fri, 13 Dec 2024 11:31:30 +0000
In-Reply-To: <20241213-objtool-strict-v1-0-fd388f9d971f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213-objtool-strict-v1-0-fd388f9d971f@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20241213-objtool-strict-v1-1-fd388f9d971f@google.com>
Subject: [PATCH 1/2] objtool: Add --fail-on-warn
From: Brendan Jackman <jackmanb@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

At present objtool only prints to the terminal when observing "fatal
warnings". This option lets you have it produce an error instead.

My use case for this is noinstr validation; so far I've never seen any
false warnings here, but it quite often detects real bugs. I'd like my
build to fail when I have those bugs.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/objtool/builtin-check.c           | 6 ++++++
 tools/objtool/check.c                   | 7 ++-----
 tools/objtool/include/objtool/builtin.h | 1 +
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 387d56a7f5fb8da8435d0a3f5c05eeee66932c9b..dd70cbb98929b7f558c27766bda46ad276c0750d 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -94,6 +94,12 @@ static const struct option check_options[] = {
 	OPT_BOOLEAN(0, "sec-address", &opts.sec_address, "print section addresses in warnings"),
 	OPT_BOOLEAN(0, "stats", &opts.stats, "print statistics"),
 	OPT_BOOLEAN('v', "verbose", &opts.verbose, "verbose warnings"),
+	/*
+	 *  For now, don't fail the kernel build on fatal warnings by default.
+	 *  These errors are still fairly common due to the growing matrix of
+	 *  supported toolchains and their recent pace of change.
+	 */
+	OPT_BOOLEAN(0, "fail-on-warn", &opts.fail_on_warn, "fail on fatal warnings"),
 
 	OPT_END(),
 };
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4ce176ad411fb12a10101bbedbb6180275941b4b..266896b46e92c5c4a3244aa73deb3a355e6d8f8d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4941,10 +4941,7 @@ int check(struct objtool_file *file)
 	}
 
 out:
-	/*
-	 *  For now, don't fail the kernel build on fatal warnings.  These
-	 *  errors are still fairly common due to the growing matrix of
-	 *  supported toolchains and their recent pace of change.
-	 */
+	if (opts.fail_on_warn && warnings)
+		return 1;
 	return 0;
 }
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index fcca6662c8b4b5e0048e54fada8694cc2e6ebc34..f9af81ad9f600044280085cd1a743609ce054a21 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -38,6 +38,7 @@ struct opts {
 	bool sec_address;
 	bool stats;
 	bool verbose;
+	bool fail_on_warn;
 };
 
 extern struct opts opts;

-- 
2.47.1.613.gc27f4b7a9f-goog


