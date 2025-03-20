Return-Path: <linux-kernel+bounces-570215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74605A6ADE1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA94C7B2FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEAC22F38C;
	Thu, 20 Mar 2025 18:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiHzNIuV"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4E322E3FA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496812; cv=none; b=SjkVnvsGT7sfJIshsFakYyDnD8v3Wv9JpK9TvyH0kQwS7uqEBBh1eUX8YYLTX3jUghP2KASyJnCt+RDzB8Rwf05xlfFicDFUU6kPo0Zc7yJrvKsa5Mo8AhUn/IpdJNwWFD74xxnfvjSVE+Jb3YDk1xTGSzhf4TNLWAcvrPrdeNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496812; c=relaxed/simple;
	bh=68+bijATnJ7OwTlKcj2iAsplqdJ6fBbn+ICp/sHJKAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWY3hvI9DAT6y0WaFkiIEHZQRh9CaT0m5+AAF2sTpEm0wNvjaq/TN6KhdWEabTqdIGis57/PUzrHAIbjx8Nnb1wwuVjBryYtc2k9AxV+ntwOHmNQxltBxlcTaJGM0bC37ucyn0h2+ZdMgevUP+bKCXeItaMDS2ODINe9Mf9rCbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiHzNIuV; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85afd2b9106so111047139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496810; x=1743101610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/TmguIcilYWi0b4T/ZXyXvq5cs5z5jPAwptJanq78o=;
        b=UiHzNIuViAK23tL/CPa5RP3FjhhN91F67uogvjsnJw3wRDLL00TOGYN9dWtnLVeTJ/
         M4nXKfqaQIRpPqv2s4M4SeBHQtVNO9hHEwdGOC7Y6tWbG9LzG4UsdBrHt+iHGuss5ylt
         scagD26ILd3v0jSku/oCSkxluP0pHhiH1ZIebyJdLlR0UTsHHA2GNddIVhroaslwL01u
         45ah/77JLFmXqMIeiqLNzkwv529/MLSMPrXPTyI85Npzp26I6NG3o9iMPOV0AUdLYCya
         3DGKH3kaPeAMHq03KeiQfZqcvjDWfvZHtxN5Os5JcAj5aRS4wYPdrshm8ylWbHONdx2/
         oX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496810; x=1743101610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/TmguIcilYWi0b4T/ZXyXvq5cs5z5jPAwptJanq78o=;
        b=t9FQYCLF2MRZs/p5bLmqY2O/n5yFcbCH3v3mdjKNERVbHe7GViSpVZBEuB/wWZwlPA
         5El/BOybIVfEXcG3kxW/hNKzqZsSLSNtaQoKNCqCxw6wUOxJiTYFAtrhj2hvtMn2gwh/
         VyzwMZCu6jFzF8EJkbEsFgfvNBft08KpWCKFwZqyycPsKA1PGxfh83CkiMmNMdjk0uWX
         ZBIHWiyAZWCClri9JZ6QfsrV27ipwMlJF907tMiS4zfHoZHFQHNLwa7GOlHawjOmqD0R
         pBMYE5jiWX3L2AeoOKzia7f2GMVt3JAYz3nfbtSMEQH8qC1ZrhrrxtFdknl+SxWYZe5G
         zAFw==
X-Gm-Message-State: AOJu0Yz4dyvm076NcS/iNn6mbjw68sYPIE/zF1ylMaEwxYCAAyV63VyT
	mBfyFbN59tM+pSixwyZPyUUyA/JAl0DbTZEagX5JX7woV3BEQ6HOZRp3bUEZ
X-Gm-Gg: ASbGncv9k7RYb+yIVK3u0Ln5nLAD+Hx3s9VZIHMd8hmP5NL39bygq6f2Y8DEWrIDfEn
	6Pu5xGitBXdpB1U2nAqigs69soqvJfKRb0ctyh1eqHAvF+VVS0FrAayF+7+9A4+0ov6zBeyyTSR
	vIwIcCK1Om8ktSYHir1zxgSpQTsJjzpMiztiA5swVQ9STbXxuy+CISQ+E7pm5s6SJVkPFWxjYIB
	r56GU3cXFTT9BB1K5/RSTrydpFTyD7Ju4aBoLAnBbivGApcgffsVmwEvAZQMM/yJS8bwX5NdS9S
	7p/+NLkRqeNI2Bv7qSIt03rN5EU0rvZdrrCBktNRGWnYRg41ujYYICrwSUd18udkEe7NGQAmLif
	6Ig==
X-Google-Smtp-Source: AGHT+IFyIwb+RWjlXVmPJReqZ7Gaf5mcrnSGy/txhhCgyUW+11xOhYLGUO72gS3V0AUotv0u6Xegpw==
X-Received: by 2002:a05:6602:4013:b0:85d:115b:bb3f with SMTP id ca18e2360f4ac-85e2ca64287mr43643139f.6.1742496810314;
        Thu, 20 Mar 2025 11:53:30 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:29 -0700 (PDT)
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
Subject: [PATCH v2 24/59] dyndbg: treat comma as a token separator
Date: Thu, 20 Mar 2025 12:52:02 -0600
Message-ID: <20250320185238.447458-25-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320185238.447458-1-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
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
index cd3eec5bb81c..168663629ef2 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -293,6 +293,14 @@ static int ddebug_change(const struct ddebug_query *query, struct flag_settings
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
@@ -306,8 +314,8 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 	while (*buf) {
 		char *end;
 
-		/* Skip leading whitespace */
-		buf = skip_spaces(buf);
+		/* Skip leading whitespace and comma */
+		buf = skip_spaces_and_commas(buf);
 		if (!*buf)
 			break;	/* oh, it was trailing whitespace */
 		if (*buf == '#')
@@ -323,7 +331,7 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 				return -EINVAL;	/* unclosed quote */
 			}
 		} else {
-			for (end = buf; *end && !isspace(*end); end++)
+			for (end = buf; *end && !isspace(*end) && *end != ','; end++)
 				;
 			if (end == buf) {
 				pr_err("parse err after word:%d=%s\n", nwords,
@@ -595,7 +603,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (split)
 			*split++ = '\0';
 
-		query = skip_spaces(query);
+		query = skip_spaces_and_commas(query);
+
 		if (!query || !*query || *query == '#')
 			continue;
 
-- 
2.49.0


