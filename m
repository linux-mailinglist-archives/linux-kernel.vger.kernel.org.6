Return-Path: <linux-kernel+bounces-570193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A43A6ADA8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687348A5F83
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834F1229B05;
	Thu, 20 Mar 2025 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhFbqORb"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2EB227E9B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496785; cv=none; b=CKNwnlvTMtfNNUgRx/7udNnCfdSgU7IA9lL7qWEDHk38bAbupV/9rl9yspA/JOesOwSrMn/KHLJ5pK3q8S4zPx+1h0Yy7s++Q/KXOYkaDs82+Lrc151/q5D9v3GWGAVHUbfoy83MtgZ2D2GJ5BSbN61JVpLc19hT9Wvro8rw2vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496785; c=relaxed/simple;
	bh=w+l1IxbKwn5+Odqn0uWbE42u8ngJlWpn+SjVKSxHY6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hI+OW3hTVhZY5YKpAvxAtJc6L2dJVpi9hH1t9xX+1rhf01xEoXZRtQTka21CP6F0zhRcU8/IO9vCaYKo44buN/GvAewtaZbw0HtN+PaNqv7JR4uYvikHkZ5/whbszaLxJmflhvLcdIeOV5jVunT750aEvk4dn8+YVJNfbm7vNlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhFbqORb; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-854a68f5a9cso86533039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496783; x=1743101583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8krvmT3hXiuiccuxDpOYGdDtTsrrIwxKLxWjX0uKEg=;
        b=GhFbqORb3MBAAeQU1WLWgkR1KCaegfnkXs7Xm5kT3vTml9kNrT+4bPql57g57+2v//
         H8jhtx86wJGFhd3ZjXls9wA/nvZNgzjfAL/ObmW0632hsd5bZUn96CEy8O83w6+AHFoC
         J86ut35K9mVAsHT1Ed2Cel3DdYsKxwHKgQethavlTtPTaVhehcrmUDAneQc/Pyou1dRL
         o1N3U3nG828gIzqCRRu8SH/6WLBB+nW7SWjaT4aVXkNwctD7sBdh0JtpNjyb8rHd/tgw
         EvaubCgMF8QTtLEd36uy7WZpumUeYrKjX/HgURWfGkFUel2o+3QU260LU1uVYj4LtEyl
         zLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496783; x=1743101583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8krvmT3hXiuiccuxDpOYGdDtTsrrIwxKLxWjX0uKEg=;
        b=kUbZMU0km2Tp864ovN8YHTFnVYvOKZ9gdrd20RO4VGNoOL8AacamfIkiYcjV16Ll4d
         FzIiEmpNDgmzSiaPljpTza+ngRulfiYbsSnIZvOqQlV5kSR0+zx9GTJqQHJEjOPcwo94
         /vuWT2mfABieMKFlP+hfiibPb/+Ns+ZPFkL89nV3t+AYws9yNng0lFJf1UIk9TB/tC4h
         TTh8EmbpOLS9zVjJggfoGX0jZzaOS48ss+6fIF5pWQsV4ItuOw/kSJrfYCXyvQxGbMOg
         LVtU83L27Y4U3iDUBeulY+ZQeY11+Tbcmvb6qaBIBHEXwVquR02wMkhcKH7fRpy5kLca
         IP8Q==
X-Gm-Message-State: AOJu0YzrpwChnVDrAfUL3lSuoWZO1RuIp6B5IHPMv9D3QEv/wz/U7ytr
	+WpvXMFVAAZHexkdxdJr5EUOlbOTtJDUiRLDwVw8UnUOtKIoS1xkdzdqEk9g
