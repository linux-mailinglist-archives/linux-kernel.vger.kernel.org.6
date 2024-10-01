Return-Path: <linux-kernel+bounces-345029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD75D98B144
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C651C21DFD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83F8646;
	Tue,  1 Oct 2024 00:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UW60OOY4"
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05AA173
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 00:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727741030; cv=none; b=R8janty0XKBBhgyTnZ8RS2B7rrASKxQwg6c6EYxERMipV6BmTc2dacHJe0vU6FHgYR9+AGDvocNMTRSYddoySHY/FzA64D84a/p8n78R/IjzKXizjeq49t62KZh/Hp2TmcGVx/Kepsg/x/Jv7xLCBHUaGFWZZ23JPMC3AmJamtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727741030; c=relaxed/simple;
	bh=820IcyqCs7+T/TOejXHPpSMJYxzvLXB8fiX8/yiykJg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rW3IL5ufzpoLIS9LUvHAkRS6rOpa0qrPcFcUQ4mFbZurvp9S0TZkyztZkeRujDf1oouk1qBOkiS9wKpUcq8S++7dksRAjfVPDcZOoZR0SNHWrH3uljxVE5orhBIKlyDZ3KiHmA9VH61VnI/qQNVQoLu2MSTrzldjqsWoujVeb0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UW60OOY4; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3a2762bfcbbso74769745ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727741027; x=1728345827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O7sX1wqGBxbtPFBtTAq4huaNxr3STgR9xkPM02Bw42k=;
        b=UW60OOY4pwYqAg+6HaUvqh7J9F9l75UVTmz34KbqJbsVBZzF0nVgjijEAIkW1AlRYy
         GGOcxHlwmWXeLfSZxdhft2SxJR4L8CLTAbc5cb6ORP6v2eNjYS4ss7KKoB42AKPM7SzN
         zgvy7SjlFvy+taRk/koaWFIqFbl3Zizr8krO3obsO8p2yypA4h7yHaVuQEIHyNgeaFDM
         FB6w/3YrHyA+q87cuQRX1hqZcSlf1B865WFLJEraz89nZ6nOgEHZKRoy9aDZw2yXc01V
         Pq13Gfrl5ELNwzuUPfLzSU/1B1SCFol9kEKSCwMHiuibgC0eeVXByP8YJP3ASifz74Nj
         CIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727741027; x=1728345827;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O7sX1wqGBxbtPFBtTAq4huaNxr3STgR9xkPM02Bw42k=;
        b=mj7lRRjCHV8RTGI/nW64IwJA9aoaD137qSIHUVVeAOiQ16ZMaz9XMPUfQy6ruh1/ZX
         Th5Y8r1DsC44o05Hqs61g/27Ln2I79xQsxW/vNrAUayC6QPuSzLXNHMoJ0GrH2GndNFy
         NfQiBJiMvGWI7FmNxd8AOc3wyOYLI457zAdUrMnXzS+Kin81z8lW2xZiqZwR5lJvprud
         AKZ96o80h+WYIF1M5d7+afbO6DGLfD1yHoo6nm3H36LCZsFjo+2S1q+lBvf/zDzQ3qxi
         bQ4+dVI8s0mA6qOb5SqfJGO1gFkTeQXFhSE/yoRjiTVPGkQy5h43E9hVgAAMPx/LUGza
         7F6w==
X-Gm-Message-State: AOJu0YxEQXOmX4O29IVvIIgmFJLtxi8tGnbnBr/CyELjGn0nRmJpNi8L
	TbWazUWtnk6fdmf+fsON5sopOD1C9dbgypJ+PnbzVm+7qOFiWcSDpJs4y1GgtTwXdFNNpKChBju
	xZsvnf3hM1RwYwGPxbOafDQ==
X-Google-Smtp-Source: AGHT+IFW65PL0mRlJiI5TO7iIxstS0LHU6Jw3egJeK7nKtUNejIwUqkyKodc7CrRGLU91KDv5IaQ5HbaRaJPeB0JGg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a92:c26d:0:b0:3a3:3a77:919f with SMTP
 id e9e14a558f8ab-3a3452ced05mr1839825ab.4.1727741027091; Mon, 30 Sep 2024
 17:03:47 -0700 (PDT)
