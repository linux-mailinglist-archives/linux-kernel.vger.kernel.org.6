Return-Path: <linux-kernel+bounces-542096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F2BA4C5A7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 474F27AA311
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A619D215180;
	Mon,  3 Mar 2025 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n+CNwudK"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4030D21505C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016782; cv=none; b=l3SGQVFCQyTIG+6nE5YLDzb/0fX8JiTXgSWvCgS8ozuI1/ld1PocfzTvRD+joke8YzaGrYoij1WEPDo/5Z2xa5hGUu8RWs/fwXHa6Wd6SlkVxR35ZB2Z0D7WaYcDhoOANzpqO9dkBJ+rKQ/+h1tAIPNZkOD3CUcR2jYbLYzqi3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016782; c=relaxed/simple;
	bh=xZbG9+LargulmZD5V8VthUDEt6YSputXK3s15FU9+zY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BxsCXR0Kpm2eWdlox3zqINyo0GBtTt/rtxRlIxgWm3FoEW+s6zL65dnwVjXx90F/fJ0OIVuePRiBwyi94FqWw8+wLiY2scbyM2ql6scZFV4+fzOZchZg5dJOyRnYJrLe8uceXFllDAtbrCux7wurjbb1recv4dzWWUuFstkGlsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n+CNwudK; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4398ed35b10so20577805e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741016777; x=1741621577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m5VafYnlfGJvqMjKGIihikKtNMHAvBXWGf3PBF9dZwk=;
        b=n+CNwudKozlZbT6oiHJG+0oHweXrMIE8o1c4Kul4CVLaXWOHS27K9/nn4o9J4R2cHL
         gmc6DnkJrFdw1vBD5BIy7tXI76q8lGKXeUkVcRjEi7Pp5hXKct3b8A/OQ9mRpB256NUj
         hRWPatMYOLQXP/nAHl+6Ye1q7qxPDKUEnz8p94SNrYr39oBT+ZMqvl4FaRhlAkkNlzXG
         x4hS8BaN11TO9BdjA+hgR/JyholaylH4H3LwNVfuI7sWcKvS1qCzEP4kS1fBzvMmn//h
         FXdYzwQkfasrLZxsJXzx40ZrQS/dHbpY52erK1NmJvgyM4o9qMGFK40QHY6ZYd8r+PZf
         lepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016777; x=1741621577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5VafYnlfGJvqMjKGIihikKtNMHAvBXWGf3PBF9dZwk=;
        b=dIEAgRVzQ9CJCgbnKX5QZfydvPAPpJ9bnu0RhcjX8uiJBStJgBk7hrIELEuUAdKD+W
         iOEsmlPMELK1Sn7F5fm52AsMp2yndk74nKIOIdQM52AuwHlb/niNqlDrxMO9UGv3gIlZ
         qOBHXWlTXWJc7MhlZ+9xOYAg7jIR0psBP7hY9BrnueIcxJlShUfW8eAmoDs5PTjWRrfq
         mI5If8qTiH9ZS9r8NHr9EtVvUQbKwquDfam6C6Bq8gnl2HTqedJUMkfDzfTOJvjyTxQe
         5V0TISPDHs2Pl8lBJDaC81VMTJvI5idAQonpfiu6scVxMG71O271bjiChfmwMINN8VIW
         7dIg==
X-Gm-Message-State: AOJu0YxybluWR42/gFFFXaQBlVs3t7pTVmRiCoSbn/jrjr/t+7aLcyli
	kwlRxUNSkxQId5f78HCHowTte0HeP5uhLEZN0gjnlQdKpWTSqCZnPwsHrKH3VfEX6HXJYh9LT66
	1Vz90qLbpbQ==
X-Google-Smtp-Source: AGHT+IE3N2oxEHJ5LswDOjLZnmd7mp9zhpcr2Z2YcRShTrfqCv8jdoD7g0qBBoBARJd31RAi+IyGCvu8ellqWA==
X-Received: from wmbfl18.prod.google.com ([2002:a05:600c:b92:b0:43b:c967:2f53])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d0b:b0:43b:c5a3:2e1a with SMTP id 5b1f17b1804b1-43bc5a32fd2mr21349525e9.2.1741016777647;
 Mon, 03 Mar 2025 07:46:17 -0800 (PST)