X-Gm-Gg: ASbGncvBhUbLBd9ZccB15IQYhRQrT5kKkRA7kJ/hCpbDHMmWAvjPbjH3KwIMmkqNuiG
	r5A3byzbF2tDLWV79sUQy7n8BZEnF5tvfwQJMnzWOoRLeEpN0A4XvwpgdZkywC7/PHgTsxKtKPK
	Ss+qn/pHPueDvayUYeJhSTyBqugi+56nPcP6EQMFwh0QAwpQnpSDB+mjPWKSTuQkMNGgIdaopgj
	S/IItZM493Xj/BgVzCsrdn+2hChckDqtKSX9KZGXL/860aj+kVjoAOROW2vQ/6OMq+wTiiR1GdP
	4xvzUfruLj0b4yR4PWPOUvnz1733qFr2bXtN3DDLjK7U/thJ/w3wc+PVE+FzkiXsYLwxCVNFkwS
	meA==
X-Google-Smtp-Source: AGHT+IGLFUNT7vu4Ze4s5l3PwVkHNFHoLLOgOZkw1v5IbQQj6bj520ZJNqB0G+YoLRgvlprY8LGZcA==
X-Received: by 2002:a05:6602:3785:b0:85b:427c:de6d with SMTP id ca18e2360f4ac-85e2ca2d11bmr47845339f.1.1742496783217;
        Thu, 20 Mar 2025 11:53:03 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:02 -0700 (PDT)
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
Subject: [PATCH v2 02/59] docs/dyndbg: update examples \012 to \n
Date: Thu, 20 Mar 2025 12:51:40 -0600
Message-ID: <20250320185238.447458-3-jim.cromie@gmail.com>
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

commit 47ea6f99d06e ("dyndbg: use ESCAPE_SPACE for cat control")
changed the control-file to display format strings with "\n" rather
than "\012".  Update the docs to match the new reality.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Tested-by: Louis Chauvet<louis.chauvet@bootlin.com>
---
-v2 fix missed \012's
---
 .../admin-guide/dynamic-debug-howto.rst       | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 7c036590cd07..4ac18c0a1d95 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -38,12 +38,12 @@ You can view the currently configured behaviour in the *prdbg* catalog::
 
   :#> head -n7 /proc/dynamic_debug/control
   # filename:lineno [module]function flags format
-  init/main.c:1179 [main]initcall_blacklist =_ "blacklisting initcall %s\012
-  init/main.c:1218 [main]initcall_blacklisted =_ "initcall %s blacklisted\012"
-  init/main.c:1424 [main]run_init_process =_ "  with arguments:\012"
-  init/main.c:1426 [main]run_init_process =_ "    %s\012"
-  init/main.c:1427 [main]run_init_process =_ "  with environment:\012"
-  init/main.c:1429 [main]run_init_process =_ "    %s\012"
+  init/main.c:1179 [main]initcall_blacklist =_ "blacklisting initcall %s\n"
+  init/main.c:1218 [main]initcall_blacklisted =_ "initcall %s blacklisted\n"
+  init/main.c:1424 [main]run_init_process =_ "  with arguments:\n"
+  init/main.c:1426 [main]run_init_process =_ "    %s\n"
+  init/main.c:1427 [main]run_init_process =_ "  with environment:\n"
+  init/main.c:1429 [main]run_init_process =_ "    %s\n"
 
 The 3rd space-delimited column shows the current flags, preceded by
 a ``=`` for easy use with grep/cut. ``=p`` shows enabled callsites.
@@ -59,10 +59,10 @@ query/commands to the control file.  Example::
 
   :#> ddcmd '-p; module main func run* +p'
   :#> grep =p /proc/dynamic_debug/control
-  init/main.c:1424 [main]run_init_process =p "  with arguments:\012"
-  init/main.c:1426 [main]run_init_process =p "    %s\012"
-  init/main.c:1427 [main]run_init_process =p "  with environment:\012"
-  init/main.c:1429 [main]run_init_process =p "    %s\012"
+  init/main.c:1424 [main]run_init_process =p "  with arguments:\n"
+  init/main.c:1426 [main]run_init_process =p "    %s\n"
+  init/main.c:1427 [main]run_init_process =p "  with environment:\n"
+  init/main.c:1429 [main]run_init_process =p "    %s\n"
 
 Error messages go to console/syslog::
 
-- 
2.49.0


