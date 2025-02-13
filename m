Return-Path: <linux-kernel+bounces-512542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB72A33AA9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F4D67A26D0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4018020E329;
	Thu, 13 Feb 2025 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JRF2hl8P"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1DD20C496
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437721; cv=none; b=PwHPSPtK+wEwJ0bgZKksyW/y0EPstv85pXGUyky3HUxeR9CSuO36K2cX5LnF3jRr+iBRnIP0Hr/wIJugFSaefyC70CtZZWqdI3O+boHtX1SOuL/zNpe6OiLtKjzRkQ4I4M169EaoxDy23KNiA9m1iil3ORm/2pmwPW4fB2Ot88w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437721; c=relaxed/simple;
	bh=JrTATGJXLXPnfT36NRdWEwRMkJqStLNhLoyrpg87QNc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r6FkEVpcOc5/JniVoA06/8Iol5QwDgfxqZV9PJUXZyIZ8xzbP8hn0FjU6fDrIFvuusKUI5DLQm+GHtUr8GAhECbg5PEF4XowDG+EtME31TY7KGAWcx01D4ce41TMpe0etxbOEpOHrvcMwLlSdHMBjyEamFPLQtHk4f5AJaP91vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JRF2hl8P; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-ab7eb66ea19so68058366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739437718; x=1740042518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mjAFE95s2BudHj4Rh3WJBU6cX4YpZYt+tVJ8vz3xHhE=;
        b=JRF2hl8P1SI7/umMNjTPMuU9/9nXp9Wo8xBL6967oBCwX5cWX6zyTwhyHRCFn29DBA
         HQJJJ9PYWyGzufpItmr6VjPG4SFV3tlDUqL7YjViGR8Z6EqQ9EyjgeDV5hxqHh0SepGb
         HrA6uTxq3WdZn/eSeRV8kQ2atjlUiuAvp2JOBLzvofIJWep4vTkmOPtyrlNY62g0MPOg
         kXTpnKOCDmiBbfM+aQ9hchV8rwvhNzmT4W/vx8lDhoKudwbACOZwcfiqR7UHn+wwaxNm
         qO00MI9l0F+dnS4R3oJW3UytlZ9S4geJikZTb2WDyQvMOEFhLJn63LXrWtuA7Qxc8GPn
         E+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739437718; x=1740042518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjAFE95s2BudHj4Rh3WJBU6cX4YpZYt+tVJ8vz3xHhE=;
        b=HtLBOvedHL0saJUocGsQZiecq7PHeynWSHfEFtFlQnuTwMIJpLWQ1sbLd4qRdGPaVI
         jzakaERvABTh2OfTUF8bUpUjpmTphmaYuDunb7D/5Puo784AKYrpUjojK/bGUXt5UwYR
         8L/AWuKqNKwfv/MZE96kzCjmKgvNwGGlXKNtPbttLToLNWzC5I04n7txpaxOD2oouw3c
         hdb5YCP1NDmBIPop2Ms3Ir8F260FJsTsUVsU5WrBjqI1Fu73MTvBE1c94cw5icBLmBSs
         MEDG5ntwi043T23BOOuurfE1KCT68yP7p4PaKrpZ8TFnXzhl2YKAyu8skz8vspAk5hYL
         LMhg==
X-Forwarded-Encrypted: i=1; AJvYcCWS0XCJG76HkhC/Cl5KkQPybb0L3mEvRN99wRnP0zwxyE/nQFggWzlIXSALkOaYxZW1tiUUS0c9zf/ikTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsJT0EZKDSJLdi3UxiWswDFuO0LLViedZJLqo2peUMCqQNdj4H
	oKukfi27b88W1U2vimW3bayBOiy+o2XTzgMWmYgYU33Aph1Ge/HkyloBJKQITIwrMOhotKB8v8B
	d9luoDg==
X-Google-Smtp-Source: AGHT+IH9LwpfT04DDWtCH5j94A3cuMLdIHZO6FgVgF/BHCBKgnawOwnbB2bOallL0yYB74DsbmHNq/kAgJGD
X-Received: from ejdv2.prod.google.com ([2002:a17:906:2922:b0:ab7:a6ca:4d72])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:7f27:b0:aa6:a7ef:7f1f
 with SMTP id a640c23a62f3a-ab7f3325255mr587122766b.11.1739437718375; Thu, 13
 Feb 2025 01:08:38 -0800 (PST)
Date: Thu, 13 Feb 2025 10:08:16 +0100
In-Reply-To: <cover.1739437531.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1739437531.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <32b4ce1731126c88a2d9e191dc87e39ae4651cb7.1739437531.git.dvyukov@google.com>
Subject: [PATCH v7 3/9] perf report: Switch filtered from u8 to u16
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com, acme@kernel.org, 
	ak@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

We already have all u8 bits taken, adding one more filter leads to unpleasant
failure mode, where code compiles w/o warnings, but the last filters silently
don't work. Add a typedef and switch to u16.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/util/addr_location.h | 3 ++-
 tools/perf/util/hist.c          | 2 +-
 tools/perf/util/hist.h          | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/addr_location.h b/tools/perf/util/addr_location.h
index 36aaa45445f24..f83d74e370b2f 100644
--- a/tools/perf/util/addr_location.h
+++ b/tools/perf/util/addr_location.h
@@ -3,6 +3,7 @@
 #define __PERF_ADDR_LOCATION 1
 
 #include <linux/types.h>
+#include "hist.h"
 
 struct thread;
 struct maps;
@@ -17,7 +18,7 @@ struct addr_location {
 	const char    *srcline;
 	u64	      addr;
 	char	      level;
-	u8	      filtered;
+	filter_mask_t filtered;
 	u8	      cpumode;
 	s32	      cpu;
 	s32	      socket;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index cafd693568189..6b8f8da8d3b66 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -585,7 +585,7 @@ static struct hist_entry *hist_entry__new(struct hist_entry *template,
 	return he;
 }
 
-static u8 symbol__parent_filter(const struct symbol *parent)
+static filter_mask_t symbol__parent_filter(const struct symbol *parent)
 {
 	if (symbol_conf.exclude_other && parent == NULL)
 		return 1 << HIST_FILTER__PARENT;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index a6e662d77dc24..4035106a74087 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -33,6 +33,8 @@ enum hist_filter {
 	HIST_FILTER__C2C,
 };
 
+typedef u16 filter_mask_t;
+
 enum hist_column {
 	HISTC_SYMBOL,
 	HISTC_TIME,
@@ -244,7 +246,7 @@ struct hist_entry {
 	bool			leaf;
 
 	char			level;
-	u8			filtered;
+	filter_mask_t		filtered;
 
 	u16			callchain_size;
 	union {
-- 
2.48.1.502.g6dc24dfdaf-goog


