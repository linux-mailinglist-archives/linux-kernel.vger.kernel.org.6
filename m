Return-Path: <linux-kernel+bounces-238440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DDE924B0C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C591F258E2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A246183278;
	Tue,  2 Jul 2024 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDUKS2oB"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26262205E3C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957520; cv=none; b=WtS9KVxzP+pJFPgYTj6hn4QmtS0mIRzOaG+lrN4dLlQ72F+9dvcJT8AgAGh92YQPPVfwED6F+5KWz1OF2IlTZEciuStibDKINmQfLcjn2BfnAfDyT3NKcGa5dlMsCmoRHDM3xYkYVPVJYjkcyXdX9aTAD6BFfE/ZTV8X1lQ1KEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957520; c=relaxed/simple;
	bh=icwqeywsyrttsSDlGtVX51FXgI87DPMODzf+SUKMTJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bwMUvcPN2HKujvbe8QZE94HMHFp7mTWtVe9Qb+vho5mgdZA5trncpWWyBDFMVpDraZOrnoy6NNVwHJCyCHD0HoLc4lqjleFT3lkEpiemvU18SMOaav7ZpJt3lhFEoja0JIkToMw3hfCJ4DK3R/1EBWyzSwFyZeDOyWVxN3rReeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDUKS2oB; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7f65715fe2cso34945439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957518; x=1720562318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xowWZ+ekpberKm26oOQ15iL0A2hZa3GfKHRI1+lg3PY=;
        b=CDUKS2oBC3O0yTIFkaPKK8EADDkiMmo6xQZYmnYMNZAF55W9sPMo1cwiFGJwZVdi/z
         g3LTHIBlUDE8zOlT0p+yyZAvTWwVDKNSVcrWeRvJd/4yOeyka6WJsphjxtGH+c9Ju3o9
         L8GsBQyjRc7S0Nvhw+BBfNwUEQxvKdmt1e12VeKjBjfTLVHiJ1jb7WcIRYlLOO34dKT7
         zFBl/Q3fHvzKVW2wzNI36xZevFOiw4xq0k79ucAWVhE7stIxA4JwYG695pL6HbrtfVcH
         rnOE+ls+m1LDyH4P4A/egmDtS85khtFwm6SGMSv3JfCGefEnDYrN8g2iNK7x1QWnk8RK
         SZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957518; x=1720562318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xowWZ+ekpberKm26oOQ15iL0A2hZa3GfKHRI1+lg3PY=;
        b=n1bMz9gPd0SZClK6xM9CpnlOwF5x3IKAFwebx+kUsESlhSzAe+q+i0ORZt7hEb+iX3
         jB+Yw0vW1Dsbrtf2gvV8AHHaflrhutcd99nppYzWyVc3QwjyCHV+5Vrw7V3XOHxdagjj
         rpEgmrfDvppIik5hSWH+LFnCze0QjZKeoVSpTXz7vGLHKz/LTHNoTOmy9CAQfkWdj24U
         XGoLNQBZNkc7nfdSC5P3abWLYvwOO8ichC1JVw7JY094OGxUGH9HilfqgYfvb7WxKSMR
         uNzfkQpiTHHu8byiVx99fXutDx+rQIjnZspGIhXdnsF/Ip3ihK1IHHsH96fZ/rxs5obR
         dNsA==
X-Gm-Message-State: AOJu0YzyIzad+dpybtKhfxOPdyJew072z7QWe4VHWul5r9xMEls1bwLw
	OPH8/XFpaaoSwhHCzO3ecgRq7IDb5BVDNs6+h63DIxopjhfgE7DK
X-Google-Smtp-Source: AGHT+IFEGPMJ0Jh14wpvUFc2djetIH1c1nAPVR9FTMSLomEU1MSc3gn/62MyPuGbMB621f76l28FXg==
X-Received: by 2002:a05:6602:2bfa:b0:7f3:d731:c6df with SMTP id ca18e2360f4ac-7f62ee501eamr1142864839f.10.1719957518165;
        Tue, 02 Jul 2024 14:58:38 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:37 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9 19/52] dyndbg: treat comma as a token separator
Date: Tue,  2 Jul 2024 15:57:09 -0600
Message-ID: <20240702215804.2201271-20-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702215804.2201271-1-jim.cromie@gmail.com>
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Treat comma as a token terminator, just like a space.  This allows a
user to avoid quoting hassles when spaces are otherwise needed:

 :#> modprobe drm dyndbg=class,DRM_UT_CORE,+p\;class,DRM_UT_KMS,+p

or as a boot arg:

 drm.dyndbg=class,DRM_UT_CORE,+p  # todo: support multi-query here

Given the many ways a boot-line +args can be assembled and then passed
in/down/around shell based tools, this may allow side-stepping all
sorts of quoting hassles thru those layers.

existing query format:

 modprobe test_dynamic_debug dyndbg="class D2_CORE +p"

new format:

 modprobe test_dynamic_debug dyndbg=class,D2_CORE,+p

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Co-developed-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 lib/dynamic_debug.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index e9a95b0f3757..235d85765b63 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -290,6 +290,14 @@ static int ddebug_change(const struct ddebug_query *query,
 	return nfound;
 }
 
+static char *skip_spaces_and_commas(const char *str)
+{
+	str = skip_spaces(str);
+	while (*str == ',')
+		str = skip_spaces(++str);
+	return (char *)str;
+}
+
 /*
  * Split the buffer `buf' into space-separated words.
  * Handles simple " and ' quoting, i.e. without nested,
@@ -303,8 +311,8 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 	while (*buf) {
 		char *end;
 
-		/* Skip leading whitespace */
-		buf = skip_spaces(buf);
+		/* Skip leading whitespace and comma */
+		buf = skip_spaces_and_commas(buf);
 		if (!*buf)
 			break;	/* oh, it was trailing whitespace */
 		if (*buf == '#')
@@ -320,7 +328,7 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 				return -EINVAL;	/* unclosed quote */
 			}
 		} else {
-			for (end = buf; *end && !isspace(*end); end++)
+			for (end = buf; *end && !isspace(*end) && *end != ','; end++)
 				;
 			if (end == buf) {
 				pr_err("parse err after word:%d=%s\n", nwords,
@@ -592,7 +600,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (split)
 			*split++ = '\0';
 
-		query = skip_spaces(query);
+		query = skip_spaces_and_commas(query);
+
 		if (!query || !*query || *query == '#')
 			continue;
 
-- 
2.45.2


