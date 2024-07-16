Return-Path: <linux-kernel+bounces-254255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E105E9330D1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3761F24331
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE861A01CD;
	Tue, 16 Jul 2024 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ji2sORLM"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916E119A86F;
	Tue, 16 Jul 2024 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156303; cv=none; b=R0J7AuMkuPjIYj+sG2kmyOJMI0V44VRP7UqHsRspFy5hd+6yUE+B5HiZqvgZQNQaQf/JDqJ72JzfjuLRqqDJWrqbNmSElvfZkCtiFjWA5TOSoXA055FBeq7TdIqXyLFkfRYEBhPreXnknSkghP5kUkQMSlgGXE9DMIqJqqqeBTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156303; c=relaxed/simple;
	bh=wKsffOuXjQz6csIEgiqYbyUo9lvjHQdEP0b/s+bAJ7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rs0fGiKJz4/F88bcIKu4/ztym8ye1cE0KN1Ub2FRAwU6SRFFz+N5goRSjj7drCmb8DIkLxpev9hPPwfu61jDQXzAWCWIrH2ach5Ka9Wd+KJVOcbHTg+WT2J8qvWEFBzIdWqxGIx+EI4UutP9QPVmSIAbtkUDEW+GFaueWNjUpHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ji2sORLM; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8046f65536dso6038739f.1;
        Tue, 16 Jul 2024 11:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156300; x=1721761100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5R1ZNEsygnLGTQO2NIWkjU0SF7pc6VSZuM8NRzidmQA=;
        b=ji2sORLMXfvOdCkS+9O1i31N5FCRzZNXGZyTA/PSBT+oBzdsGb1JlgkPUnKF1E7igf
         ifsB+xjdSoqTsEZ1jP1b3Jg2big90Q4jnjOdO2DUd96P2MJgZJxENLh+DejUwrjObNz0
         u1ZbKtVGA/24Jhld/ywaT9SAfhRcrn5BLPlfTbGbFBET7nxinWo1X/m+AXYsxZqUN1VF
         ThjH0GUrVBsUqLzaCrCHkLSvIS89BpYi6m3C2yw3OD/JSVOYsANlqj1N2tTIcdZNZl2z
         3VkbAPYbOF7lKam4LlCotDiQQiAMXx0ShpZesHWxY3mstNR0tL/ZGtHF+HN5yoR3LEJW
         PgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156300; x=1721761100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5R1ZNEsygnLGTQO2NIWkjU0SF7pc6VSZuM8NRzidmQA=;
        b=GSPSfEBxPV4S7OI+AW+YAAX1xvRLb1z7/i6iHkXiQgmmIrg8FK+sijmpKKE6Y4vYgd
         2S5AfbxEP/7oZGM3AW0prFV/1+blvWYS4yDVLfcaXwxusxoTmf8tuijtFvklY6m6a6gD
         RO0t1xM18YS+JO0KKkd4Uz9AtWu4E0y224r9uQ6Vfz9YsMPF+awYXCgJzximovcR8Kek
         MSPJXDEkvrTVK3VooBCAmurgF3oSjrLKQ00HoogdbkYIGtkSLj55K7LDidwpSoI+/7EM
         ZJD+5GKJwOvAqb4GVKjz1u8nQea4KvrR3LUfvJdmVTepqL/yUwewor4Fp7Z8sO2V9SKT
         nGLw==
X-Forwarded-Encrypted: i=1; AJvYcCWeB2HgYdIeJNySEgKBLeKioJwio+QPlCKAUuSVxkcvLP4OWMOYbsBKAZl7zrfpM7WvZEdd7vfPvnSFcfTloLHykM8ONbRtIoPV
X-Gm-Message-State: AOJu0YzZ284oKWawULX/01/rkV9FL2GPUfQFcoa//uUmrdz3AiHLVKLp
	rmVN3hJncyE6SKDBoDGn5B/fUfMP8/tvsaK6Nxw1sYwbP/U9zAPlkYnUVldh
X-Google-Smtp-Source: AGHT+IG/GWDlKRu5+OOMDNAMNMhtDFiwfQtpn8aBJzDUfIXJDuLqEafEhFwZW4oo9t/YHsJs9EPD5Q==
X-Received: by 2002:a05:6602:1502:b0:803:980e:5b38 with SMTP id ca18e2360f4ac-816c2d03801mr41542239f.1.1721156300341;
        Tue, 16 Jul 2024 11:58:20 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:19 -0700 (PDT)
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
Subject: [PATCH v9-resend 01/54] docs/dyndbg: update examples \012 to \n
Date: Tue, 16 Jul 2024 12:57:13 -0600
Message-ID: <20240716185806.1572048-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716185806.1572048-1-jim.cromie@gmail.com>
References: <20240716185806.1572048-1-jim.cromie@gmail.com>
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
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 0e9b48daf690..6a8ce5a34382 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -52,12 +52,12 @@ query/commands to the control file.  Example::
   # grease the interface
   :#> alias ddcmd='echo $* > /proc/dynamic_debug/control'
 
-  :#> ddcmd '-p; module main func run* +p'
+  :#> ddcmd '-p; module main func run* +p'	# disable all, then enable main
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
2.45.2


