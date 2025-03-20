Return-Path: <linux-kernel+bounces-570217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F02FFA6ADEF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219844A0F76
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104C322FF57;
	Thu, 20 Mar 2025 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqZgfCT6"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB86922F392
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496815; cv=none; b=GvWrfDfvZmRy7A29gvnIL3SKCvQUvyIwzGO8BYVnuuqtkEK6r3mRLZPcXlCtP+uOFEPqjBzMK9xREQN7ZOFBatwCQn+c0dmISd0QCQS3/yJ/qzBf5S6PnONDu074su0ICJ9K0Z96zwKbjsDtxRORr/nLOecgC/TzYuuuVxr8OHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496815; c=relaxed/simple;
	bh=h6fwIXL4bxkC92XTS9SsO+A29VD3Mfm0T8Nlpp1eLek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovRkamcWffYzAQoPN8wmJboLvF4NQj0O4nL5IwQfXxLy9wKEnG6HRrYF5WanDX5fxXbtSCAyq+sihM2EfPLKs5mEQiZ0bSo/2lOROfu/UqoAtx1Gzf4iBC6kjO/r2RmXM3OWSi4tLMRjohN7xUZK24bAwxhP4VA0q9G1GXKJY5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqZgfCT6; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85ae4dc67e5so58314939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496813; x=1743101613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xw8adb2Z5sY9CYdNStTgPHlquDwGHHXQsVDd6QeFLJc=;
        b=IqZgfCT6BJINNyccOAqAECHH/0I7zMFw7Dc88H21o8fYao/R4HgNXe/UrGdqjEB2xA
         gMBd2AyHjQ0lqVKrswttphqRrFVgXMgjBPlr5y9IcSXWQVdoAPCj+gOxJ5EyErwMNhlG
         BVfa9jDe+jM4TkZtYSc62XI9rKBld1r1RykwudGFnENlqJQnvixF6rjVzw9TkDS9Ij79
         Nki8cWvtUx8JxgbdNGHSR8mBViDaL8Kwh8hfMC1TE2fwN0/I+YadG6/rsELqcdGMSpJ9
         rMM2pVWSytYQOqZOf1dq/CYjnxMKnaN4qm5HJGTMBc2ActB9sleFSauZg/JZY7MiJ6Kh
         1udQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496813; x=1743101613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xw8adb2Z5sY9CYdNStTgPHlquDwGHHXQsVDd6QeFLJc=;
        b=fR3UYQ4wxBAl8QwNaQI4+neEWvAZYhj6sKDj4nA+Ob70YJe6liS52PErrMWMJEkyG4
         zNqcdceSMQv6cLRO0jfsdjkoIDF1Rqw65yKSJc1zFjwiFyQW77zmxF6xlNuvMdceB6NE
         PZQtLkZlGOg8fmVZX15mWt7eNvfU/cMM4h45SC2lVuilBKM+sdpDoSxL1ZirRGCF/AoV
         tLpLA/xK1AzKP/ZPp7l/FwsrUH2fAhBq1X3ePVS4GM/ZMeNknz2RFFuoOMITLzK2Tj5L
         yhsVJxMHTzm2F9h72kyHCZrACj/cuR+cxphuJJQ2C8iufILvnxmv/5U6jPV6mTbVqAn/
         i+dA==
X-Gm-Message-State: AOJu0YwLUmawsDXlYoVmsc2BnJovWxXN/bc4kcGitlvZ7Jw9c6ihThaF
	XzTjl2QnTqLLvYKLzHUcYYWQVcp1GfQlrNPrNjvAbIFFHvDPkNvHUmFz8oFt
X-Gm-Gg: ASbGncufwW81cxBSkfvfFPhulfQs5QwtJ/RbOrYz9Ew4QCX6YnnB/aYZ/Jr/+Yft9Ls
	K+XGH2Vk9tAXq6hAftZSpgeE2u/FTmPLqDVRsS/F0yn6K7gWOC/3OApKgf9338igY1moXAcZtZD
	a2t85+N8dwP4KavCl6ghB70Y6U1T4+Bu86TY0Aca1QhIxsksO4vC/Dq/Vbi4qSjw71NtrjdT6j6
	1INwGPzLuGQsWDMrdo32ArsYYgBWuHWKwyCAbEJ2SktsaENvl40LNq2T5g4XUwWrs0WUzlSWf5Q
	qLBSrHQn77RY8Z+Yl3mpxAPQVAv4QKDxN+hbMNo0D1bZn5ve3TT7XlEJPfAfZZLKrQnbLGsQ+vQ
	UEw==
X-Google-Smtp-Source: AGHT+IEM+TCm6SAKhxXC9orQJ/SOjoMht1drU2xoXtyO6z7G8nlW6dhEGvYl4P5S+BLPG1cYCvgpwA==
X-Received: by 2002:a05:6602:358f:b0:85b:52d7:17da with SMTP id ca18e2360f4ac-85e2ca756admr60410739f.6.1742496812752;
        Thu, 20 Mar 2025 11:53:32 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:31 -0700 (PDT)
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
Subject: [PATCH v2 26/59] dyndbg: split multi-query strings with %
Date: Thu, 20 Mar 2025 12:52:04 -0600
Message-ID: <20250320185238.447458-27-jim.cromie@gmail.com>
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

Since commit
85f7f6c0edb8 ("dynamic_debug: process multiple debug-queries on a line")

Multi-query commands have been allowed:

  modprobe drm dyndbg="class DRM_UT_CORE +p; class DRM_UT_KMS +p"
  modprobe drm dyndbg=<<EOX
     class DRM_UT_CORE +p
     class DRM_UT_KMS +p
  EOX

More recently, the need for quoting was avoided by treating a comma
like a space/token-terminator:

  modprobe drm dyndbg=class,DRM_UT_CORE,+p\;class,DRM_UT_KMS,+p

That works, but it needs the escaped semicolon, which is a shell
special-char (one of the bash control operators), so it is brittle
when passed in/down/around scripts.  In particular, it fails when
passed to vng (virtme-ng).

So this patch adds '%' to the existing ';' and '\n' multi-command
separators, which is more shell-friendly, so you can more fully avoid
quoting and escaping hassles.

NOTE: it does break format matching on '%' patterns:

bash-5.2# ddcmd 'format "find-me: %foo" +p'
[  203.900581] dyndbg: read 26 bytes from userspace
[  203.900883] dyndbg: query 0: "format "find-me: " mod:*
[  203.901118] dyndbg: unclosed quote: find-me:
[  203.901355] dyndbg: tokenize failed
[  203.901529] dyndbg: query 1: "foo" +p" mod:*
[  203.901957] dyndbg: split into words: "foo"" "+p"
[  203.902243] dyndbg: op='+' flags=0x1 maskp=0xffffffff
[  203.902458] dyndbg: expecting pairs of match-spec <value>
[  203.902703] dyndbg: query parse failed
[  203.902871] dyndbg: processed 2 queries, with 0 matches, 2 errs
bash: echo: write error: Invalid argument

The '%' splits the input into 2 queries, and both fail.  Given the
limited utility of matching against the working parts of a format
string "foo: %d bar %s", nothing is actually lost here.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 168663629ef2..c44502787c2b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -599,7 +599,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 	int i, errs = 0, exitcode = 0, rc, nfound = 0;
 
 	for (i = 0; query; query = split) {
-		split = strpbrk(query, ";\n");
+		split = strpbrk(query, "%;\n");
 		if (split)
 			*split++ = '\0';
 
-- 
2.49.0


