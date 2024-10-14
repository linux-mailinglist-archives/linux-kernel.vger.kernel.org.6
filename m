Return-Path: <linux-kernel+bounces-364746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3A799D8CA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147571C212C2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8F31D0E3E;
	Mon, 14 Oct 2024 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+VMjkUJ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26B51D1726
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728940397; cv=none; b=k3817DyDEM/RXAbGuNezA/VpgQEAO14RmdloqICbv6ScH73sgYkmbtKqyPJKCadTR3N8JtrEL0b7DRl24AKeOrnxzs65j0uCJcL+miOM/ar2Bfcyz4brxR4HOyxqvvmSJKqizovDWp4Sq/HvkLsWGu9odPzx3fVwkZJ4gxdIPhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728940397; c=relaxed/simple;
	bh=uzGP3fTBfJEcisBlsf65F3JUyRpz1YsU0VQnyjjJC3Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HHTdUIJN9DwQH5HM86+C4P49U4XaeGIj+KctfGAvd/G/sGqL70Annzkdln5eg/BwBvUGlotdzGxzWN4LUzt43XVQcMEeLSCSEPFWuoNotNMwm1VllxQN4u/yWU9ZSrMXyZr0JTFh39pVf6ky2g9uo5XGhE8yIhwIAUR9RBWvdtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S+VMjkUJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1159159528so8210330276.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728940395; x=1729545195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0/hwr21L5jvhIc5C9e7aZcC+JDoL+nMT8XwfIns1XuE=;
        b=S+VMjkUJqJu5yI874W0IDiqncOcHDcR1BSCC5hG1MelVXHnGBXpo78OvNEuXvRdt8G
         G4A/Q/VX2Ql4msdvh31CnHxw834C/s8wNeYE2s3qCPpnItK+e8xx58Ot+yoy2vG9bXUu
         Vs4o6p3Y9ZYI6hwS9vqsp3rhqM/f0Ow4ULVETWWTPLd+egT9gWMhK11+ClglJnm+3t4R
         2Hsv3ca6YqmZOi1OAkbyveivq7zXdqT+tWetEtEJvWokBljbRpOP5lT+AYJNKdAm3Unw
         o0GpO2FrDuuU1FDtaGrAiiHhSVXgnqjB8WnbG5Vwbhmu6w9cuG0zXExjhArF3ej3181j
         M1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728940395; x=1729545195;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/hwr21L5jvhIc5C9e7aZcC+JDoL+nMT8XwfIns1XuE=;
        b=dQbkgtLnn6M2aVP8nQww1a+r3KyCEe8E19NGvg9GDiHCDwN0Q8HEZo8d8w9PWZ38w8
         WYXBl6hve+Y8hRRoiCRV1SGbds29KAtmQ3DZf83CBwgUo3qxHNJe4gUAlCNAJBRLPMP4
         A52DBPD0s1Z7+bqVkHjvNbUAmFfzyIQhTutvUm6ggT5eVmMduje1ZafWNawuGZPWy9wp
         ZE0tOZ7W6MSgsTrUMkRVGracyAzAqiOAc/cx+SfBktHRuzBw08mkwxdHRQfCZ4CeNuEH
         Jv/kDkc1t0STnnhCAx+uiByUzprPRgN+7M0fi3FFYPVpSWLtbagMx0YcEHD4O8ggKehh
         DsDQ==
X-Gm-Message-State: AOJu0YyuGoZAGQoEGMNlLyc2kkkwKAq1GIuszKj1mGSeCxxCBwvNC+lp
	yQ9DlZ9XENnTflMsn2VV0U0jyjne10bxHNhrOgTXSfHA0DmTfd39UGXzx4EKsP8+ryWLh+u8tUx
	T/x0UOFKSykomq0JRmwxXDQ==
