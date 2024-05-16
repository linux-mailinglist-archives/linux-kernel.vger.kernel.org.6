Return-Path: <linux-kernel+bounces-181401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA88E8C7B91
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85A77281359
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F98F158DC3;
	Thu, 16 May 2024 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CByamTHe"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6310515747D
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881504; cv=none; b=M6yFSeg1Fanq3OY9m90ZOgzZWyw+DAW1NhhiKczsxQ6606y9/alkyVnL/pR5gQ9FYJdk5DwJLSx4Rp1xGr4B7/igbc8ThztgOreYtN0T4M+W1TlGUURL2Ykoagd/eDnHq+eK1dj3vtC+U34uIC7VHUksTYdEetPLBTm8nFcS3xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881504; c=relaxed/simple;
	bh=itcV+24asaVC3KYa/U3kpaJGYMkp9GjyLqWBirFU8Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WpY34MrgqsfNGs58tUrRie0kqpxfbAKwrg0MS59YKAWgiaXblv0MeIA0DRY4rP2BhwaHfsu6O4RKz82YZBFNvn+QtH7VyZyDgBX/hJKK9xd3hi/JENstikzbyoEBe0zR9y4mK44fT1Eyi6RWXtqPjZg78hZN0KEARKnKh6aUlDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CByamTHe; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7e1cd52db2eso60617039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881501; x=1716486301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKt9z1FjU1g7BjHL+/GNBbUF+urWK9jMB07KelneGxw=;
        b=CByamTHeXl4xlO0U9qbWizxCAtiBj5Brpj130fd2oPdXCMa4MQx8fwPncC7CkZLRtz
         8Dp9upuZLwirmS5u2HpTSKpuh1xeBtn8d6bfDOeNSNQ6Ad5k0NTiICtuuFZVzx/afI6i
         ur+4qK5Ycs8hhVBfjSwiocZnnkdlmHTM9G+FAKJz0iSWSMVfo4I4i3Hs72LTsY7RSD1c
         ZKMDtjSzr8S0lLIdYtMAOxBwRqRuo+mkOS/vpos4GlC3VsMNaU5fzQ2dJUOy2+MsyKLu
         rDpNzKXJLj2iI55B3LvbHrljwJK71cpjgamO5MLhu7X5rvEDHIyDzAZfEUPQx5h3ecpw
         jDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881501; x=1716486301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKt9z1FjU1g7BjHL+/GNBbUF+urWK9jMB07KelneGxw=;
        b=W3W9Hf/LFuRI9oWT9gGbIUZg+vXEIMx+z7Navp2yRly23JPl3LqfC5gTKDoeINWrh/
         6WcfGROPd+Mt8Jx9+GXoNy/u666yslCafOucPLHA6/u16LmXdvN+gkcYhhDw22zr867v
         durOJyiOoQiOeujqLX6iEqCvz2CfLxUetghNWh6T0ooh2apT0KGD/tdhC4lPOiIEiwIh
         fjMCI4G4S2VvOjeSc/a6uFS5LBv53C5oRITssJNfCFssBWgKnN9xHEEv1zIMTD4wLj5B
         On7E1WlY2oqYniS8pMWAQtic3vXDVJkDAObueG7g0sxypwlupC9XY2MPB8qY+Rn2o6l4
         G/3A==
X-Forwarded-Encrypted: i=1; AJvYcCVO0uHEYgKLF5k89L9i5WC5O6h1J6Va7SA0HbEBgiLgZkUSiLws+QS3/UvmkUJUEioLobABJVtXzZdpdpOYZWVUNiwvXzC/qoNBxMD7
X-Gm-Message-State: AOJu0YyG9bNrSWbXe+Fox/8AsN4kO9iLoimd4x0LlB33Zl5J2x6xT4XF
	wU+veuZRzLDVgcfu1Bf/kyNNjat7wHeXfELiQogeMuqqbDu0DbW+vU3AaQB+
X-Google-Smtp-Source: AGHT+IG59BWQ/oedgZTxz2VCoG+HjvX3ctlv+HY2oKfQVsj56oPniv1hwb6cN8gHAHFhxE1NthOfQw==
X-Received: by 2002:a5d:88c7:0:b0:7e2:1e0:3350 with SMTP id ca18e2360f4ac-7e201e033d5mr837924039f.12.1715881501632;
        Thu, 16 May 2024 10:45:01 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:45:01 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8-RESEND 20/33] dyndbg: treat comma as a token separator
Date: Thu, 16 May 2024 11:43:44 -0600
Message-ID: <20240516174357.26755-21-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516174357.26755-1-jim.cromie@gmail.com>
References: <20240516174357.26755-1-jim.cromie@gmail.com>
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
index 31fd67597928..c1bc728cb050 100644
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
2.45.0


