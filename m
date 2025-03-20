Return-Path: <linux-kernel+bounces-570205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DA4A6ADDD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667138A35DF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B55022CBD5;
	Thu, 20 Mar 2025 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4sc5Xay"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E286822B8C4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496800; cv=none; b=sLaGTFsUBfyXZdWJeig+ZhLeWB20LfpDYed6tLDbQ7zGZ5D0QGW77KSMYMlcimG2vm0so30VapsRIeX6y7WbJj9Cfphm5T0uoVFLLrpoqz5CHikF00KwKJSJ2UMVdse9838XSEXUYgwAZUZyqzFU62gIJP8vsAfGSxz4WaFADgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496800; c=relaxed/simple;
	bh=pALskfNdMJkNL/AohFvEmiVIFnssjOgkVCcrFeimGac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoXHUup1dL4CsRgkR8WJc8ofcvT58kkfwaHDlxINbLW3+bowrgvCOSGwrO36hLYO2dkLnoMvmUSPomqq5HcrAV/vmflWz2kKJO8I3vUZCOgcaP3rzM8efRLIjK6NZ/JfUPwkUTu3wg1GNbugKZI36EGSH7Cd6ck8R0UYm7rEm20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4sc5Xay; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-85db7a3da71so81500239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496798; x=1743101598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I11xVBXKQ+hF/QWDzrpW4DMDNxkmWPkILnOV6Dv+FVE=;
        b=c4sc5XayCBThlCsDiJT9xsf4/0NhBy5zR9hA4NFcpuKLm4ff2akA9tCvGDoq1iRaOt
         4wTwIcMPmZhgsjivsUjrQnCJMhh421r+Ktc4mP4j9r+SB+hoa4ilnYtU0c0gmzirbokn
         +Dj8Edog/ZJ7C5IdZhtxBFDYT0lw+rOAIBn+Dh7pcqffaIifbAC6E9w+HwWHia8hrpCx
         ZhRi0jLPfMR63mE8AjA9DNg/ECGCWTL3SD/4COR6zwxkcdTMzkwL30IP5yZTroEMSoNi
         r4oY4qioJDAWh7TnNLgWFehJbu8dAuDtiH8clhOMnpwx+iPYCeoXLuourZjieFKnO/DO
         00mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496798; x=1743101598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I11xVBXKQ+hF/QWDzrpW4DMDNxkmWPkILnOV6Dv+FVE=;
        b=CzCJXEoVC0odHL5s2n9JOUvFx+hQoslnoKRE/HfisWVw0q+SH9dp4jL/SdH40wEKNM
         nSgu1uI/+A90NVXqj874vj234ugFb/hHA7jCQirO1QV/ZSqQJJs/J+CNRVSm5q8qbTj5
         QqZky5elJ6la/GgDuEll41dJa9vC114JTx18SfegpzYHK339AsNV1rOLqxUQfgLQzNuk
         tHzqzPplTSblWf07ae2t45GvQoKFMMC/ZIqLO81WGgbzbnD+JfB6Aq1xCl4vFrBBcvqT
         lnPuGoUtltI+hu9bYBuiF2+04QL5rlJ0dh+baWLqeOXqTumrwfiCQ8eFU9aaBHnHihvm
         KzZg==
X-Gm-Message-State: AOJu0YzQ2UzV9RFfrnFUnY981vPrAxAGcJoQXNiPTQHa/NDzPttSotVn
	ncEvlfn5CgEv9a6TYE47ckjifnN7umw+11/m6CsBd8PdnVWtALj8fSm33rA/
X-Gm-Gg: ASbGnctwu6TSlADcSAg5awbEPylwmGut6WqDq466qoKfB3dsMmLAl1QBD/+vpaidB4F
	7PBi1AJU39y57j0AfONkdB5w4kvxZQwrZB/OeIhmkwVje3FDbGktcrU0bU34bfph8gBexx6Ky5R
	GP2deEkmWQbpxUbGYMk0xaMKgQ7JEmqY4rjtHSFPbwqmOsupVWsEE6C+e3BwQU59ptEmpKnBxAB
	YRRw+YnfaTR0Nu8LsdXLFWK9JE7Z9OQaJQys/yzxyQxULJ+0NyspA0rpfrhD59mbg93Dc3QBF4F
	8q9oRfTESJ2NzWEnC+cpMYOiOUD75qDopw3YCce8IQhqwuW9XgndJ1Frk7MkJVJfHkV1RONI2Tm
	YBw==
