Return-Path: <linux-kernel+bounces-254273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E720933157
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDFA81F23ECD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B6B1A4F38;
	Tue, 16 Jul 2024 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFV/27yf"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DF81A4F09;
	Tue, 16 Jul 2024 18:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156332; cv=none; b=bjfZswOfEObSz3zrBvh5E6tOLIsaEpKhfwhypLzEh5cje8fzUPAeFi/qfzgX3NebeA0IX6B5LASGtIMZv6+S7jV+aaZMKi1sOlqM76lRnDBeKazyTW0v+1lVyKGyp/wVpv2qHNuDsvG3jztUjPHDCReVzXaSNXeV1C3GYBufPDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156332; c=relaxed/simple;
	bh=icwqeywsyrttsSDlGtVX51FXgI87DPMODzf+SUKMTJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a4ipBFLnNS7LmkHtyuHNmo6GVKBCYUm7s/XpRWySUkpUIS9KU1JYr0Vn0d2oX2Pg4G7QtrMg6YoIiAcCIQU41b4E2BmWEB7Jgm1JrmNHolK/MPnBpyDD8p+8TTmZPcfipqvKwUIAY6dYZi/IoWII5g2pgUkwog/MEg+iKNgJzds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFV/27yf; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-80557928673so6037939f.2;
        Tue, 16 Jul 2024 11:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156329; x=1721761129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xowWZ+ekpberKm26oOQ15iL0A2hZa3GfKHRI1+lg3PY=;
        b=nFV/27yfeH0gZXzkPd6YsHjAk1vXCb2xzQjzTRdPfozLdHZWeHh3oAG5iy+WexSY4+
         MhncCPZzNGUy1+OQtnOq8sytubf7rrsdE/c64FD2I7sg7KqpylCL9fwWR8qe1z/WLED+
         Dl1uA73DqVTO/6aYwNwqlD9pkF//LfiEgj89nwAeDI2ALDIB1OqXR4E/Q45WNb7LuUVa
         l+lU4KcvAWZr/zESDpgh/i/TYIR9OplQXOEf017E3m6NEEWESDsY5C1+C/pTXhrJ407+
         cWV6d7mU5p2hJKyBqm66JDhAVDyLc5OhEDJh9+g72H0sDYDniNl5Ug3HkiNg5gisIIHC
         5rUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156329; x=1721761129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xowWZ+ekpberKm26oOQ15iL0A2hZa3GfKHRI1+lg3PY=;
        b=ARGf7KXN8glJknzzZc2MpPs0fuFx5nfnUzyCK6nvFg3ECp1heppCZF9QjEwkMdFBRB
         1GVJSK+vCAtaaY+8n/I9nRPZM9C0qoGLhwVHSP+xUzZLQyPX2mSXtTSm9BMA9ki8Ff5Z
         oSA1zKbA1PaQgxUm7cCao3ez6zXshMRDsFCkaYgMbSSZGDF2FuugqBmqw/JRJXiN3zqp
         f9mfmtSeCIeLK3l1rE+KNEJu6/bYXgJloVzdcoCZFMNFC3FEV0Qsu06TvS4afqkX2fO1
         dxV+n53I3/Th00UJywS/Tr2Hg6m9wNQGfgQcY+6N1uMSByh+muuh3P5gqngN7NH2D1wo
         PnIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4rq4kXaFVVk9T/nqFznSB+l0h35j4fFhYlgJs+7cpow8IrRwF4MiKoNWiY06AL8FKmdE+QthzsMzNGVH+Bj6PbBx2iR7ZJIBm
X-Gm-Message-State: AOJu0YwjzdjxKMprkuOdIsT/YzlKCvEpS5VPltVX0NUkmwp4LQhySiff
	gQjraCH6lvgH0MeFBqUeUhO68v828DZ6h+wkPZKXOfSQz0J1efAhh2JVQE5l
X-Google-Smtp-Source: AGHT+IFbKxBJYJFRLsqlIc8X6rZ3ddxjJaHcru4WtjoSkVJW1iE/Ay/MRGOURVvx09A7Mej6GaYQYg==
X-Received: by 2002:a05:6602:1513:b0:805:afed:ce90 with SMTP id ca18e2360f4ac-816c578dc7bmr35156939f.16.1721156329549;
        Tue, 16 Jul 2024 11:58:49 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:49 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	kernelnewbies@kernelnewbies.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9-resend 19/54] dyndbg: treat comma as a token separator
Date: Tue, 16 Jul 2024 12:57:31 -0600
Message-ID: <20240716185806.1572048-20-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716185806.1572048-1-jim.cromie@gmail.com>
References: <20240716185806.1572048-1-jim.cromie@gmail.com>
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


