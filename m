Return-Path: <linux-kernel+bounces-301986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 320C895F84F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC7F1F22012
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31628198A3D;
	Mon, 26 Aug 2024 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="euz5BZ4s"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D2019884C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724694054; cv=none; b=urucqhAzHBjQ5DkdUmFjbEzYf+FlUGc+kZ1gGzNTfrQCEzWA1Gw585mSVrIox6Zxe6Yu4ZltdXuXFIuLSMAF7ChTWM/UHs2ZajS6kTRRa2LFbuCuYdIh+UkN13fpTeiIwiPCg5HeZQXulSNeuqhwnsu9LkYtlI6x8UvFPlOErk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724694054; c=relaxed/simple;
	bh=38RYpX0itHRcFlvcfwO20AY1tm82Tl6U3bOwLFm4DaM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uNpf+L28GhLsgWoZ9mI1orxmuGpw7rsymf5jN5Leogzwy5V3zqqpzq/+lT6Y0qA52Pd15GX1anHIaGMLmiKar2vTu3pb5kuR2WHIUf0VmeBwaja8LwUtLMqNNFFKfIoBo1sA7SkyZOOkb0C3eSQ6sHSniq091yr4uQvHtJXqxaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=euz5BZ4s; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e117634c516so8194881276.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724694052; x=1725298852; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IRpbKT8eDTs2jbkcv3eRtpU9kxct2vnPfTcDOFQv4ew=;
        b=euz5BZ4scNKSHoGCtSlVDrqDx8VVtRJwj96AUO7t96IIB/iWnUwzmG/RKfqCiNfygT
         zsGR3LXLx9R4ut+BNjZrHa70OgFxfrlN1ly0+fuJo90n9KI/1sR9rjhEBEdFYnfXImtA
         Y1d0PaDoz7nmB/s6q4V3T48CMNGAds2T62QRePZptmwG5eAB/Cc7abxwkt40GXSSBTnh
         ptYCCLvn0Darm0QohULf08XquWfSp2UT9mnHjm/C3kbQXmAfo1jk22VSiF2O9PA5AeZk
         OBmtvEldei1GoqMiebfOR4W2Jg7nrRBlCJFQoCb24OGAz70h3vkJpJCnJzQXqlqYl9n6
         7KZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724694052; x=1725298852;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IRpbKT8eDTs2jbkcv3eRtpU9kxct2vnPfTcDOFQv4ew=;
        b=mSwyoWmD+kQbBq3k0Jna1uBXQtFiaP4wnE9fGcatDOusWKCfcKxqHiUSi7ROAsbymO
         5u58ZLwdrXwRoJFAj7d8YkuX8oTOF4vAZd+Qzg7QvCEYOAnfWghTH77h1gKO20S8vnsA
         G0W3weD7wUA0qLJ0BYG4NZtmaUgY833oCSFJNnzCgrnAVr/E8YFE2B6KCRAwK3iwkPdB
         6r2SOVBjiKDZG0JFaBeW6Hk7Fxwase0iJybt8ZG27iGzl8r8fp7krpHpgc4JHxRwLMmY
         kJho6lHjnm3Q7nyuzwUyfpUjzsiCyTqA4dawTQaWyAo+TrjLa4bOtPpCrDW0UuwxstNo
         rF0g==
X-Gm-Message-State: AOJu0YxHKilfF0MNZHTxC8dA2MtZK9QKU7qFgobf+2TDtM+oTtoheFYj
	yDUazCyyZBFa7SK4gX3HWI717MfqG8xazJbetKdfcr+K/IQsdzo1U7iKFcJKoENZ1UyJuII5e+Y
	GHN1ti/aRL44X9DLin4qMdg==
X-Google-Smtp-Source: AGHT+IFLZCvHUGimXlZ9eOrIm8DbE3Ww2SBM+aysI+wCSClXo8gNSrTZOIhqS+2PU6aHWHPOxJN8b0j1y3mqiL6SmQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:32a1:b0:e0b:bd79:3077 with
 SMTP id 3f1490d57ef6-e17a8630eb5mr18971276.9.1724694051919; Mon, 26 Aug 2024
 10:40:51 -0700 (PDT)
Date: Mon, 26 Aug 2024 10:40:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACC+zGYC/yWN0QqCQBBFf0XmuYF1K9B+JSLW8aqDMcmsRCH+e
 0u9HDgv52yU4YpMl2ojx0uzPq1IfahIpmQjWPviFEM8hSYGzqubLB+e4YYHr54Ef947TyYTC4f Uno/opB9QUyktjkHfv8v1tu9ffCLlGXUAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724694050; l=1750;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=38RYpX0itHRcFlvcfwO20AY1tm82Tl6U3bOwLFm4DaM=; b=32tkeynr+w56sMQwNB1tcARgQrlhZTXteUye/hSpgeKtvOHvrqN6XgA5kAqwRGXZOfaLNFjlS
 51LpAtw4U4DAT7JN8z2LQFtfXpDQBxQQDYAfrpEifJOGQgHXif6GjEO
X-Mailer: b4 0.12.3
Message-ID: <20240826-strncpy-kernel-trace-trace_branch-c-v1-1-b2c14f2e9e84@google.com>
Subject: [PATCH] tracing: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

Both of these fields want to be NUL-terminated as per their use in
printk:

    F_printk("%u:%s:%s (%u)%s",
      __entry->line,
      __entry->func, __entry->file, __entry->correct,
      __entry->constant ? " CONSTANT" : "")

Use strscpy() as it NUL-terminates the destination buffer, so it doesn't
have to be done manually.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 kernel/trace/trace_branch.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
index e47fdb4c92fb..aa63548873c3 100644
--- a/kernel/trace/trace_branch.c
+++ b/kernel/trace/trace_branch.c
@@ -74,10 +74,8 @@ probe_likely_condition(struct ftrace_likely_data *f, int val, int expect)
 		p--;
 	p++;
 
-	strncpy(entry->func, f->data.func, TRACE_FUNC_SIZE);
-	strncpy(entry->file, p, TRACE_FILE_SIZE);
-	entry->func[TRACE_FUNC_SIZE] = 0;
-	entry->file[TRACE_FILE_SIZE] = 0;
+	strscpy(entry->func, f->data.func);
+	strscpy(entry->file, p);
 	entry->constant = f->constant;
 	entry->line = f->data.line;
 	entry->correct = val == expect;

---
base-commit: 521b1e7f4cf0b05a47995b103596978224b380a8
change-id: 20240820-strncpy-kernel-trace-trace_branch-c-0a953ebcdfe1

Best regards,
--
Justin Stitt <justinstitt@google.com>


