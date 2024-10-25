Return-Path: <linux-kernel+bounces-382267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1289B0BA0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA69B2123A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2952217451;
	Fri, 25 Oct 2024 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oXMIeMnM"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF99217454
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729877004; cv=none; b=iBWkNl3mpC6Ld/h662foxYbwpder/9DHTithlo8h+tD6thb58fn9QLLxxnjS7qFlEf2iR/xccyBJQUrfZXcXoeC1k2/sBEJIS88zbwiDqCfd97lhy80ZKr43vwgKYTfQUPoRzEUnXoQ7AVAUbVfBPJRamil6VUdDpgvqLTZJTuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729877004; c=relaxed/simple;
	bh=f6QE0Qn9b12eCjBKI2V7KW/KAZe5l2VYiK5SexO5YnY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=OIJCwaTJUY6/wvQZdQO5X58CXe8RHYA3ko6viSqalEYzOvpEiT+cAQr57RgwWkGXKW31BZdaee1Gef57sd7v0KXIaRwCoMsc2oTL7m6kjSC91OPnM9pXxDRbft7OeYwfHc/kybP9nXPolcF7vRvLOIBdPhdy/KHQbSntCdjE2hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oXMIeMnM; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e291ac8dcf3so3999669276.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729877001; x=1730481801; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbqflGTx7CldhGCbP/KKXIEFYVyDlX4onDQk9rCC00w=;
        b=oXMIeMnMD10XQtgHxr3wT7uDSV2bIRBQgGkgjWcwpyzQcLvTFRXhOS3d1w24K91Yjz
         sN2Y6K1Hj9nmKpZglcwOu9zOUt3jZ+8huExmNyMzHaOu27THZ8fRLx7ItZdCSlsTyiV2
         0DS0aCkyPgWcCupNxuDm1tpGPzlCOEQwVHz7dnKXx7k0DqyF/ijJQlJboE1o7IXX0y7k
         xU8NEkNPHjsqGvaHlOyLAdJfxoSrcxWPIvRgMK3n/kA3cVLFvxFVK7yeNJZ49/EXDAiJ
         TbYkUlhknbgjlCzqTBQ6K+y6jWqMUQ7AZpRaVgiqsmoy03opZwYZzA1mweYApU6AQ5iB
         N9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729877001; x=1730481801;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbqflGTx7CldhGCbP/KKXIEFYVyDlX4onDQk9rCC00w=;
        b=oGpGNm5lLcb60B2bcwle/eBufFh1Yuo6mhQlk+J0g4fFEAuekYk1n/jGE1kYrID0Gv
         VISk3TG1P4oCPM2yNnzmmLZ8w8RXKIeXm346tNJQnmhaLNboUqqenjr74Rb6a2y9g86f
         rQbTTvpgyQ4XrPKsj5p40L8dfr3rRgBNOkkOUcLupFlxUXvBDerj9CxyUPQXHcoseUVZ
         Sptax4ku9cYFddWxhGewZd4w/TkiNlVOi9GHsoiGLpwcakf9L7PHS6OsrjMHLevvE7Nb
         K6zHPFUF4hctRg/FWEiVa6y1Q7Fd8EgGUnyDzAv1w8JbK0iICEykNVPsl9GN0Youxt+0
         boYw==
X-Forwarded-Encrypted: i=1; AJvYcCVSRhRkdG7Fg9hR+TKZyc0a8stZMAF/Fnu6vsdjT1/hNWdp/juDC06HxmfxpaD8LXplJMALT9yFw41iQp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSMfNZmP7HO/RQM3I16lLGgpmFJfJT8gFCm+mI5t01r44g8D4m
	MwMu8xQSc5CrWDhmM4+YFg0VyxsL/565OQWgSWDGW1OcHOH5ZYCn4W1uhKt31T+/tuzuOSqnSKY
	3NMNA7A==
X-Google-Smtp-Source: AGHT+IGANBTbxP9uqUtLEAG/z+bqH1Yapu9/gBtTn5hF7Sva9IgdS4fCS7fa0s1vcAX4O9hvRjxKwcj7Zh58
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a25:6b11:0:b0:e2e:2fe8:2d0b with SMTP id
 3f1490d57ef6-e3087b69f72mr177276.5.1729877001252; Fri, 25 Oct 2024 10:23:21
 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:23:03 -0700
In-Reply-To: <20241025172303.77538-1-irogers@google.com>
Message-Id: <20241025172303.77538-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241025172303.77538-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v1 6/6] perf python: Fix setup.py mypy errors
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

getenv may return None, so assert it isn't None for CC and srctree
environmental variables required for the script.
Disable an optional warning related to Popen.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/setup.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 649550e9b7aa..dd289d15acfd 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -3,6 +3,7 @@ from subprocess import Popen, PIPE
 from re import sub
 
 cc = getenv("CC")
+assert cc, "Environment variable CC not set"
 
 # Check if CC has options, as is the case in yocto, where it uses CC="cc --sysroot..."
 cc_tokens = cc.split()
@@ -12,8 +13,13 @@ if len(cc_tokens) > 1:
 else:
     cc_options = ""
 
+# ignore optional stderr could be None as it is set to PIPE to avoid that.
+# mypy: disable-error-code="union-attr"
 cc_is_clang = b"clang version" in Popen([cc, "-v"], stderr=PIPE).stderr.readline()
-src_feature_tests  = getenv('srctree') + '/tools/build/feature'
+
+srctree = getenv('srctree')
+assert srctree, "Environment variable srctree, for the Linux sources, not set"
+src_feature_tests  = f'{srctree}/tools/build/feature'
 
 def clang_has_option(option):
     cc_output = Popen([cc, cc_options + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
@@ -71,7 +77,7 @@ else:
 # The python headers have mixed code with declarations (decls after asserts, for instance)
 cflags += [ "-Wno-declaration-after-statement" ]
 
-src_perf  = getenv('srctree') + '/tools/perf'
+src_perf  = f'{srctree}/tools/perf'
 build_lib = getenv('PYTHON_EXTBUILD_LIB')
 build_tmp = getenv('PYTHON_EXTBUILD_TMP')
 
-- 
2.47.0.163.g1226f6d8fa-goog