Date: Mon, 03 Mar 2025 15:45:39 +0000
In-Reply-To: <20250303-setcpuid-taint-louder-v1-0-8d255032cb4c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250303-setcpuid-taint-louder-v1-0-8d255032cb4c@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250303-setcpuid-taint-louder-v1-3-8d255032cb4c@google.com>
Subject: [PATCH 3/3] x86/cpu: Log CPU flag cmdline hacks more verbosely
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="utf-8"

Since using these options is very dangerous, make details as visible as
possible:

- Instead of a single message for each of the cmdline options, print a
  separate pr_warn() for each individual flag.

- Say explicitly whether the flag is a "feature" or a "bug".

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/kernel/cpu/common.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c1ced31f976d970efd24d6c9e4ac77cbff3371b9..8eba9ca9c216127ce1a6d630e7f67130520137b4 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1484,8 +1484,6 @@ static inline bool parse_set_clear_cpuid(char *arg, bool set)
 	char *opt;
 	int taint = 0;
 
-	pr_warn("%s CPUID bits:", set ? "Force-enabling" : "Clearing");
-
 	while (arg) {
 		bool found __maybe_unused = false;
 		unsigned int bit;
@@ -1500,16 +1498,19 @@ static inline bool parse_set_clear_cpuid(char *arg, bool set)
 		if (!kstrtouint(opt, 10, &bit)) {
 			if (bit < NCAPINTS * 32) {
 
+				if (set) {
+					pr_warn("setcpuid: force-enabling CPU feature flag:");
+					setup_force_cpu_cap(bit);
+				} else {
+					pr_warn("clearcpuid: force-disabling CPU feature flag:");
+					setup_clear_cpu_cap(bit);
+				}
 				/* empty-string, i.e., ""-defined feature flags */
 				if (!x86_cap_flags[bit])
-					pr_cont(" %d:%d", bit >> 5, bit & 31);
+					pr_cont(" %d:%d\n", bit >> 5, bit & 31);
 				else
-					pr_cont(" %s", x86_cap_flags[bit]);
+					pr_cont(" %s\n", x86_cap_flags[bit]);
 
-				if (set)
-					setup_force_cpu_cap(bit);
-				else
-					setup_clear_cpu_cap(bit);
 				taint++;
 			}
 			/*
@@ -1521,11 +1522,15 @@ static inline bool parse_set_clear_cpuid(char *arg, bool set)
 
 		for (bit = 0; bit < 32 * (NCAPINTS + NBUGINTS); bit++) {
 			const char *flag;
+			const char *kind;
 
-			if (bit < 32 * NCAPINTS)
+			if (bit < 32 * NCAPINTS) {
 				flag = x86_cap_flags[bit];
-			else
+				kind = "feature";
+			} else {
+				kind = "bug";
 				flag = x86_bug_flags[bit - (32 * NCAPINTS)];
+			}
 
 			if (!flag)
 				continue;
@@ -1533,22 +1538,24 @@ static inline bool parse_set_clear_cpuid(char *arg, bool set)
 			if (strcmp(flag, opt))
 				continue;
 
-			pr_cont(" %s", opt);
-			if (set)
+			if (set) {
+				pr_warn("setcpuid: force-enabling CPU %s flag: %s\n",
+					kind, flag);
 				setup_force_cpu_cap(bit);
-			else
+			} else {
+				pr_warn("clearcpuid: force-disabling CPU %s flag: %s\n",
+					kind, flag);
 				setup_clear_cpu_cap(bit);
+			}
 			taint++;
 			found = true;
 			break;
 		}
 
 		if (!found)
-			pr_cont(" (unknown: %s)", opt);
+			pr_warn("%s: unknown CPU flag: %s", set ? "setcpuid" : "clearcpuid", opt);
 	}
 
-	pr_cont("\n");
-
 	return taint;
 }
 

-- 
2.48.1.711.g2feabab25a-goog


