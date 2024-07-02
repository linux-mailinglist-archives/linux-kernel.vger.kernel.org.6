Return-Path: <linux-kernel+bounces-238433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A03924AFF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425A7286CCD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33BD17A5A7;
	Tue,  2 Jul 2024 21:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwIgh2Yy"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC243DAC12
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957512; cv=none; b=PQFRKyUWnzoFz1BAIguWup6k5hqQsMg10zjiv6AAlITS4UJMzdlT0g7Dj4p7WMty69pyokoptwMugDoV54LA7Pgun4CSR0bbyG0oprT5aOoZjRm38RYR+fGG15Z4aIE1ykdBIMpb68tYS3Hb/tL200izj0Enm7YcmkhsrhIO1s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957512; c=relaxed/simple;
	bh=iJRabDk4n3FOVpiDfU5H29ecoGu4HIZhqD6br1cK+Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzOYbhvWCSw9gtbgI9RwmuQf7EMly5NMpoRnnPKC1KD9O9d6erp7XP9v3JFBayAOe7NosHmdstq0cVpTvsmYYNrUuzQnIS9xWFzLz+wpXuvcGlMyL5dT+oANUh3VM0UX69prmd7DxljBqzNAoi985dsNzTTlq8KgEBF335FMG+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwIgh2Yy; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7f61549406eso180458239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957510; x=1720562310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PG0HixeKNGYC1yKqg8pO4K0aUEEvqiNOUzi5OjavD2Q=;
        b=gwIgh2YyMDZ4uovKxMK09D9HhYprvqN+6ToxttLkP4/rCOAZBo1v68G7Xu7LRkLcOq
         uujYwe/cEiUXKP4osSQgrwGlVuYQp94OsJ6XZF8IZwCBQ+gghiakmWQ/D31wg9HbPUdl
         /VUYCxQgqXcDEGyq8KIV8IcnsDXL+iGRzEViqyoFraqrdIRbOBjXWIdUI04KYYBeWJaE
         Q++WutMeMk7j+gS9Afi5CPQ6vYWls4QpqD+6bemVeX5FxtUzWGO9J2RA5bi4qn5yYO6a
         nLoR7WeW7UoNg8q/eoaDVesbtubR0tJK88oDuTkah3Rt6CGjLJNrwgm8F+jv46gGRNtR
         U7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957510; x=1720562310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PG0HixeKNGYC1yKqg8pO4K0aUEEvqiNOUzi5OjavD2Q=;
        b=KJydPkJRUvUCWibfN40VNDsbtXQt2prSyMgOOEJit3nIBjqJX+Pau5tvQDi9tq3T2r
         aGLvEmr8rXhklOEqRboM/SVxUhn1mZn8hl6D/JP3ytbItf5WLSORKyjvrVxAuyT9QZkH
         SJpxE26tfytBMbqgGgFjkH4mQZ7xJt7GnLgmTOb1I9fzrc8vKRchfcA7oJUY5KcSz2Ic
         GdUvHf+mcMFaMx9XGNbc0u8RdOHHlr2xOQmlZtMAqVa8ZETNh8xno2yq/W1T1fSzvGBu
         lIqyWA7FcabiTgHAjpl4QUm/EdkGS3+icJH3/EPQFkKlVd4ZRzx3De6X1c/2krOJsYmT
         U7bg==
X-Gm-Message-State: AOJu0YyNUY7cXiSMHvt3spMW+Ov6tL9/Kvl4o0/JJM4AWIqUmHGXatAJ
	bPPWQ1w16vQ4C+Cqh116vnjuh9AOYemVO9eloEqBZB1bHnT/ecAR
X-Google-Smtp-Source: AGHT+IHFxJvBXIHq5LZcv20uJ1NKUAM88ZngYdPTVnyFhFGhwG7OwIeFbtlBvY1gNg2J1W/h7jPgdQ==
X-Received: by 2002:a05:6602:2be1:b0:7f6:1b3a:437b with SMTP id ca18e2360f4ac-7f62ee79e9emr1172631339f.17.1719957509908;
        Tue, 02 Jul 2024 14:58:29 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:29 -0700 (PDT)
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
Subject: [PATCH v9 13/52] dyndbg: reduce verbose=3 messages in ddebug_add_module
Date: Tue,  2 Jul 2024 15:57:03 -0600
Message-ID: <20240702215804.2201271-14-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702215804.2201271-1-jim.cromie@gmail.com>
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When modprobing a module, dyndbg currently logs/says "add-module", and
then "skipping" if the module has no prdbgs.  Instead just check 1st
and return quietly.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d4a0ae31d059..43a8e04b8599 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1245,11 +1245,10 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
 
-	v3pr_info("add-module: %s.%d sites\n", modname, di->num_descs);
-	if (!di->num_descs) {
-		v3pr_info(" skip %s\n", modname);
+	if (!di->num_descs)
 		return 0;
-	}
+
+	v3pr_info("add-module: %s %d sites\n", modname, di->num_descs);
 
 	dt = kzalloc(sizeof(*dt), GFP_KERNEL);
 	if (dt == NULL) {
-- 
2.45.2