X-Google-Smtp-Source: AGHT+IEtCf2Gpyn2UFZqee/mhr53XbcO/kcuDLQe2NGqup147/L1yuCpY56bd5EokVyHN82kmeirhA==
X-Received: by 2002:a05:6602:2988:b0:85d:9f44:4421 with SMTP id ca18e2360f4ac-85e2cabfc2emr39548439f.8.1742496797837;
        Thu, 20 Mar 2025 11:53:17 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:17 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 14/59] dyndbg: split _emit_lookup() out of dynamic_emit_prefix()
Date: Thu, 20 Mar 2025 12:51:52 -0600
Message-ID: <20250320185238.447458-15-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320185238.447458-1-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split dynamic_emit_prefix() to separate out _INCL_LOOKUPs:

1. keep dynamic_emit_prefix() static inline
   check _INCL_ANY flags before calling 2

2. __dynamic_emit_prefix()
   prints [TID] or <intr> and trailing space if +t flag
   check _INCL_LOOKUP flags before calling 3

3. __dynamic_emit_lookup()
   prints ONLY module, function, src, line, and trailing space
   TID isn't "callsite" specific info.
   result is "cacheable"

Notes:

2,3 are gated, only called when theyve something to emit, so they just
add trailing space.  This obsoletes the pos_after_tid var and logic.

__dynamic_emit_lookup() adds line too, so the result is "whole".
While this would enlarge a naive cache vs add-line-after-caching, we
dont even have a naive one yet.

And some clever indexing on store() might be able to fold the flags
setting in, such that the prefix stored with +mf flags only (-l),
could be returned for all pr_debugs in that function which also had
+mf flags. While still supporting +mfsl prefixes (with cache
expansion) as they're used.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 663c125006d0..f7ec2365ab40 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -850,19 +850,8 @@ static int remaining(int wrote)
 	return 0;
 }
 
-static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
+static int __dynamic_emit_lookup(const struct _ddebug *desc, char *buf, int pos)
 {
-	int pos_after_tid;
-	int pos = 0;
-
-	if (desc->flags & _DPRINTK_FLAGS_INCL_TID) {
-		if (in_interrupt())
-			pos += snprintf(buf + pos, remaining(pos), "<intr> ");
-		else
-			pos += snprintf(buf + pos, remaining(pos), "[%d] ",
-					task_pid_vnr(current));
-	}
-	pos_after_tid = pos;
 	if (desc->flags & _DPRINTK_FLAGS_INCL_MODNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				desc->modname);
@@ -875,8 +864,29 @@ static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 	if (desc->flags & _DPRINTK_FLAGS_INCL_LINENO)
 		pos += snprintf(buf + pos, remaining(pos), "%d:",
 				desc->lineno);
-	if (pos - pos_after_tid)
-		pos += snprintf(buf + pos, remaining(pos), " ");
+
+	/* cuz LOOKUP, we've emitted, so add trailing space if room */
+	if (remaining(pos))
+		buf[pos++] = ' ';
+
+	return pos;
+}
+
+static char *__dynamic_emit_prefix(struct _ddebug *desc, char *buf)
+{
+	int pos = 0;
+
+	if (desc->flags & _DPRINTK_FLAGS_INCL_TID) {
+		if (in_interrupt())
+			pos += snprintf(buf + pos, remaining(pos), "<intr> ");
+		else
+			pos += snprintf(buf + pos, remaining(pos), "[%d] ",
+					task_pid_vnr(current));
+	}
+
+	if (unlikely(desc->flags & _DPRINTK_FLAGS_INCL_LOOKUP))
+		pos += __dynamic_emit_lookup(desc, buf, pos);
+
 	if (pos >= PREFIX_SIZE)
 		buf[PREFIX_SIZE - 1] = '\0';
 
@@ -885,7 +895,7 @@ static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 
 static inline char *dynamic_emit_prefix(struct _ddebug *desc, char *buf)
 {
-	if (unlikely(desc->flags & _DPRINTK_FLAGS_INCL_ANY))
+	if (desc->flags & _DPRINTK_FLAGS_INCL_ANY)
 		return __dynamic_emit_prefix(desc, buf);
 	return buf;
 }
-- 
2.49.0