Date: Mon, 30 Sep 2024 17:03:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGE8+2YC/yWNwQrCMBAFf6Xs2YW0jRD9FZES4osullh2Q1FK/
 92gl4G5zGxkUIHRudtIsYrJqzTpDx2lRyx3sNya0+AG706jY6ta0vLhJ7Rg5qox4c8JK0q1Kct coZw4ex/HHHw49oFacFFkef9ml+u+fwF7qakEfAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727741025; l=3204;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=820IcyqCs7+T/TOejXHPpSMJYxzvLXB8fiX8/yiykJg=; b=Aby9lKMnQ53tWHvDf9Y4RnflLVgStoq85NOjaNHjIKfUR/wy0GMDZzWXmuAdw6uslbdbPhy3e
 mwnS/yicvF+AWa/t9uHxCfQyLHHsxEJ3mSaMPf8F7Sd0Bn3mjCIEZXy
X-Mailer: b4 0.12.3
Message-ID: <20240930-strncpy-kernel-trace-trace_events_filter-c-v1-1-feed30820b83@google.com>
Subject: [PATCH] tracing: replace multiple deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings [1] and
as such we should prefer more robust and less ambiguous string interfaces.

We expect the @pattern and @num_buf strings to be NUL-terminated, as
evidenced by their manual NUL-byte assignments immediately following
each copy.

Switch to using strscpy which guarantees NUL-termination for the
destination buffer -- eschewing manual NUL-byte assignments. strscpy
does not NUL-pad so to keep this behavior zero-allocate @num_buf. @pred
is already zero-allocated before the copies.
	pred = kzalloc(sizeof(*pred), GFP_KERNEL);

This should result in no behavioral changes whilst helping towards the
goal of [2] -- with the ultimate goal of removing strncpy in favor of
less ambiguous and more robust alternatives.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90 [2]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 kernel/trace/trace_events_filter.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 0c611b281a5b..76b55eead8ac 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1506,7 +1506,7 @@ static int parse_pred(const char *str, void *data,
 	unsigned long offset;
 	unsigned long size;
 	unsigned long ip;
-	char num_buf[24];	/* Big enough to hold an address */
+	char num_buf[24] = {0};	/* Big enough to hold an address */
 	char *field_name;
 	char *name;
 	bool function = false;
@@ -1616,8 +1616,7 @@ static int parse_pred(const char *str, void *data,
 				goto err_free;
 			}
 
-			strncpy(num_buf, str + s, len);
-			num_buf[len] = 0;
+			strscpy(num_buf, str + s, len);
 
 			ret = kstrtoul(num_buf, 0, &ip);
 			if (ret) {
@@ -1694,8 +1693,7 @@ static int parse_pred(const char *str, void *data,
 		if (!pred->regex)
 			goto err_mem;
 		pred->regex->len = len;
-		strncpy(pred->regex->pattern, str + s, len);
-		pred->regex->pattern[len] = 0;
+		strscpy(pred->regex->pattern, str + s, len);
 
 	} else if (!strncmp(str + i, "CPUS", 4)) {
 		unsigned int maskstart;
@@ -1859,8 +1857,7 @@ static int parse_pred(const char *str, void *data,
 		if (!pred->regex)
 			goto err_mem;
 		pred->regex->len = len;
-		strncpy(pred->regex->pattern, str + s, len);
-		pred->regex->pattern[len] = 0;
+		strscpy(pred->regex->pattern, str + s, len);
 
 		filter_build_regex(pred);
 
@@ -1919,8 +1916,7 @@ static int parse_pred(const char *str, void *data,
 			goto err_free;
 		}
 
-		strncpy(num_buf, str + s, len);
-		num_buf[len] = 0;
+		strscpy(num_buf, str + s, len);
 
 		/* Make sure it is a value */
 		if (field->is_signed)

---
base-commit: bc83b4d1f08695e85e85d36f7b803da58010161d
change-id: 20240930-strncpy-kernel-trace-trace_events_filter-c-f44a3f848518

Best regards,
--
Justin Stitt <justinstitt@google.com>


