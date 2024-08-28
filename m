Return-Path: <linux-kernel+bounces-305854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF93963545
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE73286149
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455D11AB528;
	Wed, 28 Aug 2024 23:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvThTGea"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DA1146A63
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724886951; cv=none; b=Dec8NAeHircMYri2EfntZFAyySRyFSRVEUJJ8ZE/eiz/4hecoGXic5Wfqz3zCPh57aLcXs75PKpvblgYuRUSL+xMKlSHaMCwwguBJ4IoqKjwX8SUOAu7I+QwQgxN19FlWAenEkDKLOaGgaCGYTFcsq1uk6MS3b79a3WeZsb2LPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724886951; c=relaxed/simple;
	bh=ISwT3XDvRm7A2zqtsYKzBvvLDzqlF2Njc9Eqd6paImQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=coR4QMn7LhMVfiBraerS8m3PWNh771OTvREPGmbkaa9X3mazb5TwzBYByXhmwX9QRi0SWdc7TG3HNS7P42M7cttrNaGvIUhVg9vbUtmvHGySLXDNxsTnFc5ii2SSXR5T/qlpLJJVkpXMw20OiHh0ksJtiIQILOGTog2Y2GvvUdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fvThTGea; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6cf78470a56so1780207b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724886949; x=1725491749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MMRQE9M5HKxzvMTzsEDSmvB+myXexAwhYGndQpAOIRM=;
        b=fvThTGea6+WIx98nHt8lNwBOv1drWJW+AUC1Fjjf+wj7lYJ76vRQiz/Gxw4VyhBa1m
         9br7i/4lp5GkXAXHAQqWQ1utm1vb3w5QIOjkqXNSwf49xAGEuQtOPfR2MrPiptne3GSU
         pFnO6C/KRsX2Emmyn/wpyqDV66Yq53Y433mhwtetdQPA3wpXFS17VAUDEKVdpGJyF2oF
         6hsTiydzk07zwxz+ZOvuBRnB1N92hW7UaCnzXGYGcOSsSmpyy4sWnorKaHW6M7B3xUPU
         CQ2PpxVVrnugD4BENghUMwQTI6ay+j6kGAYiKB8kYOPClQ9QWmc+sGb7fE5X+Zmgwfy3
         lG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724886949; x=1725491749;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MMRQE9M5HKxzvMTzsEDSmvB+myXexAwhYGndQpAOIRM=;
        b=S1ZxBs/lFHO6lv/UbEPRgJ6auouMWBm1nM1AdMWoAm/MspmrSoUWoTU0gj8qJYMm1W
         KxbMFytt4A8EdX6RoWToz8xOI2zqtHv9YZru+aiEwh0BenMbEoQ8BeWXR3+MbPKDYUpq
         XFL2HoF16c3YkGzaKpTSzad/Axq/HCWbVgRVCX8t9B+HAnoMWDmDaMpmhjrXPtkoRMRp
         ax4dF2yXJhu3WhGxbbxMw8Qk9Gf+eMu1c/1Qh85WMkAzTECLebIXLuCZr5RehX2YUv1p
         2tuBvfvwjbKfikzW4SBZE+Ny9PWswV5fXBHoMZKZCkgxT+ACzTL/OcuSdPewR423AK1c
         ZkXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL0sYFW7tdVmxs/P8zbEBnemxiFEG6PPoKyf2K4s1Q9XTwoi6jFpVqGvaXk9k6jYAF3yFypbIgR0J77es=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjJQNzHgtBVm/tcivEO6l69wOi1M9+0KUC4CPtCZ0Q/B5MpLA7
	mqHuSAzRmBM+YQG6JHdRYbsZ4VGfOmZRWYHvAfLTC6KOf9qpAzuUm1HyS1NgwW1Ga8ccwnp4Y3V
	50A==
X-Google-Smtp-Source: AGHT+IHZ+O35i4VghFjFn/vmGMPTny7V3ShVkfOR7KuwKnk76ug3SO1rO9edrN4QbyJehMcztWhlCgXbs0g=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:1513:a:29f6:5d06])
 (user=surenb job=sendgmr) by 2002:a05:690c:6382:b0:650:93e3:fe73 with SMTP id
 00721157ae682-6d277880caamr395607b3.5.1724886949080; Wed, 28 Aug 2024
 16:15:49 -0700 (PDT)
Date: Wed, 28 Aug 2024 16:15:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240828231536.1770519-1-surenb@google.com>
Subject: [PATCH 1/1] alloc_tag: fix allocation tag reporting when CONFIG_MODULES=n
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, david@redhat.com, vbabka@suse.cz, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, surenb@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

codetag_module_init() is used to initialize sections containing allocation
tags. This function is used to initialize module sections as well as core
kernel sections, in which case the module parameter is set to NULL. This
function has to be called even when CONFIG_MODULES=n to initialize core
kernel allocation tag sections.
When CONFIG_MODULES=n, this function is a NOP, which is wrong. This leads
to /proc/allocinfo reported as empty. Fix this by making it independent
of CONFIG_MODULES.

Fixes: 916cc5167cc6 ("lib: code tagging framework")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org # v6.10
---
 lib/codetag.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/lib/codetag.c b/lib/codetag.c
index 5ace625f2328..afa8a2d4f317 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -125,7 +125,6 @@ static inline size_t range_size(const struct codetag_type *cttype,
 			cttype->desc.tag_size;
 }
 
-#ifdef CONFIG_MODULES
 static void *get_symbol(struct module *mod, const char *prefix, const char *name)
 {
 	DECLARE_SEQ_BUF(sb, KSYM_NAME_LEN);
@@ -155,6 +154,15 @@ static struct codetag_range get_section_range(struct module *mod,
 	};
 }
 
+static const char *get_mod_name(__maybe_unused struct module *mod)
+{
+#ifdef CONFIG_MODULES
+	if (mod)
+		return mod->name;
+#endif
+	return "(built-in)";
+}
+
 static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
 {
 	struct codetag_range range;
@@ -164,8 +172,7 @@ static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
 	range = get_section_range(mod, cttype->desc.section);
 	if (!range.start || !range.stop) {
 		pr_warn("Failed to load code tags of type %s from the module %s\n",
-			cttype->desc.section,
-			mod ? mod->name : "(built-in)");
+			cttype->desc.section, get_mod_name(mod));
 		return -EINVAL;
 	}
 
@@ -199,6 +206,7 @@ static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
 	return 0;
 }
 
+#ifdef CONFIG_MODULES
 void codetag_load_module(struct module *mod)
 {
 	struct codetag_type *cttype;
@@ -248,9 +256,6 @@ bool codetag_unload_module(struct module *mod)
 
 	return unload_ok;
 }
-
-#else /* CONFIG_MODULES */
-static int codetag_module_init(struct codetag_type *cttype, struct module *mod) { return 0; }
 #endif /* CONFIG_MODULES */
 
 struct codetag_type *

base-commit: 9287e4adbc6ab8fa04d25eb82e097fed877a4642
-- 
2.46.0.295.g3b9ea8a38a-goog