X-Google-Smtp-Source: AGHT+IEVKC+wG4wGouRbzL32A0moDAXPTQcMZCtANmaveTOGRNjnHIMmr3sCc3s8PDpq4sxnwiq3TrmSzLazj5jTeA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:ba:c019:ac11:dacf])
 (user=justinstitt job=sendgmr) by 2002:a25:6805:0:b0:e20:cfc2:a326 with SMTP
 id 3f1490d57ef6-e29184333b9mr123460276.6.1728940394998; Mon, 14 Oct 2024
 14:13:14 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:13:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGmJDWcC/52NSwrCMBRFt1Iy9kl+QnTkPqSUmr60wZqUlxAsp
 Xs36g6cXDh3cM7GEpLHxC7NxgiLTz6GCvLQMDv1YUTwQ2UmudT8rDikTMEuKzyQAs6Qqbf42w4
 Lhpw65+eMBBac1r1yRpuTMKwKF0LnX9/Yra08+ZQjrd92EZ/3r0wRIMAhDoobye9GXccYxxmPN j5Zu+/7G4UEiojlAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728940393; l=2965;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=uzGP3fTBfJEcisBlsf65F3JUyRpz1YsU0VQnyjjJC3Q=; b=LexTwNo7Ijmd2xfyR7O6jramq59fng0ZxBNdR7gqur/w7C0LwKEsKgfpwgR7ClJd3t2EYjMK3
 ZOjmBmNNaZ+Co+83EVktZTPpJ2thPrTRsf1ai1Gu6X561x6ozL5VS8R
X-Mailer: b4 0.12.3
Message-ID: <20241014-strncpy-kernel-trace-trace_events_filter-c-v2-1-d821e81e371e@google.com>
Subject: [PATCH v2] tracing: replace multiple deprecated strncpy with memcpy
From: Justin Stitt <justinstitt@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings [1] and
as such we should prefer more robust and less ambiguous string interfaces.

String copy operations involving manual pointer offset and length
calculations followed by explicit NUL-byte assignments are best changed
to either strscpy or memcpy.

strscpy is not a drop-in replacement as @len would need a one subtracted
from it to avoid truncating the source string.

To not sabotage readability of the current code, use memcpy (retaining
the manual NUL assignment) as this unambiguously describes the desired
behavior.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90 [2]
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- use memcpy instead of strscpy (thanks Steven)
- No longer breaks Steven's test:

$ echo 'common_pid != 0 && common_pid != 120 && common_pid != 1253 &&
  common_pid != 17 && common_pid != 394 && common_pid != 81 &&
  common_pid != 87' > /sys/kernel/tracing/events/sched/sched_switch/filter

- Link to v1: https://lore.kernel.org/r/20240930-strncpy-kernel-trace-trace_events_filter-c-v1-1-feed30820b83@google.com
---
 kernel/trace/trace_events_filter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 0c611b281a5b..78051de581e7 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1616,7 +1616,7 @@ static int parse_pred(const char *str, void *data,
 				goto err_free;
 			}
 
-			strncpy(num_buf, str + s, len);
+			memcpy(num_buf, str + s, len);
 			num_buf[len] = 0;
 
 			ret = kstrtoul(num_buf, 0, &ip);
@@ -1694,7 +1694,7 @@ static int parse_pred(const char *str, void *data,
 		if (!pred->regex)
 			goto err_mem;
 		pred->regex->len = len;
-		strncpy(pred->regex->pattern, str + s, len);
+		memcpy(pred->regex->pattern, str + s, len);
 		pred->regex->pattern[len] = 0;
 
 	} else if (!strncmp(str + i, "CPUS", 4)) {
@@ -1859,7 +1859,7 @@ static int parse_pred(const char *str, void *data,
 		if (!pred->regex)
 			goto err_mem;
 		pred->regex->len = len;
-		strncpy(pred->regex->pattern, str + s, len);
+		memcpy(pred->regex->pattern, str + s, len);
 		pred->regex->pattern[len] = 0;
 
 		filter_build_regex(pred);
@@ -1919,7 +1919,7 @@ static int parse_pred(const char *str, void *data,
 			goto err_free;
 		}
 
-		strncpy(num_buf, str + s, len);
+		memcpy(num_buf, str + s, len);
 		num_buf[len] = 0;
 
 		/* Make sure it is a value */

---
base-commit: bc83b4d1f08695e85e85d36f7b803da58010161d
change-id: 20240930-strncpy-kernel-trace-trace_events_filter-c-f44a3f848518

Best regards,
--
Justin Stitt <justinstitt@google.com>


